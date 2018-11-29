$PBExportHeader$w_correct_object.srw
forward
global type w_correct_object from Window
end type
type dw_2 from datawindow within w_correct_object
end type
type lb_1 from listbox within w_correct_object
end type
type cb_2 from commandbutton within w_correct_object
end type
type cb_1 from commandbutton within w_correct_object
end type
type dw_1 from datawindow within w_correct_object
end type
end forward

global type w_correct_object from Window
int X=416
int Y=456
int Width=2062
int Height=1216
boolean TitleBar=true
string Title="Correct An Object"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
dw_2 dw_2
lb_1 lb_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_correct_object w_correct_object

type variables
Long 		lSerial

String 		szOldPart
String		szOriginalUnit

DataWindowChild 	dwcPackaging

Boolean		bMessage
Boolean                 ib_Password

Dec		dOriginalQty
end variables

forward prototypes
public subroutine wf_get_units ()
public subroutine wf_get_packaging ()
end prototypes

public subroutine wf_get_units ();Long lRow

Int iLoop

lb_1 = f_get_units_for_part ( "", dw_1.GetItemString ( 1, "part" ), lb_1 )

dwcUnits.Reset ( )

For iLoop = 1 to lb_1.TotalItems ( )

	lRow = dwcUnits.RowCount( ) + 1
	dwcUnits.InsertRow ( 0 )
	lb_1.SelectItem ( iLoop )
	dwcUnits.SetItem ( lRow, "unit", lb_1.SelectedItem ( ) )

Next

end subroutine

public subroutine wf_get_packaging ();String szPart
String szPackageType

Long lRow

szPart = dw_1.GetItemString ( 1, "part" )

If szPart <> 'PALLET' then
	
		 DECLARE package_types CURSOR FOR  
		  SELECT package_materials.code  
			 FROM package_materials,   
					part_packaging  
			WHERE ( package_materials.code = part_packaging.code ) and  
					( ( part_packaging.part = :szPart ) )   
		ORDER BY package_materials.code ASC  ;

      Open package_types ;

      dwcPackaging.Reset ( )

      Do

	   Fetch package_types Into :szPackageType ;

	   if SQLCA.SQLCode = 0 Then
//		  lRow = dwcPackaging.RowCount ( )
		  lRow = dwcPackaging.InsertRow ( 0 )
		  dwcPackaging.SetItem ( lRow, "package_type", szPackageType )
	   End if

Loop While SQLCA.SQLCode = 0

Close package_types ;

else
		 DECLARE pallet_package_types CURSOR FOR  
			  SELECT package_materials.code  
				 FROM package_materials 					  
				WHERE package_materials.type = 'P' 
				ORDER BY package_materials.code ASC;
	
			  Open pallet_package_types ;
	
			 dwcPackaging.Reset ( )
	
		Do
	
			Fetch pallet_package_types Into :szPackageType ;
	
			if SQLCA.SQLCode = 0 Then
//			  lRow = dwcPackaging.RowCount ( )
			  lRow = dwcPackaging.InsertRow ( 0 )
			  dwcPackaging.SetItem ( lRow, "package_type", szPackageType )
			End if
	
	  Loop While SQLCA.SQLCode = 0
	
	  Close pallet_package_types ;
	  
end if
		
end subroutine

event open;dw_1.SetTransObject ( sqlca )

lSerial = Message.DoubleParm

IF dw_1.Retrieve ( lSerial ) > 0 Then

	dw_2.Show ( )
	dw_2.InsertRow ( 1 )
	dw_1.GetChild ( "unit_measure", dwcUnits )
	dw_1.GetChild ( "package_type", dwcPackaging )
	dw_1.SetItem ( 1, "operator", "" )
	wf_get_units ( )
	wf_get_packaging ( )
	dOriginalQty = dw_1.GetItemNumber ( 1, "std_quantity" )
	szOriginalUnit = dw_1.GetItemString ( 1, "unit_measure" )

Else

	MessageBox ( "Error", "Unable to open object file!", StopSign! )
	Close ( This )	

End if
end event

