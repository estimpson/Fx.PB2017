$PBExportHeader$w_change_password.srw
forward
global type w_change_password from Window
end type
type cb_1 from commandbutton within w_change_password
end type
type st_2 from statictext within w_change_password
end type
type st_1 from statictext within w_change_password
end type
type sle_2 from singlelineedit within w_change_password
end type
type sle_1 from singlelineedit within w_change_password
end type
end forward

global type w_change_password from Window
int X=1121
int Y=613
int Width=682
int Height=689
boolean TitleBar=true
string Title="Change Password"
long BackColor=12632256
WindowType WindowType=popup!
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_2 sle_2
sle_1 sle_1
end type
global w_change_password w_change_password

type variables
Boolean bGotItOnce

String szNewPassword
end variables

on deactivate;Close ( w_change_password )
end on

on open;sle_1.SetFocus ( )
end on

on w_change_password.create
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.Control[]={ this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_2,&
this.sle_1}
end on

on w_change_password.destroy
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.sle_1)
end on

type cb_1 from commandbutton within w_change_password
int X=220
int Y=449
int Width=257
int Height=129
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( w_change_password )
end on

type st_2 from statictext within w_change_password
int X=37
int Y=225
int Width=627
int Height=73
boolean Enabled=false
string Text="Enter New Password:"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_change_password
int X=37
int Width=599
int Height=73
boolean Enabled=false
string Text="Enter Old Password:"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_change_password
int X=37
int Y=321
int Width=586
int Height=97
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If bGotItOnce = False Then
	szNewPassword = sle_2.Text
	bGotItOnce = True
	st_2.Text = "Enter Again:"
	sle_2.Text = ""
Else
	If sle_2.Text <> szNewPassword Then
		//MessageBox ( "Error", "New Password Entry Does Not~rMatch.  Try Again", StopSign! )
		gnv_App.of_GetFrame().SetMicroHelp ( "New Password Entry Does Not Match.  Try Again..." )
		szNewPassword = ""
		bGotItOnce = False
		sle_2.SetFocus ( )
		st_2.Text = "Enter New Password:"
		sle_2.Text = ""
	Else
		UPDATE parameters  
		   SET admin_password = :szNewPassword  ;

		If SQLCA.SQLCode = -1 Then
			RollBack ;
		Else
			Commit ;
		End if

		Close ( w_change_password )

	End if

End if


end on

type sle_1 from singlelineedit within w_change_password
int X=37
int Y=97
int Width=586
int Height=97
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;String szPassword

SELECT parameters.admin_password  
  INTO :szPassword  
  FROM parameters  ;

If sle_1.Text <> szPassword Then
	MessageBox ( "Error", "Invalid Password!", StopSign! )
	sle_1.SetFocus ( )
	Return
End if

sle_2.SetFocus ( )

end on

