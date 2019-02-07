HA$PBExportHeader$u_fxdw_addressedit.sru
forward
global type u_fxdw_addressedit from u_fxdw
end type
end forward

global type u_fxdw_addressedit from u_fxdw
integer width = 4384
integer height = 1256
string dataobject = "d_addresseditx3"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_addressedit u_fxdw_addressedit

on u_fxdw_addressedit.create
call super::create
end on

on u_fxdw_addressedit.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetRowSelect(false)

end event

