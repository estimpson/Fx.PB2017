$PBExportHeader$w_databaseprofilesadmin.srw
forward
global type w_databaseprofilesadmin from w_response
end type
type cb_1 from commandbutton within w_databaseprofilesadmin
end type
type cb_2 from commandbutton within w_databaseprofilesadmin
end type
type cbx_1 from checkbox within w_databaseprofilesadmin
end type
type cbx_2 from checkbox within w_databaseprofilesadmin
end type
type cbx_3 from checkbox within w_databaseprofilesadmin
end type
end forward

global type w_databaseprofilesadmin from w_response
int Width=795
int Height=592
boolean TitleBar=true
string Title="Database Profiles Admin"
long BackColor=78748035
cb_1 cb_1
cb_2 cb_2
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
end type
global w_databaseprofilesadmin w_databaseprofilesadmin

type variables
string	is_AppProfile
end variables

event open;call super::open;//	Declarations
ulong	lul_SQLServer
ulong	lul_ODBC
ulong	lul_SystemODBC

//	Store the app profile
is_AppProfile = Message.StringParm

//	Get the registry settings and display
gnv_app.inv_Reg.of_GetDisplayDBMS ( is_AppProfile, lul_SQLServer, lul_ODBC, lul_SystemODBC )

cbx_1.Checked = ( lul_SQLServer = 1 )
cbx_2.Checked = ( lul_ODBC = 1 )
cbx_3.Checked = ( lul_SystemODBC = 1 )

end event

on w_databaseprofilesadmin.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cbx_2
this.Control[iCurrent+5]=this.cbx_3
end on

on w_databaseprofilesadmin.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
end on

type cb_1 from commandbutton within w_databaseprofilesadmin
int X=73
int Y=352
int Width=293
int Height=128
int TabOrder=10
boolean BringToTop=true
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
ulong	lul_SQLServer
ulong	lul_ODBC
ulong	lul_SystemODBC

if cbx_1.Checked then
	lul_SQLServer = 1
else
	lul_SQLServer = 0
end if
if cbx_2.Checked then
	lul_ODBC = 1
else
	lul_ODBC = 0
end if
if cbx_3.Checked then
	lul_SystemODBC = 1
else
	lul_SystemODBC = 0
end if

//	Get the registry settings and display
gnv_app.inv_Reg.of_SetDisplayDBMS ( is_AppProfile, lul_SQLServer, lul_ODBC, lul_SystemODBC )

Close ( Parent )
end event

type cb_2 from commandbutton within w_databaseprofilesadmin
int X=402
int Y=352
int Width=293
int Height=128
int TabOrder=20
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type cbx_1 from checkbox within w_databaseprofilesadmin
int X=18
int Y=32
int Width=731
int Height=96
boolean BringToTop=true
string Text="Display SQL Server Profiles"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Microsoft Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_2 from checkbox within w_databaseprofilesadmin
int X=18
int Y=128
int Width=731
int Height=96
boolean BringToTop=true
string Text="Display ODBC Profiles"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Microsoft Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_3 from checkbox within w_databaseprofilesadmin
int X=18
int Y=224
int Width=768
int Height=96
boolean BringToTop=true
string Text="Display System ODBC Profiles"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Microsoft Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

