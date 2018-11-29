$PBExportHeader$pfc_u_notes.sru
$PBExportComments$PFC Calendar class
forward
global type pfc_u_notes from u_base
end type
type dw_note from u_dw within pfc_u_notes
end type
end forward

global type pfc_u_notes from u_base
integer width = 1102
integer height = 536
long backcolor = 1073741824
long tabtextcolor = 0
long tabbackcolor = 67108864
long picturemaskcolor = 25166016
event type integer pfc_dropdown ( )
dw_note dw_note
end type
global pfc_u_notes pfc_u_notes

type variables
Public:
// Datawindow Register columnStyle.
constant integer NONE = 1
constant integer DDLB = 2
constant integer DDLB_WITHARROW = 3
n_cst_dropdown	inv_dropdown

integer ii_registry

Protected:
// Internal attibutes.
n_cst_notesattrib NotesAttrib
dragobject idrg_requestor
datawindow idw_requestor
editmask iem_requestor
String	is_prevcell=''
Integer	ii_boldfontweight=700
Integer	ii_normalfontweight=400

// API accessible attributes
Long	il_fontcolor=0
Boolean	ib_closeonclick = True
Boolean	ib_closeondclick = True
Boolean	ib_initialvalue= False
Boolean	ib_alwaysredraw = False

//API accessible attributes - DataWindow only attributes.
string	is_dwcolumns[]
string	is_dwcolumnsexp[]
integer	ii_dwcolumnstyle[]
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
protected function integer of_dropdown ()
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
end prototypes

event pfc_dropdown;call super::pfc_dropdown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_dropdown
//
//	(Arguments:		None)
//
//	Returns:  Integer
//		1 if it succeeds
//		-1 if an error occurs.
//		0 if the current datawindow column has not been registered.
//
//	Description:  
//		Request the dropdown calendar.
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

Return of_DropDown()
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
idrg_requestor = ldrg_notvalid
idw_requestor = ldrg_notvalid
iem_requestor = ldrg_notvalid

// Is this object behaving as a dropdown object.
If IsValid(inv_dropdown) Then
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
		idw_requestor = adrg_requestor
	CASE EditMask!
		lem_testonly = adrg_requestor
		If lem_testonly.MaskDataType <> DateMask! Then
			Return -3
		End If
		iem_requestor = adrg_requestor
		If Not lb_dropdownbehavior Then
			// Field cannot be typed on.
			iem_requestor.DisplayOnly = True
			// Set initial value.
			of_Reset()
		End If						
	CASE ELSE
		Return -1
END CHOOSE

// Set the generic reference.
idrg_requestor = adrg_requestor

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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
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
//		1 if it succeeds and -1 if an error occurs.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Validate Reference.
If IsNull(idrg_requestor) or Not IsValid(idrg_requestor) Then 
	Return -1
End If

Return idrg_requestor.SetFocus()
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Use the NONE default.
Return of_Register(as_dwcolumn, NONE)
end function

protected function integer of_reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Reset
//
//	Access:    Protected
//
//	Arguments:	None.
//
//	Returns:  Integer
//		1 if it succeeds and -1 if an error occurs.
//
//	Description: Resets the note according to the requestor note.
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

// Validate Reference.
If IsValid(idw_requestor) Or IsValid(iem_requestor) Then
	// Good reference.
Else
	Return -1
End If

// Get the current note from the requesting object.
string	noteText
If IsValid(idw_requestor) Then
	noteText = idw_requestor.GetText()
ElseIf IsValid(iem_requestor) Then
	noteText = iem_requestor.Text
Else
	Return -1
End If

// Bring focus on the note.
SetFocus(this)
SetFocus(dw_note)

// Validate the date (compare to an invalid date).
// Keep track if the date was valid or not.
dw_note.object.note[1] = noteText

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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

// Check arguments.
if IsNull (ab_switch) then return -1

if ab_Switch then
	if IsNull(inv_dropdown) Or not IsValid (inv_dropdown) then
		inv_dropdown = create n_cst_dropdown
		inv_dropdown.of_SetRequestor (this)
		li_rc = 1
	end if
else
	if IsValid (inv_dropdown) then

		destroy inv_dropdown
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

