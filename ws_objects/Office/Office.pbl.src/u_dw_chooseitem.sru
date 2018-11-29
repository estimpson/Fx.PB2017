$PBExportHeader$u_dw_chooseitem.sru
forward
global type u_dw_chooseitem from u_dw
end type
end forward

global type u_dw_chooseitem from u_dw
integer width = 1111
integer height = 100
string dataobject = "d_choosestringitem"
boolean vscrollbar = false
boolean border = false
end type
global u_dw_chooseitem u_dw_chooseitem

on u_dw_chooseitem.create
call super::create
end on

on u_dw_chooseitem.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
Retrieve()
of_SetUpdateable(false)

end event

