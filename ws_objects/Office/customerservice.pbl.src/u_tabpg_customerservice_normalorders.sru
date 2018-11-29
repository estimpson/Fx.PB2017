$PBExportHeader$u_tabpg_customerservice_normalorders.sru
forward
global type u_tabpg_customerservice_normalorders from u_tabpg_dw
end type
type st_1 from u_st_splitbar within u_tabpg_customerservice_normalorders
end type
type dw_2 from u_fxdw_custsrv_normalorderedit within u_tabpg_customerservice_normalorders
end type
end forward

global type u_tabpg_customerservice_normalorders from u_tabpg_dw
integer width = 3776
string text = "Normal Order Headers"
st_1 st_1
dw_2 dw_2
end type
global u_tabpg_customerservice_normalorders u_tabpg_customerservice_normalorders

on u_tabpg_customerservice_normalorders.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_2
end on

on u_tabpg_customerservice_normalorders.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_2)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(dw_2.X + dw_2.Width, dw_1.Y + dw_1.Height)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_2, 100, 0, 0, 100)
inv_Resize.of_Register(st_1, 100, 0, 0, 100)
st_1.post of_Register(gb_1, st_1.LEFT)
st_1.post of_Register(dw_1, st_1.LEFT)
st_1.post of_Register(dw_2, st_1.RIGHT)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.ordernumber

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_normalorders
integer y = 8
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_normalorders
integer y = 88
string dataobject = "d_customerservice_normalorders"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	RowCount() < activeRow or activeRow < 1 then
	dw_2.Reset()
	return
end if

dw_2.OrderNumber = object.ordernumber[activeRow]
dw_2.event pfc_Retrieve()

end event

type st_1 from u_st_splitbar within u_tabpg_customerservice_normalorders
integer x = 1755
integer y = 8
integer width = 18
integer height = 1084
boolean bringtotop = true
end type

type dw_2 from u_fxdw_custsrv_normalorderedit within u_tabpg_customerservice_normalorders
integer x = 1769
integer width = 1669
integer height = 1080
integer taborder = 11
boolean bringtotop = true
end type

