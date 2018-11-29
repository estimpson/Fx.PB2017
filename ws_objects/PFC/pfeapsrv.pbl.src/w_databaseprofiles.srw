$PBExportHeader$w_databaseprofiles.srw
forward
global type w_databaseprofiles from w_response
end type
type tv_1 from treeview within w_databaseprofiles
end type
type ddlb_1 from dropdownlistbox within w_databaseprofiles
end type
type st_1 from statictext within w_databaseprofiles
end type
type cbx_1 from checkbox within w_databaseprofiles
end type
end forward

global type w_databaseprofiles from w_response
integer width = 1440
integer height = 1424
string title = "Choose Database Profile"
long backcolor = 78748035
event ue_new ( )
event ue_delete ( )
event ue_edit ( )
tv_1 tv_1
ddlb_1 ddlb_1
st_1 st_1
cbx_1 cbx_1
end type
global w_databaseprofiles w_databaseprofiles

type variables
n_cst_Registry		inv_Reg
string			is_AppProfile
end variables

forward prototypes
public subroutine wf_showdefaults ()
public subroutine refreshprofiles ()
public subroutine refreshsqlprofiles ()
end prototypes

event ue_new;
//	Declarations
n_cst_associative_array	lnv_Args

//	Set the arguments and open the edit window
lnv_Args.of_SetItem ( "AppProfile", is_AppProfile )
lnv_Args.of_SetItem ( "SQLProfile", "" )
OpenWithParm ( w_sqlserverprofile, lnv_Args )

end event

event ue_delete();//	Declarations
treeviewitem	ltvi_Item
long		ll_Handle

//	Get the current item
ll_Handle = tv_1.FindItem(CurrentTreeItem!, 0)
if ll_Handle > 0 then
	tv_1.GetItem(ll_Handle, ltvi_Item)
	if MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure about deleting the profile " + ltvi_Item.Label + "?", Question!, YesNo!, 2) = 1 then
		inv_Reg.of_DeleteSQLServerProfile(is_AppProfile, ltvi_Item.Label)
		n_ds dsProfiles
		dsProfiles = create n_ds
		dsProfiles.DataObject = "d_conn_profiles"
		//dsProfiles.ImportFile(XML!, "ConnProfiles.xml")
		dsProfiles.ImportFile("ConnProfiles.txt")
		dsProfiles.SetFilter("profilename=~"" + ltvi_Item.Label + "~"")
		dsProfiles.Filter()
		if	dsProfiles.RowCount() = 1 then
			dsProfiles.DeleteRow(1)
			dsProfiles.SetFilter("")
			dsProfiles.Filter()
			dsProfiles.Sort()
			//dsProfiles.SaveAs("ConnProfiles.xml", XML!, false)
			dsProfiles.SaveAs("ConnProfiles.txt", Text!, false)
		else
			MessageBox(gnv_App.iapp_Object.DisplayName, "Delete of profile " + ltvi_Item.Label + " failed", StopSign!)
		end if
		destroy dsProfiles
		RefreshProfiles()
	end if
end if
end event

event ue_edit;//	Declarations
treeviewitem		ltvi_Item
long			ll_Handle
n_cst_associative_array	lnv_Args

//	Get the current item
ll_Handle = tv_1.FindItem ( CurrentTreeItem!, 0 )
if ll_Handle > 0 then
	tv_1.GetItem ( ll_Handle, ltvi_Item )
	choose case ltvi_Item.Data
		case "ODBCLabel"
			Run ( "ODBCAD32.EXE" )
		case else
			//	Build the arguments and open the edit window
			lnv_Args.of_SetItem ( "AppProfile", is_AppProfile )
			lnv_Args.of_SetItem ( "SQLProfile", ltvi_Item.Label )
			OpenWithParm ( w_sqlserverprofile, lnv_Args )
	end choose
end if
end event

public subroutine wf_showdefaults ();
//	Set the default profile.
n_ds dsDefaultProfile
dsDefaultProfile = create n_ds
dsDefaultProfile.DataObject = "d_conn_defaultprofile"
//dsDefaultProfile.ImportFile(XML!, "ConnDefaultProfile.xml")
dsDefaultProfile.ImportFile("ConnDefaultProfile.txt")
if	dsDefaultProfile.RowCount() < 1 then
	dsDefaultProfile.InsertRow(0)
	dsDefaultProfile.object.DBMS[1] = "MSS"
	dsDefaultProfile.object.Provider[1] = "SQLNCLI10"
end if
string defaultProfile
defaultProfile = dsDefaultProfile.object.DefaultProfile[1]

//	Set the prompt setting
cbx_1.Checked = (dsDefaultProfile.object.Prompt[1] = 1)

