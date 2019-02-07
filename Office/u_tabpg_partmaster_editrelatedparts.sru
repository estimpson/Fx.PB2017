HA$PBExportHeader$u_tabpg_partmaster_editrelatedparts.sru
forward
global type u_tabpg_partmaster_editrelatedparts from u_tabpg_dw
end type
type cb_newgroup from commandbutton within u_tabpg_partmaster_editrelatedparts
end type
type cb_close from commandbutton within u_tabpg_partmaster_editrelatedparts
end type
type cb_addparts from commandbutton within u_tabpg_partmaster_editrelatedparts
end type
type cb_removeparts from commandbutton within u_tabpg_partmaster_editrelatedparts
end type
type dw_unrelatedparts from u_fxdw within u_tabpg_partmaster_editrelatedparts
end type
type cb_renamegroup from commandbutton within u_tabpg_partmaster_editrelatedparts
end type
type gb_2 from groupbox within u_tabpg_partmaster_editrelatedparts
end type
end forward

global type u_tabpg_partmaster_editrelatedparts from u_tabpg_dw
integer width = 4050
cb_newgroup cb_newgroup
cb_close cb_close
cb_addparts cb_addparts
cb_removeparts cb_removeparts
dw_unrelatedparts dw_unrelatedparts
cb_renamegroup cb_renamegroup
gb_2 gb_2
end type
global u_tabpg_partmaster_editrelatedparts u_tabpg_partmaster_editrelatedparts

type variables

private string _partCode
private string _groupGUID
end variables

forward prototypes
public function integer setpart (string partcode)
public subroutine close ()
end prototypes

public function integer setpart (string partcode);
//	Set part and refresh.
_partCode = partCode
return Refresh()

end function

public subroutine close ();
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

dw_1.Reset()
myController.EndEditRelatedParts()

end subroutine

on u_tabpg_partmaster_editrelatedparts.create
int iCurrent
call super::create
this.cb_newgroup=create cb_newgroup
this.cb_close=create cb_close
this.cb_addparts=create cb_addparts
this.cb_removeparts=create cb_removeparts
this.dw_unrelatedparts=create dw_unrelatedparts
this.cb_renamegroup=create cb_renamegroup
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_newgroup
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_addparts
this.Control[iCurrent+4]=this.cb_removeparts
this.Control[iCurrent+5]=this.dw_unrelatedparts
this.Control[iCurrent+6]=this.cb_renamegroup
this.Control[iCurrent+7]=this.gb_2
end on

on u_tabpg_partmaster_editrelatedparts.destroy
call super::destroy
destroy(this.cb_newgroup)
destroy(this.cb_close)
destroy(this.cb_addparts)
destroy(this.cb_removeparts)
destroy(this.dw_unrelatedparts)
destroy(this.cb_renamegroup)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(gb_2.X + gb_1.X + gb_2.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_addparts, 0, 50, 0, 0)
inv_Resize.of_Register(cb_removeparts, 0, 50, 0, 0)
inv_Resize.of_Register(cb_close, 0, 100, 0, 0)
inv_Resize.of_UnRegister(gb_1)
inv_Resize.of_UnRegister(dw_1)
inv_Resize.of_Register(gb_1, 0, 0, 0, 100)
inv_Resize.of_Register(dw_1, 0, 0, 0, 100)
inv_Resize.of_Register(gb_2, 0, 0, 100, 100)
inv_Resize.of_Register(dw_unrelatedparts, 0, 0, 100, 100)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_editrelatedparts
integer x = 37
integer width = 1568
string text = "Related Parts"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_editrelatedparts
integer x = 46
integer width = 1550
string dataobject = "d_partmaster_relatedpartlist"
boolean showpowerfilter = false
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode)

end event

event dw_1::constructor;call super::constructor;
//	Turn off the sort service
of_SetSort (false)

//	Turn off the filter service
of_SetFilter (false)

//	Turn off the calendar for editable dates.
of_SetDropDownCalendar(false)

of_SetTransObject(SQLCA)

end event

event dw_1::clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

SetRedraw(false)
choose case upper(dwo.Name)
	case Upper("c_delete")
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to remove the selected value(s)?", Question!, YesNo!, 2) = 2 then
			SetRedraw(true)
			return
		end if
		dw_1.Object.StringValue[row] = ""
	
	case Upper("c_choosevalues"), Upper("StringValue")
		long allowMultipleValues
		allowMultipleValues = dw_1.Object.AllowMultipleValues[row]
		if	allowMultipleValues = 0 then return
		
		string customFieldName
		customFieldName = dw_1.Object.CustomFieldName[row]
		myController.EditCustomFieldMultiValue(_partCode, customFieldName)
