$PBExportHeader$w_manual_down_enter.srw
forward
global type w_manual_down_enter from Window
end type
type cb_enter from commandbutton within w_manual_down_enter
end type
type st_3 from statictext within w_manual_down_enter
end type
type sle_reason from singlelineedit within w_manual_down_enter
end type
type cb_10 from commandbutton within w_manual_down_enter
end type
type cb_one_m from commandbutton within w_manual_down_enter
end type
type cb_2_m from commandbutton within w_manual_down_enter
end type
type cb_3_m from commandbutton within w_manual_down_enter
end type
type cb_4_m from commandbutton within w_manual_down_enter
end type
type cb_5_m from commandbutton within w_manual_down_enter
end type
type cb_6_m from commandbutton within w_manual_down_enter
end type
type cb_7_m from commandbutton within w_manual_down_enter
end type
type cb_8_m from commandbutton within w_manual_down_enter
end type
type cb_9_m from commandbutton within w_manual_down_enter
end type
type cb_zero_m from commandbutton within w_manual_down_enter
end type
type sle_minute from singlelineedit within w_manual_down_enter
end type
type st_2 from statictext within w_manual_down_enter
end type
type st_1 from statictext within w_manual_down_enter
end type
type cb_exit from commandbutton within w_manual_down_enter
end type
type cb_clear_m from commandbutton within w_manual_down_enter
end type
type sle_defect_quantity from singlelineedit within w_manual_down_enter
end type
type cb_zero from commandbutton within w_manual_down_enter
end type
type cb_9 from commandbutton within w_manual_down_enter
end type
type cb_8 from commandbutton within w_manual_down_enter
end type
type cb_7 from commandbutton within w_manual_down_enter
end type
type cb_6 from commandbutton within w_manual_down_enter
end type
type cb_5 from commandbutton within w_manual_down_enter
end type
type cb_4 from commandbutton within w_manual_down_enter
end type
type cb_3 from commandbutton within w_manual_down_enter
end type
type cb_2 from commandbutton within w_manual_down_enter
end type
type cb_1 from commandbutton within w_manual_down_enter
end type
type r_1 from rectangle within w_manual_down_enter
end type
type r_2 from rectangle within w_manual_down_enter
end type
end forward

global type w_manual_down_enter from Window
int X=105
int Y=252
int Width=3195
int Height=2060
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_enter cb_enter
st_3 st_3
sle_reason sle_reason
cb_10 cb_10
cb_one_m cb_one_m
cb_2_m cb_2_m
cb_3_m cb_3_m
cb_4_m cb_4_m
cb_5_m cb_5_m
cb_6_m cb_6_m
cb_7_m cb_7_m
cb_8_m cb_8_m
cb_9_m cb_9_m
cb_zero_m cb_zero_m
sle_minute sle_minute
st_2 st_2
st_1 st_1
cb_exit cb_exit
cb_clear_m cb_clear_m
sle_defect_quantity sle_defect_quantity
cb_zero cb_zero
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
r_1 r_1
r_2 r_2
end type
global w_manual_down_enter w_manual_down_enter

type variables
String sReason, sreason2, sdown_reason
String sDefectQuantity
Long NRowNumber
String is_Machine
string	is_part
string	is_workorder
end variables

forward prototypes
public subroutine addnumber (int nnumber)
public subroutine addnun (integer nnum)
public function integer getnum ()
end prototypes

public subroutine addnumber (int nnumber);int ntemp
ntemp = sle_defect_quantity.x
ntemp = ntemp + nnumber
sle_defect_quantity.x = ntemp
end subroutine

public subroutine addnun (integer nnum);sle_defect_quantity.x =nnum
end subroutine

public function integer getnum ();Return sle_defect_quantity.x
end function

event open;//	get a reason first
n_cst_associative_array lncst_aa
lncst_aa = message.powerobjectparm

