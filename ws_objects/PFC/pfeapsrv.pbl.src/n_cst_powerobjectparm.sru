$PBExportHeader$n_cst_powerobjectparm.sru
forward
global type n_cst_powerobjectparm from nonvisualobject
end type
end forward

global type n_cst_powerobjectparm from nonvisualobject
end type
global n_cst_powerobjectparm n_cst_powerobjectparm

type variables
Private:

n_cst_associative_array	in_cst_Parm
end variables

forward prototypes
public function any of_getitem (any aa_Name)
public function any of_setitem (any aa_name, any aa_value)
end prototypes

public function any of_getitem (any aa_Name);
//	Return getitem ().

return in_cst_parm.of_GetItem ( aa_Name )
end function

public function any of_setitem (any aa_name, any aa_value);
//	Return getitem ().

return in_cst_parm.of_SetItem ( aa_Name, aa_Value )
end function

on n_cst_powerobjectparm.create
TriggerEvent( this, "constructor" )
end on

on n_cst_powerobjectparm.destroy
TriggerEvent( this, "destructor" )
end on

