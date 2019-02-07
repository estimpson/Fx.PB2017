$PBExportHeader$w_number_enter.srw
$PBExportComments$Enter Defects
forward
global type w_number_enter from Window
end type
type cb_return from commandbutton within w_number_enter
end type
type st_1 from statictext within w_number_enter
end type
type cb_exit from commandbutton within w_number_enter
end type
type st_choose_defect from statictext within w_number_enter
end type
type dw_defects from datawindow within w_number_enter
end type
type cb_12 from commandbutton within w_number_enter
end type
type cb_10 from commandbutton within w_number_enter
end type
type cb_clear from commandbutton within w_number_enter
end type
type sle_defect_quantity from singlelineedit within w_number_enter
end type
type cb_enter from commandbutton within w_number_enter
end type
type cb_zero from commandbutton within w_number_enter
end type
type cb_9 from commandbutton within w_number_enter
end type
type cb_8 from commandbutton within w_number_enter
end type
type cb_7 from commandbutton within w_number_enter
end type
type cb_6 from commandbutton within w_number_enter
end type
type cb_5 from commandbutton within w_number_enter
end type
type cb_4 from commandbutton within w_number_enter
end type
type cb_3 from commandbutton within w_number_enter
end type
type cb_2 from commandbutton within w_number_enter
end type
type cb_1 from commandbutton within w_number_enter
end type
end forward

global type w_number_enter from Window
int X=105
int Y=252
int Width=3195
int Height=2060
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_return cb_return
st_1 st_1
cb_exit cb_exit
st_choose_defect st_choose_defect
dw_defects dw_defects
cb_12 cb_12
cb_10 cb_10
cb_clear cb_clear
sle_defect_quantity sle_defect_quantity
cb_enter cb_enter
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
end type
global w_number_enter w_number_enter

type variables
String sReason
String sDefectQuantity
Long NRowNumber
string	is_machine, &
	is_workorder, &
	is_part, &
	is_operator
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

event open;n_cst_associative_array	lncst_aa
lncst_aa = message.powerobjectparm

is_machine = lncst_aa.of_getitem("machine")
is_workorder = lncst_aa.of_getitem("workorder")
is_part = lncst_aa.of_getitem("part")
is_operator = lncst_aa.of_getitem("operator")

dw_defects.settransobject ( sqlca )
dw_defects.retrieve ()


end event

on close;w_part_production.total_scrapped ( )
end on

