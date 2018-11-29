$PBExportHeader$w_add_order_type.srw
forward
global type w_add_order_type from Window
end type
type cb_2 from commandbutton within w_add_order_type
end type
type cb_1 from commandbutton within w_add_order_type
end type
type rb_2 from radiobutton within w_add_order_type
end type
type rb_1 from radiobutton within w_add_order_type
end type
end forward

global type w_add_order_type from Window
int X=1070
int Y=648
int Width=777
int Height=672
boolean TitleBar=true
string Title="Add order of type:"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
end type
global w_add_order_type w_add_order_type

type variables
st_generic_structure	istr_parm
end variables

event open;string ls_type

istr_parm = Message.PowerObjectParm

select order_type
into   :ls_type
from   parameters ;


If ls_type = 'N' Then
	rb_2.SetFocus ( )
Else
	rb_1.SetFocus ( )
End if
end event

on w_add_order_type.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.rb_2,&
this.rb_1}
end on

on w_add_order_type.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

event closequery;if Message.DoubleParm = 1 then
	If rb_1.Checked = True Then
		Message.DoubleParm = 1
//		OpenSheetWithParm ( w_blanket_order, istr_parm, wMainScreen, 3, Original! )
	Elseif rb_2.Checked = True Then
		Message.DoubleParm = 2
//		OpenSheetWithParm ( w_orders_detail, istr_parm, wMainScreen, 3, Original! )
	End if
end if
end event

type cb_2 from commandbutton within w_add_order_type
int X=453
int Y=368
int Width=256
int Height=128
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_add_order_type
int X=50
int Y=368
int Width=256
int Height=128
string Text="&OK"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 1 )
end event

type rb_2 from radiobutton within w_add_order_type
int X=73
int Y=208
int Width=585
int Height=96
int TabOrder=20
string Text="Normal Order"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_add_order_type
int X=73
int Y=96
int Width=585
int Height=96
int TabOrder=10
string Text="Blanket Order"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

