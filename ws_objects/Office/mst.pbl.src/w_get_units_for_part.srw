$PBExportHeader$w_get_units_for_part.srw
$PBExportComments$This window gets all of the units available to convert to for the unit sent in the following structure:~r~n~tst_return_units_for_part ----~r~n~r~n~t~tddlbName - DropDownListBox~r~n~t~tszPart - String~r~n~t~tszOriginalUnit - String
forward
global type w_get_units_for_part from Window
end type
type dw_1 from datawindow within w_get_units_for_part
end type
end forward

global type w_get_units_for_part from Window
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
global w_get_units_for_part w_get_units_for_part

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

	For lCount2 = 1 to stParm.ddlbName.TotalItems ( )

		If stParm.ddlbName.SelectItem ( lCount2 ) < 1 Then &
			MessageBox ( "Error", SQLCA.SQLErrText, Information! )

		//
		//  If selected text is same as unit get out of loop
		//

		szSelectedText = stParm.ddlbName.Text ( lCount2 )

		If szTempUnit = szSelectedText Then

			bFoundIt = True

			lCount2 = stParm.ddlbName.TotalItems ( )

		End if

	Next

	If bFoundIt = False then &
		stParm.ddlbName.AddItem ( szTempUnit )

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

	For lCount2 = 1 to stParm.ddlbName.TotalItems ( )

		stParm.ddlbName.SelectItem ( lCount2 )

		//
		//  If selected text is same as unit get out of loop
		//

		If szTempUnit = stParm.ddlbName.Text ( lCount2 ) Then

			bFoundIt = True

			lCount2 = stParm.ddlbName.TotalItems ( )

		End if

	Next

	If bFoundIt = False Then &
		stParm.ddlbName.AddItem ( szTempUnit )

Next


bFoundIt = False

For lCount2 = 1 to stParm.ddlbName.TotalItems ( )

	stParm.ddlbName.SelectItem ( lCount2 )

	//
	//  If selected text is same as unit get out of loop
	//

	If szTempUnit = stParm.ddlbName.Text ( lCount2 ) Then

		bFoundIt = True

		lCount2 = stParm.ddlbName.TotalItems ( )

	End if

Next

If bFoundIt = False Then &
	stParm.ddlbName.AddItem ( stParm.szOriginalUnit )


//
//  Close Window
//

lItem = stParm.ddlbName.FindItem ( stParm.szOriginalUnit, 1 )
stParm.ddlbName.SelectItem ( lItem )

Close ( w_get_units_for_part )
end on

on w_get_units_for_part.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_get_units_for_part.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_get_units_for_part
int X=476
int Y=449
int Width=494
int Height=361
int TabOrder=1
string DataObject="d_unit"
boolean LiveScroll=true
end type

