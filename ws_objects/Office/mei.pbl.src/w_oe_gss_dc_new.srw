$PBExportHeader$w_oe_gss_dc_new.srw
forward
global type w_oe_gss_dc_new from Window
end type
type pb_1 from picturebutton within w_oe_gss_dc_new
end type
type st_3 from statictext within w_oe_gss_dc_new
end type
type sle_1 from singlelineedit within w_oe_gss_dc_new
end type
type st_2 from statictext within w_oe_gss_dc_new
end type
type st_1 from statictext within w_oe_gss_dc_new
end type
type gb_3 from groupbox within w_oe_gss_dc_new
end type
type gb_2 from groupbox within w_oe_gss_dc_new
end type
type gb_1 from groupbox within w_oe_gss_dc_new
end type
end forward

global type w_oe_gss_dc_new from Window
int X=5
int Y=9
int Width=2894
int Height=1877
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
pb_1 pb_1
st_3 st_3
sle_1 sle_1
st_2 st_2
st_1 st_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_oe_gss_dc_new w_oe_gss_dc_new

on w_oe_gss_dc_new.create
this.pb_1=create pb_1
this.st_3=create st_3
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.pb_1,&
this.st_3,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_oe_gss_dc_new.destroy
destroy(this.pb_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type pb_1 from picturebutton within w_oe_gss_dc_new
int X=586
int Y=321
int Width=110
int Height=65
int TabOrder=50
string Text="none"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_oe_gss_dc_new
int X=37
int Y=257
int Width=2597
int Height=65
boolean Enabled=false
string Text="Dates across the Top  Days, Weeks"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_oe_gss_dc_new
int X=37
int Y=129
int Width=439
int Height=97
int TabOrder=10
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_oe_gss_dc_new
int X=37
int Y=33
int Width=421
int Height=73
boolean Enabled=false
string Text="This Order Qty "
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_oe_gss_dc_new
int X=549
int Y=33
int Width=2195
int Height=193
boolean Enabled=false
string Text="Part Info, Part, Name, Type, Unit, Package, Price"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_oe_gss_dc_new
int X=37
int Y=1105
int Width=2634
int Height=481
int TabOrder=40
string Text="Part Status"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_oe_gss_dc_new
int X=37
int Y=609
int Width=2634
int Height=481
int TabOrder=30
string Text="Display each catagory data"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_oe_gss_dc_new
int X=37
int Y=385
int Width=2634
int Height=225
int TabOrder=20
string Text="Available Grid Global"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

