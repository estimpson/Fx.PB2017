$PBExportHeader$w_conversion_part_link.srw
forward
global type w_conversion_part_link from w_sheet_4t
end type
type dw_part_conversion_list from datawindow within w_conversion_part_link
end type
type dw_conversion_include_std_unit from datawindow within w_conversion_part_link
end type
type st_3 from statictext within w_conversion_part_link
end type
type st_1 from statictext within w_conversion_part_link
end type
type p_2 from picture within w_conversion_part_link
end type
type p_1 from picture within w_conversion_part_link
end type
type st_2 from statictext within w_conversion_part_link
end type
type dw_conversion_list from datawindow within w_conversion_part_link
end type
end forward

global type w_conversion_part_link from w_sheet_4t
integer height = 1560
string title = "Unit Conversion"
string menuname = "m_part_unit_conversion"
event delete_conversion pbm_custom01
dw_part_conversion_list dw_part_conversion_list
dw_conversion_include_std_unit dw_conversion_include_std_unit
st_3 st_3
st_1 st_1
p_2 p_2
p_1 p_1
st_2 st_2
dw_conversion_list dw_conversion_list
end type
global w_conversion_part_link w_conversion_part_link

type variables
String szStdUnit
String szPart
String szCode

SingleLineEdit sleUnit[50]

Line lnLink[50]

Long lCurrentPartRow
Long lCurrentConversionRow

Boolean bOpened
end variables

forward prototypes
public subroutine wf_init ()
public subroutine wf_dw_setup ()
public subroutine wf_set_dw_color ()
public subroutine wf_attach_units_to_part ()
public subroutine wf_detach_units_from_part ()
public function boolean wf_check_for_duplicate_entries (string szconversioncode, string szpartnumber)
public function boolean wf_check_for_std_unit (string szconversioncode, string szstdunit)
public subroutine wf_select_records_for_code (long lrow)
end prototypes

event delete_conversion;Int iRtnCode

If szCode = "" Then Return

iRtnCode = MessageBox ( "Delete", "Are you sure about deleting~r" + &
											 szCode + " Conversion?", Question!, YesNo!, 2 )

If iRtnCode = 1 Then

	DELETE FROM unit_conversion  
    WHERE code = :szCode   ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		MessageBox ( "Error", "Delete failed!", StopSign! )
		Return
	End if

	  DELETE FROM part_unit_conversion  
   WHERE code = :szCode   ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		MessageBox ( "Error", "Delete failed!", StopSign! )
		Return
	End if

	Commit ;

	wf_dw_setup ( )

End if
end event

public subroutine wf_init ();/*  Initialize Graphic Objects  */

SELECT part_inventory.standard_unit  
  INTO :szStdUnit
  FROM part_inventory  
 WHERE part_inventory.part = :szPart   ;

This.Title = This.Title + " /  Part:" + szPart + " - Std. Unit:" + szStdUnit


end subroutine

public subroutine wf_dw_setup ();/*  Declare Variables  */
DECLARE mp_unit_conversion CURSOR FOR  
  SELECT code,   
         unit1,   
         unit2,   
         conversion,   
         sequence  
    FROM unit_conversion  
   WHERE sequence > 0  
ORDER BY code ASC, sequence ASC ;

String szUnit1, szUnit2
String szExpression
String szAttached

Dec dConversion

Int iRtnCode
Int iSequence

/*  Initialize Variables  */

dw_part_conversion_list.SetTransObject ( sqlca )
dw_part_conversion_list.Retrieve ( szPart )
dw_conversion_list.Reset ( )

/*  Main  */

OPEN mp_unit_conversion ; 

FETCH mp_unit_conversion 
INTO :szCode, :szUnit1, :szUnit2, :dConversion, :iSequence ;

DO 
	IF SQLCA.SQLCODE = 0 THEN

		szExpression = "code = ~'" + szCode + "~'"
		iRtnCode = dw_part_conversion_list.Find ( szExpression, 1, dw_part_conversion_list.RowCount ( ) )

		If iRtnCode > 0 Then
			szAttached = "Y"
		Else
			szAttached = "N"
		End if

		dw_conversion_list.InsertRow ( 1 )
		dw_conversion_list.SetItem ( 1, "code", szCode )
		dw_conversion_list.SetItem ( 1, "unit1", szUnit1 )
		dw_conversion_list.SetItem ( 1, "unit2", szUnit2 )
		dw_conversion_list.SetItem ( 1, "conversion", dConversion )
		dw_conversion_list.SetItem ( 1, "attached", szAttached )
		dw_conversion_list.SetItem ( 1, "sequence", iSequence )

		FETCH NEXT mp_unit_conversion 
		INTO :szCode, :szUnit1, :szUnit2, :dConversion, :iSequence ;

	END IF

