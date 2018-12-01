$PBExportHeader$u_tabpg_lot_trace_inv_quality_newheader.sru
forward
global type u_tabpg_lot_trace_inv_quality_newheader from u_tabpg_dw
end type
type cb_ok from commandbutton within u_tabpg_lot_trace_inv_quality_newheader
end type
type cb_cancel from commandbutton within u_tabpg_lot_trace_inv_quality_newheader
end type
type st_1 from u_st_splitbar within u_tabpg_lot_trace_inv_quality_newheader
end type
type mle_description from multilineedit within u_tabpg_lot_trace_inv_quality_newheader
end type
type gb_2 from groupbox within u_tabpg_lot_trace_inv_quality_newheader
end type
end forward

global type u_tabpg_lot_trace_inv_quality_newheader from u_tabpg_dw
integer width = 4265
integer height = 1936
string text = "New Cycle Count"
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
mle_description mle_description
gb_2 gb_2
end type
global u_tabpg_lot_trace_inv_quality_newheader u_tabpg_lot_trace_inv_quality_newheader

type variables

Private:
//	Model data.
string _serialList

//	Controller reference.
n_lot_trace_controller _myController

//	Data context.
n_cst_inventorytrans_quality _trans

end variables
forward prototypes
public function integer reset ()
public function integer savenewheader ()
public function integer setseriallist (string seriallist, string description)
end prototypes

public function integer reset ();
dw_1.SetFilter("")
dw_1.Reset()

return SUCCESS

end function

public function integer savenewheader ();
string description
description = mle_description.Text

long returnValue
string qualityBatchNumber
if	_trans.NewHeader(description, qualityBatchNumber) = SUCCESS then
	long row, rows
	rows = dw_1.RowCount()
	for	row = 1 to rows
		if	_trans.AddObject(qualityBatchNumber, dw_1.Object.Serial[row]) <> SUCCESS then
			rollback using SQLCA;
			return FAILURE
		end if
	next
	if	_trans.Begin(qualityBatchNumber) = SUCCESS then
		_trans.CommitTrans()
		return SUCCESS
	end if
end if
rollback using SQLCA;
return FAILURE

end function

public function integer setseriallist (string seriallist, string description);
_serialList = serialList
mle_description.Text = description

return Refresh()

end function

on u_tabpg_lot_trace_inv_quality_newheader.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.mle_description=create mle_description
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.mle_description
this.Control[iCurrent+5]=this.gb_2
end on

on u_tabpg_lot_trace_inv_quality_newheader.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
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

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")
_trans = create n_cst_inventorytrans_quality

end event

event destructor;call super::destructor;
destroy _trans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_lot_trace_inv_quality_newheader
integer x = 5
integer width = 2039
integer height = 1088
integer taborder = 0
string text = "Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_lot_trace_inv_quality_newheader
integer x = 14
integer width = 2021
integer height = 1000
integer taborder = 20
string dataobject = "d_lot_trace_quality_inventorylist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_serialList)

end event

type cb_ok from commandbutton within u_tabpg_lot_trace_inv_quality_newheader
integer x = 2085
integer y = 40
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

if	not IsValid(_myController) or IsNull(_myController) then return

_myController.EndNewQualityBatch()

end event

type cb_cancel from commandbutton within u_tabpg_lot_trace_inv_quality_newheader
integer x = 2085
integer y = 220
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
if	not IsValid(_myController) or IsNull(_myController) then return

_myController.CancelNewQualityBatch()

end event

type st_1 from u_st_splitbar within u_tabpg_lot_trace_inv_quality_newheader
integer x = 5
integer y = 1088
integer width = 2039
boolean bringtotop = true
end type

type mle_description from multilineedit within u_tabpg_lot_trace_inv_quality_newheader
integer x = 9
integer y = 1188
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

type gb_2 from groupbox within u_tabpg_lot_trace_inv_quality_newheader
integer x = 5
integer y = 1112
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