//	Get the default from the registry and find in drop down and in tree view
ddlb_1.Text = defaultProfile + " - (" + dsDefaultProfile.object.DBMS[1] + ")"

long handle
handle = tv_1.FindItem(RootTreeItem!, 0)
handle = tv_1.FindItem(ChildTreeItem!, handle)
do while handle <> -1
	treeviewitem tvItem
	tv_1.GetItem(handle, tvItem)
	if	tvItem.Label = defaultProfile then
		tv_1.SelectItem(handle)
		handle = -1
	else
		handle = tv_1.FindItem(NextTreeItem!, handle)
	end if
loop
destroy dsDefaultProfile

end subroutine

public subroutine refreshprofiles ();//	Declarations
long handle
handle = tv_1.FindItem(RootTreeItem!, 0)
do while handle > 0
	tv_1.DeleteItem(handle)
	handle = tv_1.FindItem(RootTreeItem!, 0)
loop

//	Get the sql server database profiles and add them to the tree view
treeviewitem ltvi_Item
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 1
ltvi_Item.Label = "SQL Server Profiles"
ltvi_Item.Data = "SQLLabel"
ltvi_Item.Children = TRUE
ltvi_Item.Expanded = TRUE
tv_1.InsertItemLast(0, ltvi_Item)

ddlb_1.Reset()
ddlb_1.AddItem("(None)")

RefreshSQLProfiles()
wf_ShowDefaults()

end subroutine

public subroutine refreshsqlprofiles ();
//	Get the sql server database profiles and add them to the tree view
long handle, childHandle
handle = tv_1.FindItem(RootTreeItem!, 0)
childHandle = tv_1.FindItem(ChildTreeItem!, handle)
do while childHandle > 0
	tv_1.DeleteItem(childHandle)
	childHandle = tv_1.FindItem(ChildTreeItem!, handle)
loop
treeviewitem tvItem
tvItem.PictureIndex = 1
tvItem.SelectedPictureIndex = 1
tvItem.Children = FALSE
tvItem.Expanded = FALSE

//	Read all of the profiles.
n_ds dsProfiles
dsProfiles = create n_ds
dsProfiles.DataObject = "d_conn_profiles"
//dsProfiles.ImportFile(XML!, "ConnProfiles.xml")
dsProfiles.ImportFile("ConnProfiles.txt")

long i
for i = 1 to RowCount(dsProfiles)
	tvItem.Label = dsProfiles.object.ProfileName[i]
	tvItem.Data = "SQLProfile"
	tv_1.InsertItemSort(handle, tvItem)
	//	Add item to default dropdown
	ddlb_1.AddItem(dsProfiles.object.ProfileName[i] + " - (MSS)")
next

destroy dsProfiles
end subroutine

on w_databaseprofiles.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_1
end on

on w_databaseprofiles.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cbx_1)
end on

event pfc_postopen;call super::pfc_postopen;
RefreshProfiles()

//	Place window on top.
SetPosition (TopMost!)

end event

event pfc_preopen;call super::pfc_preopen;
//	Store the app profile for later use
is_AppProfile = Message.StringParm

//	Set the title
Title = "Choose " + is_AppProfile + " Database Profile"

//	Turn on the base service
of_SetBase ( TRUE )

//	Turn on the resize service
of_SetResize ( TRUE )

//	Set the original size
inv_resize.of_SetOrigSize ( ( tv_1.x * 2 ) + tv_1.Width, ( ddlb_1.y * 2 ) + tv_1.y + tv_1.Height )

//	Registry the controls with the resize service
inv_resize.of_Register ( st_1, 0, 0, 0, 0 )
inv_resize.of_Register ( ddlb_1, 0, 0, 0, 0 )
inv_resize.of_Register ( cbx_1, 0, 0, 0, 0 )
inv_resize.of_Register ( tv_1, 0, 0, 100, 100 )

//	Center the window
inv_base.of_Center ( )
end event

event activate;call super::activate;RefreshProfiles ( )
end event

event key;call super::key;if key = KeyA! and keyflags = 3 then
	OpenWithParm ( w_databaseprofilesadmin, is_AppProfile )
end if
end event

type tv_1 from treeview within w_databaseprofiles
integer x = 18
integer y = 112
integer width = 1390
integer height = 1200
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"DatabaseProfile!","ConfigODBC!","ConfigODBC5!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event selectionchanging;////	Declarations
//treeviewitem	ltvi_Item
//
////	Get the new item
//GetItem ( newhandle, ltvi_Item )
//
////	If the type of item is a label, dont allow to continue
//if ltvi_Item.Data = "Label" then
//	return 1
//end if
end event

