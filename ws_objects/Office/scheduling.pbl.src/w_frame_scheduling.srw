$PBExportHeader$w_frame_scheduling.srw
forward
global type w_frame_scheduling from w_frame
end type
type tab_menu from tab within w_frame_scheduling
end type
type tabpage_menu from userobject within tab_menu
end type
type tabpage_menu from userobject within tab_menu
end type
type tab_menu from tab within w_frame_scheduling
tabpage_menu tabpage_menu
end type
type tab_sheets from tab within w_frame_scheduling
end type
type tab_sheets from tab within w_frame_scheduling
end type
type uo_login from u_login within w_frame_scheduling
end type
type uo_mdi from u_base within w_frame_scheduling
end type
type st_splitvert from u_st_splitbar within w_frame_scheduling
end type
type tv_menu from u_tv within w_frame_scheduling
end type
end forward

global type w_frame_scheduling from w_frame
integer width = 2816
integer height = 2376
string title = "FX COP"
string menuname = "m_frame_office"
event sheetclosing ( ref w_sheet_4t sheetwindow )
event sheethasfocus ( ref w_sheet_4t sheetwindow )
event accessadmin ( )
tab_menu tab_menu
tab_sheets tab_sheets
uo_login uo_login
uo_mdi uo_mdi
st_splitvert st_splitvert
tv_menu tv_menu
end type
global w_frame_scheduling w_frame_scheduling

type variables

private n_cst_associative_array SheetsDictionary
private constant integer XOFFSET = 37, YOFFSET = 16, MDIHELPHEIGHT = 48
private string ActiveUserCode

end variables

forward prototypes
public subroutine validlogin (boolean _validlogin)
end prototypes

event sheetclosing(ref w_sheet_4t sheetwindow);
//	Close tab associated with sheet.
if	IsValid (sheetWindow) then
	if	IsValid (sheetWindow.sheetTabPage) then
		tab_sheets.CloseTab(sheetWindow.sheetTabPage)
	end if
end if

end event

event sheethasfocus(ref w_sheet_4t sheetwindow);
//	Close tab associated with sheet.
if	IsValid (sheetWindow) then
	if	IsValid (sheetWindow.SheetTabPage) then
		int	i
		for	i = 1 to UpperBound(tab_sheets.Control)
			if	tab_sheets.Control[i] = sheetWindow.sheetTabPage then
				tab_sheets.SelectTab(i)
				return
			end if
		next
	end if
	
	//	Tab not open.  Create it.
	tab_sheets.OpenTab(sheetWindow.SheetTabPage, 0)
	tab_sheets.SelectTab(UpperBound(tab_sheets.Control))
	sheetWindow.SheetTabPage.of_SetSheetWindow(sheetWindow, IsNull(message.inv_Parm.of_GetItem("ItemPicture"), ""))
end if

end event

event accessadmin();
//	Validate administrative password.
integer returnValue 
Open(w_password)
returnValue = Message.DoubleParm
if	returnValue <> SUCCESS then
	return
end if

//	Open access admin.
OpenWithParm(w_accessadmin, ActiveUserCode)

//	Reset the menu.
do while tv_menu.FindItem(RootTreeItem!, 0) > 0
	tv_menu.DeleteItem(tv_menu.FindItem(RootTreeItem!, 0))
loop

//	Attempt to build menu.
n_srv_useraccess userAccess
long	menuItems
menuItems = userAccess.BuildUserMenu (ActiveUserCode, tv_menu)
ValidLogin(menuItems > 0)

end event

public subroutine validlogin (boolean _validlogin);
tv_menu.enabled = _validLogin
st_splitvert.enabled = _validLogin

end subroutine

on w_frame_scheduling.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_frame_office" then this.MenuID = create m_frame_office
this.tab_menu=create tab_menu
this.tab_sheets=create tab_sheets
this.uo_login=create uo_login
this.uo_mdi=create uo_mdi
this.st_splitvert=create st_splitvert
this.tv_menu=create tv_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_menu
this.Control[iCurrent+2]=this.tab_sheets
this.Control[iCurrent+3]=this.uo_login
this.Control[iCurrent+4]=this.uo_mdi
this.Control[iCurrent+5]=this.st_splitvert
this.Control[iCurrent+6]=this.tv_menu
end on

on w_frame_scheduling.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_menu)
destroy(this.tab_sheets)
destroy(this.uo_login)
destroy(this.uo_mdi)
destroy(this.st_splitvert)
destroy(this.tv_menu)
end on

