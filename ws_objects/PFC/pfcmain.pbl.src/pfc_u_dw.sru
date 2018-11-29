$PBExportHeader$pfc_u_dw.sru
$PBExportComments$PFC DataWindow class
forward
global type pfc_u_dw from datawindow
end type
end forward

shared variables
// All Shared variables are Private.
n_cst_dwsrv_property 	snv_property
end variables

global type pfc_u_dw from datawindow
integer width = 325
integer height = 244
integer taborder = 1
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event rbuttonup pbm_dwnrbuttonup
event type integer pfc_clear ( )
event type integer pfc_copy ( )
event type integer pfc_cut ( )
event type integer pfc_deleterow ( )
event type boolean pfc_descendant ( )
event type long pfc_insertrow ( )
event type long pfc_addrow ( )
event type integer pfc_paste ( )
event type boolean pfc_printpreview ( )
event type boolean pfc_ruler ( )
event type long pfc_retrieve ( )
event type long pfc_retrievedddw ( string as_column )
event type integer pfc_selectall ( )
event type integer pfc_undo ( )
event type integer pfc_update ( boolean ab_accepttext,  boolean ab_resetflag )
event type integer pfc_zoom ( )
event type integer pfc_firstpage ( )
event type long pfc_lastpage ( )
event type long pfc_nextpage ( )
event type long pfc_previouspage ( )
event type integer pfc_printimmediate ( )
event type integer pfc_print ( )
event type integer pfc_printdlg ( ref s_printdlgattrib astr_printdlg )
event pfc_preprintdlg ( ref s_printdlgattrib astr_printdlg )
event type integer pfc_pagesetup ( )
event type integer pfc_pagesetupdlg ( ref s_pagesetupattrib astr_pagesetup )
event pfc_prepagesetupdlg ( ref s_pagesetupattrib astr_pagesetup )
event pfc_rowchanged ( )
event lbuttonup pbm_lbuttonup
event lbuttondown pbm_lbuttondown
event pfc_prermbmenu ( ref m_dw am_dw )
event type integer pfc_updatespending ( )
event type integer pfc_validation ( )
event type long pfc_restorerow ( )
event pfc_finddlg ( )
event pfc_replacedlg ( )
event type integer pfc_filterdlg ( )
event type integer pfc_sortdlg ( )
event type integer pfc_values ( )
event type integer pfc_operators ( )
event pfc_debug ( )
event dropdown pbm_dwndropdown
event type integer pfc_ddcalendar ( )
event type integer pfc_ddcalculator ( )
event type integer pfc_ddnotes ( )
event pfc_prerestorerow ( ref n_cst_restorerowattrib anv_restorerowattrib )
event type integer pfc_accepttext ( boolean ab_focusonerror )
event type integer pfc_postupdate ( )
event type integer pfc_rowvalidation ( long al_row )
event type integer pfc_preproperties ( ref n_cst_dwpropertyattrib anv_dwpropertyattrib )
event type long pfc_populatedddw ( string as_colname,  ref datawindowchild adwc_obj )
event type integer pfc_preupdate ( )
event type integer pfc_updateprep ( )
event type integer pfc_predeleterow ( )
event pfc_prefinddlg ( ref n_cst_findattrib anv_findattrib )
event pfc_prereplacedlg ( ref n_cst_findattrib anv_findattrib )
event type integer pfc_preinsertrow ( )
event type integer pfc_resetupdate ( )
event pfc_properties ( )
event selectionchanged ( )
event dwlbuttonup pbm_dwnlbuttonup
event type integer pfc_ddcustom ( )
event pfc_dateselected ( date newdate )
end type
global pfc_u_dw pfc_u_dw

type variables
Private:
boolean ib_state_rowchanging

Public:
// - Common return value constants:
constant integer 		SUCCESS = 1
constant integer 		FAILURE = -1
constant integer 		NO_ACTION = 0
// - Continue/Prevent return value constants:
constant integer 		CONTINUE_ACTION = 1
constant integer 		PREVENT_ACTION = 0
//constant integer 		FAILURE = -1

n_tr			itr_object
n_cst_dwsrv		inv_base
n_cst_dwsrv_rowmanager	inv_rowmanager
n_cst_dwsrv_querymode	inv_querymode
n_cst_dwsrv_linkage	inv_linkage
n_cst_dwsrv_report		inv_report
n_cst_dwsrv_multitable	inv_multitable
n_cst_dwsrv_rowselection	inv_rowselect
n_cst_dwsrv_sort		inv_sort
n_cst_dwsrv_filter		inv_filter
n_cst_dwsrv_reqcolumn	inv_reqcolumn
n_cst_dwsrv_dropdownsearch inv_dropdownsearch
n_cst_dwsrv_find		inv_find
n_cst_dwsrv_printpreview	inv_printpreview
n_cst_dwsrv_resize		inv_resize
n_cst_PowerFilter PowerFilter
u_calendar 		iuo_calendar
u_calculator 		iuo_calculator
u_notes iuo_notes
u_customdropdown CustomDropDown
n_cst_dwsrv_property 	inv_property

Protected:
boolean		ib_isupdateable = true
boolean		ib_rmbmenu = true
boolean		ib_rmbfocuschange = true
string		is_updatesallowed="IUD" // I-Inserts U-Updates D-Deletes
powerobject	ipo_updaterequestor

end variables

forward prototypes
public function boolean of_getupdateable ()
public function integer of_settransobject (n_tr atr_object)
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_setbase (boolean ab_switch)
public function integer of_setdropdownsearch (boolean ab_switch)
public function integer of_setfilter (boolean ab_switch)
public function integer of_setfind (boolean ab_switch)
public function integer of_setlinkage (boolean ab_switch)
public function integer of_setmultitable (boolean ab_switch)
public function integer of_setprintpreview (boolean ab_switch)
public function integer of_setquerymode (boolean ab_switch)
public function integer of_setreport (boolean ab_switch)
public function integer of_setrowmanager (boolean ab_switch)
public function integer of_setrowselect (boolean ab_switch)
public function integer of_setsort (boolean ab_switch)
public function integer of_setupdateable (boolean ab_isupdateable)
public function integer of_setreqcolumn (boolean ab_switch)
public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly)
public function integer of_setdropdowncalendar (boolean ab_switch)
public function integer of_setdropdowncalculator (boolean ab_switch)
public function integer of_setdropdownnotes (boolean ab_switch)
public function integer of_setresize (boolean ab_switch)
public function boolean of_isroot ()
public function integer of_setproperty (boolean ab_switch)
public function integer of_setupdaterequestor (powerobject apo_updaterequestor)
public function integer of_accepttext (boolean ab_focusonerror)
public function integer of_reset ()
public function integer of_retrieve ()
public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, powerobject apo_requestor)
public function integer of_updatespending ()
public function integer of_validation ()
public function integer of_update (boolean ab_accepttext, boolean ab_resetflag)
public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, boolean ab_insert, boolean ab_update, boolean ab_delete)
public function integer of_updateprep ()
public function integer of_postupdate ()
public function boolean of_isupdateable ()
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
public function integer of_setsharedproperty (boolean ab_switch)
public function boolean of_IsSharedProperty ()
public function integer setpowerfilter (boolean switchpowerfilter)
public function integer setcustomdropdown (boolean setswitch)
public function integer filter ()
end prototypes

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttonup
//
//	Description:  Popup menu
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Added DataWindow Property to the popup menu.
// 6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean		lb_frame
boolean		lb_val
boolean		lb_readonly
integer		li_tabsequence
long			ll_getrow
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
window		lw_parent
window		lw_frame
window		lw_sheet
window		lw_childparent
m_dw			lm_dw
n_cst_conversion	lnv_conversion

// Determine if RMB popup menu should occur
if not ib_rmbmenu or IsNull (dwo) then
	return 1
end if

// No RMB support for OLE objects and graphs
if dwo.type = "ole" or dwo.type = "tableblob" or dwo.type = "graph" then
	return 1
end if

// No RMB support for print preview mode
if this.object.datawindow.print.preview = "yes" then
	return 1
end if

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.object.datawindow.readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

choose case dwo.type
	case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"

		// Row operations based on readonly status
		lm_dw.m_table.m_insert.enabled = not lb_readonly
		lm_dw.m_table.m_addrow.enabled = not lb_readonly
		lm_dw.m_table.m_delete.enabled = not lb_readonly

		// Menu item enablement for current row
		if not lb_readonly then
			if ll_getrow > 0 then
				lm_dw.m_table.m_delete.enabled = true
				lm_dw.m_table.m_insert.enabled = true
			else
				lm_dw.m_table.m_delete.enabled = false
				lm_dw.m_table.m_insert.enabled = false
			end if
		end if
	case else
		lm_dw.m_table.m_insert.enabled = false
		lm_dw.m_table.m_delete.enabled = false
		lm_dw.m_table.m_addrow.enabled = false
end choose

// Get column properties
ls_currcolname = this.GetColumnName()
if dwo.type = "column" then
	ls_editstyle = dwo.edit.style
	ls_colname = dwo.name
	ls_protect = dwo.protect
	ls_val = dwo.tabsequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
lm_dw.m_table.m_copy.enabled = false
lm_dw.m_table.m_cut.enabled = false
lm_dw.m_table.m_paste.enabled = false
lm_dw.m_table.m_selectall.enabled = false

