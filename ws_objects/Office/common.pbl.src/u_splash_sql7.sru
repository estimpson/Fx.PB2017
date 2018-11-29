$PBExportHeader$u_splash_sql7.sru
forward
global type u_splash_sql7 from UserObject
end type
type st_1 from statictext within u_splash_sql7
end type
type st_2 from statictext within u_splash_sql7
end type
type st_3 from statictext within u_splash_sql7
end type
type st_4 from statictext within u_splash_sql7
end type
type st_5 from statictext within u_splash_sql7
end type
type p_1 from picture within u_splash_sql7
end type
end forward

global type u_splash_sql7 from UserObject
int Width=1550
int Height=1008
long BackColor=77897888
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
p_1 p_1
end type
global u_splash_sql7 u_splash_sql7

event constructor;If monsys.oemtitle <> "" Then
	st_1.Text = monsys.oemtitle
else
	st_1.Text = monsys.title
end if
st_2.Text = monsys.version
CHOOSE CASE sysenviron.OSType
	CASE WindowsNT!
		st_3.text = "For Windows NT"
	CASE ELSE
		st_3.text = "For Windows 95/98"
END CHOOSE
st_4.Text = monsys.company
st_5.Text = "Serial: " + monsys.serial

end event

on u_splash_sql7.create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.p_1=create p_1
this.Control[]={this.st_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.p_1}
end on

on u_splash_sql7.destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.p_1)
end on

type st_1 from statictext within u_splash_sql7
int X=110
int Y=608
int Width=1335
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
long BorderColor=1579032
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_splash_sql7
int X=110
int Y=672
int Width=1335
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
long BorderColor=1579032
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_splash_sql7
int X=110
int Y=736
int Width=1335
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
long BorderColor=1579032
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_splash_sql7
int X=110
int Y=800
int Width=1335
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
long BorderColor=1579032
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within u_splash_sql7
int X=110
int Y=864
int Width=1335
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
long BorderColor=1579032
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within u_splash_sql7
int Width=1554
int Height=1008
string PictureName="monsplash70.bmp"
boolean FocusRectangle=false
end type

