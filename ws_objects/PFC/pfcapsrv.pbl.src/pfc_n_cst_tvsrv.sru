$PBExportHeader$pfc_n_cst_tvsrv.sru
$PBExportComments$PFC TreView Base service
forward
global type pfc_n_cst_tvsrv from n_base
end type
end forward

global type pfc_n_cst_tvsrv from n_base
end type
global pfc_n_cst_tvsrv pfc_n_cst_tvsrv

type variables
Protected:
string	is_delimiter = ";"
string	is_displayitem = "this item"
string	is_displayunits = "items"
u_tvs	itv_requestor

end variables

forward prototypes
public function long of_findfirstitemlevel (integer ai_level, long al_handle)
public function any of_getdataany (long al_handle)
public function string of_getdatastring (long al_handle)
public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase)
public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level)
public function long of_finditem (string as_attribute, any aa_target, long al_begin)
public function long of_finditem (string as_attribute, any aa_target)
public function integer of_setrequestor (u_tvs atv_requestor)
public function integer of_setdisplayitem (string as_displayitem)
public function string of_getdisplayitem ()
public function string of_getdisplayunits ()
public function integer of_setdisplayunits (string as_displayunits)
public function long of_getdatanumeric (long al_handle)
protected function long of_searchchild (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function integer of_setdelimiter (string as_delimiter)
public function string of_getdelimiter ()
end prototypes

public function long of_findfirstitemlevel (integer ai_level, long al_handle);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindFirstItemLevel
//
//	Access:		public
//
//	Arguments:
//	ai_Level		The Level of the TreeView for which the first item is
//						being sought.
//	al_Handle	The handle of the TreeView item to begin searching
//
//	Returns:		Long
//					The handle of the first item on the given level.  Returns 0 if not found,
//					-1 if an error occurrs.
//
//	Description:	Find the first item on a level.
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

Long					ll_Handle, ll_Found
TreeViewItem		ltvi_Item

If al_Handle > 0 Then
	If itv_requestor.GetItem(al_Handle, ltvi_Item) = -1 Then Return -1
	If ai_level = ltvi_Item.Level Then Return al_Handle
End If

// Search children
ll_Handle = itv_requestor.FindItem(ChildTreeItem!, al_Handle)
If ll_Handle > 0 Then
	ll_Found = of_FindFirstItemLevel(ai_Level, ll_Handle)
		
	If ll_Found = -1 Then Return -1
	If ll_Found > 0 Then Return ll_Found
End If

//Search next sibling
ll_Handle = itv_requestor.FindItem(NextTreeItem!, al_Handle)
If ll_Handle > 0 Then
	ll_Found = of_FindFirstItemLevel(ai_Level, ll_Handle)
	
	If ll_Found = -1 Then Return -1
	If ll_Found > 0 Then Return ll_Found
End If

Return 0

end function

public function any of_getdataany (long al_handle);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetDataAny
//
//	Access:  		public
//
//	Arguments:		
//	al_handle		The handle for the item for which you want to retrieve information
//
//	Returns:  		Any
//						data value if it succeeds and -1 if an error occurs.
//
//	Description:  	Return the 'Data' element in any format
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

treeviewitem ltvi_item

If IsNull(al_handle) Or (al_handle < 0) Then
	Return -1
End If

if itv_requestor.GetItem ( al_handle, ltvi_item ) <> 1 then
	return -1
else
	return ltvi_item.Data
end if
end function

public function string of_getdatastring (long al_handle);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetDataString
//
//	Access:  		public
//
//	Arguments:		
//	al_handle		The handle for the item for which you want to retrieve information
//
//	Returns:  		string
//						string value if it succeeds and "" if an error occurs.
//
//	Description:  	Return the 'Data' element in string format
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

treeviewitem ltvi_item

If IsNull(al_handle) Or (al_handle < 0) Then
	Return ""
End If

if itv_requestor.GetItem ( al_handle, ltvi_item ) <> 1 then
	return ""
else
	return String ( ltvi_item.Data )
end if
end function

public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindItem
//
//	Access:		public
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//	al_Begin			The handle of the TreeView item to begin searching, if
//						0 entire tree will be searched.
//	ai_Level			The level to search, if 0 entire tree will be searched.
//	ab_RespectCase	True - search is case sensitive,
//						False - search is not case sensitive.  Only used if the target
//						is a string.
//	ab_FullCompare	True - Label or Data and Target must be equal,
//						False - Label or Data can contain Target (uses POS() function).
//						Only used if the target is a string.
//
//	Returns:		Long
//					The handle of the item whose Label matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for an item in the TreeView.  This function calls of_SearchChild
//						which is recursive to search for the target in either the Label or Data attribute
//						of the TreeView items.  It will use the pfc_searchcompare event to actually
//						perform the comparison.  Override this event if another comparison is desired.
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

Long					ll_Handle, ll_Found, ll_Parent

Do While True
	ll_Found = this.of_SearchChild(as_Attribute, aa_Target, al_Begin, ai_Level, &
											ab_RespectCase, ab_FullCompare)
	If ll_Found = -1 or ll_Found > 0 Then 
		Return ll_Found
	Else
		// Search parent's siblings
		ll_Parent = itv_requestor.FindItem(ParentTreeItem!, al_Begin)
	
		Do
			If ll_Parent < 1 Then Return 0
		
			ll_Handle = itv_requestor.FindItem(NextTreeItem!, ll_Parent)
			If ll_Handle < 1 Then
				ll_Parent = itv_requestor.FindItem(ParentTreeItem!, ll_Parent)
			End If
		Loop Until ll_Handle > 0
		al_begin = ll_handle
	End If
Loop

end function

public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindItem
//
//	Access:		public
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//	al_Begin			The handle of the TreeView item to begin searching, if
//						0 entire tree will be searched.
//	ai_Level			The level to search, if 0 entire tree will be searched.
//	ab_RespectCase	True - search is case sensitive,
//						False - search is not case sensitive.  Only used if the target
//						is a string.
//
//	Returns:		Long
//					The handle of the item whose Label matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for an item in the TreeView.  This function calls of_SearchChild
//						which is recursive to search for the target in either the Label or Data attribute
//						of the TreeView items.  It will use the pfc_searchcompare event to actually
//						perform the comparison.  Override this event if another comparison is desired.
//
//		This function overloads the real of_FindItem function to allow the last
//		retrieval argument to be optional.
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

Return of_FindItem(as_Attribute, aa_Target, al_Begin, ai_Level, ab_RespectCase, False)

end function

public function long of_finditem (string as_attribute, any aa_target, long al_begin, integer ai_level);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindItem
//
//	Access:		public
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//	al_Begin			The handle of the TreeView item to begin searching, if
//						0 entire tree will be searched.
//	ai_Level			The level to search, if 0 entire tree will be searched.
//
//	Returns:		Long
//					The handle of the item whose Label matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for an item in the TreeView.  This function calls of_SearchChild
//						which is recursive to search for the target in either the Label or Data attribute
//						of the TreeView items.  It will use the pfc_searchcompare event to actually
//						perform the comparison.  Override this event if another comparison is desired.
//
//		This function overloads the real of_FindItem function to allow the last 2
//		retrieval argument to be optional.
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

Return of_FindItem(as_Attribute, aa_Target, al_Begin, ai_Level, False, False)

end function

public function long of_finditem (string as_attribute, any aa_target, long al_begin);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindItem
//
//	Access:		public
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//	al_Begin			The handle of the TreeView item to begin searching, if
//						0 entire tree will be searched.
//
//	Returns:		Long
//					The handle of the item whose Label matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for an item in the TreeView.  This function calls of_SearchChild
//						which is recursive to search for the target in either the Label or Data attribute
//						of the TreeView items.  It will use the pfc_searchcompare event to actually
//						perform the comparison.  Override this event if another comparison is desired.
//
//		This function overloads the real of_FindItem function to allow the last 3
//		retrieval argument to be optional.
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

Return of_FindItem(as_Attribute, aa_Target, al_Begin, 0, False, False)

end function

public function long of_finditem (string as_attribute, any aa_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_FindItem
//
//	Access:		public
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//						0 entire tree will be searched.
//
//	Returns:		Long
//					The handle of the item whose Label matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for an item in the TreeView.  This function calls of_SearchChild
//						which is recursive to search for the target in either the Label or Data attribute
//						of the TreeView items.  It will use the pfc_searchcompare event to actually
//						perform the comparison.  Override this event if another comparison is desired.
//
//		This function overloads the real of_FindItem function to allow the last 4
//		retrieval argument to be optional.
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

Return of_FindItem(as_Attribute, aa_Target, 0, 0, False, False)

end function

public function integer of_setrequestor (u_tvs atv_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetRequestor
//
//	Access:  		public
//
//	Arguments:		
//	atv_requestor	The treeview requesting this service
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Associates a treeview with this service.
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

If IsNull(atv_requestor) Or Not IsValid(atv_requestor) Then
	Return -1
End If

itv_requestor = atv_requestor

Return 1
end function

public function integer of_setdisplayitem (string as_displayitem);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetDisplayItem
//
//	Access:		public
//
//	Arguments:
//	as_displayitem:  display name of the item (row)
//
//	Returns:		integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the display name of the item (row) of the listview
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

// Validate argument
if IsNull (as_displayitem) then
	return -1
end if

is_displayitem = as_displayitem

return 1
end function

public function string of_getdisplayitem ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDisplayItem
//
//	Access:		public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Gets the display name of the item (row) of the listview
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

return is_displayitem
end function

public function string of_getdisplayunits ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDisplayUnits
//
//	Access:		public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Gets the display name of the units (rows) of the Listview.
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

return is_displayunits
end function

public function integer of_setdisplayunits (string as_displayunits);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetDisplayUnits
//
//	Access:		public
//
//	Arguments:
//	as_displayunits:  display name of the units (rows)
//
//	Returns:		integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the display name of the units (rows) of the listview.
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

// Validate argument
if IsNull (as_displayunits) then
	return -1
end if

is_displayunits = as_displayunits

return 1
end function

public function long of_getdatanumeric (long al_handle);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetDataNumeric
//
//	Access:  		public
//
//	Arguments:		
//	al_handle		The handle for the item for which you want to retrieve information
//
//	Returns:  		Long
//						data value if it succeeds and -1 if an error occurs.
//
//	Description:  	Return the 'Data' element in number format
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
string			ls_data
treeviewitem	ltvi_item

If IsNull(al_handle) Or (al_handle < 0) Then
	Return -1
End If

if itv_requestor.GetItem ( al_handle, ltvi_item ) <> 1 then
	return -1
else
	ls_data = string (ltvi_item.data)
	If isnumber(ls_data) then
		return long(ls_data)
	Else
		Return -1
	End If
end if
end function

protected function long of_searchchild (string as_attribute, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SearchChild
//
//	Access:		Protected
//
//	Arguments:
//	as_Attribute	The attribute of the TreeView item to search ("Label", 
//						or "Data")
//	aa_Target		A variable of type Any containg the search target.
//	al_Begin			The handle of the TreeView item to begin searching, if
//						0 entire tree will be searched.
//	ai_Level			The level to search, if 0 entire tree will be searched.
//	ab_RespectCase	True - search is case sensitive,
//						False - search is not case sensitive.  Only used if the target
//						is a string.
//	ab_FullCompare	True - Label or Data and Target must be equal,
//						False - Label or Data can contain Target (uses POS() function).
//						Only used if the target is a string.
//
//	Returns:		Long
//					The handle of the item whose Label or Data matches the target.  Returns 0
//					if not found, -1 if an error occurrs.
//
//	Description:	Search for the target in either the Label or Data attribute of the TreeView 
//						items..  This is a recursive function called by of_FindItem.  It will use the 
//						pfc_searchcompare event to actually perform the comparison.  Override 
//						this event if another comparison is desired.
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

Integer				li_Level
Long					ll_Handle, ll_Found
TreeViewItem		ltvi_Item

If al_Begin > 0 Then
	If itv_requestor.GetItem(al_Begin, ltvi_Item) = -1 Then Return -1
	li_level = ltvi_Item.Level

	If ai_Level = 0 Or ai_Level = li_Level Then
		// Send to requesting object to see if the event was overloaded/extended
		If itv_requestor.dynamic Event pfc_searchcompare(al_Begin, as_Attribute, aa_Target, ab_RespectCase, &
															ab_FullCompare) Then Return al_Begin
	End If
Else
	li_Level = 0
End If

If ai_Level = 0 Or ai_Level > li_Level Then
	
	// Search children
	ll_Handle = itv_requestor.FindItem(ChildTreeItem!, al_Begin)
	If ll_Handle > 0 Then
		ll_Found = this.of_SearchChild(as_Attribute, aa_Target, ll_Handle, ai_Level, &
													ab_RespectCase, ab_FullCompare)
		
		If ll_Found = -1 Then Return -1
		If ll_Found > 0 Then Return ll_Found
	End If
End If

If ai_Level = 0 Or ai_Level >= li_Level Then
	
	//Search next sibling
	ll_Handle = itv_requestor.FindItem(NextTreeItem!, al_Begin)
	If ll_Handle > 0 Then
		ll_Found = this.of_SearchChild(as_Attribute, aa_Target, ll_Handle, ai_Level, &
													ab_RespectCase, ab_FullCompare)
		
		If ll_Found = -1 Then Return -1
		If ll_Found > 0 Then Return ll_Found
	End If
End If

Return 0

end function

public function integer of_setdelimiter (string as_delimiter);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_SetDelimiter
//
//	Access:		public
//
//	Arguments:
//	as_delimiter   The delimiter used to differentiate the keys of the compound key
//
//	Returns:		integer
//	SUCCESS = 1
//	ERROR = -1
//
//	Description:
//	Sets delimiter used to differentiate the keys placed in the data property of
//	the treeview item
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

If IsNull(as_delimiter) or as_delimiter = "" Then
	Return -1
End If

is_delimiter = as_delimiter

return 1
end function

public function string of_getdelimiter ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_GetDelimiter
//
//	Access:		public
//
//	Arguments:	none
//
//	Returns:		string
//
//	Description:
//	Gets the delimiter character used to separate items in the data attribute
//	of the treeview item
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

return is_delimiter
end function

on pfc_n_cst_tvsrv.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_tvsrv.destroy
TriggerEvent( this, "destructor" )
end on

