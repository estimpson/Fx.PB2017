$PBExportHeader$w_prompt_for_invoice_detail_dropship.srw
forward
global type w_prompt_for_invoice_detail_dropship from Window
end type
type sle_qty from editmask within w_prompt_for_invoice_detail_dropship
end type
type sle_date from editmask within w_prompt_for_invoice_detail_dropship
end type
type st_1 from statictext within w_prompt_for_invoice_detail_dropship
end type
type st_2 from statictext within w_prompt_for_invoice_detail_dropship
end type
type cb_create from commandbutton within w_prompt_for_invoice_detail_dropship
end type
type cb_exit from commandbutton within w_prompt_for_invoice_detail_dropship
end type
type st_um from statictext within w_prompt_for_invoice_detail_dropship
end type
type st_4 from statictext within w_prompt_for_invoice_detail_dropship
end type
type sle_operator from singlelineedit within w_prompt_for_invoice_detail_dropship
end type
end forward

global type w_prompt_for_invoice_detail_dropship from Window
int X=727
int Y=552
int Width=983
int Height=588
boolean TitleBar=true
string Title="Record Customer Receipt"
long BackColor=79741120
WindowType WindowType=response!
sle_qty sle_qty
sle_date sle_date
st_1 st_1
st_2 st_2
cb_create cb_create
cb_exit cb_exit
st_um st_um
st_4 st_4
sle_operator sle_operator
end type
global w_prompt_for_invoice_detail_dropship w_prompt_for_invoice_detail_dropship

type variables
Window wHostWindow

Boolean bValidOperator = FALSE
end variables

on w_prompt_for_invoice_detail_dropship.create
this.sle_qty=create sle_qty
this.sle_date=create sle_date
this.st_1=create st_1
this.st_2=create st_2
this.cb_create=create cb_create
this.cb_exit=create cb_exit
this.st_um=create st_um
this.st_4=create st_4
this.sle_operator=create sle_operator
this.Control[]={this.sle_qty,&
this.sle_date,&
this.st_1,&
this.st_2,&
this.cb_create,&
this.cb_exit,&
this.st_um,&
this.st_4,&
this.sle_operator}
end on

on w_prompt_for_invoice_detail_dropship.destroy
destroy(this.sle_qty)
destroy(this.sle_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_create)
destroy(this.cb_exit)
destroy(this.st_um)
destroy(this.st_4)
destroy(this.sle_operator)
end on

event open;st_generic_structure l_st_parm

l_st_parm = message.powerobjectparm

sle_qty.text = l_st_parm.value2
st_um.text   = l_st_parm.value3
sle_date.text = string ( today() )


end event

type sle_qty from editmask within w_prompt_for_invoice_detail_dropship
int X=498
int Y=32
int Width=402
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date from editmask within w_prompt_for_invoice_detail_dropship
int X=498
int Y=128
int Width=402
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_prompt_for_invoice_detail_dropship
int X=41
int Y=32
int Width=256
int Height=64
boolean Enabled=false
string Text="Quantity"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_prompt_for_invoice_detail_dropship
int X=41
int Y=128
int Width=421
int Height=64
boolean Enabled=false
string Text="Date Received"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_create from commandbutton within w_prompt_for_invoice_detail_dropship
int X=101
int Y=368
int Width=402
int Height=96
int TabOrder=30
string Text="Create Invoice"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If bValidOperator then
	w_smart_dropship_processor.Trigger Dynamic Event create_invoice_detail &
		( Long ( sle_qty.text), date ( sle_date.text ) , sle_operator.text )
Else
	MessageBox(monsys.msg_title, "You must enter a valid password first.", StopSign!)
End If
end event

type cb_exit from commandbutton within w_prompt_for_invoice_detail_dropship
int X=562
int Y=368
int Width=302
int Height=96
int TabOrder=40
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( parent )

end event

type st_um from statictext within w_prompt_for_invoice_detail_dropship
int X=334
int Y=32
int Width=146
int Height=64
boolean Enabled=false
string Text="(UM)"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_prompt_for_invoice_detail_dropship
int X=41
int Y=224
int Width=421
int Height=64
boolean Enabled=false
string Text="Operator"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_operator from singlelineedit within w_prompt_for_invoice_detail_dropship
int X=498
int Y=224
int Width=402
int Height=80
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;String l_s_Password
String l_s_Operator

l_s_Password	= this.text

SELECT employee.operator_code  
  INTO :l_s_Operator  
  FROM employee  
 WHERE employee.password = :l_s_Password   ;

If SQLCA.SQLCode = 0 then
	bValidOperator	= TRUE
	this.password	= FALSE
	this.text		= l_s_Operator
Else
	bValidOperator	= FALSE
	this.password	= FALSE
	this.text		= "Invalid Oper"
End If

cb_create.SetFocus()
end event