is_machine = lncst_aa.of_getitem("machine")
sreason2 = lncst_aa.of_getitem("reason")
is_part = lncst_aa.of_getitem("part")

is_workorder = lncst_aa.of_getitem("workorder")

SELECT 	code_description
INTO	:sdown_reason
FROM	downtime_codes
WHERE	dt_code = :sreason2;

sle_reason.text = sdown_reason

end event

on w_manual_down_enter.create
this.cb_enter=create cb_enter
this.st_3=create st_3
this.sle_reason=create sle_reason
this.cb_10=create cb_10
this.cb_one_m=create cb_one_m
this.cb_2_m=create cb_2_m
this.cb_3_m=create cb_3_m
this.cb_4_m=create cb_4_m
this.cb_5_m=create cb_5_m
this.cb_6_m=create cb_6_m
this.cb_7_m=create cb_7_m
this.cb_8_m=create cb_8_m
this.cb_9_m=create cb_9_m
this.cb_zero_m=create cb_zero_m
this.sle_minute=create sle_minute
this.st_2=create st_2
this.st_1=create st_1
this.cb_exit=create cb_exit
this.cb_clear_m=create cb_clear_m
this.sle_defect_quantity=create sle_defect_quantity
this.cb_zero=create cb_zero
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.r_1=create r_1
this.r_2=create r_2
this.Control[]={this.cb_enter,&
this.st_3,&
this.sle_reason,&
this.cb_10,&
this.cb_one_m,&
this.cb_2_m,&
this.cb_3_m,&
this.cb_4_m,&
this.cb_5_m,&
this.cb_6_m,&
this.cb_7_m,&
this.cb_8_m,&
this.cb_9_m,&
this.cb_zero_m,&
this.sle_minute,&
this.st_2,&
this.st_1,&
this.cb_exit,&
this.cb_clear_m,&
this.sle_defect_quantity,&
this.cb_zero,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.r_1,&
this.r_2}
end on

on w_manual_down_enter.destroy
destroy(this.cb_enter)
destroy(this.st_3)
destroy(this.sle_reason)
destroy(this.cb_10)
destroy(this.cb_one_m)
destroy(this.cb_2_m)
destroy(this.cb_3_m)
destroy(this.cb_4_m)
destroy(this.cb_5_m)
destroy(this.cb_6_m)
destroy(this.cb_7_m)
destroy(this.cb_8_m)
destroy(this.cb_9_m)
destroy(this.cb_zero_m)
destroy(this.sle_minute)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_exit)
destroy(this.cb_clear_m)
destroy(this.sle_defect_quantity)
destroy(this.cb_zero)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.r_1)
destroy(this.r_2)
end on

type cb_enter from commandbutton within w_manual_down_enter
int X=1925
int Y=1592
int Width=658
int Height=256
int TabOrder=110
string Text="Enter"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
Date dTodaysDate   
Time tTimeNow
DateTime dtNow
Int nSixty
Int nDownHours
Int nDownMins
Int nSeconds
Integer pt_pos
Decimal nDownTime
Decimal nqty
String ls_downtimename
String ls_rq
String ls_rq1
String ls_part
String ls_workorder

ls_rq = string(szremqty)
pt_pos = PosA (ls_rq, ".")
ls_rq1 = LeftA(ls_rq,(pt_pos + 2))
nQty  = Dec ( ls_rq1 )

//If w_machine.dw_3.Rowcount() > 0 and w_machine.dw_2.RowCount() > 0  then
//	ls_part = f_get_string_value(w_machine.dw_3.getitemstring(1, "part"))
//	ls_workorder =  f_get_string_value(w_machine.dw_2.getitemstring(1, "work_order")) 
//End If
//

nSeconds = 0
nSixty = Integer ( sle_minute.text )

If ( nSixty > 59 ) then 

	MessageBox ( "Too Many Minutes" , "The Number of Minutes cannot exceed 59" )
	sle_minute.text = ""
	return

End  if 

// insert the record into the defect database

