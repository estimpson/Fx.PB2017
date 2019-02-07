$PBExportHeader$u_tabpg_outproc_maint_headers.sru
forward
global type u_tabpg_outproc_maint_headers from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_outproc_maint_headers
end type
type cb_2 from commandbutton within u_tabpg_outproc_maint_headers
end type
end forward

global type u_tabpg_outproc_maint_headers from u_tabpg_dw
integer width = 2551
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_outproc_maint_headers u_tabpg_outproc_maint_headers

type variables

Private:
//	Controller reference.
n_outproc_maint_controller _myController

end variables

forward prototypes
public function integer newpart ()
public function integer closepart ()
end prototypes

public function integer newpart ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
int returnValue
returnValue = _myController.ShowNewPart()
SetPointer(Arrow!)

return returnValue

end function

public function integer closepart ();
if	not IsValid(_myController) then return FAILURE
int activeRow
activeRow = dw_1.GetRow()
if	activeRow <= 0 or activeRow > dw_1.RowCount() then return NO_ACTION

long OPDefRowID
OPDefRowID = dw_1.Object.RowID[activerow]

SetPointer(HourGlass!)
int returnValue
returnValue = _myController.ClosePart(OPDefRowID)
SetPointer(Arrow!)

return returnValue

end function

on u_tabpg_outproc_maint_headers.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_outproc_maint_headers.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_outproc_maint_headers
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_outproc_maint_headers
string dataobject = "d_outproc_maint_headers"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) then return

n_outproc_definition opDefinition

if	activeRow <= 0 or activeRow > RowCount() then
	SetNull(opDefinition.OPDefRowID)
	_myController.SetActiveOPDefinition(opDefinition)
	return
else
	opDefinition.OPDefRowID = Object.RowID[activerow]
	opDefinition.OutputPart = Object.OutputPart[activerow]
	opDefinition.InputPartList = Object.InputPartList[activerow]
	opDefinition.SupplierCode = Object.SupplierCode[activerow]
	opDefinition.ActiveBlanketPONumber = Object.ActiveBlanketPONumber[activerow]
	opDefinition.IsOutputDropShip = Object.IsOutputDropShip[activerow]
	opDefinition.NextPart = Object.NextPart[activerow]
	opDefinition.ShipToSupplier = Object.ShipToSupplier[activerow]
end if

_myController.SetActiveOPDefinition(opDefinition)

end event

type cb_1 from commandbutton within u_tabpg_outproc_maint_headers
boolean visible = false
integer x = 1806
integer y = 8
integer width = 686
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Add OP Part..."
end type

event clicked;
NewPart()


end event

type cb_2 from commandbutton within u_tabpg_outproc_maint_headers
boolean visible = false
integer x = 1806
integer y = 136
integer width = 686
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Close OP Part..."
end type

event clicked;
ClosePart()

end event