on w_correct_object.create
this.dw_2=create dw_2
this.lb_1=create lb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.lb_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_correct_object.destroy
destroy(this.dw_2)
destroy(this.lb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type dw_2 from datawindow within w_correct_object
int X=1394
int Y=880
int Width=613
int Height=88
int TabOrder=20
string DataObject="d_external_operator"
boolean Border=false
boolean LiveScroll=true
end type

on itemchanged;String szOperator, szPassword

szPassword = dw_2.GetText ( )

SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :szPassword   ;

If IsNull ( szOperator ) Or szOperator = "" Then
	bMessage = True
   MessageBox ( "Error", "Invalid Operator!~r" + szPassword + "~r" + szOperator, StopSign! )
   bMessage = False
// ib_Password = TRUE
   dw_2.SetItem ( 1, "operator", "" )
   dw_2.SetItem ( 1, "code", "" )   
	dw_2.SetFocus ( )
   Return
End IF

dw_1.SetItem ( 1, "operator", szOperator )
dw_2.SetItem ( 1, "code", szOperator )

Return

end on

type lb_1 from listbox within w_correct_object
int X=187
int Y=808
int Width=219
int Height=96
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_correct_object
int X=1102
int Y=1008
int Width=256
int Height=96
int TabOrder=40
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_correct_object
int X=773
int Y=1008
int Width=256
int Height=96
int TabOrder=30
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dec 		dQuantity
Dec 		dStdQty
Dec		dTareWeight
Dec		dRtnQty
String 	szUnit
String 	szPart
String	ls_Operator
String	szPackageType
String	ls_status
String	ls_UserDefinedStatus
Long	ll_Serial

dw_2.TriggerEvent ( ItemChanged! )		//  Event will run now if you had 
													//	 forgotten to press 'enter'
dw_1.AcceptText()

dQuantity 	= f_get_value ( dw_1.GetItemNumber ( 1, "quantity" ) )
szUnit    	= f_get_string_value ( dw_1.GetItemString ( 1, "unit_measure" ) )
szPart    	= f_get_string_value ( dw_1.GetItemString ( 1, "part" ) )
ls_Operator  	= f_get_string_value ( dw_1.GetItemString ( 1, "operator" ) )
szPackageType	= f_get_string_value ( dw_1.GetItemString ( 1, "package_type" ) )
ls_Status	= f_get_string_value ( dw_1.object.status [ 1  ]  ) 
ll_Serial	= f_get_value ( dw_1.GetItemNumber ( 1, "serial" ) )
lserial		= ll_Serial

// Checking for validity of operator code

If ls_Operator = "" Then
	Return
End If

if szUnit = '' and szpart = 'PALLET' then
		dw_1.update()
		commit;
 elseif szUnit = "" Then
	bMessage = True
	MessageBox ( "Error", "Invalid Unit of Measure!", StopSign! )
	bMessage = False
	dw_1.SetColumn ( "unit_measure" )
	dw_1.SetFocus ( )
	Return
 elseif dQuantity <= 0 Then
	bMessage = True
	MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
	bMessage = False
	dw_1.SetColumn ( "quantity" )
	dw_1.SetFocus ( )
	Return
End if

bMessage = True

dStdQty 		= f_get_value ( f_convert_units ( szUnit, "", szPart, dQuantity ) )
if dw_1.object.std_quantity [ 1 ] <> dstdqty then
	dw_1.setitem (1, 'std_quantity', dstdqty)
end if

SELECT package_materials.weight  
  INTO :dTareWeight  
  FROM package_materials  
 WHERE package_materials.code = :szPackageType   ;

SELECT user_defined_status.display_name  
  INTO :ls_UserDefinedStatus
  FROM user_defined_status  
 WHERE user_defined_status.type = :ls_Status  ;

dw_1.SetItem ( 1, "status", ls_Status )
dw_1.SetItem ( 1, "user_defined_status", ls_UserDefinedStatus )
dw_1.SetItem ( 1, "tare_weight", dTareWeight )
dw_1.SetItem ( 1, "last_date", Today ( ) )
dw_1.SetItem ( 1, "last_time", Now ( ) )
dw_1.SetItem ( 1, "operator", ls_Operator )

If dw_1.Update ( ) = -1 Then
	RollBack ;
Else

	If dStdQty > dOriginalQty Then
		dRtnQty = f_update_onhand ( szPart, dStdQty - dOriginalQty, "+*" )
		If dRtnQty = -1 Then
			RollBack ;
			Return
		End if
	Elseif dStdQty < dOriginalQty Then
		dRtnQty = f_update_onhand ( szPart, dOriginalQty - dStdQty, "-*" )
		If dRtnQty = -1 Then
			RollBack ;
			Return
		End if
	Else
		SELECT part_online.on_hand  
		  INTO :dRtnQty  
		  FROM part_online  
		 WHERE part_online.part = :szPart   ;
	End if

	If Not f_create_audit_trail ( ll_Serial, "X", String ( dRtnQty ),"","","","","","","","","No Commit" ) Then
		RollBack ;
	Else
		Commit ;
	End if

End if

bMessage = False
Close ( Parent )

end event

type dw_1 from datawindow within w_correct_object
int X=32
int Y=28
int Width=1993
int Height=956
int TabOrder=10
string DataObject="d_correct_object"
BorderStyle BorderStyle=StyleLowered!
end type

