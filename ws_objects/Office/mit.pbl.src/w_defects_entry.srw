$PBExportHeader$w_defects_entry.srw
forward
global type w_defects_entry from Window
end type
type st_1 from statictext within w_defects_entry
end type
type cb_exit from commandbutton within w_defects_entry
end type
type st_choose_defect from statictext within w_defects_entry
end type
type dw_defects from datawindow within w_defects_entry
end type
type cb_12 from commandbutton within w_defects_entry
end type
type cb_10 from commandbutton within w_defects_entry
end type
type cb_clear from commandbutton within w_defects_entry
end type
type sle_defect_quantity from singlelineedit within w_defects_entry
end type
type cb_enter from commandbutton within w_defects_entry
end type
type cb_zero from commandbutton within w_defects_entry
end type
type cb_9 from commandbutton within w_defects_entry
end type
type cb_8 from commandbutton within w_defects_entry
end type
type cb_7 from commandbutton within w_defects_entry
end type
type cb_6 from commandbutton within w_defects_entry
end type
type cb_5 from commandbutton within w_defects_entry
end type
type cb_4 from commandbutton within w_defects_entry
end type
type cb_3 from commandbutton within w_defects_entry
end type
type cb_2 from commandbutton within w_defects_entry
end type
type cb_1 from commandbutton within w_defects_entry
end type
end forward

global type w_defects_entry from Window
int X=5
int Y=4
int Width=2866
int Height=1864
long BackColor=77897888
WindowState WindowState=maximized!
WindowType WindowType=response!
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
global w_defects_entry w_defects_entry

type variables
String 	sReason
String 	sDefectQuantity
Long 	NRowNumber
String 	szMachine
String 	szPart
String          szserial
String          sz_operator
Dec	id_Quantity
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

event open;st_generic_structure stParm

stParm = Message.PowerObjectParm

szMachine   = stParm.Value1
szPart      = stParm.Value2
id_Quantity = Dec ( stParm.Value3 )
szserial    = stparm.value4
sz_operator = stparm.value5
IF sz_operator='' or ISNULL(sz_operator) THEN SETNULL(sz_operator)
dw_defects.settransobject ( sqlca )
dw_defects.retrieve ()



end event

on w_defects_entry.create
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
this.Control[]={this.st_1,&
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

on w_defects_entry.destroy
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

type st_1 from statictext within w_defects_entry
int X=1829
int Y=36
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
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within w_defects_entry
int X=37
int Y=1544
int Width=658
int Height=256
int TabOrder=170
string Text="Cancel"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, -1 )
end on

type st_choose_defect from statictext within w_defects_entry
int X=242
int Y=36
int Width=1280
int Height=128
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Choose a Defect Code"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_defects from datawindow within w_defects_entry
int X=37
int Y=224
int Width=1755
int Height=1252
int TabOrder=120
string DataObject="dw_defects_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;// Get Reason 

nRowNumber = dw_defects.getclickedrow ( )

////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If nRowNumber = 0 Then Return

SelectRow ( dw_defects, 0, False )
SelectRow ( dw_defects, nRowNumber, True )

sReason = dw_defects.getitemstring ( nrownumber, "code" )



	



end on

type cb_12 from commandbutton within w_defects_entry
int X=2491
int Y=1220
int Width=329
int Height=256
int TabOrder=150
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_10 from commandbutton within w_defects_entry
int X=2158
int Y=1220
int Width=329
int Height=256
int TabOrder=130
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clear from commandbutton within w_defects_entry
int X=1134
int Y=1544
int Width=658
int Height=256
int TabOrder=70
string Text="Clear"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
sle_defect_quantity.text = ""
end on

type sle_defect_quantity from singlelineedit within w_defects_entry
int X=1829
int Y=228
int Width=987
int Height=192
int TabOrder=160
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_enter from commandbutton within w_defects_entry
int X=2162
int Y=1548
int Width=658
int Height=256
int TabOrder=110
string Text="Enter"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////
//
// insert the record into the defect database
//

DateTime 		dtTodaysDate   
DateTime 		dtTimeNow

dtTodaysDate = datetime(Today (),Now())
dtTimeNow    = datetime(Today (),Now())

/////////////////////////////////////////////////////////////////////
//
//  If the trans is not complete display message and start over
//

If sreason = "" then return

If Dec ( sle_defect_quantity.Text ) > id_Quantity Then
	MessageBox ( "Error", "Defect quantity must be less than object's quantity!", StopSign! )
	Return
End if

If sle_defect_quantity.text = "" then return

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
   VALUES ( :szMachine,   
            :szPart,   
            :sreason,   
            :sle_defect_quantity.text,   
            :sz_operator,   
            null,   
            null,   
            :szserial,   
            :dtTodaysDate,   
            :dtTimeNow )  ; 

If SQLCA.SQLCode = -1 then
	MessageBox ("SQL error", SQLCA.SQLErrText,Information!)
	Return
end if

CloseWithReturn ( Parent, sle_defect_quantity.Text + "/" + sReason )
end event

type cb_zero from commandbutton within w_defects_entry
int X=1829
int Y=1220
int Width=329
int Height=256
int TabOrder=140
string Text="0"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If LenA ( sle_defect_quantity.Text ) > 0 Then &
	sle_defect_quantity.Text = sle_defect_quantity.Text + '0'

end on

type cb_9 from commandbutton within w_defects_entry
int X=2491
int Y=452
int Width=329
int Height=256
int TabOrder=100
string Text="9"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '9'

end on

type cb_8 from commandbutton within w_defects_entry
int X=2158
int Y=452
int Width=329
int Height=256
int TabOrder=90
string Text="8"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '8'

end on

type cb_7 from commandbutton within w_defects_entry
int X=1829
int Y=452
int Width=329
int Height=256
int TabOrder=80
string Text="7"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '7'

end on

type cb_6 from commandbutton within w_defects_entry
int X=2491
int Y=708
int Width=329
int Height=256
int TabOrder=60
string Text="6"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '6'

end on

type cb_5 from commandbutton within w_defects_entry
int X=2158
int Y=708
int Width=329
int Height=256
int TabOrder=50
string Text="5"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '5'

end on

type cb_4 from commandbutton within w_defects_entry
int X=1829
int Y=708
int Width=329
int Height=256
int TabOrder=40
string Text="4"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '4'

end on

type cb_3 from commandbutton within w_defects_entry
int X=2491
int Y=964
int Width=329
int Height=256
int TabOrder=30
string Text="3"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '3'

end on

type cb_2 from commandbutton within w_defects_entry
int X=2158
int Y=964
int Width=329
int Height=256
int TabOrder=20
string Text="2"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '2'

end on

type cb_1 from commandbutton within w_defects_entry
int X=1829
int Y=964
int Width=329
int Height=256
int TabOrder=10
string Text="1"
int TextSize=-22
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_defect_quantity.Text = sle_defect_quantity.Text + '1'

end on

