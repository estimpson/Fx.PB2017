$PBExportHeader$w_custom_volkswagenloafdetails.srw
forward
global type w_custom_volkswagenloafdetails from w_sheet_4t
end type
type cb_save from commandbutton within w_custom_volkswagenloafdetails
end type
type cb_delete from commandbutton within w_custom_volkswagenloafdetails
end type
type cb_add from commandbutton within w_custom_volkswagenloafdetails
end type
type dw_1 from u_fxdw within w_custom_volkswagenloafdetails
end type
end forward

global type w_custom_volkswagenloafdetails from w_sheet_4t
integer width = 2953
string title = "Volkswagen Loaf Details"
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
dw_1 dw_1
end type
global w_custom_volkswagenloafdetails w_custom_volkswagenloafdetails

on w_custom_volkswagenloafdetails.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.dw_1
end on

on w_custom_volkswagenloafdetails.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_add.X - (dw_1.X + dw_1.Width) + cb_add.X + cb_add.Width, dw_1.Width)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(cb_add, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)


end event

type cb_save from commandbutton within w_custom_volkswagenloafdetails
integer x = 2446
integer y = 284
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;dw_1.AcceptText()
dw_1.Update()

end event

type cb_delete from commandbutton within w_custom_volkswagenloafdetails
integer x = 2446
integer y = 152
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete"
end type

event clicked;dw_1.DeleteRow(dw_1.GetRow())

end event

type cb_add from commandbutton within w_custom_volkswagenloafdetails
integer x = 2446
integer y = 20
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Add"
end type

event clicked;dw_1.InsertRow(0)

end event

type dw_1 from u_fxdw within w_custom_volkswagenloafdetails
integer width = 2354
integer height = 1244
integer taborder = 10
string dataobject = "d_custom_volkswagenloafdetails"
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
Retrieve()

end event

event updateend;call super::updateend;
commit using SQLCA  ;

end event

