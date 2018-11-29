$PBExportHeader$pfc_w_sortmulti.srw
$PBExportComments$PFC DDLB-style Sort dialog window
forward
global type pfc_w_sortmulti from w_response
end type
type dw_sort from u_dw within pfc_w_sortmulti
end type
type cb_add from u_cb within pfc_w_sortmulti
end type
type cb_delete from u_cb within pfc_w_sortmulti
end type
type cb_insert from u_cb within pfc_w_sortmulti
end type
type cb_ok from u_cb within pfc_w_sortmulti
end type
type cb_cancel from u_cb within pfc_w_sortmulti
end type
type gb_sort from u_gb within pfc_w_sortmulti
end type
type cb_dlghelp from u_cb within pfc_w_sortmulti
end type
end forward

global type pfc_w_sortmulti from w_response
int Width=1856
int Height=948
boolean TitleBar=true
string Title="Sort"
long BackColor=80263328
dw_sort dw_sort
cb_add cb_add
cb_delete cb_delete
cb_insert cb_insert
cb_ok cb_ok
cb_cancel cb_cancel
gb_sort gb_sort
cb_dlghelp cb_dlghelp
end type
global pfc_w_sortmulti pfc_w_sortmulti

type variables
Protected:
datawindowchild	idwc_cols
n_cst_sortattrib	inv_sortattrib
n_cst_returnattrib 	inv_return 
end variables

forward prototypes
public function string of_buildsortstring ()
end prototypes

public function string of_buildsortstring ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BuildSortString
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		String
//   					The new sort string
//
//	Description:  	Construct a new sort string based on criteria entered
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
string 	ls_asc_desc, ls_sort_expr, ls_colname
int 		li_i, li_rcount, li_found_row

li_rcount = dw_sort.RowCount ( )

FOR li_i = 1 to li_rcount
	ls_asc_desc = dw_sort.GetItemString ( li_i,"sort_order")
	li_found_row = idwc_cols.Find ( 'display_column = "' + dw_sort.GetItemString(li_i,"display_column") + '"', &
								1, idwc_cols.RowCount () )
	IF li_found_row > 0 THEN 
		ls_colname = idwc_cols.GetItemString ( li_found_row, "columnname" ) 
	END IF 
	
	IF Trim(ls_colname) <> "" THEN
		IF idwc_cols.GetItemString ( li_found_row, "use_display" ) = "1" THEN 
			ls_sort_expr = ls_sort_expr + "LookUpDisplay(" + ls_colname + ") " + &
								ls_asc_desc + " "
		ELSE 
			ls_sort_expr = ls_sort_expr + ls_colname + " " + ls_asc_desc + " "
		END IF 
	END IF
NEXT

Return Trim ( ls_sort_expr )
end function

event open;call w_response::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_w_sortmulti
//
//	Description:  A Specify Sort dialog in a dropdownlistbox style,
//					  reminiscent of the PB3 Sort Dialog.
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

// Get the PowerObject
inv_sortattrib = Message.PowerObjectParm

// Start the base service.
of_SetBase (true)

// Center the window.
inv_base.of_Center()

// Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

end event

on pfc_w_sortmulti.create
int iCurrent
call super::create
this.dw_sort=create dw_sort
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_sort=create gb_sort
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sort
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.gb_sort
this.Control[iCurrent+8]=this.cb_dlghelp
end on

on pfc_w_sortmulti.destroy
call super::destroy
destroy(this.dw_sort)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_sort)
destroy(this.cb_dlghelp)
end on

event pfc_postopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_postopen
//
//	Description:  Set up the datawindow with column names and previous sort.
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
integer 	li_num_cols, li_found, li_i
integer 	li_numcols_sort, li_newrow
Integer	li_rc
string 	ls_display

SetPointer ( HourGlass! ) 

// Turn off re-drawing until all done.
dw_sort.SetReDraw (FALSE)

// Get dddw reference.
dw_sort.GetChild ( "display_column", idwc_cols ) 

