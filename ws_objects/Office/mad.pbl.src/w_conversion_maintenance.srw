$PBExportHeader$w_conversion_maintenance.srw
forward
global type w_conversion_maintenance from Window
end type
type st_4 from statictext within w_conversion_maintenance
end type
type st_3 from statictext within w_conversion_maintenance
end type
type st_2 from statictext within w_conversion_maintenance
end type
type sle_code from singlelineedit within w_conversion_maintenance
end type
type dw_units from datawindow within w_conversion_maintenance
end type
type st_1 from statictext within w_conversion_maintenance
end type
type dw_conversions from datawindow within w_conversion_maintenance
end type
end forward

global type w_conversion_maintenance from Window
int X=5
int Y=16
int Width=2011
int Height=1520
boolean TitleBar=true
string Title="Unit Conversion Maintenance"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_save pbm_custom01
event ue_exit pbm_custom02
event ue_clear pbm_custom03
event ue_delete pbm_custom04
st_4 st_4
st_3 st_3
st_2 st_2
sle_code sle_code
dw_units dw_units
st_1 st_1
dw_conversions dw_conversions
end type
global w_conversion_maintenance w_conversion_maintenance

type variables
Int iNodes
Int iElements
Int iNumberOfUnits
Int iNumberOfQtys
Int iCounter

Dec nQtys[9]

String szUnit[10]
String szCode

Long lCurrentRow

Boolean bChanged
Boolean bSave
end variables

forward prototypes
public subroutine wf_hide_all_nodes ()
public subroutine wf_draw_conversions ()
public subroutine wf_draw_line ()
public subroutine wf_draw_node (string data)
public subroutine wf_create_records ()
public subroutine wf_delete_old_records ()
public subroutine wf_reset_arrays ()
public subroutine wf_delete_node ()
public subroutine wf_reset_node (integer iNodeFrom)
public function boolean wf_search_for_duplicates (string szsearchforunit)
public function boolean wf_create_arrays ()
public function boolean wf_check_for_base (string szUnit1, string szUnit2)
public subroutine wf_draw_qty (decimal dqty)
end prototypes

event ue_save;If sle_code.Text = "" Then

	sle_code.SetFocus ( )
	Return

ElseIf bChanged Then

	If dw_conversions.AcceptText ( ) = -1 Then
      bChanged = True 
		Return

   Else
   szCode = sle_code.Text 
	If Not wf_create_arrays ( ) Then Return
	wf_delete_old_records ( )
	wf_create_records ( )
	bSave = True
	bChanged = False
   Timer ( .5, w_conversion_part_link )
	End If

End if



end event

event ue_exit;Int iRtnCode

If Not bChanged Then
	Close (This)
ELSE
	iRtnCode = MessageBox ( "Warning", "Do you want to save the changes?", Exclamation!, YesNoCancel!, 3 )

   Choose Case iRtnCode
   Case 1 
		TriggerEvent ( clicked! )

      If iRtnCode = 1 AND bChanged = True Then
          Return
          dw_conversions.SetFocus ( )
      End If
	Case 3
      Return
	End Choose
	Close ( This )
END IF


end event

event ue_clear;If sle_code.Text = "" Then 
	sle_code.SetFocus ( )
	Return
End if

wf_hide_all_nodes ( )
wf_reset_arrays ( )
bChanged = True
end event

event ue_delete;If sle_code.Text = "" Then 
	sle_code.SetFocus ( )
	Return
End if

wf_delete_node ( )
bChanged = True
end event

