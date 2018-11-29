$PBExportHeader$u_tabpg_integrated_machinemfg.sru
forward
global type u_tabpg_integrated_machinemfg from u_tabpg_dw
end type
end forward

global type u_tabpg_integrated_machinemfg from u_tabpg_dw
integer width = 1977
string text = "Machine Mfg"
end type
global u_tabpg_integrated_machinemfg u_tabpg_integrated_machinemfg

type variables
boolean Refreshing

end variables

forward prototypes
public function integer refresh ()
public function integer save ()
end prototypes

public function integer refresh ();
dw_1.of_Refresh(Refreshing) ; Refreshing = false
return dw_1.event pfc_retrieve()

end function

public function integer save ();integer updateReturn
dw_1.AcceptText()
updateReturn = dw_1.Update(true)
if	updateReturn = 1 then
	commit;
else
	msgBox("Save Failed!")
end if
return	updateReturn

end function

on u_tabpg_integrated_machinemfg.create
call super::create
end on

on u_tabpg_integrated_machinemfg.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_integrated_machinemfg
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_integrated_machinemfg
string dataobject = "d_fxcop_integrated_machinemfg"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then SetRow(row)

end event

event dw_1::dberror;call super::dberror;return 2
end event

