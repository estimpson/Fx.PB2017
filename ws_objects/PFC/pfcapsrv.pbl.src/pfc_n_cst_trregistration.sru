$PBExportHeader$pfc_n_cst_trregistration.sru
$PBExportComments$PFC Transaction Registration service
forward
global type pfc_n_cst_trregistration from n_base
end type
end forward

type os_transentry from structure
	n_tr		tr_object
	boolean		b_used
end type

global type pfc_n_cst_trregistration from n_base
end type
global pfc_n_cst_trregistration pfc_n_cst_trregistration

type variables
Protected:
integer		ii_count
os_transentry	istr_trans[]
end variables

forward prototypes
public function integer of_getcount ()
public function integer of_register (n_tr atr_object)
public function integer of_unregister (n_tr atr_obj)
public function integer of_getregistered (ref n_tr atr_obj[])
public function boolean of_isregistered (string as_name)
public function boolean of_isregistered (n_tr atr_obj)
public function integer of_getbyname (string as_name, ref n_tr atr_obj)
end prototypes

public function integer of_getcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetCount
//
//	Access:  		public
//
//	Arguments:  	none
//
//	Returns:  		integer
//						Number of registered transaction objects
//
//	Description:  	Returns the number of registered trans objects
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

return ii_count
end function

public function integer of_register (n_tr atr_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:
//	atr_object   	Transaction object to register.
//
//	Returns:  		integer
//						 1 = success
//						 0 = transaction object has already been registered.
//						-1 = error
//
//	Description:  	Registers a transaction object with the service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Prevent objects from being registered more than once.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_slotavailable=0
integer	li_cnt=0
integer	li_upperbound=0

// Check arguments.
if IsNull(atr_object) Or not IsValid (atr_object) then
	return -1
end if

// Determine if there is an open slot available.
// Determine if the object has already been registered.
li_upperbound = UpperBound (istr_trans[])
For li_cnt = 1 to li_upperbound
	// Check to see if transaction object was already registered.
	if istr_trans[li_cnt].tr_object = atr_object then
		Return 0
	end if	

	// Determine if there is an open slot.
	if not istr_trans[li_cnt].b_used then
		If li_slotavailable = 0 Then
			//Get the first slot found
			li_slotavailable = li_cnt
		End If		
	end if
Next

//If an available slot was not found then create a new entry
If li_slotavailable = 0 Then
	li_slotavailable = li_upperbound + 1
End If

// Register the transaction object.
istr_trans[li_slotavailable].tr_object = atr_object
istr_trans[li_slotavailable].b_used = true

// Increase count of registered transaction objects.
ii_count++	

Return 1
end function

public function integer of_unregister (n_tr atr_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister
//
//	Access:  		public
//
//	Arguments:
//	atr_obj   		transaction object to be unregistered
//
//	Returns:  		integer
//						 1 = successful unregister
//						 0 = the specified trans object was not registered
//						-1 = error
//
//	Description:  	Unregisters a transaction object from the service.
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

integer	li_upperbound
integer	li_cnt = 1
boolean	lb_found

// Check arguments
if IsNull(atr_obj) Or not IsValid (atr_obj) then
	return -1
end if

// Find transaction object to unregister
li_upperbound = UpperBound (istr_trans)
do while not lb_found and li_cnt <= li_upperbound
	if istr_trans[li_cnt].tr_object = atr_obj then
		// Unregister the transaction.
		istr_trans[li_cnt].b_used = false
		SetNull (istr_trans[li_cnt].tr_object)
		ii_count --
		Return 1
	end if
	li_cnt++
loop

// Trans object not found.
return 0
end function

public function integer of_getregistered (ref n_tr atr_obj[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetRegistered
//
//	Access:  public
//
//	Arguments:
//	atr_obj[]   array of trans objects passed by reference
//
//	Returns:  integer
//	The number of registered transaction objects
//
//	Description:  Returns the registered transaction objects
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

integer	li_upperbound
integer	li_cnt
integer	li_count

// Loop through the registered array.
li_upperbound = UpperBound (istr_trans)
for li_cnt = 1 to li_upperbound
	if istr_trans[li_cnt].b_used and IsValid (istr_trans[li_cnt].tr_object) then
		li_count++
		atr_obj[li_count] = istr_trans[li_cnt].tr_object
	end if
next

return li_count
end function

public function boolean of_isregistered (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsRegistered
//
//	Access:  		public
//
//	Arguments:
//	as_name   		Name of the transaction object to check for registration
//
//	Returns:  		boolean
//						Returns whether the transaction object specified is registered
//						with the service.
//
//	Description:	Check whether the transaction object specified is registered
//						with the service.
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

integer	li_upperbound
integer	li_cnt
string	ls_name

// Check if registered.
li_upperbound = UpperBound (istr_trans)
for li_cnt = 1 to li_upperbound
	if istr_trans[li_cnt].b_used and IsValid (istr_trans[li_cnt].tr_object) then
		ls_name = istr_trans[li_cnt].tr_object.of_GetName()
		if ls_name = as_name then
			// The Transaction is registered.
			Return True
		end if
	end if
next

// The Transaction is NOT registered.
Return False
end function

public function boolean of_isregistered (n_tr atr_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsRegistered
//
//	Access:  		public
//
//	Arguments:
//	atr_obj   		Transaction object to check for registration
//
//	Returns:  		boolean
//						Returns whether the transaction object specified is 
//						registered with the service.
//
//	Description:	Checks whether the transaction object specified is 
//						registered with the service.
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

integer	li_upperbound
integer	li_cnt

// Check arguments.
if IsNull(atr_obj) Or not IsValid (atr_obj) then
	return false
end if

// Check if registered
li_upperbound = UpperBound (istr_trans)
for li_cnt = 1 to li_upperbound
	if istr_trans[li_cnt].b_used and IsValid (istr_trans[li_cnt].tr_object) then
		if istr_trans[li_cnt].tr_object = atr_obj then
			// The Transaction is registered.
			Return True
		end if
	end if
next

// The Transaction is NOT registered.
Return False
end function

public function integer of_getbyname (string as_name, ref n_tr atr_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetByName
//
//	Access:  		public
//
//	Arguments:
//	as_name:  		name of the transaction object to get a reference for
//	atr_obj:  		transaction object by reference
//
//	Returns:  		integer
//						1 = success
//						0 = transaction object not found
//
//	Description:  	Gets a reference to the registered trans object based on
//						the name specified.
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

integer	li_upperbound
integer	li_cnt
string	ls_name

// Loop through the registered array.
li_upperbound = UpperBound (istr_trans)
for li_cnt = 1 to li_upperbound
	if istr_trans[li_cnt].b_used and IsValid (istr_trans[li_cnt].tr_object) then
		ls_name = istr_trans[li_cnt].tr_object.of_GetName()
		if ls_name = as_name then
			// Transaction was found.
			atr_obj = istr_trans[li_cnt].tr_object
			Return 1
		end if
	end if
next

// Transaction was not found.
return 0

end function

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			destructor
//
//	Description:  	Service is shutting down so destroy all registered
//						transaction objects
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

integer	li_cnt
integer	li_upper

// Destroy all registered transaction objects
li_upper = UpperBound (istr_trans)
for li_cnt = 1 to li_upper
	if IsValid (istr_trans[li_cnt].tr_object) then
		destroy istr_trans[li_cnt].tr_object
	end if
next
end event

on pfc_n_cst_trregistration.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_trregistration.destroy
TriggerEvent( this, "destructor" )
end on

