$PBExportHeader$w_part_qtys_per_location.srw
forward
global type w_part_qtys_per_location from Window
end type
type mle_1 from multilineedit within w_part_qtys_per_location
end type
type sle_8 from singlelineedit within w_part_qtys_per_location
end type
type st_11 from statictext within w_part_qtys_per_location
end type
type st_14 from statictext within w_part_qtys_per_location
end type
type sle_7 from singlelineedit within w_part_qtys_per_location
end type
type sle_6 from singlelineedit within w_part_qtys_per_location
end type
type sle_5 from singlelineedit within w_part_qtys_per_location
end type
type sle_4 from singlelineedit within w_part_qtys_per_location
end type
type sle_3 from singlelineedit within w_part_qtys_per_location
end type
type sle_2 from singlelineedit within w_part_qtys_per_location
end type
type sle_1 from singlelineedit within w_part_qtys_per_location
end type
type dw_2 from datawindow within w_part_qtys_per_location
end type
type dw_3 from datawindow within w_part_qtys_per_location
end type
type gb_8 from groupbox within w_part_qtys_per_location
end type
type gb_7 from groupbox within w_part_qtys_per_location
end type
type gb_6 from groupbox within w_part_qtys_per_location
end type
type gb_5 from groupbox within w_part_qtys_per_location
end type
type gb_4 from groupbox within w_part_qtys_per_location
end type
type gb_3 from groupbox within w_part_qtys_per_location
end type
type gb_2 from groupbox within w_part_qtys_per_location
end type
type gb_1 from groupbox within w_part_qtys_per_location
end type
type dw_1 from datawindow within w_part_qtys_per_location
end type
end forward

global type w_part_qtys_per_location from Window
int X=9
int Y=12
int Width=3497
int Height=1872
boolean TitleBar=true
string Title="Part: "
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
mle_1 mle_1
sle_8 sle_8
st_11 st_11
st_14 st_14
sle_7 sle_7
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
dw_2 dw_2
dw_3 dw_3
gb_8 gb_8
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
end type
global w_part_qtys_per_location w_part_qtys_per_location

type variables
st_generic_structure stParm
st_unit_conversion stUnitParm

String szPart, szStdUnit, szUnit, szStatus
String szLocation,szplant

Long lCount, lRow

Dec dQty, dQuantity
Dec dOnHand, dOnHold, dScrapped, dRejected, dObsolete
Dec dTotOnHand, dTotOnHold, dTotScrap
Dec dTotReject, dTotObsolete

Boolean bDblClick
end variables

forward prototypes
public subroutine build_row ()
end prototypes

public subroutine build_row ();lRow = lRow + 1

dw_3.InsertRow ( lRow )
//dw_3.SetItem ( lRow, "plant", szplant1 )
dw_3.SetItem ( lRow, "location", szLocation )
dw_3.SetItem ( lRow, "on_hand", dOnHand )
dw_3.SetItem ( lRow, "on_hold", dOnHold )
dw_3.SetItem ( lRow, "scrapped", dScrapped )
dw_3.SetItem ( lRow, "rejected", dRejected )
dw_3.SetItem ( lRow, "obsolete", dObsolete )

dOnHand = 0
dOnHold = 0
dScrapped = 0
dRejected = 0
dObsolete = 0

end subroutine

event timer;dw_3.Retrieve(szpart)
	
if dw_3.Retrieve(szpart) > 0 then
	
  sle_1.text = string(dw_3.GetItemNumber(1,'total_approved'))
  sle_2.text = string(dw_3.GetItemNumber(1,'total_onhold'))
  sle_3.text = string(dw_3.GetItemNumber(1,'total_scrapped'))
  sle_4.text = string(dw_3.GetItemNumber(1,'total_rejected'))
  sle_5.text = string(dw_3.GetItemNumber(1,'total_obsolete'))
  sle_6.text = string(dw_3.Rowcount())
  sle_7.text = string(dw_3.GetItemNumber(1,'total_committed'))  
  dTotOnHand  = dec ( sle_1.text )
  


  UPDATE part_online  
    SET on_hand = :dTotOnHand  
  WHERE part = :szPart   ;

  If SQLCA.SQLCode = -1 Then
	 RollBack ;
  Else
	Commit ;
  End if
  
end if

SetPointer ( Arrow! )

Timer(0)

