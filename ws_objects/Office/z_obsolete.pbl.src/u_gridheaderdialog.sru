$PBExportHeader$u_gridheaderdialog.sru
$PBExportComments$PFC Calendar class
forward
global type u_gridheaderdialog from u_base
end type
type tv_1 from treeview within u_gridheaderdialog
end type
type cb_2 from commandbutton within u_gridheaderdialog
end type
type cb_1 from commandbutton within u_gridheaderdialog
end type
type dw_1 from datawindow within u_gridheaderdialog
end type
end forward

global type u_gridheaderdialog from u_base
integer width = 1495
integer height = 1404
long backcolor = 1073741824
long tabtextcolor = 0
long tabbackcolor = 67108864
long picturemaskcolor = 25166016
event type integer pfc_rightclicked ( integer xpos,  integer ypos,  integer row,  dwobject dwo )
event losefocus pbm_killfocus
tv_1 tv_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global u_gridheaderdialog u_gridheaderdialog

type variables

Public:
constant string AltHeaderSuffix = "_t1"
constant string DefaultHeaderSuffix = "_t"

// Datawindow Register columnStyle.
constant integer NONE = 1
constant integer DDLB = 2
constant integer DDLB_WITHARROW = 3

integer ii_registry

Protected:
// Internal attibutes.
u_fxdw requestorDW
string	is_prevcell=''
Integer ii_boldfontweight=700
Integer ii_normalfontweight=400
n_cst_popup invPopUp
string ColumnName
string SortOrder

// API accessible attributes
Long il_fontcolor=0
Boolean ib_closeonclick = True
Boolean ib_closeondclick = True
Boolean ib_initialvalue= False
Boolean ib_alwaysredraw = False

//API accessible attributes - DataWindow only attributes.
string	is_dwcolumns[]
string	is_dwcolumnsexp[]
integer ii_dwcolumnstyle[]

Protected:
boolean hideDialog = false

end variables

forward prototypes
public function integer of_setrequestor (dragobject adrg_requestor)
public function integer of_setcloseonclick (boolean ab_switch)
public function integer of_setcloseondclick (boolean ab_switch)
public function integer of_getregistered (ref string as_dwcolumns[])
public function boolean of_isregistered (string as_dwcolumn)
protected function integer of_setfocusonrequestor ()
public function integer of_register ()
public function integer of_register (string as_dwcolumn)
protected function integer of_reset ()
public function integer of_setdropdown (boolean ab_switch)
public function integer of_register (string as_dwcolumn, integer ai_style)
public function integer of_register (integer ai_style)
public function integer of_unregister (string as_dwcolumn)
public function boolean of_IsCloseOnClick ()
public function boolean of_IsCloseOnDClick ()
public function integer of_getregistered (ref string as_dwcolumns[], ref integer ai_dwcolumnstyle[])
public function integer of_getregisteredstyle (string as_dwcolumn)
public function integer of_unregister ()
protected function integer of_redirectfocus ()
public function integer of_setalwaysredraw (boolean ab_switch)
public function boolean of_isalwaysredraw ()
public function integer of_getregisterable (ref string as_allcolumns[])
public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib)
public function integer of_SetInitialValue (boolean ab_switch)
public function boolean of_IsInitialValue ()
protected function boolean of_isstringtype (string as_type)
public function integer of_setvalueonrequestor (string _value)
public function integer hidedialog ()
protected function integer popup (dwobject dwo)
public function integer buildselectiontreeviewstring (ref datastore tempdata)
public function integer buildselectiontreeviewdatetime (ref datastore tempdata)
end prototypes

event type integer pfc_rightclicked(integer xpos, integer ypos, integer row, dwobject dwo);
return Popup(dwo)

end event

event losefocus;Hide()
end event

