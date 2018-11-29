$PBExportHeader$w_pricing_main.srw
forward
global type w_pricing_main from w_sheet_4t
end type
type st_1 from statictext within w_pricing_main
end type
end forward

global type w_pricing_main from w_sheet_4t
integer height = 1560
string title = "Customer Pricing"
string menuname = "m_pricing_main"
st_1 st_1
end type
global w_pricing_main w_pricing_main

on w_pricing_main.create
int iCurrent
call super::create
if this.MenuName = "m_pricing_main" then this.MenuID = create m_pricing_main
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_pricing_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

type st_1 from statictext within w_pricing_main
integer x = 370
integer y = 384
integer width = 2130
integer height = 616
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Customer Pricing"
alignment alignment = center!
boolean focusrectangle = false
end type

