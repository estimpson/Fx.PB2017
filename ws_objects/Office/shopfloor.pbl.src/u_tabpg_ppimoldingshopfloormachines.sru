$PBExportHeader$u_tabpg_ppimoldingshopfloormachines.sru
forward
global type u_tabpg_ppimoldingshopfloormachines from u_tabpg_dw
end type
type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloormachines
end type
end forward

global type u_tabpg_ppimoldingshopfloormachines from u_tabpg_dw
string text = "Molding Machines"
uo_rowcontrol uo_rowcontrol
end type
global u_tabpg_ppimoldingshopfloormachines u_tabpg_ppimoldingshopfloormachines

type variables

end variables

on u_tabpg_ppimoldingshopfloormachines.create
int iCurrent
call super::create
this.uo_rowcontrol=create uo_rowcontrol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_rowcontrol
end on

on u_tabpg_ppimoldingshopfloormachines.destroy
call super::destroy
destroy(this.uo_rowcontrol)
end on

event constructor;call super::constructor;
inv_Resize.of_Register(uo_rowcontrol, 0, 100, 0, 0)

//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO [1] = dw_1.object.machinecode

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_ppimoldingshopfloormachines
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_ppimoldingshopfloormachines
integer height = 880
string dataobject = "d_ppi_moldingschedulemachineheader"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve ()

end event

event dw_1::retrieveend;call super::retrieveend;
uo_RowControl.CurrentRow(GetRow())

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
uo_RowControl.CurrentRow(currentRow)

end event

type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloormachines
integer x = 5
integer y = 964
integer height = 112
integer taborder = 90
boolean bringtotop = true
end type

event constructor;call super::constructor;
SetRequestor(dw_1)

end event

on uo_rowcontrol.destroy
call u_rowselector::destroy
end on

