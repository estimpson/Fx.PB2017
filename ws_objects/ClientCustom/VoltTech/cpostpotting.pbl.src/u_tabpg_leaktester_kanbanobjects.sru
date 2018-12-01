$PBExportHeader$u_tabpg_leaktester_kanbanobjects.sru
forward
global type u_tabpg_leaktester_kanbanobjects from u_tabpg_dw
end type
end forward

global type u_tabpg_leaktester_kanbanobjects from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_leaktester_kanbanobjects u_tabpg_leaktester_kanbanobjects

type variables

private:
string _kanbanNumber
end variables

forward prototypes
public function integer setkanbannumber (string kanbannumber)
end prototypes

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return Refresh()

end function

on u_tabpg_leaktester_kanbanobjects.create
call super::create
end on

on u_tabpg_leaktester_kanbanobjects.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_leaktester_kanbanobjects
string text = "Good Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_leaktester_kanbanobjects
string dataobject = "d_leaktester_kanbanobjectlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_kanbanNumber)

end event

