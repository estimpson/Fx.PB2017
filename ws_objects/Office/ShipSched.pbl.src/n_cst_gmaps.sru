$PBExportHeader$n_cst_gmaps.sru
forward
global type n_cst_gmaps from n_base
end type
end forward

global type n_cst_gmaps from n_base
end type
global n_cst_gmaps n_cst_gmaps

type variables

public:
string ia_Key

protectedwrite string	is_CSView = "u_dw_cssexplorerview"
protectedwrite string	is_CSViewDW = ""
protectedwrite string	is_Type = "GMAPS"

protectedwrite n_cst_associative_array	inv_Property
privatewrite n_tr	itr_TransObject

end variables

forward prototypes
public function integer of_settransobject (ref n_tr atr_transobject)
public function string of_getcsviewdw ()
public function string of_getcsview ()
end prototypes

public function integer of_settransobject (ref n_tr atr_transobject);
//	Reset current transaction
n_tr	ltr_None
itr_TransObject = ltr_None

//	Check if transaction is valid.
if IsValid ( atr_TransObject ) then
	//	Record transaction.
	itr_TransObject = atr_TransObject
	return SUCCESS
else
	return FAILURE
end if

end function

public function string of_getcsviewdw ();
//	Attempt to get an override.
string	ls_CSViewDW

select	OverrideClass
into	:ls_CSViewDW
from	CSPlantOverrides
where	BaseClass = :is_CSViewDW using itr_TransObject  ;

if itr_TransObject.SQLCode = 0 then return ls_CSViewDW

//	Return.
return is_CSViewDW

end function

public function string of_getcsview ();
//	Attempt to get an override.
string	ls_CSView

select	OverrideClass
into	:ls_CSView
from	CSPlantOverrides
where	BaseClass = :is_CSView using itr_TransObject  ;

if itr_TransObject.SQLCode = 0 then return ls_CSView

//	Return.
return is_CSView

end function

on n_cst_gmaps.create
call super::create
end on

on n_cst_gmaps.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Default assignment is SQLCA.
of_SetTransObject ( SQLCA )

end event