if dwo.type = "column" and not lb_readonly then
	if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then

		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then

			// Copy
			lm_dw.m_table.m_copy.enabled = true

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				choose case ls_editstyle
					case "edit"
						ls_val = dwo.edit.displayonly
						lm_dw.m_table.m_cut.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "editmask"
						ls_val = dwo.editmask.readonly
						lm_dw.m_table.m_cut.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_cut.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_cut.enabled = lnv_conversion.of_Boolean (ls_val)
				end choose
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			if Len (ClipBoard()) > 0 then
				choose case ls_editstyle
					case "edit"
						ls_val = dwo.edit.displayonly
						lm_dw.m_table.m_paste.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "editmask"
						ls_val = dwo.editmask.readonly
						lm_dw.m_table.m_paste.enabled= not lnv_conversion.of_Boolean (ls_val)
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_paste.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_paste.enabled = lnv_conversion.of_Boolean (ls_val)
				end choose
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_selectall.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_selectall.enabled = lnv_conversion.of_Boolean (ls_val)
					case else
						lm_dw.m_table.m_selectall.enabled = true
				end choose
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
if IsValid (inv_rowmanager) then
	// Undelete capability
	if inv_rowmanager.of_IsRestoreRow() then
		lm_dw.m_table.m_restorerow.visible = true
		if this.DeletedCount() > 0 and not lb_readonly then
			lm_dw.m_table.m_restorerow.enabled = true
		else
			lm_dw.m_table.m_restorerow.enabled = false
		end if
	end if
else
	lm_dw.m_table.m_restorerow.visible = false
	lm_dw.m_table.m_restorerow.enabled = false
end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.visible = false
lm_dw.m_table.m_operators.enabled = false
lm_dw.m_table.m_values.visible = false
lm_dw.m_table.m_values.enabled = false
lm_dw.m_table.m_dash12.visible = false

if IsValid (inv_querymode) then
	if inv_querymode.of_GetEnabled() then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.visible = false
		lm_dw.m_table.m_restorerow.enabled = false		

		// Default visible to true if in querymode
		lm_dw.m_table.m_values.visible = true
		lm_dw.m_table.m_operators.visible = true
		lm_dw.m_table.m_dash12.visible = true

		if dwo.type = "column" and not lb_readonly then
			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
				if li_tabsequence > 0 and ls_protect = "0" then				
					choose case ls_editstyle
						case "edit"
							ls_val = dwo.edit.displayonly
							lb_val = not lnv_conversion.of_Boolean (ls_val)
						case "editmask"
							ls_val = dwo.editmask.readonly
							lb_val = not lnv_conversion.of_Boolean (ls_val)
						case "ddlb"
							ls_val = dwo.ddlb.allowedit
							lb_val = lnv_conversion.of_Boolean (ls_val)
						case "dddw"
							ls_val = dwo.dddw.allowedit
							lb_val = lnv_conversion.of_Boolean (ls_val)
					end choose

					// Enablement based on column				
					lm_dw.m_table.m_values.enabled = lb_val
					lm_dw.m_table.m_operators.enabled = lb_val
				end if
			end if
		end if
	end if
end if

// DataWindow properties.
If IsValid(inv_property) Then
	If inv_property.of_IsPropertyOpen() = False Then
		lm_dw.m_table.m_debug.visible = True
		lm_dw.m_table.m_debug.enabled = True
	End If
ElseIf IsValid(snv_property) Then
	If snv_property.of_IsPropertyOpen() = False Then
		lm_dw.m_table.m_debug.visible = True
		lm_dw.m_table.m_debug.enabled = True
	End If
End If	

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_rowselect) then
	inv_rowselect.event pfc_rbuttonup (xpos, ypos, row, dwo)
end if

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
destroy lm_dw

return 1

end event

event pfc_clear;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_clear
//
//	Arguments:  None
//
//	Returns:  integer
//				Return value from PowerScript Clear() function
//
//	Description:  Clear Text (no clipboard) functionality
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

Return this.Clear()
end event

event pfc_copy;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_copy
//
//	Arguments:  none
//
//	Returns:  integer
//	Return value from the PowerScript Copy function
//
//	Description:  Copy the text to the clipboard.
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

return this.Copy()
end event

event pfc_cut;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_cut
//
//	Arguments:  none
//
//	Returns:  integer
//	Return value from the PowerScript Cut function
//
//	Description:	 Cut the text to the clipboard.
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

return this.Cut()
end event

event pfc_deleterow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_deleterow
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//  0 = Row not deleted
//	-1 = error
//
//	Description:
//	Deletes the current or selected row(s)
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Enhanced with PreDelete process.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
long		ll_row

// Perform Pre Delete process.
If this.Event pfc_predeleterow() <= PREVENT_ACTION Then
	Return NO_ACTION
End If

// Delete row.
if IsValid (inv_rowmanager) then
	li_rc = inv_rowmanager.event pfc_deleterow () 
else	
	li_rc = this.DeleteRow (0) 
end if

If li_rc > 0 Then ll_row = 0 Else ll_row = -1
//	Note: The deletion of multiple master rows is not supported by the linkage service.
if IsValid ( inv_Linkage ) then
	inv_Linkage.Event pfc_deleterow (ll_row) 
end If

return li_rc
end event

event pfc_descendant;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_descendant
//
//	Arguments:   none
//
//	Returns:  boolean
//
//	Description:  Always returns true and is used to determine that this
//	   class is part of the PowerBuilder Foundation Class Library.
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

return true
end event

event pfc_insertrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_insertrow
//
//	Arguments:  none
//
//	Returns:  long
//	number of the new row that was inserted
//	 0 = No row was added.
//	-1 = error
//
//	Description:
//	Inserts a new row into the DataWindow before the current row
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced with Pre Insert funcitonality.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_currow
long	ll_rc

// Allow for pre functionality.
If this.Event pfc_preinsertrow() <= PREVENT_ACTION Then
	Return NO_ACTION
End If

// Get current row
ll_currow = this.GetRow()
if ll_currow < 0 then ll_currow = 0

// Notify that a new row is about to be added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (0) 
END IF 

// Insert row.
if IsValid (inv_rowmanager) then
	ll_rc = inv_rowmanager.event pfc_insertrow (ll_currow)
else
	ll_rc = this.InsertRow (ll_currow) 
end if

// Notify that a new row has been added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (ll_rc) 
END IF 

return ll_rc
end event

event pfc_addrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_addrow
//
//	Arguments:  none
//
//	Returns:  long
//	number of the new row that was inserted
//	 0 = No row was added.
//	-1 = error
//
//	Description:
//	Adds a new row to the end of the DW
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced with Pre Insert funcitonality.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc

// Allow for pre functionality.
If this.Event pfc_preinsertrow() <= 0 Then
	Return NO_ACTION
End If

// Notify that a new row is about to be added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (0) 
END IF 

// Insert row.
if IsValid (inv_rowmanager) then
	ll_rc = inv_rowmanager.event pfc_addrow ()
else
	ll_rc = this.InsertRow (0) 
end if

// Notify that a new row has been added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (ll_rc) 
END IF 

return ll_rc
end event

event pfc_paste;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_paste
//
//	Arguments:  none
//
//	Returns:  integer
//	Return value from the Powerscript Paste function
//
//	Description:  Paste the text from the clipboard.
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

return this.Paste()
end event

event pfc_printpreview;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_printpreview
//
//	Arguments:  none
//
//	Returns:  boolean
//	true = DataWindow is in printpreview
//	false = DataWindow is in editmode
//
//	Description:	Toggles the DataWindow in printpreview/edit mode
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

boolean	lb_rc

if IsValid (inv_printpreview) then
	lb_rc = inv_printpreview.of_GetEnabled()
	lb_rc = not lb_rc
	inv_printpreview.of_SetEnabled (lb_rc)
end if

return lb_rc
end event

event pfc_ruler;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_ruler
//
//	Arguments:  none
//
//	Returns:  boolean
//	true = Printpreview rulers are displayed
//	false = Printpreview rulers are not displayed
//
//	Description:	Toggles the ruler display in printpreview mode
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

boolean	lb_rc

if IsValid (inv_printpreview) then
	if inv_printpreview.of_GetEnabled() then
		lb_rc = inv_printpreview.of_GetRuler()
		lb_rc = not lb_rc
		inv_printpreview.of_SetRuler (lb_rc)
	end if
end if

return lb_rc
end event

event pfc_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_retrieve
//
//	Arguments:  none
//
//	Returns:  long
//	The return code from the Retrieve Powerscript function
//	 0 = No rows returned from successful retrieve
//	-1 = Retrieve was unsuccessful
//	>0 = The number of rows returned from the retrieve)
//
//	Description:  Specific retrieve logic should be coded in descendant scripts
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

return 0
end event

event pfc_retrievedddw;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_retrievedddw
//
//	Arguments:  none
//
//	Returns:  long
//	Can be used with Powerscript Retrieve function, to indicate
//	   success/failure, or number of rows retrieved.
//
//	Description:  This event should be used in descendants to
//	   populate any DropDownDataWindows on the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Marked obsolete Replaced by pfc_populatedddw
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return 0
end event

event pfc_selectall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_selectall
//
//	Arguments:  none
//
//	Returns:  integer
//	Return value from the Powerscript SelectText function
//
//	Description:  Select all text in the current row/column
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

return SelectText (1, 32767)
end event

event pfc_undo;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_undo
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = nothing to Undo, or failure on Undo function
//
//	Description:  Cancels the last edit, restoring the text to the content
//	  before the last change.
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

return this.Undo()
end event

event pfc_update;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_update
//
//	Arguments:  
//	ab_accepttext	When applicable, specifying whether control should perform an
//						AcceptText prior to performing the update:
//	ab_resetflag	Value specifying whether object should automatically 
//						reset its update flags.
//
//	Returns: Integer
//	 1 = The update was successful
//	-1 = The update failed
//
//	Description:  	Specific Update logic.  Either perform a regular single dw
//						update or a Multiple table update.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Enhanced to include PreUpdate event.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

// Verify passed arguments.
IF IsNull(ab_accepttext) Or IsNull(ab_resetflag) Then Return -1 

// Call for PreUpdate functionality.
If this.Event pfc_PreUpdate() < 0 Then Return -1

// Call the multi-table update if applicable.
IF IsValid (inv_multitable) THEN 
	li_rc = inv_multitable.of_update (ab_accepttext, ab_resetflag)
ELSE
	li_rc = this.Update(ab_accepttext, ab_resetflag)
END IF

Return li_rc
end event

