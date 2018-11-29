$PBExportHeader$w_fxcop_titlescreen.srw
forward
global type w_fxcop_titlescreen from w_sheet_4t
end type
type p_1 from picture within w_fxcop_titlescreen
end type
end forward

global type w_fxcop_titlescreen from w_sheet_4t
integer width = 4014
integer height = 2812
string title = "Continuos Operations Planning"
long backcolor = 0
p_1 p_1
end type
global w_fxcop_titlescreen w_fxcop_titlescreen

on w_fxcop_titlescreen.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_fxcop_titlescreen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_1)
end on

type p_1 from picture within w_fxcop_titlescreen
integer width = 4681
integer height = 2400
boolean originalsize = true
string picturename = "logoFXCOP.jpg"
boolean focusrectangle = false
end type

