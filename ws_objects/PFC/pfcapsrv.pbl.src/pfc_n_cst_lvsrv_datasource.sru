$PBExportHeader$pfc_n_cst_lvsrv_datasource.sru
$PBExportComments$listview datasource service
forward
global type pfc_n_cst_lvsrv_datasource from n_cst_lvsrv
end type
end forward

global type pfc_n_cst_lvsrv_datasource from n_cst_lvsrv
event type long pfc_endlabeledit ( integer ai_index,  string as_newlabel )
event type integer pfc_undodelete ( )
event type integer pfc_undoinsert ( )
event type integer pfc_undoedit ( )
event type integer pfc_undo ( )
event type integer pfc_deleteitem ( )
event type integer pfc_insertitem ( n_ds ads_obj,  long al_row,  listviewitem alvi_item,  string as_position,  integer ai_item )
event type integer pfc_setitemattributes ( n_ds ads_source,  long al_row,  ref listviewitem alvi_item )
event type integer pfc_refresh ( )
event type integer pfc_refreshitem ( integer ai_index )
end type
global pfc_n_cst_lvsrv_datasource pfc_n_cst_lvsrv_datasource

type variables
Constant String UNDO_EDIT = "Edit"
Constant String UNDO_INSERT = "Insert"
Constant String UNDO_DELETE = "Delete"
Constant String CACHE_ID = "pfc listview"

Protected:

n_cst_lvsrvattrib	inv_attrib
n_cst_columnattrib	inv_colattrib[]

boolean	ib_confirmondelete = false
string	is_pfckey = "pfc_lvi_key"

// undo functionality
boolean		ib_undo = False
long		il_undodeletehandle[]
long		il_undoinserthandle
long		il_undoedithandle
string		is_undoeditlabeltext
string		is_undotype
listviewitem	ilvi_undodeleteitem[]

boolean		ib_isrefreshing = False
boolean		ib_isundoing = False

n_cst_dwcache	inv_cache

end variables

forward prototypes
public function long of_refresh ()
public function integer of_update (boolean ab_accept, boolean ab_resetflags)
public function integer of_getdatasource (ref n_ds ads_source)
public function integer of_resetupdate ()
public function integer of_register (string as_labelcolumn, string as_dwobjectname, string as_importfile)
public function integer of_register (string as_labelcolumn, string as_dwobjectname, powerobject apo_data[])
public function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj)
public function integer of_register (string as_labelcolumn, string as_dwobjectname)
public function integer of_register (string as_labelcolumn, datastore ads_control)
public function integer of_register (string as_labelcolumn, n_tr atr_obj, string as_sql)
public function integer of_register (string as_labelcolumn, datawindow adw_control)
public function integer of_resetlist ()
public function integer of_reset ()
protected function integer of_clearundo ()
public function boolean of_isconfirmondelete ()
public function integer of_setconfirmondelete (boolean ab_switch)
public function string of_getlabelcolumn ()
public function string of_getpicturecolumn ()
public function string of_getstatepicturecolumn ()
public function string of_getoverlaypicturecolumn ()
public function integer of_setstatepicturecolumn (string as_column)
public function integer of_setoverlaypicturecolumn (string as_column)
public function string of_getxposcolumn ()
public function string of_getyposcolumn ()
public function integer of_setxposcolumn (string as_column)
public function integer of_setyposcolumn (string as_column)
public function integer of_setpicturecolumn (string as_column)
public function integer of_setitemattributes (n_ds ads_source, long al_row, ref listviewitem alvi_item)
public function integer of_insertitem (ref n_ds ads_obj, long al_row, listviewitem alvi_new, string as_position, integer ai_item)
public function string of_getdataobject ()
public function string of_getmethod ()
public function integer of_converttorow (any aa_columnvalues[], ref n_ds ads_obj, ref long al_row)
protected function integer of_registerdatasource (string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
public function integer of_confirmdelete (long al_amount)
public function integer of_registerreportcolumn ()
public function boolean of_canundo ()
public function boolean of_canundo (ref string as_undotype)
protected function integer of_setcache (boolean ab_switch)
public function integer of_gettransobject (ref n_tr atr_obj)
public function integer of_getdatarow (integer ai_item, ref n_ds ads_source, ref long al_row)
protected function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
public function integer of_unregister ()
public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel, alignment aal_alignment, integer ai_columnwidth)
public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel, alignment aal_alignment)
public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel)
public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname)
public function integer of_unregisterreportcolumn ()
public function integer of_unregisterreportcolumn (integer ai_column)
public function integer of_getcolumninfo (integer ai_column, ref n_cst_columnattrib anv_colattrib)
public function integer of_registerreportcolumn (n_ds ads_obj)
public function string of_formatdata (string as_columnname, string as_colformat, string as_coltype, n_ds ads_obj, long al_row)
public function integer of_setundo (boolean ab_switch)
protected function boolean of_confirmondelete ()
public function string of_decodekey (string as_decodekey)
public function integer of_deleteitem (integer ai_index)
public function integer of_getindex (n_ds ads_obj, long al_row)
public function integer of_getindex (long al_row)
public function long of_retrieve (any aa_args[20], ref n_ds ads_data)
public function string of_encodekey (n_ds ads_source, long al_row)
public function integer of_deleteitem ()
public function integer of_getattributes (ref n_cst_lvsrvattrib anv_attrib)
end prototypes

event pfc_endlabeledit;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_EndLabelEdit
//
//	Arguments:	
//	ai_index			Index of the listview item being used
//	as_newlabel		Text to become the new label of the listview item
//
//	Return:		Long
//		CONTINUE_ACTION	Allow the new text to become the item's label
//		PREVENT_ACTION		Prevent the new text from becoming the item's label
//
//	Description:	Change the label column in the appropriate data source to be
//						the newtext.  This only works if the label column is updatable.
//						If a computed column is being used for the label, override
//						this script with appropriate code.
//
//						NOTE:  Update() is NOT called for the DataStore.  This is
//						left to the user to perform.
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

Long					ll_Row
n_ds					lds_DataStore
ListViewItem		llvi_Item

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// Make sure the label did change
ilv_requestor.GetItem(ai_index, llvi_Item)
If as_newlabel = llvi_Item.Label Then Return PREVENT_ACTION

// Get the row in the DataStore
If this.of_GetDataRow(ai_index, lds_DataStore, ll_Row) = FAILURE Then
	Return PREVENT_ACTION
End If

// Change the value of the label column
If lds_DataStore.SetItem(ll_Row, inv_attrib.is_LabelColumn, as_newlabel) < 1 Then Return PREVENT_ACTION

// set the undo values
if ib_undo Then
	il_UndoEditHandle = ai_index
	is_UndoEditLabelText = llvi_Item.Label
	is_UndoType = UNDO_EDIT
End If

Return CONTINUE_ACTION

end event

event pfc_undodelete;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_UndoDelete
//
//	Arguments:	None
//
//	Returns:		integer
//	 1 = success; last delete was undone
//	 0 = nothing to undo
//	-1 = error
//
//	Description:	Restore the last deleted item (items if multiple delete occured)
//						back to the listview
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
integer	li_rc, li_numbertoundo, li_cnt
long		ll_row, ll_rowcount, ll_undohandle, ll_deleterowid
long		ll_emptyhandle[]
string	ls_key, ls_undokey
listviewitem	llvi_undo
listviewitem	llvi_empty, llvi_emptyitem[]

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// do not undo if undo is not set
If Not ib_undo Then Return -1

// Check to see if we have an delete to undo
li_numbertoundo = UpperBound(il_UndoDeleteHandle)
If li_numbertoundo < 1 then Return 0

//ilv_requestor.SetRedraw(False)
For li_cnt = li_numbertoundo to 1 Step -1

	ll_undohandle = il_UndoDeleteHandle[li_cnt]
//	ls_undokey = string( ilvi_UndoDeleteItem[li_cnt].Data )
	llvi_undo = ilvi_UndoDeleteItem[li_cnt]
	
	// Reset the undo delete variables (here if there are problems so we don't try to undelete the wrong thing)
	il_UndoDeleteHandle[li_cnt] = 0
	ilvi_UndoDeleteItem[li_cnt] = llvi_empty
	
	// The last row in the DataStore Delete! buffer is the one last deleted.
	ll_row = inv_attrib.ids_source.DeletedCount()
	If ll_row < 1 Then Return -1

	// Compare the keys to see if we really have the right row
	ls_undokey = of_DecodeKey( string(llvi_undo.data) )
	ll_deleterowid = inv_attrib.ids_source.GetRowFromRowid(long(ls_undokey), Delete!)
	If ll_deleterowid > 0 Then
		// Move row back to primary buffer
		ll_rowcount = inv_attrib.ids_source.RowCount()
		inv_attrib.ids_source.RowsMove(ll_deleterowid, ll_deleterowid, Delete!, inv_attrib.ids_source, (ll_rowcount + 1), Primary!)
	Else
		Continue
	End If

	// Insert row back under parent.
	llvi_undo.selected = False
	li_rc = ilv_requestor.InsertItem(ll_undohandle, llvi_undo)
	il_undoinserthandle = ll_undohandle
	if li_rc < 0 then Return -1

End For

// Reset the undo delete variables for upperbound check
il_UndoDeleteHandle = ll_emptyhandle
ilvi_UndoDeleteItem = llvi_emptyitem
is_UndoType = ""

//ilv_requestor.SetRedraw(True)

return 1

end event

event pfc_undoinsert;call super::pfc_undoinsert;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_UndoInsert
//
//	Arguments:	None
//
//	Returns:		integer
//	 1 = success; last Insert was undone
//	 0 = nothing to undo
//	-1 = error
//
//	Description:	Remove the last inserted item from the listview
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
long		ll_undohandle

// do not undo if undo is not set
If Not ib_undo Then Return -1

// check to see if we have something to undo
If il_UndoInsertHandle < 1 Then Return 0

ll_undohandle = il_UndoInsertHandle
	