public subroutine wf_hide_all_nodes ();dw_conversions.Modify ( "line1.Visible='0'" )
dw_conversions.Modify ( "line2.Visible='0'" )
dw_conversions.Modify ( "line3.Visible='0'" )
dw_conversions.Modify ( "line4.Visible='0'" )
dw_conversions.Modify ( "line5.Visible='0'" )
dw_conversions.Modify ( "line6.Visible='0'" )
dw_conversions.Modify ( "line7.Visible='0'" )
dw_conversions.Modify ( "line8.Visible='0'" )
dw_conversions.Modify ( "line9.Visible='0'" )
dw_conversions.Modify ( "unit1.Visible='0'" )
dw_conversions.Modify ( "unit2.Visible='0'" )
dw_conversions.Modify ( "unit3.Visible='0'" )
dw_conversions.Modify ( "unit4.Visible='0'" )
dw_conversions.Modify ( "unit5.Visible='0'" )
dw_conversions.Modify ( "unit6.Visible='0'" )
dw_conversions.Modify ( "unit7.Visible='0'" )
dw_conversions.Modify ( "unit8.Visible='0'" )
dw_conversions.Modify ( "unit9.Visible='0'" )
dw_conversions.Modify ( "unit10.Visible='0'" )
dw_conversions.Modify ( "qty1.Visible='0'" )
dw_conversions.Modify ( "qty2.Visible='0'" )
dw_conversions.Modify ( "qty3.Visible='0'" )
dw_conversions.Modify ( "qty4.Visible='0'" )
dw_conversions.Modify ( "qty5.Visible='0'" )
dw_conversions.Modify ( "qty6.Visible='0'" )
dw_conversions.Modify ( "qty7.Visible='0'" )
dw_conversions.Modify ( "qty8.Visible='0'" )
dw_conversions.Modify ( "qty9.Visible='0'" )

end subroutine

public subroutine wf_draw_conversions ();Int iSequence
String szUnit1, szUnit2
Dec dConversion

 DECLARE unit_conversions CURSOR FOR  
  SELECT unit_conversion.unit1,   
         unit_conversion.unit2,   
         unit_conversion.conversion,   
         unit_conversion.sequence  
    FROM unit_conversion  
   WHERE ( unit_conversion.code = :sle_code.Text ) AND  
         ( unit_conversion.sequence > 0 )   
ORDER BY unit_conversion.sequence ASC  ;


Open unit_conversions ;

iNodes = 1

Do
	Fetch unit_conversions Into :szUnit1, :szUnit2, :dConversion, :iSequence ;
	If SQLCA.SQLCode = 0 Then
		If Not wf_search_for_duplicates ( szUnit1 ) Then
			wf_draw_node ( szUnit1 )
			iNodes++
		End if
		If Not wf_search_for_duplicates ( szUnit2 ) Then
			wf_draw_node ( szUnit2 )
			If iNodes > 1 Then
				wf_draw_line ( )
				wf_draw_qty ( dConversion )
			End if
			iNodes++
		End if
	End if	
Loop While SQLCA.SQLCode = 0

Close unit_conversions ;

iNodes --
end subroutine

public subroutine wf_draw_line ();String szRtnCode

szRtnCode = dw_conversions.Modify ( "line" + String ( iNodes - 1 ) + ".Visible='1'" )

If szRtnCode <> "" Then &
	MessageBox ( "Error", szRtnCode )
end subroutine

public subroutine wf_draw_node (string data);String szRtnCode

szRtnCode = dw_conversions.Modify ( "unit" + String ( iNodes ) + ".Visible='1'" )

If szRtnCode <> "" Then Return

dw_conversions.SetItem ( 1, iNodes, data )
end subroutine

public subroutine wf_create_records ();Int iToUnit = 0
Int iFromUnit = 0
Int iRecordNumber
Int iSequence = 0
Int iWriteSeq

Dec nForwardQty
Dec nReverseQty


