$PBExportHeader$n_cst_eventarray.sru
forward
global type n_cst_eventarray from n_base
end type
end forward

global type n_cst_eventarray from n_base
end type
global n_cst_eventarray n_cst_eventarray

type variables

private integer	ii_ArraySize = 0
public n_cst_event invEvents [ ]

end variables

forward prototypes
public function integer of_getindex (string as_Event)
public function integer of_upperbound ()
end prototypes

public function integer of_getindex (string as_Event);
//	Check the current list of events.
integer	i
for i = 1 to ii_ArraySize
	if invEvents [ i ].Name = as_Event then return i
next

//	Not found.  Add it.
ii_ArraySize++
invEvents [ ii_ArraySize ] = create n_cst_event
invEvents [ ii_ArraySize ].Name = as_Event
return ii_ArraySize

end function

public function integer of_upperbound ();
//	Return size.
return ii_ArraySize

end function

on n_cst_eventarray.create
call super::create
end on

on n_cst_eventarray.destroy
call super::destroy
end on