event pfc_zoom;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_zoom
//
//	Arguments:  none
//
//	Returns:  integer
//	 zoom level chosen by the user
//	 0 = user cancelled from zoom dialog
//	-1 = error
//
//	Description:  Zooms the print preview level to the user-specified amount
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

if IsValid (inv_printpreview) then
	if inv_printpreview.of_GetEnabled() then
		return inv_printpreview.of_SetZoom()
	end if
end if

return FAILURE
end event

event pfc_firstpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_firstpage
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	Scrolls to the first page of the DW
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

return this.ScrollToRow (0)
end event

event pfc_lastpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_lastpage
//
//	Arguments:  none
//
//	Returns:  long
//	row number displayed at the top of the page scrolled to
//	-1 if an error occurs
//
//	Description:	Scrolls to the last page of the DW
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

long	ll_rc
string	ls_rc

ll_rc = ScrollToRow (2147483647)
if ll_rc > 0 then
	ls_rc = this.object.datawindow.firstrowonpage
	if IsNumber (ls_rc) then
		ll_rc = Long (ls_rc)
	else
		ll_rc = FAILURE
	end if
end if

return ll_rc

end event

event pfc_nextpage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_nextpage
//
//	Arguments:  none
//
//	Returns:  long
//	 row number displayed at the top of the DataWindow
//	-1 = error
//
//	Description:	Scrolls to the next page of the DW
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

return this.ScrollNextPage()

end event

event pfc_previouspage;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_previouspage
//
//	Arguments:  none
//
//	Returns:  long
//	 row number displayed at the top of the DataWindow
//	-1 = error
//
//	Description:	Scrolls to the previous page of the DW
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

return this.ScrollPriorPage()
end event

event pfc_printimmediate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_printimmediate
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Prints the DataWindow (without displaying a print dialog)
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

return this.Print (true)
end event

event pfc_print;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_print
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Opens the print dialog to allow user to change print settings,
//	and then prints the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.01   Modified script to avoid 64K segment problem with 16bit machine code executables
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean	lb_rowselection
integer	li_rc
long		ll_selected[]
long		ll_selectedcount
long		ll_cnt
string		ls_val
datastore				lds_selection
s_printdlgattrib		lstr_printdlg

li_rc = this.event pfc_printdlg (lstr_printdlg)
if li_rc < 0 then
	return li_rc
end if

// Print selection
if this.object.datawindow.print.page.range = "selection" then
	// Get selected count
	lb_rowselection = IsValid (inv_rowselect)
	if not lb_rowselection then
		of_SetRowSelect (true)
	end if
	ll_selectedcount = inv_rowselect.of_SelectedCount (ll_selected)
	if not lb_rowselection then
		of_SetRowSelect (false)
	end if	

	if ll_selectedcount > 0 then
		// Create a datastore to print selected rows
		lds_selection = create datastore
		lds_selection.dataobject = this.dataobject

		// First discard any data in the dataobject
		lds_selection.Reset()

		// Copy selected rows
		for ll_cnt = 1 to ll_selectedcount
			if this.RowsCopy (ll_selected[ll_cnt], ll_selected[ll_cnt], primary!, lds_selection, 2147483647, primary!) < 0 then
				return -1
			end if
		next

		// Capture print properties of original DW
		// (Note:  this syntax uses Describe/Modify PS functions to avoid 64K segment limit)
		ls_val = this.Describe ("datawindow.print.collate")
		lds_selection.Modify ("datawindow.print.collate = " + ls_val)

		ls_val = this.Describe ("datawindow.print.color")
		lds_selection.Modify ("datawindow.print.color = " + ls_val)

		ls_val = this.Describe ("datawindow.print.columns")
		lds_selection.Modify ("datawindow.print.columns = " + ls_val)

		ls_val = this.Describe ("datawindow.print.columns.width")
		lds_selection.Modify ("datawindow.print.columns.width = " + ls_val)

		ls_val = this.Describe ("datawindow.print.copies")
		lds_selection.Modify ("datawindow.print.copies = " + ls_val)

		ls_val = this.Describe ("datawindow.print.documentname")
		lds_selection.Modify ("datawindow.print.documentname = " + ls_val)

		ls_val = this.Describe ("datawindow.print.duplex")
		lds_selection.Modify ("datawindow.print.duplex = " + ls_val)

		ls_val = this.Describe ("datawindow.print.filename")
		lds_selection.Modify ("datawindow.print.filename = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.bottom")
		lds_selection.Modify ("datawindow.print.margin.bottom = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.left")
		lds_selection.Modify ("datawindow.print.margin.left = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.right")
		lds_selection.Modify ("datawindow.print.margin.right = " + ls_val)

		ls_val = this.Describe ("datawindow.print.margin.top")
		lds_selection.Modify ("datawindow.print.margin.top = " + ls_val)

		ls_val = this.Describe ("datawindow.print.orientation")
		lds_selection.Modify ("datawindow.print.orientation = " + ls_val)

		ls_val = this.Describe ("datawindow.print.page.range")
		lds_selection.Modify ("datawindow.print.page.range = " + ls_val)

		ls_val = this.Describe ("datawindow.print.page.rangeinclude")
		lds_selection.Modify ("datawindow.print.page.rangeinclude = " + ls_val)

		ls_val = this.Describe ("datawindow.print.paper.size")
		lds_selection.Modify ("datawindow.print.paper.size = " + ls_val)

		ls_val = this.Describe ("datawindow.print.paper.source")
		lds_selection.Modify ("datawindow.print.paper.source = " + ls_val)

		ls_val = this.Describe ("datawindow.print.prompt")
		lds_selection.Modify ("datawindow.print.prompt = " + ls_val)

		ls_val = this.Describe ("datawindow.print.quality")
		lds_selection.Modify ("datawindow.print.quality = " + ls_val)

		ls_val = this.Describe ("datawindow.print.scale")
		lds_selection.Modify ("datawindow.print.scale = " + ls_val)
	end if
end if

// Print
if IsValid (lds_selection) then
	li_rc = lds_selection.Print (true)
	destroy lds_selection
else
	li_rc = this.Print (true)
end if

this.object.datawindow.print.filename = ""
this.object.datawindow.print.page.range = ""

return li_rc
end event

event pfc_printdlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_printdlg
//
//	Arguments:
//	astr_printdlg:  print dialog structure by ref
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  
//	Opens the print dialog for this DataWindow, 
//	and sets the print values the user selected for the DW.
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

boolean			lb_collate
integer			li_copies
long				ll_rc
long				ll_pagecount
string				ls_pagecount
string				ls_pathname = "Output"
string				ls_filename
string				ls_copies
string				ls_collate
n_cst_platform		lnv_platform
n_cst_conversion	lnv_conversion
window				lw_parent

// Initialize printdlg structure with current print values of DW
astr_printdlg.b_allpages = true

ls_copies = this.object.datawindow.print.copies
if not IsNumber (ls_copies) then
	ls_copies = "1"
end if
li_copies = Integer (ls_copies)
astr_printdlg.l_copies = li_copies

ls_collate = this.object.datawindow.print.collate
lb_collate = lnv_conversion.of_Boolean (ls_collate)
astr_printdlg.b_collate = lb_collate

astr_printdlg.l_frompage = 1
astr_printdlg.l_minpage = 1

ls_pagecount = this.Describe ("evaluate ('PageCount()', 1)")
if IsNumber (ls_pagecount) then
	ll_pagecount = Long (ls_pagecount)
	astr_printdlg.l_maxpage = ll_pagecount
	astr_printdlg.l_topage = ll_pagecount
end if

if this.GetSelectedRow (0) = 0 then
	astr_printdlg.b_disableselection = true
end if

// Allow printdlg structure to have additional values
// set before opening print dialog
this.event pfc_preprintdlg (astr_printdlg)

// Open print dialog
f_setplatform (lnv_platform, true)
this.of_GetParentWindow (lw_parent)
ll_rc = lnv_platform.of_PrintDlg (astr_printdlg, lw_parent)
f_setplatform (lnv_platform, false)

// Set print values of DW based on users selection
if ll_rc > 0 then
	// Page Range
	if astr_printdlg.b_allpages then
		this.object.datawindow.print.page.range = ""
	elseif astr_printdlg.b_pagenums then
		this.object.datawindow.print.page.range = &
			String (astr_printdlg.l_frompage) + "-" + String (astr_printdlg.l_topage)
	elseif astr_printdlg.b_selection then
		this.object.datawindow.print.page.range = "selection"
	end if

	// Collate copies
	this.object.datawindow.print.collate = astr_printdlg.b_collate

	// Number of copies
	this.object.datawindow.print.copies = astr_printdlg.l_copies

	// Print to file (must prompt user for filename first)
	if astr_printdlg.b_printtofile then
		if GetFileSaveName ("Print to File", ls_pathname, ls_filename, "prn", &
			"Printer Files,*.prn,All Files,*.*") <= 0 then
			return -1
		else
			this.object.datawindow.print.filename = ls_pathname
		end if
	end if
end if

return ll_rc

end event

event pfc_pagesetup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_pagesetup
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	 0 = user cancelled from pagesetup dialog
//	-1 = error
//
//	Description:
//	Opens the pagesetup dialog to allow user to change settings
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

s_pagesetupattrib	lstr_pagesetup

return this.event pfc_pagesetupdlg (lstr_pagesetup)
end event

event pfc_pagesetupdlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_pagesetupdlg
//
//	Arguments:
//	astr_pagesetup:  page setup structure by ref
//
//	Returns:  integer
//	 1 = success
//	 0 = user cancelled from page setup
//	-1 = error
//
//	Description:  
//	Opens the page setup dialog for this DataWindow, 
//	and sets the page setup values the user selected for the DW.
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

integer	li_margin
integer	li_papersize
integer	li_papersource
integer	li_units
string		ls_margin
string		ls_papersize
string		ls_papersource
string		ls_portraitorientation
string		ls_units
long		ll_rc
n_cst_platform	lnv_platform

