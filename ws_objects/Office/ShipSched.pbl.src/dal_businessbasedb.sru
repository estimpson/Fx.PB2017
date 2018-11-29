$PBExportHeader$dal_businessbasedb.sru
forward
global type dal_businessbasedb from n_base
end type
end forward

global type dal_businessbasedb from n_base
end type
global dal_businessbasedb dal_businessbasedb

type variables

Protected:
n_tr SQLTrans

end variables

forward prototypes
public function integer settransobject (ref n_tr _sqltrans)
end prototypes

public function integer settransobject (ref n_tr _sqltrans);
if	not IsValid(_SQLTrans) then
	return FAILURE
end if

SQLTrans = _SQLTrans
return SUCCESS

end function

on dal_businessbasedb.create
call super::create
end on

on dal_businessbasedb.destroy
call super::destroy
end on

