$PBExportHeader$u_tabpg_fxcop_torcaraw.sru
forward
global type u_tabpg_fxcop_torcaraw from u_tabpg_dw
end type
type dw_2 from u_dw within u_tabpg_fxcop_torcaraw
end type
end forward

global type u_tabpg_fxcop_torcaraw from u_tabpg_dw
string text = "Demand Summary"
dw_2 dw_2
end type
global u_tabpg_fxcop_torcaraw u_tabpg_fxcop_torcaraw

on u_tabpg_fxcop_torcaraw.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on u_tabpg_fxcop_torcaraw.destroy
call super::destroy
destroy(this.dw_2)
end on

event constructor;call super::constructor;
inv_Resize.of_Register(dw_2, 0, 0, 100, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_fxcop_torcaraw
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_fxcop_torcaraw
integer y = 212
integer width = 1737
integer height = 868
string dataobject = "d_fxcop_demandheader_parttype"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return retrieve (dw_2.object.d1[1], dw_2.object.d2[1], dw_2.object.d3[1], '%RAW')

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("torcaraw.RawPart", object.PartCode[GetRow()])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
if	currentrow > 0 then
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("torcaraw.RawPart", object.PartCode[CurrentRow])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then SetRow(row)

end event

type dw_2 from u_dw within u_tabpg_fxcop_torcaraw
integer x = 5
integer y = 76
integer width = 1737
integer height = 136
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fxcop_demandbuckets"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;
AcceptText()
dw_1.of_Refresh(true)
dw_1.event pfc_retrieve()

end event

event getfocus;call super::getfocus;
gb_1.textcolor = 134217742
gb_1.backcolor = 134217741
end event

event losefocus;call super::losefocus;
gb_1.textcolor = 33554432
gb_1.backcolor = 1073741824
end event

event constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false

end event

