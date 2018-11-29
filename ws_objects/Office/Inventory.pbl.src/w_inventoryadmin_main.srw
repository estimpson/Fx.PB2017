$PBExportHeader$w_inventoryadmin_main.srw
forward
global type w_inventoryadmin_main from w_sheet_4t
end type
type st_title from statictext within w_inventoryadmin_main
end type
end forward

global type w_inventoryadmin_main from w_sheet_4t
string title = "Inventory Administration"
st_title st_title
end type
global w_inventoryadmin_main w_inventoryadmin_main

on w_inventoryadmin_main.create
int iCurrent
call super::create
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
end on

on w_inventoryadmin_main.destroy
call super::destroy
destroy(this.st_title)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_Register(st_title, 0, 0, 100, 0)

end event

type st_title from statictext within w_inventoryadmin_main
integer width = 2450
integer height = 320
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217737
long backcolor = 134217730
string text = "Inventory Admin"
alignment alignment = center!
boolean focusrectangle = false
end type