// Reset the undo insert variables (here if there are problems so we don't try to uninsert the wrong thing)
il_UndoInsertHandle = 0
is_UndoType = ""
	
// pfc undo process running - do not display confirmation messages
ib_isundoing = True

//	Remove the item from the listview (visual and datastore)
If of_deleteitem(ll_undohandle) < 1 Then Return -1

// pfc undo process Not running - ok to display confirmation messages
ib_isundoing = True

return 1
end event

event pfc_undoedit;call super::pfc_undoedit;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_UndoEdit
//
//	Arguments:	None
//
//	Returns:		integer
//	 1 = success; last change was undone
//	 0 = nothing to undo
//	-1 = error
//
//	Description:	Restore the previous value the label had before it was changed
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

Long					ll_Row, ll_undohandle
string				ls_undotext
n_ds					lds_DataStore
ListViewItem		llvi_Item

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// do not undo if undo is not set
If Not ib_undo Then Return -1

// check to see if we have something to undo
If il_UndoEditHandle < 1 Then Return 0

ll_undohandle = il_UndoEditHandle
ls_undotext = is_UndoEditLabelText
	
// reset the undo values here.  If an error occurs do not want undo hanging around
il_UndoEditHandle = 0
is_UndoEditLabelText = ""
is_UndoType = ""

// Get the listview item
If ilv_requestor.GetItem(ll_undohandle, llvi_Item) < 1 Then Return -1

// Get the row in the DataStore
If of_GetDataRow(ll_undohandle, lds_DataStore, ll_Row) = -1 Then
	Return -1
End If

// Change the value of the label column
lds_DataStore.SetItem(ll_Row, inv_attrib.is_LabelColumn, ls_undotext)

// Reset the label on the treeivew item
llvi_Item.Label = ls_undotext
If ilv_requestor.SetItem(ll_undohandle, llvi_item) < 1 Then Return -1


Return 1

end event

event pfc_undo;call super::pfc_undo;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_Undo
//
//	Arguments:	None
//
//	Returns:		integer
//	 1 = success; 
//	 0 = nothing to undo
//	-1 = error
//
//	Description:	Restore the last listview change.  
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
String	ls_undotype

// do not undo if undo is not set
If Not ib_undo Then Return -1

If of_CanUndo(ls_undotype) then
	Choose Case ls_UndoType
		Case UNDO_DELETE
			return this.event pfc_undodelete()
		Case UNDO_INSERT
			return this.event pfc_undoinsert()
		Case UNDO_EDIT
			return this.event pfc_undoedit()
	End Choose
End If

Return 0
end event

event pfc_deleteitem;call super::pfc_deleteitem;//////////////////////////////////////////////////////////////////////////////
//
//	Function:	pfc_DeleteItem
//
//	Access:		public
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	- the item was deleted successfully
//					 0 - nothing deleted (or was prevented)
//					-1	- an error occurred
//
//	Description:	Delete an item(s) from the listview.  The item's row will be
//						DELETED from its DataStore (the user must call the Update(),
//						however).  
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

return of_deleteitem()
end event

event pfc_insertitem;call super::pfc_insertitem;//////////////////////////////////////////////////////////////////////////////
//
//	Function:	pfc_InsertItem
//
//	Access:		public
//
//	Arguments:
//	ads_obj		The DataStore containing the data to be used for the new item.
//						This can be the same DataStore that was created for the listview, or
//						another maintained by the user.  If the latter, the row will be added
//						to the listviews DataStore.  Passed by reference.
//	al_Row		The row in the DataStore pointing to the data.
//	alvi_item	The Item to be added to the listview
//	as_Position	The position under the parent where the new item will be inserted:
//						"First" - before the first item of the listview 
//						"Last" - after the last listview item (default)
//						"Before" - before the item with index ai_item
//						"After" - after the item with index ai_item
//	ai_Item		The index to the item which the new item will be inserted either after or before.
//						Ignored unless as_Position = "After" or "Before".
//
//	Returns:		Integer
//					Returns the index of the item if it was added successfully, 
//					-1 if an error occurrs.
//
//	Description:	Add a new item to the ListView using data from a DataStore.
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

return of_insertitem(ads_obj, al_row, alvi_item, as_position, ai_item)
end event

event pfc_setitemattributes;//////////////////////////////////////////////////////////////////////////////
//
//	Function:	pfc_SetItemAttributes
//
//	Access:		public
//
//	Arguments:
//	ads_source	The datasource used to get information for the listview attributes
//	al_Row		The row in the DataStore to use for the item's attributes.
//	alvi_Item	The pointer to a ListView item whose attributes are to be set.
//						Passed by reference
//
//	Returns:		Integer
//					Returns 1 if successful, -1 if an error occurred
//
//	Description:	Set the default attributes of a ListView item using data from the data source.
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

return of_setitemattributes(ads_source, al_row, alvi_item)

end event

event pfc_refresh;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_Refresh
//
//	Arguments:	None
//
//	Returns:		long
//					 # of items refreshed successfully  
//					-1 = an error occurred
//
//	Description:	Refresh the ListView with items from the data source.
//						Do not re-retrieve the data.
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
n_ds		lds_data

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

Setpointer(hourglass!)

// refresh the listview
If ilv_requestor.DeleteItems() < 1 Then Return -1

// Reset the undo delete variables because indexes change when re-adding items
this.of_clearundo()

// Get the data
this.of_getdatasource(lds_data)

// add the retrieved rows to the listview
Return ilv_requestor.event pfc_addall(lds_data) 
end event

event pfc_refreshitem;//////////////////////////////////////////////////////////////////////////////
//
//	Event:	pfc_RefreshItem
//
//	Arguments:
//	ai_index		The index of the item to be refreshed.
//
//	Returns:		Integer
//					 1 if successfull
//					-1 if an error occurred
//
//	Description:	Refresh an item in the ListView.  Reset all its attributes to the 
//						default values based on the data in the DataStore.
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
Integer			li_rc=-1
Long				ll_Row
ListViewItem	llvi_Item
n_ds				lds_Source

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// Check Arguments
If IsNull(ai_index) or (ai_index < 0) Then Return -1
	
	// Get the item
If ilv_requestor.GetItem(ai_index, llvi_Item) <> 1 Then Return -1

// Get the corresponding row in the DataStore
If this.of_GetDataRow(ai_index, lds_Source, ll_Row) <> 1 Then 
	Return -1
End If

// Set the item's attributes
ilv_requestor.event pfc_SetItemAttributes(lds_source, ll_row, llvi_item)

// Perform the Prerefreshitem logic if needed
ilv_requestor.event pfc_prerefreshitem(ai_index, lds_source, ll_row, llvi_item)

// Refresh the item
li_rc = ilv_requestor.SetItem(ai_index, llvi_Item)

Return li_rc


end event

public function long of_refresh ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Refresh
//
//	Access:		public
//
//	Arguments:	None.
//
//	Returns:		Long
//					 1 if successful
//					-1 if an error occurred
//
//	Description:	Refresh the ListView with items from the data source.
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

// Reset the undo delete variables because indexes change when re-adding items
this.of_clearundo()

Return 1

end function

public function integer of_update (boolean ab_accept, boolean ab_resetflags);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Update
//
//	Access:		public
//
//	Arguments:
//	ab_Accept		True - perform an AcceptText prior to the update,
//						False - do not perform an AcceptText.
//	ab_ResetFlags	True - reset the status flags,
//						False - do not reset the flags.
//
//	Returns:		Integer
//					 1	- the DataStore was updated successfully
//					-1	- an error occurred
//
//	Description:	Update the DataStore associated with the ListView.
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

Return inv_attrib.ids_Source.Update(ab_Accept, ab_ResetFlags)

end function

