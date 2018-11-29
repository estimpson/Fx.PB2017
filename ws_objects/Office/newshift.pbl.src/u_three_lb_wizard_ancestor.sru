$PBExportHeader$u_three_lb_wizard_ancestor.sru
forward
global type u_three_lb_wizard_ancestor from u_wizard_ancestor
end type
type st_4 from statictext within u_three_lb_wizard_ancestor
end type
type st_3 from statictext within u_three_lb_wizard_ancestor
end type
type st_2 from statictext within u_three_lb_wizard_ancestor
end type
type st_1 from statictext within u_three_lb_wizard_ancestor
end type
type p_2 from picture within u_three_lb_wizard_ancestor
end type
type p_1 from picture within u_three_lb_wizard_ancestor
end type
type lb_1 from listbox within u_three_lb_wizard_ancestor
end type
type lb_2 from ulb_smart_drag_drop within u_three_lb_wizard_ancestor
end type
type lb_3 from ulb_smart_drag_drop within u_three_lb_wizard_ancestor
end type
end forward

global type u_three_lb_wizard_ancestor from u_wizard_ancestor
int Width=1970
int Height=924
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
p_2 p_2
p_1 p_1
lb_1 lb_1
lb_2 lb_2
lb_3 lb_3
end type
global u_three_lb_wizard_ancestor u_three_lb_wizard_ancestor

on u_three_lb_wizard_ancestor.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.p_2=create p_2
this.p_1=create p_1
this.lb_1=create lb_1
this.lb_2=create lb_2
this.lb_3=create lb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.lb_1
this.Control[iCurrent+8]=this.lb_2
this.Control[iCurrent+9]=this.lb_3
end on

on u_three_lb_wizard_ancestor.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.lb_1)
destroy(this.lb_2)
destroy(this.lb_3)
end on

type st_4 from statictext within u_three_lb_wizard_ancestor
int X=1335
int Y=300
int Width=494
int Height=72
boolean Enabled=false
string Text="Title 3:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_three_lb_wizard_ancestor
int X=631
int Y=300
int Width=494
int Height=72
boolean Enabled=false
string Text="Title 2:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_three_lb_wizard_ancestor
int X=73
int Y=300
int Width=494
int Height=72
boolean Enabled=false
string Text="Title 1:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_three_lb_wizard_ancestor
int X=439
int Y=28
int Width=1390
int Height=244
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_2 from picture within u_three_lb_wizard_ancestor
int X=1152
int Y=464
int Width=160
int Height=100
string PictureName="rightlow.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_1 from picture within u_three_lb_wizard_ancestor
int X=1152
int Y=604
int Width=160
int Height=100
string PictureName="leftlow.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type lb_1 from listbox within u_three_lb_wizard_ancestor
int X=78
int Y=384
int Width=494
int Height=360
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_2 from ulb_smart_drag_drop within u_three_lb_wizard_ancestor
int X=626
int Y=384
int Width=494
int Height=360
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type lb_3 from ulb_smart_drag_drop within u_three_lb_wizard_ancestor
int X=1326
int Y=384
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

