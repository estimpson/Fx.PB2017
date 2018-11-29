$PBExportHeader$w_package_type_part.srw
forward
global type w_package_type_part from Window
end type
type cb_2 from commandbutton within w_package_type_part
end type
type cb_1 from commandbutton within w_package_type_part
end type
type dw_1 from datawindow within w_package_type_part
end type
type gb_1 from groupbox within w_package_type_part
end type
end forward

global type w_package_type_part from Window
int X=672
int Y=264
int Width=1083
int Height=812
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_package_type_part w_package_type_part

type variables
String szPart
end variables

on open;szPart = Message.StringParm

dw_1.SetTransObject ( sqlca )
If dw_1.Retrieve ( szPart ) < 1 Then
	dw_1.InsertRow ( 0 )
	dw_1.SetItem ( 1, "part", szPart )
End if



end on

on w_package_type_part.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_package_type_part.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_package_type_part
int X=439
int Y=580
int Width=256
int Height=96
int TabOrder=30
string Text="&Save"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_1.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
End if

Close ( parent )
Close ( wChain )
end on

type cb_1 from commandbutton within w_package_type_part
int X=731
int Y=580
int Width=256
int Height=96
int TabOrder=20
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
Close ( wChain )

end on

type dw_1 from datawindow within w_package_type_part
int X=73
int Y=64
int Width=878
int Height=384
int TabOrder=10
string DataObject="d_package_type_popup"
boolean Border=false
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_package_type_part
int X=37
int Width=951
int Height=480
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

