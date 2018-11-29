$PBExportHeader$pfc_u_tabpg_dwproperty_buffers.sru
$PBExportComments$PFC DataWindow Property - The buffers tabpage
forward
global type pfc_u_tabpg_dwproperty_buffers from u_tabpg_dwproperty_base
end type
type rb_primary from u_rb within pfc_u_tabpg_dwproperty_buffers
end type
type rb_filtered from u_rb within pfc_u_tabpg_dwproperty_buffers
end type
type rb_deleted from u_rb within pfc_u_tabpg_dwproperty_buffers
end type
type cb_sort from u_cb within pfc_u_tabpg_dwproperty_buffers
end type
type cb_filter from u_cb within pfc_u_tabpg_dwproperty_buffers
end type
type cb_undelete from u_cb within pfc_u_tabpg_dwproperty_buffers
end type
type st_primaryrowcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type st_filteredcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type st_deletedcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type gb_deleted from u_gb within pfc_u_tabpg_dwproperty_buffers
end type
type gb_filtered from u_gb within pfc_u_tabpg_dwproperty_buffers
end type
type gb_primary from u_gb within pfc_u_tabpg_dwproperty_buffers
end type
type st_modifiedcount_t from u_st within pfc_u_tabpg_dwproperty_buffers
end type
type st_primaryrowcount from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type st_modifiedcount from u_st within pfc_u_tabpg_dwproperty_buffers
end type
type st_filteredcount from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type st_deletedcount from statictext within pfc_u_tabpg_dwproperty_buffers
end type
type gb_buffer from u_gb within pfc_u_tabpg_dwproperty_buffers
end type
type dw_requestorview from u_dw within pfc_u_tabpg_dwproperty_buffers
end type
type dw_requestorduplicate from u_dw within pfc_u_tabpg_dwproperty_buffers
end type
end forward

global type pfc_u_tabpg_dwproperty_buffers from u_tabpg_dwproperty_base
int Width=1198
int Height=1200
event type integer pfc_propertybufferchanged ( dwbuffer adwb_buffer )
event type integer pfc_propertystats ( )
event type integer pfc_propertyundelete ( )
rb_primary rb_primary
rb_filtered rb_filtered
rb_deleted rb_deleted
cb_sort cb_sort
cb_filter cb_filter
cb_undelete cb_undelete
st_primaryrowcount_t st_primaryrowcount_t
st_filteredcount_t st_filteredcount_t
st_deletedcount_t st_deletedcount_t
gb_deleted gb_deleted
gb_filtered gb_filtered
gb_primary gb_primary
st_modifiedcount_t st_modifiedcount_t
st_primaryrowcount st_primaryrowcount
st_modifiedcount st_modifiedcount
st_filteredcount st_filteredcount
st_deletedcount st_deletedcount
gb_buffer gb_buffer
dw_requestorview dw_requestorview
dw_requestorduplicate dw_requestorduplicate
end type
global pfc_u_tabpg_dwproperty_buffers pfc_u_tabpg_dwproperty_buffers

type variables

end variables

event pfc_PropertyBufferChanged;call super::pfc_PropertyBufferChanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_PropertyBufferChanged
//
//	Arguments:  
//	adwb_buffer	The requested buffer.
//
//	Returns:  none
//	
//	Description:	 
//	Notification that the buffer has been changed or needs refresing.
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

Integer	li_rc
long		ll_filteredcount
long		ll_deletedcount

//Validate the argument
If adwb_buffer = Primary! or adwb_buffer = Filter! or adwb_buffer = Delete! Then
	// Expected value.
Else
	Return -1
End If

// Initialize
dw_requestorduplicate.Reset()


If adwb_buffer = Primary! Then
	// Set the datawindows.
	dw_requestorduplicate.Visible = False
	dw_requestorview.Visible = True

	// Set the buttons.
	cb_undelete.Enabled = False
	cb_filter.Enabled = True
	cb_sort.Enabled = True

ElseIf adwb_buffer = Filter! Then
	// For Display only.  Copy the Filtered rows to the Duplicate dw.
	ll_filteredcount = dw_requestorview.FilteredCount()
	If ll_filteredcount > 0 Then
		li_rc = dw_requestorview.RowsCopy (1, ll_filteredcount, Filter!, &
					dw_requestorduplicate, 1, Primary!)
		If li_rc <= 0 Then Return -1
	End If
	
	// Set the datawindows.
	dw_requestorduplicate.Visible = True
	dw_requestorview.Visible = False	
	
	// Set the buttons.
	cb_undelete.Enabled = False
	cb_filter.Enabled = True
	cb_sort.Enabled = False	
	
