$PBExportHeader$w_std_password.srw
forward
global type w_std_password from Window
end type
type cb_cancel from commandbutton within w_std_password
end type
type cb_ok from commandbutton within w_std_password
end type
type dw_operator from datawindow within w_std_password
end type
end forward

global type w_std_password from Window
int X=823
int Y=360
int Width=887
int Height=424
boolean TitleBar=true
string Title="Operator"
long BackColor=78682240
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
dw_operator dw_operator
end type
global w_std_password w_std_password

on w_std_password.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_operator=create dw_operator
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_operator}
end on

on w_std_password.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_operator)
end on

type cb_cancel from commandbutton within w_std_password
int X=453
int Y=192
int Width=247
int Height=96
int TabOrder=20
string Text="Cancel"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn ( parent, '' )
end event

type cb_ok from commandbutton within w_std_password
int X=165
int Y=192
int Width=247
int Height=96
int TabOrder=20
boolean Enabled=false
string Text="Ok"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_operator

// return operator code that the user entered.
ls_operator = dw_operator.object.operator_code [1]
closewithreturn ( parent, ls_operator )

end event

type dw_operator from datawindow within w_std_password
event ue_key pbm_dwnkey
int X=41
int Y=24
int Width=786
int Height=120
int TabOrder=10
string DataObject="d_std_password"
boolean Border=false
boolean LiveScroll=true
end type

event ue_key;if key = keyenter! then 
	accepttext()
	triggerevent ( itemchanged! )
end if
end event

event constructor;insertrow (1)
end event

event itemchanged;if f_get_password ( data ) > '' then
	cb_ok.enabled = true
else
	cb_ok.enabled = false
	setitem ( 1, 'operator', '' )
	setitem ( 1, 'operator_code', '' )
	messagebox ( 'DataWindow Error', 'Invalid Operator Password!', Exclamation! )
	return 1
end if	


end event

event itemerror;return 1
end event