For iFromUnit = 1 to iNumberOfUnits

	nReverseQty = 1
	nForwardQty = 1

	For iToUnit = ( iFromUnit + 1 ) to iNumberOfUnits

		nReverseQty = nReverseQty * 1 / nQtys[iToUnit - 1]
		nForwardQty = nForwardQty * nQtys[iToUnit - 1]

		If wf_check_for_base ( szUnit[iFromUnit], szUnit[iToUnit] ) Then
			iSequence++
			iWriteSeq = iSequence
		Else
			iWriteSeq = 0
		End if

		iRecordNumber++
	   INSERT INTO unit_conversion  
    			    ( code,   
		            unit1,   
		            unit2,   
		            conversion,   
		            sequence )  
		   VALUES ( :szCode,   
		            :szUnit[iFromUnit],   
		            :szUnit[iToUnit],   
		            :nForwardQty,   
		            :iWriteSeq )  ;

		If SQLCA.SQLCode = -1 Then
			RollBack ;
			Return
		End if

		iRecordNumber++
	   INSERT INTO unit_conversion  
		          ( code,   
		            unit1,   
		 	         unit2,   
		            conversion,   
 		            sequence )  
		   VALUES ( :szCode,   
		            :szUnit[iToUnit],   
		            :szUnit[iFromUnit],   
		            :nReverseQty,   
		            0 )  ;

		If SQLCA.SQLCode = -1 Then
			RollBack ;
			Return
		End if

		Commit ;
		
	Next

Next


end subroutine

public subroutine wf_delete_old_records ();DELETE FROM unit_conversion  
 WHERE code = :szCode   ;

end subroutine

public subroutine wf_reset_arrays ();Int iCount

For iCount = 1 to 10
	szUnit[iCount] = ""
	If iCount < 10 Then &
		nQtys[iCount]  = 0
Next

iNodes = 0
end subroutine

public subroutine wf_delete_node ();String szRtnCode

dw_conversions.Modify ( "unit" + String ( iNodes ) + ".Visible='0'" )
If iNodes > 1 Then
	dw_conversions.Modify ( "qty" + String ( iNodes - 1 ) + ".Visible='0'" )
	dw_conversions.Modify ( "line" + String ( iNodes - 1 ) + ".Visible='0'" )
	wf_reset_node ( iNodes )
End if

iNodes --

If iNodes > 1 Then
	dw_conversions.SetColumn ( 10 + ( iNodes - 1 ) )
	dw_conversions.SetFocus ( )
End if
end subroutine

public subroutine wf_reset_node (integer iNodeFrom);Int iCount

For iCount = iNodeFrom to iNodes
	szUnit[iCount] = ""
	nQtys[iCount - 1]  = 0
Next
end subroutine

public function boolean wf_search_for_duplicates (string szsearchforunit);Int iCount
String szTempUnit

For iCount = 1 to ( iNodes - 1 )
	szTempUnit = dw_conversions.GetItemString ( 1, iCount )
	If szSearchForUnit = szTempUnit Then Return True
Next

Return False
end function

public function boolean wf_create_arrays ();/*  Declare Variables  */

Int  iCount
Dec  dTempQty


/*  Initialize Variables  */

iNumberOfUnits = iNodes
iNumberOfQtys  = iNodes - 1


/*  Main  */

For iCount = 1 to ( iNodes - 1 ) 
	dTempQty = f_get_value ( dw_conversions.GetItemNumber ( 1, 10 + iCount ) )
	If dTempQty <= 0 Then
		MessageBox ( "Error", "Conversion quantity must be greater than 0!", StopSign! )
		dw_conversions.SetColumn ( 10 + iCount )
		Return False
	End if
Next

For iCount = 1 to iNodes
	szUnit[iCount] = dw_conversions.GetItemString ( 1, iCount )
	If iCount < iNodes Then nQtys[iCount] = dw_conversions.GetItemNumber ( 1, iCount + 10 )
Next

Return True
end function

public function boolean wf_check_for_base (string szUnit1, string szUnit2);Int iCount

For iCount = 1 to ( iNodes - 1 )
	If szUnit1 = szUnit[iCount] And szUnit2 = szUnit[iCount + 1] Then &
		Return True
Next

Return False
end function

public subroutine wf_draw_qty (decimal dqty);String szRtnCode

dw_conversions.AcceptText ( )

