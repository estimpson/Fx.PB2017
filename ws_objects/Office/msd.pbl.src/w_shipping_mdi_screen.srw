$PBExportHeader$w_shipping_mdi_screen.srw
forward
global type w_shipping_mdi_screen from w_frame
end type
end forward

global type w_shipping_mdi_screen from w_frame
integer x = 0
integer y = 0
integer width = 2949
integer height = 2016
string menuname = "m_list_of_shippers"
windowstate windowstate = maximized!
long backcolor = 12632256
end type
global w_shipping_mdi_screen w_shipping_mdi_screen

event closequery;call super::closequery;If MessageBox ( monsys.msg_title, "Are you sure you want to exit?", Question!, YesNo!, 1 ) = 2 Then
	return 1
end if

end event

event pfc_postopen;call super::pfc_postopen;
This.title = monsys.title + sqlca.is_Profile
OpenSheet(w_list_of_active_shippers, w_shipping_mdi_screen, 3, Original!)

end event

on w_shipping_mdi_screen.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_list_of_shippers" then this.MenuID = create m_list_of_shippers
end on

on w_shipping_mdi_screen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

