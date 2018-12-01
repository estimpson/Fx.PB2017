$PBExportHeader$u_tabpg_lot_trace_receipthistory.sru
forward
global type u_tabpg_lot_trace_receipthistory from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_lot_trace_receipthistory
end type
type cb_2 from commandbutton within u_tabpg_lot_trace_receipthistory
end type
type dw_2 from u_fxdw within u_tabpg_lot_trace_receipthistory
end type
end forward

global type u_tabpg_lot_trace_receipthistory from u_tabpg_dw
integer width = 2309
integer height = 1612
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
end type
global u_tabpg_lot_trace_receipthistory u_tabpg_lot_trace_receipthistory

type variables

Private:
//	Controller reference.
n_lot_trace_controller _myController

end variables

forward prototypes
public function integer func1 ()
public function integer func2 ()
end prototypes

public function integer func1 ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
//_myController.func1()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer func2 ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	someValue
		someValue = dw_1.Object.SomeValue[i]
		
		//_myController.Func2(someValue)
	end if
next

return SUCCESS
end function

on u_tabpg_lot_trace_receipthistory.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
end on

on u_tabpg_lot_trace_receipthistory.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_lot_trace_receipthistory
integer y = 460
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_lot_trace_receipthistory
integer y = 540
string dataobject = "{d_list}"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve()

end event

type cb_1 from commandbutton within u_tabpg_lot_trace_receipthistory
integer x = 1806
integer y = 468
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "func1"
end type

event clicked;func1()

end event

type cb_2 from commandbutton within u_tabpg_lot_trace_receipthistory
integer x = 1806
integer y = 596
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "func2"
end type

event clicked;func2()

end event

type dw_2 from u_fxdw within u_tabpg_lot_trace_receipthistory
integer y = 16
integer width = 2277
integer height = 396
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_lot_trace_searchreceipthistory"
boolean vscrollbar = false
end type