// Check arguments
If (IsNull(as_dwcolumn) Or Len(Trim(as_dwcolumn))=0) Or &
	(ai_style < NONE or ai_style >  DDLB_WITHARROW) Or &
	IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then 
	Return -1
End If

// Trim and Convert to lower case.
as_dwcolumn = Trim(Lower(as_dwcolumn))

// Check if the column is already registered.
If of_IsRegistered(as_dwcolumn) Then
	Return 0
End If

// Get the column type.
ls_coltype = idw_requestor.Describe(as_dwcolumn+".coltype")
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
		ls_editstyle = idw_requestor.Describe (as_dwcolumn+".Edit.Style")
		CHOOSE CASE Lower(ls_editstyle)
			CASE 'edit'
				ls_descret = idw_requestor.Describe (as_dwcolumn+".Edit.Required")
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".Edit.Required=" + ls_descret + " "
					ls_modexp = as_dwcolumn+".DDLB.Required=" + ls_descret + " "
				End If			
				ls_descret = idw_requestor.Describe (as_dwcolumn+".Edit.NilIsNull")				
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".Edit.NilIsNull=" + ls_descret + " "				
					ls_modexp += as_dwcolumn+".DDLB.NilIsNull=" + ls_descret + " "
				End If					
			CASE 'editmask'
				ls_descret = idw_requestor.Describe (as_dwcolumn+".EditMask.Mask")
				If ls_descret = '!' or ls_descret = '?' Then
					ls_storemodify += as_dwcolumn+".EditMask.Mask='' "		
				Else
					ls_storemodify += as_dwcolumn+".EditMask.Mask='" + ls_descret + "' "				
				End If						
				ls_descret = idw_requestor.Describe (as_dwcolumn+".EditMask.Required")
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".EditMask.Required=" + ls_descret + " "				
					ls_modexp = as_dwcolumn+".DDLB.Required=" + ls_descret + " "
				End If			
				ls_descret = idw_requestor.Describe (as_dwcolumn+".EditMask.NilIsNull")				
				If ls_descret = 'yes' or ls_descret = 'no' Then
					ls_storemodify += as_dwcolumn+".EditMask.NilIsNull=" + ls_descret + " "				
					ls_modexp += as_dwcolumn+".DDLB.NilIsNull=" + ls_descret + " "
				End If					
			CASE 'ddlb'
				ls_descret = idw_requestor.Describe (as_dwcolumn+".DDLB.useasborder")	
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
		ls_rc = idw_requestor.Modify (ls_modexp)
		If Len(ls_rc) > 0 Then Return -1

		If ai_style = DDLB_WITHARROW Then		
			ls_modexp =	as_dwcolumn+".DDLB.useasborder=Yes " 
			ls_rc = idw_requestor.Modify (ls_modexp)	
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

// Get the number of columns in the datawindow object
li_colcount = integer(idw_requestor.object.datawindow.Column.Count)

// Loop around all columns looking for date columns.
For li_i=1 to li_colcount
	//Get-Validate the name and column type of the column.
	ls_colname = idw_requestor.Describe("#"+string(li_i)+".Name")
	ls_coltype = idw_requestor.Describe("#"+string(li_i)+".ColType")	
	ls_editstyle = idw_requestor.Describe ("#"+string(li_i)+".Edit.Style")
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
			ls_rc = idw_requestor.Modify (is_dwcolumnsexp[li_cnt])	
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
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

protected function integer of_dropdown ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DropDown
//
//	Access:    Protected
//
//	Arguments:	None
//
//	Returns:  Integer
//		1 if it succeeds
//		-1 if an error occurs.
//		0 if the current datawindow column has not been registered.
//
//	Description:  
//		Drop Down the Calendar after getting the appropriate location.
//		For datawindow columns check that the current column has 
//		been registered.
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
Integer 	li_rc
String	ls_colname
Integer	li_x
Integer	li_y

// Check the required references.
If IsNull(inv_dropdown) or Not IsValid(inv_dropdown) or &
	IsNull(idrg_requestor) or Not IsValid(idrg_requestor) Then
	Return -1
End If

