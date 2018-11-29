$PBExportHeader$n_cst_associativestack.sru
forward
global type n_cst_associativestack from nonvisualobject
end type
end forward

global type n_cst_associativestack from nonvisualobject autoinstantiate
end type

type variables

Private:
any		ia_Index [ ]
any		ia_Value [ ]

integer	ii_StackPos [ ]

n_cst_anyarray	incst_Array [ ]
end variables

forward prototypes
public function integer of_setitem (any aa_index, any aa_value)
public function any of_getitem (any aa_index)
public function any of_getitem (integer ai_index)
public function integer of_upperbound ()
public function integer of_setitem (integer ai_index, any aa_newvalue, ref any aa_oldvalue)
public subroutine of_reset ()
public function any of_popitem (any aa_index)
public function integer of_pushitem (any aa_index)
end prototypes

public function integer of_setitem (any aa_index, any aa_value);//************************************************************************************//
// Function Name:	of_setitem
//
// Description:	This function adds and indexed item to the array or updates an
//						existing one.
//
// Syntax:			INTEGER of_setitem ( ANY aa_index, ANY aa_value )
//
// Where:			aa_index		The index to add to the array
//						aa_value		The value to associate to the added index of the array
//
// Returns Codes:	1		Successful
//						-1		Failure due to incompatible data types
//
// Log of Changes:
// CBR 02-22-1999 10:59.00 Original.
//************************************************************************************//

// declare local variables
INTEGER	li_updateindex = 0,&
			li_index
STRING	ls_classname

// get data type for index
ls_classname = ClassName ( aa_index )

// search to see if index already exists and if so, update the data
FOR li_index = 1 TO UpperBound ( ia_index )
	IF ClassName ( ia_index[li_index] ) <> ls_classname THEN
		CONTINUE
	ELSEIF ia_index[li_index] = aa_index THEN
		IF ClassName ( ia_value[li_index] ) = ClassName ( aa_value ) THEN
			li_updateindex = li_index
		ELSE
			li_updateindex = -1
		END IF
		li_index = UpperBound ( ia_index )
	END IF
NEXT

// item doesn't exists so add it
IF li_updateindex = 0 THEN
	// get next array item to add to
	li_updateindex = UpperBound ( ia_index ) + 1
	ia_index[li_updateindex] = aa_index
// there was an error
ELSEIF li_updateindex = -1 THEN
	return -1
END IF

// assign values sent to array
ia_value[li_updateindex] = aa_value

// return success
return 1
end function

public function any of_getitem (any aa_index);//************************************************************************************//
// Function Name:	of_getitem
//
// Description:	This function gets the value at the specified index and returns it.
//
// Syntax:			ANY of_getitem ( ANY aa_index )
//
// Where:			aa_index		The index value to return
//
// Returns:			ANY	The object at the specified index
//						NULL	Index not found
//
// Log of Changes:
// CBR 02-22-1999 10:09.00	Original.
//************************************************************************************//

// declare local variables
INTEGER	li_index
ANY		la_value
STRING	ls_classname

// set initial value to null
SetNull ( la_value )

// get data type of index
ls_classname = ClassName ( aa_index )

// loop through array and get value for specified index
FOR li_index = 1 to UpperBound ( ia_index )
	// make sure data types are the same
	IF ClassName ( ia_index[li_index] ) <> ls_classname THEN
		CONTINUE
	ELSEIF aa_index = ia_index[li_index] THEN
		la_value = ia_value[li_index]
		li_index = UpperBound ( ia_index )
	END IF
NEXT

// return value found or null if not found
return la_value
end function

public function any of_getitem (integer ai_index);//************************************************************************************//
// Function Name:	of_getitem
//
// Description:	This function gets the value at the specified index and returns it.
//
// Syntax:			ANY of_getitem ( INTEGER ai_index )
//
// Where:			ai_index		The index value to return
//
// Returns:			ANY	The object at the specified index
//						NULL	Index not found
//
// Log of Changes:
// CBR 02-22-1999 10:09.00	Original.
//************************************************************************************//

// declare local variables
ANY		la_dummy

// set to null in case object doesn't exist (returned)
SetNull ( la_dummy )

// make sure index exists
IF ai_index > UpperBound ( ia_index ) THEN
	return la_dummy
ELSE
	return ia_value[ai_index]
END IF
end function

public function integer of_upperbound ();//************************************************************************************//
// Function Name:	of_upperbound
//
// Description:	This function returns the number of items in the array
//
// Syntax:			INTEGER of_upperbound ( )
//
// Returns Codes:	INTEGER	the number of items in the array
//
// Log of Changes:
// CBR 02-22-1999 14:07.00 Original.
//************************************************************************************//

// return the number of items in array
return UpperBound ( ia_index )
end function

