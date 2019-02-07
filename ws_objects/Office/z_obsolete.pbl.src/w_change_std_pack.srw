$PBExportHeader$w_change_std_pack.srw
forward
global type w_change_std_pack from Window
end type
type lb_1 from listbox within w_change_std_pack
end type
type sle_1 from singlelineedit within w_change_std_pack
end type
type cb_14 from commandbutton within w_change_std_pack
end type
type cb_13 from commandbutton within w_change_std_pack
end type
type cb_12 from commandbutton within w_change_std_pack
end type
type cb_1 from commandbutton within w_change_std_pack
end type
type cb_11 from commandbutton within w_change_std_pack
end type
type cb_10 from commandbutton within w_change_std_pack
end type
type cb_9 from commandbutton within w_change_std_pack
end type
type cb_8 from commandbutton within w_change_std_pack
end type
type cb_7 from commandbutton within w_change_std_pack
end type
type cb_6 from commandbutton within w_change_std_pack
end type
type cb_5 from commandbutton within w_change_std_pack
end type
type cb_4 from commandbutton within w_change_std_pack
end type
type cb_3 from commandbutton within w_change_std_pack
end type
type cb_2 from commandbutton within w_change_std_pack
end type
end forward

global type w_change_std_pack from Window
int X=782
int Y=408
int Width=1358
int Height=1116
boolean TitleBar=true
string Title="Change Standard Pack"
long BackColor=77897888
WindowType WindowType=response!
lb_1 lb_1
sle_1 sle_1
cb_14 cb_14
cb_13 cb_13
cb_12 cb_12
cb_1 cb_1
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
end type
global w_change_std_pack w_change_std_pack

type variables
Boolean bDecimalPoint
end variables

event open;STRING					l_s_part,&
							l_s_unit,&
							l_s_desc
st_generic_structure	l_str_parm
int						l_i_index

l_str_parm = Message.PowerObjectParm
l_s_part = l_str_parm.value1
l_s_unit = l_str_parm.value2

DECLARE unit_list PROCEDURE FOR msp_unit_list :l_s_part  USING sqlca;

Execute unit_list;

Fetch unit_list into :l_s_unit, :l_s_desc;	
Do While sqlca.sqlcode = 0
	lb_1.AddItem ( l_s_unit )
	Fetch unit_list into :l_s_unit, :l_s_desc;		
Loop 

Close unit_list;

l_i_index = lb_1.FindItem ( l_str_parm.value2, 1 )
lb_1.SelectItem ( l_i_index )
 
end event

on w_change_std_pack.create
this.lb_1=create lb_1
this.sle_1=create sle_1
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_1=create cb_1
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.Control[]={this.lb_1,&
this.sle_1,&
this.cb_14,&
this.cb_13,&
this.cb_12,&
this.cb_1,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2}
end on

on w_change_std_pack.destroy
destroy(this.lb_1)
destroy(this.sle_1)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_1)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
end on

type lb_1 from listbox within w_change_std_pack
int X=823
int Y=32
int Width=421
int Height=528
int TabOrder=160
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_change_std_pack
int X=55
int Y=32
int Width=750
int Height=96
int TabOrder=10
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_14 from commandbutton within w_change_std_pack
int X=823
int Y=784
int Width=439
int Height=192
int TabOrder=110
string Text="&Cancel"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, '' )
end on

type cb_13 from commandbutton within w_change_std_pack
int X=55
int Y=784
int Width=238
int Height=192
int TabOrder=70
string Text="."
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If Not bDecimalPoint Then
	sle_1.Text = sle_1.Text + '.'
	bDecimalPoint = True
End if
end on

type cb_12 from commandbutton within w_change_std_pack
int X=823
int Y=576
int Width=439
int Height=192
int TabOrder=90
string Text="&Ok"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;STRING	l_s_return

IF lb_1.SelectedItem ( ) = '(None)' THEN
	l_s_return = f_get_string_value ( sle_1.Text ) + "~t"
ELSE
	l_s_return = f_get_string_value ( sle_1.Text ) + "~t" + lb_1.SelectedItem ( )
END IF

CloseWithReturn ( Parent, l_s_return )
end on

type cb_1 from commandbutton within w_change_std_pack
int X=567
int Y=784
int Width=238
int Height=192
int TabOrder=80
string Text="Clr"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = ''
end on

type cb_11 from commandbutton within w_change_std_pack
int X=311
int Y=784
int Width=238
int Height=192
int TabOrder=60
string Text="0"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If f_get_string_value ( sle_1.Text ) <> '' Then &
	sle_1.Text = sle_1.Text + '0'
end on

type cb_10 from commandbutton within w_change_std_pack
int X=567
int Y=576
int Width=238
int Height=192
int TabOrder=50
string Text="3"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '3'
end on

type cb_9 from commandbutton within w_change_std_pack
int X=311
int Y=576
int Width=238
int Height=192
int TabOrder=40
string Text="2"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '2'
end on

type cb_8 from commandbutton within w_change_std_pack
int X=55
int Y=576
int Width=238
int Height=192
int TabOrder=30
string Text="1"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '1'
end on

type cb_7 from commandbutton within w_change_std_pack
int X=567
int Y=368
int Width=238
int Height=192
int TabOrder=100
string Text="6"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '6'
end on

type cb_6 from commandbutton within w_change_std_pack
int X=311
int Y=368
int Width=238
int Height=192
int TabOrder=120
string Text="5"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '5'
end on

type cb_5 from commandbutton within w_change_std_pack
int X=55
int Y=368
int Width=238
int Height=192
int TabOrder=20
string Text="4"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '4'
end on

type cb_4 from commandbutton within w_change_std_pack
int X=567
int Y=160
int Width=238
int Height=192
int TabOrder=150
string Text="9"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '9'
end on

type cb_3 from commandbutton within w_change_std_pack
int X=311
int Y=160
int Width=238
int Height=192
int TabOrder=140
string Text="8"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '8'
end on

type cb_2 from commandbutton within w_change_std_pack
int X=55
int Y=160
int Width=238
int Height=192
int TabOrder=130
string Text="7"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '7'
end on

