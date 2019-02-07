HA$PBExportHeader$u_tabpg_browser.sru
forward
global type u_tabpg_browser from u_tabpg_4t
end type
type uo_browser from u_browser within u_tabpg_browser
end type
end forward

global type u_tabpg_browser from u_tabpg_4t
integer width = 1977
uo_browser uo_browser
end type
global u_tabpg_browser u_tabpg_browser

on u_tabpg_browser.create
int iCurrent
call super::create
this.uo_browser=create uo_browser
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_browser
end on

on u_tabpg_browser.destroy
call super::destroy
destroy(this.uo_browser)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_1.X + gb_1.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(uo_browser, 0, 0, 100, 100)

end event

type gb_1 from u_tabpg_4t`gb_1 within u_tabpg_browser
string text = "Browser:"
end type

type uo_browser from u_browser within u_tabpg_browser
integer x = 5
integer y = 76
integer width = 1737
integer height = 1000
integer taborder = 20
boolean bringtotop = true
end type

on uo_browser.destroy
call u_browser::destroy
end on

