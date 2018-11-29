$PBExportHeader$n_cst_statearray.sru
forward
global type n_cst_statearray from n_base
end type
end forward

global type n_cst_statearray from n_base
end type
global n_cst_statearray n_cst_statearray

type variables

private integer	ii_ArraySize = 0
public n_cst_state invStates [ ]

end variables

forward prototypes
public function integer of_getindex (string as_state)
public function integer of_upperbound ()
public function integer of_addstate (string state, ref boolean newstate)
public function integer of_addstate (string state)
end prototypes

public function integer of_getindex (string as_state);
//	Check the current list of events.
integer	i
for i = 1 to ii_ArraySize
	if invStates [ i ].Name = as_State then return i
next
return 0

end function

public function integer of_upperbound ();
//	Return size.
return ii_ArraySize

end function

public function integer of_addstate (string state, ref boolean newstate);
//	Check the current list of events.
integer	i
i = of_GetIndex(state)
if i > 0 then
	newState = false
	return i
end if

//	Not found.  Add it.
newState = true
ii_ArraySize++
invStates[ii_ArraySize] = create n_cst_state
invStates[ii_ArraySize].Name = state
return ii_ArraySize

end function

public function integer of_addstate (string state);
//	Check the current list of events.
boolean newStateIgnored
return of_AddState(state, newStateIgnored)


end function

on n_cst_statearray.create
call super::create
end on

on n_cst_statearray.destroy
call super::destroy
end on

