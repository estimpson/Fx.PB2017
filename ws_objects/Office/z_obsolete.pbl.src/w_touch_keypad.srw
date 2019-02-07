$PBExportHeader$w_touch_keypad.srw
forward
global type w_touch_keypad from Window
end type
type cb_39 from commandbutton within w_touch_keypad
end type
type sle_2 from singlelineedit within w_touch_keypad
end type
type st_code from statictext within w_touch_keypad
end type
type st_password from statictext within w_touch_keypad
end type
type sle_1 from singlelineedit within w_touch_keypad
end type
type cb_38 from commandbutton within w_touch_keypad
end type
type cb_37 from commandbutton within w_touch_keypad
end type
type cb_36 from commandbutton within w_touch_keypad
end type
type cb_35 from commandbutton within w_touch_keypad
end type
type cb_34 from commandbutton within w_touch_keypad
end type
type cb_33 from commandbutton within w_touch_keypad
end type
type cb_32 from commandbutton within w_touch_keypad
end type
type cb_31 from commandbutton within w_touch_keypad
end type
type cb_30 from commandbutton within w_touch_keypad
end type
type cb_29 from commandbutton within w_touch_keypad
end type
type cb_28 from commandbutton within w_touch_keypad
end type
type cb_27 from commandbutton within w_touch_keypad
end type
type cb_26 from commandbutton within w_touch_keypad
end type
type cb_25 from commandbutton within w_touch_keypad
end type
type cb_24 from commandbutton within w_touch_keypad
end type
type cb_23 from commandbutton within w_touch_keypad
end type
type cb_22 from commandbutton within w_touch_keypad
end type
type cb_21 from commandbutton within w_touch_keypad
end type
type cb_20 from commandbutton within w_touch_keypad
end type
type cb_19 from commandbutton within w_touch_keypad
end type
type cb_18 from commandbutton within w_touch_keypad
end type
type cb_17 from commandbutton within w_touch_keypad
end type
type cb_16 from commandbutton within w_touch_keypad
end type
type cb_15 from commandbutton within w_touch_keypad
end type
type cb_14 from commandbutton within w_touch_keypad
end type
type cb_13 from commandbutton within w_touch_keypad
end type
type cb_12 from commandbutton within w_touch_keypad
end type
type cb_11 from commandbutton within w_touch_keypad
end type
type cb_10 from commandbutton within w_touch_keypad
end type
type cb_9 from commandbutton within w_touch_keypad
end type
type cb_8 from commandbutton within w_touch_keypad
end type
type cb_7 from commandbutton within w_touch_keypad
end type
type cb_6 from commandbutton within w_touch_keypad
end type
type cb_5 from commandbutton within w_touch_keypad
end type
type cb_4 from commandbutton within w_touch_keypad
end type
type cb_3 from commandbutton within w_touch_keypad
end type
type cb_2 from commandbutton within w_touch_keypad
end type
type cb_1 from commandbutton within w_touch_keypad
end type
type gb_1 from groupbox within w_touch_keypad
end type
end forward

global type w_touch_keypad from Window
int X=123
int Y=120
int Width=2679
int Height=1692
boolean TitleBar=true
string Title="Operator Information"
long BackColor=77897888
WindowType WindowType=response!
cb_39 cb_39
sle_2 sle_2
st_code st_code
st_password st_password
sle_1 sle_1
cb_38 cb_38
cb_37 cb_37
cb_36 cb_36
cb_35 cb_35
cb_34 cb_34
cb_33 cb_33
cb_32 cb_32
cb_31 cb_31
cb_30 cb_30
cb_29 cb_29
cb_28 cb_28
cb_27 cb_27
cb_26 cb_26
cb_25 cb_25
cb_24 cb_24
cb_23 cb_23
cb_22 cb_22
cb_21 cb_21
cb_20 cb_20
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
cb_12 cb_12
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
cb_1 cb_1
gb_1 gb_1
end type
global w_touch_keypad w_touch_keypad

on w_touch_keypad.create
this.cb_39=create cb_39
this.sle_2=create sle_2
this.st_code=create st_code
this.st_password=create st_password
this.sle_1=create sle_1
this.cb_38=create cb_38
this.cb_37=create cb_37
this.cb_36=create cb_36
this.cb_35=create cb_35
this.cb_34=create cb_34
this.cb_33=create cb_33
this.cb_32=create cb_32
this.cb_31=create cb_31
this.cb_30=create cb_30
this.cb_29=create cb_29
this.cb_28=create cb_28
this.cb_27=create cb_27
this.cb_26=create cb_26
this.cb_25=create cb_25
this.cb_24=create cb_24
this.cb_23=create cb_23
this.cb_22=create cb_22
this.cb_21=create cb_21
this.cb_20=create cb_20
this.cb_19=create cb_19
this.cb_18=create cb_18
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_12=create cb_12
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
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.cb_39,&
this.sle_2,&
this.st_code,&
this.st_password,&
this.sle_1,&
this.cb_38,&
this.cb_37,&
this.cb_36,&
this.cb_35,&
this.cb_34,&
this.cb_33,&
this.cb_32,&
this.cb_31,&
this.cb_30,&
this.cb_29,&
this.cb_28,&
this.cb_27,&
this.cb_26,&
this.cb_25,&
this.cb_24,&
this.cb_23,&
this.cb_22,&
this.cb_21,&
this.cb_20,&
this.cb_19,&
this.cb_18,&
this.cb_17,&
this.cb_16,&
this.cb_15,&
this.cb_14,&
this.cb_13,&
this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.gb_1}
end on

