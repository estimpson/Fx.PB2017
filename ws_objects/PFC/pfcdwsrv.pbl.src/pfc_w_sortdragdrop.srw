$PBExportHeader$pfc_w_sortdragdrop.srw
$PBExportComments$PFC Drag/Drop Style Sort dialog window
forward
global type pfc_w_sortdragdrop from w_response
end type
type dw_sorted from u_dw within pfc_w_sortdragdrop
end type
type st_3 from u_st within pfc_w_sortdragdrop
end type
type st_4 from u_st within pfc_w_sortdragdrop
end type
type st_2 from u_st within pfc_w_sortdragdrop
end type
type dw_sortcolumns from u_dw within pfc_w_sortdragdrop
end type
type cb_ok from u_cb within pfc_w_sortdragdrop
end type
type cb_cancel from u_cb within pfc_w_sortdragdrop
end type
type cb_dlghelp from u_cb within pfc_w_sortdragdrop
end type
end forward

global type pfc_w_sortdragdrop from w_response
int X=1280
int Y=780
int Width=1664
int Height=848
boolean TitleBar=true
string Title="Sort"
long BackColor=80263328
dw_sorted dw_sorted
st_3 st_3
st_4 st_4
st_2 st_2
dw_sortcolumns dw_sortcolumns
cb_ok cb_ok
cb_cancel cb_cancel
cb_dlghelp cb_dlghelp
end type
global pfc_w_sortdragdrop pfc_w_sortdragdrop

type variables
Protected:
long		il_availablerow
long		il_sortingrow
n_cst_sortattrib 	inv_sortattrib
n_cst_returnattrib 	inv_return 
end variables

forward prototypes
protected function string of_BuildSortString ()
end prototypes

protected function string of_BuildSortString ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BuildSortString
//
//	Access:    		Protected
//
//	Arguments: 		None
//	
//	Returns:   		String
//   					The new sort string
//
//	Description:  	This function will construct the new sort string
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_colname
string	ls_sortitem
string 	ls_sortstring=''
integer	li_i
integer	li_max

// Loop around all rows.
li_max = dw_sorted.RowCount ( ) 
FOR li_i = 1 to li_max 
	
	// Get the column name.
	ls_colname = dw_sorted.GetItemString (li_i, "columnname")
	IF IsNull(ls_colname) or Len(Trim(ls_colname))=0 Then Continue
	
	// Determine if LookUpDisplay should be used.
	IF dw_sorted.GetItemString (li_i, "use_display" ) = "1" THEN 
		// Use LookUpDisplay.
		ls_sortitem = "LookUpDisplay(" + ls_colname + ") "
	ELSE
		// Do NOT use LookUpDisplay.
		ls_sortitem = ls_colname + " "
	END IF 

	// Append the sort order.
	ls_sortitem = ls_sortitem + dw_sorted.GetItemString (li_i, "sort_order" ) + " "

	// Create the sort criteria.
	ls_sortstring = ls_sortstring + ls_sortitem
NEXT

// Return the new sort string.
Return ls_sortstring
end function

event open;call w_response::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_sortdragdrop
//
//	Description:  A Specify Sort dialog using drag/drop for selection
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Get the PowerObject.
inv_sortattrib = Message.PowerObjectParm 

// Start the base service.
of_SetBase (true)

// Center the window.
inv_base.of_center()

// Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True
end event

on pfc_w_sortdragdrop.create
int iCurrent
call super::create
this.dw_sorted=create dw_sorted
this.st_3=create st_3
this.st_4=create st_4
this.st_2=create st_2
this.dw_sortcolumns=create dw_sortcolumns
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sorted
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_sortcolumns
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.cb_dlghelp
end on

on pfc_w_sortdragdrop.destroy
call super::destroy
destroy(this.dw_sorted)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.dw_sortcolumns)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_dlghelp)
end on

