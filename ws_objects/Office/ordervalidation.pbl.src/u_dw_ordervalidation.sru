$PBExportHeader$u_dw_ordervalidation.sru
forward
global type u_dw_ordervalidation from u_dw_base
end type
end forward

global type u_dw_ordervalidation from u_dw_base
end type
global u_dw_ordervalidation u_dw_ordervalidation

forward prototypes
public function long getpreviousselectedrow (long al_row)
end prototypes

public function long getpreviousselectedrow (long al_row);//	Description:
//	Reports the number of the previous highlighted row before a specified
//	row in a DataWindow control or DataStore object.
//	
//	Controls:
//	u_dw_base
//	
//	Syntax:
//	dwcontrol.GetSelectedRow( row )
//	Argument	Description
//	dwcontrol	The name of the DataWindow control, DataStore, or child DataWindow in which you want to obtain the number of a selected row
//	row	A long identifying the location of the row after which you want to search for the next selected row
//	Return value 
//	Long. Returns the number of the first row that is selected after row in  dwcontrol. Returns 0 if no row is selected after the specified row. If any argument's value is NULL, GetSelectedRow returns NULL.
//	Usage 
//	Rows are not automatically selected, that is, highlighted, when they become current. You can select a row by calling the SelectRow function.
//	GetSelectedRow begins it search after the specified row. It doesn't matter whether row itself is selected.

//  Declarations.
LONG	ll_rowcounter

//	If al_row is zero, then set it to the rowcount.
IF al_row = 0 THEN
	al_row = RowCount ( ) + 1
END IF

//  Loop until selected row found.
ll_rowcounter = al_row
DO
	ll_rowcounter --
LOOP UNTIL IsSelected ( ll_rowcounter ) OR ll_rowcounter = 0

Return ll_rowcounter
end function

