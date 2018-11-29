$PBExportHeader$n_cst_associative_array.sru
forward
global type n_cst_associative_array from nonvisualobject
end type
end forward

global type n_cst_associative_array from nonvisualobject autoinstantiate
end type

type variables
PRIVATE:
Any		ia_index[],&
		ia_value[]
end variables

forward prototypes
public function integer of_setitem (any aa_index, any aa_value)
public function any of_getitem (any aa_index)
public function any of_getitem (integer ai_index)
public function integer of_upperbound ()
public subroutine of_reset ()
public function any of_getitemindexor (integer ai_index)
public function any of_getitemindexors ()
public function any of_getitems ()
public function any of_getitem (any aa_index, any aa_default)
public function any of_getitem (integer ai_index, any aa_Default)
public function integer of_getindexorkey (any aa_index)
public function integer of_getvaluekey (any aa_value)
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
		if IsValid (ia_value[li_index]) then
			if not IsValid (aa_Value) then
				li_UpdateIndex = li_Index
			else
				IF ClassName ( ia_value[li_index] ) = ClassName ( aa_value ) THEN
					li_updateindex = li_index
				ELSE
					li_updateindex = -1
				END IF
			end if
		else
			li_updateindex = li_index
		end if
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

public function any of_getitemindexor (integer ai_index);//************************************************************************************//
// Function Name:	of_getitemindexor
//
// Description:	This function gets the indexor at the specified index and returns it.
//
// Syntax:			ANY of_getitemIndexor ( INTEGER ai_index )
//
// Where:			ai_index		The indexor value to return
//
// Returns:			ANY	The indexor at the specified index
//						NULL	Indexor not found
//
// Log of Changes:
// CBR 02-22-1999 10:09.00	Original.
//************************************************************************************//

// declare local variables
ANY		la_dummy

// set to null in case object doesn't exist (returned)
SetNull ( la_dummy )

// make sure index exists
IF ai_index > UpperBound ( ia_index ) or ai_index < 1 THEN
	return la_dummy
ELSE
	return ia_Index[ai_index]
END IF

end function

public function any of_getitemindexors ();//************************************************************************************//
// Function Name:	of_getitemindexor
//
// Description:	This function gets the indexor at the specified index and returns it.
//
// Syntax:			ANY of_getitemIndexor ( INTEGER ai_index )
//
// Where:			ai_index		The indexor value to return
//
// Returns:			ANY	The indexor at the specified index
//						NULL	Indexor not found
//
// Log of Changes:
// CBR 02-22-1999 10:09.00	Original.
//************************************************************************************//

//	Return indexors
return ia_Index

end function

public function any of_getitems ();//************************************************************************************//
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

//	Return values.
return ia_Value

end function

public function any of_getitem (any aa_index, any aa_default);//************************************************************************************//
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
return IsNull ( la_value, aa_Default )

end function

public function any of_getitem (integer ai_index, any aa_Default);//************************************************************************************//
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

// make sure index exists
IF ai_index > UpperBound ( ia_index ) THEN
	return aa_Default
ELSE
	return ia_value[ai_index]
END IF
end function

public function integer of_getindexorkey (any aa_index);
//************************************************************************************//
// Function Name:	of_GetIndexorKey
//
// Description:	This function gets the key [internal array index] of the specified associative array indexor
//
// Syntax:			INTEGER of_GetIndexorKey ( ANY aa_index )
//
// Where:			aa_index		The index to add to the array
//
// Returns Codes:	>=1	Key of indexor
//						-1		Failure, indexor not found
//
//************************************************************************************//

// declare local variables
int	indexorKey = -1, key
string	ls_classname

// get data type for index
ls_classname = ClassName ( aa_index )

// search to see if index already exists and if so, update the data
for	key = 1 TO UpperBound ( ia_index )
	if	ClassName ( ia_index[key] ) <> ls_classname then
		continue
	elseif	ia_index[key] = aa_index then
		if IsValid (ia_value[key]) then
			indexorKey = key
		else
			indexorKey = key
		end if
		key = UpperBound ( ia_index )
		exit
	end if
next

// return success
return indexorKey

end function

public function integer of_getvaluekey (any aa_value);
//************************************************************************************//
// Function Name:	of_GetIndexorKey
//
// Description:	This function gets the key [internal array index] of the specified associative array indexor
//
// Syntax:			INTEGER of_GetIndexorKey ( ANY aa_value )
//
// Where:			aa_value		The index to add to the array
//
// Returns Codes:	>=1	Key of indexor
//						-1		Failure, indexor not found
//
//************************************************************************************//

// declare local variables
int	indexorKey = -1, key
string	ls_classname

// get data type for index
ls_classname = ClassName ( aa_value )

// search to see if index already exists and if so, update the data
for	key = 1 TO UpperBound ( ia_value )
	if	ClassName ( ia_value[key] ) <> ls_classname then
		continue
	elseif	ia_value[key] = aa_value then
		if IsValid (ia_value[key]) then
			indexorKey = key
		else
			indexorKey = key
		end if
		key = UpperBound ( ia_value )
		exit
	end if
next

// return success
return indexorKey

end function

on n_cst_associative_array.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_associative_array.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

