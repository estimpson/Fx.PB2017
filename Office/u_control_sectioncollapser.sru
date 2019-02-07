HA$PBExportHeader$u_control_sectioncollapser.sru
forward
global type u_control_sectioncollapser from u_base
end type
type st_1 from statictext within u_control_sectioncollapser
end type
type dw_1 from u_fxdw within u_control_sectioncollapser
end type
type ln_1 from line within u_control_sectioncollapser
end type
type ln_2 from line within u_control_sectioncollapser
end type
end forward

global type u_control_sectioncollapser from u_base
integer width = 1134
integer height = 80
long backcolor = 1073741824
st_1 st_1
dw_1 dw_1
ln_1 ln_1
ln_2 ln_2
end type
global u_control_sectioncollapser u_control_sectioncollapser

type variables

// Model data.
Public:
boolean IsExpanded = false
string TitleText = "Section Title"
int TitleWidth = 823

end variables

forward prototypes
public function integer updateview ()
end prototypes

public function integer updateview ();
if	IsExpanded then
	dw_1.object.IsExpanded[1] = 1
else
	dw_1.object.IsExpanded[1] = 0
end if

return SUCCESS

end function

on u_control_sectioncollapser.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.ln_1
this.Control[iCurrent+4]=this.ln_2
end on

on u_control_sectioncollapser.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event resize;call super::resize;
ln_1.EndX = newwidth
ln_2.EndX = newwidth

end event

type st_1 from statictext within u_control_sectioncollapser
integer x = 187
integer y = 4
integer width = 823
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Section Title"
boolean focusrectangle = false
end type

type dw_1 from u_fxdw within u_control_sectioncollapser
integer x = 5
integer width = 73
integer height = 76
integer taborder = 10
string dataobject = "d_showhidecontrol"
boolean vscrollbar = false
boolean livescroll = false
end type

type ln_1 from line within u_control_sectioncollapser
long linecolor = 134217738
integer linethickness = 4
integer beginx = 123
integer beginy = 36
integer endx = 1115
integer endy = 36
end type

type ln_2 from line within u_control_sectioncollapser
long linecolor = 134217738
integer linethickness = 4
integer beginx = 123
integer beginy = 48
integer endx = 1115
integer endy = 48
end type

