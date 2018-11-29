$PBExportHeader$w_frame_office.srw
forward
global type w_frame_office from w_frame
end type
type dw_scannerbox from u_scannerbox within w_frame_office
end type
type dw_quickaccess from u_dw within w_frame_office
end type
type tab_menu from tab within w_frame_office
end type
type tabpage_menu from userobject within tab_menu
end type
type tabpage_menu from userobject within tab_menu
end type
type tab_menu from tab within w_frame_office
tabpage_menu tabpage_menu
end type
type tab_sheets from tab within w_frame_office
end type
type tab_sheets from tab within w_frame_office
end type
type uo_login from u_login within w_frame_office
end type
type uo_mdi from u_base within w_frame_office
end type
type st_splitvert from u_st_splitbar within w_frame_office
end type
type tv_menu from u_tv within w_frame_office
end type
end forward

global type w_frame_office from w_frame
integer width = 4763
integer height = 1656
string title = "Factory eXplorer"
string menuname = "m_frame_office"
event sheetclosing ( ref w_sheet_4t sheetwindow )
event sheethasfocus ( ref w_sheet_4t sheetwindow )
event accessadmin ( )
dw_scannerbox dw_scannerbox
dw_quickaccess dw_quickaccess
tab_menu tab_menu
tab_sheets tab_sheets
uo_login uo_login
uo_mdi uo_mdi
st_splitvert st_splitvert
tv_menu tv_menu
end type
global w_frame_office w_frame_office

type variables

private:
n_cst_associative_array SheetsDictionary
constant integer XOFFSET = 37, YOFFSET = 16, MDIHELPHEIGHT = 48
string ActiveUserCode
string _applicationName = "Factory Explorer - [FX]"
boolean MenuRefresh = false
boolean _suspendLayout = true
boolean _isScanning = false
boolean _isTreeVisible = true
boolean _isLoginVisible = true

n_cst_fxframe_controller Controller

end variables

forward prototypes
public subroutine validlogin (boolean _validlogin)
public subroutine layout ()
public function integer stopscanning ()
public function integer startscanning (n_cst_virtual_controller scanhandler)
public function integer hidetree ()
public function integer showtree ()
public function integer hidelogin ()
public function integer showlogin ()
public function integer setapplicationprofile (long menuvisible, long loginvisible, string defaultsheet)
public function integer navigatemenuitem (str_menuuseraccess menuitem)
public function integer setdefaultmenuitem (string defaultsheet)
public function integer suspendlayout ()
public function integer resumelayout ()
public function integer checkforsavedlogin ()
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

//	Attempt to re-build menu.
n_srv_menuuseraccess userAccess
long	menuItems
MenuRefresh = true // Prevent new windows from opening as menu is rebuilt.
menuItems = userAccess.BuildUserMenu ("", ActiveUserCode, tv_menu, false)
MenuRefresh = false // Finished rebuilding, allow menu selections.
ValidLogin(menuItems > 0)

end event

public subroutine validlogin (boolean _validlogin);
tv_menu.enabled = _validLogin
st_splitvert.enabled = _validLogin

end subroutine

public subroutine layout ();
if	_suspendLayout then return

SetRedraw(false)

//	Get the workspace dimensions.
integer	WorkSpaceX, WorkSpaceY, WorkSpaceWidth, WorkSpaceHeight
WorkSpaceX = WorkSpaceX()
WorkSpaceY = WorkSpaceY()
WorkSpaceWidth = WorkSpaceWidth()
WorkSpaceHeight = WorkSpaceHeight()

int explorerTopLine

//	Move and size controls.
if	uo_login.Visible then
	uo_login.Enabled = true
	uo_login.Move (WorkSpaceX + XOFFSET, WorkSpaceY + YOFFSET)
	uo_login.Resize (2048, 96)
	explorerTopLine = uo_login.Y + uo_login.Height + YOFFSET
else
	uo_login.Enabled = false
	explorerTopLine = WorkSpaceY + YOFFSET
	uo_login.Resize (0, 0)
end if

//	Handle quick access.
if	dw_quickaccess.Visible then
	dw_quickaccess.Move (WorkSpaceX + XOFFSET, explorerTopLine)
	dw_quickaccess.Resize (1120, 100)
	explorerTopLine = dw_quickaccess.Y + dw_quickaccess.Height + YOFFSET
else
	dw_quickaccess.Move (WorkSpaceX + XOFFSET + 2121, WorkSpaceY)
	dw_quickaccess.Resize (0,0)
end if

