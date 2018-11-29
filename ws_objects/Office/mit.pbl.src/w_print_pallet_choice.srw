$PBExportHeader$w_print_pallet_choice.srw
forward
global type w_print_pallet_choice from Window
end type
type cb_cancel from commandbutton within w_print_pallet_choice
end type
type cb_1 from commandbutton within w_print_pallet_choice
end type
type cb_2 from commandbutton within w_print_pallet_choice
end type
type cb_3 from commandbutton within w_print_pallet_choice
end type
type cb_4 from commandbutton within w_print_pallet_choice
end type
end forward

global type w_print_pallet_choice from Window
int X=370
int Y=376
int Width=2181
int Height=1168
boolean TitleBar=true
string Title="Scale Interface"
long BackColor=77897888
WindowType WindowType=response!
event ue_open pbm_custom01
cb_cancel cb_cancel
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_print_pallet_choice w_print_pallet_choice

type prototypes

end prototypes

type variables

end variables

on ue_open;string	ls_parm
int		li_pos,&
			li_last_pos,&
			li_count

ls_parm = Message.StringParm

Do
	li_count++
	li_pos = PosA ( ls_parm, "/", li_pos + 1 )
	if li_pos > 0 then
		Choose Case li_count
			Case 1
				cb_1.Text = MidA ( ls_parm, li_last_pos + 1, li_pos - ( li_last_pos + 1 ) )
				cb_1.Show ( )
			Case 2
				cb_2.Text = MidA ( ls_parm, li_last_pos + 1, li_pos - ( li_last_pos + 1 ) )
				cb_2.Show ( )
			Case 3
				cb_3.Text = MidA ( ls_parm, li_last_pos + 1, li_pos - ( li_last_pos + 1 ) )
				cb_3.Show ( )
		End Choose
		li_last_pos = li_pos
	else
		Choose Case li_count
			Case 1
				cb_1.Text = MidA ( ls_parm, li_last_pos + 1, LenA ( ls_parm ) - li_last_pos )
				cb_1.Show ( )
			Case 2
				cb_2.Text = MidA ( ls_parm, li_last_pos + 1, LenA ( ls_parm ) - li_last_pos )
				cb_2.Show ( )
			Case 3
				cb_3.Text = MidA ( ls_parm, li_last_pos + 1, LenA ( ls_parm ) - li_last_pos )
				cb_3.Show ( )
		End Choose
	end if
Loop While li_pos > 0

end on

on w_print_pallet_choice.create
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.Control[]={this.cb_cancel,&
this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_4}
end on

on w_print_pallet_choice.destroy
destroy(this.cb_cancel)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

on open;postevent ( "ue_open" )
end on

type cb_cancel from commandbutton within w_print_pallet_choice
int X=37
int Y=848
int Width=2066
int Height=192
int TabOrder=20
string Text="&Cancel"
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, "0" )
end on

type cb_1 from commandbutton within w_print_pallet_choice
int X=37
int Y=16
int Width=2066
int Height=192
int TabOrder=40
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, Text )
end on

type cb_2 from commandbutton within w_print_pallet_choice
int X=37
int Y=224
int Width=2066
int Height=192
int TabOrder=50
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, Text )
end on

type cb_3 from commandbutton within w_print_pallet_choice
int X=37
int Y=432
int Width=2066
int Height=192
int TabOrder=10
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, Text )
end on

type cb_4 from commandbutton within w_print_pallet_choice
int X=37
int Y=640
int Width=2066
int Height=192
int TabOrder=30
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, Text )
end on

