$PBExportHeader$w_operator_login.srw
forward
global type w_operator_login from Window
end type
type cb_2 from commandbutton within w_operator_login
end type
type cb_1 from commandbutton within w_operator_login
end type
type sle_2 from singlelineedit within w_operator_login
end type
type sle_1 from singlelineedit within w_operator_login
end type
type st_2 from statictext within w_operator_login
end type
type st_1 from statictext within w_operator_login
end type
type gb_1 from groupbox within w_operator_login
end type
end forward

global type w_operator_login from Window
int X=960
int Y=728
int Width=1211
int Height=448
boolean TitleBar=true
string Title="Login Screen"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_operator_login w_operator_login

type variables
string	is_operator
string	is_password
end variables

on w_operator_login.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_operator_login.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event activate;sle_1.text=''
sle_2.text=''


end event

event open;sle_1.text=''
sle_2.text=''
//sle_1.setfocus()

end event

type cb_2 from commandbutton within w_operator_login
int X=910
int Y=36
int Width=247
int Height=108
int TabOrder=30
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	close this window
closewithreturn ( w_operator_login, '' ) 
end event

type cb_1 from commandbutton within w_operator_login
int X=910
int Y=200
int Width=247
int Height=108
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
string	ls_operator

//	Initilization
ls_operator = is_operator

//	validate operator & take the appropriate action
if (isnull(ls_operator) or LenA(ls_operator) = 0 or ls_operator = '') then
	sle_1.text = ''
	Messagebox ( "System Message","Invalid user id & password, Please try again" )
else
	//	open the transfer window
	closewithreturn ( w_operator_login, ls_operator )
end if 	

end event

type sle_2 from singlelineedit within w_operator_login
int X=489
int Y=76
int Width=325
int Height=76
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_operator_login
event ue_key pbm_dwnkey
int X=489
int Y=188
int Width=325
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;if keydown ( keyenter! )then 
	cb_1.triggerevent(clicked!)
elseif keydown ( keyescape! ) then 
	cb_2.triggerevent(clicked!)
end if 
	
end event

event modified;//	Declarations
string	ls_operator
string	ls_password

//	Initialization
ls_password = trim(sle_1.text)

//	get operator
select	operator_code
into	:ls_operator
from	employee
where	password=:ls_password;

//	check sql status
if sqlca.sqlcode <> 0 then ls_operator = ''

is_operator = ls_operator
is_password = ls_password

//	Assignment
sle_2.text = ls_operator

end event

type st_2 from statictext within w_operator_login
int X=82
int Y=76
int Width=325
int Height=76
boolean Enabled=false
string Text="User Id:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_operator_login
int X=82
int Y=192
int Width=325
int Height=76
boolean Enabled=false
string Text="Password:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_operator_login
int X=37
int Width=832
int Height=308
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

