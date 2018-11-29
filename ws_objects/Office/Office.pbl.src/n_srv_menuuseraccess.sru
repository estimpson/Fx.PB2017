$PBExportHeader$n_srv_menuuseraccess.sru
forward
global type n_srv_menuuseraccess from n_base
end type
end forward

global type n_srv_menuuseraccess from n_base autoinstantiate
end type

type variables

//	Hold menu data in memory to persist changes to access.
private str_menuuseraccess MenuData[]
private string User

end variables

forward prototypes
public function long getmenuparent (string _mcode, long _curreniindex)
public function integer buildusermenu (string _application, string _user, ref u_tv _menutv, boolean _admin)
public function integer saveuseraccess (ref u_tv _menutv)
public function integer getmenuitem (string menuid, ref str_menuuseraccess menuitem)
public function integer saveuseraccess2 (ref u_tv _menutv)
public function integer addusermenuitem (string usercode, string menuitemname)
public function integer removeusermenuitem (string usercode, string menuitemname)
end prototypes

public function long getmenuparent (string _mcode, long _curreniindex);
//	Loop through items above the current index and return handle if parent found.
long	i
for	i = 1 to _currenIindex - 1
	if	MenuData[i].chain = left (_MCode, len(_MCode) - 2) then
		return	MenuData[i].treeviewhandle
	end if
next

//	Default root for parent not found.
return	0

end function

public function integer buildusermenu (string _application, string _user, ref u_tv _menutv, boolean _admin);
if	not IsNull(_user, "") > "" then
	return FAILURE
end if
User = _user

//	Reset the menu.
do while _menuTV.FindItem(RootTreeItem!, 0) > 0
	_menuTV.DeleteItem(_menuTV.FindItem(RootTreeItem!, 0))
loop

//	Retrieve menu data cache.
n_ds menuUserAccess
menuUserAccess = create n_ds
menuUserAccess.DataObject = "d_menuuseraccess"
menuUserAccess.of_SetTransObject (SQLCA)
long	menuUserAccessRecords
SQLCA.AutoCommit = true
menuUserAccessRecords = menuUserAccess.Retrieve(_application, User)
SQLCA.AutoCommit = false
if	_admin then
	menuUserAccess.SetFilter("")
	menuUserAccess.Filter()
	menuUserAccess.Sort()
	menuUserAccessRecords = menuUserAccess.RowCount()
end if
if	menuUserAccessRecords > 0 then
	MenuData = menuUserAccess.object.Data.primary
	destroy	menuUserAccess
else
	//	There is no menu data.
	destroy	menuUserAccess
	return	NO_ACTION
end if

//	Build menu.
long menuItemCount = 1
long menuUserAccessIndex = 1
long userAccessIndex = 1

treeviewitem menuItem
string objectClass
for	menuUserAccessIndex = 1 to menuUserAccessRecords
	
	//	Separate argument from object name.
	if	Pos(MenuData[menuUserAccessIndex].objectClass, "|") > 0 then
		objectClass = Left(MenuData[menuUserAccessIndex].objectClass, Pos(MenuData[menuUserAccessIndex].objectClass, "|") - 1)
	else
		objectClass = MenuData[menuUserAccessIndex].objectClass
	end if

	//	Validte menu item.
	boolean valid
	valid = true
	string validationError
	validationError = ""
	
	ClassDefinition menuItemClassDefinition
	menuItemClassDefinition = FindClassDefinition(objectClass)

	if	not IsValid (menuItemClassDefinition) or IsNull (menuItemClassDefinition) then
		//	Definition was not found and the item will not be added to the menu.
		valid = false
		validationError = "definition not found"
	else
		ClassDefinition parentDef
		choose case menuItemClassDefinition.DataTypeOf
			case "window"
				choose case lower(MenuData[menuUserAccessIndex].ObjectType)
					case "pb10.sheet"
						//	Ensure specified class is derived from a w_sheet_4t window.
						boolean wSheetFT
						wSheetFT = false
						parentDef = menuItemClassDefinition
						do while IsValid(parentDef) and not wSheetFT
							if	parentDef.Name = "w_sheet_4t" then
								wSheetFT = true
								continue
							end if
							parentDef = parentDef.Ancestor
						loop
						if	not wSheetFT then
							valid = false
							validationError = "not a w_sheet_4t"
						end if
					case "pb10.fxsheetview"
						//	Ensure specified class is derived from a w_fxsheetview window.
						boolean wFXSheetView
						wFXSheetView = false
						parentDef = menuItemClassDefinition
						do while IsValid(parentDef) and not wFXSheetView
							if	parentDef.Name = "w_fxsheetview" then
								wFXSheetView = true
								continue
							end if
							parentDef = parentDef.Ancestor
						loop
						if	not wFXSheetView then
							valid = false
							validationError = "not a w_fxsheetview"
						end if
					case "pb10.popup"
						//	Popups are fine if they are any type of window.
					case "rf.app", "rf.tabpage"
				end choose
			case else
				//	Not a window and the item will not be added to the menu.
				valid = false
				validationError = "not a window"
		end choose
	end if
	
	if	_admin or valid then
		menuItemCount++
		if	MenuData[menuUserAccessIndex].userAccess = 1 then
			menuItem.StatePictureIndex = 2
		else
			menuItem.StatePictureIndex = 1
		end if
		menuItem.Label = MenuData[menuUserAccessIndex].menuText
		menuItem.Data = MenuData[menuUserAccessIndex]
		if	lower(MenuData[menuUserAccessIndex].ObjectType) <> "rf.app" and lower(MenuData[menuUserAccessIndex].ObjectType) <> "rf.tabpage" then
			menuItem.PictureIndex = _menuTV.GetPictureIndex(MenuData[menuUserAccessIndex].menuIcon)
		else
			menuItem.PictureIndex = _menuTV.GetPictureIndex("rf.ico")
		end if
		menuItem.SelectedPictureIndex = menuItem.PictureIndex
		if	not valid and lower(MenuData[menuUserAccessIndex].ObjectType) <> "rf.app" and lower(MenuData[menuUserAccessIndex].ObjectType) <> "rf.tabpage" then
			int	warningIndex
			warningIndex =_menuTV.GetPictureIndex("Warning!")
			_menuTV.SetOverlayPicture(1, warningIndex)
			menuItem.OverlayPictureIndex = 1
			menuItem.Label += "[" + validationError + "]"
		else
			menuItem.OverlayPictureIndex = 0
		end if
		menuItem.Expanded = true
		MenuData[menuUserAccessIndex].treeViewHandle = _menuTV.InsertItemLast (getMenuParent(MenuData[menuUserAccessIndex].chain, menuUserAccessIndex), menuItem)
	end if
