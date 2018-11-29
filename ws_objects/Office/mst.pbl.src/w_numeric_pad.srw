$PBExportHeader$w_numeric_pad.srw
forward
global type w_numeric_pad from Window
end type
type cb_14 from commandbutton within w_numeric_pad
end type
type cb_13 from commandbutton within w_numeric_pad
end type
type cb_12 from commandbutton within w_numeric_pad
end type
type cb_11 from commandbutton within w_numeric_pad
end type
type cb_10 from commandbutton within w_numeric_pad
end type
type cb_9 from commandbutton within w_numeric_pad
end type
type cb_8 from commandbutton within w_numeric_pad
end type
type cb_7 from commandbutton within w_numeric_pad
end type
type cb_6 from commandbutton within w_numeric_pad
end type
type cb_5 from commandbutton within w_numeric_pad
end type
type cb_4 from commandbutton within w_numeric_pad
end type
type cb_3 from commandbutton within w_numeric_pad
end type
type cb_2 from commandbutton within w_numeric_pad
end type
type cb_1 from commandbutton within w_numeric_pad
end type
type sle_1 from singlelineedit within w_numeric_pad
end type
end forward

global type w_numeric_pad from Window
int X=462
int Y=57
int Width=1994
int Height=961
boolean TitleBar=true
string Title="Numeric Pad"
long BackColor=12632256
WindowType WindowType=popup!
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
sle_1 sle_1
end type
global w_numeric_pad w_numeric_pad

type variables
Int iDigits
Boolean bDecPoint
Boolean bDone
Window wCallingWindow

Dec dNumber
end variables

on open;bDecPoint = False
iDigits = 0
sle_1.Text = ""

wCallingWindow = Message.PowerObjectParm
end on

on w_numeric_pad.create
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
this.sle_1=create sle_1
this.Control[]={ this.cb_14,&
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
this.sle_1}
end on

on w_numeric_pad.destroy
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
destroy(this.sle_1)
end on

type cb_14 from commandbutton within w_numeric_pad
int X=951
int Y=545
int Width=951
int Height=193
int TabOrder=100
string Text="Cancel"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dReturnedQty = 0
Close ( Parent )

//CloseWithReturn ( Parent, sle_1.Text )

end on

type cb_13 from commandbutton within w_numeric_pad
int X=951
int Y=321
int Width=951
int Height=193
int TabOrder=90
string Text="Enter"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dReturnedQty = Dec ( sle_1.Text )
Close ( Parent )
//CloseWithReturn ( Parent, sle_1.Text )
end on

type cb_12 from commandbutton within w_numeric_pad
int X=37
int Y=609
int Width=293
int Height=193
int TabOrder=70
string Text="C"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = ""
iDigits = 0
bDecPoint = False
end on

type cb_11 from commandbutton within w_numeric_pad
int X=330
int Y=609
int Width=293
int Height=193
int TabOrder=80
string Text="0"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

If sle_1.Text = "" Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "0"
end on

type cb_10 from commandbutton within w_numeric_pad
int X=622
int Y=609
int Width=293
int Height=193
int TabOrder=120
string Text="."
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 or bDecPoint Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "."

bDecPoint = True
end on

type cb_9 from commandbutton within w_numeric_pad
int X=37
int Y=417
int Width=293
int Height=193
int TabOrder=60
string Text="7"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "7"
end on

type cb_8 from commandbutton within w_numeric_pad
int X=330
int Y=417
int Width=293
int Height=193
int TabOrder=110
string Text="8"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "8"
end on

type cb_7 from commandbutton within w_numeric_pad
int X=622
int Y=417
int Width=293
int Height=193
int TabOrder=140
string Text="9"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "9"
end on

type cb_6 from commandbutton within w_numeric_pad
int X=37
int Y=225
int Width=293
int Height=193
int TabOrder=50
string Text="4"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "4"
end on

type cb_5 from commandbutton within w_numeric_pad
int X=330
int Y=225
int Width=293
int Height=193
int TabOrder=130
string Text="5"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "5"
end on

type cb_4 from commandbutton within w_numeric_pad
int X=622
int Y=225
int Width=293
int Height=193
int TabOrder=150
string Text="6"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "6"
end on

type cb_3 from commandbutton within w_numeric_pad
int X=622
int Y=33
int Width=293
int Height=193
int TabOrder=40
string Text="3"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "3"
end on

type cb_2 from commandbutton within w_numeric_pad
int X=330
int Y=33
int Width=293
int Height=193
int TabOrder=30
string Text="2"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "2"
end on

type cb_1 from commandbutton within w_numeric_pad
int X=37
int Y=33
int Width=293
int Height=193
int TabOrder=20
string Text="1"
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If iDigits >= 15 Then Return

iDigits = iDigits + 1

sle_1.Text = sle_1.Text + "1"
end on

type sle_1 from singlelineedit within w_numeric_pad
int X=951
int Y=97
int Width=951
int Height=193
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-24
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

