$PBExportHeader$u_tabpg_packaging_bulk_shiptos.sru
forward
global type u_tabpg_packaging_bulk_shiptos from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_packaging_bulk_shiptos
end type
type cb_2 from commandbutton within u_tabpg_packaging_bulk_shiptos
end type
end forward

global type u_tabpg_packaging_bulk_shiptos from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_packaging_bulk_shiptos u_tabpg_packaging_bulk_shiptos

type variables

Private:
//	Controller reference.
n_packaging_bulk_controller _myController

//	Model data.
string _packageCode


end variables

forward prototypes
public function integer enableshiptos ()
public function integer disableshiptos ()
public function integer setpackagecode (string packagecode)
end prototypes

public function integer enableshiptos ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		string	destinationCode
		destinationCode = dw_1.Object.DestinationCode[i]
		
		_myController.EnableShipTo(_packageCode, destinationCode)
	end if
next

return SUCCESS
end function

public function integer disableshiptos ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		string	destinationCode
		destinationCode = dw_1.Object.DestinationCode[i]
		
		_myController.DisableShipTo(_packageCode, destinationCode)
	end if
next

return SUCCESS
end function

public function integer setpackagecode (string packagecode);
_packageCode = packageCode
return Refresh()

end function

on u_tabpg_packaging_bulk_shiptos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_packaging_bulk_shiptos.destroy
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_packaging_bulk_shiptos
string text = "Ship Tos"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_packaging_bulk_shiptos
string dataobject = "d_packaging_bulktracking_shiptos"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve(_packageCode)

end event

event dw_1::retrieveend;call super::retrieveend;
cb_1.Enabled = (rowcount > 0)
cb_2.Enabled = (rowcount > 0)

end event

type cb_1 from commandbutton within u_tabpg_packaging_bulk_shiptos
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
boolean enabled = false
string text = "Enable"
end type

event clicked;
EnableShipTos()

end event

type cb_2 from commandbutton within u_tabpg_packaging_bulk_shiptos
boolean visible = false
integer x = 1806
integer y = 136
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
boolean enabled = false
string text = "Disable"
end type

event clicked;
DisableShipTos()

end event

