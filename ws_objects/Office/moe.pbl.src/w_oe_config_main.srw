$PBExportHeader$w_oe_config_main.srw
forward
global type w_oe_config_main from Window
end type
type cb_3 from commandbutton within w_oe_config_main
end type
type cb_2 from commandbutton within w_oe_config_main
end type
type cb_1 from commandbutton within w_oe_config_main
end type
type sle_31 from singlelineedit within w_oe_config_main
end type
type st_8 from statictext within w_oe_config_main
end type
type sle_30 from singlelineedit within w_oe_config_main
end type
type sle_29 from singlelineedit within w_oe_config_main
end type
type sle_28 from singlelineedit within w_oe_config_main
end type
type st_7 from statictext within w_oe_config_main
end type
type sle_27 from singlelineedit within w_oe_config_main
end type
type sle_26 from singlelineedit within w_oe_config_main
end type
type st_6 from statictext within w_oe_config_main
end type
type sle_25 from singlelineedit within w_oe_config_main
end type
type st_5 from statictext within w_oe_config_main
end type
type st_4 from statictext within w_oe_config_main
end type
type sle_24 from singlelineedit within w_oe_config_main
end type
type sle_23 from singlelineedit within w_oe_config_main
end type
type sle_22 from singlelineedit within w_oe_config_main
end type
type sle_21 from singlelineedit within w_oe_config_main
end type
type sle_20 from singlelineedit within w_oe_config_main
end type
type sle_19 from singlelineedit within w_oe_config_main
end type
type sle_18 from singlelineedit within w_oe_config_main
end type
type sle_17 from singlelineedit within w_oe_config_main
end type
type sle_16 from singlelineedit within w_oe_config_main
end type
type st_3 from statictext within w_oe_config_main
end type
type rb_1 from radiobutton within w_oe_config_main
end type
type sle_15 from singlelineedit within w_oe_config_main
end type
type st_2 from statictext within w_oe_config_main
end type
type sle_14 from singlelineedit within w_oe_config_main
end type
type st_1 from statictext within w_oe_config_main
end type
type sle_13 from singlelineedit within w_oe_config_main
end type
type sle_12 from singlelineedit within w_oe_config_main
end type
type sle_11 from singlelineedit within w_oe_config_main
end type
type sle_10 from singlelineedit within w_oe_config_main
end type
type sle_9 from singlelineedit within w_oe_config_main
end type
type sle_8 from singlelineedit within w_oe_config_main
end type
type sle_7 from singlelineedit within w_oe_config_main
end type
type sle_6 from singlelineedit within w_oe_config_main
end type
type sle_5 from singlelineedit within w_oe_config_main
end type
type sle_4 from singlelineedit within w_oe_config_main
end type
type sle_3 from singlelineedit within w_oe_config_main
end type
type sle_2 from singlelineedit within w_oe_config_main
end type
type sle_1 from singlelineedit within w_oe_config_main
end type
type gb_1 from groupbox within w_oe_config_main
end type
end forward

global type w_oe_config_main from Window
int X=1
int Y=1
int Width=2935
int Height=1921
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_31 sle_31
st_8 st_8
sle_30 sle_30
sle_29 sle_29
sle_28 sle_28
st_7 st_7
sle_27 sle_27
sle_26 sle_26
st_6 st_6
sle_25 sle_25
st_5 st_5
st_4 st_4
sle_24 sle_24
sle_23 sle_23
sle_22 sle_22
sle_21 sle_21
sle_20 sle_20
sle_19 sle_19
sle_18 sle_18
sle_17 sle_17
sle_16 sle_16
st_3 st_3
rb_1 rb_1
sle_15 sle_15
st_2 st_2
sle_14 sle_14
st_1 st_1
sle_13 sle_13
sle_12 sle_12
sle_11 sle_11
sle_10 sle_10
sle_9 sle_9
sle_8 sle_8
sle_7 sle_7
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
gb_1 gb_1
end type
global w_oe_config_main w_oe_config_main

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_oe_config_main )
end on

