$PBExportHeader$n_cst_trans.sru
forward
global type n_cst_trans from n_base
end type
end forward

global type n_cst_trans from n_base
end type
global n_cst_trans n_cst_trans

type variables

protected n_tr TransObject

end variables

forward prototypes
public function integer settransobject (n_tr _transobject)
end prototypes

public function integer settransobject (n_tr _transobject);
if	IsValid (_transObject) then
	TransObject = _transObject
	return SUCCESS
end if
return FAILURE


end function

on n_cst_trans.create
call super::create
end on

on n_cst_trans.destroy
call super::destroy
end on

