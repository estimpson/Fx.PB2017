$PBExportHeader$u_shipper_header_for_return_to_vendor.sru
forward
global type u_shipper_header_for_return_to_vendor from UserObject
end type
type cb_exit from commandbutton within u_shipper_header_for_return_to_vendor
end type
type cb_save from commandbutton within u_shipper_header_for_return_to_vendor
end type
type dw_shipper_header from datawindow within u_shipper_header_for_return_to_vendor
end type
type gb_1 from groupbox within u_shipper_header_for_return_to_vendor
end type
end forward

global type u_shipper_header_for_return_to_vendor from UserObject
int Width=1925
int Height=1008
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
cb_exit cb_exit
cb_save cb_save
dw_shipper_header dw_shipper_header
gb_1 gb_1
end type
global u_shipper_header_for_return_to_vendor u_shipper_header_for_return_to_vendor

type variables
String szDestination
String szCustomer
String szTerms

Window wHostWindow
end variables

forward prototypes
public subroutine uf_setup (string szvendor, ref window wwin)
end prototypes

public subroutine uf_setup (string szvendor, ref window wwin);dw_shipper_header.SetTransObject(sqlca)

szDestination	= szVendor

dw_shipper_header.InsertRow(1)
dw_shipper_header.SetItem(1, "destination", szDestination)
dw_shipper_header.SetItem(1, "date_stamp", Today())
dw_shipper_header.SetItem(1, "status", "O")
dw_shipper_header.SetItem(1, "type", "R")

wHostWindow	= wWin

end subroutine

on u_shipper_header_for_return_to_vendor.create
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_shipper_header=create dw_shipper_header
this.gb_1=create gb_1
this.Control[]={this.cb_exit,&
this.cb_save,&
this.dw_shipper_header,&
this.gb_1}
end on

on u_shipper_header_for_return_to_vendor.destroy
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_shipper_header)
destroy(this.gb_1)
end on

type cb_exit from commandbutton within u_shipper_header_for_return_to_vendor
int X=1627
int Y=848
int Width=247
int Height=108
int TabOrder=30
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wHostWindow.TriggerEvent("close_uo")
end on

type cb_save from commandbutton within u_shipper_header_for_return_to_vendor
int X=1353
int Y=848
int Width=247
int Height=108
int TabOrder=20
string Text="Save"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wHostWindow.TriggerEvent("save_shipper_header")
end on

type dw_shipper_header from datawindow within u_shipper_header_for_return_to_vendor
int X=55
int Y=144
int Width=1792
int Height=584
int TabOrder=10
string DataObject="dw_shipper_header_info"
boolean Border=false
boolean LiveScroll=true
end type

type gb_1 from groupbox within u_shipper_header_for_return_to_vendor
int X=18
int Y=32
int Width=1865
int Height=800
int TabOrder=40
string Text="Shipper Header Information"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