//	Handle scan box.
dw_scannerbox.Visible = _isScanning
dw_scannerbox.Enabled = _isScanning
if	_isScanning then
	dw_scannerbox.Move (WorkSpaceX + XOFFSET, explorerTopLine)
	dw_scannerbox.Resize (WorkSpaceX + WorkSpaceWidth - 2 * XOFFSET, 204)
	explorerTopLine = dw_scannerbox.Y + dw_scannerbox.Height + YOFFSET
else
	dw_scannerbox.Move (WorkSpaceX + XOFFSET, WorkSpaceY)
	dw_scannerbox.Resize (0, 0)
end if

if	_isTreeVisible then
	tab_menu.Move (WorkSpaceX + XOFFSET, explorerTopLine)
	tab_menu.Height = 84
	tv_menu.Move (WorkSpaceX + XOFFSET, tab_menu.Y + tab_menu.Height)
	tv_menu.Height = WorkSpaceY + WorkSpaceHeight - tv_menu.Y - 2 * YOFFSET - MDIHELPHEIGHT
	st_splitvert.Move (tv_menu.X + tv_menu.Width, tab_menu.Y)
	st_splitvert.Height = tab_menu.Height + tv_menu.Height
	tab_sheets.Move (st_splitvert.X + st_splitvert.Width, explorerTopLine)
	tab_sheets.Width = WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET
	uo_mdi.Move (st_splitvert.X + st_splitvert.Width, tab_sheets.Y + tab_sheets.Height)
	uo_mdi.Resize (WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET, WorkSpaceY + WorkSpaceHeight - uo_mdi.Y - 2 * YOFFSET - MDIHELPHEIGHT)
else
	tab_menu.Move (WorkSpaceX + XOFFSET, explorerTopLine)
	tab_menu.Height =0
	tv_menu.Move (WorkSpaceX + XOFFSET, tab_menu.Y + tab_menu.Height)
	tv_menu.Height = 0
	st_splitvert.Move (tv_menu.X + tv_menu.Width, tab_menu.Y)
	st_splitvert.Height = tab_menu.Height + tv_menu.Height
	tab_sheets.Move (WorkSpaceX + XOFFSET, explorerTopLine)
	tab_sheets.Width = WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET
	if	UpperBound(tab_sheets.Control) > 1 then
		tab_sheets.height = 84
	else
		tab_sheets.Height = 0
	end if
	uo_mdi.Move (WorkSpaceX + XOFFSET, tab_sheets.Y + tab_sheets.Height)
	uo_mdi.Resize (WorkSpaceX + WorkSpaceWidth - uo_mdi.X - XOFFSET, WorkSpaceY + WorkSpaceHeight - uo_mdi.Y - 2 * YOFFSET - MDIHELPHEIGHT)
end if

SetRedraw(true)

end subroutine

public function integer stopscanning ();
_isScanning = false
dw_scannerbox.Visible = _isScanning
dw_scannerbox.StopScanning()
Layout()

return SUCCESS

end function

public function integer startscanning (n_cst_virtual_controller scanhandler);
_isScanning = true
dw_scannerbox.Visible = _isScanning
dw_scannerbox.StartScanning(scanHandler)
Layout()

return SUCCESS

end function

public function integer hidetree ();
_isTreeVisible = false
tab_menu.Visible = _isTreeVisible
tv_menu.Visible = _isTreeVisible
st_splitvert.Visible = _isTreeVisible
Layout()

return SUCCESS

end function

public function integer showtree ();
_isTreeVisible = true
tab_menu.Visible = _isTreeVisible
tv_menu.Visible = _isTreeVisible
st_splitvert.Visible = _isTreeVisible
Layout()

return SUCCESS

end function

public function integer hidelogin ();
_isLoginVisible = false
uo_login.Visible = _isLoginVisible
Layout()

return SUCCESS

end function

public function integer showlogin ();
_isLoginVisible = true
uo_login.Visible = _isLoginVisible
Layout()

return SUCCESS

end function

public function integer setapplicationprofile (long menuvisible, long loginvisible, string defaultsheet);
if	menuVisible = 0 then
	m_frame_office.NoTree()
	HideTree()
end if
if	loginVisible = 0 then
	m_frame_office.NoLogin()
	HideLogin()
else
	CheckForSavedLogin()
end if
if	defaultSheet > "" then
	_applicationName = "Custom"
	SetDefaultMenuItem(defaultSheet)
end if

return SUCCESS

end function

public function integer navigatemenuitem (str_menuuseraccess menuitem);string objectClass
objectClass = menuItem.objectClass

//	Validate class definition.
string objectName, parameters
if	Pos(objectClass, '|') > 0 then
	objectName = Left(objectClass, Pos(objectClass, "|") - 1)
	parameters = Right(objectClass, Len(string(objectClass)) - Pos(objectClass, "|"))
else
	objectName = objectClass