LOOP WHILE SQLCA.SQLCODE = 0

CLOSE mp_unit_conversion ; 

dw_conversion_list.SetSort ( "code A, sequence A" )
dw_conversion_list.Sort ( )



end subroutine

public subroutine wf_set_dw_color ();String szRtnCode

szRtnCode = dw_conversion_list.Modify ( "code.color='0~tIf(attached=~~'Y~~', 255, 0 )'" )

end subroutine

public subroutine wf_attach_units_to_part ();/*  Declare Variables  */

Long lCurrentRow


/*  Initialize Variables  */


/*  Main  */

szCode = ""

For lCurrentRow = 1 to dw_conversion_list.RowCount ( )

	If dw_conversion_list.IsSelected ( lCurrentRow ) Then

		szCode = dw_conversion_list.GetItemString ( lCurrentRow, "code" )
		lCurrentRow = dw_conversion_list.RowCount ( )

	End if

Next

If szCode = "" Then Return

If wf_check_for_std_unit ( szCode, szStdUnit ) Then

	If dw_part_conversion_list.find ( "code = ~'" + szCode + "~'", 1, dw_part_conversion_list.RowCount ( ) ) < 1 Then

		If wf_check_for_duplicate_entries ( szCode, szPart ) Then
			MessageBox ( "Error", "A link in this conversion conflicts with " + &
						          "another conversion attatched to this part!", StopSign! )
			Return
		End if

		dw_part_conversion_list.InsertRow ( 1 )
		dw_part_conversion_list.SetItem ( 1, "code", szCode )
		dw_part_conversion_list.SetItem ( 1, "part", szPart )
	
		If dw_part_conversion_list.Update ( ) = -1 Then
			RollBack ;
		Else
			Commit ;
		End if

	Else

		MessageBox ( "Error", "This conversion is already attatched to part: " + szPart + "!", StopSign! )
		Return

	End if

	wf_dw_setup ( )

Else

	MessageBox ( "Error", "This conversion does not contain the standard unit of measure!  Please re-check conversion.", StopSign! )
	Return

End if

end subroutine

public subroutine wf_detach_units_from_part ();/*  Declare Variables  */

Long lCurrentRow


/*  Initialize Variables  */


/*  Main  */

For lCurrentRow = 1 to dw_conversion_list.RowCount ( )

	If dw_conversion_list.IsSelected ( lCurrentRow ) Then

		szCode = dw_conversion_list.GetItemString ( lCurrentRow, "code" )
		lCurrentRow = dw_conversion_list.RowCount ( )

	End if

Next

DELETE FROM part_unit_conversion  
 WHERE ( part = :szPart ) AND  
       ( code = :szCode )   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit ;
End if

wf_dw_setup ( )
end subroutine

public function boolean wf_check_for_duplicate_entries (string szconversioncode, string szpartnumber);String szCurrentUnit1, szCurrentUnit2
String szNewUnit1, szNewUnit2

 DECLARE conversions_by_code CURSOR FOR  
  SELECT unit1,   
         unit2  
    FROM unit_conversion  
   WHERE code = :szConversionCode   ;

DECLARE conversions_by_part CURSOR FOR  
  SELECT unit1,   
         unit2  
    FROM part_unit_conversion,   
         unit_conversion  
   WHERE ( part_unit_conversion.code = unit_conversion.code ) and  
         ( ( part_unit_conversion.part = :szPartNumber ) AND  
         ( part_unit_conversion.code = :szConversionCode ) )   ;

Open conversions_by_code ;

FETCH conversions_by_code
INTO :szCurrentUnit1, :szCurrentUnit2 ;

Do

	If SQLCA.SQLCode = 0 Then
		OPEN conversions_by_part ;
		Do
			FETCH conversions_by_part
			INTO :szNewUnit1, :szNewUnit2 ;
			If SQLCA.SQLCode = 0 Then
				If szCurrentUnit1 = szNewUnit1 And &
					szCurrentUnit2 = szNewUnit2 Then
						Close conversions_by_code ;
						Close conversions_by_part ;
						Return True
				End if
			End if
		LOOP While SQLCA.SQLCode = 0
		CLOSE conversions_by_part ;
	End if

	FETCH conversions_by_code
	INTO :szCurrentUnit1, :szCurrentUnit2 ;
Loop While SQLCA.SQLCode = 0

Close conversions_by_code ;

Return False
end function

public function boolean wf_check_for_std_unit (string szconversioncode, string szstdunit);dw_conversion_include_std_unit.SetTransObject ( sqlca )
dw_conversion_include_std_unit.Retrieve ( szConversionCode, szStdUnit )

If dw_conversion_include_std_unit.RowCount ( ) < 1 Then 
	Return False