////LONG 	l_l_count
//
//For lCount = 1 to dw_1.RowCount ( )
//
//	szUnit    = dw_1.GetItemString ( lCount, "unit_measure" )
//	szStatus  = dw_1.GetItemString ( lCount, "status" )
//	dQty      = dw_1.GetItemNumber ( lCount, "std_quantity" )
////	szplant1   = dw_1.GetItemstring ( lCount, "plant" )
//	
//	If IsNull ( dQty ) or dQty < 0 Then dQty = 0	
//	  
////	If szLocation <> dw_1.GetItemString ( lCount, "location" ) And lCount > 1 Then &
//		build_row ( )
//
//	CHOOSE CASE szStatus
//
//		CASE 'A'
//			dOnHand = dOnHand + dQty
//			dTotOnHand = dTotOnHand + dQty
//			sle_1.Text = String ( Truncate ( Dec ( sle_1.Text ) + dQty, 2 ) )
//
//		CASE 'H'
//			dOnHold = dOnHold + dQty
//			dTotOnHold = dTotOnHold + dQty
//			sle_2.Text = String ( Truncate ( Dec ( sle_2.Text ) + dQty, 2 ) )
//
//		CASE 'S'
//			dScrapped = dScrapped + dQty
//			dTotScrap = dTotScrap + dQty
//			sle_3.Text = String ( Truncate ( Dec ( sle_3.Text ) + dQty, 2 ) )
//
//		CASE 'R'
//			dRejected = dRejected + dQty
//			dTotReject = dTotReject + dQty
//			sle_4.Text = String ( Truncate ( Dec ( sle_4.Text ) + dQty, 2 ) )
//
//		CASE 'O'
//			dObsolete = dObsolete + dQty
//			dTotObsolete = dTotObsolete + dQty
//			sle_5.Text = String ( Truncate ( Dec ( sle_5.Text ) + dQty, 2 ) )
//
//	END CHOOSE
//
//	szLocation = dw_1.GetItemString ( lCount, "location" )
//  
//	sle_6.Text = String ( lCount )
//
//Next
//
//build_row ( )
//
//sle_1.Text = String ( Truncate ( dTotOnHand, 2 ) )
//sle_2.Text = String ( Truncate ( dTotOnHold, 2 ) )
//sle_3.Text = String ( Truncate ( dTotScrap, 2 ) )
//sle_4.Text = String ( Truncate ( dTotReject, 2 ) )
//sle_5.Text = String ( Truncate ( dTotObsolete, 2 ) )
//sle_6.Text = String ( dw_1.RowCount ( ) )
//
//UPDATE part_online  
//   SET on_hand = :dTotOnHand  
// WHERE part = :szPart   ;
//
//If SQLCA.SQLCode = -1 Then
//	RollBack ;
//Else
//	Commit ;
//End if
//
//SetPointer ( Arrow! )
//
//Timer ( 0 )
//
//
end event

event activate;If wMainScreen.MenuName <> "m_menu_with_only_exit" Then &
	wMainScreen.ChangeMenu ( m_menu_with_only_exit )

If bDblClick = False Then
	dw_3.Reset ( )
	sle_1.Text = ""
	sle_2.Text = ""
	sle_3.Text = ""
	sle_4.Text = ""
	sle_5.Text = ""
	sle_6.Text = ""
	sle_7.Text = ""	
	Timer ( .055 )
Else
	bDblClick = False
End if
end event

event open;//wMainScreen.ChangeMenu ( m_menu_with_only_exit )
string	ls_nsoperator, ls_nsnote

szPart = Message.StringParm
dw_3.SetTransObject(sqlca)
dw_3.Retrieve(szpart)
w_part_qtys_per_location.Title = w_part_qtys_per_location.Title + szPart

if dw_3.Retrieve(szpart) <= 0 then 
	MessageBox( monsys.msg_title, "There are no objects for this part to retrieve", Information!)
	close ( this )
else
 sle_1.text = string(dw_3.GetItemNumber(1,'total_approved'))
 sle_2.text = string(dw_3.GetItemNumber(1,'total_onhold'))
 sle_3.text = string(dw_3.GetItemNumber(1,'total_scrapped'))
 sle_4.text = string(dw_3.GetItemNumber(1,'total_rejected'))
 sle_5.text = string(dw_3.GetItemNumber(1,'total_obsolete'))
 sle_6.text = string(dw_3.Rowcount())
 sle_7.text = string(dw_3.GetItemNumber(1,'total_committed'))
 
 select	non_ship_note,
 	non_ship_operator
 into	:ls_nsnote,
 	:ls_nsoperator
 from	part_eecustom
 where	part = :szpart;
 
 sle_8.text = ls_nsoperator
 mle_1.text = ls_nsnote
 
end if

//
//  SELECT part_inventory.standard_unit  
//    INTO :szStdUnit  
//    FROM part_inventory  
//   WHERE part_inventory.part = :szPart   ;
//
//dw_1.SetTransObject ( sqlca )
//dw_2.SetTransObject ( sqlca )
//dw_3.SetTransObject ( sqlca )
//
//dw_1.Retrieve ( szPart )
//
//sle_1.Text = "0"
//sle_2.Text = "0"
//sle_3.Text = "0"
//sle_4.Text = "0"
//sle_5.Text = "0"
//sle_6.Text = "0"
//
//dTotOnHand = 0
//dTotOnHold = 0
//dTotScrap = 0
//dTotReject = 0
//dTotObsolete = 0
end event