Else // Delete! buffer.
	// For Display only.  Copy the Deleted rows to the Duplicate dw.
	ll_deletedcount = dw_requestorview.DeletedCount()
	If ll_deletedcount > 0 Then
		li_rc = dw_requestorview.RowsCopy (1, dw_requestorview.DeletedCount(), Delete!,  &
					dw_requestorduplicate, 1, Primary!)
		If li_rc <= 0 Then Return -1	
	End If
	
	// Set the datawindows.
	dw_requestorduplicate.Visible = True
	dw_requestorview.Visible = False	
	
	// Set the buttons.
	cb_undelete.Enabled = False	
	cb_filter.Enabled = False
	cb_sort.Enabled = False	
	
End If

Return 1
end event

event pfc_PropertyStats;call super::pfc_PropertyStats;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_stat
//
//	Arguments:  
//	adwb_buffer	The requested buffer.
//
//	Returns:  none
//	
//	Description:	 
//	Notification that the buffer has been changed or needs refresing.
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

st_primaryrowcount.Text = string(dw_requestorview.RowCount())
st_modifiedcount.Text = string(dw_requestorview.ModifiedCount())
st_filteredcount.Text = string(dw_requestorview.FilteredCount())
st_deletedcount.Text = string(dw_requestorview.DeletedCount())

Return 1
end event

event pfc_PropertyUndelete;call super::pfc_PropertyUndelete;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_PropertyUndelete
//
//	Description:  Restore selected rows to the primary buffer
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

long	ll_selectedrow
long	ll_row
long	ll_focusrow
long	ll_restored

SetPointer (hourglass!) 

// Move selected rows from delete to primary buffer
ll_selectedrow = dw_requestorduplicate.GetSelectedRow (0)
ll_row = ll_selectedrow
do while ll_selectedrow > 0 
	if dw_requestorview.RowsMove (ll_row, ll_row, delete!, dw_requestorview, dw_requestorview.RowCount() + 1 , primary!) = 1 then
		ll_restored++
		ll_selectedrow = dw_requestorduplicate.GetSelectedRow (ll_selectedrow)
		ll_row = ll_selectedrow - ll_restored
	else
		exit
	end if
loop

// Scroll to first restored row
ll_focusrow = dw_requestorview.RowCount() - ll_restored + 1
dw_requestorview.ScrolltoRow (ll_focusrow) 

dw_requestorview.SetRow (ll_focusrow)

// Return the number of rows restored
Return ll_restored

end event

on pfc_u_tabpg_dwproperty_buffers.create
int iCurrent
call u_tabpg_dwproperty_base::create
this.rb_primary=create rb_primary
this.rb_filtered=create rb_filtered
this.rb_deleted=create rb_deleted
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_undelete=create cb_undelete
this.st_primaryrowcount_t=create st_primaryrowcount_t
this.st_filteredcount_t=create st_filteredcount_t
this.st_deletedcount_t=create st_deletedcount_t
this.gb_deleted=create gb_deleted
this.gb_filtered=create gb_filtered
this.gb_primary=create gb_primary
this.st_modifiedcount_t=create st_modifiedcount_t
this.st_primaryrowcount=create st_primaryrowcount
this.st_modifiedcount=create st_modifiedcount
this.st_filteredcount=create st_filteredcount
this.st_deletedcount=create st_deletedcount
this.gb_buffer=create gb_buffer
this.dw_requestorview=create dw_requestorview
this.dw_requestorduplicate=create dw_requestorduplicate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=rb_primary
this.Control[iCurrent+2]=rb_filtered
this.Control[iCurrent+3]=rb_deleted
this.Control[iCurrent+4]=cb_sort
this.Control[iCurrent+5]=cb_filter
this.Control[iCurrent+6]=cb_undelete
this.Control[iCurrent+7]=st_primaryrowcount_t
this.Control[iCurrent+8]=st_filteredcount_t
this.Control[iCurrent+9]=st_deletedcount_t
this.Control[iCurrent+10]=gb_deleted
this.Control[iCurrent+11]=gb_filtered
this.Control[iCurrent+12]=gb_primary
this.Control[iCurrent+13]=st_modifiedcount_t
this.Control[iCurrent+14]=st_primaryrowcount
this.Control[iCurrent+15]=st_modifiedcount
this.Control[iCurrent+16]=st_filteredcount
this.Control[iCurrent+17]=st_deletedcount
this.Control[iCurrent+18]=gb_buffer
this.Control[iCurrent+19]=dw_requestorview
this.Control[iCurrent+20]=dw_requestorduplicate
end on

