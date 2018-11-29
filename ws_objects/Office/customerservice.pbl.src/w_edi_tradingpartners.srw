$PBExportHeader$w_edi_tradingpartners.srw
forward
global type w_edi_tradingpartners from w_sheet_panel_4t
end type
type st_1 from statictext within w_edi_tradingpartners
end type
end forward

global type w_edi_tradingpartners from w_sheet_panel_4t
integer x = 214
integer y = 221
st_1 st_1
end type
global w_edi_tradingpartners w_edi_tradingpartners

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)

//	Too many false positives...
//of_SetUpdateable(true)

end event

on w_edi_tradingpartners.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_edi_tradingpartners.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

type uo_1 from w_sheet_panel_4t`uo_1 within w_edi_tradingpartners
integer height = 1160
end type

type st_1 from statictext within w_edi_tradingpartners
integer y = 1176
integer width = 2130
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx EDI - Trading Partner Setup 1.0  "
alignment alignment = right!
boolean focusrectangle = false
end type