// Populate the dropdownlistbox with column names.
li_numcols_sort = UpperBound ( inv_sortattrib.is_sortcolumns ) 
FOR li_i = 1 to li_numcols_sort
	// Insert a new row
	li_newrow = idwc_cols.InsertRow ( 0 ) 
	// Populate the attributes for the column.	
	idwc_cols.SetItem ( li_newrow, "columnname", inv_sortattrib.is_sortcolumns[li_i] ) 
	idwc_cols.SetItem ( li_newrow, "display_column", inv_sortattrib.is_colnamedisplay[li_i] ) 
	IF inv_sortattrib.ib_usedisplay[li_i] THEN
		li_rc = idwc_cols.SetItem ( li_newrow, "use_display", "1" ) 
	ELSE
		li_rc = idwc_cols.SetItem ( li_newrow, "use_display", "0" ) 
	END IF 
NEXT

// Add rows for the current sort. One row for each column.
li_num_cols = UpperBound ( inv_sortattrib.is_origcolumns ) 
FOR li_i = 1 to li_num_cols
	li_found = idwc_cols.Find ( "columnname = '" + inv_sortattrib.is_origcolumns[li_i] + &
									    "'", 1, idwc_cols.RowCount () ) 
	IF li_found > 0 THEN
		// Insert a new row.
		li_newrow = dw_sort.InsertRow (0) 		
		// Set the column		
		ls_display = idwc_cols.GetItemString (li_found, "display_column" ) 
		li_rc = dw_sort.SetItem ( li_newrow, "display_column", ls_display ) 
		// Check the Asc/Desc sort order column		
		li_rc = dw_sort.SetItem ( li_newrow, "sort_order", inv_sortattrib.is_origorder[li_i] ) 
	END IF 
NEXT 

// Make sure there is at least one empty row.
If dw_sort.RowCount() = 0 Then
	// Insert a new row.
	li_newrow = dw_sort.InsertRow (0)
End If

// Turn off re-drawing until all done.
dw_sort.SetReDraw (TRUE)

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

type dw_sort from u_dw within pfc_w_sortmulti
int X=73
int Y=100
int Width=1280
int Height=552
int TabOrder=10
string DataObject="d_sortmulti"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Constructor!
//
//	Description:  This is not an updateable datawindow.
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

type cb_add from u_cb within pfc_w_sortmulti
int X=1399
int Y=232
int TabOrder=30
string Text="&Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Add another row to continue the sort criteria
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
Integer li_row

li_row = dw_sort.Event pfc_AddRow()
If li_row > 0 Then
	dw_sort.SetRow(li_row)
End If
dw_sort.SetFocus()
end event

type cb_delete from u_cb within pfc_w_sortmulti
int X=1399
int Y=348
int TabOrder=40
string Text="&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Delete the current row
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
Integer li_row

dw_sort.Event pfc_DeleteRow()

IF dw_sort.RowCount() = 0 THEN
	li_row = dw_sort.Event pfc_InsertRow()
	If li_row > 0 Then
		dw_sort.SetRow(li_row)
	End If
End If

dw_sort.SetFocus()
end event

type cb_insert from u_cb within pfc_w_sortmulti
int X=1399
int Y=116
int TabOrder=20
string Text="&Insert"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	Description:  Insert a new row before the current row
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
Integer li_row

li_row = dw_sort.Event pfc_InsertRow()
If li_row > 0 Then
	dw_sort.SetRow(li_row)
End If
dw_sort.SetFocus()

end event

type cb_ok from u_cb within pfc_w_sortmulti
int X=690
int Y=724
int TabOrder=50
string Text="OK"
boolean Default=true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked!
//
//	Description:  	Perform the OK window process.
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

type cb_cancel from u_cb within pfc_w_sortmulti
int X=1065
int Y=724
int TabOrder=60
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked!
//
//	Description:  	Perform the window Cancel operation.
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

Parent.Event pfc_Cancel ()
end event

type gb_sort from u_gb within pfc_w_sortmulti
int X=23
int Y=20
int Width=1769
int Height=664
int TabOrder=0
string Text="Sort items by"
long TextColor=33554687
long BackColor=82889382
end type

type cb_dlghelp from u_cb within pfc_w_sortmulti
int X=1440
int Y=724
int TabOrder=70
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

showHelp ("pfcdlg.hlp", topic!, 1000)
end event

