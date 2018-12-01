$PBExportHeader$u_tabpg_mrp_purchasing_contracts.sru
forward
global type u_tabpg_mrp_purchasing_contracts from u_tabpg_dw
end type
type cb_2 from commandbutton within u_tabpg_mrp_purchasing_contracts
end type
type cb_3 from commandbutton within u_tabpg_mrp_purchasing_contracts
end type
type cb_1 from commandbutton within u_tabpg_mrp_purchasing_contracts
end type
end forward

global type u_tabpg_mrp_purchasing_contracts from u_tabpg_dw
integer width = 2523
cb_2 cb_2
cb_3 cb_3
cb_1 cb_1
end type
global u_tabpg_mrp_purchasing_contracts u_tabpg_mrp_purchasing_contracts

type variables

Private:
//	Controller reference.
n_mrp_purchasing_controller _myController

end variables

forward prototypes
public function integer updatepos ()
public function integer generateposchedule ()
end prototypes

public function integer updatepos ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	poNumber
		poNumber = dw_1.Object.DefaultPONumber[i]
		
		_myController.UpdatePO(poNumber)
	end if
next

return SUCCESS

end function

public function integer generateposchedule ();
if	not IsValid(_myController) then return FAILURE

return _myController.GeneratePOSchedule()


end function

on u_tabpg_mrp_purchasing_contracts.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_1
end on

on u_tabpg_mrp_purchasing_contracts.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mrp_purchasing_contracts
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mrp_purchasing_contracts
string dataobject = "d_mrp_purchasingcontracts"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) then return

long poNumber
if	activeRow <= 0 or activeRow > RowCount() then
	SetNull(poNumber)
else
	poNumber = Object.DefaultPONumber[activerow]
end if

_myController.SetPONumber(poNumber)


end event

type cb_2 from commandbutton within u_tabpg_mrp_purchasing_contracts
integer x = 1806
integer y = 136
integer width = 681
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate New Schedule"
end type

event clicked;
GeneratePOSchedule()

end event

type cb_3 from commandbutton within u_tabpg_mrp_purchasing_contracts
integer x = 1806
integer y = 264
integer width = 681
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Update Selected POs"
end type

event clicked;
UpdatePOs()

end event

type cb_1 from commandbutton within u_tabpg_mrp_purchasing_contracts
integer x = 1806
integer y = 8
integer width = 681
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save Contract Changes"
end type

event clicked;
dw_1.AcceptText()
if	dw_1.Update() = SUCCESS then
	SQLCA.of_Commit()
	Refreshing = true
	Refresh()
else
	SQLCA.of_Rollback()
end if


end event