on pfc_u_tabpg_dwproperty_buffers.destroy
call u_tabpg_dwproperty_base::destroy
destroy(this.rb_primary)
destroy(this.rb_filtered)
destroy(this.rb_deleted)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_undelete)
destroy(this.st_primaryrowcount_t)
destroy(this.st_filteredcount_t)
destroy(this.st_deletedcount_t)
destroy(this.gb_deleted)
destroy(this.gb_filtered)
destroy(this.gb_primary)
destroy(this.st_modifiedcount_t)
destroy(this.st_primaryrowcount)
destroy(this.st_modifiedcount)
destroy(this.st_filteredcount)
destroy(this.st_deletedcount)
destroy(this.gb_buffer)
destroy(this.dw_requestorview)
destroy(this.dw_requestorduplicate)
end on

event pfc_propertyopen;call super::pfc_propertyopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_Propertyopen
//
//	Arguments:  None
//
//	Returns:  Integer
//	
//	Description:	 
//	
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

// Update the onscreen stats.
Event pfc_PropertyStats()

Return 1

end event

event pfc_propertyinitialize;call super::pfc_propertyinitialize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_PropertyInitialize
//
//	Arguments:  
//	 anv_attrib   The datawindow property attributes.
//
//	Returns: Integer
//	 1 = successful
// -1 = Error
//
//	Description:
//	 Initializes the object.
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
string 	ls_dataobject

// Determine which Dataobject to try first.
If Len(Trim(inv_attrib.is_dataobjectbuffer)) > 0 Then
	ls_dataobject = Trim(inv_attrib.is_dataobjectbuffer)
Else
	ls_dataobject = idw_requestor.DataObject
End If

// Set/Validate the dataobject on the RequestorView used for the Primary view.
dw_requestorview.DataObject = ls_dataobject
li_rc = idw_requestor.ShareData ( dw_requestorview )
If li_rc <= 0 Then
	// Try the Dataobject associated with the Requestor.
	ls_dataobject = idw_requestor.DataObject
	dw_requestorview.DataObject = ls_dataobject
	li_rc = idw_requestor.ShareData ( dw_requestorview )
	If li_rc <= 0 Then	
		Return -1
	End If
End If

// Make all the columns available. 
li_rc = dw_requestorview.Event pfc_propertyunprotect()

// Set the new dataobject on the DuplicateDW used for Filter and Delete views.
// Make sure that the DuplicateDW is readonly.
dw_requestorduplicate.DataObject = ls_dataobject
dw_requestorduplicate.Object.DataWindow.ReadOnly = "Yes"

Return 1
end event

type rb_primary from u_rb within pfc_u_tabpg_dwproperty_buffers
int X=46
int Y=96
int Width=274
string Text="&Primary"
boolean Checked=true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:	 Notification to refresh the main object view.
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

Parent.Event pfc_PropertyBufferChanged(Primary!)
end event

type rb_filtered from u_rb within pfc_u_tabpg_dwproperty_buffers
int X=539
int Y=96
int Width=297
boolean BringToTop=true
string Text="&Filtered"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:	 Notification to refresh the main object view.
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

Parent.Event pfc_PropertyBufferChanged(Filter!)
end event

type rb_deleted from u_rb within pfc_u_tabpg_dwproperty_buffers
int X=855
int Y=96
int Width=297
boolean BringToTop=true
string Text="&Deleted"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:	 Notification to refresh the main object view.
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

Parent.Event pfc_PropertyBufferChanged(Delete!)
end event

type cb_sort from u_cb within pfc_u_tabpg_dwproperty_buffers
int X=421
int Y=1080
int TabOrder=50
string Text="&Sort"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:	 Notify the view datawindow to display its sort dialog.
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

// Notify the datawindow to display its sort dialog.
Parent.Enabled = False
dw_requestorview.Event pfc_sortdlg()
Parent.Enabled = True