// Initialize pagesetup structure with current values of DW
// Margin bottom
ls_margin = this.object.datawindow.print.margin.bottom
if not IsNumber (ls_margin) then
	ls_margin = "0"
end if
li_margin = Integer (ls_margin)
astr_pagesetup.i_marginbottom = li_margin

// Margin left
ls_margin = this.object.datawindow.print.margin.left
if not IsNumber (ls_margin) then
	ls_margin = "0"
end if
li_margin = Integer (ls_margin)
astr_pagesetup.i_marginleft = li_margin

// Margin right
ls_margin = this.object.datawindow.print.margin.right
if not IsNumber (ls_margin) then
	ls_margin = "0"
end if
li_margin = Integer (ls_margin)
astr_pagesetup.i_marginright = li_margin

// Margin top
ls_margin = this.object.datawindow.print.margin.top
if not IsNumber (ls_margin) then
	ls_margin = "0"
end if
li_margin = Integer (ls_margin)
astr_pagesetup.i_margintop = li_margin

// DataWindow units
ls_units = this.object.datawindow.units
if not IsNumber (ls_units) then
	ls_units = "0"
end if
li_units = Integer (ls_units)
if li_units < 2 then
	astr_pagesetup.b_disablemargins = true
end if
astr_pagesetup.i_units = li_units

// Paper Size
ls_papersize = this.object.datawindow.print.paper.size
if not IsNumber (ls_papersize) then
	ls_papersize = "0"
end if
li_papersize = Integer (ls_papersize)
astr_pagesetup.i_papersize = li_papersize

// Paper Source
ls_papersource = this.object.datawindow.print.paper.source
if not IsNumber (ls_papersource) then
	ls_papersource = "0"
end if
li_papersource = Integer (ls_papersource)
astr_pagesetup.i_papersource = li_papersource

// Orientation
ls_portraitorientation = this.object.datawindow.print.orientation
if ls_portraitorientation = "0" then
	SetNull (astr_pagesetup.b_portraitorientation)
elseif ls_portraitorientation = "2" then
	astr_pagesetup.b_portraitorientation = true
end if

// Allow pagesetup structure to have additional values
// set before opening print dialog
this.event pfc_prepagesetupdlg (astr_pagesetup)

// Open page setup dialog
f_setplatform (lnv_platform, true)
ll_rc = lnv_platform.of_PageSetupDlg (astr_pagesetup)
f_setplatform (lnv_platform, false)

// Set page setup values based on users selection
if ll_rc > 0 then
	// Margins
	this.object.datawindow.print.margin.bottom = astr_pagesetup.i_marginbottom
	this.object.datawindow.print.margin.left = astr_pagesetup.i_marginleft
	this.object.datawindow.print.margin.right = astr_pagesetup.i_marginright
	this.object.datawindow.print.margin.top = astr_pagesetup.i_margintop

	// Paper Size
	this.object.datawindow.print.paper.size = astr_pagesetup.i_papersize

	// Paper Source
	this.object.datawindow.print.paper.source = astr_pagesetup.i_papersource

	// Orientation
	if IsNull (astr_pagesetup.b_portraitorientation) then
		this.object.datawindow.print.orientation = 0
	elseif not astr_pagesetup.b_portraitorientation then
		this.object.datawindow.print.orientation = 1
	elseif astr_pagesetup.b_portraitorientation then
		this.object.datawindow.print.orientation = 2
	end if
end if

return ll_rc

end event

event pfc_rowchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_rowchanged
//
//	(Arguments: None)
//
//	(Returns:   None)
//
//	Description:  
//	Provides notification when the buffer has been sorted, filtered or otherwise
//	manipulated such that the current row has not changed, but the actually row
//	at that location may be different.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed the notification to the Linkage service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_RowChanged () 
END IF 
end event

event lbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  lbuttonup
//
//	Description:  Send lbuttonup notification to services
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

if IsValid (inv_rowselect) then
	inv_rowselect.event pfc_lbuttonup (flags, xpos, ypos)
end if
end event

event lbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  lbuttondown
//
//	Description:  Send lbuttondown notification to services
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

if IsValid (inv_rowselect) then
	inv_rowselect.event pfc_lbuttondown (flags, xpos, ypos)
end if
end event

event pfc_updatespending;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  
//	pfc_UpdatesPending
//
//	Arguments:  none
//
//	Returns:  integer
//	1 = Updates are pending.
//	0 = No updates are pending
//
//	Description:
//	Determine if any updates are pending on this datawindow
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

// Check if DataWindow is updateable
if not of_IsUpdateable() then
	return 0
end if

// Check for any updates that may be pending
if this.ModifiedCount() + this.DeletedCount() > 0 then
	return 1
end if

return 0

end event

event pfc_validation;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  
//	pfc_validation
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = All validation passed
//	-1 = validation failed
//
//	Description:
//	Validate the DataWindow.
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

integer	li_checkcolumn = 1
integer	li_rc
long		ll_checkrow = 1
string	ls_checkcolname = ''
boolean	ib_updateonly = true

// Check for Missing Required Fields
li_rc = of_CheckRequired (primary!, ll_checkrow, li_checkcolumn, ls_checkcolname, ib_updateonly)
if (li_rc < 0) or (ll_checkrow > 0) then return FAILURE
				
return SUCCESS
end event

event pfc_restorerow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_restorerow
//
//	Arguments:  none
//
//	Returns:  long
//	number of rows restored (undeleted)
//	-1 = error
//	-2 = no rows in delete buffer to restore
//
//	Description:
//	Allows user to undelete rows
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

if IsValid (inv_rowmanager) then
	Return inv_rowmanager.event pfc_restorerow()
end if

return FAILURE
end event

event pfc_finddlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		pfc_finddlg
//
//	Arguments:  none
//
//	Returns:  	none
//
//	Description:  Invokes the Find dialog window.
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

If IsValid (inv_find) Then
	inv_find.Event pfc_finddlg()
end if

Return
end event

event pfc_replacedlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		pfc_replacedlg
//
//	Arguments:  none
//
//	Returns:  	none
//
//	Description:  Invokes the Find/Replace dialog window.
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

If IsValid (inv_find) Then
	inv_find.Event pfc_replacedlg()
end if

Return
end event

event pfc_filterdlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		pfc_filterdlg
//
//	Arguments:  none
//
//	Returns:  	integer
//					 1 success
//					 0 = user cancelled from filter dialog
//					-1 = error
//
//	Description:  Invokes the Find dialog window.
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

If IsValid (inv_filter) Then
	Return inv_filter.Event pfc_filterdlg()
end if

Return FAILURE
end event

event pfc_sortdlg;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		pfc_SortDlg
//
//	Arguments:  none
//
//	Returns:  	integer
//					 1 success
//					 0 = user cancelled from Sort dialog
//					-1 = error
//
//	Description:  Invokes the Sort dialog window.
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

If IsValid (inv_sort) Then
	Return inv_sort.Event pfc_SortDlg()
end if

Return FAILURE
end event

event pfc_values;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_values
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	 0 = user cancelled
//	-1 = error
//
//	Description:
//	Allows user to select from available database values
//	for the current column
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

if IsValid (inv_querymode) then
	Return inv_querymode.event pfc_values()
end if

return FAILURE
end event

event pfc_operators;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_operators
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	 0 = user cancelled from selection window
//	-1 = error
//
//	Description:
//	Allows user to select from a list of querymode operators
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

if IsValid (inv_querymode) then
	Return inv_querymode.event pfc_operators()
end if

return FAILURE


end event

event pfc_debug;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_debug
//
//	Description:
//	Call the DataWindow property Dialog.
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

this.Event pfc_properties()
end event

event dropdown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  dropdown
//
//	Arguments:  none
//
//	Returns:  none
//	
//	Description:	 Notification that a dropdown object has been requested.
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

If IsValid(iuo_calendar) Then
	// Check if this a column that has the calendar associated to it.
	If iuo_calendar.Event pfc_dropdown() = 1 Then
		// Column is a ddcalendar column.  Prevent listbox from appearing.
		Return 1
	End If
End If

If IsValid(iuo_calculator) Then
	// Check if this a column that has the calculator associated to it.
	If iuo_calculator.Event pfc_dropdown() = 1 Then
		// Column is a ddcalculator column.  Prevent listbox from appearing.
		Return 1
	End If
End If

If IsValid(iuo_notes) Then
	// Check if this a column that has the notes associated to it.
	If iuo_notes.Event pfc_dropdown() = 1 Then
		// Column is a ddnotes column.  Prevent listbox from appearing.
		Return 1
	End If
End If

if	IsValid(CustomDropdown) then
	//	Check if this column has a custom dropdown associated with it.
	if	CustomDropdown.dynamic event pfc_dropdown() = 1 then
		//	Column has a custom dropdown.  Prevent listbox from appearing.
		return 1
	end if
end if

end event

event pfc_ddcalendar;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_ddcalculator
//
//	Description:  Request the dropdown calendar.
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

If IsValid(iuo_calendar) Then
	Return iuo_calendar.Event pfc_dropdown()
End If

Return FAILURE
end event

event pfc_ddcalculator;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_ddcalculator
//
//	Description:  Request the dropdown calculator.
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

If IsValid(iuo_calculator) Then
	Return iuo_calculator.Event pfc_dropdown()
End If

Return FAILURE
end event

event pfc_ddnotes;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_ddnotes
//
//	Description:  Request the dropdown notes.
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

If IsValid(iuo_Notes) Then
	Return iuo_Notes.Event pfc_dropdown()
End If

Return FAILURE
end event

event pfc_prerestorerow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_prerestorerow
//
//	Arguments:		
//	anv_restorerowattrib:  Restore object by reference
//
//	Returns:  None
//
//	Description:	
//	Populate restore object attributes before the Restore window opens.
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
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//	The filter to be applied prior to displaying the RestoreRow dialog.
If IsValid (inv_linkage) Then
	If inv_linkage.of_GetStyle() = inv_linkage.FILTER Then
		// Only display the rows that belong to the current master row.
		anv_restorerowattrib.is_filter = this.Object.DataWindow.Table.Filter
	End If