on w_touch_keypad.destroy
destroy(this.cb_39)
destroy(this.sle_2)
destroy(this.st_code)
destroy(this.st_password)
destroy(this.sle_1)
destroy(this.cb_38)
destroy(this.cb_37)
destroy(this.cb_36)
destroy(this.cb_35)
destroy(this.cb_34)
destroy(this.cb_33)
destroy(this.cb_32)
destroy(this.cb_31)
destroy(this.cb_30)
destroy(this.cb_29)
destroy(this.cb_28)
destroy(this.cb_27)
destroy(this.cb_26)
destroy(this.cb_25)
destroy(this.cb_24)
destroy(this.cb_23)
destroy(this.cb_22)
destroy(this.cb_21)
destroy(this.cb_20)
destroy(this.cb_19)
destroy(this.cb_18)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_12)
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
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;sle_1.setfocus()
end event

type cb_39 from commandbutton within w_touch_keypad
int X=1006
int Y=1360
int Width=329
int Height=224
int TabOrder=180
string Text="0"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '0'
end on

type sle_2 from singlelineedit within w_touch_keypad
int X=1792
int Y=144
int Width=768
int Height=192
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=77897888
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_code from statictext within w_touch_keypad
int X=1317
int Y=160
int Width=439
int Height=128
boolean Enabled=false
string Text="Code:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_password from statictext within w_touch_keypad
int X=55
int Y=160
int Width=658
int Height=128
boolean Enabled=false
string Text="Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_touch_keypad
int X=768
int Y=144
int Width=475
int Height=192
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=16777215
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;w_touch_keypad.cb_30.trigger event clicked ()
end event

type cb_38 from commandbutton within w_touch_keypad
int X=2139
int Y=1360
int Width=512
int Height=224
int TabOrder=170
string Text="Cancel"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sle_1.text=''
szoperator=''
Close( w_touch_keypad )

//CloseWithReturn ( w_touch_keypad, "" )

end event

type cb_37 from commandbutton within w_touch_keypad
int X=1737
int Y=1360
int Width=402
int Height=224
int TabOrder=160
string Text="Clear"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = ''
end on

type cb_36 from commandbutton within w_touch_keypad
int X=677
int Y=1360
int Width=329
int Height=224
int TabOrder=250
string Text="9"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '9'
end on

type cb_35 from commandbutton within w_touch_keypad
int X=347
int Y=1360
int Width=329
int Height=224
int TabOrder=240
string Text="8"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '8'
end on

type cb_34 from commandbutton within w_touch_keypad
int X=18
int Y=1360
int Width=329
int Height=224
int TabOrder=230
string Text="7"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '7'
end on

type cb_33 from commandbutton within w_touch_keypad
int X=1664
int Y=1136
int Width=329
int Height=224
int TabOrder=220
string Text="6"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '6'
end on

type cb_32 from commandbutton within w_touch_keypad
int X=1993
int Y=1136
int Width=329
int Height=224
int TabOrder=120
string Text="Y"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'Y'
end on

type cb_31 from commandbutton within w_touch_keypad
int X=2322
int Y=1136
int Width=329
int Height=224
int TabOrder=130
string Text="Z"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'Z'
end on

type cb_30 from commandbutton within w_touch_keypad
int X=1335
int Y=1360
int Width=402
int Height=224
int TabOrder=150
string Text="Enter"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long 		lCount
//String 	szOperator

SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :sle_1.Text   ;

If IsNull ( szOperator ) Or szOperator = "" Then
	MessageBox ( "Error", "Invalid Password!", StopSign! )
	Return
End if

sle_2.Text = szOperator

//For lCount = 1 To 35000
//Next

Close ( w_touch_keypad )
//CloseWithReturn ( w_touch_keypad, sle_2.Text )
end event

type cb_29 from commandbutton within w_touch_keypad
int X=18
int Y=1136
int Width=329
int Height=224
int TabOrder=210
string Text="1"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '1'
end on

type cb_28 from commandbutton within w_touch_keypad
int X=347
int Y=1136
int Width=329
int Height=224
int TabOrder=280
string Text="2"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '2'
end on