public function integer of_setrequestor (dragobject adrg_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor
//
//	Access:    Public
//
//	Arguments:
//   adrg_requestor   The object requesting the service.
//			Valid objects are DataWindow! and dropdownlistbox!.
//
//	Returns:  Integer
//		1 if it succeeds 
//		-1 if an error occurs.
//		-2 if attempting to associate object where only dropdowns are supported.
//		-3 MaskDataType is incorrect.
//
//	Description:  Associates an object control with this object 
//		by setting the requestor instance variable(s).
//		The valid objects which can be associated are of type datawindow and 
//		type editmask.  Editmask type should further have a mask of 
//		type DateMask!.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

dragobject	ldrg_notvalid
editmask		lem_testonly
boolean		lb_dropdownbehavior

// Validate Reference.
If IsNull(adrg_requestor) or Not IsValid(adrg_requestor) Then
	Return -1
End If

// Invalidate references.
requestorDW = ldrg_notvalid

// Is this object behaving as a dropdown object.
If IsValid(invPopUp) Then
	lb_dropdownbehavior = True
End If

// Make sure it is one of the expected type and get the 
// parent window reference.
CHOOSE CASE TypeOf(adrg_requestor)
	CASE DataWindow!
		If Not lb_dropdownbehavior Then
			// Not supported for datawindow controls.
			Return -2
		End If		
		requestorDW = adrg_requestor
	CASE ELSE
		Return -1
END CHOOSE

Return 1
end function

public function integer of_setcloseonclick (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_SetCloseOnClick
//
//	Access:    	Public
//
//	Arguments:
//   ab_switch  A switch that determines when to close the calendar object.
//
//	Returns:   		Integer
//   					1 if successful, otherwise -1
//
//	Description:  	Sets the switch that determines when to close the 
//						calendar object.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check to see if the passed style number is valid.
IF IsNull(ab_switch) THEN 
	Return -1
End If

ib_closeonclick = ab_switch
Return 1
end function

public function integer of_setcloseondclick (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_SeCloseOnDClick
//
//	Access:    	Public
//
//	Arguments:
//   ab_switch  A switch that determines when to close the calendar object.
//
//	Returns:   		Integer
//   					1 if successful, otherwise -1
//
//	Description:  	Sets the switch that determines when to close the 
//						calendar object.   "DoubleClick"
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check to see if the passed style number is valid.
IF IsNull(ab_switch) THEN 
	Return -1
End If

ib_closeondclick = ab_switch
Return 1
end function

public function integer of_getregistered (ref string as_dwcolumns[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_GetRegistered
//
//	Access:  		public
//
//	Arguments:
//	as_dwcolumns[]	Columns names for which the service is providing a calendar 
//						(by reference)
//
//	Returns:  		integer
//						The number of entries in the returned array.
//
//	Description:  	This function returns the column names for which the service 
//						is providing calendar capabilities.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_style[]

Return of_GetRegistered(as_dwcolumns, li_style)
end function

public function boolean of_isregistered (string as_dwcolumn);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsRegistered
//
//	Access:  		Public.
//
//	Arguments:
//	as_dwcolumn		The registered column to search for.
//
//	Returns:  		boolean
//						True or False depending if the column is already registered.
//
//	Description: 	This function is called to determine if the passed in 
//						column name has already been registered with the service.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_count
integer	li_i

// Check arguments
If IsNull(as_dwcolumn) Or Len(Trim(as_dwcolumn))=0 Then 
	Return False
End If

// Validate the references.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return False
End If

// Trim and Convert to lower case.
as_dwcolumn = Trim(Lower(as_dwcolumn))

// Find column name.
li_count = upperbound(is_dwcolumns)
For li_i=1 To li_count
	If is_dwcolumns[li_i] = as_dwcolumn THEN
		// Column name was found.
		Return True
	end if
Next

// Column name not found in array.
Return False
end function

protected function integer of_setfocusonrequestor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFocusOnRequestor
//
//	Access:    Protected
//
//	Arguments:	None
//
//	Returns:  Integer
//		1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  Sets the focus on the requestor.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Validate Reference.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then 
	Return -1
End If

Return requestorDW.SetFocus()
end function

public function integer of_register ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access: 			public
//
//	Arguments:		None.
//
//	Returns: 		integer
//						The number of columns registered.
//						-1 if an error is encountered.
//
//	Description:	
//	Register all the appropriate columns that are holding date fields.
// This version should only be called when "ALL" date columns are desired, 
// otherwise call the version which accepts a column name as an argument.
//	Columns need to be of editstyle 'ddlb', 'edit' or 'editmask'.
//
//		*Note:	For a column to be added it most have a field of type Date.
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Use the NONE as a default.
Return of_Register(NONE)
end function

public function integer of_register (string as_dwcolumn);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:
//	 as_dwcolumn	Column to register.
//
//	Returns:  		Integer
//						1 if the column was added.
//						0 if the column was not added.
//						-1 if an error is encountered.
//
//	Description: 	
//	 Register the column which should be holding a date field.
//	 Columns need to be of editstyle 'ddlb', 'edit' or 'editmask'.
//
//		*Note:	For a column to be added it most have a field of type Date.
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Use the NONE default.
Return of_Register(as_dwcolumn, NONE)
end function

protected function integer of_reset ();
//// Validate Reference.
//If IsValid(requestorDW) Or IsValid(requestorDW) Then
//	// Good reference.
//Else
//	Return -1
//End If
//
//// Get the current note from the requesting object.
//string	noteText
//If IsValid(requestorDW) Then
//	noteText = requestorDW.GetText()
//ElseIf IsValid(iem_requestor) Then
//	noteText = iem_requestor.Text
//Else
//	Return -1
//End If
//
//// Bring focus on the note.
//SetFocus(this)
//SetFocus(dw_note)
//
//// Validate the date (compare to an invalid date).
//// Keep track if the date was valid or not.
//dw_note.object.note[1] = noteText

Return 1
end function

public function integer of_setdropdown (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetDropDown
//
//	Arguments:
//	ab_switch   starts/stops the UserObject DropDown service
//
//	Returns:  integer
//	 1 = Successful operation.
//	 0 = No action necessary
//	-1 = An error was encountered
//
//	Description:
//	Starts or stops the UserObject DropDown service
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

// Check arguments.
if IsNull (ab_switch) then return -1

if ab_Switch then
	if IsNull(invPopUp) Or not IsValid (invPopUp) then
		invPopUp = create n_cst_popup
		invPopUp.of_SetRequestor (this)
		li_rc = 1
	end if
else
	if IsValid (invPopUp) then

		destroy invPopUp
		li_rc = 1
	end if
end if

return li_rc
end function

public function integer of_register (string as_dwcolumn, integer ai_style);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:
//	 as_dwcolumn	Column to register.
//	 ai_style		The columnstyle.
//
//	Returns:  		Integer
//						1 if the column was added.
//						0 if the column was not added.
//						-1 if an error is encountered.
//
//	Description: 	
//	 Register the column which should be holding a date field.
//	 Columns need to be of editstyle 'ddlb', 'edit' or 'editmask'.
//
//		*Note:	For a column to be added it most have a field of type Date.
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer 		li_cnt, li_rc
integer		li_availableentry
integer		li_upperbound
string		ls_coltype
string		ls_modexp
string		ls_descexp
string		ls_descret
string		ls_editstyle
string		ls_storemodify=''
string		ls_rc

// Check the required reference.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return -1
End If

// Check arguments
If (IsNull(as_dwcolumn) Or Len(Trim(as_dwcolumn))=0) Or &
	(ai_style < NONE or ai_style >  DDLB_WITHARROW) Or &
	IsNull(requestorDW) Or Not IsValid(requestorDW) Then 
	Return -1
End If

// Trim and Convert to lower case.
as_dwcolumn = Trim(Lower(as_dwcolumn))

// Check if the column is already registered.
If of_IsRegistered(as_dwcolumn) Then
	Return 0
End If

// Get the column type.
ls_coltype = requestorDW.Describe(as_dwcolumn+".coltype")
If of_IsStringType(ls_coltype) Then

	// Get the upperbound of all registered columns.
	li_upperbound = upperbound(is_dwcolumns)
	
	// Determine if there is an open slot available other than a
	// new entry on the array
	For li_cnt = 1 to li_upperbound
		If IsNull(is_dwcolumns[li_cnt]) or Len(Trim(is_dwcolumns[li_cnt])) = 0 Then
			If li_availableentry = 0 Then
				//Get the first slot found
				li_availableentry = li_cnt
				Exit
			End If
		End If
	Next
	//If an available slot was not found then create a new entry
	If li_availableentry = 0 Then
		li_availableentry = li_upperbound + 1
	End If
		
	// Add/Initilize the new entry.				
	is_dwcolumns[li_availableentry] = as_dwcolumn
	ii_dwcolumnstyle[li_availableentry] = ai_style
	is_dwcolumnsexp[li_availableentry] = ''
	
	If ai_style = DDLB Or ai_style = DDLB_WITHARROW Then	

		// Store the Modify expression needed to unregister the column.
		ls_editstyle = requestorDW.Describe (as_dwcolumn+".Edit.Style")
		CHOOSE CASE Lower(ls_editstyle)
			CASE 'edit'
				ls_descret = requestorDW.Describe (as_dwcolumn+".Edit.Required")
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".Edit.Required=" + ls_descret + " "
					ls_modexp = as_dwcolumn+".DDLB.Required=" + ls_descret + " "
				End If			
				ls_descret = requestorDW.Describe (as_dwcolumn+".Edit.NilIsNull")				
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".Edit.NilIsNull=" + ls_descret + " "				
					ls_modexp += as_dwcolumn+".DDLB.NilIsNull=" + ls_descret + " "
				End If					
			CASE 'editmask'
				ls_descret = requestorDW.Describe (as_dwcolumn+".EditMask.Mask")
				If ls_descret = '!' or ls_descret = '?' Then
					ls_storemodify += as_dwcolumn+".EditMask.Mask='' "		
				Else
					ls_storemodify += as_dwcolumn+".EditMask.Mask='" + ls_descret + "' "				
				End If						
				ls_descret = requestorDW.Describe (as_dwcolumn+".EditMask.Required")
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".EditMask.Required=" + ls_descret + " "				
					ls_modexp = as_dwcolumn+".DDLB.Required=" + ls_descret + " "
				End If			
				ls_descret = requestorDW.Describe (as_dwcolumn+".EditMask.NilIsNull")				
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".EditMask.NilIsNull=" + ls_descret + " "				
					ls_modexp += as_dwcolumn+".DDLB.NilIsNull=" + ls_descret + " "
				End If					
			CASE 'ddlb'
				ls_descret = requestorDW.Describe (as_dwcolumn+".DDLB.useasborder")	
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify = as_dwcolumn+".DDLB.useasborder=" + ls_descret + " "	
				End If			
			CASE Else
				// Not a valid original edit style.
				Return -1
		END CHOOSE
			
		// Store the Modify statement that allows unregister.
		is_dwcolumnsexp[li_availableentry] = ls_storemodify		
		
		// Convert to DDLB.
		ls_modexp += as_dwcolumn+".DDLB.limit=0 " + &
						 as_dwcolumn+".DDLB.AllowEdit=Yes " 
		ls_rc = requestorDW.Modify (ls_modexp)
		If Len(ls_rc) > 0 Then Return -1

		If ai_style = DDLB_WITHARROW Then		
			ls_modexp =	as_dwcolumn+".DDLB.useasborder=Yes " 
			ls_rc = requestorDW.Modify (ls_modexp)	
			If Len(ls_rc) > 0 Then Return -1			
		End If
	End If	
	
	// The column was registered.
	Return 1
End If	

// The column was not registered.
Return 0
end function

public function integer of_register (integer ai_style);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access: 			public
//
//	Arguments:		
//	 ai_style		The style for all the columns.
//
//	Returns: 		integer
//						The number of columns registered.
//						-1 if an error is encountered.
//
//	Description:	
//	Register all the appropriate columns that are holding date fields.
// This version should only be called when "ALL" date columns are desired, 
// otherwise call the version which accepts a column name as an argument.
//	Columns need to be of editstyle 'ddlb', 'edit' or 'editmask'.
//
//		*Note:	For a column to be added it most have a field of type Date.
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer		li_colcount, li_i, li_count, li_rc
string		ls_colname
string		ls_coltype
string		ls_editstyle

// Check the arguments.
If	(ai_style < NONE or ai_style >  DDLB_WITHARROW)  Then
	Return -1
End If

// Check the required reference.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return -1
End If

// Get the number of columns in the datawindow object
li_colcount = integer(requestorDW.object.datawindow.Column.Count)

// Loop around all columns looking for date columns.
For li_i=1 to li_colcount
	//Get-Validate the name and column type of the column.
	ls_colname = requestorDW.Describe("#"+string(li_i)+".Name")
	ls_coltype = requestorDW.Describe("#"+string(li_i)+".ColType")	
	ls_editstyle = requestorDW.Describe ("#"+string(li_i)+".Edit.Style")
	If ls_coltype = '!' or ls_colname = '!' or ls_editstyle = '!' Then 
		Return -1	
	End If
	
	If ls_editstyle = 'ddlb' or ls_editstyle='edit' or ls_editstyle='editmask' Then
		If of_IsStringType(ls_coltype) Then
			// Add entry into array.
			li_rc = of_Register(ls_colname, ai_style)
		End If
	End If
Next

Return upperbound(is_dwcolumns)
end function

public function integer of_unregister (string as_dwcolumn);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister
//
//	Access:  		Public.
//
//	Arguments:
//	as_dwcolumn		The registered column to search for.
//
//	Returns:  		Integer
//	1 successful.
// 0 not previously registered.
//	-1 error.
//
//	Description: 	
//	 UnRegisters the object from the service by the column name.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_upper
Integer	li_cnt
String	ls_rc
Constant String EMPTY=''

// Check for a valid ID.
If IsNull(as_dwcolumn) or Len(Trim(as_dwcolumn))= 0  Then
	Return -1
End If

// Trim and Convert to lower case.
as_dwcolumn = Trim(Lower(as_dwcolumn))

// Find the Column.
li_upper = UpperBound(is_dwcolumns)
For li_cnt = 1 to li_upper
	If as_dwcolumn = is_dwcolumns[li_cnt] Then 
		// The entry has been found.  
		// Clear out any attribute changes.
		If Len(is_dwcolumnsexp[li_cnt]) > 0 Then
			ls_rc = requestorDW.Modify (is_dwcolumnsexp[li_cnt])	
			If Len(ls_rc) > 0 Then 
				Return -1			
			End If
		End If

		// Perform the actual Unregister.
		is_dwcolumns[li_cnt] = EMPTY
		is_dwcolumnsexp[li_cnt]= EMPTY
		ii_dwcolumnstyle[li_cnt]= 0
		
		Return 1
	End If
Next

// The column was not found.
Return 0
end function

public function boolean of_IsCloseOnClick ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_IsCloseOnClick
//
//	Access:    	Public
//
//	Arguments:	None
//
//	Returns:   	Boolean
//  True / False
//
//	Description:  	
//		Helps in determining when it is ok to close the object. "Single Click"
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_closeonclick
end function

public function boolean of_IsCloseOnDClick ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_IsCloseOnDClick
//
//	Access:    	Public
//
//	Arguments:	None
//
//	Returns:   	Boolean
//  True / False
//
//	Description:  	
//		Helps in determining when it is ok to close the object. "Double Click"
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_closeondclick 
end function

public function integer of_getregistered (ref string as_dwcolumns[], ref integer ai_dwcolumnstyle[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_GetRegistered
//
//	Access:  		public
//
//	Arguments:
//	as_dwcolumns[]	Columns names for which the service is providing a calendar 
//						(by reference)
//	ai_dwcolumnstyle[] The style for the columns (by reference)
//
//	Returns:  		integer
//						The number of entries in the returned array(s).
//
//	Description:  	This function returns the column names for which the service 
//						is providing calendar capabilities.  It also returns the style.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer 	li_i
integer	li_loop
integer	li_upper
integer	li_cnt
string	ls_empty[]
integer	li_empty[]

// Initialize strings.
as_dwcolumns = ls_empty
ai_dwcolumnstyle = li_empty

// Validate the references.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return -1
End If

// Loop around all entries and populate arrays with columnnames and style.
li_upper = upperbound(is_dwcolumns)
For li_i=1 To li_upper
	If Len(is_dwcolumns[li_i]) > 0 Then
		li_cnt ++
		as_dwcolumns[li_cnt] = is_dwcolumns[li_i]
		ai_dwcolumnstyle[li_cnt] = ii_dwcolumnstyle[li_i]
	End If
Next

Return UpperBound(as_dwcolumns)
end function

public function integer of_getregisteredstyle (string as_dwcolumn);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegisteredStyle
//
//	Access:  		Public.
//
//	Arguments:
//	as_dwcolumn		The registered column to search for.
//
//	Returns:  		integer
//		The style for the column passed in.
//		0 if the column is not registered.
//		-1 if an error is encountered.
//
//	Description: 	
//	 This function is called to determine the style of the column name passed in.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_count
integer	li_i

// Check arguments
If IsNull(as_dwcolumn) Or Len(Trim(as_dwcolumn))=0 Then 
	Return 0
End If

// Validate the references.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return -1
End If

// Trim and Convert to lower case.
as_dwcolumn = Trim(Lower(as_dwcolumn))

// Find column name.
li_count = upperbound(is_dwcolumns)
For li_i=1 To li_count
	If is_dwcolumns[li_i] = as_dwcolumn THEN
		// Column name was found.
		Return ii_dwcolumnstyle[li_i]
	end if
Next

// Column name not found in array.
Return 0
end function

public function integer of_unregister ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister
//
//	Access:  		Public.
//
//	Arguments:		None
//
//	Returns:  		Integer
//	1 successful.
// 0 nothing previously registered.
//
//	Description: 	
//	 UnRegisters all registerd columns from the service.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_upper
Integer	li_cnt
Integer	li_unregistered = 0

// Loop around all registered columns.
li_upper = UpperBound(is_dwcolumns)
For li_cnt = 1 to li_upper
	If Len(is_dwcolumns[li_cnt]) > 0 Then
		If of_Unregister(is_dwcolumns[li_cnt]) = 1 Then
			li_unregistered ++
		End If
	End If
Next

If li_unregistered > 0 Then
	Return 1
End If
	
Return 0
end function

protected function integer of_redirectfocus ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RedirectFocus
//
//	Access:    Protected
//
//	Arguments:	None
//
//	Returns:  Integer
//	1 if it succeeds.
//	-1 if an error occurs.
//
//	Description:  
//	Prevent this object from having focus while not visible.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Prevent this object from having focus while not visible.
If this.Visible = False Then
	Return of_SetFocusOnRequestor()
End If

Return 1
end function

public function integer of_setalwaysredraw (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_SetAlwaysRedraw
//
//	Access:    	Public
//
//	Arguments:
//		ab_switch	True or False
//
//	Returns:   	Integer
//   				1 if successful, otherwise -1
//
//	Description:  	
//	Sets the attribute which can force a redraw of the calendar month at various
// times.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check the argument.
IF IsNull(ab_switch) THEN 
	Return -1
End If

ib_alwaysredraw = ab_switch
Return 1
end function

public function boolean of_isalwaysredraw ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_IsAlwaysRedraw
//
//	Access:    	Public
//
//	Arguments:
//		ab_switch	True or False
//
//	Returns:   	Boolean
//   True /False
//
//	Description:  	
//	Reports on the attribute which forces a redraw of the calendar month at various
// times.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_alwaysredraw
end function

public function integer of_getregisterable (ref string as_allcolumns[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegisterable
//
//	Access:  		public
//
//	Arguments:
//	as_allcolumns[] By Reference.  All columns belonging to the requestor which
//						could be registered.
//
//	Returns:  		Integer
//	 The column count.
//	-1 if an error is encountered.
//
//	Description:
//	 Determines all columns belonging to the requestor which could be registered.
//
//		*Note:	Function is only valid when serving a DataWindow control.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer		li_colcount, li_i
integer		li_count
string		ls_coltype
string		ls_colname
string		ls_editstyle
string		ls_allcolumns[]

// Initialize.
as_allcolumns = ls_allcolumns

// Validate required reference.
If IsNull(requestorDW) or Not IsValid(requestorDW) Then
	Return -1
End If

// Get the number of columns in the datawindow object
li_colcount = integer(requestorDW.object.datawindow.Column.Count)

// Loop around all columns looking for String columns.
For li_i=1 to li_colcount
	ls_coltype = requestorDW.Describe("#"+string(li_i)+".coltype")
	ls_editstyle = requestorDW.Describe ("#"+string(li_i)+".Edit.Style")

	If ls_editstyle = 'ddlb' or ls_editstyle='edit' or ls_editstyle='editmask' Then
		If of_IsStringType(ls_coltype) Then	
			ls_colname = requestorDW.Describe("#"+string(li_i)+".Name")

			// Add entry into array.
			li_count = upperbound(ls_allcolumns) +1
			ls_allcolumns[li_count] = ls_colname		
		End If
	End If
	
Next

as_allcolumns = ls_allcolumns
Return UpperBound(as_allcolumns)

end function

public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_infoattrib	(By reference) The Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Object Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Populate Information.
anv_infoattrib.is_name = 'Notes'
anv_infoattrib.is_description = &
	'Provides Datawindows and EditMask notes fields with multiline edit functionality.'

Return 1
end function

public function integer of_SetInitialValue (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_SetInitialValue
//
//	Access:    	Public
//
//	Arguments:
//   ab_switch  A switch that determines if todays date should be set on the
//					requestor when an invalid date or no date is found on the requestor.
//
//	Returns:   		Integer
//   					1 if successful, otherwise -1
//
//	Description:  	
// Sets the switch that determines if an initial (todays date) value should be used 
// when an initial invalid value or no value is found on the requestor.
//
// *Note: The main behavior change through this attribute is in the row/column status.
//		For example,
//		A) The attribute is set to True.
//			1) The calendar is requested on a field that has no date.
//			2) The calendar dropsdown with todays date showing.
//			3) The field also displays todays date.  This means the column status may
//				be changed.  One possibility is from NotModified! to Modified!.
//		B) The attribute is set to False.
//			1) The calendar is requested on a field that has no date.
//			2) The calendar dropsdown with todays date showing.
//			3) The field continues to display empty.  This means the column status 
//				has not changed.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check to see if the passed style number is valid.
IF IsNull(ab_switch) THEN 
	Return -1
End If

ib_initialvalue = ab_switch
Return 1
end function

public function boolean of_IsInitialValue ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_IsInitialValue
//
//	Access:    	Public
//
//	Arguments:	None
//
//	Returns:   	Boolean
//
//	Description: 
// Gets the switch that determines if an initial (todays date) value should be used 
// when an initial invalid value or no value is found on the requestor.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return ib_initialvalue

end function

protected function boolean of_isstringtype (string as_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsStringType
//
//	Access: 			Protected
//
//	Arguments:
//	 as_type			The type to test for.
//
//	Returns: 		Boolean
//						True if the parameter is of type 'string'.
//
//	Description:	Determines if the passed in type is of type date.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
boolean isString

// Check the required argument.
If IsNull(as_type) Then
	Return False
End If

isString = (lower(left(as_type,4)) = 'char')
Return isString

end function

public function integer of_setvalueonrequestor (string _value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetValueOnRequestor
//
//	Access:    Public
//
//	Arguments:
//   adbl_value	The value to set.
//
//	Returns:  Integer
//		1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  Sets the value on the requestor.
//
//	*Note: This function's argument is a string in order to not loose the decimal
//		point in numbers that have no decimal values. (i.e. 6.)
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Validate Reference.
If not IsValid(requestorDW) Then
	Return FAILURE
End If

// Set the requestor with the new value.
requestorDW.SetText(_value)

Return SUCCESS
end function

public function integer hidedialog ();
if	HideDialog then
	Hide()
	return SUCCESS
end if

return NO_ACTION

end function

protected function integer popup (dwobject dwo);
Integer 	li_rc
String	ls_colname
Integer	li_x
Integer	li_y

// Check the required references.
if	IsNull(invPopUp) or not IsValid(invPopUp) or IsNull(requestorDW) or Not IsValid(requestorDW) then
	return FAILURE
end if

// Datawindow control specific checks.
if	IsValid(requestorDW) then
	//	Determine if column header was clicked.
	//	Only valid on header column.
	
	if dwo.Name = 'datawindow' then return NO_ACTION
	if dwo.Band <> "header" then return NO_ACTION
	
	//	Get column header information.
	string clickedName
	int headerLen, suffixLen, altSuffixLen
	clickedName = dwo.Name
	headerLen = Len (clickedName)
	suffixLen = Len (DefaultHeaderSuffix)
	altSuffixLen = Len (AltHeaderSuffix)
	
	//	Extract the columname from the header label 
	//	(by taking out the header suffix).
	if	Right (clickedName, suffixLen) <> DefaultHeaderSuffix then
		if	Right (clickedName, altSuffixLen) <> AltHeaderSuffix then 
			//	Cannot determine the column name from the header.	
			return FAILURE
		else
			ColumnName = Left (clickedName, headerLen - altSuffixLen)
			clickedName = ColumnName + DefaultHeaderSuffix // Don't use the filter/sort indicator for placement of popup.
		end if
	else
		ColumnName = Left (clickedName, headerLen - suffixLen )
	end if

	//	Validate the column name.
	if	IsNull (ColumnName) or Len (Trim(ColumnName)) = 0 then
		return FAILURE
	end if
end if

//	Get the sort order for the column.
if	IsValid(requestorDW.inv_Sort) then
	requestorDW.inv_Sort.GetColumnSort(ColumnName, SortOrder)
	choose case SortOrder
		case "A"
			dw_1.object.SortOrder[1] = "1"
		case "D"
			dw_1.object.SortOrder[1] = "2"
		case "N"
			dw_1.object.SortOrder[1] = "0"
	end choose
end if

// Set this object on its new Position.
li_rc = invPopUp.of_Position(clickedName, requestorDW, False)
If li_rc < 0 Then Return -1

// Show the object.
Visible = true
dw_1.SetFocus()

//	Get all values for column.
dw_1.object.ColumnName[1] = requestorDW.Describe(clickedName + ".Text")
dw_1.object.SelectAll[1] = "Y"
tv_1.SetRedraw(false)
tv_1.DeleteItem(0)
if	requestorDW.RowCount() > 0 then
	datastore tempData
	tempData = create datastore
	tempData.Create(requestorDW.object.DataWindow.Syntax)
	requestorDW.RowsCopy(1, requestorDW.RowCount(), Primary!, tempData, 1, Primary!)
	tempData.SetSort(ColumnName + " asc")
	tempData.Sort()
	any stringValues[], lastStringValue = "~~~~~~"
	int i
	int valueCount = 0
	string colType
	colType = tempData.Describe(columnName + ".ColType")
	choose case lower(left(colType, 5))
		case lower(left("Char(n)", 5))
			BuildSelectionTreeViewString(tempData)
		case lower(left("Date", 5))
		case lower(left("DateTime", 5))
			BuildSelectionTreeViewDateTime(tempData)
		case lower(left("Int", 5))
		case lower(left("Long", 5))
		case lower(left("Number", 5)), lower(left("Decimal{6}", 5))
		case lower(left("Real", 5))
		case lower(left("Time", 5))
		case lower(left("Timestamp", 5))
		case lower(left("ULong", 5))
	end choose
	
	treeviewitem valueTVI
	for	i=1 to tempData.RowCount()
		any thisValue
		choose case lower(left(colType, 5))
			case lower(left("Char(n)", 5))
			case lower(left("Date", 5))
				thisValue = tempData.GetItemDate(i, ColumnName)
			case lower(left("DateTime", 5))
			case lower(left("Int", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
			case lower(left("Long", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
			case lower(left("Number", 5)), lower(left("Decimal{6}", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
			case lower(left("Real", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
			case lower(left("Time", 5))
				thisValue = tempData.GetItemTime(i, ColumnName)
			case lower(left("Timestamp", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
			case lower(left("ULong", 5))
				thisValue = tempData.GetItemNumber(i, ColumnName)
		end choose
		if	isnull(lastStringValue, "~~~~") <> isnull(String(thisValue), "~~~~") then
			lastStringValue = String(thisValue)
			valueCount++
			valueTVI.Label = isnull(String(thisValue), "<Null>")
			valueTVI.StatePictureIndex = 2
			stringValues[valueCount] = string(thisValue)
			tv_1.InsertItemLast(0, valueTVI)
		end if
	next
end if
destroy tempData
tv_1.SetRedraw(true)

return SUCCESS

end function

public function integer buildselectiontreeviewstring (ref datastore tempdata);
//	Get all values for column.
treeviewitem valueTVI
int i, valueCount = 0
string lastValueAsString, stringValues[]

for	i=1 to tempData.RowCount()
	string thisValue
	thisValue = tempData.GetItemString(i, ColumnName)
	if	isnull(lastValueAsString, "~~~~") <> isnull(String(thisValue), "~~~~") then
		lastValueAsString = String(thisValue)
		valueCount++
		valueTVI.Label = isnull(String(thisValue), "<Null>")
		valueTVI.StatePictureIndex = 2
		stringValues[valueCount] = string(thisValue)
		tv_1.InsertItemLast(0, valueTVI)
	end if
next

return SUCCESS
end function

public function integer buildselectiontreeviewdatetime (ref datastore tempdata);
//	Get all values for column.
treeviewitem valueTVI
int i
string lastValueAsString = "", lastYearAsString = "", lastMonthAsString = ""
long lastYearItem, lastMonthItem = 0

for	i=1 to tempData.RowCount()
	datetime thisValue
	thisValue = tempData.GetItemDateTime(i, ColumnName)
	if	isnull(lastValueAsString, "~~~~") <> isnull(String(thisValue), "~~~~") then
		lastValueAsString = String(thisValue)
		if	lastYearAsString = "" and isnull(string(thisValue), "") > "" or lastYearAsString <> String(thisValue, "yyyy") then
			lastYearAsString = String(thisValue, "yyyy")
			valueTVI.Label = lastYearAsString
			valueTVI.StatePictureIndex = 2
			lastYearItem = tv_1.InsertItemLast(0, valueTVI)
			
			lastMonthAsString = String(thisValue, "mmmm")
			valueTVI.Label = lastMonthAsString
			valueTVI.StatePictureIndex = 2
			lastMonthItem = tv_1.InsertItemLast(lastYearItem, valueTVI)
		elseif lastMonthAsString = "" and isnull(string(thisValue), "") > "" or lastMonthAsString <> String(thisValue, "mmmm") then
			lastMonthAsString = String(thisValue, "mmmm")
			valueTVI.Label = lastMonthAsString
			valueTVI.StatePictureIndex = 2
			lastMonthItem = tv_1.InsertItemLast(lastYearItem, valueTVI)
		end if
		valueTVI.Label = isnull(String(thisValue), "<Null>")
		valueTVI.StatePictureIndex = 2
		if	lastMonthItem > 0 then
			tv_1.InsertItemLast(lastMonthItem, valueTVI)
		else
			//	Nulls don't go in tree.
			tv_1.InsertItemLast(0, valueTVI)
		end if
	end if
next

return SUCCESS
end function

event constructor;
this.Visible = False	
of_SetDropDown(True)

// Make sure the object is not updateable.
of_SetUpdateable(False)

invPopUp = create n_cst_popup
invPopUp.of_SetRequestor (this)

end event

on u_gridheaderdialog.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on u_gridheaderdialog.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event destructor;call super::destructor;
destroy invPopUp

end event

type tv_1 from treeview within u_gridheaderdialog
event checkboxclicked pbm_bnclicked
event keyup pbm_keyup
integer x = 261
integer y = 732
integer width = 1189
integer height = 472
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean checkboxes = true
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event getfocus;
HideDialog = false


end event

event losefocus;
HideDialog = true
post HideDialog()

end event

event other;////
//if	Ignoring then
//	IgnoreList.of_SetItem(String(lparam), "X")
//else
//	if	isnull(IgnoreList.of_GetItem(String(lparam)), "") <> "X" then
//		IgnoreList.of_SetItem(String(lparam), "X")
//		EventNumber ++
//		lb_1.InsertItem(String(EventNumber) + " : " + String(wparam) + " ~~ " + String(lparam), 1)
//	end if
//end if

////treeviewitem selectedTVI, otherTVI
////long handle
////long nextHandle
////if	lparam = 1629800 then
////	SetRedraw(false)
////	handle = FindItem(CurrentTreeItem!, 0)
////	if	handle <> 1 then return
////	GetItem(handle, selectedTVI)
////	if	selectedTVI.Label = "(Select All)" then
////		nextHandle = handle
////		do while nextHandle >= 0
////			nextHandle = FindItem(NextTreeItem!, nextHandle)
////			if	GetItem(nextHandle, otherTVI) = SUCCESS then
////				if	selectedTVI.StatePictureIndex = 1 then
////					otherTVI.StatePictureIndex = 2
////				else
////					otherTVI.StatePictureIndex = 1
////				end if
////				SetItem(nextHandle, otherTVI)
//			end if
//		loop
//	end if
//	SetRedraw(true)
//elseif	lparam = 1629768 then
//	SetRedraw(false)
//	handle = FindItem(CurrentTreeItem!, 0)
//	if	handle <> 1 then return
//	GetItem(handle, selectedTVI)
//	if	selectedTVI.Label = "(Select All)" then
//		nextHandle = handle
//		do while nextHandle >= 0
//			nextHandle = FindItem(NextTreeItem!, nextHandle)
//			if	GetItem(nextHandle, otherTVI) = SUCCESS then
//				if	selectedTVI.StatePictureIndex = 1 then
//					otherTVI.StatePictureIndex = 2
//				else
//					otherTVI.StatePictureIndex = 1
//				end if
//			end if
//		loop
//	end if
//	SetRedraw(true)
//end if
//end if
//
end event

type cb_2 from commandbutton within u_gridheaderdialog
integer x = 1074
integer y = 1260
integer width = 379
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

type cb_1 from commandbutton within u_gridheaderdialog
integer x = 622
integer y = 1264
integer width = 379
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;
string filterVerb = "IN", filterValue = ""

long nextHandle
treeviewitem allTVI
nextHandle = tv_1.FindItem(RootTreeItem!, 0)
do while nextHandle >= 0
	if	tv_1.GetItem(nextHandle, allTVI) = SUCCESS then
		if	allTVI.StatePictureIndex = 2 and filterVerb = "IN" then
			filterValue += "~"" + allTVI.Label + "~","
		end if
		tv_1.SetItem(nextHandle, allTVI)
	end if
	nextHandle = tv_1.FindItem(NextTreeItem!, nextHandle)
loop

requestorDW.event pfc_SetColumnFilter(ColumnName, filterVerb, filterValue + "~"~~~~~~~~~"")
HideDialog = true
post HideDialog()

end event

event getfocus;
HideDialog = false

end event

event losefocus;
HideDialog = true
post HideDialog()

end event

type dw_1 from datawindow within u_gridheaderdialog
event mousemove pbm_dwnmousemove
integer width = 1495
integer height = 1404
integer taborder = 10
string title = "none"
string dataobject = "d_gridheaderdialog"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event mousemove;
choose case dwo.Name
	case "p_atoz", "p_atozs", "t_atoz", "rr_atoz"
		object.rr_atoz.brush.color = "134217731"
		object.rr_ztoa.brush.color = "1073741824"
		object.rr_clear.brush.color = "1073741824"
		object.rr_filters.brush.color = "1073741824"
		object.p_atoz.filename = "atozh.jpg"
		object.p_ztoa.filename = "ztoa.jpg"
		object.p_clear.filename = "clearfilter.jpg"
	case "p_ztoa", "p_ztoas", "t_ztoa", "rr_ztoa"
		object.rr_atoz.brush.color = "1073741824"
		object.rr_ztoa.brush.color = "134217731"
		object.rr_clear.brush.color = "1073741824"
		object.rr_filters.brush.color = "1073741824"
		object.p_atoz.filename = "atoz.jpg"
		object.p_ztoa.filename = "ztoah.jpg"
		object.p_clear.filename = "clearfilter.jpg"
	case "p_clear", "p_clears", "c_clear", "rr_clear"
		object.rr_atoz.brush.color = "1073741824"
		object.rr_ztoa.brush.color = "1073741824"
		object.rr_clear.brush.color = "134217731"
		object.rr_filters.brush.color = "1073741824"
		object.p_atoz.filename = "atoz.jpg"
		object.p_ztoa.filename = "ztoa.jpg"
		object.p_clear.filename = "clearfilterh.jpg"
	case "c_filters", "rr_filters"
		object.rr_atoz.brush.color = String(rgb(255,255,255))
		object.rr_ztoa.brush.color = String(rgb(255,255,255))
		object.rr_clear.brush.color = String(rgb(255,255,255))
		object.rr_filters.brush.color = "134217731"
		object.p_atoz.filename = "atoz.jpg"
		object.p_ztoa.filename = "ztoa.jpg"
		object.p_clear.filename = "clearfilter.jpg"
	case else
		object.rr_atoz.brush.color = String(rgb(255,255,255))
		object.rr_ztoa.brush.color = String(rgb(255,255,255))
		object.rr_clear.brush.color = String(rgb(255,255,255))
		object.rr_filters.brush.color = String(rgb(255,255,255))
		object.p_atoz.filename = "atoz.jpg"
		object.p_ztoa.filename = "ztoa.jpg"
		object.p_clear.filename = "clearfilter.jpg"		
end choose
//SetRedraw(true)

end event

event losefocus;
HideDialog = true
post HideDialog()

end event

event getfocus;
HideDialog = false

end event

event clicked;
choose case dwo.Name
	case "p_atoz", "p_atozs", "t_atoz", "rr_atoz"
		//	Sort ascending or remove sort.
		if	SortOrder = "A" then
			requestorDW.event pfc_SetColumnSort(ColumnName, "N")
		else
			requestorDW.event pfc_SetColumnSort(ColumnName, "A")
		end if
		
		HideDialog = true
		post HideDialog()
	case "p_ztoa", "p_ztoas", "t_ztoa", "rr_ztoa"
		//	Sort descending or remove sort.
		if	SortOrder = "D" then
			requestorDW.event pfc_SetColumnSort(ColumnName, "N")
		else
			requestorDW.event pfc_SetColumnSort(ColumnName, "D")
		end if
		
		HideDialog = true
		post HideDialog()
	case "p_clear", "p_clears", "c_clear", "rr_clear"
		//	Clear filter.
		requestorDW.event pfc_SetColumnFilter(ColumnName, "NOT IN", "~"~~~~~~~~~"")
		
		HideDialog = true
		post HideDialog()

end choose
end event

event itemchanged;
choose case dwo.Name
	case "selectall"
		SetRedraw(false)
		long nextHandle
		treeviewitem allTVI
		nextHandle = tv_1.FindItem(RootTreeItem!, 0)
		do while nextHandle >= 0
			if	tv_1.GetItem(nextHandle, allTVI) = SUCCESS then
				if	data = "N" then
					allTVI.StatePictureIndex = 1
				else
					allTVI.StatePictureIndex = 2
				end if
				tv_1.SetItem(nextHandle, allTVI)
			end if
			if	tv_1.FindItem(ChildTreeItem!, nextHandle) >= 0 then
				nextHandle = tv_1.FindItem(ChildTreeItem!, nextHandle)
			elseif tv_1.FindItem(NextTreeItem!, nextHandle) >= 0 then
				nextHandle = tv_1.FindItem(NextTreeItem!, nextHandle)
			elseif tv_1.FindItem(NextTreeItem!, tv_1.FindItem(ParentTreeItem!, nextHandle)) >= 0 then
				nextHandle = tv_1.FindItem(NextTreeItem!, tv_1.FindItem(ParentTreeItem!, nextHandle))
			else
				nextHandle = tv_1.FindItem(NextTreeItem!, tv_1.FindItem(ParentTreeItem!, tv_1.FindItem(ParentTreeItem!, nextHandle)))
			end if
		loop
		SetRedraw(true)
end choose

end event

