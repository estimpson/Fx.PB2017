$PBExportHeader$n_srv_useraccess.sru
forward
global type n_srv_useraccess from n_base
end type
type menudata from structure within n_srv_useraccess
end type
type useraccessdata from structure within n_srv_useraccess
end type
end forward

type menudata from structure
	string		pmcode
	string		mcode
	string		mname
	string		switch
	string		display
	string		menuname
	string		menuicon
	string		objectname
	string		objecttype
	long		treeviewhandle
end type

type useraccessdata from structure
	string		mcode
	string		ucode
	string		gcode
	string		scode
	string		escode
	string		accesstype
end type

global type n_srv_useraccess from n_base autoinstantiate
end type

type variables

//	Hold menu data in memory to persist changes to access.
private str_menucache MenuData[]
private userAccessData UserAccessData[]
private n_ds userAccessCache
private string User

end variables

forward prototypes
public function integer buildusermenu (string _user, ref u_tv _menutv, boolean _admin)
public function integer buildusermenu (string _user, ref u_tv _menutv)
public function long getmenuparent (string _mcode, long _curreniindex)
public function integer saveuseraccess (ref u_tv _menutv)
public function integer readchildaccess (ref u_tv _menutv, integer _currentitemhandle)
end prototypes

public function integer buildusermenu (string _user, ref u_tv _menutv, boolean _admin);
//	Retrieve menu data cache.
n_ds MenuDataCache
MenuDataCache = create n_ds
MenuDataCache.DataObject = "d_MenuDataCache"
MenuDataCache.of_SetTransObject (SQLCA)
long	MenuDataCacheRecords
MenuDataCacheRecords = MenuDataCache.Retrieve()
if	MenuDataCacheRecords > 0 then
	MenuData = MenuDataCache.object.Data.primary
	destroy	MenuDataCache
else
	//	There is no menu data.
	destroy	MenuDataCache
	return	NO_ACTION
end if

//	Retrieve user access cache.
User = _user
userAccessCache.DataObject = "d_UserAccessCache"
userAccessCache.of_SetTransObject(SQLCA)
long	userAccessRecords
userAccessRecords = userAccessCache.Retrieve(User)
if	userAccessRecords = 0 and _admin then
	userAccessCache.InsertRow(0)
	userAccessRecords++
end if
if	userAccessRecords > 0 then
	UserAccessData = userAccessCache.object.Data.primary
else
	//	User has no access.
	return	NO_ACTION
end if

//	Build menu.
n_srv_encryption encryption
long menuItemCount = 1
long MenuDataCacheIndex = 1
long userAccessIndex = 1
string	access ; access = encryption.Decrypt(UserAccessData[userAccessIndex].escode, User)
treeviewitem rootItem, menuItem
rootItem.StatePictureIndex = 2
rootItem.Label = MenuData[MenuDataCacheIndex].menuName
rootItem.Data = MenuData[MenuDataCacheIndex]
rootItem.PictureIndex = _menuTV.GetPictureIndex(MenuData[MenuDataCacheIndex].menuIcon)
rootItem.SelectedPictureIndex = rootItem.PictureIndex
rootItem.Expanded = true
MenuData[MenuDataCacheIndex].treeViewHandle = _menuTV.InsertItemLast (0, rootItem)
string objectName

for	MenuDataCacheIndex = 2 to MenuDataCacheRecords
	
	//	Check user access.
	do while MenuData[MenuDataCacheIndex].pmcode > UserAccessData[userAccessIndex].mcode and userAccessIndex < userAccessRecords
		userAccessIndex++
	
		//	Decrypt access.	
		access = encryption.Decrypt(UserAccessData[userAccessIndex].escode, User)
	loop
	if	MenuData[MenuDataCacheIndex].pmcode <> UserAccessData[userAccessIndex].mcode and not _admin then
		//	Access record not found.
		continue
	end if
	//	Separate argument from object name.
	if	Pos(MenuData[MenuDataCacheIndex].objectName, "|") > 0 then
		objectName = Left(MenuData[MenuDataCacheIndex].objectName, Pos(MenuData[MenuDataCacheIndex].objectName, "|") - 1)
	else
		objectName = MenuData[MenuDataCacheIndex].objectName
	end if
	if	IsValid(FindClassDefinition(objectName)) then
		//	Check access.
		if	MidA(access, long (right (MenuData[MenuDataCacheIndex].mcode, 2)), 1) = "1" or _admin then
			menuItemCount++
			if	_admin then
				if	MidA(access, long (right (MenuData[MenuDataCacheIndex].mcode, 2)), 1) = "1" then
					menuItem.StatePictureIndex = 2
				else
					menuItem.StatePictureIndex = 1
				end if
			end if
			menuItem.Label = MenuData[MenuDataCacheIndex].menuName
			menuItem.Data = MenuData[MenuDataCacheIndex]
			menuItem.PictureIndex = _menuTV.GetPictureIndex(MenuData[MenuDataCacheIndex].menuIcon)
			menuItem.SelectedPictureIndex = menuItem.PictureIndex
			menuItem.Expanded = true
			MenuData[MenuDataCacheIndex].treeViewHandle = _menuTV.InsertItemLast (getMenuParent(MenuData[MenuDataCacheIndex].mcode, MenuDataCacheIndex), menuItem)
		end if
	end if