dTodaysDate = Today ()
tTimeNow    = Now ()
dtNow	    = DateTime (Today(),Now())

/////////////////////////////////////////////////////////////////////
//
//  If the trans is not complete display message and start over
//

nDownHours = Integer (sle_defect_quantity.text )
nDownMins  = Integer (sle_minute.text )

nDownTime =  ((nDownHours * 60) + nDownMins)/60

INSERT INTO downtime  
         ( trans_date,   
           machine,   
           reason_code,   
           reason_name,   
           down_time,   
           notes,   
           employee,   
           shift,   
           job,   
           part,   
           qty,   
           type,   
           production_pointer,   
           data_source,   
           trans_time )  
 VALUES ( :dtNow,   
           :is_machine,   
           :sReason2,   
           :sdown_reason,   
           :nDownTime,   
           null,   
           :szOperator,   
           null,   
           :is_workorder,   
           :is_part,   
           :nQty,   
           null,   
           null,   
           'MANUAL',   
           :dtNow )  ;

If SQLCA.SQLCode <> 0 then
	RollBack ;
	MessageBox ( "System Message", "Unable to save to Down Time" )
End if 

Commit;

close ( w_downtime_enter_2 )

close (w_manual_down_enter)




end event

type st_3 from statictext within w_manual_down_enter
int X=105
int Y=32
int Width=1134
int Height=128
boolean Enabled=false
string Text="Selected Reason"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_reason from singlelineedit within w_manual_down_enter
int X=1239
int Y=12
int Width=1463
int Height=160
int TabOrder=240
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_10 from commandbutton within w_manual_down_enter
int X=2345
int Y=544
int Width=329
int Height=256
int TabOrder=230
string Text="Clear"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.text = ""
end on

type cb_one_m from commandbutton within w_manual_down_enter
int X=2121
int Y=1248
int Width=219
int Height=256
int TabOrder=220
string Text="1"
boolean Cancel=true
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_one_m.text
sle_minute.text = stemp
end on

type cb_2_m from commandbutton within w_manual_down_enter
int X=1902
int Y=1248
int Width=219
int Height=256
int TabOrder=210
string Text="2"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_2_m.text
sle_minute.text = stemp
end on

type cb_3_m from commandbutton within w_manual_down_enter
int X=1682
int Y=1248
int Width=219
int Height=256
int TabOrder=200
string Text="3"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_3_m.text
sle_minute.text = stemp
end on

type cb_4_m from commandbutton within w_manual_down_enter
int X=1463
int Y=1248
int Width=219
int Height=256
int TabOrder=190
string Text="4"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_4_m.text
sle_minute.text = stemp
end on

type cb_5_m from commandbutton within w_manual_down_enter
int X=1243
int Y=1248
int Width=219
int Height=256
int TabOrder=180
string Text="5"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_5_m.text
sle_minute.text = stemp
end on

type cb_6_m from commandbutton within w_manual_down_enter
int X=1024
int Y=1248
int Width=219
int Height=256
int TabOrder=170
string Text="6"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_6_m.text
sle_minute.text = stemp
end on

type cb_7_m from commandbutton within w_manual_down_enter
int X=805
int Y=1248
int Width=219
int Height=256
int TabOrder=160
string Text="7"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_7_m.text
sle_minute.text = stemp
end on

type cb_8_m from commandbutton within w_manual_down_enter
int X=585
int Y=1248
int Width=219
int Height=256
int TabOrder=150
string Text="8"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_8_m.text
sle_minute.text = stemp
end on

type cb_9_m from commandbutton within w_manual_down_enter
int X=366
int Y=1248
int Width=219
int Height=256
int TabOrder=140
string Text="9"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_9_m.text
sle_minute.text = stemp
end on

type cb_zero_m from commandbutton within w_manual_down_enter
int X=146
int Y=1248
int Width=219
int Height=256
int TabOrder=130
string Text="0"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_minute.text
stemp = stemp + cb_zero_m.text
sle_minute.text = stemp
end on

