$PBExportHeader$u_addressdropdown.sru
forward
global type u_addressdropdown from u_customdropdowncontrol
end type
type dw_1 from u_fxdw_addressedit within u_addressdropdown
end type
end forward

global type u_addressdropdown from u_customdropdowncontrol
integer width = 4425
integer height = 1324
dw_1 dw_1
end type
global u_addressdropdown u_addressdropdown

event constructor;call super::constructor;
post Resize(dw_1.width, dw_1.height)

end event

on u_addressdropdown.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_addressdropdown.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_fxdw_addressedit within u_addressdropdown
integer taborder = 10
end type

