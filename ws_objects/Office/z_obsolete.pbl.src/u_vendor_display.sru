$PBExportHeader$u_vendor_display.sru
$PBExportComments$(mrs) Added the po info
forward
global type u_vendor_display from UserObject
end type
type st_info from statictext within u_vendor_display
end type
type st_vendor_code from statictext within u_vendor_display
end type
type p_1 from picture within u_vendor_display
end type
end forward

global type u_vendor_display from UserObject
int Width=475
int Height=132
boolean Border=true
long BackColor=77897888
long PictureMaskColor=25166016
long TabBackColor=67108864
event ue_dragdrop pbm_custom01
st_info st_info
st_vendor_code st_vendor_code
p_1 p_1
end type
global u_vendor_display u_vendor_display

type variables
long ii_ptr
end variables

on ue_dragdrop;parent.triggerevent( 'ue_dragdrop_to_vendor', 0, ii_ptr )
end on

on dragdrop;this.triggerevent( 'ue_dragdrop' )
end on

on u_vendor_display.create
this.st_info=create st_info
this.st_vendor_code=create st_vendor_code
this.p_1=create p_1
this.Control[]={this.st_info,&
this.st_vendor_code,&
this.p_1}
end on

on u_vendor_display.destroy
destroy(this.st_info)
destroy(this.st_vendor_code)
destroy(this.p_1)
end on

type st_info from statictext within u_vendor_display
int X=91
int Y=80
int Width=366
int Height=48
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_vendor_code from statictext within u_vendor_display
int X=91
int Y=16
int Width=366
int Height=48
boolean Enabled=false
string Text="Vendor"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on dragdrop;parent.triggerevent( 'ue_dragdrop' )
end on

type p_1 from picture within u_vendor_display
int Width=91
int Height=76
boolean Enabled=false
string PictureName="vendor.bmp"
boolean FocusRectangle=false
end type

on dragdrop;parent.triggerevent( 'ue_dragdrop' )
end on

