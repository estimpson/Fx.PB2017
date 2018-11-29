$PBExportHeader$w_ei_issues.srw
$PBExportComments$updated on 5/23
forward
global type w_ei_issues from Window
end type
type rb_4 from radiobutton within w_ei_issues
end type
type rb_3 from radiobutton within w_ei_issues
end type
type rb_2 from radiobutton within w_ei_issues
end type
type cb_3 from commandbutton within w_ei_issues
end type
type rb_1 from radiobutton within w_ei_issues
end type
type cb_2 from commandbutton within w_ei_issues
end type
type cb_1 from commandbutton within w_ei_issues
end type
type dw_2 from datawindow within w_ei_issues
end type
type dw_1 from datawindow within w_ei_issues
end type
end forward

global type w_ei_issues from Window
int X=10
int Y=21
int Width=2890
int Height=1885
boolean TitleBar=true
string Title="Issues"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
cb_3 cb_3
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_ei_issues w_ei_issues

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )

end on

on w_ei_issues.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.cb_3=create cb_3
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.rb_4,&
this.rb_3,&
this.rb_2,&
this.cb_3,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_ei_issues.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.cb_3)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type rb_4 from radiobutton within w_ei_issues
int X=2218
int Y=1169
int Width=618
int Height=65
string Text="Issues by Product"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_issue_product"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_issues
int X=2218
int Y=1265
int Width=641
int Height=65
string Text="Issues by Catagory"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_issue_pie"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_issues
int X=2218
int Y=1073
int Width=590
int Height=65
string Text="Issues by Day"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_2.dataObject	= "dw_ei_issue_trend_day"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()

end on

type cb_3 from commandbutton within w_ei_issues
int X=2222
int Y=1465
int Width=458
int Height=109
int TabOrder=50
string Text="Performance"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_defects_3)
end on

type rb_1 from radiobutton within w_ei_issues
int X=2218
int Y=977
int Width=599
int Height=65
string Text="Issues by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_2.dataObject	= "dw_ei_issue_trend"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()

end on

type cb_2 from commandbutton within w_ei_issues
int X=2218
int Y=1337
int Width=458
int Height=117
int TabOrder=40
string Text="Issue Status"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_issues_2)
end on

type cb_1 from commandbutton within w_ei_issues
int X=2222
int Y=1601
int Width=604
int Height=89
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

type dw_2 from datawindow within w_ei_issues
int X=19
int Y=21
int Width=2798
int Height=929
int TabOrder=10
string DataObject="dw_ei_issue_trend"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_ei_issues
int X=23
int Y=961
int Width=2186
int Height=641
int TabOrder=20
string DataObject="dw_ei_issue_pie"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

