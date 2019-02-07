HA$PBExportHeader$w_mes_main.srw
forward
global type w_mes_main from w_sheet_4t
end type
type st_title from statictext within w_mes_main
end type
end forward

global type w_mes_main from w_sheet_4t
integer x = 214
integer y = 221
string title = "MES"
st_title st_title
end type
global w_mes_main w_mes_main

on w_mes_main.create
int iCurrent
call super::create
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
end on

on w_mes_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_title)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_Register(st_title, 0, 0, 100, 0)

end event

type st_title from statictext within w_mes_main
integer width = 2455
integer height = 320
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217737
long backcolor = 134217730
string text = "Manufacturing Execution System"
alignment alignment = center!
boolean focusrectangle = false
end type