next

//	Return
_menuTV.Enabled = true
_menuTV.SelectItem(1)
return	menuItemCount

end function

public function integer saveuseraccess (ref u_tv _menutv);
//	Delete current access data for this user.
delete
	FT.SecurityAccess
where
	SecurityID =
	(	select
			u.UserID
		from
			FT.Users u
		where
			u.OperatorCode = :User
	)
	and ResourceID in
	(	select
			MenuID
		from
			FT.MenuItems
	)  ;

//
integer	i
treeviewitem	childItem
for	i = 1 to UpperBound(MenuData)
	if	_menuTV.GetItem(MenuData[i].TreeViewHandle, childItem) = 1 then
		if	childItem.StatePictureIndex = 2 then
			insert
				FT.SecurityAccess
			(	SecurityID
			,	ResourceID
			)
			select
				u.UserID
			,	mi.MenuID
			from
				FT.Users u
				cross join FT.MenuItems mi
			where
				u.OperatorCode = :User
				and
					mi.MenuItemName = :MenuData[i].MenuItemName  ;
		end if
	end if
next
commit  ;

//	Return.
return SUCCESS
end function

public function integer getmenuitem (string menuid, ref str_menuuseraccess menuitem);
select top 1
	mua.ApplicationName
,	mua.MenuItemName
,	mua.MenuIcon
,	mua.MenuText
,	mua.ObjectClass
,	mua.ObjectType
,	mua.Level
,	mua.Sequence
,	mua.Chain
,	mua.UserAccess
into
	:menuItem.ApplicationName
,	:menuItem.MenuItemName
,	:menuItem.MenuIcon
,	:menuItem.MenuText
,	:menuItem.ObjectClass
,	:menuItem.ObjectType
,	:menuItem.MenuLevel
,	:menuItem.MenuSequence
,	:menuItem.Chain
,	:menuItem.UserAccess
from
	FT.MenuUserAccess mua
where
	mua.MenuID = :menuID using SQLCA  ;

return SUCCESS

end function

public function integer saveuseraccess2 (ref u_tv _menutv);
integer i
treeviewitem childItem
boolean autoCommit

autoCommit = SQLCA.AutoCommit;
SQLCA.AutoCommit = true
for	i = 1 to UpperBound(MenuData)
	if	_menuTV.GetItem(MenuData[i].TreeViewHandle, childItem) = 1 then
		if	childItem.StatePictureIndex = 2 then
			AddUserMenuItem(User, MenuData[i].MenuItemName)
		else
			RemoveUserMenuItem(User, MenuData[i].MenuItemName)
		end if
	end if
next
commit  ;
SQLCA.AutoCommit = autoCommit

//	Return.
return SUCCESS
end function

public function integer addusermenuitem (string usercode, string menuitemname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add user menu item.
declare AddUserMenuItem procedure for dbo.usp_Admin_AddUserMenuItem
	@User = :userCode
,	@MenuItemName = :menuItemName
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute AddUserMenuItem  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MsgBox("Failed on execute, unable to add user menu item:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AddUserMenuItem
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MsgBox("Failed on result, unable to add user menu item:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AddUserMenuItem   ;

//	Return.
return SUCCESS

end function

public function integer removeusermenuitem (string usercode, string menuitemname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to remove user menu item.
declare RemoveUserMenuItem procedure for dbo.usp_Admin_RemoveUserMenuItem
	@User = :userCode
,	@MenuItemName = :menuItemName
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute RemoveUserMenuItem  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MsgBox("Failed on execute, unable to remove user menu item:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RemoveUserMenuItem
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MsgBox("Failed on result, unable to remove user menu item:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RemoveUserMenuItem   ;

//	Return.
return SUCCESS

end function

on n_srv_menuuseraccess.create
call super::create
end on

on n_srv_menuuseraccess.destroy
call super::destroy
end on