end choose
SetRedraw(true)

end event

event dw_1::updateend;call super::updateend;
//	Close transaction.
commit using SQLCA  ;

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 or activerow > RowCount() then
	SetNull(_groupGUID)
	cb_renamegroup.Enabled = false
	dw_unrelatedparts.Reset()
	return
end if

//	Refresh the list of unrelated parts.
_groupGUID = Object.GroupGUID[activerow]
cb_renamegroup.Enabled = true
dw_unrelatedparts.Refresh()

end event

type cb_newgroup from commandbutton within u_tabpg_partmaster_editrelatedparts
integer x = 1659
integer y = 16
integer width = 517
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New Group..."
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

//	Tell controller to create a new part group related to this part
myController.NewRelatedPartGroup(_partCode)

end event

type cb_close from commandbutton within u_tabpg_partmaster_editrelatedparts
integer x = 1659
integer y = 972
integer width = 517
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;
//	Close
Close()

end event

type cb_addparts from commandbutton within u_tabpg_partmaster_editrelatedparts
integer x = 1659
integer y = 444
integer width = 517
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< Add parts"
end type

event clicked;
//	Add selected parts to group
long row, rows
long SelectedArray []
string partCodeArray [], groupGUID
groupGUID = dw_1.Object.GroupGUID[dw_1.GetRow()]

SelectedArray = dw_unrelatedparts.Object.IsSelected.Primary
partCodeArray = dw_unrelatedparts.Object.PartCode.Primary

n_cst_partmastertrans_relatedparts partMasterTrans_RelatedParts
partMasterTrans_RelatedParts = create n_cst_partmastertrans_relatedparts

rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	partMasterTrans_RelatedParts.AddRelatedPart(partCodeArray[row], groupGUID) <> SUCCESS then
			destroy partMasterTrans_RelatedParts
			return
		end if
	end if
next
commit using SQLCA  ;
destroy partMasterTrans_RelatedParts
Refresh()

end event

type cb_removeparts from commandbutton within u_tabpg_partmaster_editrelatedparts
integer x = 1659
integer y = 576
integer width = 517
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Remove parts >>"
end type

event clicked;
//	Add selected parts to group
long row, rows
long SelectedArray [], isGroupArray []
string partCodeArray [], groupGUIDArray[]

SelectedArray = dw_1.Object.IsSelected.Primary
isGroupArray = dw_1.Object.IsGroup.Primary
partCodeArray = dw_1.Object.RelatedPartCode.Primary
groupGUIDArray = dw_1.Object.GroupGUID.Primary

n_cst_partmastertrans_relatedparts partMasterTrans_RelatedParts
partMasterTrans_RelatedParts = create n_cst_partmastertrans_relatedparts

rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 and isGroupArray[row] = 0 then
		if	partMasterTrans_RelatedParts.RemoveRelatedPart(partCodeArray[row], groupGUIDArray[row]) <> SUCCESS then
			destroy partMasterTrans_RelatedParts
			return
		end if
	end if
next
commit using SQLCA  ;
destroy partMasterTrans_RelatedParts

Refresh()

end event

type dw_unrelatedparts from u_fxdw within u_tabpg_partmaster_editrelatedparts
integer x = 2245
integer y = 80
integer width = 1550
integer height = 996
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_partmaster_unrelatedpartlist"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Turn on the sort service
of_SetSort (true)
inv_sort.of_SetStyle(inv_sort.DRAGDROP)
inv_Sort.SetColumnHeaderExt (true)

//	Turn on the filter service
of_SetFilter (true)
inv_filter.of_SetStyle(inv_filter.EXTENDED)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode, _groupGUID)

end event

type cb_renamegroup from commandbutton within u_tabpg_partmaster_editrelatedparts
integer x = 1659
integer y = 148
integer width = 517
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rename Group..."
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

//	Tell controller to create a new part group related to this part
myController.EditRelatedPartGroupName(_partCode, _groupGUID)

end event

type gb_2 from groupbox within u_tabpg_partmaster_editrelatedparts
integer x = 2235
integer width = 1568
integer height = 1084
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Unrelated Parts"
end type

