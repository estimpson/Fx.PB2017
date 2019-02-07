HA$PBExportHeader$u_tabpg_partmaster_customfields.sru
forward
global type u_tabpg_partmaster_customfields from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_partmaster_customfields
end type
end forward

global type u_tabpg_partmaster_customfields from u_tabpg_dw
integer width = 2427
cb_new cb_new
end type
global u_tabpg_partmaster_customfields u_tabpg_partmaster_customfields

type variables

public:
string CustomFieldName

end variables
forward prototypes
public function integer newcustomfield ()
end prototypes

public function integer newcustomfield ();
return dw_1.InsertRow(0)

end function

on u_tabpg_partmaster_customfields.create
int iCurrent
call super::create
this.cb_new=create cb_new
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
end on

on u_tabpg_partmaster_customfields.destroy
call super::destroy
destroy(this.cb_new)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_customfields
string text = "Custom Fields"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_customfields
string dataobject = "d_dbo_partmaster_customfields"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_customfields_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

if	activeRow <= 0 or activeRow > RowCount() then
	CustomFieldName = ""
	myController.SetCustomFieldName(CustomFieldName)
	return
end if
CustomFieldName = Object.CustomFieldName[activeRow]
myController.SetCustomFieldName(CustomFieldName)

end event

event dw_1::updateend;call super::updateend;
//	Commit changes.
commit using sqlca  ;

end event

type cb_new from commandbutton within u_tabpg_partmaster_customfields
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New Field"
end type

event clicked;
NewCustomField()

end event