on w_part_qtys_per_location.create
this.mle_1=create mle_1
this.sle_8=create sle_8
this.st_11=create st_11
this.st_14=create st_14
this.sle_7=create sle_7
this.sle_6=create sle_6
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.mle_1,&
this.sle_8,&
this.st_11,&
this.st_14,&
this.sle_7,&
this.sle_6,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.dw_2,&
this.dw_3,&
this.gb_8,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.dw_1}
end on

on w_part_qtys_per_location.destroy
destroy(this.mle_1)
destroy(this.sle_8)
destroy(this.st_11)
destroy(this.st_14)
destroy(this.sle_7)
destroy(this.sle_6)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
end on

type mle_1 from multilineedit within w_part_qtys_per_location
int X=2880
int Y=192
int Width=544
int Height=1348
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
boolean DisplayOnly=true
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_8 from singlelineedit within w_part_qtys_per_location
int X=3209
int Y=32
int Width=215
int Height=76
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean HideSelection=false
boolean DisplayOnly=true
long BackColor=79216776
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_part_qtys_per_location
int X=2880
int Y=32
int Width=325
int Height=76
boolean Enabled=false
string Text="NSS Operator:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_part_qtys_per_location
int X=2880
int Y=124
int Width=325
int Height=64
boolean Enabled=false
string Text="NSS Note:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_7 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=1420
int Width=695
int Height=96
int TabOrder=50
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_6 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=1184
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_5 from singlelineedit within w_part_qtys_per_location
int X=2117
int Y=960
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=736
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=512
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=288
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_part_qtys_per_location
int X=2121
int Y=64
int Width=695
int Height=96
boolean Border=false
boolean AutoHScroll=false
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_part_qtys_per_location
int X=507
int Y=1320
int Width=439
int Height=352
int TabOrder=30
boolean Visible=false
string DataObject="d_unit_conversion"
boolean LiveScroll=true
end type

type dw_3 from datawindow within w_part_qtys_per_location
int X=78
int Y=64
int Width=1952
int Height=1472
int TabOrder=10
string DataObject="d_part_qtys_per_plant"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;If lRow < 1 Then Return

//SelectRow ( dw_3, 0, False )
//SelectRow ( dw_3, Row, True )

stParm.value1 = szPart
stParm.Value2 = dw_3.GetItemString (lrow,"location")
stParm.Value3 = dw_3.GetItemString (lrow,"plant")

bDblClick = True
OpenSheetWithParm ( w_objects_per_location, stParm, wMainScreen, 3, layered! )
end event

event clicked;//Long lRow
//
//lRow = dw_3.GetClickedRow ( )
//
//If lRow < 1 Then Return
//
//SelectRow ( dw_3, 0, False )
//SelectRow ( dw_3, lRow, True )

String l_s_value
Integer l_i_pos

l_s_value = dw_3.GetBandAtPointer()

IF l_s_value > '' THEN
	l_i_pos	= Pos ( l_s_value, "~t", 1 )	
	lrow	= Long ( Right ( l_s_value,  Len ( l_s_value ) - l_i_pos ) )
END IF
end event

event constructor;SetTransObject(SQLCA)
end event

type gb_8 from groupbox within w_part_qtys_per_location
int X=2085
int Y=1356
int Width=768
int Height=192
int TabOrder=40
string Text="Total Committed:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_7 from groupbox within w_part_qtys_per_location
int X=37
int Width=2011
int Height=1552
string Text="Online Quantities:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within w_part_qtys_per_location
int X=2085
int Y=1124
int Width=768
int Height=192
string Text="Total Objects:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_part_qtys_per_location
int X=2080
int Y=896
int Width=768
int Height=192
string Text="Obsolete:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_part_qtys_per_location
int X=2085
int Y=672
int Width=768
int Height=192
string Text="Rejected:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_part_qtys_per_location
int X=2085
int Y=448
int Width=768
int Height=192
string Text="Scrapped:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_part_qtys_per_location
int X=2085
int Y=224
int Width=768
int Height=192
string Text="On Hold:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_part_qtys_per_location
int X=2085
int Width=768
int Height=192
string Text="On Hand:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_part_qtys_per_location
int X=965
int Y=1328
int Width=1189
int Height=608
boolean Visible=false
boolean BringToTop=true
string DataObject="d_calc_object_qtys_per_location"
boolean LiveScroll=true
end type

on retrievestart;lCount = 0
end on

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

