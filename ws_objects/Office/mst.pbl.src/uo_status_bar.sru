$PBExportHeader$uo_status_bar.sru
forward
global type uo_status_bar from UserObject
end type
type st_status from statictext within uo_status_bar
end type
type st_bar from statictext within uo_status_bar
end type
type st_background from statictext within uo_status_bar
end type
end forward

global type uo_status_bar from UserObject
int Width=942
int Height=89
long BackColor=12632256
st_status st_status
st_bar st_bar
st_background st_background
end type
global uo_status_bar uo_status_bar

forward prototypes
public subroutine uof_draw (int icurrent, int ifinish)
end prototypes

public subroutine uof_draw (int icurrent, int ifinish);Int iPercentDone
Int iTotalLength
Int iRatio

iTotalLength = 677
iRatio = iFinish / iTotalLength

iPercentDone = iRatio * iCurrent

st_status.Text = String ( iPercentDone ) + "%"
st_bar.Width = iPercentDone

end subroutine

on constructor;st_bar.Width = 0
st_bar.Show ( )

end on

on uo_status_bar.create
this.st_status=create st_status
this.st_bar=create st_bar
this.st_background=create st_background
this.Control[]={ this.st_status,&
this.st_bar,&
this.st_background}
end on

on uo_status_bar.destroy
destroy(this.st_status)
destroy(this.st_bar)
destroy(this.st_background)
end on

type st_status from statictext within uo_status_bar
int X=732
int Width=202
int Height=81
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=128
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_bar from statictext within uo_status_bar
int Width=42
int Height=81
boolean Visible=false
boolean Enabled=false
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16711680
long BorderColor=128
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_background from statictext within uo_status_bar
int Width=714
int Height=81
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554560
long BackColor=12632256
long BorderColor=128
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