event rightclicked;
if handle = 0 then return

//	Declarations
treeviewitem		ltvi_Item
m_databaseprofilespopup	lm_Popup

//	Create the popup menu
lm_Popup = create m_databaseprofilespopup

//	Get the current item
GetItem ( handle, ltvi_Item )

if ltvi_Item.Data = "SQLLabel" then
	lm_Popup.m_sqllabel.PopMenu ( PointerX ( ) + 50, PointerY ( ) + 50 )
elseif ltvi_Item.Data = "ODBCLabel" then
	lm_Popup.m_odbclabel.PopMenu ( PointerX ( ) + 50, PointerY ( ) + 50 )
elseif ltvi_Item.Data = "SQLProfile" then
	lm_Popup.m_sqlprofile.PopMenu ( PointerX ( ) + 50, PointerY ( ) + 50 )
end if

end event

event doubleclicked;
if handle = 0 then return

//	Declarations
treeviewitem		ltvi_Item
ulong			lul_IntegratedSecurity
ulong			lul_AutoCommit
string			ls_ServerName
string			ls_Database
string			ls_LogId
string			ls_LogPass
n_cst_associative_array	lnv_Args

//	Get the current item
GetItem ( handle, ltvi_Item )

lnv_Args.of_SetItem ( "profile", ltvi_Item.Label )
if ltvi_Item.Data = "SQLProfile" then
	lnv_Args.of_SetItem ( "dbms", "MSS" )
	CloseWithReturn ( Parent, lnv_Args )
elseif ltvi_Item.Data = "ODBCProfile" then
	lnv_Args.of_SetItem ( "dbms", "ODBC" )
	CloseWithReturn ( Parent, lnv_Args )
end if

end event

event key;Parent.Event key ( key, keyflags )
end event

type ddlb_1 from dropdownlistbox within w_databaseprofiles
event key pbm_keydown
integer x = 347
integer y = 16
integer width = 768
integer height = 1120
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event key;Parent.Event key ( key, keyflags )
end event

event selectionchanged;//	Parse out the profile and dbms
string	defaultProfile = ""
string	dbms = ""
if	Text <> "(None)" then
	integer hyphenPos
	hyphenPos = Pos(Text, " - (")
	if	hyphenPos > 0 then
		defaultProfile = Left(Text, hyphenPos - 1)
		dbms = Mid(Text, hyphenPos + 4, Len(Text) -(hyphenPos + 4))
	end if
end if

//	Set the default profile.
n_ds dsDefaultProfile
dsDefaultProfile = create n_ds
dsDefaultProfile.DataObject = "d_conn_defaultprofile"
//dsDefaultProfile.ImportFile(XML!, "ConnDefaultProfile.xml")
dsDefaultProfile.ImportFile("ConnDefaultProfile.txt")
if	dsDefaultProfile.RowCount() < 1 then
	dsDefaultProfile.InsertRow(0)
	dsDefaultProfile.object.DBMS[1] = "MSS"
	dsDefaultProfile.object.Provider[1] = "SQLNCLI10"
end if
dsDefaultProfile.object.DefaultProfile[1] = defaultProfile
//dsDefaultProfile.SaveAs("ConnDefaultProfile.xml", XML!, false)
dsDefaultProfile.SaveAs("ConnDefaultProfile.txt", Text!, false)
destroy dsDefaultProfile



end event

type st_1 from statictext within w_databaseprofiles
integer x = 18
integer y = 32
integer width = 329
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Default Profile:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_databaseprofiles
event key pbm_keydown
integer x = 1152
integer y = 16
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prompt"
end type

event key;Parent.Event key ( key, keyflags )
end event

event clicked;
//	Set the default profile.
n_ds dsDefaultProfile
dsDefaultProfile = create n_ds
dsDefaultProfile.DataObject = "d_conn_defaultprofile"
//dsDefaultProfile.ImportFile(XML!, "ConnDefaultProfile.xml")
dsDefaultProfile.ImportFile("ConnDefaultProfile.txt")
if	dsDefaultProfile.RowCount() < 1 then
	dsDefaultProfile.InsertRow(0)
	dsDefaultProfile.object.DBMS[1] = "MSS"
	dsDefaultProfile.object.Provider[1] = "SQLNCLI10"
end if
if	Checked then
	dsDefaultProfile.object.Prompt[1] = 1
else
	dsDefaultProfile.object.Prompt[1] = 0
end if
//dsDefaultProfile.SaveAs("ConnDefaultProfile.xml", XML!, false)
dsDefaultProfile.SaveAs("ConnDefaultProfile.txt", Text!, false)
destroy dsDefaultProfile

end event

