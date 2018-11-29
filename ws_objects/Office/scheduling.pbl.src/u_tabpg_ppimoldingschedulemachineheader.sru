$PBExportHeader$u_tabpg_ppimoldingschedulemachineheader.sru
forward
global type u_tabpg_ppimoldingschedulemachineheader from u_tabpg_dw
end type
end forward

global type u_tabpg_ppimoldingschedulemachineheader from u_tabpg_dw
string text = "Machine List"
end type
global u_tabpg_ppimoldingschedulemachineheader u_tabpg_ppimoldingschedulemachineheader

on u_tabpg_ppimoldingschedulemachineheader.create
call super::create
end on

on u_tabpg_ppimoldingschedulemachineheader.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO[1] = dw_1.object.machinecode

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_ppimoldingschedulemachineheader
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_ppimoldingschedulemachineheader
string dataobject = "d_ppi_moldingschedulemachineheader"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve ()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

