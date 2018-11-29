$PBExportHeader$n_cst_requestor.sru
forward
global type n_cst_requestor from n_base
end type
end forward

global type n_cst_requestor from n_base
end type
global n_cst_requestor n_cst_requestor

type variables

public boolean	HasEvents = false
public integer	Status
public powerobject	Requestor
public n_cst_eventarray	invEventArray

end variables

on n_cst_requestor.create
call super::create
end on

on n_cst_requestor.destroy
call super::destroy
end on

event constructor;call super::constructor;
invEventArray = create n_cst_eventarray

end event

event destructor;call super::destructor;
destroy invEventArray

end event