event pfc_preopen;call super::pfc_preopen;
//	Store preferences.
of_SetPreference(true)

//	Register controls for window resize.
//of_SetResize(true)
//inv_Resize.of_Register(tv_menu, 0, 0, 0, 100)
//inv_Resize.of_Register(st_splitvert, 0, 0, 0, 100)
//inv_Resize.of_Register(uo_mdi, 0, 0, 100, 100)

//	Move focus to the login control.
uo_login.SetFocus()

//	Check if admin key is pressed.
if	KeyDown (Key4!) then // and KeyDown (KeyShift!) and KeyDown (KeyControl!) then
	uo_login.Login4T()
else
	this.ValidLogin(false)
end if

end event

event resize;call super::resize;
//	Get the workspace dimensions.
integer	WorkSpaceX, WorkSpaceY, WorkSpaceWidth, WorkSpaceHeight
WorkSpaceX = WorkSpaceX()
WorkSpaceY = WorkSpaceY()
WorkSpaceWidth = WorkSpaceWidth()
WorkSpaceHeight = WorkSpaceHeight()

//	Move and size controls.
uo_login.Move (WorkSpaceX + XOFFSET, WorkSpaceY)
tab_menu.Move (WorkSpaceX + XOFFSET, uo_login.Y + uo_login.Height + YOFFSET)
tab_sheets.Move (st_splitvert.X + st_splitvert.Width, uo_login.Y + uo_login.Height + YOFFSET)
tab_sheets.Width = WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET
tv_menu.Move (WorkSpaceX + XOFFSET, tab_sheets.Y + tab_sheets.Height)
tv_menu.Height = WorkSpaceY + WorkSpaceHeight - tv_menu.Y - YOFFSET - MDIHELPHEIGHT
st_splitvert.Move (tv_menu.X + tv_menu.Width, tab_menu.Y)
st_splitvert.Height = tab_menu.Height + tv_menu.Height
uo_mdi.Move (st_splitvert.X + st_splitvert.Width, tv_menu.Y)
uo_mdi.Resize (WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET, tv_menu.Height)

end event

type tab_menu from tab within w_frame_scheduling
integer x = 37
integer y = 128
integer width = 846
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_menu tabpage_menu
end type

on tab_menu.create
this.tabpage_menu=create tabpage_menu
this.Control[]={this.tabpage_menu}
end on

on tab_menu.destroy
destroy(this.tabpage_menu)
end on

type tabpage_menu from userobject within tab_menu
integer x = 18
integer y = 100
integer width = 809
integer height = -32
long backcolor = 79741120
string text = "Applications"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
end type

type tab_sheets from tab within w_frame_scheduling
integer x = 914
integer y = 128
integer width = 1682
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
end type

event selectionchanged;
if	oldindex > 0 then
	control[oldindex].tabbackcolor = 0
end if
if	newindex > 0 then
	control[newindex].tabbackcolor = RGB(46,142,200)
end if

u_sheet_tabpg	currentTabPg
currentTabPg = control[newindex]
currentTabPg.of_ShowSheet()
end event

type uo_login from u_login within w_frame_scheduling
event sheetopened ( ref window sheet )
integer x = 37
integer y = 16
integer width = 2048
integer height = 96
integer taborder = 10
end type

event ue_login;call super::ue_login;
//	Reset the menu.
do while tv_menu.FindItem(RootTreeItem!, 0) > 0
	tv_menu.DeleteItem(tv_menu.FindItem(RootTreeItem!, 0))
loop

//	Attempt to build menu.
n_srv_useraccess userAccess
long	menuItems
ActiveUserCode = _user
menuItems = userAccess.BuildUserMenu (ActiveUserCode, tv_menu)
parent.ValidLogin(menuItems > 0)
if	menuItems > 0 then
	
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("User", ActiveUserCode)
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)

	return CONTINUE_ACTION
else
	return PREVENT_ACTION
end if

end event

event ue_loggedout;call super::ue_loggedout;
//	Reset the menu.
do while tv_menu.FindItem(RootTreeItem!, 0) > 0
	tv_menu.DeleteItem(tv_menu.FindItem(RootTreeItem!, 0))
loop

parent.ValidLogin(false)

end event

type uo_mdi from u_base within w_frame_scheduling
integer x = 914
integer y = 224
integer width = 1682
integer height = 1216
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mdi.destroy
call u_base::destroy
end on

