$PBExportHeader$w_printzoom.srw
$PBExportComments$Control Print Preview on a datawindow objects
forward
global type w_printzoom from Window
end type
type em_custom from editmask within w_printzoom
end type
type pb_cancel_preview from picturebutton within w_printzoom
end type
type cbx_rulers from checkbox within w_printzoom
end type
type st_percent from statictext within w_printzoom
end type
type cb_ok from commandbutton within w_printzoom
end type
type cb_cancel from commandbutton within w_printzoom
end type
type rb_custom from radiobutton within w_printzoom
end type
type rb_30 from radiobutton within w_printzoom
end type
type rb_65 from radiobutton within w_printzoom
end type
type rb_100 from radiobutton within w_printzoom
end type
type rb_200 from radiobutton within w_printzoom
end type
type gb_1 from groupbox within w_printzoom
end type
end forward

global type w_printzoom from Window
int X=828
int Y=529
int Width=1221
int Height=721
boolean TitleBar=true
string Title="Print Preview"
long BackColor=12632256
em_custom em_custom
pb_cancel_preview pb_cancel_preview
cbx_rulers cbx_rulers
st_percent st_percent
cb_ok cb_ok
cb_cancel cb_cancel
rb_custom rb_custom
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
gb_1 gb_1
end type
global w_printzoom w_printzoom

type variables
//int ii_zoom
datawindow idw_dw
end variables

on open;string tmp

idw_dw = message.powerobjectparm

tmp = idw_dw.Describe('DataWindow.Print.Preview DataWindow.Print.Preview.rulers DataWindow.Print.Preview.Zoom')
pb_cancel_preview.enabled = ('yes' = f_get_token(tmp,'~n'))
cbx_rulers.checked = ('yes' = f_get_token(tmp,'~n'))
choose case tmp

	case '200'
		rb_200.checked = true
		rb_200.triggerevent(clicked!)

	case '100'
		rb_100.checked = true
		rb_100.triggerevent(clicked!)

	case '65'
		rb_65.checked = true
		rb_65.triggerevent(clicked!)

	case '30'
		rb_30.checked = true
		rb_30.triggerevent(clicked!)

	case else
		rb_custom.checked = true
		em_custom.text = tmp

end choose

end on

on w_printzoom.create
this.em_custom=create em_custom
this.pb_cancel_preview=create pb_cancel_preview
this.cbx_rulers=create cbx_rulers
this.st_percent=create st_percent
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.rb_custom=create rb_custom
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_1=create gb_1
this.Control[]={ this.em_custom,&
this.pb_cancel_preview,&
this.cbx_rulers,&
this.st_percent,&
this.cb_ok,&
this.cb_cancel,&
this.rb_custom,&
this.rb_30,&
this.rb_65,&
this.rb_100,&
this.rb_200,&
this.gb_1}
end on

on w_printzoom.destroy
destroy(this.em_custom)
destroy(this.pb_cancel_preview)
destroy(this.cbx_rulers)
destroy(this.st_percent)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.rb_custom)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_1)
end on

on deactivate;Close ( This )
end on

type em_custom from editmask within w_printzoom
event spun pbm_enchange
int X=417
int Y=453
int Width=234
int Height=89
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean Spin=true
double Increment=5
string MinMax="1~~1000"
string Text="50"
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on spun;rb_custom.checked = true

end on

type pb_cancel_preview from picturebutton within w_printzoom
int X=855
int Y=265
int Width=284
int Height=213
int TabOrder=50
string Text="Cancel &Preview Mode"
VTextAlign VTextAlign=MultiLine!
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;string tmp
tmp = "DataWindow.Print.Preview = no"
setpointer(hourglass!)
idw_dw.Modify(tmp)
close ( parent )	 
end on

type cbx_rulers from checkbox within w_printzoom
int X=755
int Y=517
int Width=453
int Height=73
int TabOrder=40
string Text="Show Rulers"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_percent from statictext within w_printzoom
int X=641
int Y=461
int Width=60
int Height=73
boolean Enabled=false
string Text="%"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_printzoom
int X=855
int Y=33
int Width=284
int Height=97
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;string tmp

tmp = "DataWindow.Print.Preview.Zoom="+em_custom.text+" DataWindow.Print.Preview = yes DataWindow.Print.Preview.rulers = "
if cbx_rulers.checked then 
	tmp = tmp + "yes"
else
	tmp = tmp + 'no'
end if
setpointer(hourglass!)
idw_dw.Modify(tmp)
close ( parent )	 
end on

type cb_cancel from commandbutton within w_printzoom
int X=855
int Y=149
int Width=284
int Height=97
int TabOrder=60
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close ( parent)
end on

type rb_custom from radiobutton within w_printzoom
int X=101
int Y=461
int Width=339
int Height=73
string Text=" C&ustom"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_custom.setfocus()
end on

type rb_30 from radiobutton within w_printzoom
int X=101
int Y=373
int Width=257
int Height=73
string Text=" &30 %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_custom.text = '30'
end on

type rb_65 from radiobutton within w_printzoom
int X=101
int Y=285
int Width=257
int Height=73
string Text=" &65 %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_custom.text = '65'
end on

type rb_100 from radiobutton within w_printzoom
int X=101
int Y=197
int Width=289
int Height=73
string Text="&100 %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_custom.text = '100'
end on

type rb_200 from radiobutton within w_printzoom
int X=101
int Y=109
int Width=275
int Height=73
string Text="&200 %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;em_custom.text = '200'

end on

type gb_1 from groupbox within w_printzoom
int X=42
int Y=33
int Width=686
int Height=553
int TabOrder=10
string Text="Magnification"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