end if
ClassDefinition selectedItemClassDefinition
selectedItemClassDefinition = FindClassDefinition(objectName)
if not IsValid (selectedItemClassDefinition) or IsNull (selectedItemClassDefinition) then return FAILURE

//	Take appropriate action depending on type.
choose case selectedItemClassDefinition.DataTypeOf
	case "window"
		choose case lower(menuitem.ObjectType)
			case "pb10.sheet"
				w_sheet_4t	sheetWindow
				sheetWindow = isnullobject (sheetsDictionary.of_GetItem (selectedItemClassDefinition.Name + "|" + parameters), sheetWindow)
				if	not IsValid (sheetWindow) then
					message.inv_Parm.of_SetItem("ItemPicture", menuItem.MenuIcon)
					gnv_App.inv_Global.of_SetItem("parameters", parameters)
					OpenSheet(sheetWindow, selectedItemClassDefinition.Name, this, 0, Original!)
					sheetsDictionary.of_SetItem (selectedItemClassDefinition.Name + "|" + parameters, sheetWindow)
				else
					sheetWindow.BringToTop = true
				end if
			case "pb10.popup"
				window popupWindow
				Open(popupWindow, selectedItemClassDefinition.Name, this)
		end choose
end choose

return SUCCESS

end function

public function integer setdefaultmenuitem (string defaultsheet);
str_menuuseraccess menuItem
n_srv_menuuseraccess menuUserAccess
menuUserAccess.GetMenuItem(defaultSheet, menuItem)
return NavigateMenuItem(menuItem)

end function

public function integer suspendlayout ();
_suspendLayout = true
return SUCCESS

end function

public function integer resumelayout ();
_suspendLayout = false
post Layout()
return SUCCESS


end function

public function integer checkforsavedlogin ();
//	Lookup user.
string	savedUserCode, validUserCode, validUserName

n_cst_registry	registryValues
registryValues.GetDefaultUser(savedUserCode)

select
	e.operator_code
,	e.name
into
	:validUserCode
,	:validUserName
from
	dbo.employee e
where
	e.operator_code = :savedUserCode  ;

if	validUserCode > "" then
	
	//	Notify controls.
	integer	loginResult
	loginResult = uo_login.SetUser(validUserCode, validUserName)
	if	loginResult = PREVENT_ACTION then
		MessageBox (gnv_App.iapp_Object.DisplayName, "You don't have access to this application.  Please contact your system administrator.")
		uo_login.clearUser()
		return FAILURE
	end if
	return SUCCESS
else
	return	FAILURE
end if

return NO_ACTION

end function

on w_frame_office.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_frame_office" then this.MenuID = create m_frame_office
this.dw_scannerbox=create dw_scannerbox
this.dw_quickaccess=create dw_quickaccess
this.tab_menu=create tab_menu
this.tab_sheets=create tab_sheets
this.uo_login=create uo_login
this.uo_mdi=create uo_mdi
this.st_splitvert=create st_splitvert
this.tv_menu=create tv_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scannerbox
this.Control[iCurrent+2]=this.dw_quickaccess
this.Control[iCurrent+3]=this.tab_menu
this.Control[iCurrent+4]=this.tab_sheets
this.Control[iCurrent+5]=this.uo_login
this.Control[iCurrent+6]=this.uo_mdi
this.Control[iCurrent+7]=this.st_splitvert
this.Control[iCurrent+8]=this.tv_menu
end on

on w_frame_office.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_scannerbox)
destroy(this.dw_quickaccess)
destroy(this.tab_menu)
destroy(this.tab_sheets)
destroy(this.uo_login)
destroy(this.uo_mdi)
destroy(this.st_splitvert)
destroy(this.tv_menu)
end on

event pfc_preopen;call super::pfc_preopen;
gnv_app.of_SetFrame(this)

//	Store preferences.
of_SetPreference(true)
inv_Preference.of_SetToolbarItemVisible(false)

//	Register controls for window resize.
//of_SetResize(true)
//inv_Resize.of_Register(tv_menu, 0, 0, 0, 100)
//inv_Resize.of_Register(st_splitvert, 0, 0, 0, 100)
//inv_Resize.of_Register(uo_mdi, 0, 0, 100, 100)

//	Move focus to the login control (post instead of call because setting focus causes activate event to fire).
uo_login.post SetFocus()

//	Check if admin key is pressed.
if	KeyDown (Key4!) then // and KeyDown (KeyShift!) and KeyDown (KeyControl!) then
	uo_login.Login4T()
else
	this.ValidLogin(false)
end if

//	Create the frame controller and register self.
Controller = create n_cst_fxframe_controller
Container.of_SetItem("Controller", Controller)
w_frame_office wThis
wThis = this
Controller.RegisterFrame(wThis)