// Reset focus to this control.
this.SetFocus()
end event

type cb_filter from u_cb within pfc_u_tabpg_dwproperty_buffers
int X=805
int Y=1080
int TabOrder=60
boolean BringToTop=true
string Text="&Filter"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:	 Notify the view datawindow to display its filter dialog.
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

// Notify the datawindow to display its filter dialog.
Parent.Enabled = False
dw_requestorview.Event pfc_filterdlg()
Parent.Enabled = True

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()

// Refresh the Duplicate DW which is currently displaying the filtered rows.
If rb_filtered.Checked Then
	rb_filtered.Event Clicked()
End If

// Reset focus to this control.
this.SetFocus()
end event

type cb_undelete from u_cb within pfc_u_tabpg_dwproperty_buffers
event type integer pfc_selectionchange ( )
int X=37
int Y=1080
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="&Undelete"
end type

event pfc_selectionchange;call super::pfc_selectionchange;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_selectionchange
//	
//	Description:	 Enable or Disable button depending on Highlighted rows.
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

// Option is only valid for the Delete! buffer.
If rb_deleted.Checked Then
	// Enable or Disable button depending on Highlighted rows.
	this.Enabled = (dw_requestorduplicate.GetSelectedRow(0) > 0)
End If

Return 1
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//	
//	Description:	 Perform Undelete functionality.
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

// Perform Undelete functionality.
Parent.Event pfc_PropertyUndelete()

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()

// Refresh the Duplicate DW which is currently displaying the Deleted rows.
If rb_deleted.Checked Then
	rb_deleted.Event Clicked()
End If

// Reset focus to this control.
this.SetFocus()
end event

type st_primaryrowcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
int X=46
int Y=200
int Width=247
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="RowCount:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_filteredcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
int X=539
int Y=200
int Width=274
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="RowCount:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_deletedcount_t from statictext within pfc_u_tabpg_dwproperty_buffers
int X=855
int Y=200
int Width=279
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="RowCount:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_deleted from u_gb within pfc_u_tabpg_dwproperty_buffers
int X=855
int Y=172
int Width=274
int Height=12
int TabOrder=0
string Text=""
end type

type gb_filtered from u_gb within pfc_u_tabpg_dwproperty_buffers
int X=539
int Y=172
int Width=274
int Height=12
int TabOrder=0
string Text=""
end type

type gb_primary from u_gb within pfc_u_tabpg_dwproperty_buffers
int X=41
int Y=172
int Width=457
int Height=12
int TabOrder=0
string Text=""
end type

type st_modifiedcount_t from u_st within pfc_u_tabpg_dwproperty_buffers
int X=41
int Y=268
int Width=224
string Text="Modified:"
end type

type st_primaryrowcount from statictext within pfc_u_tabpg_dwproperty_buffers
int X=288
int Y=200
int Width=215
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_modifiedcount from u_st within pfc_u_tabpg_dwproperty_buffers
int X=288
int Y=268
int Width=206
boolean BringToTop=true
string Text="0"
end type

type st_filteredcount from statictext within pfc_u_tabpg_dwproperty_buffers
int X=535
int Y=268
int Width=270
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_deletedcount from statictext within pfc_u_tabpg_dwproperty_buffers
int X=855
int Y=268
int Width=251
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_buffer from u_gb within pfc_u_tabpg_dwproperty_buffers
int X=18
int Y=36
int Width=1147
int Height=304
int TabOrder=10
string Text="Buffer"
end type

type dw_requestorview from u_dw within pfc_u_tabpg_dwproperty_buffers
event type integer pfc_propertyunprotect ( )
int X=14
int Y=372
int Width=1152
int Height=668
int TabOrder=20
boolean HScrollBar=true
end type

event pfc_propertyunprotect;call super::pfc_propertyunprotect;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_propertyunprotect
//
//	Arguments:  None
//
//	Returns: Integer
//	 1 = successful
// -1 = Error
//
//	Description:
//	 Unprotects all columns.
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
integer	li_upper
integer	li_cnt
integer	li_value
string	ls_rc
string	ls_modifyexp
string	ls_collist[]

// Validate required reference.
If IsNull(inv_reqcolumn) or Not IsValid(inv_reqcolumn) Then
	Return -1
End If