event pfc_postopen;call super::pfc_postopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event Name:  pfc_postopen
//
//	Description:  Populate the columnnames and previous sort string
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Integer 	li_i, li_sortnumcols
Integer	li_orignumcols, li_found, li_newrow
Integer	li_rc

SetPointer ( HourGlass! ) 

// Turn off re-drawing until all done.
dw_sortcolumns.SetReDraw (FALSE)

// Populate the "dw_sortcolumns" datawindow with column names.
// Loop around all the columns.
li_sortnumcols = UpperBound(inv_sortattrib.is_sortcolumns)
FOR li_i = 1 to li_sortnumcols
	// Insert a new row
	li_newrow = dw_sortcolumns.InsertRow(0) 
	// Populate the attributes for the column.
	dw_sortcolumns.SetItem(li_newrow, "columnname", inv_sortattrib.is_sortcolumns[li_i])
	dw_sortcolumns.SetItem(li_newrow, "displayname", inv_sortattrib.is_colnamedisplay[li_i]) 
	IF inv_sortattrib.ib_usedisplay[li_i] THEN
		dw_sortcolumns.SetItem ( li_newrow, "use_display", "1" ) 
	ELSE
		dw_sortcolumns.SetItem ( li_newrow, "use_display", "0" ) 
	END IF 
NEXT

// Sort dw_sortcolumns.
dw_sortcolumns.SetSort("displayname A")
dw_sortcolumns.Sort() 

// Find the current sort columns (dw_sorted) and display them as selected.
li_orignumcols = UpperBound(inv_sortattrib.is_origcolumns) 
FOR li_i = 1 to li_orignumcols
	// Find the row on dw_sortcolumns
	li_found = dw_sortcolumns.Find ( "columnname = '" + inv_sortattrib.is_origcolumns[li_i] + &
												 "'", 1, dw_sortcolumns.RowCount() ) 
	IF li_found > 0 THEN
		// Move the row from dw_sortcolumns to dw_sorted.
		li_rc = dw_sortcolumns.RowsMove ( li_found, li_found, Primary!, &
					dw_sorted, dw_sorted.RowCount()+1, Primary! )
		
		// Check the Asc/Desc sort order column
		dw_sorted.SetItem ( li_i, "sort_order", inv_sortattrib.is_origorder[li_i] ) 
	END IF 
NEXT 

// Turn off re-drawing until all done.
dw_sortcolumns.SetReDraw (TRUE)
end event

event pfc_cancel;call w_response::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_Cancel
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Set to the appropriate return code and close the dialog.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Set the return code to mean the window was closed by a cancel operation.
inv_return.ii_rc = 0

// Clear the sort string.
inv_return.is_rs = ''

// Close the window.
CloseWithReturn ( this, inv_return ) 
end event

event pfc_default;call w_response::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_Default
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Construct the new sort string and close this dialog
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Set the return code to mean succesful operation.
inv_return.ii_rc = 1

// Set the new sort string.
inv_return.is_rs = of_BuildSortString ( ) 

// Close the window.
CloseWithReturn ( this, inv_return )
end event

event close;call w_response::close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Close
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Window close.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// If the return code matches the default value,
// then window is currently being closed as a Cancel operation.
If inv_return.ii_rc=-99 Then
	this.Event pfc_Cancel ()
End If
end event

type dw_sorted from u_dw within pfc_w_sortdragdrop
int X=759
int Y=108
int Width=846
int Height=468
int TabOrder=0
string DragIcon="arrowl.ico"
string DataObject="d_sortdragdrop"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Determine if the user clicked on a column and start Drag
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
IF IsNull (dwo) or IsNull(row) or row<=0 THEN 
	Return
End If

IF dwo.name = "display_column" THEN 
	il_sortingrow = row
	
	// Start the drag.
	this.Drag ( Begin! ) 
END IF 
end event

event dragdrop;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  DragDrop!
//
//	Description:  Move the row from the "sort from" dw to the 
//					  "selected sort" dw and stop the Drag
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc
dragobject ldrg_object