Else
	Return True
End if
end function

public subroutine wf_select_records_for_code (long lrow);/*  Declare Variables  */

Long lCurrentRow
Long lStartRow

String szCodeCheck


/*  Intitialize Variables  */


/*  Main  */

If lRow < 1 Then 
	dw_conversion_list.SelectRow ( 0, False )
	szCode = ""
	Return
End if

SelectRow ( dw_conversion_list, 0, False )
SelectRow ( dw_conversion_list, lRow, True )

szCode = dw_conversion_list.GetItemString ( lRow, "code" )

lStartRow = dw_conversion_list.find ( "code = ~'" + szCode + "~'", 1, lRow + 1 )

For lCurrentRow = lStartRow to dw_conversion_list.RowCount ( )

	szCodeCheck = dw_conversion_list.GetItemString ( lCurrentRow, "code" )

	If szCodeCheck = szCode Then

		SelectRow ( dw_conversion_list, lCurrentRow, True )

	End if

Next


end subroutine

on open;/*  Grab argument  */

szPart = TRIM(Message.StringParm)

/*  Initialize screen  */

wf_init ( )
wf_dw_setup ( )
wf_set_dw_color ( )
end on

on timer;Timer ( 0, This )

If wf_check_for_duplicate_entries ( szCode, szPart ) Then

	MessageBox ( "Error", "A link in this conversion conflicts with " + &
					          "another conversion attatched to this part!", StopSign! )

   DELETE FROM part_unit_conversion  
    WHERE ( part = :szPart ) AND  
  	       ( code = :szCode )   ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
	Else
		Commit ;
	End if

End if

wf_dw_setup ( )


end on

on w_conversion_part_link.create
int iCurrent
call super::create
if this.MenuName = "m_part_unit_conversion" then this.MenuID = create m_part_unit_conversion
this.dw_part_conversion_list=create dw_part_conversion_list
this.dw_conversion_include_std_unit=create dw_conversion_include_std_unit
this.st_3=create st_3
this.st_1=create st_1
this.p_2=create p_2
this.p_1=create p_1
this.st_2=create st_2
this.dw_conversion_list=create dw_conversion_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_part_conversion_list
this.Control[iCurrent+2]=this.dw_conversion_include_std_unit
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_conversion_list
end on

on w_conversion_part_link.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_part_conversion_list)
destroy(this.dw_conversion_include_std_unit)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.dw_conversion_list)
end on

type dw_part_conversion_list from datawindow within w_conversion_part_link
boolean visible = false
integer x = 18
integer y = 1504
integer width = 530
integer height = 364
string dataobject = "d_part_unit_conversion_list"
boolean livescroll = true
end type

type dw_conversion_include_std_unit from datawindow within w_conversion_part_link
boolean visible = false
integer x = 585
integer y = 1508
integer width = 494
integer height = 360
integer taborder = 10
string dataobject = "d_conversions_with_std_unit_included"
boolean livescroll = true
end type

type st_3 from statictext within w_conversion_part_link
integer x = 347
integer y = 1280
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Detach"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_conversion_part_link
integer x = 37
integer y = 1280
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Attach"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_2 from picture within w_conversion_part_link
integer x = 347
integer y = 1040
integer width = 265
integer height = 232
string picturename = "clear1.bmp"
boolean border = true
boolean focusrectangle = false
end type

on dragdrop;wf_detach_units_from_part ( )
end on

type p_1 from picture within w_conversion_part_link
integer x = 32
integer y = 1040
integer width = 265
integer height = 232
string picturename = "unit.bmp"
boolean border = true
boolean focusrectangle = false
end type

on dragdrop;wf_attach_units_to_part ( )
end on

type st_2 from statictext within w_conversion_part_link
integer x = 37
integer y = 32
integer width = 1481
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Possible Unit Conversions"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_conversion_list from datawindow within w_conversion_part_link
integer x = 37
integer y = 112
integer width = 1481
integer height = 896
integer taborder = 20
string dragicon = "MONITOR.ICO"
string dataobject = "d_external_unit_conversion_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on clicked;Long lRow

lRow = dw_conversion_list.GetClickedRow ( )

If lRow < 1 Then
	szCode = ""
	Return
End if

wf_select_records_for_code ( lRow )

Drag ( Begin! )

end on

event doubleclicked;/*  Declare Variables  */

Long lRow


/*  Initialize variables  */

lRow = row

If lRow < 1 Then 
	szCode = ""
	Return
End if

wf_select_records_for_code ( lRow )
szCode = dw_conversion_list.GetItemString ( lRow, "code" )

bOpened = True

OpenSheetWithParm ( w_conversion_maintenance, szCode, gnv_App.of_GetFrame(), 3, Original! )
end event

