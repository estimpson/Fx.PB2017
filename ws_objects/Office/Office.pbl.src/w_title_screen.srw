$PBExportHeader$w_title_screen.srw
forward
global type w_title_screen from w_sheet_4t
end type
type p_logo from picture within w_title_screen
end type
end forward

global type w_title_screen from w_sheet_4t
integer width = 3977
integer height = 1964
string title = "Fx"
p_logo p_logo
end type
global w_title_screen w_title_screen

on w_title_screen.create
int iCurrent
call super::create
this.p_logo=create p_logo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_logo
end on

on w_title_screen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_logo)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_Register(p_logo, 50, 75, 0, 0)

end event

type p_logo from picture within w_title_screen
integer x = 1170
integer y = 164
integer width = 2048
integer height = 1496
boolean originalsize = true
string picturename = "New Logo.jpg"
boolean focusrectangle = false
end type