ldrg_object = DraggedObject( )

// Make sure you are not dropping this object on itself!
IF TypeOf ( ldrg_object ) = DataWindow! THEN
	IF ldrg_object.ClassName ( ) = "dw_sorted" THEN 
		li_rc = this.Drag ( Cancel! ) 
		Return 
	END IF
END IF

// Move the row.
If il_availablerow > 0 Then
	li_rc = dw_sortcolumns.RowsMove ( il_availablerow, il_availablerow, Primary!, &
				this, this.RowCount()+1, Primary! )
End If

dw_sortcolumns.Drag ( End! ) 


end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Constructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Sort Columns DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetUpdateable ( FALSE ) 
ib_rmbmenu = FALSE

end event

type st_3 from u_st within pfc_w_sortdragdrop
int X=777
int Y=48
int Width=416
int Height=60
string Text="Sort Columns"
long TextColor=33554687
long BackColor=82889382
end type

type st_4 from u_st within pfc_w_sortdragdrop
int X=1262
int Y=44
int Width=338
int Height=60
string Text="Ascending"
Alignment Alignment=Right!
long TextColor=33554687
long BackColor=82889382
end type

type st_2 from u_st within pfc_w_sortdragdrop
int X=46
int Y=44
int Width=713
int Height=60
string Text="Columns Available for Sorting"
long TextColor=33554687
long BackColor=82889382
end type

type dw_sortcolumns from u_dw within pfc_w_sortdragdrop
int X=37
int Y=108
int Width=686
int Height=468
int TabOrder=0
string DragIcon="arrowr.ico"
string DataObject="d_sortdragdrop"
string Icon="arrowr.ico"
end type

event dragdrop;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  DragDrop!
//
//	Description:  Move the row from the "selected sort" dw to the 
//					  "sort from" dw and stop the Drag
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc
dragobject ldrg_object

ldrg_object = DraggedObject( )

// Make sure you are not dropping this object on itself!.
IF TypeOf ( ldrg_object ) = DataWindow! THEN
	IF ldrg_object.ClassName ( ) = "dw_sortcolumns" THEN 
		li_rc = this.Drag ( Cancel! ) 
		Return 
	END IF
END IF

// Move the row.
If il_sortingrow > 0 Then
	li_rc = dw_sorted.RowsMove ( il_sortingrow, il_sortingrow, Primary!, &
				this, this.RowCount()+1, Primary! )
End If

li_rc = this.SetSort ( "display_column A" )
li_rc = this.Sort ( ) 

dw_sorted.Drag ( End! ) 


end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Determine if the user clicked on a column and start Drag
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
IF IsNull (dwo) or IsNull(row) or row<=0 THEN 
	Return
End If

IF dwo.Name = "display_column" THEN
	il_availablerow = row
	
	// Start the drag.
	this.Drag ( Begin! ) 
END IF 
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Constructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Columns Available DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.04 Prevent the Sort_Order column from being accessible.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetUpdateable ( FALSE ) 
ib_rmbmenu = FALSE

// Prevent the Sort_Order column from being accessible.
this.Object.sort_order.Visible = 0

end event

type cb_ok from u_cb within pfc_w_sortdragdrop
int X=494
int Y=624
int TabOrder=10
string Text="OK"
boolean Default=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Perform the Default processing.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Parent.Event pfc_default()
end event

type cb_cancel from u_cb within pfc_w_sortdragdrop
int X=873
int Y=624
int TabOrder=20
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked!
//
//	Description:  	Perform the Cancel processing.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Parent.Event pfc_cancel()

end event

type cb_dlghelp from u_cb within pfc_w_sortdragdrop
int X=1253
int Y=624
int TabOrder=30
string Text="&Help"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Description:
//	Display PFC dialog help
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

showHelp ("pfcdlg.hlp", topic!, 900)
end event