on w_number_enter.create
this.cb_return=create cb_return
this.st_1=create st_1
this.cb_exit=create cb_exit
this.st_choose_defect=create st_choose_defect
this.dw_defects=create dw_defects
this.cb_12=create cb_12
this.cb_10=create cb_10
this.cb_clear=create cb_clear
this.sle_defect_quantity=create sle_defect_quantity
this.cb_enter=create cb_enter
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
this.Control[]={this.cb_return,&
this.st_1,&
this.cb_exit,&
this.st_choose_defect,&
this.dw_defects,&
this.cb_12,&
this.cb_10,&
this.cb_clear,&
this.sle_defect_quantity,&
this.cb_enter,&
this.cb_zero,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_number_enter.destroy
destroy(this.cb_return)
destroy(this.st_1)
destroy(this.cb_exit)
destroy(this.st_choose_defect)
destroy(this.dw_defects)
destroy(this.cb_12)
destroy(this.cb_10)
destroy(this.cb_clear)
destroy(this.sle_defect_quantity)
destroy(this.cb_enter)
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
end on

type cb_return from commandbutton within w_number_enter
int X=2487
int Y=1552
int Width=658
int Height=256
int TabOrder=120
string Text="Exit"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (w_number_enter)
end event

type st_1 from statictext within w_number_enter
int X=2158
int Y=32
int Width=987
int Height=128
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Enter Qty"
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

type cb_exit from commandbutton within w_number_enter
int X=37
int Y=1552
int Width=658
int Height=256
int TabOrder=170
string Text="Cancel"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (w_number_enter)
end on

type st_choose_defect from statictext within w_number_enter
int X=37
int Y=32
int Width=2085
int Height=128
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Choose a Defect Code"
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

type dw_defects from datawindow within w_number_enter
int X=37
int Y=224
int Width=2085
int Height=1248
int TabOrder=120
string DataObject="dw_defects_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;// Get Reason 

nRowNumber = getclickedrow ( )

////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

SelectRow ( 0, FALSE )

If ( nRowNumber = 0 ) Then Return

SelectRow ( nRowNumber, TRUE )

sReason = dw_defects.getitemstring ( nrownumber, "code" )



	



end on

type cb_12 from commandbutton within w_number_enter
int X=2816
int Y=1216
int Width=329
int Height=256
int TabOrder=150
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_10 from commandbutton within w_number_enter
int X=2487
int Y=1216
int Width=329
int Height=256
int TabOrder=130
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clear from commandbutton within w_number_enter
int X=850
int Y=1552
int Width=658
int Height=256
int TabOrder=70
string Text="Clear"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sle_defect_quantity.text = ""
end event

type sle_defect_quantity from singlelineedit within w_number_enter
int X=2158
int Y=224
int Width=987
int Height=192
int TabOrder=160
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

type cb_enter from commandbutton within w_number_enter
int X=1682
int Y=1552
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

event clicked;Date dTodaysDate   
Time tTimeNow
DateTime dtNow
String	ls_ErrText
dec	l_dec_qty
dTodaysDate = Today ()
tTimeNow    = Now ()
dtNow       = DateTime(Today(),Now())

If ( w_number_enter.sreason = "" ) then 
	Messagebox("Warning!","Invalid reason code")
ElseIf ( sle_defect_quantity.text = "" ) then 
	Messagebox("Warning!","Invalid quantity")
Else
	l_dec_qty = Dec ( sle_defect_quantity.text )
	  INSERT INTO defects  
         ( machine,   
           part,   
           reason,   
           quantity,   
           operator,   
           shift,   
           work_order,   
           data_source,   
           defect_date,   
           defect_time )  
	  VALUES ( :is_machine,
           :is_part,
           :w_number_enter.sreason,   
           :l_dec_qty,   
           :is_operator,
           null,   
           :is_workorder,
           null,   
           :dtNow,   
           :dtNow )  ;
	If SQLCA.SQLCode <> 0 then
		ls_ErrText = SQLCA.SQLErrText
		RollBack ;
		MessageBox ("SQL error", ls_ErrText,Information!)
	Else
		commit;
		dw_defects.SelectRow ( 0, FALSE )		
	end if
End if 	
sle_defect_quantity.text = ""

end event

type cb_zero from commandbutton within w_number_enter
int X=2158
int Y=1216
int Width=329
int Height=256
int TabOrder=140
string Text="0"
int TextSize=-20
int Weight=400
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

type cb_9 from commandbutton within w_number_enter
int X=2816
int Y=448
int Width=329
int Height=256
int TabOrder=100
string Text="9"
int TextSize=-20
int Weight=400
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

type cb_8 from commandbutton within w_number_enter
int X=2487
int Y=448
int Width=329
int Height=256
int TabOrder=90
string Text="8"
int TextSize=-20
int Weight=400
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

type cb_7 from commandbutton within w_number_enter
int X=2158
int Y=448
int Width=329
int Height=256
int TabOrder=80
string Text="7"
int TextSize=-20
int Weight=400
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

type cb_6 from commandbutton within w_number_enter
int X=2816
int Y=704
int Width=329
int Height=256
int TabOrder=60
string Text="6"
int TextSize=-20
int Weight=400
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

type cb_5 from commandbutton within w_number_enter
int X=2487
int Y=704
int Width=329
int Height=256
int TabOrder=50
string Text="5"
int TextSize=-20
int Weight=400
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

type cb_4 from commandbutton within w_number_enter
int X=2158
int Y=704
int Width=329
int Height=256
int TabOrder=40
string Text="4"
int TextSize=-20
int Weight=400
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

type cb_3 from commandbutton within w_number_enter
int X=2816
int Y=960
int Width=329
int Height=256
int TabOrder=30
string Text="3"
int TextSize=-20
int Weight=400
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

type cb_2 from commandbutton within w_number_enter
int X=2487
int Y=960
int Width=329
int Height=256
int TabOrder=20
string Text="2"
int TextSize=-20
int Weight=400
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

type cb_1 from commandbutton within w_number_enter
int X=2158
int Y=960
int Width=329
int Height=256
int TabOrder=10
string Text="1"
int TextSize=-20
int Weight=400
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

