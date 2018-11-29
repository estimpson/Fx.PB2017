$PBExportHeader$n_cst_requestorarray.sru
forward
global type n_cst_requestorarray from n_base
end type
end forward

global type n_cst_requestorarray from n_base
end type
global n_cst_requestorarray n_cst_requestorarray

type variables

private integer	ii_ArraySize = 0
public n_cst_requestor invRequestors [ ]

end variables

forward prototypes
public function integer of_getindex (powerobject apo_Requestor)
public function integer of_upperbound ()
end prototypes

public function integer of_getindex (powerobject apo_Requestor);
//	Check the current list of requestors.
integer	i
for i = 1 to ii_ArraySize
	if invRequestors [ i ].Requestor = apo_Requestor then return i
next

//	Not found.  Add it.
ii_ArraySize++
invRequestors [ ii_ArraySize ] = create n_cst_requestor
invRequestors [ ii_ArraySize ].Requestor = apo_Requestor
return ii_ArraySize

end function

public function integer of_upperbound ();
//	Return size.
return ii_ArraySize

end function

on n_cst_requestorarray.create
call super::create
end on

on n_cst_requestorarray.destroy
call super::destroy
end on