type sle_minute from singlelineedit within w_manual_down_enter
int X=1925
int Y=928
int Width=539
int Height=288
int TabOrder=260
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_manual_down_enter
int X=146
int Y=928
int Width=1504
int Height=288
boolean Enabled=false
string Text="Enter Minutes"
Alignment Alignment=Center!
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

type st_1 from statictext within w_manual_down_enter
int X=178
int Y=232
int Width=1353
int Height=288
boolean Enabled=false
string Text="Enter Hours"
Alignment Alignment=Center!
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

type cb_exit from commandbutton within w_manual_down_enter
int X=183
int Y=1600
int Width=658
int Height=256
int TabOrder=270
string Text="Cancel"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (w_manual_down_enter)
end on

type cb_clear_m from commandbutton within w_manual_down_enter
int X=2341
int Y=1248
int Width=329
int Height=256
int TabOrder=70
string Text="Clear"
boolean Cancel=true
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
sle_minute.text = ""
end on

type sle_defect_quantity from singlelineedit within w_manual_down_enter
int X=1925
int Y=220
int Width=539
int Height=288
int TabOrder=250
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_zero from commandbutton within w_manual_down_enter
int X=146
int Y=544
int Width=219
int Height=256
int TabOrder=120
string Text="0"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_zero.text
sle_defect_quantity.text = stemp
end on

type cb_9 from commandbutton within w_manual_down_enter
int X=366
int Y=544
int Width=219
int Height=256
int TabOrder=100
string Text="9"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_9.text
sle_defect_quantity.text = stemp
end on

type cb_8 from commandbutton within w_manual_down_enter
int X=585
int Y=544
int Width=219
int Height=256
int TabOrder=90
string Text="8"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_8.text
sle_defect_quantity.text = stemp
end on

type cb_7 from commandbutton within w_manual_down_enter
int X=805
int Y=544
int Width=219
int Height=256
int TabOrder=80
string Text="7"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_7.text
sle_defect_quantity.text = stemp
end on

type cb_6 from commandbutton within w_manual_down_enter
int X=1024
int Y=544
int Width=219
int Height=256
int TabOrder=60
string Text="6"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_6.text
sle_defect_quantity.text = stemp
end on

type cb_5 from commandbutton within w_manual_down_enter
int X=1243
int Y=544
int Width=219
int Height=256
int TabOrder=50
string Text="5"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_5.text
sle_defect_quantity.text = stemp
end on

type cb_4 from commandbutton within w_manual_down_enter
int X=1463
int Y=544
int Width=219
int Height=256
int TabOrder=40
string Text="4"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!

FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_4.text
sle_defect_quantity.text = stemp
end on

type cb_3 from commandbutton within w_manual_down_enter
int X=1682
int Y=544
int Width=219
int Height=256
int TabOrder=30
string Text="3"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Addnumber ( This.x )
String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_3.text
sle_defect_quantity.text = stemp
end on

type cb_2 from commandbutton within w_manual_down_enter
int X=1902
int Y=544
int Width=219
int Height=256
int TabOrder=20
string Text="2"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_2.text
sle_defect_quantity.text = stemp
end on

type cb_1 from commandbutton within w_manual_down_enter
int X=2121
int Y=544
int Width=219
int Height=256
int TabOrder=10
string Text="1"
int TextSize=-18
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String stemp
stemp = sle_defect_quantity.text
stemp = stemp + cb_1.text
sle_defect_quantity.text = stemp
end on

type r_1 from rectangle within w_manual_down_enter
int X=110
int Y=864
int Width=2597
int Height=672
boolean Enabled=false
int LineThickness=4
long LineColor=8421504
long FillColor=77897888
end type

type r_2 from rectangle within w_manual_down_enter
int X=110
int Y=180
int Width=2597
int Height=672
boolean Enabled=false
int LineThickness=4
long LineColor=8421504
long FillColor=77897888
end type