next

//	Return
_menuTV.SelectItem(1)
return	menuItemCount

end function

public function integer buildusermenu (string _user, ref u_tv _menutv);
//	Not building admin menu.
return BuildUserMenu(_user, _menutv, false)

end function

public function long getmenuparent (string _mcode, long _curreniindex);
//	Loop through items above the current index and return handle if parent found.
long	i
for	i = 1 to _currenIindex - 1
	if	MenuData[i].mcode = left (_MCode, len(_MCode) - 2) then
		return	MenuData[i].treeviewhandle
	end if
next

//	Default root for parent not found.
return	0

end function

public function integer saveuseraccess (ref u_tv _menutv);
//	Read menu.
treeviewItem rootItem
integer	rootItemHandle
rootItemHandle = _menuTV.FindItem(RootTreeItem!, 0)
if	rootItemHandle > 0 then
	if	 _menuTV.GetItem(rootItemHandle, rootItem) = 1 then
		//	Read access for children.
		ReadChildAccess(_menuTV, rootItemHandle)
	end if
end if

//	Write data back to database.
userAccessCache.object.Data.primary = userAccessData
delete	tdata
where	ucode = :User;

userAccessCache.Update()
commit  ;

//	Return
return	SUCCESS

end function

public function integer readchildaccess (ref u_tv _menutv, integer _currentitemhandle);
integer	i, j
integer	childItemHandle
string	access = ""
treeviewitem	childItem
childItemHandle = _menuTV.FindItem(ChildTreeItem!, _currentItemHandle)
if	childItemHandle < 0 then return NO_ACTION
n_srv_encryption encryption

for	i = 1 to UpperBound(MenuData)
	if	MenuData[i].TreeViewHandle = childItemHandle then
		for	j = 1 to UpperBound(UserAccessData)
			if	MenuData[i].pmcode = UserAccessData[j].mcode then
	
				//	Decrypt access.	
				access = encryption.Decrypt(UserAccessData[j].escode, User)
				exit

			end if
		next
		
		//	If access record wasn't found...
		if	access = "" then
			j = UpperBound(UserAccessData) + 1
			UserAccessData[j].mcode = MenuData[i].pmcode
			UserAccessData[j].ucode = User
			access = FillA("0",250)
		end if
		exit
	end if
next
if	j = 0 then
	return FAILURE
end if

do while childItemHandle > 0
	_menuTV.GetItem(childItemHandle, childItem)
	for	i = 1 to UpperBound(MenuData)
		if	MenuData[i].TreeViewHandle = childItemHandle then
			exit
		end if
	next
	
	//	Set access flag.
	if	childItem.StatePictureIndex = 2 then
		access = Replace(access, Integer(Right(MenuData[i].mcode, 2)), 1, "1")
	else
		access = Replace(access, Integer(Right(MenuData[i].mcode, 2)), 1, "0")
	end if
	
	//	Recurvisly handle children.
	ReadChildAccess(_menuTV, childItemHandle)
	childItemHandle = _menuTV.FindItem(NextTreeItem!, childItemHandle)
loop

//	Encrypt access.
UserAccessData[j].escode = encryption.Encrypt(access, User)

return SUCCESS

end function

on n_srv_useraccess.create
call super::create
end on

on n_srv_useraccess.destroy
call super::destroy
end on

event constructor;call super::constructor;UserAccessCache = create n_ds

end event

event destructor;call super::destructor;destroy	userAccessCache

end event

