$PBExportHeader$w_get_units_for_part_po_version.srw
forward
global type w_get_units_for_part_po_version from Window
end type
type dw_1 from datawindow within w_get_units_for_part_po_version
end type
end forward

global type w_get_units_for_part_po_version from Window
int X=673
int Y=265
int Width=1555
int Height=965
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
dw_1 dw_1
end type
global w_get_units_for_part_po_version w_get_units_for_part_po_version

type variables
st_return_units_for_part stParm
end variables

on open;//
//  Declare Variables
//

st_return_units_for_part stParm

String szTempUnit, szSelectedText

Long lCount, lCount2, lItem

Boolean bFoundIt


//
//  Initialize Variables
//

stParm = Message.PowerObjectParm

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( stParm.szPart, stParm.szOriginalUnit )


//
//  Loop through first unit in dw_1
//

For lCount = 1 to dw_1.RowCount ( )
	

	//
	//  Get units of measure
	//

	szTempUnit = dw_1.GetItemString ( lCount, "unit_conversion_unit1" )

	//
	//  Loop through drop down list box and look for units
	//

	bFoundIt = False

	For lCount2 = 1 to dwcUnits.RowCount ( )

		//
		//  If selected text is same as unit get out of loop
		//

		szSelectedText = dwcUnits.GetItemString ( lCount2, "data" )

		If szTempUnit = szSelectedText Then

			bFoundIt = True

			lCount2 = dwcUnits.RowCount ( )

		End if

	Next

	If bFoundIt = False then
		dwcUnits.InsertRow ( 1 )
		dwcUnits.SetItem ( 1, "data", szTempUnit )
		dwcUnits.SetSort ( "data A" )
		dwcUnits.Sort ( )
	End if

Next


//
//  Loop through second unit in dw_1
//

For lCount = 1 to dw_1.RowCount ( )

	//
	//  Get units of measure
	//

	szTempUnit = dw_1.GetItemString ( lCount, "unit_conversion_unit2" )

	//
	//  Loop through drop down list box and look for units
	//

	bFoundIt = False

	For lCount2 = 1 to dwcUnits.RowCount ( )

		//
		//  If selected text is same as unit get out of loop
		//

		szSelectedText = dwcUnits.GetItemString ( lCount2, "data" )

		If szTempUnit = szSelectedText Then

			bFoundIt = True

			lCount2 = dwcUnits.RowCount ( )

		End if

	Next

	If bFoundIt = False Then
		dwcUnits.InsertRow ( 1 )
		dwcUnits.SetItem ( 1, "data", szTempUnit )
		dwcUnits.SetSort ( "unit A" )
		dwcUnits.Sort ( )
	End if

Next


//
//  Search For Parameter in list and add if not found
//

bFoundIt = False

For lCount2 = 1 to dwcUnits.RowCount ( )

	//
	//  If selected text is same as unit get out of loop
	//

	If stParm.szOriginalUnit = dwcUnits.GetItemString ( lCount2, "data" ) Then

		bFoundIt = True

		lCount2 = dwcUnits.RowCount ( )

	End if

Next

If bFoundIt = False Then
	dwcUnits.InsertRow ( 1 )
	dwcUnits.SetItem ( 1, "data", stParm.szOriginalUnit )
	dwcUnits.SetSort ( "unit A" )
	dwcUnits.Sort ( )
End if


//
//  Close Window
//

Close ( This )
end on

on w_get_units_for_part_po_version.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_get_units_for_part_po_version.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_get_units_for_part_po_version
int X=403
int Y=353
int Width=494
int Height=361
int TabOrder=1
string DataObject="d_unit"
boolean LiveScroll=true
end type