end event

event resize;call super::resize;
Layout()

end event

event pfc_splitbarbegin;call super::pfc_splitbarbegin;
if	_isScanning then
	dw_scannerbox.StopScanning()
end if
return CONTINUE_ACTION

end event

event pfc_splitbarend;call super::pfc_splitbarend;
if	_isScanning then
	dw_scannerbox.ResumeScanning()
end if

end event

event pfc_postopen;call super::pfc_postopen;
//	Resume layout.
ResumeLayout()

end event

type dw_scannerbox from u_scannerbox within w_frame_office
integer x = 3090
integer width = 1623
integer height = 204
integer taborder = 20
boolean vscrollbar = false
end type

event pfd_event;call super::pfd_event;
choose case EventName
	case "SheetChange"
		parent.StopScanning()
		visible = false
end choose
Layout()

end event

event constructor;call super::constructor;
string parms[]
parms[1] = "ScannerBox"
parms[2] = "ScannerHandler"

gnv_App.inv_StateMSGRouter.Register("ScannerBox", parms, this, false)
gnv_App.inv_StateMSGRouter.Register("SheetChange", this, false)

end event

type dw_quickaccess from u_dw within w_frame_office
boolean visible = false
integer x = 2158
integer y = 16
integer width = 1120
integer height = 100
integer taborder = 10
string dataobject = "d_quickaccess"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event pfd_event;call super::pfd_event;
choose case EventName
	case "QuickAccess"
		visible = true
		SetFocus()
	case "SheetChange"
		visible = false
end choose
Layout()

end event

event constructor;call super::constructor;
gnv_App.inv_StateMSGRouter.Register("QuickAccess", this, false)
gnv_App.inv_StateMSGRouter.Register("SheetChange", this, false)
end event

type tab_menu from tab within w_frame_office
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

type tab_sheets from tab within w_frame_office
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
boolean boldselectedtext = true
integer selectedtab = 1
end type

event selectionchanged;
u_sheet_tabpg	currentTabPg
currentTabPg = control[newindex]
currentTabPg.of_ShowSheet()

end event

event selectionchanging;
n_cst_associative_array	eventParm
eventParm.of_SetItem("SheetChange", "")
gnv_App.inv_StateMSGRouter.of_Broadcast(eventParm)

end event

type uo_login from u_login within w_frame_office
event sheetopened ( ref window sheet )
integer x = 32
integer y = 16
integer width = 2048
integer height = 96
integer taborder = 10
end type

event ue_login;call super::ue_login;
//	Attempt to build menu.
n_srv_menuuseraccess userAccess
long	menuItems
ActiveUserCode = _user
menuItems = userAccess.BuildUserMenu (_applicationName, ActiveUserCode, tv_menu, false)
//menuItems = userAccess.BuildUserMenu (ActiveUserCode, tv_menu)
parent.ValidLogin(menuItems > 0)
if	menuItems > 0 then
	
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("User", ActiveUserCode)
	gnv_App.inv_StateMSGRouter.of_Broadcast(eventParm)
	gnv_App.inv_Global.of_SetItem("User", ActiveUserCode)

	return CONTINUE_ACTION
else
	return PREVENT_ACTION
end if

end event

event ue_loggedout;call super::ue_loggedout;
gnv_App.inv_Global.of_SetItem("User", "")

//	Reset the menu.
do while tv_menu.FindItem(RootTreeItem!, 0) > 0
	tv_menu.DeleteItem(tv_menu.FindItem(RootTreeItem!, 0))
loop

parent.ValidLogin(false)

end event

type uo_mdi from u_base within w_frame_office
integer x = 914
integer y = 224
integer width = 1682
integer height = 1216
integer taborder = 20
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

type st_splitvert from u_st_splitbar within w_frame_office
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

type tv_menu from u_tv within w_frame_office
integer x = 37
integer y = 224
integer width = 841
integer height = 1216
integer taborder = 10
boolean hideselection = false
long picturemaskcolor = 12632256
end type

event selectionchanged;call super::selectionchanged;
//	Do nothing if the menu is refreshing.
if	MenuRefresh then return

//	Display clicked item (if already selected).
treeviewitem	selectedItem
if	newhandle <> FindItem(CurrentTreeItem!, 0) then
	return	NO_ACTION
end if
if	GetItem(newhandle, selectedItem) <> 1 then
	return	FAILURE
end if

str_menuuseraccess menuItem
menuItem = selectedItem.data

string objectClass
objectClass = menuItem.objectClass

NavigateMenuItem(menuItem)

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

str_menuuseraccess menuItem
menuItem = selectedItem.data

NavigateMenuItem(menuItem)

end event