public function integer of_setitem (integer ai_index, any aa_newvalue, ref any aa_oldvalue);//************************************************************************************//
// Function Name:	of_setitem
//
// Description:	This function replaces the value of the specified item of the array
//
// Syntax:			INTEGER of_setitem ( INTEGER ai_index, ANY aa_newvalue )
//
// Where:			ai_index		The index of the array to change
//						aa_newvalue	The value to associate to the index of the array
//
// Returns Codes:	1		Successful
//						-1		Failure due to array boundry exceeded
//						-2		Failure due to incompatible data types
//
// Log of Changes:
// CBR 02-22-1999 10:59.00 Original.
//************************************************************************************//

// see if index already exists and if so, update the data
IF ai_index > UpperBound ( ia_index ) THEN
	// failure
	return -1
END IF

// make sure data types are the same as the new value
IF ClassName ( ia_value[ai_index] ) = ClassName ( aa_newvalue ) THEN
	ia_value[ai_index] = aa_newvalue
	// return success
	return 1
ELSE
	// failure
	return -2
END IF


end function

public subroutine of_reset ();//************************************************************************************//
// Function Name:	of_reset
//
// Description:	This function gets rid of all indexes of the array
//
// Syntax:			of_reset	( )
//
// Returns:			None.
//
// Log of Changes:
// CBR 02-22-1999 14:11.00 Original.
//************************************************************************************//

// declare local variables
ANY	la_index[],&
		la_value[]

// set all indexes and values to nothing
ia_index[] = la_index[]
ia_value[] = la_value[]
end subroutine

public function any of_popitem (any aa_index);//	Function Name:
//	of_PopItem
//
//	Description:
//	This function pops an Indexed item from a stack and returns it.
//
//	Syntax:
//	integer of_PopItem ( any aa_Index )
//
//	Where:
//	aa_Index		The Indexed stack to Pop from.
//
//	Returns:
//	any		The Value popped.
//	null		Index not found or stack empty.
//
//	Log of Changes:
//	2001.06.02	Eric Stimpson		Original.

//	Local declarations.
any	la_Value

integer	li_Index

string	ls_ClassName

//	Set initial Value to null.
SetNull ( la_Value )

//	Get data type for Index.
ls_ClassName = ClassName ( aa_Index )

//	Search to see if Index already exists and if so, Pop the Value from the stack.
for li_Index = 1 to UpperBound ( ia_Index )
	if ClassName ( ia_Index [ li_Index ] ) <> ls_ClassName then
		continue
	elseif ia_Index [ li_Index ] = aa_Index then
		if UpperBound ( ii_StackPos ) >= li_Index and UpperBound ( incst_Array ) >= li_Index then
			if ii_StackPos [ li_Index ] > 0 and UpperBound ( incst_Array [ li_Index ].ia_Array ) >= ii_StackPos [ li_Index ] then
				la_Value = incst_Array [ li_Index ].ia_Array [ ii_StackPos [ li_Index ] ]
				ii_StackPos [ li_Index ] --
				li_Index = UpperBound ( ia_Index )
			end if
		end if
	end if
next

//	Return Value found or null if not found.
return la_Value

end function

public function integer of_pushitem (any aa_index);
//	Function Name:
//	of_PushItem
//
//	Description:
//	This function adds the current Value of an Indexed item to a stack.
//
//	Syntax:
//	integer of_PushItem ( any aa_Index )
//
//	Where:
//	aa_Index		The Index to add to the array.
//
//	Returns Codes:
//	 1		Successful.
//	-1		Failure due to incompatible data types.
//
//	Log of Changes:
//	2001.06.02	Eric Stimpson		Original.

//	Local declarations.
integer	li_UpdateIndex = 0
integer	li_Index

string	ls_ClassName

//	Get data type for Index.
ls_ClassName = ClassName ( aa_Index )

//	Search to see if Index already exists and if so, Push the data onto stack.
for li_Index = 1 to UpperBound ( ia_Index )
	if ClassName ( ia_Index [ li_Index ] ) <> ls_ClassName then
		continue
	elseif ia_Index [ li_Index ] = aa_Index then
		li_UpdateIndex = li_Index
		if UpperBound ( ii_StackPos ) >= li_UpdateIndex then
			ii_StackPos [ li_UpdateIndex ] ++
		else
			ii_StackPos [ li_UpdateIndex ] = 1
		end if
		li_Index = UpperBound ( ia_Index )
	end if
next

//	Item doesn't exists so return error.
if li_UpdateIndex = 0 then
	return -1
end if

//	Assign current Value to Stack.
incst_Array [ li_UpdateIndex ].ia_Array [ ii_StackPos [ li_UpdateIndex ] ] = ia_Value [ li_UpdateIndex ]

//	Return success.
return 1

end function

on n_cst_associativestack.create
TriggerEvent( this, "constructor" )
end on

on n_cst_associativestack.destroy
TriggerEvent( this, "destructor" )
end on

