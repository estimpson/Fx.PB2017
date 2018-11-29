$PBExportHeader$u_tabpg_inventory_quality_newheader.sru
forward
global type u_tabpg_inventory_quality_newheader from u_tabpg_dw
end type
type dw_headercriteria from u_fxdw within u_tabpg_inventory_quality_newheader
end type
type cb_ok from commandbutton within u_tabpg_inventory_quality_newheader
end type
type cb_cancel from commandbutton within u_tabpg_inventory_quality_newheader
end type
type cb_preview from commandbutton within u_tabpg_inventory_quality_newheader
end type
type cb_editquery from commandbutton within u_tabpg_inventory_quality_newheader
end type
type st_1 from u_st_splitbar within u_tabpg_inventory_quality_newheader
end type
type mle_description from multilineedit within u_tabpg_inventory_quality_newheader
end type
type gb_2 from groupbox within u_tabpg_inventory_quality_newheader
end type
end forward

global type u_tabpg_inventory_quality_newheader from u_tabpg_dw
integer width = 4265
integer height = 1936
string text = "New Cycle Count"
dw_headercriteria dw_headercriteria
cb_ok cb_ok
cb_cancel cb_cancel
cb_preview cb_preview
cb_editquery cb_editquery
st_1 st_1
mle_description mle_description
gb_2 gb_2
end type
global u_tabpg_inventory_quality_newheader u_tabpg_inventory_quality_newheader

type variables

n_cst_inventorytrans_quality InventoryTrans_Quality

string DESCRIPTION_INST = "Type description here..."
end variables

forward prototypes
public function integer reset ()
public function integer savenewheader ()
end prototypes

public function integer reset ();
dw_headercriteria.event pfc_retrieve()
dw_1.SetFilter("")
dw_1.Reset()
mle_description.Text = DESCRIPTION_INST

return SUCCESS

end function

public function integer savenewheader ();
if	mle_description.Text = DESCRIPTION_INST or trim(mle_description.Text) = "" then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Please enter a description for this quality batch.")
	mle_description.SetFocus()
	return FAILURE
end if

string description
description = mle_description.Text

long returnValue
string cycleCountNumber
if	InventoryTrans_Quality.NewHeader(description, cycleCountNumber) = SUCCESS then
	long row, rows
	rows = dw_1.RowCount()
	for	row = 1 to rows
		if	InventoryTrans_Quality.AddObject(cycleCountNumber, dw_1.Object.Serial[row]) <> SUCCESS then
			rollback using SQLCA;
			return FAILURE
		end if
	next
	if	InventoryTrans_Quality.Begin(cycleCountNumber) = SUCCESS then
		commit using SQLCA;
		return SUCCESS
	end if
end if
rollback using SQLCA;
return FAILURE

end function

on u_tabpg_inventory_quality_newheader.create
int iCurrent
call super::create
this.dw_headercriteria=create dw_headercriteria
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_preview=create cb_preview
this.cb_editquery=create cb_editquery
this.st_1=create st_1
this.mle_description=create mle_description
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_headercriteria
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_preview
this.Control[iCurrent+5]=this.cb_editquery
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.mle_description
this.Control[iCurrent+8]=this.gb_2
end on

on u_tabpg_inventory_quality_newheader.destroy
call super::destroy
destroy(this.dw_headercriteria)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_preview)
destroy(this.cb_editquery)
destroy(this.st_1)
destroy(this.mle_description)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_cancel.X + cb_cancel.Width + (cb_cancel.X - (gb_1.X + gb_1.Width)), gb_2.Y + gb_2.Height)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(cb_ok, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)
inv_Resize.of_Register(gb_2, 0, 100, 100, 0)
inv_Resize.of_Register(mle_description, 0, 100, 100, 0)

st_1.of_Register(gb_1, st_1.ABOVE)
st_1.of_Register(dw_1, st_1.ABOVE)
st_1.of_Register(gb_2, st_1.BELOW)
st_1.of_Register(mle_description, st_1.BELOW)

InventoryTrans_Quality = create n_cst_inventorytrans_quality

end event