End If

// The sort to be applied prior to displaying the RestoreRow dialog.
anv_restorerowattrib.is_sort = this.Object.DataWindow.Table.Sort



end event

event pfc_accepttext;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_accepttext
//
//	Arguments:  
//	ab_focusonerror Boolean which states if focus should be set in case of error.
//
//	Returns:  
//	1 if it succeeds and -1 if an error occurs.
//	
//	Description:	 Perform an accepttext and set focus when requested.
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

integer li_rc

// Do not perform AcceptText on Datawidows found on uncreated tab pages.
If this.RowCount() + this.FilteredCount() + &
	this.ModifiedCount() + this.DeletedCount() <= 0 Then
	Return SUCCESS
End If
	
// Perform AcceptText, check rc
li_rc = this.AcceptText()
If li_rc < 0 Then 
	If ab_FocusOnError Then this.SetFocus()
	Return FAILURE
End If

Return SUCCESS
end event

event pfc_postupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_postupdate
//
//	Arguments:  None
//
//	Returns:  1 if it succeeds and -1 if an error occurs.
//	
//	Description:	
// Perform post update processing.
//	Clear the update flags in the DataWindow.
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

Return this.Event pfc_resetupdate()
end event

event pfc_rowvalidation;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_RowValidation
//
//	Arguments:		
//	al_row	The row to validate.
//
//	Returns:  Integer
//	1 Validated ok.
//	-1 An error was found.
//
//	Description:	Specific row validation.
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
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return SUCCESS
end event

event pfc_populatedddw;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_populatedddw
//
//	Arguments:
//	as_colname		column name of the DDDW to populate
//	adwc_obj		DataWindowChild reference of the DDDW column
//
//	Returns:  long
//	Indicates success/failure, or number of rows populated.
//
//	Description:  
//	Populate the passed-in DropDownDataWindow.
//
//	This script for this event should be in descendant DataWindows.
//	The DropDownDataWindow can be populated in any manner, including
//	using the DataWindow caching service, external data, or retrieving.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version - Replaces obsoleted event pfc_retrievedddw.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return NO_ACTION
end event

event pfc_preupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_preupdate
//
//	Arguments:  None
//
//	Returns: Integer
//	 1 = successful
//	-1 = error
//
//	Description:  	
//	Specific PreUpdate logic.
//
// Note: 
// This event should be extended to provide the specific PreUpdate logic.
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

Return SUCCESS
end event

event pfc_updateprep;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  
//	pfc_UpdatePrep
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = All preparation (if any) passed
//	-1 = preparation failed
//
//	Description:
//	Prepare the object for an update.
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

Return SUCCESS
end event

event pfc_predeleterow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_predeleterow
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = Continue with delete
//  0 = Prevent the actual delete.
//	-1 = error
//
//	Description:
//	Notification of a pending delete operation.
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

if IsValid ( inv_Linkage ) then
	// Notify service of the possible deletion.
	//	Note: The deletion of multiple master rows is not supported by the linkage service.
	// Note: The linkage service has the functionality to cancel the delete operation.
	If inv_Linkage.Event pfc_predeleterow (0) <> inv_linkage.CONTINUE_ACTION Then
		Return PREVENT_ACTION
	End If
end if

Return CONTINUE_ACTION
end event

event pfc_preinsertrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_preinsertrow
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 if it OK to insert the row
//	 0 = prevent the row from being added.
//	-1 = error
//
//	Description:
//	Determines if it is OK to insert a new row.
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

if IsValid (inv_linkage) then
	If inv_linkage.event pfc_preinsertrow() <> inv_linkage.CONTINUE_ACTION Then
		Return PREVENT_ACTION
	End If
end if

Return CONTINUE_ACTION
end event

event pfc_resetupdate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_postupdate
//
//	Arguments:  None
//
//	Returns:  1 if it succeeds and -1 if an error occurs.
//	
//	Description:	
//	Clear the update flags in the DataWindow.
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

Return this.ResetUpdate()
end event

event pfc_properties;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_properties
//
//	Description:
//	Call the DataWindow property Dialog.
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

n_cst_dwpropertyattrib lnv_dwproperty

If IsValid(snv_property) Or IsValid(inv_property) Then
	// Set initial values.
	lnv_dwproperty.idw_requestor = this

	// Allow structure to have other values set before opening dialog.
	this.Event pfc_preproperties(lnv_dwproperty)

	// Open property window.
	If IsValid(inv_property) Then
		inv_property.of_OpenProperty(lnv_dwproperty)
	Else
		snv_property.of_OpenProperty(lnv_dwproperty)
	End If
End If
end event

event dwlbuttonup;
//PowerFilter.event post ue_buttonclicked(dwo.Type, dwo.Name)

end event

event type integer pfc_ddcustom();if	IsValid(CustomDropDown) then
	return CustomDropDown.dynamic event pfc_dropdown()
end if

return FAILURE

end event

public function boolean of_getupdateable ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetUpdateable
//
//	Access:  Public
//
//	Arguments:  None
//
//	Returns:  boolean
//	TRUE   The dw is marked as updateable
//	FALSE   The dw is not marked as updateable
//
//	Description:
//	Gets the value of the updateable property of the DW indicating
//	whether the DataWindow is updateable
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Marked obsolete  Replaced by of_IsUpdateable
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return of_IsUpdateable()
end function

