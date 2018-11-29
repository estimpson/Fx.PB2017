$PBExportHeader$w_ei_defects_2.srw
$PBExportComments$updated on 5/22
forward
global type w_ei_defects_2 from Window
end type
type mdi_1 from mdiclient within w_ei_defects_2
end type
type rb_2 from radiobutton within w_ei_defects_2
end type
type rb_1 from radiobutton within w_ei_defects_2
end type
type dw_3 from datawindow within w_ei_defects_2
end type
type cb_1 from commandbutton within w_ei_defects_2
end type
type dw_2 from datawindow within w_ei_defects_2
end type
end forward

global type w_ei_defects_2 from Window
int X=19
int Y=17
int Width=2867
int Height=1841
boolean TitleBar=true
string Title="Defects Today"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
rb_2 rb_2
rb_1 rb_1
dw_3 dw_3
cb_1 cb_1
dw_2 dw_2
end type
global w_ei_defects_2 w_ei_defects_2

event open;

dw_2.settransobject ( sqlca )
dw_2.Retrieve ( today() )

dw_3.settransobject ( sqlca )
dw_3.Retrieve ( today() )


end event

on w_ei_defects_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_2=create dw_2
this.Control[]={ this.mdi_1,&
this.rb_2,&
this.rb_1,&
this.dw_3,&
this.cb_1,&
this.dw_2}
end on

on w_ei_defects_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_2)
end on

type mdi_1 from mdiclient within w_ei_defects_2
long BackColor=276856960
end type

type rb_2 from radiobutton within w_ei_defects_2
event clicked pbm_bnclicked
int X=1651
int Y=1565
int Width=586
int Height=73
string Text="Back to Pie Chart"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defects_machine_today"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve(today())

end event

type rb_1 from radiobutton within w_ei_defects_2
int X=1651
int Y=1485
int Width=357
int Height=73
string Text="Bar Chart"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_defect_today"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve(today())

end event

type dw_3 from datawindow within w_ei_defects_2
int X=1591
int Y=25
int Width=1198
int Height=1445
int TabOrder=20
string DataObject="dw_ei_defect_part_today"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_defects_2
int X=2433
int Y=1501
int Width=343
int Height=125
int TabOrder=30
string Text="&Exit"
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_2 from datawindow within w_ei_defects_2
int X=37
int Y=25
int Width=1532
int Height=1585
int TabOrder=10
string DataObject="dw_ei_defects_machine_today"
boolean TitleBar=true
string Title="Today's Defect"
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