// Datawindow control specific checks.
If IsValid(idw_requestor) Then
	// Get the current column name.
	ls_colname = idw_requestor.GetColumnName()

	// Check if column is in the search column array.
	If Not of_IsRegistered(ls_colname) Then
		Return 0
	End If

	// Validate that it is still a date column.
	If Not of_IsStringType(idw_requestor.Describe(ls_colname+".coltype")) Then
		Return -1
	End If
End If

// Set this object on its new Position.
li_rc = inv_dropdown.of_Position(idrg_requestor, False)
If li_rc < 0 Then Return -1

// Set the calendar to the appropriate date.
of_Reset()

// Show the object.
This.Visible = True	

Return 1

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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

// Get the number of columns in the datawindow object
li_colcount = integer(idw_requestor.object.datawindow.Column.Count)

// Loop around all columns looking for String columns.
For li_i=1 to li_colcount
	ls_coltype = idw_requestor.Describe("#"+string(li_i)+".coltype")
	ls_editstyle = idw_requestor.Describe ("#"+string(li_i)+".Edit.Style")

	If ls_editstyle = 'ddlb' or ls_editstyle='edit' or ls_editstyle='editmask' Then
		If of_IsStringType(ls_coltype) Then	
			ls_colname = idw_requestor.Describe("#"+string(li_i)+".Name")

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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
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
//		1 if it succeeds and -1 if an error occurs.
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Validate Reference.
If IsValid(idw_requestor) Or IsValid(iem_requestor) Then
	// Good reference.
Else
	Return -1
End If

// Set the requestor with the new value.
If IsValid(idw_requestor) Then
	idw_requestor.SetText(_value)
ElseIf IsValid(iem_requestor) Then
	iem_requestor.Text = _value
Else
	Return -1
End If

Return 1
end function

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Constructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Intialize values for the Calendar object.
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

If IsValid(Message.PowerObjectParm) Then
	If NotesAttrib.ClassName() = Message.PowerObjectParm.ClassName() Then
		NotesAttrib = Message.PowerObjectParm
		
		// Is the object to behave as a dropdown object?
		If NotesAttrib.DropDown Then
			// Yes, it is a dropdown object.  
			// Immediately hide the object and Create the dropdown service.
			this.Visible = False	
			of_SetDropDown(True)
		End If
	End IF
End If

// Make sure the object is not updateable.
of_SetUpdateable(False)
end event

on pfc_u_notes.create
int iCurrent
call super::create
this.dw_note=create dw_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_note
end on

on pfc_u_notes.destroy
call super::destroy
destroy(this.dw_note)
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Destructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Destroy the instantiated services attached.
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

// Unregister all columns.
of_Unregister()

of_SetDropDown(False)
end event

type dw_note from u_dw within pfc_u_notes
event key pbm_dwnkey
integer width = 1102
integer height = 536
integer taborder = 20
string dataobject = "d_note"
boolean vscrollbar = false
boolean livescroll = false
end type

event key;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			key
//
//	(Arguments:		
//	key
//	keyflags
//
//	(Returns:  		None)
//
//	Description:
//	Support keyboard to be used to change the date on the calendar.
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

Choose Case key
	Case KeyEscape! 
		//If appropriate, hide the Calendar.
		If IsValid(inv_dropdown) Then
			If ib_closeonclick or ib_closeondclick Then
				// Set focus on the Requestor object which in turns hides the calendar.
				of_SetFocusOnRequestor()
			End If
		End If
	Case KeyTab!
		If IsValid(inv_dropdown) Then
			Post of_SetFocusOnRequestor()
		End If
	Case KeyEnter!
		if	keyDown(KeyControl!) then
			If IsValid(inv_dropdown) Then
				acceptText()
				of_SetValueOnRequestor(object.note[1])
				of_SetFocusOnRequestor()
			end if
		end if
End Choose
end event

event losefocus;call super::losefocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			losefocus
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	
//	If this object is being used as a DropDown object, hide it when focus
// is lost.
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

//Determine if the object is being used as a dropdown object.
If IsValid(inv_dropdown) Then
	// Hide object.
	Parent.Visible = False
End If

Return
end event

