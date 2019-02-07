HA$PBExportHeader$u_tabpg_shipping_expeditecodes_setup.sru
forward
global type u_tabpg_shipping_expeditecodes_setup from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_shipping_expeditecodes_setup
end type
type cb_delete from commandbutton within u_tabpg_shipping_expeditecodes_setup
end type
type cb_save from commandbutton within u_tabpg_shipping_expeditecodes_setup
end type
end forward

global type u_tabpg_shipping_expeditecodes_setup from u_tabpg_dw
integer width = 2519
cb_new cb_new
cb_delete cb_delete
cb_save cb_save
end type
global u_tabpg_shipping_expeditecodes_setup u_tabpg_shipping_expeditecodes_setup

type variables

Private:

//	Controller reference.
n_shipping_expeditecodes_controller _myController

//	Model data.

end variables

on u_tabpg_shipping_expeditecodes_setup.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_save
end on

on u_tabpg_shipping_expeditecodes_setup.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.cb_save)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_expeditecodes_setup
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_expeditecodes_setup
string dataobject = "d_shipping_expeditecodes_setup"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::updateend;call super::updateend;
commit using SQLCA  ;

end event

type cb_new from commandbutton within u_tabpg_shipping_expeditecodes_setup
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
string text = "New Code"
end type

event clicked;
dw_1.SetRow(dw_1.InsertRow(0))

end event

type cb_delete from commandbutton within u_tabpg_shipping_expeditecodes_setup
integer x = 1806
integer y = 136
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete"
end type

event clicked;
long procResult
long selectedRow = 0

int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = UpperBound(selectedRows) to 1 step -1
	if	selectedRows[i] = 1 then
		dw_1.DeleteRow(i)
	end if
next



end event

type cb_save from commandbutton within u_tabpg_shipping_expeditecodes_setup
integer x = 1806
integer y = 264
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;
dw_1.AcceptText()
dw_1.Update(true)

end event