on w_oe_config_main.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_31=create sle_31
this.st_8=create st_8
this.sle_30=create sle_30
this.sle_29=create sle_29
this.sle_28=create sle_28
this.st_7=create st_7
this.sle_27=create sle_27
this.sle_26=create sle_26
this.st_6=create st_6
this.sle_25=create sle_25
this.st_5=create st_5
this.st_4=create st_4
this.sle_24=create sle_24
this.sle_23=create sle_23
this.sle_22=create sle_22
this.sle_21=create sle_21
this.sle_20=create sle_20
this.sle_19=create sle_19
this.sle_18=create sle_18
this.sle_17=create sle_17
this.sle_16=create sle_16
this.st_3=create st_3
this.rb_1=create rb_1
this.sle_15=create sle_15
this.st_2=create st_2
this.sle_14=create sle_14
this.st_1=create st_1
this.sle_13=create sle_13
this.sle_12=create sle_12
this.sle_11=create sle_11
this.sle_10=create sle_10
this.sle_9=create sle_9
this.sle_8=create sle_8
this.sle_7=create sle_7
this.sle_6=create sle_6
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.gb_1=create gb_1
this.Control[]={ this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_31,&
this.st_8,&
this.sle_30,&
this.sle_29,&
this.sle_28,&
this.st_7,&
this.sle_27,&
this.sle_26,&
this.st_6,&
this.sle_25,&
this.st_5,&
this.st_4,&
this.sle_24,&
this.sle_23,&
this.sle_22,&
this.sle_21,&
this.sle_20,&
this.sle_19,&
this.sle_18,&
this.sle_17,&
this.sle_16,&
this.st_3,&
this.rb_1,&
this.sle_15,&
this.st_2,&
this.sle_14,&
this.st_1,&
this.sle_13,&
this.sle_12,&
this.sle_11,&
this.sle_10,&
this.sle_9,&
this.sle_8,&
this.sle_7,&
this.sle_6,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.gb_1}
end on

on w_oe_config_main.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_31)
destroy(this.st_8)
destroy(this.sle_30)
destroy(this.sle_29)
destroy(this.sle_28)
destroy(this.st_7)
destroy(this.sle_27)
destroy(this.sle_26)
destroy(this.st_6)
destroy(this.sle_25)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_24)
destroy(this.sle_23)
destroy(this.sle_22)
destroy(this.sle_21)
destroy(this.sle_20)
destroy(this.sle_19)
destroy(this.sle_18)
destroy(this.sle_17)
destroy(this.sle_16)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.sle_15)
destroy(this.st_2)
destroy(this.sle_14)
destroy(this.st_1)
destroy(this.sle_13)
destroy(this.sle_12)
destroy(this.sle_11)
destroy(this.sle_10)
destroy(this.sle_9)
destroy(this.sle_8)
destroy(this.sle_7)
destroy(this.sle_6)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.gb_1)
end on

