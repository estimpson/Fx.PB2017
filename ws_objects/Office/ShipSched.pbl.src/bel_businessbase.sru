$PBExportHeader$bel_businessbase.sru
forward
global type bel_businessbase from n_base
end type
end forward

global type bel_businessbase from n_base
end type
global bel_businessbase bel_businessbase

type variables

Public:
protectedwrite long ID

end variables

forward prototypes
public function integer setid (long _id)
end prototypes

public function integer setid (long _id);
//	Set the ID.
ID = _id

//	Return.
return	SUCCESS

end function

on bel_businessbase.create
call super::create
end on

on bel_businessbase.destroy
call super::destroy
end on