public function integer of_settransobject (n_tr atr_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetTransObject
//
//	Access:  public
//
//	Arguments:
//	atr_object:  transaction object to set for the datawindow
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the transaction object that the datawindow will use
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

integer	li_rc

// Check arguments
if IsNull (atr_object) or not IsValid (atr_object) then
	return FAILURE
end if

// Set the transaction object
li_rc = this.SetTransObject (atr_object)
if li_rc = 1 then
	itr_object = atr_object
end if

return li_rc
end function

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  public
//
//	Arguments:
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
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

powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return FAILURE
end If

aw_parent = lpo_parent
return SUCCESS

end function

public function integer of_setbase (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetBase
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Basic DataWindow Services.
//               It is only necessary to start this service, if
//					  you are not using any other dw services.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_base) Or Not IsValid (inv_base) THEN
		inv_base = Create n_cst_dwsrv
		inv_base.of_SetRequestor ( this ) 
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_base) THEN
		Destroy inv_base
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setdropdownsearch (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetDropdownSearch
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDownDataWindow search services
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_dropdownsearch) Or Not IsValid (inv_dropdownsearch) THEN
		inv_dropdownsearch = Create n_cst_dwsrv_dropdownsearch
		inv_dropdownsearch.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_dropdownsearch) THEN
		Destroy inv_dropdownsearch
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_setfilter (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetSort_filter
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Sort/Filter Services.  This service
//				     provides several sort/filter dialogs and refinements.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_Filter) Or Not IsValid (inv_Filter) THEN
		inv_Filter = Create n_cst_dwsrv_filter
		inv_Filter.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_Filter) THEN
		Destroy inv_Filter
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_setfind (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetFind
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DataWindow Find/Replace services.  
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_find) Or Not IsValid (inv_find) THEN
		inv_find = Create n_cst_dwsrv_find
		inv_find.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_find) THEN
		Destroy inv_find
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setlinkage (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetLinkage
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DataWindow Linkage Services.  This service
//				     allows for multiple levels of master/detail style datawindows.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_linkage) Or Not IsValid (inv_linkage) THEN
		inv_linkage = Create n_cst_dwsrv_linkage
		inv_linkage.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_linkage) THEN
		Destroy inv_linkage
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setmultitable (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetMultitable
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Multi-Table Update Services.  This service
//				     facilitates updating datawindows where multiple SQL tables 
//				     are used.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_MultiTable) Or Not IsValid (inv_MultiTable) THEN
		inv_MultiTable = Create n_cst_dwsrv_multitable
		inv_MultiTable.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_MultiTable) THEN
		Destroy inv_MultiTable
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setprintpreview (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetPrintPreview
//
//	Arguments:  ab_switch
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  
//	Starts or stops the printpreview service.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_printpreview) Or Not IsValid (inv_printpreview) THEN
		inv_printpreview = Create n_cst_dwsrv_printpreview
		inv_printpreview.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_printpreview) THEN
		Destroy inv_printpreview
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setquerymode (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetQuerymode
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Querymode Services.  This service
//				     facilitates querymode options and includes popup help, 
//					  and save-to/load-from disk queries.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_QueryMode) Or Not IsValid (inv_QueryMode) THEN
		inv_QueryMode = Create n_cst_dwsrv_querymode
		inv_QueryMode.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_QueryMode) THEN
		Destroy inv_QueryMode
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setreport (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetReport
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Reporting Services.  The Reporting Services
//				     provide the ability to dynamically change the appearance of 
//				     datawindows.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_Report) Or Not IsValid (inv_Report) THEN
		inv_Report = Create n_cst_dwsrv_report
		inv_Report.of_SetRequestor(This)
		Return SUCCESS
	END IF
ELSE
	IF IsValid (inv_Report) THEN
		Destroy inv_Report
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setrowmanager (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetRowManager
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Row Management Services.  This service
//				     facilitates the addition, deletion of rows in a datawindow
//					  and provides an 'last-change' undo.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_rowmanager) Or Not IsValid (inv_rowmanager) THEN
		inv_rowmanager = Create n_cst_dwsrv_rowmanager
		inv_rowmanager.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_rowmanager) THEN
		Destroy inv_rowmanager
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setrowselect (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetRowSelect
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Row Selection Services.  This service
//					  provides for single, multi and extended row selection.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_RowSelect) Or Not IsValid (inv_RowSelect) THEN
		inv_RowSelect = Create n_cst_dwsrv_rowselection
		inv_RowSelect.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_RowSelect) THEN
		Destroy inv_RowSelect
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setsort (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetSort
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the Sort Service.  This service
//				     provides several sort dialogs and refinements.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_Sort) Or Not IsValid (inv_Sort) THEN
		inv_Sort = Create n_cst_dwsrv_sort
		inv_Sort.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_Sort) THEN
		Destroy inv_Sort
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setupdateable (boolean ab_isupdateable);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetUpdateable
//
//	Access:  Public
//
//	Arguments:
//	ab_isupdateable   Indicates whether the DW is updateable
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets whether the DW is updateable
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

if IsNull (ab_isupdateable) then return FAILURE

ib_isupdateable =  ab_isupdateable
return SUCCESS
end function

public function integer of_setreqcolumn (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetReqColumn
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description: 	Starts or stops the Required Column Service.
//						This service allows users to Tab/Click out of Required fields 
//						without entering any data.
//
//						Through the DataWindow ItemError Event the service (if appropriate)
//						will replace an empty string with a null value and surpress the standard
//						DataWindow "Value Required For This Item Message".  The one requirement 
//						for this behavior is that the RequiredField is also set to accept 
//						"empty string as a null".
//						The end result of this action is that an user can click or 
//						Tab out of a Required field without first having to enter data in it.
//						Note: The RowStatus and ItemStatus of the field is not 
//						affected/changed by the service.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_reqcolumn) Or Not IsValid (inv_reqcolumn) THEN
		inv_reqcolumn = Create n_cst_dwsrv_reqcolumn
		inv_reqcolumn.of_SetRequestor(this)
		Return SUCCESS
	END IF
ELSE
	IF IsValid (inv_reqcolumn) THEN
		Destroy inv_reqcolumn
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION

end function

public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CheckRequired 
//
//	Access:  Public
//
//	Arguments:
//	adw_buffer   The buffer to check for required fields
// al_row   First row to be checked.  Also stores the number of the found row
//	ai_col   First column to be checked.  Also stores the number of the found column
//	as_colname   Contains the columnname in error
//
//	Returns:  integer
//	 1 = The required fields test was successful, check arguments for required fields missing
//	 0 = The required fields test was successful and no errors were found
//  -1 = The FindRequired failed
//
//	Description:
//	Calls the FindRequired function to determine if any of the required
//	columns contain null values.
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
w_master	lw_pfcparent
window	lw_parent
boolean	lb_skipmessage=False
string	ls_msgparm[2]

// Check arguments
if IsNull (adw_buffer) or IsNull (al_row) or IsNull (ai_col) or IsNull (as_colname) then
	return FAILURE
end if

SetPointer(HourGlass!) 

// Call FindRequired to locate first error, if any
if this.FindRequired (adw_buffer, al_row, ai_col, as_colname, ab_updateonly) < 0 then
	return FAILURE
end if

// Get a reference to the window
this.of_GetParentWindow (lw_parent) 
if IsValid (lw_parent) then
	if lw_parent.TriggerEvent ("pfc_descendant") = 1 then
		lw_pfcparent = lw_parent
	end if
end if

// Check if an error was found.
if al_row <> 0 then
	
	// Make sure the window is not closing.  
	if IsValid (lw_pfcparent) then
		if lw_pfcparent.of_GetCloseStatus() then
			// It is closing, so don't show errors now.	
			lb_skipmessage = True
		end if
	end if
	
	If Not lb_skipmessage Then
		If IsValid(gnv_app.inv_error) Then
			ls_msgparm[1] = as_colname
			ls_msgparm[2] = String (al_row)
			gnv_app.inv_error.of_Message('pfc_requiredmissing', ls_msgparm, &
					gnv_app.iapp_object.DisplayName)
		Else
			of_MessageBox ('pfc_checkrequired_missingvalue', gnv_app.iapp_object.DisplayName, &
				"Required value missing for " + as_colname + " on row "  + String (al_row) + &
				".  Please enter a value.", information!, Ok!, 1)
		End If
		this.SetRow (al_row)
		this.ScrollToRow (al_row)		
		this.SetColumn (ai_col)
		this.SetFocus () 		
	End If
	
	return 1
end if

return 0
end function

public function integer of_setdropdowncalendar (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownCalendar
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDown Calendar visual object.
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
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent
n_cst_calendarattrib lnv_calendarattrib

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_Calendar) THEN
		// Tell the object to behave as a dropdown object.
		lnv_calendarattrib.ib_dropdown = True
		lw_parent.OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
		iuo_Calendar.of_SetRequestor (this)
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (iuo_Calendar) THEN
		lw_parent.CloseUserObject(iuo_Calendar)
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_setdropdowncalculator (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownCalculator
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDown Calculator visual object.
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
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent
n_cst_calculatorattrib lnv_calculatorattrib

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_Calculator) THEN
		// Tell the object to behave as a dropdown object.
		lnv_calculatorattrib.ib_dropdown = True
		lw_parent.OpenUserObjectWithParm(iuo_Calculator, lnv_calculatorattrib)
		iuo_Calculator.of_SetRequestor (this)
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (iuo_Calculator) THEN
		lw_parent.CloseUserObject(iuo_Calculator)
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_setdropdownnotes (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownNotes
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDown Notes visual object.
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
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent
n_cst_notesattrib lnv_notesattrib

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_Notes) THEN
		// Tell the object to behave as a dropdown object.
		lnv_notesattrib.DropDown = True
		lw_parent.OpenUserObjectWithParm(iuo_Notes, lnv_notesattrib)
		iuo_Notes.of_SetRequestor (this)
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (iuo_Notes) THEN
		lw_parent.CloseUserObject(iuo_Notes)
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_setresize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetResize
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DW Resize Services. 
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_resize) Or Not IsValid (inv_resize) THEN
		inv_resize = Create n_cst_dwsrv_resize
		inv_resize.of_SetRequestor ( this )
		inv_resize.of_SetOrigSize (this.Width, this.Height)
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_resize) THEN
		Destroy inv_resize
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function boolean of_isroot ();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_IsRoot
//
//	(Arguments: None
//
//	Returns:  Boolean
//		True if a root datawindow (any dw not having a master dw).
//		False if not a root datawindow.
//
//	Description:  
//	Determine if the datawindow is a root datawindow.
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

If IsValid(inv_linkage) Then
	Return inv_linkage.of_isRoot()
End If

Return True
end function

