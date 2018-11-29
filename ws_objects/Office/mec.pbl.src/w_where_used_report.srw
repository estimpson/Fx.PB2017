$PBExportHeader$w_where_used_report.srw
forward
global type w_where_used_report from Window
end type
type cb_1 from commandbutton within w_where_used_report
end type
type dw_1 from datawindow within w_where_used_report
end type
end forward

global type w_where_used_report from Window
int X=1074
int Y=484
int Width=2071
int Height=1468
boolean TitleBar=true
string Title="Where Used Report"
long BackColor=79741120
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_where_used_report w_where_used_report

on w_where_used_report.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_where_used_report.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( Message.StringParm )
end event

type cb_1 from commandbutton within w_where_used_report
int X=1746
int Y=1276
int Width=270
int Height=104
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type dw_1 from datawindow within w_where_used_report
int X=18
int Width=2030
int Height=1248
int TabOrder=10
string DataObject="d_bom_where_used"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

