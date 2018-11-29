$PBExportHeader$w_zoom.srw
forward
global type w_zoom from Window
end type
type st_1 from statictext within w_zoom
end type
type em_1 from editmask within w_zoom
end type
type rb_5 from radiobutton within w_zoom
end type
type rb_4 from radiobutton within w_zoom
end type
type rb_3 from radiobutton within w_zoom
end type
type rb_2 from radiobutton within w_zoom
end type
type rb_1 from radiobutton within w_zoom
end type
type cb_3 from commandbutton within w_zoom
end type
type cb_2 from commandbutton within w_zoom
end type
type cb_1 from commandbutton within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
end forward

global type w_zoom from Window
int X=833
int Y=361
int Width=1047
int Height=821
boolean TitleBar=true
string Title="Report Zoom"
long BackColor=79741120
WindowType WindowType=response!
st_1 st_1
em_1 em_1
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_zoom w_zoom

type variables
INTEGER	i_i_zoom
end variables

on w_zoom.create
this.st_1=create st_1
this.em_1=create em_1
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={ this.st_1,&
this.em_1,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.gb_1}
end on

on w_zoom.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;i_i_zoom = Message.DoubleParm

CHOOSE CASE i_i_zoom
	CASE 200
		rb_1.checked = TRUE
	CASE 100
		rb_2.checked = TRUE	
	CASE 65
		rb_3.checked = TRUE
	CASE 30
		rb_4.checked = TRUE
	CASE ELSE
		rb_5.checked = TRUE
		rb_5.PostEvent ( Clicked! )
END CHOOSE
end event

type st_1 from statictext within w_zoom
int X=545
int Y=533
int Width=78
int Height=77
boolean Enabled=false
string Text="%"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_zoom
int X=398
int Y=505
int Width=147
int Height=101
int TabOrder=5
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
string DisplayData="@"
string Text="100"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;i_i_zoom = Integer ( text )
end event

type rb_5 from radiobutton within w_zoom
int X=92
int Y=533
int Width=330
int Height=77
string Text="&Custom"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;em_1.enabled = TRUE
end event

type rb_4 from radiobutton within w_zoom
int X=92
int Y=437
int Width=261
int Height=77
string Text="&30 %"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;em_1.enabled = FALSE
em_1.text = '30'
i_i_zoom = 30
end event

type rb_3 from radiobutton within w_zoom
int X=92
int Y=353
int Width=261
int Height=77
string Text="&65 %"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;em_1.enabled = FALSE
em_1.text = '65'
i_i_zoom = 65
end event

type rb_2 from radiobutton within w_zoom
int X=92
int Y=257
int Width=293
int Height=77
string Text="&100 %"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;em_1.enabled = FALSE
em_1.text = '100'
i_i_zoom = 100
end event

type rb_1 from radiobutton within w_zoom
int X=92
int Y=165
int Width=293
int Height=77
string Text="&200 %"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;em_1.enabled = FALSE
em_1.text = '200'
i_i_zoom = 200
end event

type cb_3 from commandbutton within w_zoom
int X=737
int Y=441
int Width=247
int Height=109
int TabOrder=10
string Text="&Help"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_zoom
int X=737
int Y=205
int Width=247
int Height=109
int TabOrder=20
string Text="Cancel"
boolean Default=true
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type cb_1 from commandbutton within w_zoom
int X=737
int Y=81
int Width=247
int Height=109
int TabOrder=40
string Text="OK"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, i_i_zoom )
end event

type gb_1 from groupbox within w_zoom
int X=46
int Y=37
int Width=631
int Height=645
int TabOrder=30
string Text="Magnification"
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