public function integer of_setproperty (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetProperty
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  
//	Starts or stops the Property Service.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_property) Or Not IsValid (inv_property) THEN
		inv_property = Create n_cst_dwsrv_property
		inv_property.of_SetRequestor (this)
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_property) THEN
		Destroy inv_property
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function integer of_setupdaterequestor (powerobject apo_updaterequestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetUpdateRequestor
//
//	Access:    Public
//
//	Arguments:
//   apo_updaterequestor   The object which is requesting an update within a 
//				transaction.  Or an invalid reference to clear the reference.
//
//	Returns:  Integer
//		1 for success
//		-1 for error.
//
//	Description:  
//	Associates the object which is requesting an update within a transaction.
//	Or clears the reference to mean there is no current object requesting an
//	update within a transaction.
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

// Check for a valid apo_updaterequestor is not desired.
ipo_updaterequestor = apo_updaterequestor
Return SUCCESS
end function

public function integer of_accepttext (boolean ab_focusonerror);//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_AcceptText
//
//	Arguments:  
//	ab_focusonerror	States if focus should be set in case of error.
//
//	Returns:  Integer
//	1 if it succeeds
//	-1 if an error occurs.
//	
//	Description:
//	Perform an accepttext and set focus when requested.
//
// Note:
//	Specific acceptext logic should be coded in descendant pfc_AcceptText event.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0  Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_AcceptText(ab_focusonerror)
Else
	li_rc = this.Event pfc_AcceptText(ab_focusonerror)
End If

return li_rc

end function

public function integer of_reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Reset
//
//	Arguments:  None
//
//	Returns:  Integer
//	1 if it succeeds 
//	-1 if an error occurs.
//	
//	Description:	
//	Resets the DataWindow(s).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_Reset()
Else
	li_rc = this.Reset()
End If

return li_rc

end function

public function integer of_retrieve ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Retrieve
//
// Access:	Public
//
//	Arguments:  none
//
//	Returns:  long
//	The return code from the Retrieve Powerscript function
//	 0 = No rows returned from successful retrieve
//	-1 = Retrieve was unsuccessful
//	>1 = Success.
//
//	Description:  
// Execute the specific Retrieve logic.
//
// Note:
//	Specific retrieve logic should be coded in descendant pfc_Retrieve event.
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

Long	ll_rc

If IsValid(inv_linkage) Then
	ll_rc = inv_linkage.of_Retrieve()
Else
	ll_rc = this.Event pfc_Retrieve()
End If

return ll_rc

end function

public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, powerobject apo_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Update
//
//	Arguments:  
//	ab_accepttext	When applicable, specifying whether control should perform an
//						AcceptText prior to performing the update:
//	ab_resetflag	Value specifying whether object should automatically 
//						reset its update flags.
//	apo_requestor	An object requesting the update within a transaction.
//
//	Returns: Integer
//	 1 = The update was successful
//	-1 = The update failed
//
//	Description:  	
//	Execute the specific Update logic.  
//
// Note:
//	Specific Update logic should be coded in descendant pfc_Update event.
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

integer		li_rc
powerobject	lpo_notvalid

If IsValid(inv_linkage) Then
	// Set the object requesting the update.
	If inv_linkage.of_SetUpdateRequestor(apo_requestor) <0 Then Return FAILURE
	
	// Perform the actual update.
	li_rc = this.of_Update(ab_accepttext, ab_resetflag)
	
	// Clear the object which requested the update.
	inv_linkage.of_SetUpdateRequestor(lpo_notvalid)
Else
	// Set the object requesting the update.
	If this.of_SetUpdateRequestor(apo_requestor) <0 Then Return FAILURE
	
	// Perform the actual update.	
	li_rc = this.of_Update(ab_accepttext, ab_resetflag)
	
	// Clear the object which requested the update.
	this.of_SetUpdateRequestor(lpo_notvalid)
End If

Return li_rc

end function

public function integer of_updatespending ();//////////////////////////////////////////////////////////////////////////////
//
//	Funciton:
//	of_UpdatesPending
//
//	Arguments:  none
//
//	Returns:  integer
//	1 = Updates are pending.
//	0 = No updates are pending
//
//	Description:
//	Determine if any updates are pending on this datawindow or its linked details.
//
// Note:
//	Specific UpdatesPending logic should be coded in descendant pfc_UpdatesPending event.
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

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_GetUpdatesPending()
Else
	li_rc = this.Event pfc_UpdatesPending()
End If

return li_rc

end function

public function integer of_validation ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Validation
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = All validation passed
//	-1 = validation failed
//
//	Description:
//	Perform validation logic.
//
// Note:
//	Specific Validation logic should be coded in descendant pfc_validation event.
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

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_Validation()
Else
	li_rc = this.Event pfc_Validation()
End If

return li_rc

end function

public function integer of_update (boolean ab_accepttext, boolean ab_resetflag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Update
//
//	Arguments:  
//	ab_accepttext	When applicable, specifying whether control should perform an
//						AcceptText prior to performing the update:
//	ab_resetflag	Value specifying whether object should automatically 
//						reset its update flags.
//
//	Returns: Integer
//	 1 = The update was successful
//	-1 = The update failed
//
//	Description:  	
//	Execute the specific Update logic.  
//
// Note:
//	Specific Update logic should be coded in descendant pfc_Update event.
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

integer		li_rc

If IsValid(inv_linkage) Then
	// Perform a Linked Update.
	li_rc = inv_linkage.of_Update(ab_accepttext, ab_resetflag)
Else
	// Perform the Update.
	li_rc = this.Event pfc_Update(ab_accepttext, ab_resetflag)
End If

Return li_rc


end function

public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, boolean ab_insert, boolean ab_update, boolean ab_delete);//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_Update
//
//	Arguments:  
//	ab_accepttext	Value specifying whether the DataWindow control should perform an
//						AcceptText prior to performing the update:
//	ab_resetflag	Value specifying whether DWControl should automatically 
//						reset the update flags.
//	ab_insert		Boolean stating if Inserts should be performed.
//	ab_update		Boolean stating if Updates should be performed.
//	ab_delete		Boolean stating if Deletes should be performed.
//
//	Returns: Integer
//	 1 = The update was successful
//	-1 = The update failed
//
//	Description:  	Perform the Specific Update logic, but only perform the
//		requested SQL (insert, update, delete) statements.
//
// Note:
//	Specific Update logic should be coded in descendant pfc_Update event.
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

integer	li_rc

// Verify passed arguments.
IF IsNull(ab_accepttext) Or IsNull(ab_resetflag) &
	Or IsNull(ab_insert) Or IsNull(ab_update) Or IsNull(ab_delete) Then 
	Return FAILURE
End If

// Set the variable which determines which updates are allowed.
is_updatesallowed = ''
If ab_insert Then is_updatesallowed += 'I'
If ab_update Then is_updatesallowed += 'U'
If ab_delete Then is_updatesallowed += 'D'

// Perform the update.
li_rc = this.Event pfc_update (ab_accepttext, ab_resetflag)

// Reset the variable which determines which updates are allowed.
is_updatesallowed = "IUD"

Return li_rc
end function

public function integer of_updateprep ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_UpdatePrep
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = All preparation passed
//	-1 = preparation failed
//
//	Description:
//	Prepare the DataWindow(s)
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

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_UpdatePrep()
Else
	li_rc = this.Event pfc_UpdatePrep()
End If

return li_rc

end function

public function integer of_postupdate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	of_PostUpdate
//
//	Arguments:  None
//
//	Returns:  Integer
//	1 if it succeeds
// -1 if an error occurs.
//	
//	Description:
//	Perform post update processing.
//	Reset the update flags in the DataWindow(s).
//
// Note:
//	Specific PostUpdate logic should be coded in descendant pfc_PostUpdate event.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

If IsValid(inv_linkage) Then
	li_rc = inv_linkage.of_PostUpdate()
Else
	li_rc = this.Event pfc_postupdate()
End If

return li_rc

end function

public function boolean of_isupdateable ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IsUpdateable
//
//	Access:  Public
//
//	Arguments:  None
//
//	Returns:  boolean
//	TRUE   The dw is marked as updateable
//	FALSE   The dw is not marked as updateable
//
//	Description:
//	Gets the value of the updateable property of the DW indicating
//	whether the DataWindow is updateable
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version - Replaces obsoleted function of_GetUpdateable(...).
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return ib_isupdateable
end function

protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_MessageBox
//
//	Access:  			protected
//
//	Arguments:
//	as_id			An ID for the Message.
//	as_title  	Text for title bar
//	as_text		Text for the actual message.
//	ae_icon 		The icon you want to display on the MessageBox.
//	ae_button	Set of CommandButtons you want to display on the MessageBox.
//	ai_default  The default button.
//
//	Returns:  integer
//	Return value of the MessageBox.
//
//	Description:
//	Display a PowerScript MessageBox.  
//	Allow PFC MessageBoxes to be manipulated prior to their actual display.
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

Return MessageBox(as_title, as_text, ae_icon, ae_button, ai_default)
end function

public function integer of_setsharedproperty (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetSharedProperty
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  
//	Starts or stops the Shared Property Service.
//
//	Note:
//	Do not set the requestor on the shared instance.
//	Do not execute snv_property.of_SetRequestor (this) since the object is shared
//	among many datawindows.
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

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(snv_property) Or Not IsValid (snv_property) THEN
		snv_property = Create n_cst_dwsrv_property
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (snv_property) THEN
		Destroy snv_property
		Return SUCCESS
	END IF	
END IF

Return NO_ACTION
end function

public function boolean of_IsSharedProperty ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IsSharedProperty
//
//	Arguments:  none
//
//	Returns: boolean
//   TRUE  - The service is started.
//   FALSE - The service is not started.
//
//	Description:  
//	Determines if the DataWindow Shared Property service has been started.
//
//	Note:
//	This function is need because all Shared variables are always defined
//	as private.  This function is only needed when an outside object needs to
// know if the Shared service has been started or not.
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

If IsValid (snv_property) Then
	Return True
End If

Return False
end function

public function integer setpowerfilter (boolean switchpowerfilter);
//Check arguments
if	IsNull(switchPowerFilter) then
	return FAILURE
end if

if	switchPowerFilter then
	if	isnull(PowerFilter) or not IsValid(PowerFilter) then
		PowerFilter = create n_cst_PowerFilter
		PowerFilter.of_SetDW(this) //equivalent to SetRequestor()
		return SUCCESS
	end if
else
	if	IsValid(PowerFilter) then
		destroy PowerFilter
		return SUCCESS
	end if
end if

return NO_ACTION

end function

public function integer setcustomdropdown (boolean setswitch);
window requestorWindow
n_customdropdownattrib customDropDownAttrib

//Check arguments
if	IsNull(setSwitch) then
	return FAILURE
end if

// Get parent window reference.
of_GetParentWindow(requestorWindow)
if	isnull(requestorWindow) or not IsValid(requestorWindow) then
	return FAILURE
end if

if	setSwitch then
	if	not IsValid (CustomDropDown) then
		// Tell the object to behave as a dropdown object.
		requestorWindow.OpenUserObject(CustomDropDown)
		CustomDropDown.SetRequestor(this)
		return SUCCESS
	end if
else
	if	IsValid (customDropDown) then
		requestorWindow.CloseUserObject(customDropDown)
		return SUCCESS
	end if
end if

return NO_ACTION

end function

public function integer filter ();// OVERRIDE!
// BUG! Fixes problem with filter function not triggering rowfocuschanged  events.

long l_previousrow

l_previousrow = this.getrow()
ib_state_rowchanging = false

// Call native filter event:
If datawindow::filter( ) = -1 Then
	Return -1
ElseIf ( Not ib_state_rowchanging ) And ( this.getrow() <> l_previousrow ) Then
	// Rows changed without events being fired.
	this.event rowfocuschanging( l_previousrow, this.getrow() )
	this.event rowfocuschanged( this.getrow() )
End If

return 1

end function

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:  DataWindow clicked
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added Linkage service notification
// 6.0 	Introduced non zero return value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Destructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	
//	Destroy the instantiated datawindow services attached to this dw.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added cleanup for new 6.0 services.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetBase (FALSE)
of_SetRowManager (FALSE)
of_SetQuerymode (FALSE)
of_SetLinkage (FALSE)
of_SetReport (FALSE)
of_SetMultitable (FALSE)
of_SetRowSelect (FALSE)
of_SetReqColumn (FALSE)
of_SetSort (FALSE)
of_SetFilter (FALSE)
of_SetFind (FALSE)
of_SetDropdownSearch (FALSE)
of_SetPrintPreview (FALSE)
of_SetResize (FALSE)
of_SetDropDownCalendar (FALSE)
of_SetDropDownCalculator (FALSE)
of_SetProperty (FALSE)
end event

event getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			getfocus
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Notify the parent window that this control got focus.
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

window 	lw_parent

of_GetParentWindow(lw_parent)
If IsValid(lw_parent) Then
	// Dynamic call to the parent window.
	lw_parent.dynamic event pfc_ControlGotFocus (this)
End If

end event

event rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//
//	Description:  Send rowfocuschanged notification to services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Added RowSelect service notification.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If IsValid( inv_rowselect ) Then
	inv_rowselect.Event pfc_RowFocusChanged (currentrow) 
End If

If IsValid ( inv_Linkage ) Then
	inv_Linkage.Event pfc_RowFocusChanged (currentrow) 
End If 
end event

event sqlpreview;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  SQLPreview
//
//	Description:	Allow for SQLSpy service.
//						Provide selective updates, inserts, and deletes. 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0 	Only perform the requested SQL (insert, update, delete) statements.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer					li_rc
string 					ls_sqlsyntax
sqlpreviewfunction	l_request 	
sqlpreviewtype			l_sqltype		
dwbuffer					l_buffer			

//Check the arguments.
If IsNull(sqltype) or IsNull(sqlsyntax) or IsNull(buffer) Then
	Return
End If

// Only perform the requested SQL (insert, update, delete) statements.
If (sqltype = PreviewSelect!) Or &
	(sqltype = PreviewInsert! And Pos(is_updatesallowed,'I')>0) Or &
	(sqltype = PreviewUpdate! And Pos(is_updatesallowed,'U')>0) Or &
	(sqltype = PreviewDelete! And Pos(is_updatesallowed,'D')>0) Then
	// Allow the continuation of the SQL statament.	
Else
	// Stop this SQL statement from being executed.
	// Return 2 - Skip this request and execute the next request.
	Return 2
End If

//If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) Then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) Then

		ls_sqlsyntax = sqlsyntax
		l_request = request
		l_sqltype = sqltype
		l_buffer = buffer

		//Send the information to the service for processing.
		li_rc = gnv_app.inv_debug.inv_sqlspy.of_sqlpreview &
			(this.ClassName(), l_request, l_sqltype, ls_sqlsyntax, l_buffer, row)
		If li_rc = 1 or li_rc = 2 Then
			// 1 Stop processing of all entries.
			// 2 Skip this request and execute the next request.
			Return li_rc
		Else
			// Normal processing.
			If ls_sqlsyntax <> sqlsyntax Then
				//The sqlsyntax was inspected and changed by the user.
				//Update the SQL to the new syntax.
				If this.SetSQLPreview (ls_sqlsyntax) = 1 Then 
					Return
				Else
					// An error was encountered on the Modified SQLStatement
					of_Messagebox ('pfc_sqlpreview_error', 'SQLSpy on SQLPreview', &
						'An error was encountered with the following SQL:~r~n~r~n'+ &
						ls_sqlsyntax, Information!, Ok!, 1)
				End If				
			End If
		End If
		
	End If
End If

end event

event itemerror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  ItemError
//
//	Description:  Send itemerror notification to services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced to support the linkage service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
w_master	lw_parent

// If appropriate replace an empty string with a null value and suppress the 
//	standard DataWindow Value Required Message. 
If IsValid(inv_reqcolumn) Then
	li_rc = inv_reqcolumn.of_SetToNullIfEmpty(row, String(dwo.Name), This.GetText())
	If li_rc > 0 Then
		If li_rc =1 Then
			// Item was changed from an Empty to a Null value.  Notify itemchanged...
			this.Event itemchanged (row, dwo, data)
		End If
		Return 3		// Reject the data value but allow focus to change.
	End If
End If

// If the window is closing Suppress all Errors. 
This.of_GetParentWindow(lw_parent)
If IsValid(lw_parent) Then
	If lw_parent.TriggerEvent ("pfc_descendant") = 1 Then	
		If lw_parent.of_GetCloseStatus() Then
			Return 1   	//	Reject the data value with no message box.
		End If
	End If
End If
end event

event itemfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			itemfocuschanged
//
//	Description:  Send itemfocuschanged notification to DW services
//	If appropriate, display the microhelp stored in the tag value of the current column.
//
//	Note:  The tag value of a column can contain just the microhelp, or may 
//	contain other information as well. 
//	The format follows: MICROHELP=<microhelp to be displayed>. 
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0	Added notification to the Linkage Service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string			ls_microhelp
window			lw_parent
n_cst_string 	lnv_string

If IsNull(dwo) Or Not IsValid (dwo) Then
	Return
End If

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	// Check the tag for any "microhelp" information.
	ls_microhelp = lnv_string.of_GetKeyValue (dwo.tag, "microhelp", ";")
	if IsNull (ls_microhelp) or Len(Trim(ls_microhelp))=0 then
		ls_microhelp = ''	
	end if

	//Notify the window.
	of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		// Dynamic call to the parent window.
		lw_parent.Dynamic Event pfc_microHelp (ls_microhelp)
	End If	
End If

If IsValid(inv_linkage) Then
	inv_linkage.Event pfc_itemfocuschanged (row, dwo)
End If
end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttondown
//
//	Description:  Allow for focus change on rbuttondown
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added Linkage service notification.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
long		ll_currow
string	ls_colname
string	ls_curcolname

// Validate arguments.
if not ib_rmbfocuschange or IsNull (dwo) or row <= 0 then
	return
end if

if IsValid (inv_linkage) then
	If inv_linkage.event pfc_rbuttondown (xpos, ypos, row, dwo) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or an error prevents changing to a new row.
		Return
	End If
end if

if IsValid (inv_rowselect) then
	inv_rowselect.event pfc_rbuttondown (xpos, ypos, row, dwo)
end if

if dwo.type <> "column" then
	return
end if

// Perform no action if already over current row/column.
ls_colname = dwo.name
ls_curcolname = this.GetColumnName()
ll_currow = this.GetRow()
if (ls_colname = ls_curcolname) and (row = ll_currow) then
	return
end if

// Set row & column.
if this.SetRow (row) = 1 then
	this.SetColumn (ls_colname)
end if
end event

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  dberror
//
//	Description:
//	Display messagebox that a database error has occurred.
// If appropriate delay displaying the database error until the appropriate
// Rollback has been performed.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Suppress error messages until after a rollback has been performed
// 6.0 	Enhanced to use new dberrorattrib to support all error attributes.
// 6.0	Enhanced to support Transaction Management by other objects
// 6.0 	Enhanced to send notification to the SqlSpy service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

w_master	lw_parent
string	ls_message
string	ls_sqlspyheading
string	ls_sqlspymessage
string	ls_msgparm[1]
powerobject lpo_updaterequestor
n_cst_dberrorattrib lnv_dberrorattrib

// The error message.
ls_message = "A database error has occurred.~r~n~r~n~r~n" + &
	"Database error code:  " + String (sqldbcode) + "~r~n~r~n" + &
	"Database error message:~r~n" + sqlerrtext

// Set the error attributes.
lnv_dberrorattrib.il_sqldbcode = sqldbcode
lnv_dberrorattrib.is_sqlerrtext = sqlerrtext
lnv_dberrorattrib.is_sqlsyntax = sqlsyntax
lnv_dberrorattrib.idwb_buffer = buffer
lnv_dberrorattrib.il_row = row
lnv_dberrorattrib.is_errormsg = ls_message
lnv_dberrorattrib.ipo_inerror = this

//If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) Then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) Then

		//Create the heading and message for the SQLSpy.
		ls_sqlspyheading = 'DBError - ' + this.ClassName() + '(' + string(row) + ')'
		ls_sqlspymessage = "Database error code:  " + String (sqldbcode) + "~r~n" + &
			"Database error message:  " + sqlerrtext
		
		//Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, '/*** ' + ls_sqlspymessage + ' ***/')
	End If
End If


// Determine if Transaction Management is being performed by another object.
If IsValid(ipo_updaterequestor) Then
	lpo_updaterequestor = ipo_updaterequestor
Else
	// Determine if the window is in the save process. 
	This.of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		If lw_parent.TriggerEvent ("pfc_descendant") = 1 Then	
			If lw_parent.of_GetSaveStatus() Then
				lpo_updaterequestor = lw_parent
			End If
		End If
	End If
End If

If IsValid(lpo_updaterequestor) Then
	// Suppress the error message (let the UpdateRequestor display it).
	// MetaClass check, Dynamic Function Call.
	lpo_updaterequestor.Dynamic Function of_SetDBErrorMsg(lnv_dberrorattrib)
Else
	// Display the message immediately.
	If IsValid(gnv_app.inv_error) Then
		ls_msgparm[1] = ls_message
		gnv_app.inv_error.of_Message ('pfc_dwdberror', ls_msgparm, &
					gnv_app.iapp_object.DisplayName)
	Else
		of_Messagebox ("pfc_dberror", gnv_app.iapp_object.DisplayName, &
			ls_message, StopSign!, Ok!, 1)
	End If
End If

return 1




end event

event resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services
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

If IsValid (inv_resize) Then
	inv_resize.Event pfc_Resize (sizetype, This.Width, This.Height)
End If
end event

event itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  itemchanged
//
//	Description:  Send itemchanged notification to services
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

integer li_rc

if IsValid (inv_linkage) then
	//	*Note: If the changed value needs to be validated.  Validation needs to 
	//		occur prior to this linkage.pfc_itemchanged event.  If key syncronization is 
	//		performed, then the changed value cannot be undone. (i.e. return codes)	
	li_rc = inv_linkage.event pfc_itemchanged (row, dwo, data)
end if
end event

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			retrieveend
//
//	Description:  
//	Send retrieveend notification to services
// Notify the SQLSpy service
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

string 	ls_sqlspyheading
string	ls_sqlspymessage

//If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) Then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) Then

		//Create the heading and message for the SQLSpy.
		ls_sqlspyheading = 'RetrieveEnd - ' + this.ClassName() 
		ls_sqlspymessage = "Rows Retrieved = "+ string(rowcount)
		
		//Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, '/*** ' + ls_sqlspymessage + ' ***/')
		
	End If
End If

If IsValid(inv_linkage) Then
	inv_linkage.Event pfc_retrieveend (rowcount)
End If
end event

event retrievestart;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			retrievestart
//
//	Description:  Send retrievestart notification to DW services
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

If IsValid(inv_linkage) Then
	inv_linkage.Event pfc_retrievestart ()
End If
end event

event rowfocuschanging;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanging
//
//	Description:  Send rowfocuschanging notification to services
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

// Row changing event being fired:
ib_state_rowchanging = true

If IsValid(inv_linkage) Then
	If inv_linkage.Event pfc_RowFocusChanging (currentrow, newrow) <>  &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the newrow.
		Return 1
	End If	
End If

Return
end event

on pfc_u_dw.create
end on

on pfc_u_dw.destroy
end on

