$PBExportHeader$w_part_qtys.srw
forward
global type w_part_qtys from Window
end type
type dw_1 from datawindow within w_part_qtys
end type
type cb_1 from commandbutton within w_part_qtys
end type
type rb_1 from radiobutton within w_part_qtys
end type
type st_5 from statictext within w_part_qtys
end type
type st_4 from statictext within w_part_qtys
end type
type st_3 from statictext within w_part_qtys
end type
type st_2 from statictext within w_part_qtys
end type
type st_1 from statictext within w_part_qtys
end type
type sle_5 from singlelineedit within w_part_qtys
end type
type sle_4 from singlelineedit within w_part_qtys
end type
type sle_3 from singlelineedit within w_part_qtys
end type
type sle_2 from singlelineedit within w_part_qtys
end type
type sle_1 from singlelineedit within w_part_qtys
end type
type dw_2 from datawindow within w_part_qtys
end type
end forward

global type w_part_qtys from Window
int X=672
int Y=264
int Width=2089
int Height=632
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
event calc_qtys pbm_custom01
dw_1 dw_1
cb_1 cb_1
rb_1 rb_1
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
dw_2 dw_2
end type
global w_part_qtys w_part_qtys

type variables
st_generic_structure stParm
st_unit_conversion stUnitParm

String szPart, szStdUnit, szUnit, szStatus

Long lCount

Dec dQty, dQuantity
end variables

on calc_qtys;For lCount = 1 To dw_1.RowCount ( )

szUnit = dw_1.GetItemString ( lCount, "unit_measure" )
dQuantity = dw_1.GetItemNumber ( lCount, "quantity" )
szStatus = dw_1.GetItemString ( lCount, "status" )

dw_2.Retrieve ( szPart, szStdUnit, szUnit )

If dw_2.RowCount ( ) > 0 Then

	/////////////////////////////////////////////////
	//  Convert quantity to desired unit of measurement
	//

	If szStdUnit <> szUnit Then
		If szStdUnit = dw_2.GetItemString ( 1, "unit_conversion_unit1" ) Then
			dQty = dQuantity * dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
		Else
			dQty = dQuantity / dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
		End if
	Else
		dQty = dQuantity
	End if
Else
	dQty = dQuantity
End if

CHOOSE CASE szStatus

	CASE 'A'
		sle_1.Text = String ( Dec ( sle_1.Text ) + dQty )

	CASE 'H'
		sle_2.Text = String ( Dec ( sle_2.Text ) + dQty )

	CASE 'S'
		sle_3.Text = String ( Dec ( sle_3.Text ) + dQty )

	CASE 'R'
		sle_4.Text = String ( Dec ( sle_4.Text ) + dQty )

	CASE 'O'
		sle_5.Text = String ( Dec ( sle_5.Text ) + dQty )

END CHOOSE

Next
end on

on open;stParm = Message.PowerObjectParm

szPart = stParm.Value1

  SELECT part_inventory.standard_unit  
    INTO :szStdUnit  
    FROM part_inventory  
   WHERE part_inventory.part = :szPart   ;

sle_1.Text = '0'
sle_2.Text = '0'
sle_3.Text = '0'
sle_4.Text = '0'
sle_5.Text = '0'

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )
dw_1.Retrieve ( szPart )

wChain.TriggerEvent ( "calc_qtys" )
end on

on w_part_qtys.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.rb_1=create rb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.dw_2=create dw_2
this.Control[]={this.dw_1,&
this.cb_1,&
this.rb_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.dw_2}
end on

on w_part_qtys.destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.rb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.dw_2)
end on

on activate;//wChain.TriggerEvent ( "calc_qtys" )
end on

type dw_1 from datawindow within w_part_qtys
int X=73
int Y=512
int Width=1829
int Height=576
boolean Visible=false
string DataObject="d_calc_object_qtys"
boolean LiveScroll=true
end type