type cb_27 from commandbutton within w_touch_keypad
int X=677
int Y=1136
int Width=329
int Height=224
int TabOrder=310
string Text="3"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '3'
end on

type cb_26 from commandbutton within w_touch_keypad
int X=1006
int Y=1136
int Width=329
int Height=224
int TabOrder=340
string Text="4"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '4'
end on

type cb_25 from commandbutton within w_touch_keypad
int X=1335
int Y=1136
int Width=329
int Height=224
int TabOrder=370
string Text="5"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + '5'
end on

type cb_24 from commandbutton within w_touch_keypad
int X=18
int Y=912
int Width=329
int Height=224
int TabOrder=110
string Text="Q"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'Q'
end on

type cb_23 from commandbutton within w_touch_keypad
int X=347
int Y=912
int Width=329
int Height=224
int TabOrder=140
string Text="R"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'R'
end on

type cb_22 from commandbutton within w_touch_keypad
int X=677
int Y=912
int Width=329
int Height=224
int TabOrder=200
string Text="S"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'S'
end on

type cb_21 from commandbutton within w_touch_keypad
int X=1006
int Y=912
int Width=329
int Height=224
int TabOrder=270
string Text="T"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'T'
end on

type cb_20 from commandbutton within w_touch_keypad
int X=1335
int Y=912
int Width=329
int Height=224
int TabOrder=300
string Text="U"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'U'
end on

type cb_19 from commandbutton within w_touch_keypad
int X=1664
int Y=912
int Width=329
int Height=224
int TabOrder=330
string Text="V"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'V'
end on

type cb_18 from commandbutton within w_touch_keypad
int X=1993
int Y=912
int Width=329
int Height=224
int TabOrder=360
string Text="W"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'W'
end on

type cb_17 from commandbutton within w_touch_keypad
int X=2322
int Y=912
int Width=329
int Height=224
int TabOrder=390
string Text="X"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'X'
end on

type cb_16 from commandbutton within w_touch_keypad
int X=18
int Y=688
int Width=329
int Height=224
int TabOrder=100
string Text="I"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'I'
end on

type cb_15 from commandbutton within w_touch_keypad
int X=347
int Y=688
int Width=329
int Height=224
int TabOrder=190
string Text="J"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'J'
end on

type cb_14 from commandbutton within w_touch_keypad
int X=677
int Y=688
int Width=329
int Height=224
int TabOrder=260
string Text="K"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'K'
end on

type cb_13 from commandbutton within w_touch_keypad
int X=1006
int Y=688
int Width=329
int Height=224
int TabOrder=290
string Text="L"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'L'
end on

type cb_12 from commandbutton within w_touch_keypad
int X=1335
int Y=688
int Width=329
int Height=224
int TabOrder=320
string Text="M"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'M'
end on

type cb_11 from commandbutton within w_touch_keypad
int X=1664
int Y=688
int Width=329
int Height=224
int TabOrder=350
string Text="N"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'N'
end on

type cb_10 from commandbutton within w_touch_keypad
int X=1993
int Y=688
int Width=329
int Height=224
int TabOrder=380
string Text="O"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'O'
end on

type cb_9 from commandbutton within w_touch_keypad
int X=2322
int Y=688
int Width=329
int Height=224
int TabOrder=400
string Text="P"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'P'
end on

type cb_8 from commandbutton within w_touch_keypad
int X=2322
int Y=464
int Width=329
int Height=224
int TabOrder=90
string Text="H"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'H'
end on

type cb_7 from commandbutton within w_touch_keypad
int X=1993
int Y=464
int Width=329
int Height=224
int TabOrder=80
string Text="G"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'G'
end on

type cb_6 from commandbutton within w_touch_keypad
int X=1664
int Y=464
int Width=329
int Height=224
int TabOrder=70
string Text="F"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'F'
end on

type cb_5 from commandbutton within w_touch_keypad
int X=1335
int Y=464
int Width=329
int Height=224
int TabOrder=60
string Text="E"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'E'
end on

type cb_4 from commandbutton within w_touch_keypad
int X=1006
int Y=464
int Width=329
int Height=224
int TabOrder=50
string Text="D"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'D'
end on

type cb_3 from commandbutton within w_touch_keypad
int X=677
int Y=464
int Width=329
int Height=224
int TabOrder=40
string Text="C"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'C'
end on

type cb_2 from commandbutton within w_touch_keypad
int X=347
int Y=464
int Width=329
int Height=224
int TabOrder=30
string Text="B"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'B'
end on

type cb_1 from commandbutton within w_touch_keypad
int X=18
int Y=464
int Width=329
int Height=224
int TabOrder=20
string Text="A"
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + 'A'
end on

type gb_1 from groupbox within w_touch_keypad
int X=18
int Width=2633
int Height=432
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-26
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

