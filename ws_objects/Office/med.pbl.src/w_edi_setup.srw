$PBExportHeader$w_edi_setup.srw
$PBExportComments$EDI Setup
forward
global type w_edi_setup from Window
end type
type cb_2 from commandbutton within w_edi_setup
end type
type cb_1 from commandbutton within w_edi_setup
end type
type dw_edi from datawindow within w_edi_setup
end type
type gb_1 from groupbox within w_edi_setup
end type
end forward

global type w_edi_setup from Window
int X=668
int Y=393
int Width=1582
int Height=1129
boolean TitleBar=true
string Title="EDI Information Setup"
long BackColor=12632256
boolean Resizable=true
WindowType WindowType=popup!
cb_2 cb_2
cb_1 cb_1
dw_edi dw_edi
gb_1 gb_1
end type
global w_edi_setup w_edi_setup

on open;//**************************************************************************
//* Author				: Jim Wu
//* Start Date			: 1/26/94
//* Customer   		: All
//* Monitor Ver		: 3.0
//* Development Tool	: PowerBuilder 3.0 / Watcom SQL
//* Description      : EDI Setup
//************************************************************************
//* Declaration
//************************************************************************

Long iOrder			//The current sales order

dw_edi.SetTransObject(sqlca)

//************************************************************************
//* Initialization
//************************************************************************

iOrder	= Message.DoubleParm
dw_edi.SetTabOrder("line_feed_code", 20)
dw_edi.SetTabOrder("zone_code", 10)
dw_edi.SetTabOrder("Dock_Code", 30)
//************************************************************************
//* Main Routine
//************************************************************************

dw_edi.Retrieve(iOrder)






end on

on deactivate;close(this)
end on

on w_edi_setup.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_edi=create dw_edi
this.gb_1=create gb_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_edi,&
this.gb_1}
end on

on w_edi_setup.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_edi)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_edi_setup
int X=1130
int Y=833
int Width=257
int Height=129
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)
end on

type cb_1 from commandbutton within w_edi_setup
int X=842
int Y=833
int Width=257
int Height=129
int TabOrder=20
string Text="&Save"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_edi.Update() > 0 then
	Commit;
	Close(Parent)
Else
	Rollback;
End If


end on

type dw_edi from datawindow within w_edi_setup
int X=330
int Y=217
int Width=842
int Height=417
int TabOrder=10
string DataObject="dw_order_edi_setup"
boolean Border=false
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_edi_setup
int X=147
int Y=65
int Width=1244
int Height=641
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

