$PBExportHeader$w_title_screen.srw
forward
global type w_title_screen from w_sheet_4t
end type
type st_suite from statictext within w_title_screen
end type
type p_logo from picture within w_title_screen
end type
type st_title from statictext within w_title_screen
end type
end forward

global type w_title_screen from w_sheet_4t
integer width = 2807
integer height = 1904
string title = "fx"
st_suite st_suite
p_logo p_logo
st_title st_title
end type
global w_title_screen w_title_screen

on w_title_screen.create
int iCurrent
call super::create
this.st_suite=create st_suite
this.p_logo=create p_logo
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_suite
this.Control[iCurrent+2]=this.p_logo
this.Control[iCurrent+3]=this.st_title
end on

on w_title_screen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_suite)
destroy(this.p_logo)
destroy(this.st_title)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_Register(st_suite, 0, 0, 100, 0)
inv_Resize.of_Register(st_title, 0, 0, 100, 0)
inv_Resize.of_Register(p_logo, 50, 75, 0, 0)

end event

type st_suite from statictext within w_title_screen
integer y = 368
integer width = 2807
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Calibri"
boolean italic = true
long textcolor = 31830063
long backcolor = 16777215
boolean enabled = false
string text = "explore your factory         "
alignment alignment = right!
boolean focusrectangle = false
end type

type p_logo from picture within w_title_screen
integer x = 306
integer y = 672
integer width = 2194
integer height = 440
boolean originalsize = true
string picturename = "Bulb.Fore-Thought.bmp"
boolean focusrectangle = false
end type

type st_title from statictext within w_title_screen
integer y = 84
integer width = 2775
integer height = 248
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Calibri"
long textcolor = 134217737
long backcolor = 28468243
boolean enabled = false
string text = "factory explorer  "
alignment alignment = right!
boolean focusrectangle = false
end type

