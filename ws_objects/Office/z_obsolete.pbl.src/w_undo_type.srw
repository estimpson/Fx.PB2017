$PBExportHeader$w_undo_type.srw
forward
global type w_undo_type from Window
end type
type sle_scrap from singlelineedit within w_undo_type
end type
type rb_3 from radiobutton within w_undo_type
end type
type cb_clear from commandbutton within w_undo_type
end type
type cb_dec from commandbutton within w_undo_type
end type
type sle_new from singlelineedit within w_undo_type
end type
type cb_0 from commandbutton within w_undo_type
end type
type cb_9 from commandbutton within w_undo_type
end type
type cb_8 from commandbutton within w_undo_type
end type
type cb_7 from commandbutton within w_undo_type
end type
type cb_6 from commandbutton within w_undo_type
end type
type cb_5 from commandbutton within w_undo_type
end type
type cb_4 from commandbutton within w_undo_type
end type
type cb_3 from commandbutton within w_undo_type
end type
type cb_2 from commandbutton within w_undo_type
end type
type cb_1 from commandbutton within w_undo_type
end type
type sle_original from singlelineedit within w_undo_type
end type
type st_1 from statictext within w_undo_type
end type
type rb_2 from radiobutton within w_undo_type
end type
type rb_1 from radiobutton within w_undo_type
end type
type cb_cancel from commandbutton within w_undo_type
end type
type cb_ok from commandbutton within w_undo_type
end type
type st_3 from statictext within w_undo_type
end type
type gb_2 from groupbox within w_undo_type
end type
type gb_1 from groupbox within w_undo_type
end type
end forward

global type w_undo_type from Window
int X=402
int Y=460
int Width=1934
int Height=960
boolean TitleBar=true
string Title="Undo Material Issue"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=popup!
sle_scrap sle_scrap
rb_3 rb_3
cb_clear cb_clear
cb_dec cb_dec
sle_new sle_new
cb_0 cb_0
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_original sle_original
st_1 st_1
rb_2 rb_2
rb_1 rb_1
cb_cancel cb_cancel
cb_ok cb_ok
st_3 st_3
gb_2 gb_2
gb_1 gb_1
end type
global w_undo_type w_undo_type

type variables
Boolean		ib_Dec
String        i_s_mi_type
end variables

forward prototypes
public subroutine wf_partial (boolean lb_mode, string rb_opted)
end prototypes

public subroutine wf_partial (boolean lb_mode, string rb_opted);Choose Case rb_opted
	Case 'P','F'
     String l_s_part
     l_s_part = w_machine_inventory.is_undopart 
     Select material_issue_type
       Into :i_s_mi_type
       From part_inventory
      Where part= :l_s_part ;
      st_3.text    = 'Used~r~nQty'
      IF isnull(i_s_mi_type) THEN i_s_mi_type='U'
      IF i_s_mi_type='R' THEN st_3.text = 'Remaining~r~nQty'
		if rb_opted='F' then sle_new.text='' 
      sle_new.Enabled 		= lb_Mode		
      sle_scrap.Enabled 	= false
		sle_scrap.text=''
		rb_3.checked=false
	Case 'S'	
		rb_1.checked=false
		rb_2.checked=false
		sle_new.text='' 
		sle_new.Enabled = false
      sle_scrap.Enabled 	= lb_Mode		
End Choose
cb_clear.Enabled		= lb_Mode
cb_0.Enabled			= lb_Mode
cb_dec.Enabled			= lb_Mode
cb_1.Enabled			= lb_Mode
cb_2.Enabled			= lb_Mode
cb_3.Enabled			= lb_Mode
cb_4.Enabled			= lb_Mode
cb_5.Enabled			= lb_Mode
cb_6.Enabled			= lb_Mode
cb_7.Enabled			= lb_Mode
cb_8.Enabled			= lb_Mode
cb_9.Enabled			= lb_Mode
end subroutine

on close;w_machine_inventory.Enabled = True

w_machine_inventory.dw_objects.TriggerEvent ( "dragfinish" )

end on

event open;Dec		ld_Quantity

ld_Quantity = Message.DoubleParm

sle_original.Text = String ( ld_Quantity, "#########.######" )

w_machine_inventory.Enabled = False

end event

on w_undo_type.create
this.sle_scrap=create sle_scrap
this.rb_3=create rb_3
this.cb_clear=create cb_clear
this.cb_dec=create cb_dec
this.sle_new=create sle_new
this.cb_0=create cb_0
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_original=create sle_original
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_3=create st_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.sle_scrap,&
this.rb_3,&
this.cb_clear,&
this.cb_dec,&
this.sle_new,&
this.cb_0,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_original,&
this.st_1,&
this.rb_2,&
this.rb_1,&
this.cb_cancel,&
this.cb_ok,&
this.st_3,&
this.gb_2,&
this.gb_1}
end on

on w_undo_type.destroy
destroy(this.sle_scrap)
destroy(this.rb_3)
destroy(this.cb_clear)
destroy(this.cb_dec)
destroy(this.sle_new)
destroy(this.cb_0)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_original)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type sle_scrap from singlelineedit within w_undo_type
int X=325
int Y=556
int Width=475
int Height=96
int TabOrder=70
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_undo_type
int X=37
int Y=560
int Width=270
int Height=72
string Text="Scrap "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_partial ( True, 'S' )

end event

type cb_clear from commandbutton within w_undo_type
int X=1120
int Y=660
int Width=256
int Height=192
boolean Enabled=false
string Text="Clr"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text =  ""
if rb_3.checked = true then sle_scrap.Text =  ""
end event

