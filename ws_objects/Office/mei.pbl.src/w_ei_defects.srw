$PBExportHeader$w_ei_defects.srw
forward
global type w_ei_defects from Window
end type
type mdi_1 from mdiclient within w_ei_defects
end type
type rb_5 from radiobutton within w_ei_defects
end type
type rb_4 from radiobutton within w_ei_defects
end type
type rb_3 from radiobutton within w_ei_defects
end type
type rb_2 from radiobutton within w_ei_defects
end type
type cb_3 from commandbutton within w_ei_defects
end type
type rb_1 from radiobutton within w_ei_defects
end type
type cb_2 from commandbutton within w_ei_defects
end type
type cb_1 from commandbutton within w_ei_defects
end type
type p_1 from picture within w_ei_defects
end type
type dw_2 from datawindow within w_ei_defects
end type
end forward

global type w_ei_defects from Window
int X=28
int Y=5
int Width=2849
int Height=1885
boolean TitleBar=true
string Title="Defects"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
cb_3 cb_3
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
p_1 p_1
dw_2 dw_2
end type
global w_ei_defects w_ei_defects

event open;//dw_1.settransobject ( sqlca )
//dw_1.Retrieve ( )
dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )

end event

on w_ei_defects.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.cb_3=create cb_3
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_2=create dw_2
this.Control[]={ this.mdi_1,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.cb_3,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.p_1,&
this.dw_2}
end on

on w_ei_defects.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.cb_3)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_2)
end on

type mdi_1 from mdiclient within w_ei_defects
long BackColor=276856960
end type

type rb_5 from radiobutton within w_ei_defects
int X=801
int Y=1521
int Width=787
int Height=65
string Text="Defects by Activity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defects_activity_pie"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_defects
int X=28
int Y=1589
int Width=782
int Height=65
string Text="Defects by Reason"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defects_pie"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_defects
int X=801
int Y=1453
int Width=787
int Height=65
string Text="Defects by Machine"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defects_machine_pie"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_defects
int X=28
int Y=1521
int Width=791
int Height=65
string Text="Defect Total by Day"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defect_trend"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type cb_3 from commandbutton within w_ei_defects
int X=1633
int Y=1549
int Width=659
int Height=113
int TabOrder=40
string Text="&Product Summary"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_defects_3)
end on

type rb_1 from radiobutton within w_ei_defects
int X=28
int Y=1453
int Width=759
int Height=65
string Text="Defect Total by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defect_month"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type cb_2 from commandbutton within w_ei_defects
int X=1633
int Y=1433
int Width=654
int Height=113
int TabOrder=30
string Text="&Today's   Defects "
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_defects_2)
end on

type cb_1 from commandbutton within w_ei_defects
int X=2396
int Y=1493
int Width=289
int Height=149
int TabOrder=20
string Text="&Exit"
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_ei_defects
int X=37
int Y=25
int Width=2725
int Height=1377
string PictureName="qc.wmf"
boolean FocusRectangle=false
end type

type dw_2 from datawindow within w_ei_defects
int X=33
int Y=17
int Width=2743
int Height=1393
int TabOrder=10
string DataObject="dw_ei_defect_trend"
boolean TitleBar=true
string Title="Defect Trend"
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