event constructor;call super::constructor;
//	Hide.
visible = FALSE
end event

event resize;call super::resize;
//	Set size and location of mdi.
parent.mdi_1.Move (this.X, this.Y)
parent.mdi_1.Resize (this.Width, this.Height)

end event

type st_splitvert from u_st_splitbar within w_frame_scheduling
integer x = 882
integer y = 136
integer width = 27
integer height = 1312
end type

event constructor;call super::constructor;
//	Register panes.
of_Register (tab_menu, this.LEFT)
of_Register (tv_menu, this.LEFT)
of_Register (tab_sheets, this.RIGHT)
of_Register (uo_mdi, this.RIGHT)

end event

type tv_menu from u_tv within w_frame_scheduling
integer x = 37
integer y = 224
integer width = 841
integer height = 1216
integer taborder = 10
boolean hideselection = false
long picturemaskcolor = 12632256
end type

event selectionchanged;call super::selectionchanged;
//	Display clicked item (if already selected).
treeviewitem	selectedItem
if	newhandle <> FindItem(CurrentTreeItem!, 0) then
	return	NO_ACTION
end if
if	GetItem(newhandle, selectedItem) <> 1 then
	return	FAILURE
end if

//	Validate class definition.
string objectName, parameters
if	Pos(selectedItem.Data, '|') > 0 then
	objectName = Left(selectedItem.Data, Pos(selectedItem.Data, "|") - 1)
	parameters = Right(selectedItem.Data, Len(string(selectedItem.Data)) - Pos(selectedItem.Data, "|"))
else
	objectName = selectedItem.Data
end if
ClassDefinition selectedItemClassDefinition
selectedItemClassDefinition = FindClassDefinition(objectName)
if not IsValid (selectedItemClassDefinition) or IsNull (selectedItemClassDefinition) then return

//	Take appropriate action depending on type.
choose case selectedItemClassDefinition.DataTypeOf
	case "window"
		w_sheet_4t	sheetWindow
		sheetWindow = isnull (sheetsDictionary.of_GetItem (selectedItemClassDefinition.Name + "|" + parameters), sheetWindow)
		if	not IsValid (sheetWindow) then
			message.inv_Parm.of_SetItem("ItemPicture", PictureArray.of_GetItemIndexor(selectedItem.PictureIndex))
			gnv_App.inv_Global.of_SetItem("parameters", parameters)
			OpenSheet(sheetWindow, selectedItemClassDefinition.Name, parent, 0, Original!)
			sheetsDictionary.of_SetItem (selectedItemClassDefinition.Name + "|" + parameters, sheetWindow)
		else
			sheetWindow.BringToTop = true
		end if
end choose

end event

event clicked;call super::clicked;
//	Display clicked item (if already selected).
treeviewitem	selectedItem
if	handle <> FindItem(CurrentTreeItem!, 0) then
	return	NO_ACTION
end if
if	GetItem(handle, selectedItem) <> 1 then
	return	FAILURE
end if

//	Validate class definition.
string objectName, parameters
if	Pos(selectedItem.Data, '|') > 0 then
	objectName = Left(selectedItem.Data, Pos(selectedItem.Data, "|") - 1)
	parameters = Right(selectedItem.Data, Len(string(selectedItem.Data)) - Pos(selectedItem.Data, "|"))
else
	objectName = selectedItem.Data
end if
ClassDefinition selectedItemClassDefinition
selectedItemClassDefinition = FindClassDefinition(objectName)
if not IsValid (selectedItemClassDefinition) or IsNull (selectedItemClassDefinition) then return

//	Take appropriate action depending on type.
choose case selectedItemClassDefinition.DataTypeOf
	case "window"
		w_sheet_4t	sheetWindow
		sheetWindow = isnull (sheetsDictionary.of_GetItem (selectedItemClassDefinition.Name + "|" + parameters), sheetWindow)
		if	not IsValid (sheetWindow) then
			message.inv_Parm.of_SetItem("ItemPicture", PictureArray.of_GetItemIndexor(selectedItem.PictureIndex))
			gnv_App.inv_Global.of_SetItem("parameters", parameters)
			OpenSheet(sheetWindow, selectedItemClassDefinition.Name, parent, 0, Original!)
			sheetsDictionary.of_SetItem (selectedItemClassDefinition.Name + "|" + parameters, sheetWindow)
		else
			sheetWindow.BringToTop = true
		end if
end choose

end event