// Get a list of the visible columns.
li_rc = inv_reqcolumn.of_GetObjects (ls_collist, "column", "*", true) 
li_upper = UpperBound(ls_collist)

// Loop around all columns to unprotect them.
For li_cnt = 1 to li_upper
	ls_modifyexp += ls_collist[li_cnt] + ".Protect = 0 "
Next
If Len(ls_modifyexp) > 0 Then
	ls_rc = this.Modify(ls_modifyexp)
	If Len(ls_rc) > 0 Then Return -1
End If

// Loop around all columns to make sure they have a tabsequence.
ls_modifyexp = ''
For li_cnt = 1 to li_upper
	ls_modifyexp += ls_collist[li_cnt] + ".TabSequence="+ String(li_cnt+li_value)+ " "
	li_value += 10
Next
If Len(ls_modifyexp) > 0 Then
	ls_rc = this.Modify(ls_modifyexp)
	If Len(ls_rc) > 0 Then Return -1
End If

Return 1
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//	
//	Description:	 Start desired services.
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

// Start the service to allow moving past required columns.
this.of_SetReqColumn(True)

// Start the service to help Manage inserts and deletes.
this.of_SetRowManager(True)
inv_rowmanager.of_SetRestoreRow(False)

// Start the service to highlight the current row.
this.of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.EXTENDED)

// Start the service to allow Filtering.
this.of_SetFilter(True)
inv_filter.of_SetStyle(inv_filter.DEFAULT)

// Start the service to allow sorting.
this.of_SetSort(True)
inv_sort.of_SetStyle(inv_sort.DROPDOWNLISTBOX )

end event

event pfc_deleterow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_deleterow
//	
//	Description:	 After deleting rows, update the onscreen stats.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT pfc_deleterow( )

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()

Return li_rc
end event

event pfc_addrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_deleterow
//	
//	Description:	 After Adding rows, update the onscreen stats.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT pfc_addrow( )

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()


Return li_rc
end event

event pfc_insertrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_deleterow
//	
//	Description:	 After inserting rows, update the onscreen stats.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT pfc_insertrow( )

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()

Return li_rc
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  itemchanged
//	
//	Description:	 After an item changes, update the onscreen stats.
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

// Update the onscreen stats by posting the event.
Parent.Post Event pfc_PropertyStats()

end event

event pfc_restorerow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_deleterow
//	
//	Description:	 After Restoring rows, update the onscreen stats.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT pfc_restorerow( )

// Update the onscreen stats.
Parent.Event pfc_PropertyStats()

Return li_rc
end event

type dw_requestorduplicate from u_dw within pfc_u_tabpg_dwproperty_buffers
int X=14
int Y=372
int Width=1152
int Height=668
int TabOrder=30
boolean HScrollBar=true
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//	
//	Description:	 Start desired services.
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

// Always start out hidden.
this.Visible = False

// Start the service to Select Rows.
this.of_SetRowSelect(True)
If IsValid(inv_rowselect) Then
	inv_rowselect.of_SetStyle(inv_rowselect.EXTENDED)
End If

end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//	
//	Description:	 Notify the Undelete button of possible row selection changes.
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

// Notify the Undelete button of possible row selection changes.
cb_undelete.Post Event pfc_selectionchange()

Return 


end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//	
//	Description:	 Notify the Undelete button of possible row selection changes.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT clicked(xpos, ypos, row, dwo)

// Notify the Undelete button of possible row selection changes.
cb_undelete.Post Event pfc_selectionchange()

Return li_rc

end event

event lbuttonup;call super::lbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  lbuttonup
//	
//	Description:	 Notify the Undelete button of possible row selection changes.
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

// Notify the Undelete button of possible row selection changes.
cb_undelete.Post Event pfc_selectionchange()

end event

event rbuttondown;call super::rbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttondown
//	
//	Description:	 Notify the Undelete button of possible row selection changes.
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

// Notify the Undelete button of possible row selection changes.
cb_undelete.Post Event pfc_selectionchange()

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttonup
//	
//	Description:	 Notify the Undelete button of possible row selection changes.
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

// ------ Override Ancestor in order to get its return code --------

integer	li_rc

li_rc = Super::EVENT rbuttonup(xpos, ypos, row, dwo)

// Notify the Undelete button of possible row selection changes.
cb_undelete.Post Event pfc_selectionchange()

Return li_rc

end event