type cb_dec from commandbutton within w_undo_type
int X=1632
int Y=660
int Width=256
int Height=192
boolean Enabled=false
string Text="."
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then 
   If Not ib_Dec Then
   	ib_Dec = True
   	sle_new.Text = sle_new.Text + "."
   End if
end if 	
if rb_3.checked = true then 
   If Not ib_Dec Then
   	ib_Dec = True
   	sle_scrap.Text = sle_scrap.Text + "."
   End if
end if 	
end event

type sle_new from singlelineedit within w_undo_type
int X=325
int Y=304
int Width=475
int Height=96
int TabOrder=50
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_0 from commandbutton within w_undo_type
int X=1376
int Y=660
int Width=256
int Height=192
boolean Enabled=false
string Text="0"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then
   If Dec ( LeftA ( sle_new.Text, 1 ) ) > 0 or LeftA ( sle_new.Text, 1 ) = "." Then &
	   sle_new.Text = sle_new.Text + "0"
end if 
if rb_3.checked = true then 
   If Dec ( LeftA ( sle_scrap.Text, 1 ) ) > 0 or LeftA ( sle_scrap.Text, 1 ) = "." Then &
	   sle_scrap.Text = sle_scrap.Text + "0"
end if 	
	
end event

type cb_9 from commandbutton within w_undo_type
int X=1632
int Y=84
int Width=256
int Height=192
boolean Enabled=false
string Text="9"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "9"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "9"
end event

type cb_8 from commandbutton within w_undo_type
int X=1376
int Y=84
int Width=256
int Height=192
boolean Enabled=false
string Text="8"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "8"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "8"
end event

type cb_7 from commandbutton within w_undo_type
int X=1120
int Y=84
int Width=256
int Height=192
boolean Enabled=false
string Text="7"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "7"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "7"
end event

type cb_6 from commandbutton within w_undo_type
int X=1632
int Y=276
int Width=256
int Height=192
boolean Enabled=false
string Text="6"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "6"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "6"
end event

type cb_5 from commandbutton within w_undo_type
int X=1376
int Y=276
int Width=256
int Height=192
boolean Enabled=false
string Text="5"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "5"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "5"
end event

type cb_4 from commandbutton within w_undo_type
int X=1120
int Y=276
int Width=256
int Height=192
boolean Enabled=false
string Text="4"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "4"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "4"
end event

type cb_3 from commandbutton within w_undo_type
int X=1632
int Y=468
int Width=256
int Height=192
boolean Enabled=false
string Text="3"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "3"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "3"
end event

type cb_2 from commandbutton within w_undo_type
int X=1376
int Y=468
int Width=256
int Height=192
boolean Enabled=false
string Text="2"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "2"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "2"
end event

type cb_1 from commandbutton within w_undo_type
int X=1120
int Y=468
int Width=256
int Height=192
boolean Enabled=false
string Text="1"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_2.checked = true then sle_new.Text = sle_new.Text + "1"
if rb_3.checked = true then sle_scrap.Text = sle_scrap.Text + "1"
end event

type sle_original from singlelineedit within w_undo_type
int X=325
int Y=196
int Width=475
int Height=96
int TabOrder=40
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_undo_type
int X=18
int Width=1856
int Height=80
boolean Enabled=false
string Text="Choose option and press Ok to continue or Cancel to end undo"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_undo_type
int X=46
int Y=304
int Width=270
int Height=72
int TabOrder=30
string Text="Partial"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_partial ( True, 'P' )

end event

type rb_1 from radiobutton within w_undo_type
int X=46
int Y=196
int Width=270
int Height=72
int TabOrder=10
string Text="Full"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_partial ( False,'F' )
end event

type cb_cancel from commandbutton within w_undo_type
int X=841
int Y=740
int Width=256
int Height=112
int TabOrder=80
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;szReturnedString = ""
Close ( Parent )
end on

type cb_ok from commandbutton within w_undo_type
int X=549
int Y=740
int Width=256
int Height=112
int TabOrder=60
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dec l_d_diffqty
If rb_1.Checked Then
	szReturnedString = "Full"
	Close ( Parent )
	//CloseWithReturn ( Parent, "Full" )
ElseIF rb_2.Checked THEN
	If Dec ( sle_new.Text ) > Dec ( sle_original.Text ) Then
		MessageBox ( "System Error", "New quantity must be less than original quantity!", StopSign! )
		Return
	ElseIf Dec ( sle_new.Text ) = Dec ( sle_original.Text ) Then
		MessageBox ( "System Error", "If you want to undo full quantity, please select the undo full quantity option!", StopSign! )
		Return
	End if
	IF i_s_mi_type<>'R' Then
	   l_d_diffqty = Dec ( sle_original.Text ) - Dec ( sle_new.Text )  
		szReturnedString = "Partial" + String(l_d_diffqty)
	Else	
		szReturnedString = "Partial" + sle_new.Text
	End if 	
	Close ( Parent )
	//CloseWithReturn ( Parent, "Partial" + sle_new.Text )
ELSEIF rb_3.Checked THEN
	If Dec ( sle_scrap.Text ) > Dec ( sle_original.Text ) Then
		MessageBox ( "System Error", "Scrapped quantity must be less than original quantity!", StopSign! )
		Return
	End if
	w_machine_inventory.wf_scrap_qty ( )
	szReturnedString = "Scrap" + sle_scrap.Text
	Close ( Parent )
End if
end event

type st_3 from statictext within w_undo_type
int X=818
int Y=304
int Width=256
int Height=108
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_undo_type
int X=23
int Y=472
int Width=1070
int Height=216
int TabOrder=70
string Text="Scrap Quantity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_undo_type
int X=23
int Y=120
int Width=1070
int Height=308
int TabOrder=20
string Text="Undo Quantity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

