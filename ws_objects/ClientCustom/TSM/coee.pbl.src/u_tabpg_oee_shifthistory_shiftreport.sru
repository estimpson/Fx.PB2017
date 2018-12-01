$PBExportHeader$u_tabpg_oee_shifthistory_shiftreport.sru
forward
global type u_tabpg_oee_shifthistory_shiftreport from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_oee_shifthistory_shiftreport
end type
end forward

global type u_tabpg_oee_shifthistory_shiftreport from u_tabpg_dw
integer width = 2309
cb_1 cb_1
end type
global u_tabpg_oee_shifthistory_shiftreport u_tabpg_oee_shifthistory_shiftreport

type variables

Private:
//	Model data.
date _shiftDate
int _shift

//	Controller reference.
n_oee_shifthistory_controller _myController

end variables

forward prototypes
public function integer setshift (date shiftdate, integer shift)
end prototypes

public function integer setshift (date shiftdate, integer shift);
_shiftDate = shiftDate
_shift = shift

return Refresh()


end function

on u_tabpg_oee_shifthistory_shiftreport.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on u_tabpg_oee_shifthistory_shiftreport.destroy
call super::destroy
destroy(this.cb_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_oee_shifthistory_shiftreport
string text = "Report"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_oee_shifthistory_shiftreport
string dataobject = "d_custom_oee_shiftreport"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(datetime(_shiftDate), _shift)

end event

type cb_1 from commandbutton within u_tabpg_oee_shifthistory_shiftreport
integer x = 1806
integer y = 8
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
string text = "Print"
end type

event clicked;dw_1.Print()
end event