type cb_3 from commandbutton within w_oe_config_main
int X=2305
int Y=737
int Width=439
int Height=129
int TabOrder=160
string Text="Schedule"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_oe_config_main
int X=2305
int Y=385
int Width=439
int Height=129
int TabOrder=120
string Text="ReCalc"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_oe_config_main
int X=2305
int Y=65
int Width=439
int Height=129
int TabOrder=110
string Text="Mini-COP"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_31 from singlelineedit within w_oe_config_main
int X=1317
int Y=545
int Width=476
int Height=97
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="WIDE BEVEL"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_oe_config_main
int X=805
int Y=545
int Width=238
int Height=97
boolean Enabled=false
string Text="RADIUS"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_30 from singlelineedit within w_oe_config_main
int X=1829
int Y=545
int Width=293
int Height=97
int TabOrder=190
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1.75"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_29 from singlelineedit within w_oe_config_main
int X=1829
int Y=449
int Width=293
int Height=97
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="2.25"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_28 from singlelineedit within w_oe_config_main
int X=1829
int Y=353
int Width=293
int Height=97
int TabOrder=150
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="4.00"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_oe_config_main
int X=1866
int Y=161
int Width=156
int Height=97
boolean Enabled=false
string Text="TIME"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_27 from singlelineedit within w_oe_config_main
int X=1829
int Y=257
int Width=293
int Height=97
int TabOrder=100
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="3.10"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_26 from singlelineedit within w_oe_config_main
int X=1134
int Y=257
int Width=659
int Height=97
int TabOrder=130
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="6 CUT MIX"
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_oe_config_main
int X=805
int Y=257
int Width=307
int Height=97
boolean Enabled=false
string Text="FORMULA"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_25 from singlelineedit within w_oe_config_main
int X=1500
int Y=353
int Width=293
int Height=97
int TabOrder=140
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1.25"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_oe_config_main
int X=1317
int Y=353
int Width=156
int Height=97
boolean Enabled=false
string Text="I.D."
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_oe_config_main
int X=805
int Y=353
int Width=147
int Height=97
boolean Enabled=false
string Text="O.D."
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_24 from singlelineedit within w_oe_config_main
int X=988
int Y=353
int Width=293
int Height=97
int TabOrder=200
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="6~""
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_23 from singlelineedit within w_oe_config_main
int X=293
int Y=545
int Width=476
int Height=97
int TabOrder=180
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="MACHINE"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_22 from singlelineedit within w_oe_config_main
int X=293
int Y=449
int Width=476
int Height=97
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="FURNACE"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_21 from singlelineedit within w_oe_config_main
int X=293
int Y=353
int Width=476
int Height=97
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="MOLD"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_20 from singlelineedit within w_oe_config_main
int X=293
int Y=257
int Width=476
int Height=97
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="KIT/MIX"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_19 from singlelineedit within w_oe_config_main
int X=147
int Y=545
int Width=147
int Height=97
int TabOrder=170
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="4"
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_18 from singlelineedit within w_oe_config_main
int X=147
int Y=449
int Width=147
int Height=97
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="3"
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_17 from singlelineedit within w_oe_config_main
int X=147
int Y=353
int Width=147
int Height=97
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="2"
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_16 from singlelineedit within w_oe_config_main
int X=147
int Y=257
int Width=147
int Height=97
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1"
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_oe_config_main
int X=1939
int Y=1057
int Width=183
int Height=65
boolean Enabled=false
string Text="Finish"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_oe_config_main
int X=1793
int Y=1345
int Width=805
int Height=97
string Text="Schedule Shipment"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_15 from singlelineedit within w_oe_config_main
int X=1134
int Y=1345
int Width=586
int Height=97
int TabOrder=330
BorderStyle BorderStyle=StyleRaised!
boolean AutoHScroll=false
string Text="04/26/95  10:45 AM"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_oe_config_main
int X=74
int Y=1345
int Width=1025
int Height=97
boolean Enabled=false
boolean Border=true
string Text="Required Ship Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_14 from singlelineedit within w_oe_config_main
int X=74
int Y=769
int Width=2195
int Height=97
int TabOrder=250
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_oe_config_main
int X=74
int Y=1249
int Width=1025
int Height=97
boolean Enabled=false
boolean Border=true
string Text="Predicted Completion Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_13 from singlelineedit within w_oe_config_main
int X=1134
int Y=1249
int Width=586
int Height=97
int TabOrder=320
BorderStyle BorderStyle=StyleRaised!
boolean AutoHScroll=false
string Text="04/25/95  10:45 AM"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_12 from singlelineedit within w_oe_config_main
int X=1719
int Y=1153
int Width=330
int Height=97
int TabOrder=310
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_11 from singlelineedit within w_oe_config_main
int X=1390
int Y=1057
int Width=330
int Height=97
int TabOrder=280
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_10 from singlelineedit within w_oe_config_main
int X=1171
int Y=961
int Width=220
int Height=97
int TabOrder=240
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_9 from singlelineedit within w_oe_config_main
int X=951
int Y=865
int Width=220
int Height=97
int TabOrder=340
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_8 from singlelineedit within w_oe_config_main
int X=330
int Y=1153
int Width=659
int Height=97
int TabOrder=300
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_7 from singlelineedit within w_oe_config_main
int X=330
int Y=1057
int Width=549
int Height=97
int TabOrder=270
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_6 from singlelineedit within w_oe_config_main
int X=330
int Y=961
int Width=366
int Height=97
int TabOrder=230
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_5 from singlelineedit within w_oe_config_main
int X=74
int Y=1153
int Width=247
int Height=89
int TabOrder=290
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="M400"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_oe_config_main
int X=74
int Y=1057
int Width=247
int Height=89
int TabOrder=260
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="M300"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_oe_config_main
int X=74
int Y=961
int Width=247
int Height=89
int TabOrder=220
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="M200"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_oe_config_main
int X=74
int Y=865
int Width=247
int Height=89
int TabOrder=350
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="M100"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_oe_config_main
int X=330
int Y=865
int Width=586
int Height=97
int TabOrder=210
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_oe_config_main
int X=74
int Y=33
int Width=2195
int Height=737
int TabOrder=10
string Text="Customer Specifications:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