szRtnCode = dw_conversions.Modify ( "qty" + String ( iNodes - 1 ) + ".Visible='1'" )

If szRtnCode <> "" Then Return

dw_conversions.Modify ( "qty" + String ( iNodes - 1 ) + ".TabSequence=" + String ( ( iNodes - 1 ) * 10 ) )
dw_conversions.SetItem ( 1, 10 + ( iNodes - 1 ), dQty )
dw_conversions.SetColumn ( 10 + ( iNodes - 1 ) )
dw_conversions.SetFocus ( )
end subroutine

event open;/*  Declare Variables  */

dw_units.SetTransObject ( sqlca )
dw_units.Retrieve ( )


/*  Initialize Variables  */

sle_code.Text = Message.StringParm

wf_hide_all_nodes ( )

dw_conversions.InsertRow ( 1 )

If sle_code.Text <> "" Then
	wf_draw_conversions ( )
End if

end event

on w_conversion_maintenance.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.sle_code=create sle_code
this.dw_units=create dw_units
this.st_1=create st_1
this.dw_conversions=create dw_conversions
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.sle_code,&
this.dw_units,&
this.st_1,&
this.dw_conversions}
end on

on w_conversion_maintenance.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_code)
destroy(this.dw_units)
destroy(this.st_1)
destroy(this.dw_conversions)
end on

event activate;IF gnv_App.of_GetFrame().MenuName <> "m_part_unit_conversion_build" then &
	gnv_App.of_GetFrame().ChangeMenu ( m_part_unit_conversion_build )
end event

type st_4 from statictext within w_conversion_maintenance
int X=41
int Y=1304
int Width=1458
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="List Unit Conversions from Largest to Smallest"
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

type st_3 from statictext within w_conversion_maintenance
int X=1449
int Y=160
int Width=421
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Units"
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

type st_2 from statictext within w_conversion_maintenance
int X=73
int Y=32
int Width=526
int Height=96
boolean Enabled=false
string Text="Conversion Code:"
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

type sle_code from singlelineedit within w_conversion_maintenance
int X=658
int Y=32
int Width=567
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=10
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on losefocus;szCode = sle_code.Text
end on

event modified;bchanged = true
end event

type dw_units from datawindow within w_conversion_maintenance
int X=1449
int Y=256
int Width=421
int Height=1028
int TabOrder=20
string DragIcon="MONITOR.ICO"
string DataObject="d_unit_of_measure_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;/*  Declare Variables  */

/*  Initialize Variables  */

If sle_code.Text = "" Then 
	sle_code.SetFocus ( )
	Return
End if

lCurrentRow = dw_units.GetClickedRow ( )


/*  Main  */

If lCurrentRow < 1 Then Return

SelectRow ( dw_units, 0, False )
SelectRow ( dw_units, lCurrentRow, True )

dw_units.Drag ( Begin! )
end on

type st_1 from statictext within w_conversion_maintenance
int X=37
int Y=160
int Width=1390
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Unit Conversions"
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

type dw_conversions from datawindow within w_conversion_maintenance
int X=37
int Y=256
int Width=1390
int Height=1028
int TabOrder=30
string DataObject="d_external_graphic_new_unit_conversion"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemchanged;bChanged = True
end on

on editchanged;bchanged = True
end on

on dragdrop;/*  Declare Variables  */


/*  Initialize Variables  */

iNodes++


/*  Main  */

If wf_search_for_duplicates ( dw_units.GetItemString ( lCurrentRow, "unit" ) ) Then
	MessageBox ( "Error", "The unit you chose is already in your conversion!", StopSign! )
	iNodes --
	Return
End if

wf_draw_node ( dw_units.GetItemString ( lCurrentRow, "unit" ) )
If iNodes > 1 Then
	wf_draw_line ( )
	wf_draw_qty ( 0 )
End if

bChanged = True

end on

on clicked;If sle_code.Text = "" Then 
	sle_code.SetFocus ( )
	Return
End if

end on