on retrieveend;//For lCount = 1 To dw_1.RowCount ( )
//
//szUnit = dw_1.GetItemString ( lCount, "unit_measure" )
//dQuantity = dw_1.GetItemNumber ( lCount, "quantity" )
//szStatus = dw_1.GetItemString ( lCount, "status" )
//
//
//dw_2.SetTransObject ( sqlca )
//dw_2.Retrieve ( szPart, szStdUnit, szUnit )
//
//If dw_2.RowCount ( ) > 0 Then
//
//	/////////////////////////////////////////////////
//	//  Convert quantity to desired unit of measurement
//	//
//
//	If szStdUnit <> szUnit Then
//		If szStdUnit = dw_2.GetItemString ( 1, "unit_conversion_unit1" ) Then
//			dQty = dQuantity * dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
//		Else
//			dQty = dQuantity / dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
//		End if
//	Else
//		dQty = dQuantity
//	End if
//Else
//	dQty = dQuantity
//End if
//
//CHOOSE CASE szStatus
//
//	CASE 'A'
//		sle_1.Text = String ( Dec ( sle_1.Text ) + dQty )
//
//	CASE 'H'
//		sle_2.Text = String ( Dec ( sle_2.Text ) + dQty )
//
//	CASE 'S'
//		sle_3.Text = String ( Dec ( sle_3.Text ) + dQty )
//
//	CASE 'R'
//		sle_4.Text = String ( Dec ( sle_4.Text ) + dQty )
//
//	CASE 'O'
//		sle_5.Text = String ( Dec ( sle_5.Text ) + dQty )
//
//END CHOOSE
//
//Next
end on

on retrievestart;lCount = 0
end on

on retrieverow;//lCount = lCount + 1
//
//szUnit = dw_1.GetItemString ( lCount, "unit_measure" )
//dQuantity = dw_1.GetItemNumber ( lCount, "quantity" )
//szStatus = dw_1.GetItemString ( lCount, "status" )
//
//
//dw_2.SetTransObject ( sqlca )
//dw_2.Retrieve ( szPart, szStdUnit, szUnit )
//
////If dw_2.RowCount ( ) > 0 Then
//If dConversion
//
//	/////////////////////////////////////////////////
//	//  Convert quantity to desired unit of measurement
//	//
//
//	If szStdUnit <> szUnit Then
//		If szStdUnit = dw_2.GetItemString ( 1, "unit_conversion_unit1" ) Then
//			dQty = dQuantity * dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
//		Else
//			dQty = dQuantity / dw_2.GetItemNumber ( 1, "unit_conversion_conversion" )
//		End if
//	Else
//		dQty = dQuantity
//	End if
//Else
//	dQty = dQuantity
//End if
//
//CHOOSE CASE szStatus
//
//	CASE 'A'
//		sle_1.Text = String ( Dec ( sle_1.Text ) + dQty )
//
//	CASE 'H'
//		sle_2.Text = String ( Dec ( sle_2.Text ) + dQty )
//
//	CASE 'S'
//		sle_3.Text = String ( Dec ( sle_3.Text ) + dQty )
//
//	CASE 'R'
//		sle_4.Text = String ( Dec ( sle_4.Text ) + dQty )
//
//	CASE 'O'
//		sle_5.Text = String ( Dec ( sle_5.Text ) + dQty )
//
//END CHOOSE
//
end on

type cb_1 from commandbutton within w_part_qtys
int X=878
int Y=384
int Width=293
int Height=96
int TabOrder=10
string Text="&Done"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( wChain )
end on

type rb_1 from radiobutton within w_part_qtys
int X=37
int Y=288
int Width=425
int Height=72
string Text="By Location"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;OpenWithParm ( w_part_qtys_per_location, szPart )
end on

type st_5 from statictext within w_part_qtys
int X=1646
int Y=32
int Width=366
int Height=64
boolean Enabled=false
string Text="Obsolete"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_part_qtys
int X=1243
int Y=32
int Width=366
int Height=64
boolean Enabled=false
string Text="Rejected"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_part_qtys
int X=841
int Y=32
int Width=366
int Height=64
boolean Enabled=false
string Text="Scrapped"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_part_qtys
int X=439
int Y=32
int Width=366
int Height=64
boolean Enabled=false
string Text="On Hold"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_part_qtys
int X=41
int Y=32
int Width=366
int Height=64
boolean Enabled=false
string Text="On Hand"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_5 from singlelineedit within w_part_qtys
int X=1646
int Y=128
int Width=366
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Outlook"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_part_qtys
int X=1243
int Y=128
int Width=366
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Outlook"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_part_qtys
int X=841
int Y=128
int Width=366
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Outlook"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_part_qtys
int X=439
int Y=128
int Width=366
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Outlook"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_part_qtys
int X=37
int Y=128
int Width=366
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Outlook"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_part_qtys
int X=1243
int Y=512
int Width=494
int Height=360
int TabOrder=20
boolean Visible=false
string DataObject="d_unit_conversion"
boolean LiveScroll=true
end type

