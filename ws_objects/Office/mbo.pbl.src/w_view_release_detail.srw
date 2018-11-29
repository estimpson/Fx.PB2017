$PBExportHeader$w_view_release_detail.srw
forward
global type w_view_release_detail from Window
end type
type cb_1 from commandbutton within w_view_release_detail
end type
type dw_1 from datawindow within w_view_release_detail
end type
end forward

global type w_view_release_detail from Window
int X=394
int Y=589
int Width=2167
int Height=1049
boolean TitleBar=true
string Title="Release/Order Detail"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=popup!
cb_1 cb_1
dw_1 dw_1
end type
global w_view_release_detail w_view_release_detail

on open;String szPart

dw_1.SetTransObject(sqlca)

szPart	= Message.StringParm

dw_1.Retrieve(szPart)
end on

on deactivate;close(this)
end on

on w_view_release_detail.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_view_release_detail.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_view_release_detail
int X=1683
int Y=769
int Width=247
int Height=109
int TabOrder=20
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type dw_1 from datawindow within w_view_release_detail
int X=51
int Y=85
int Width=2058
int Height=645
int TabOrder=10
string DataObject="dw_view_releases_by_part"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

