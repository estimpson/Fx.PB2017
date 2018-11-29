$PBExportHeader$w_about.srw
forward
global type w_about from Window
end type
type cb_1 from commandbutton within w_about
end type
type uo_1 from u_splash_sql7 within w_about
end type
type dw_title from datawindow within w_about
end type
end forward

global type w_about from Window
int X=1024
int Y=564
int Width=1559
int Height=1012
long BackColor=16777215
WindowType WindowType=response!
cb_1 cb_1
uo_1 uo_1
dw_title dw_title
end type
global w_about w_about

type variables
INTEGER	i_i_count = 0
end variables

event open;string	ls_version

f_center_window ( This )

visible = FALSE
select	version
into	:ls_version
from	admin;


if monsys.dbplatform = "Mssql7" then
	uo_1.Show ( )
	IF isnull(ls_version,'') > '' then uo_1.st_2.text = "Version: " + ls_version
else
	
	dw_title.Show ( )
	dw_title.InsertRow ( 1 )
	If monsys.oemtitle <> "" Then
		dw_title.SetItem ( 1, "line1", monsys.oemtitle )
	Else
		dw_title.SetItem ( 1, "line1", monsys.title )
	End if

	IF isnull(ls_version,'') > ''then 
		dw_title.SetItem ( 1, "line2", trim(ls_version) ) // override version no. from admin table	
	else
		dw_title.SetItem ( 1, "line2", monsys.version )		
	end if 	
	
	CHOOSE CASE sysenviron.OSType
		CASE WindowsNT!
			dw_title.SetItem ( 1, "line3", "For Windows NT" )
		CASE ELSE
			dw_title.SetItem ( 1, "line3", "For Windows 95/98" )
	END CHOOSE
	dw_title.SetItem ( 1, "line4", monsys.company )
	dw_title.SetItem ( 1, "line5", "Copyright (c) 2000 Dave Medinis" )
	dw_title.SetItem ( 1, "line6", "Serial Number: " + monsys.serial )
end if
cb_1.BringToTop = TRUE
visible = TRUE


end event

on w_about.create
this.cb_1=create cb_1
this.uo_1=create uo_1
this.dw_title=create dw_title
this.Control[]={this.cb_1,&
this.uo_1,&
this.dw_title}
end on

on w_about.destroy
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.dw_title)
end on

type cb_1 from commandbutton within w_about
int X=1294
int Y=888
int Width=247
int Height=108
int TabOrder=20
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type uo_1 from u_splash_sql7 within w_about
int X=0
int Y=0
int TabOrder=20
boolean Visible=false
end type

on uo_1.destroy
call u_splash_sql7::destroy
end on

type dw_title from datawindow within w_about
int Width=1541
int Height=996
int TabOrder=10
boolean Visible=false
boolean Enabled=false
string DataObject="d_title"
boolean Border=false
end type