event destructor;call super::destructor;
destroy InventoryTrans_Quality

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_quality_newheader
integer x = 978
integer y = 4
integer width = 2039
integer height = 1088
integer taborder = 0
string text = "Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_quality_newheader
integer x = 987
integer y = 84
integer width = 2021
integer height = 1000
integer taborder = 20
string dataobject = "d_quality_inventorylist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetQueryMode(true)
inv_QueryMode.of_SetRetrieveOnDisabled(false)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
if	not dw_1.inv_QueryMode.of_GetEnabled() then
	dw_1.SetRedraw(false)
	dw_1.Object.DataWindow.QueryMode = "yes"
	dw_1.Object.DataWindow.QueryClear = "yes"
	
	string	criteria
	choose case dw_headercriteria.Object.Selector[1]
		case "S"
			criteria = isnull(String(dw_headercriteria.Object.Serial[1]), "") + "~t~t~t~t"
		case "PS"
			criteria = "~t" + isnull(String(dw_headercriteria.Object.PalletSerial[1]), "") + "~t~t~t"
		case "P"
			criteria = "~t~t" + isnull(dw_headercriteria.Object.Part[1], "") + "~t~t"
		case "L"
			criteria = "~t~t~t" + isnull(dw_headercriteria.Object.Location[1], "") + "~t"
		case else
			criteria = "~t~t~t~t"
	end choose
	
	if	dw_headercriteria.Object.ChoosePlant[1] = "Y" then
		criteria += dw_headercriteria.Object.Plant[1]
	end if
	
	choose case dw_headercriteria.Object.Selector[1]
		case "V"
			criteria += "~t~t~t~t" + isnull(dw_headercriteria.Object.Shipper[1], "") +  "~t~t"
		case else
			criteria += "~t~t~t~t~t~t"
	end choose
	
	dw_1.ImportString(criteria)
	dw_1.Object.DataWindow.QueryMode = "no"
	dw_1.SetRedraw(true)
end if

post Retrieve()
return SUCCESS

end event

type dw_headercriteria from u_fxdw within u_tabpg_inventory_quality_newheader
integer width = 969
integer height = 1428
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_quality_newheader"
boolean vscrollbar = false
end type

event constructor;call super::constructor;
of_SetRowSelect(false)
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_ok from commandbutton within u_tabpg_inventory_quality_newheader
integer x = 3058
integer y = 44
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
end type

event clicked;
if	SaveNewHeader() <> SUCCESS then
	return
end if

Reset()

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.EndNewHeader()

end event

type cb_cancel from commandbutton within u_tabpg_inventory_quality_newheader
integer x = 3058
integer y = 224
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
Reset()

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.CancelNewHeader()

end event

type cb_preview from commandbutton within u_tabpg_inventory_quality_newheader
integer x = 526
integer y = 1440
integer width = 425
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Preview >>"
end type

event clicked;
dw_headercriteria.AcceptText()
dw_1.event pfc_Retrieve()

end event

type cb_editquery from commandbutton within u_tabpg_inventory_quality_newheader
boolean visible = false
integer x = 526
integer y = 1572
integer width = 425
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Edit Query >>"
end type

event clicked;
if	dw_1.Object.DataWindow.QueryMode = "yes" then
	dw_1.Object.DataWindow.QueryMode = "no"
else
	dw_1.Object.DataWindow.QueryMode = "yes"
end if


end event

type st_1 from u_st_splitbar within u_tabpg_inventory_quality_newheader
integer x = 978
integer y = 1092
integer width = 2039
boolean bringtotop = true
end type

type mle_description from multilineedit within u_tabpg_inventory_quality_newheader
integer x = 983
integer y = 1192
integer width = 2025
integer height = 316
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 134217741
string text = "Type description here..."
boolean border = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
end type

event getfocus;
if	Text = DESCRIPTION_INST then
	Text = ""
	Italic = false
	TextColor = 33554432
end if
end event

event losefocus;
if	Trim(Text) = "" then
	Text = DESCRIPTION_INST
	Italic = true
	TextColor = 134217741
end if

end event

type gb_2 from groupbox within u_tabpg_inventory_quality_newheader
integer x = 978
integer y = 1116
integer width = 2039
integer height = 400
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Description"
end type