public function integer of_getdatasource (ref n_ds ads_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDataSource
//
//	Access:		public
//
//	Arguments:
//	ads_Source	The handle to the DataStore (of type n_ds) for the Listview.
//						Passed by reference.
//
//	Returns:		Integer
//					 1	- the DataStore was valid, 
//					-1	- it was not.
//
//	Description:	Get the DataStore used as the source for the ListView.  This
//						allows the user get data and attributes from the internal data source.
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

If IsNull(inv_attrib.ids_Source) Or Not IsValid(inv_attrib.ids_Source) Then Return -1

ads_Source = inv_attrib.ids_Source

Return 1

end function

public function integer of_resetupdate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_ResetUpdate
//
//	Access:		public
//
//	Arguments:	None.
//
//	Returns:		Integer
//					 1	- the DataStore flags were reset successfully
//					-1	- an error occurred
//
//	Description:	Reset the update flags for a DataStore associated with the ListView.
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

Return inv_attrib.ids_Source.ResetUpdate()

end function

public function integer of_register (string as_labelcolumn, string as_dwobjectname, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	as_dwobjectname	The data object to be used for the data source datastore.
//	as_importfile		The filename to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a disk file as a data source for the ListView.  
//						The data source will be linked to the Listview and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile

//	Check Arguments
If IsNull(as_dwobjectname) or Len(Trim(as_dwobjectname))= 0 Then Return -1
If IsNull(as_importfile) or Not FileExists(as_importfile) Then Return -1

// Set Null to indicate non-usage
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

Return of_register(as_LabelColumn, as_dwobjectname, ltr_obj, inv_cache.IMPORTFILE, &
								ls_sql, lpo_obj, ldw_control, lds_control, as_importfile)

end function

public function integer of_register (string as_labelcolumn, string as_dwobjectname, powerobject apo_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	as_dwobjectname	The data object to be used for the data source datastore.
//	apo_data				The powerobject object to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a powerobject (usually an array) as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile

// Check Arguments
If IsNull(as_dwobjectname) or Len(Trim(as_dwobjectname))= 0 Then Return -1
If IsNull(apo_data) Then Return -1
If UpperBound(apo_data) = 0 Then Return -1

// Set Null to indicate non-use
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

Return of_register(as_LabelColumn, as_dwobjectname, ltr_obj, inv_cache.POWEROBJECT, &
								ls_sql, apo_data, ldw_control, lds_control, ls_importfile)

end function

public function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	as_dwobjectname	The data object to be used for the data source datastore.
//	atr_obj				The transaction object to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a datawindow as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile

// Check Arguments
If IsNull(as_dwobjectname) or Len(Trim(as_dwobjectname))= 0 Then Return -1
If IsNull(atr_obj) Or Not IsValid(atr_obj) Then Return -1
If Not atr_obj.of_IsConnected() Then Return -1

SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

Return of_register(as_LabelColumn, as_dwobjectname, atr_obj, inv_cache.RETRIEVE, &
								ls_sql, lpo_obj, ldw_control, lds_control, ls_importfile)

end function

public function integer of_register (string as_labelcolumn, string as_dwobjectname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	as_dwobjectname	The data object to be used for the data source datastore.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a datawindow object as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_retrieveargs
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile

// Check Arguments
If IsNull(as_dwobjectname) or Len(Trim(as_dwobjectname))= 0 Then Return -1

// set null to indicate non-use
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

Return of_register(as_LabelColumn, as_dwobjectname, ltr_obj, inv_cache.DATAOBJECTDATA, &
								ls_sql, lpo_obj, ldw_control, lds_control, ls_importfile)

end function

public function integer of_register (string as_labelcolumn, datastore ads_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the Datastore object to display as the label. 
//	ads_control			The DataStore control to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a datastore control as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile

// Check Arguments
If IsNull(ads_control) or Not IsValid(ads_control) Then Return -1
If Len(ads_control.DataObject) = 0 Then Return -1

// SET NULL to indicate non usage
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

// Populate the argument with the desired DataObject.
ls_dwobjectname = ads_control.DataObject

Return of_register(as_LabelColumn, ls_dwobjectname, ltr_obj, inv_cache.DATASTORECONTROL, &
								ls_sql, lpo_obj, ldw_control, ads_control, ls_importfile)

end function

public function integer of_register (string as_labelcolumn, n_tr atr_obj, string as_sql);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	atr_obj				The transaction object to be used for the data source.
//	as_sql				The SQL Statement to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a SQL statement as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql
powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile
string		ls_dwsyntax, ls_Sqlerr

// check transaction objects
If IsNull(atr_obj) Or Not IsValid(atr_obj) Then Return -1
If Not atr_obj.of_IsConnected() Then Return -1

// check sql statement
If IsNull(as_sql) or ( len(as_sql) = 0 ) Then Return -1
	
// set null to indicate non-use
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

// get sql statement for object creation
ls_dwsyntax = atr_obj.SyntaxFromSQL ( as_sql, '', ls_sqlerr )	
If Len(ls_sqlerr) > 0 Then Return -1
		
Return of_register(as_LabelColumn, ls_dwsyntax, atr_obj, inv_cache.SQL, &
								as_sql, lpo_obj, ldw_control, lds_control, ls_importfile)

end function

public function integer of_register (string as_labelcolumn, datawindow adw_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display. 
//	adw_control			The DataWindow control to be used for the data source.
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a datawindow control as a data source for the ListView.  
//						The data source will be linked to the ListView and used
//						to populate.
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

n_tr			ltr_obj
string		ls_dwobjectname
string		ls_sql

powerobject lpo_obj[]
datawindow	ldw_control
datastore	lds_control
string		ls_importfile


// Check Arguments
If IsNull(adw_control) or Not IsValid(adw_control) Then Return -1
If Len(adw_control.DataObject) = 0 Then Return -1

// Set Null to indicate non-use
SetNull(ls_sql)
SetNull(ldw_control)
SetNull(lds_control)
SetNull(ls_importfile)

// Populate the argument with the desired DataObject.
ls_dwobjectname = adw_control.DataObject

Return of_register(as_LabelColumn, ls_dwobjectname, ltr_obj, inv_cache.DATAWINDOWCONTROL, &
								ls_sql, lpo_obj, adw_control, lds_control, ls_importfile)

end function

public function integer of_resetlist ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_ResetList
//
//	Access:		public
//
//	Arguments:  None
//
//	Returns:  Integer
//	 1 if it succeeds
//	-1 if an error occurs.
//	
//	Description:
//	Reset/clear the entire listview (items and datastores).
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

// clear the listview - delete the columns from detail view
If of_unregisterreportcolumn() < 1 Then Return -1

// clear the datasource
this.of_reset()

// Reset the undo variables 
this.of_clearundo()

return 1


end function

public function integer of_reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Reset
//
//	Access:		public
//
//	Arguments:	None.
//
//	Returns:		Integer
//					 1	- the DataStore was reset successfully
//					-1	- an error occurred
//
//	Description:	Reset the DataStore associated with the ListView.
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

Return inv_attrib.ids_Source.Reset()

end function

protected function integer of_clearundo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_ClearUndo
//
//	Access:		public
//
//	Arguments:  None
//
//	Returns:  Integer
//				 1 if it succeeds
//	
//	Description:
//	clear the undo properties
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
long				ll_empty[]
listviewitem	llvi_emptyitem[]

// Reset the undo variables
ilvi_UndoDeleteItem = llvi_emptyitem
il_UndoDeleteHandle = ll_empty
il_UndoEditHandle = 0
il_UndoInsertHandle = 0
is_UndoEditLabelText = ""
is_UndoType = ""

return 1


end function

public function boolean of_isconfirmondelete ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_IsConfirmOnDelete
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		boolean

//
//	Description:
//	Returns whether deletions will be confirmed first
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

Return ib_confirmondelete

end function

public function integer of_setconfirmondelete (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetConfirmOnDelete
//
//	Access:		Public
//
//	Arguments:
//	ab_switch	specifies whether deletions will be confirmed first
//
//	Returns:		integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets whether deletions will be confirmed by user first
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

// Validate arguments
if IsNull (ab_switch) then return -1

ib_confirmondelete = ab_switch

return 1
end function

public function string of_getlabelcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetLabelColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as item label
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

return inv_attrib.is_LabelColumn
end function

public function string of_getpicturecolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetPictureColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as the picture display
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

return inv_attrib.is_PictureColumn
end function

public function string of_getstatepicturecolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetStatePictureColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as the state picture display
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

return inv_attrib.is_StateColumn
end function

public function string of_getoverlaypicturecolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetOverlayPictureColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as the overlay display picture
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

return inv_attrib.is_OverlayColumn
end function

public function integer of_setstatepicturecolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetStatePictureColumn
//
//	Access:		Public
//
//	Arguments:	
//	as_column	column in datasource to be used for state picture display purposes
//						The column may be an integer (used as the picture index) or a
//						string (a bmp name which will be used as the picture).  Or a number
//						may be passed in (i.e. "1") which will be used as the state picture
//						index for all items.
//
//	Returns:		integer
//					 1 = success
//					-1 = failure
//
//	Description:
//		Sets the column name used from the datasource as the state picture display
//
//		Note:  The datasource(dataobject) must be set first before calling this function
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

If IsNull(as_column) Then
	Return -1
End If

// Check to make sure column is valid for the dataobject
If Trim(as_column) <> "" And Not IsNumber(as_column) And &
	inv_attrib.ids_source.Describe(as_column + ".Band") = "!" Then 
		Return -1
End If

inv_attrib.is_StateColumn = as_column

return 1
end function

public function integer of_setoverlaypicturecolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetOverlayPictureColumn
//
//	Access:		Public
//
//	Arguments:	
//	as_column	column in datasource to be used for overlay picture display purposes
//						The column may be an integer (used as the picture index) or a
//						string (a bmp name which will be used as the picture).  Or a number
//						may be passed in (i.e. "1") which will be used as the state picture
//						index for all items.
//
//	Returns:		integer
//					 1 = success
//					-1 = failure
//
//	Description:
//		Sets the column name used from the datasource as the overlay display picture
//
//		Note:  The datasource(dataobject) must be set first before calling this function
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

If IsNull(as_column) Then
	Return -1
End If

// Check to make sure column is valid for the dataobject
If Trim(as_column) <> "" And Not IsNumber(as_column) And &
	inv_attrib.ids_source.Describe(as_column + ".Band") = "!" Then 
		Return -1
End If

inv_attrib.is_OverlayColumn = as_column

return 1
end function

public function string of_getxposcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetXPosColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as the item x coordinate
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

return inv_attrib.is_XPosColumn
end function

public function string of_getyposcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetYPosColumn
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the column name used from the datasource as the item y coordinate
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

return inv_attrib.is_YPosColumn
end function

public function integer of_setxposcolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetXPosColumn
//
//	Access:		Public
//
//	Arguments:	
//	as_column	column in datasource to be used for defining x position of the item
//
//	Returns:		integer
//					 1 = success
//					-1 = failure
//
//	Description:
//		Sets the column name used from the datasource as the item x coordinate
//
//		Note:  The datasource(dataobject) must be set first before calling this function
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

If IsNull(as_column) Then
	Return -1
End If

// Check to make sure column is valid for the dataobject
If Trim(as_column) <> "" And inv_attrib.ids_source.Describe(as_column + ".Band") = "!" Then 
		Return -1
End If

inv_attrib.is_XPosColumn = as_column

return 1
end function

public function integer of_setyposcolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetYPosColumn
//
//	Access:		Public
//
//	Arguments:	
//	as_column	column in datasource to be used for defining y position of the item
//
//	Returns:		integer
//					 1 = success
//					-1 = failure
//
//	Description:
//		Sets the column name used from the datasource as the item y coordinate
//
//		Note:  The datasource(dataobject) must be set first before calling this function
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

If IsNull(as_column) Then
	Return -1
End If

// Check to make sure column is valid for the dataobject
If Trim(as_column) <> "" And inv_attrib.ids_source.Describe(as_column + ".Band") = "!" Then 
		Return -1
End If

inv_attrib.is_YPosColumn = as_column

return 1
end function

public function integer of_setpicturecolumn (string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetPictureColumn
//
//	Access:		Public
//
//	Arguments:	
//	as_Column		The column in the DataWindow object to use for the picture.
//							The column may be an integer (used as the picture index) or a
//							string (a bmp name which will be used as the picture).  Or a number
//							may be passed in (i.e. "1") which will be used as the picture index
//							for all items.
//
//	Returns:		integer
//					 1 = success
//					-1 = failure
//
//	Description:
//		Sets the column name used from the datasource as the picture display
//
//		Note:  The datasource(dataobject) must be set first before calling this function
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

If IsNull(as_column) Then
	Return -1
End If

// Check to make sure column is valid for the dataobject
If Trim(as_column) <> "" And Not IsNumber(as_column) And &
	inv_attrib.ids_source.Describe(as_column + ".Band") = "!" Then 
		Return -1
End If

inv_attrib.is_PictureColumn = as_column

return 1
end function

public function integer of_setitemattributes (n_ds ads_source, long al_row, ref listviewitem alvi_item);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetItemAttributes
//
//	Access:		public
//
//	Arguments:
//	ads_source	The datasource used to get information for the listview attributes
//	al_Row		The row in the DataStore to use for the item's attributes.
//	alvi_Item	The pointer to a ListView item whose attributes are to be set.
//						Passed by reference
//
//	Returns:		Integer
//					Returns 1 if successful, -1 if an error occurred
//
//	Description:	Set the default attributes of a ListView item using data from the data source.
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

Integer			li_Cnt, li_Cols
Integer			li_picture, li_state, li_overlay, li_x, li_y
Long				ll_Handle
String			ls_Label, ls_Column, ls_picture, ls_key

// Validate required reference.
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1
If IsNull(ads_source) or Not IsValid(ads_source) Then Return -1
If IsNull(ads_source.inv_base) or Not IsValid(ads_source.inv_base) Then Return -1

// Determine how to handle the pictures

// Large and Small Pictures
If Trim(inv_attrib.is_PictureColumn) <> "" Then
	If IsNumber(inv_attrib.is_PictureColumn) Then
		// The Picture Index is hard coded
		li_picture = Integer(inv_attrib.is_PictureColumn)
	ElseIf Left(ads_source.Describe(inv_attrib.is_PictureColumn + ".coltype"), 4) = "char" Then
		// The column contains a bmp name, so add the picture
		ls_picture = ads_source.GetItemString(al_Row, inv_attrib.is_PictureColumn)
		If Not IsNull(ls_picture) Then 
			ilv_requestor.AddSmallPicture(ls_picture)
			li_picture = ilv_requestor.AddLargePicture(ls_picture)
		Else
			li_picture = 0
		End If
	Else 
		// the column contains a index
		li_picture = ads_source.GetItemNumber(al_Row, inv_attrib.is_PictureColumn)
	End If
End if
If IsNull(li_picture) Then li_picture = 0
alvi_Item.PictureIndex = li_picture

// State Picture
If Trim(inv_attrib.is_StateColumn) <> "" Then
	If IsNumber(inv_attrib.is_StateColumn) Then
		// The Picture Index is hard coded
		li_state = Integer(inv_attrib.is_StateColumn)
	ElseIf Left(ads_source.Describe(inv_attrib.is_StateColumn + ".coltype"), 4) = "char" Then
		// The column contains a bmp name, so add the picture
		ls_picture = ads_source.GetItemString(al_Row, inv_attrib.is_StateColumn)
		If Not IsNull(ls_picture) Then 
			li_state = ilv_requestor.AddStatePicture(ls_picture)
		Else
			li_state = 0
		End If
	Else 
		// the column contains a index
		li_state = ads_source.GetItemNumber(al_Row, inv_attrib.is_StateColumn)
	End If
End if
If IsNull(li_state) Then li_state = 0
alvi_Item.StatePictureIndex = li_state

// Overlay Picture - cannot add it to the picture array
If Trim(inv_attrib.is_OverlayColumn) <> "" Then
	If IsNumber(inv_attrib.is_OverlayColumn) Then
		// The Index is hard coded
		li_overlay = Integer(inv_attrib.is_OverlayColumn)
	Else 
		// the column contains a index
		li_overlay = ads_source.GetItemNumber(al_Row, inv_attrib.is_OverlayColumn)
	End If
End if
If IsNull(li_overlay) Then li_overlay = 0
alvi_Item.OverlayPictureIndex = li_overlay


// Set the X and Y coordinates
If Trim(inv_attrib.is_XPosColumn) <> "" Then
	li_x = ads_source.GetItemNumber(al_Row, inv_attrib.is_XPosColumn)
End If
If IsNull(li_x) then li_x = 0
alvi_Item.ItemX = li_x

If Trim(inv_attrib.is_YPosColumn) <> "" Then
	li_y = ads_source.GetItemNumber(al_Row, inv_attrib.is_YPosColumn)
End If
If IsNull(li_y) then li_y = 0
alvi_Item.ItemY = li_y

// Set label with data from columns
li_Cols = UpperBound(inv_colattrib)
For li_Cnt = 1 To li_Cols
//	ls_Column = of_FormatData(is_Columns[li_Cnt], is_ColFormat[li_Cnt], is_ColType[li_Cnt], ads_source, al_Row)
	ls_Column = ads_source.inv_base.of_GetItem(al_row, inv_colattrib[li_Cnt].is_Columns)
	If Trim(ls_Label) = "" Then
		ls_Label = ls_Column
	Else
		ls_Label = ls_Label + "~t" + ls_Column
	End If
Next
alvi_Item.Label = ls_Label

//// Set data to be the unique key to be sure it can be found later
//ls_key = of_encodekey(ads_source, al_Row)
//If ls_key = "!" then return -1
//alvi_Item.Data = ls_key
	
Return 1

end function

public function integer of_insertitem (ref n_ds ads_obj, long al_row, listviewitem alvi_new, string as_position, integer ai_item);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_InsertItem
//
//	Access:		public
//
//	Arguments:
//	ads_obj		The DataStore containing the data to be used for the new item.
//						This can be the same DataStore that was created for the listview, or
//						another maintained by the user.  If the latter, the row will be added
//						to the listviews DataStore.  Passed by reference.
//	al_Row		The row in the DataStore pointing to the data.
//	alvi_item	The Item to be added to the listview
//	as_Position	The position under the parent where the new item will be inserted:
//						"First" - before the first item of the listview 
//						"Last" - after the last listview item (default)
//						"Before" - before the item with index ai_item
//						"After" - after the item with index ai_item
//	ai_Item		The index to the item which the new item will be inserted either after or before.
//						Ignored unless as_Position = "After" or "Before".
//
//	Returns:		Integer
//					Returns the index of the item if it was added successfully, 
//					-1 if an error occurrs.
//
//	Description:	Add a new item to the ListView using data from a DataStore.
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
integer				li_rc, li_index
integer				li_newindex, li_totalitems, li_after
long					ll_rowcount, ll_rowid
string				ls_key, ls_syntax1, ls_syntax2
ListViewItem		llvi_temp

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// Check Arguments
If IsNull(al_row) or IsNull(ai_item) or &
	(al_row < 1) or (ai_item < 0) or &
	IsNull(as_position) or (Trim(as_position) = "") or &
	IsNull(ads_obj) or Not IsValid(ads_obj) Then
	Return -1
End If

Choose Case as_position
	Case ilv_requestor.INSERT_FIRST, ilv_requestor.INSERT_LAST, &
			ilv_requestor.INSERT_BEFORE, ilv_requestor.INSERT_AFTER
		// valid values
	Case Else
		Return -1
End Choose

// Check if the DataStore passed is the same as the one for the level
If ads_obj <> inv_attrib.ids_source Then
	
	// Verify that the it is valid for the level
	If (ads_obj.dataobject = inv_attrib.ids_source.dataobject) Then
		If ads_obj.dataobject = '' Then
			ls_syntax1 = ads_obj.object.datawindow.syntax
			ls_syntax2 = inv_attrib.ids_Source.object.datawindow.syntax
			if ls_syntax1 <> ls_syntax2 Then return -1
		End If
	Else
		Return -1
	End IF

	// Append the rows to the DataStore
	ll_rowcount = inv_attrib.ids_source.rowcount()
	li_rc = ads_obj.RowsCopy(al_Row, al_Row, Primary!, inv_attrib.ids_source, (ll_rowcount + 999999), Primary!)
	If li_rc <> 1 then Return -1

	// Set status flag of new row to what it was in the original datastore
	// The new row is copied as NewModified! 
	ll_rowcount = inv_attrib.ids_source.rowcount()
	choose case ads_obj.GetItemStatus(al_Row, 0, primary!)
		case New!
			// newmodified! and notmodified! = new!
			inv_attrib.ids_source.SetItemStatus(ll_rowcount, 0, primary!, notmodified!)
		case DataModified!
			// newmodified! and datamodified! = datamodified!
			inv_attrib.ids_source.SetItemStatus(ll_rowcount, 0, primary!, datamodified!)
		case NotModified!
			// newmodified!  and datamodified! = datamodified!
			// datamodified! and notmodified!  = notmodified!
			inv_attrib.ids_source.SetItemStatus(ll_rowcount, 0, primary!, datamodified!)
			inv_attrib.ids_source.SetItemStatus(ll_rowcount, 0, primary!, notmodified!)
	end choose
	al_row = inv_attrib.ids_source.rowcount()
End If

// set the data attribute so we can find this row again later
ls_key = of_encodekey(inv_attrib.ids_source, al_row)
If ls_key = "!" then return -1
alvi_new.Data = string(alvi_new.data) + ls_key

// Insert the Item.  Based on position not index.  Change x, y of item to be added
li_totalitems = ilv_requestor.TotalItems() + 1
Choose Case Lower(as_Position)
	Case "first"
		li_index = ilv_requestor.finditem(0, DirectionDown!, false, false, false, false)
		If ilv_requestor.GetItem(li_index, llvi_temp) <> 1 Then Return -1
		alvi_new.ItemX = llvi_temp.ItemX - 1
		alvi_new.ItemY = llvi_temp.ItemY - 1
		li_newindex = ilv_requestor.InsertItem(1, alvi_new)
//		ilv_requestor.Arrange()
	Case "after"
		// get next item in the listview
		li_after = ai_item + 1
		If li_after > ilv_requestor.TotalItems() Then
			// at end, after is adding to end
			li_newindex = ilv_requestor.AddItem(alvi_new)
		Else	
			If ilv_requestor.GetItem(ai_item, llvi_temp) <> 1 Then Return -1
			alvi_new.ItemX = llvi_temp.ItemX + 1
			alvi_new.ItemY = llvi_temp.ItemY + 1
			li_newindex = ilv_requestor.InsertItem(li_after, alvi_new)
//			ilv_requestor.Arrange()
		End If
	Case "before"
		If ilv_requestor.GetItem(ai_item, llvi_temp) <> 1 Then Return -1
		alvi_new.ItemX = llvi_temp.ItemX - 1
		alvi_new.ItemY = llvi_temp.ItemY - 1
		li_newindex = ilv_requestor.InsertItem(ai_item, alvi_new)
//		ilv_requestor.Arrange()
	Case Else	// "last"
		li_newindex = ilv_requestor.AddItem(alvi_new)
End Choose

ilv_requestor.Arrange()

// Add for Undo capability
if ib_undo Then
	If li_newindex > 0 then
		il_undoinserthandle = li_newindex
		is_UndoType = UNDO_INSERT
	End If
End IF

Return li_newindex

end function

public function string of_getdataobject ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDataObject
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the dataobject used by the datasource to store the data
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

return inv_attrib.is_DataObject
end function

public function string of_getmethod ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetMethod
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Returns the method used to populate the datasource
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

return inv_attrib.is_Method
end function

public function integer of_converttorow (any aa_columnvalues[], ref n_ds ads_obj, ref long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_converttorow
//
//	Access:		public
//
//	Arguments:
//	aa_ColumnValues[]	The array containing the data to be used for the new row.
//	ads_obj				The datastore to place the new row in (the dataobjects should have
//								the same column types).  Passed by reference
//	al_Row				The new row of the array in the datastore.  Passed by reference
//
//	Returns:		Integer
//					 1 if successful
//					-1 if an error occurrs.
//
//	Description:	Convert an array of values which corresponded to columns in the 
//						source dataobject to a row in a datastore.  A row does not have to
//						be added to the data source first using this method
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
Integer				li_columns, li_cnt
string				ls_Sqlerr
window				lw_parentwindow

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1
If upperbound(aa_columnvalues) < 1 Then Return -1

// Populate the storage datastore
If inv_attrib.is_Method = inv_cache.SQL then
	ads_obj.Create( inv_attrib.is_DataObject, ls_sqlerr )
	If Len(ls_sqlerr) > 0 Then
		Return -1		
	End If 	
Else
	ads_obj.DataObject = inv_attrib.is_DataObject
End If
ads_obj.of_SetBase(true)
ilv_requestor.of_GetParentWindow(lw_parentwindow)
ads_obj.of_SetParentWindow(lw_parentwindow)

al_row = ads_obj.InsertRow(0)
If al_row < 1 Then 
	Return -1
End If

// copy the argument array to the datastore column by column
li_columns = UpperBound(aa_columnvalues)
For li_cnt = 1 to li_columns
	ads_obj.object.data[al_row, li_cnt] = aa_columnvalues[li_cnt]
End For

return 1
end function

protected function integer of_registerdatasource (string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_RegisterDataSource
//
//	Access:		protected
//
//	Arguments:
//	as_method			The Method we will use to populate the data source
//	as_dataobject	The DataWindow object to be used for the data source.
//	atr_obj				The transaction object for this data source .
//	as_sql				The SQL Statement to be used for the data source (if specified).
//	apo_data[]			The data to be used for the data source (if specified).
//	adw_control			The datawindow control to be used for the data source (if specified).
//	ads_control			The datastore control to be used for the data source (if specified).
//	as_importfile		The import file from which to be used for the data source (if specified).
//
//	Returns:		Integer
//	 1 = the data source was added successfully
//	-1 = Nothing was registered with the cache
//
//	Description:	Register a data source for the ListView with the cache service. 
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
Integer	li_rc

If IsNull(inv_cache) or Not Isvalid(inv_cache) Then Return -1

CHOOSE CASE as_method
	CASE inv_cache.DATASTORECONTROL
		// register a datastore control
		If IsValid(ads_control) Then
			If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
				// already registered so unregister and re-register
				li_rc = inv_cache.of_unregister(CACHE_ID)
			End If				
			li_rc = inv_cache.of_register(CACHE_ID, ads_control, TRUE)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.DATAWINDOWCONTROL
		// register a datawindow control
		If IsValid(adw_control) Then
			If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
				// already registered so unregister and re-register
				li_rc = inv_cache.of_unregister(CACHE_ID)
			End If				
			li_rc = inv_cache.of_register(CACHE_ID, adw_control, TRUE)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.POWEROBJECT
		// register a powerobject 
		If (UpperBound(apo_data) <> 0) and Not IsNull(apo_data) Then
			If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
				// already registered so unregister and re-register
				li_rc = inv_cache.of_unregister(CACHE_ID)
			End If				
			li_rc = inv_cache.of_register(CACHE_ID, as_dataobject, apo_data)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.IMPORTFILE
		// register a file from disk
		If Len(as_importfile) <> 0 and Not IsNull(as_importfile) Then
			If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
				// already registered so unregister and re-register
				li_rc = inv_cache.of_unregister(CACHE_ID)
			End If				
			li_rc = inv_cache.of_register(CACHE_ID, as_dataobject, as_importfile, TRUE)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.RETRIEVE
		// register a Retrieve
		If Len(as_dataobject) <> 0 and Not IsNull(as_dataobject) and &
			IsValid(atr_obj) and Not IsNull(atr_obj) Then
				If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
					// already registered so unregister and re-register
					li_rc = inv_cache.of_unregister(CACHE_ID)
				End If				
				li_rc = inv_cache.of_register(CACHE_ID, as_dataobject, atr_obj, FALSE)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.SQL
		// register a SQL statement
		If Len(as_sql) <> 0 and Not IsNull(as_sql) and &
			IsValid(atr_obj) and Not IsNull(atr_obj) Then
				If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
					// already registered so unregister and re-register
					li_rc = inv_cache.of_unregister(CACHE_ID)
				End If				
				li_rc = inv_cache.of_register(CACHE_ID, atr_obj, as_sql, FALSE)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE inv_cache.DATAOBJECTDATA
		// register a dataobject
		If Len(as_dataobject) <> 0 and Not IsNull(as_dataobject) Then
			If inv_cache.of_IsRegistered(CACHE_ID) > 0 Then
				// already registered so unregister and re-register
				li_rc = inv_cache.of_unregister(CACHE_ID)
			End If				
			li_rc = inv_cache.of_register(CACHE_ID, as_dataobject)
		Else
			li_rc = -1
		End If
		Return li_rc
	CASE ELSE
		// didn't register anything
		Return -1
END CHOOSE

// didn't register anything
return -1

end function

public function integer of_confirmdelete (long al_amount);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_ConfirmDelete
//
//	Access:		public
//
//	Arguments:
//	al_amount			number of rows to confirm deletion for
//
//	Returns:  integer
//	 1 = yes (ok to delete)
//	 2 = no (do not delete)
//	-1 = error
//
//	Description:  Displays messagebox confirming deletion
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

// Validate amount argument
if al_amount <=0 then
	return -1
end if

// Display confirm delete message based on single/multiple deletes
if al_amount = 1 then
	return of_MessageBox ("pfc_lv_datasource_confirmdeletesingle", "Confirm Delete", &
			"Are you sure you want to delete " + is_displayitem + "?", question!, yesno!, 1)
else
	return of_MessageBox ("pfc_lv_datasource_confirmdeletemulti", "Confirm Multiple Delete", &
			"Are you sure you want to delete these " + &
			String (al_amount) + " " + is_displayunits + "?", question!, yesno!, 1)
end if

end function

public function integer of_registerreportcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_RegisterReportColumn
//
//	Access:		public
//
//	Arguments:	None.
//
//	Returns:		Integer
//					The number of columns added if successful, -1 if an error occurred
//
//	Description:	Add a column to the ListView control for each visible column in the DataWindow.
//						They will be displayed in Report View only.
//
//		This function overloads the of_registerreportcolumn in the base service to
//		allow the internal data source to be used as the default value.
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

Return of_RegisterReportColumn(inv_attrib.ids_source)

end function

public function boolean of_canundo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_CanUndo
//
//	Access:		Public
//
//	Arguments:	none
//
//	Returns:		Boolean
//					true = we can undo the last edit/insert/delete
//					false = cannot undo the last edit/insert/delete
//
//	Description:
//	Returns if undo can be performed
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

boolean	lb_undo
string	ls_undotype

lb_undo = of_CanUndo(ls_undotype)

Return lb_undo

end function

public function boolean of_canundo (ref string as_undotype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_CanUndo
//
//	Access:		Public
//
//	Arguments:	
//	as_undotype		The type of undo we are performing.  Passed by reference
//
//	Returns:		Boolean
//					true = we can undo the last edit/insert/delete
//					false = cannot undo the last edit/insert/delete
//
//	Description:
//	Returns if undo can be performed and the type of undo that can be performed
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

// initialize the undo type
as_undotype = ""

// if undo not on then we cannot undo
If Not ib_undo Then
	Return FALSE
End If

// Validate arguments
CHOOSE CASE is_undotype
	CASE UNDO_EDIT, UNDO_INSERT, UNDO_DELETE
		// Good style.
		as_undotype = is_undotype
		Return TRUE
END CHOOSE

Return FALSE

end function

protected function integer of_setcache (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_setCache
//
//	Access:  	protected
//
//	Arguments:
//	ab_switch   enable/disable the internal cache
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Instantiates or destroys the listview cacheing service
//
//	the cache is used as the mechanism to retrieve data into the internal listview
//	datastore (inv_attrib.ids_source)
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
//	Copyright © 1996-1997 Sysource, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sysource, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if IsNull(inv_cache) Or not IsValid (inv_cache) then
		inv_cache = create n_cst_dwcache
		li_rc = 1
	end if
else
	if IsValid (inv_cache) then
		destroy inv_cache
		li_rc = 1
	end if	
end if

return li_rc


end function

public function integer of_gettransobject (ref n_tr atr_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetTransObject
//
//	Access:		public
//
//	Arguments:
//	atr_obj	The transaction object (of type n_tr) the Listview uses.
//						Passed by reference.
//
//	Returns:		Integer
//					 1	- the transaction object was valid, 
//					-1	- it was not.
//
//	Description:	Get the transaction object used for the Listview.
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

If IsNull(inv_attrib.itr_obj) Or Not IsValid(inv_attrib.itr_obj) Then Return -1

atr_obj = inv_attrib.itr_obj

Return 1

end function

public function integer of_getdatarow (integer ai_item, ref n_ds ads_source, ref long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDataRow
//
//	Access:		public
//
//	Arguments:
//	ai_Item		The index to the ListView item for which data is desired.
//	ads_Source	The handle to the DataStore (of type n_ds) for the Listview.
//						Passed by reference.
//	al_Row		The row in the DataStore that the item points to.  Passed by
//						reference.
//
//	Returns:		Integer
//					 1	- the item's data was found
//					-1	- the item or row was not found
//
//	Description:	Return the DataStore and row a particular item in the ListView points
//						to.  This allows the user to update this row any way they wish.
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

Long				ll_Row
string			ls_key
ListViewItem	llvi_Item

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1
If IsNull(ai_item) or (ai_item < 1) Then Return -1

If ilv_requestor.GetItem(ai_Item, llvi_Item) = -1 Then Return -1

ads_Source = inv_attrib.ids_Source

if IsNull(inv_attrib.ids_Source) Or not IsValid (inv_attrib.ids_Source) then
	return -1
end if

// find the row
ls_key = of_decodekey( string(llvi_item.data) )
ll_row = ads_Source.GetRowFromRowID( long(ls_key) )

//ll_Row = ads_Source.Find("pfc_lvi_key = '" + String(llvi_Item.Data) + "'", &
//										1, ads_Source.RowCount())

If ll_Row <= 0 Then
	Return -1
Else
	al_Row = ll_Row
	Return 1
End If

end function

protected function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		protected
//
//	Arguments:
//	as_LabelColumn		The column in the DataWindow object to display as the label. 
//	as_DWobjectname	The DataWindow object to be used for the data source.
//	atr_obj				The transaction object for this data source .
//	as_method			The Method we will use to populate the data source
//	as_sql				The SQL Statement to be used for the data source (if specified).
//	apo_data[]			The data to be used for the data source (if specified).
//	adw_control			The datawindow control to be used for the data source (if specified).
//	ads_control			The datastore control to be used for the data source (if specified).
//	as_importfile		The import file from which to be used for the data source (if specified).
//
//	Returns:		Integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-2 = the DataWindow object did not have any key columns assigned
//	-3 = no DataWindow object was provided
//	-4 = one of the columns provided did not exist
//	-5 = SetTransObject failed for the data source
// -6 = Error from Cache Registration
//
//	Description:	Register a data source for the ListView.  The data source is a
//						DataWindow object that will be linked to the ListView level and used
//						to populate.
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
string	ls_sqlerr, ls_empty[]
window	lw_parentwindow
n_ds		lds_test

// Check arguments
If Len (as_labelcolumn) = 0 or IsNull (as_labelcolumn) or & 
	Len (as_DWobjectname) = 0 or IsNull (as_DWobjectname) or &
	Len (as_method) = 0 or IsNull (as_method) Then 
	Return -1
End If

// create temporary datastore
lds_test = Create n_ds
If as_method = inv_cache.SQL then
	lds_test.Create( as_DWobjectname, ls_sqlerr )
	If Len(ls_sqlerr) > 0 Then
		Destroy lds_test
		Return -1		
	End If 	
Else
	lds_test.DataObject = as_DWobjectname
End If

// Set data source values.  label column must be in datawindow
If Trim(as_LabelColumn) <> "" And lds_test.Describe(as_LabelColumn + ".Band") = "!" Then 
	Destroy lds_test
	Return -4
End If

// do not need this anymore
Destroy lds_test

// set the values in the array structure
inv_attrib.is_DataObject = as_DWobjectname
inv_attrib.itr_obj = atr_obj
inv_attrib.is_Method = as_method
inv_attrib.is_LabelColumn = as_LabelColumn

// register with cache service
li_rc = of_registerdatasource(as_method, as_DWobjectname, atr_obj, &
										as_sql, apo_data, adw_control, ads_control, as_importfile)
If li_rc < 1 Then 
	Return -6
End If

// create a new dataobject 
If IsNull(inv_attrib.ids_Source) Or Not IsValid(inv_attrib.ids_Source) Then
	inv_attrib.ids_Source = Create n_ds
End if
	If as_method = inv_cache.SQL Then
		inv_attrib.ids_Source.Create( as_DWobjectname, ls_sqlerr )
	Else
		inv_attrib.ids_Source.DataObject = as_DWobjectname	
	End If

// make sure transaction object is valid
If IsValid(atr_obj) Then
	If inv_attrib.ids_Source.of_SetTransObject(atr_obj) <> 1 Then Return -5
End If

// Set parameters for the DataStore
inv_attrib.ids_Source.of_SetBase(true)
ilv_requestor.of_GetParentWindow(lw_parentwindow)
inv_attrib.ids_Source.of_SetParentWindow(lw_parentwindow)

// if method is dataobjectdata then we already will have the data in the datastore
// so we will delete the data and wait for it to be added by populate
If as_method = inv_cache.DATAOBJECTDATA Then
	inv_attrib.ids_source.Reset()
End IF

// Delete the columns if already exists in listview and clear column array
of_unregisterreportcolumn()

// Add a column to the ListView for the Label
of_RegisterReportColumn(inv_attrib.ids_source, as_LabelColumn)

Return 1

end function

public function integer of_unregister ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_unregister
//
//	Access:		public
//
//	Arguments:	None
//
//	Returns:		Integer
//	 1 = the data source was unregistered successfully
//	-1 = error
//
//	Description:	UnRegister a data source for the ListView.  Reset the attribute
//						values to defaults and destroy the datastore reference
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
string	EMPTY = ""
n_tr		ltr_obj

// reset the values in the array structure
inv_attrib.is_DataObject = EMPTY
inv_attrib.is_LabelColumn = EMPTY
inv_attrib.is_PictureColumn = EMPTY
inv_attrib.is_StateColumn = EMPTY
inv_attrib.is_OverlayColumn = EMPTY
inv_attrib.is_XPosColumn = EMPTY
inv_attrib.is_YPosColumn = EMPTY
inv_attrib.is_Method = EMPTY

inv_attrib.itr_obj = ltr_obj

If isvalid(inv_attrib.ids_source) then
	Destroy inv_attrib.ids_source
end if

// unregister with cache service
inv_cache.of_unregister(CACHE_ID) 

// Delete the report view columns
of_unregisterreportcolumn()

// no need to remember the undo items
of_clearundo()

Return 1

end function

public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel, alignment aal_alignment, integer ai_columnwidth);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_registerreportcolumn
//
//	Access:		public
//
//	Arguments:
//	ads_obj				The data store which holds the column information of as_columnname
//	as_ColumnName		The column in the DataWindow object to add as a column in
//								the ListView. 
//	as_ColumnLabel		The heading for the column to display in the ListView
//	aal_Alignment		The alignment of the column in the ListView 
//								(Left!, Right!, Center!, Justify!).
//	ai_ColumnWidth		The width of the column in the ListView (in PB Units).
//
//	Returns:		Integer
//					The index of the column if added successfully
//					-1 if an error occurred
//
//	Description:	Add a column to the ListView control.  It will be displayed in 
//						Report View only.
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

string	ls_Type
Integer	li_Cols, li_Cnt, li_ColCnt

// check reference variables and arguments
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1
If isnull(as_columnlabel) or (trim(as_columnlabel) = "") then Return -1
if isnull(as_columnname) or (trim(as_columnname) = "") then return -1
If isnull(ai_columnwidth) or (ai_columnwidth < 0) then return -1

// Check if the column was previously added
li_Cols = UpperBound(inv_colattrib)
For li_Cnt = 1 To li_Cols
	If as_ColumnName = inv_colattrib[li_Cnt].is_Columns Then
		// Already added, so set new values
		ilv_requestor.SetColumn(li_Cnt, as_ColumnLabel, aal_Alignment, ai_ColumnWidth)
		Return li_Cnt
	End If
Next

// Set the value in the data source structure
ls_Type  = ads_obj.Describe(as_ColumnName + ".coltype")
If ls_Type = "!" Then Return -1

li_ColCnt = UpperBound(inv_colattrib) + 1 
inv_colattrib[li_ColCnt].is_Columns = as_ColumnName
inv_colattrib[li_ColCnt].is_ColType = ls_Type
inv_colattrib[li_ColCnt].is_ColFormat = ads_obj.Describe(as_ColumnName + ".format")
If inv_colattrib[li_ColCnt].is_ColFormat = "?" Then inv_colattrib[li_ColCnt].is_ColFormat = ""

// Add the column to the ListView
Return ilv_requestor.AddColumn(as_ColumnLabel, aal_Alignment, ai_ColumnWidth)

end function

public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel, alignment aal_alignment);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_registerreportcolumn
//
//	Access:		public
//
//	Arguments:
//	ads_obj				The data store which holds the column information of as_columnname
//	as_ColumnName		The column in the DataWindow object to add as a column in
//								the ListView. 
//	as_ColumnLabel		The heading for the column to display in the ListView
//	aal_Alignment		The alignment of the column in the ListView 
//								(Left!, Right!, Center!, Justify!).
//
//	Returns:		Integer
//					The index of the column if added successfully
//					-1 if an error occurred
//
//	Description:	Add a column to the ListView control.  It will be displayed 
//						in Report View only.
//
//		This function overrides the real of_registerreportcolumn to allow the 
//		column width to be determined by the width of the column in the DataWindow.
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

Integer		li_Width

// Validate required reference.
If IsNull(ads_obj) or Not IsValid(ads_obj) Then Return -1
If IsNull(as_columnname) or (trim(as_columnname) = "") then return -1
If IsNull(as_columnlabel) or (trim(as_columnlabel) = "") then return -1

// Get the width of the column in the DataWindow
li_Width = Integer(ads_obj.Describe(as_ColumnName + ".width"))

// Add the column to the ListView
Return of_registerreportcolumn(ads_obj, as_ColumnName, as_ColumnLabel, aal_Alignment, li_Width)

end function

public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname, string as_columnlabel);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_registerreportcolumn
//
//	Access:		public
//
//	Arguments:
//	ads_obj				The data store which holds the column information of as_columnname
//	as_ColumnName		The column in the DataWindow object to add as a column in
//								the ListView. 
//	as_ColumnLabel		The heading for the column to display in the ListView
//
//	Returns:		Integer
//					The index of the column if added successfully
//					-1 if an error occurred
//
//	Description:	Add a column to the ListView control.  It will be displayed 
//						in Report View only.
//
//		This function overrides the real of_registerreportcolumn to allow the 
//		column width and alignment to be determined by the width of the column
//		in the DataWindow.
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

Alignment		lal_Align

// Validate required reference.
If IsNull(ads_obj) or Not IsValid(ads_obj) Then Return -1
If IsNull(as_columnname) or (trim(as_columnname) = "") then return -1
If IsNull(as_columnlabel) or (trim(as_columnlabel) = "") then return -1

// Get the alignment of the column in the DataWindow
Choose Case Lower(ads_obj.Describe(as_ColumnName + ".alignment"))
	Case "0"
		lal_Align = Left!
	Case "1"
		lal_Align = Right!
	Case "2"
		lal_Align = Center!
End Choose

// Add the column to the ListView
Return of_registerreportcolumn(ads_obj, as_ColumnName, as_ColumnLabel, lal_Align)

end function

public function integer of_registerreportcolumn (n_ds ads_obj, string as_columnname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_registerreportcolumn
//
//	Access:		public
//
//	Arguments:
//	ads_obj			The data store which holds the column information of as_columnname
//	as_ColumnName	The column in the DataWindow object to add as a column in
//							the ListView. 
//
//	Returns:		Integer
//					The index of the column if added successfully
//					-1 if an error occurred
//
//	Description:	Add a column to the ListView control. 
//						It will be displayed in Report View only.
//
//		This function overrides the real of_registerreportcolumn to allow the 
//		column width, alignment and label to be determined by the attributes 
//		of the column in the DataWindow.
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

string	ls_header

// Validate required reference.
If IsNull(ads_obj) or Not IsValid(ads_obj) Then Return -1
If IsNull(ads_obj.inv_base) or Not IsValid(ads_obj.inv_base) Then Return -1
If IsNull(as_columnname) or (trim(as_columnname) = "") then return -1

// Get the header of the column in the DataWindow
ls_header = ads_obj.inv_base.of_GetHeaderName (as_columnname)

// Add the column to the ListView
return of_registerreportcolumn (ads_obj, as_columnname, ls_header)

end function

public function integer of_unregisterreportcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_unregisterreportcolumn
//
//	Access:		public
//
//	Arguments:	None.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurred
//
//	Description:	Delete all columns in the ListView control and reset the internal column arrays.
//						Columns are displayed in Report View only.
//
//						NOTE:  If you perform this function on a populated listview you
//						should call of_refresh to refresh the data view if needed
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
n_cst_columnattrib	lnv_empty[]

// validate required reference
If IsNull(ilv_requestor) or NOT IsValid(ilv_requestor) Then Return -1

// Delete the current columns in the report view
if ilv_requestor.TotalColumns() > 0 then
	if ilv_requestor.DeleteColumns() < 1 then return -1
end if

// Empty the column list array
inv_colattrib = lnv_empty


return 1
end function

public function integer of_unregisterreportcolumn (integer ai_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_unregisterreportcolumn
//
//	Access:		public
//
//	Arguments:	
//	ai_column	the column to be removed.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurred
//
//	Description:	Delete the column in the ListView control and sync the internal column arrays.
//						Columns are displayed in Report View only.
//
//						NOTE:  If you perform this function on column 1 you
//						should call of_refresh to refresh the data view.
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

integer					li_cols, li_cnt, li_index
n_cst_columnattrib	lnv_empty[], lnv_columns[]

li_Cols = UpperBound(inv_colattrib)

// validate required reference
If IsNull(ilv_requestor) or NOT IsValid(ilv_requestor) Then Return -1
If IsNull(ai_column) or (ai_column > li_cols) or (ai_column < 1) Then Return -1

// Delete the listview column
If ilv_requestor.DeleteColumn(ai_column) < 1 Then Return -1

// Sync internal arrays
For li_Cnt = 1 To (ai_column - 1)
	lnv_Columns[li_Cnt] = inv_colattrib[li_Cnt]
Next

For li_index = (ai_column + 1) To li_cols
	lnv_Columns[li_index - 1] = inv_colattrib[li_index]
Next

inv_colattrib = lnv_empty
inv_colattrib = lnv_Columns

return 1

end function

public function integer of_getcolumninfo (integer ai_column, ref n_cst_columnattrib anv_colattrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetColumnInfo
//
//	Access:		public
//
//	Arguments:
//	ai_column			Column from the listview
//	anv_ColAttrib		The attribute nvo containing the Datasource column information 
//								passed by reference
//
//	Returns:		Integer
//					 1 = success,
//					-1 = an error occurred
//
//	Description:	Return column information from ListView control.  
//						Column information is displayed in Report View only.
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

Integer	li_Cols

// Check arguments
If IsNull(ai_column) or (ai_column < 1) Then 
	Return -1
End If

// Check if the column was previously added
li_Cols = UpperBound(inv_colattrib)
If ai_column > li_Cols Then Return -1

anv_colattrib = inv_colattrib[ai_column] 

Return 1
end function

public function integer of_registerreportcolumn (n_ds ads_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_registerreportcolumn
//
//	Access:		public
//
//	Arguments:	
//	ads_obj		The datastore which holds the column information to add to the 
//					listview
//
//	Returns:		Integer
//					The number of columns added if successful
//					-1 if an error occurred
//
//	Description:	Add a column to the ListView control for all visible columns in
//						the Datastore.  They will be displayed in Report View only.
//
//		This function overloads the of_registerreportcolumn function to allow 
//		the last 4 arguments to be optional.
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

Integer	li_NumObj, li_Cnt, li_Cols
String	ls_Columns[]

// Validate required reference.
If IsNull(ads_obj) or Not IsValid(ads_obj) Then Return -1
If IsNull(ads_obj.inv_base) or Not IsValid(ads_obj.inv_base) Then Return -1

// Get all the visible objects in the DataWindow
li_NumObj = ads_obj.inv_base.of_GetObjects(ls_Columns, "*", "*", True)

// Add each column to the ListView
For li_Cnt = 1 To li_NumObj
	// Only add objects that are columns or computed fields
	If ads_obj.Describe(ls_Columns[li_Cnt] + ".Type") = "column" Or &
		ads_obj.Describe(ls_Columns[li_Cnt] + ".Type") = "compute" Then

		li_Cols++
		If of_registerreportcolumn(ads_obj, ls_Columns[li_Cnt]) < 0 Then Return -1
	End If
Next

Return li_Cols

end function

public function string of_formatdata (string as_columnname, string as_colformat, string as_coltype, n_ds ads_obj, long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FormatData
//
//	Access:		public
//
//	Arguments:
//	as_ColumnName	The name of the column whose data is desired
//	as_ColFormat	The format for the column in the DataWindow
//	as_ColType		The data type of the column
//	ads_obj			The data store for the row of data
//	al_Row			The row of the data in the datastore
//
//	Returns:		String
//					The data in the column, row converted to a string and formatted
//					using the format attribute from the DataWindow.
//
//	Description:	Get the data from a row/column and convert it to a string using
//						the column's format attribute from the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version - this function may be obsolete
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String		ls_Data, ls_Arg
Long			ll_Arg
Double		ldb_Arg
Decimal		ldc_Arg
Date			ld_Arg
DateTime		ldt_Arg
Time			lt_Arg

If IsNull(ads_obj) or Not IsValid(ads_obj) then Return "!"
If IsNull(as_columnname) or (trim(as_columnname) = "") or &
	IsNull(al_row) or (al_row < 1) Then
	Return "!"
End If

// Format the column as a string
Choose Case Left(as_ColType, 7)
	Case "integer", "long"
		ll_Arg = ads_obj.GetItemNumber(al_Row, as_ColumnName)
		ls_Data = String(ll_Arg, as_ColFormat)
	Case "double", "number"
		ldb_Arg = ads_obj.GetItemNumber(al_Row, as_ColumnName)
		ls_Data = String(ldb_Arg, as_ColFormat)
	Case "decimal"
		ldc_Arg = ads_obj.GetItemDecimal(al_Row, as_ColumnName)
		ls_Data = String(ldc_Arg, as_ColFormat)
	Case "date"
		ld_Arg = ads_obj.GetItemDate(al_Row, as_ColumnName)
		ls_Data = String(ld_Arg, as_ColFormat)
	Case "time"
		lt_Arg = ads_obj.GetItemTime(al_Row, as_ColumnName)
		ls_Data = String(lt_Arg, as_ColFormat)
	Case "datetim"
		ldt_Arg = ads_obj.GetItemDateTime(al_Row, as_ColumnName)
		ls_Data = String(ldt_Arg, as_ColFormat)
	Case Else
		ls_Arg = ads_obj.GetItemString(al_Row, as_ColumnName)
		ls_Data = String(ls_Arg, as_ColFormat)
End Choose

If IsNull(ls_Data) then ls_Data = ""

Return ls_Data

end function

public function integer of_setundo (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetUndo
//
//	Access:		Public
//
//	Arguments:
//	ab_switch	specifies whether undo information will be remembered
//
//	Returns:		integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets whether undo information will be remembered
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

// Validate arguments
if IsNull (ab_switch) then return -1

ib_undo = ab_switch

return 1
end function

protected function boolean of_confirmondelete ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_ConfirmOnDelete
//
//	Access:		protected
//
//	Arguments:	none
//
//	Returns:		boolean
//
//	Description:
//	Returns whether we want a confirmation dialog box to appear on deletions 
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

// If the service is in the process of deleting we do not want to get the confirm question
If ib_isUndoing or ib_isRefreshing Then
	Return False
Else
	Return of_isconfirmondelete()
End If

end function

public function string of_decodekey (string as_decodekey);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Decodekey
//
//	Access:		public
//
//	Arguments:
//	as_decodekey	The listview data attribute as a string.  
//

//	Returns:		String
//					The created key if successful, 
//					"!" if an error occurrs.
//
//	Description:	Get the unique key which was previously placed in the data attribute
//						of the listview item 
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

long				ll_rowid
string			ls_key, ls_data
n_cst_string	lnv_string

// Validate required reference.
If IsNull(as_decodekey) or (len(trim(as_decodekey)) = 0) Then Return "!"

// Set Data to the unique key
ls_key = lnv_string.of_GetKeyValue(as_decodekey, is_pfckey, is_delimiter)

return ls_key
end function

public function integer of_deleteitem (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_DeleteItem
//
//	Access:		public
//
//	Arguments:
//	ai_index		The index of the item to be deleted
//
//	Returns:		Integer
//					 1	- the item was deleted successfully
//					 0 - nothing deleted
//					-1	- an error occurred
//
//	Description:	Delete an item from the listview.  The item's row will be
//						DELETED from its DataStore (the user must call the Update(),
//						however).  
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
Long					ll_row
ListViewItem		llvi_Item
n_ds					lds_source

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1
If IsNull(ai_index) or (ai_index < 1) then Return -1

If ilv_requestor.GetItem(ai_index, llvi_Item) <> 1 Then Return -1

If of_GetDataRow(ai_index, lds_source, ll_row) <> 1 Then 
	// row is already deleted from datastore
	Return -1
End If

// only need to delete the row
lds_Source.DeleteRow(ll_Row)

// Get the parent and previous handle (for undo capability) 
If ib_undo Then
	il_UndoDeleteHandle[1] = ai_index
	ilvi_UndoDeleteItem[1] = llvi_item
	is_UndoType = UNDO_DELETE
End If

Return ilv_requestor.DeleteItem(ai_index)

end function

public function integer of_getindex (n_ds ads_obj, long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetIndex
//
//	Access:		public
//
//	Arguments:
//	ads_obj		The handle to the DataStore (of type n_ds) for the Listview.
//	al_Row		The row in the DataStore that the item points to.
//
//	Returns:		Integer
//					The Index of the ListView item that points to that row
//					0 if the item was not found
//					-1 if an error occurrs
//
//	Description:	Return the ListView item index that points to a particular row 
//						in the source DataStore.
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


Long				ll_Cnt, ll_items
String			ls_Key
ListViewItem	llvi_Item

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// Check Arguments
If Not IsValid(ads_obj) then Return -1
If IsNull(al_Row) or (al_row < 1) Then Return -1

// Get the generated key for the row
ls_key = of_encodekey(ads_obj, al_Row)
If ls_key = "!" then return -1

// Find the item
ll_items = ilv_requestor.TotalItems()
For ll_Cnt = 1 To ll_items
	If ilv_requestor.GetItem(ll_Cnt, llvi_Item) = 1 Then
		If string(llvi_Item.Data) = ls_Key Then Return ll_Cnt
	End If
Next

Return 0


end function

public function integer of_getindex (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Getndex
//
//	Access:		public
//
//	Arguments:
//	al_Row		The row in the DataStore that the item points to.
//
//	Returns:		Integer
//					The Index of the ListView item that points to that row
//					0 if the item was not found
//					-1 if an error occurrs
//
//	Description:	Return the ListView item index that points to a particular row 
//						in the source DataStore.
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

// Check Arguments
If IsNull(al_Row) or (al_row < 1) Then Return -1

Return of_getindex(inv_attrib.ids_source, al_row)

end function

public function long of_retrieve (any aa_args[20], ref n_ds ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Retrieve
//
//	Access:		public
//
//	Arguments:
//	aa_Args[20]	An array of type Any which contains the retrieval arguments
//						the DataStore.
//
//	Returns:		Long
//					Returns the number of items retrieved if successful
//					-1 if an error occurred
//
//	Description:	Retrieve the data for ListView with items from the data source.
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

integer	li_newrows, li_cnt
window	lw_parentwindow

If IsNull(ilv_requestor) or Not Isvalid(ilv_requestor) Then Return -1

// Retrieve data into the DataStore
// pass the arguments to the cache
If (inv_attrib.is_method = inv_cache.SQL) or (inv_attrib.is_method = inv_cache.RETRIEVE) Then
	// register the arguments; retrieve the cache and get the reference
	inv_cache.of_RegisterArgs(CACHE_ID, aa_Args)
	If inv_cache.of_Refresh(CACHE_ID) < 0 Then return -1
End If

// Get a reference to the cache - data was retrieved on registration
IF inv_cache.of_GetRegistered(CACHE_ID, ads_data) <> 1 then Return -1

// turn back on the base service as cache does not turn it on
ads_data.of_SetBase(TRUE)

//// datastore needs parent window reference to perform updates
//ilv_requestor.of_Getparentwindow(lw_parentwindow)
//ads_data.of_SetParentWindow(lw_parentwindow)

// Clear the status flags for the new rows - want them to be notmodified!
li_newrows = ads_data.RowCount()
For li_Cnt = 1 To li_NewRows
	ads_data.SetItemStatus(li_Cnt, 0, Primary!, DataModified!)
	ads_data.SetItemStatus(li_Cnt, 0, Primary!, NotModified!)
Next

// return the rows in the datasource
Return li_newrows

end function

public function string of_encodekey (n_ds ads_source, long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_encodekey
//
//	Access:		public
//
//	Arguments:
//	ads_source	The DataStore with the data used to populate the item.  
//	al_Row		The row in the DataStore for the item.
//
//	Returns:		String
//					The created key if successful, 
//					"!" if an error occurrs.
//
//	Description:	Set the unique key of a listview item so we can find out the row
//						in the datastore which created the item at a later point in time.
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

long				ll_rowid
string			ls_key
string			ls_pfckey
n_cst_string	lnv_string

// Validate required reference.
If IsNull(ads_source) or Not IsValid(ads_source) Then Return "!"
If IsNull(al_row) or (al_row < 1) then Return "!"

// Set Data to the unique key
ll_rowid = ads_source.GetRowIDFromRow(al_Row)
If ll_rowid < 1 then return "!"

ls_pfckey = is_pfckey + "="
lnv_string.of_SetKeyValue (ls_pfckey, is_pfckey, string(ll_rowid), "=")

ls_key = ls_pfckey + is_delimiter

return ls_key
end function

public function integer of_deleteitem ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_DeleteItem
//
//	Access:		public
//
//	Arguments:	None
//
//	Returns:		Integer
//					 1	- the item was deleted successfully
//					 0 - nothing deleted (or was prevented)
//					-1	- an error occurred
//
//	Description:	Delete an item(s) from the listview.  The item's row will be
//						DELETED from its DataStore (the user must call the Update(),
//						however).  
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

Integer	li_totalitems, li_selected, li_confirm
Integer	li_deletecount=0

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

li_totalitems = ilv_requestor.totalselected()
If li_totalitems < 1 Then Return 0

// confirm this action
if of_ConfirmOnDelete() then
	If li_totalitems = 1 then
		li_confirm = of_ConfirmDelete(1)
		// Delete item if = 1
		if li_confirm <> 1 then return 0
	Else
		// we have multiple deletions, so check to see if we have asked the question before
		li_confirm = of_ConfirmDelete( li_totalitems )
		// Delete item if = 1
		if li_confirm <> 1 then return 0
	End If
End if

// find the first selected item
li_selected = ilv_requestor.selectedindex()

//Loop and delete the selected items.
DO WHILE li_selected > 0
	ilv_requestor.event pfc_predeleteitem(li_selected)
	if this.of_Deleteitem(li_selected) < 0 then Return -1
	li_deletecount++

	// Get handle to next selected item - when an item is deleted, listview count is reset
	// so we have to start from the top again
	li_selected = of_FindSelected(0, Directiondown!)
LOOP 

return li_deletecount

end function

public function integer of_getattributes (ref n_cst_lvsrvattrib anv_attrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetAttributes
//
//	Access:		Public
//
//	Arguments:	
//	anv_attrib	The attributes object containing the attributes for the listview
//
//	Returns:		Integer
//
//	Description:
//	Returns all the attributes used to populate the datasource for the listview
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
n_cst_lvsrvattrib		lnv_emptyattrib

anv_attrib = lnv_emptyattrib
anv_attrib = inv_attrib

return 1

end function

on pfc_n_cst_lvsrv_datasource.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_lvsrv_datasource.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Destructor
//
//	Description:	Destroy the items created for use by the listview
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

of_SetCache(False)

end event

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Constructor
//
//	Description:	Turn on the cache service which enables multiple types of data 
//						to be able to populate the listview
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

of_SetCache(True)

end event

