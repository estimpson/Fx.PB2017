$PBExportHeader$w_company_info.srw
forward
global type w_company_info from Window
end type
type cb_2 from commandbutton within w_company_info
end type
type cb_1 from commandbutton within w_company_info
end type
type dw_1 from datawindow within w_company_info
end type
end forward

global type w_company_info from Window
int X=691
int Y=421
int Width=1569
int Height=1149
boolean TitleBar=true
string Title="Company Info"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_company_info w_company_info

on open;dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( )
end on

on w_company_info.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_company_info.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_company_info
int X=878
int Y=865
int Width=293
int Height=129
int TabOrder=30
string Text="Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close ( parent )
end on

type cb_1 from commandbutton within w_company_info
int X=403
int Y=865
int Width=293
int Height=129
int TabOrder=20
string Text="Save"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_1.Update ( ) = -1 Then
	RollBack ;
Else 
	Commit ;
End if

close ( Parent )
end on

type dw_1 from datawindow within w_company_info
int X=183
int Y=33
int Width=1463
int Height=833
int TabOrder=10
string DataObject="d_parameters"
boolean Border=false
boolean LiveScroll=true
end type

