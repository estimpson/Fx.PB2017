$PBExportHeader$u_tabpg_fxcop_ppimolding.sru
forward
global type u_tabpg_fxcop_ppimolding from u_tabpg_dw
end type
type dw_2 from u_dw within u_tabpg_fxcop_ppimolding
end type
type cb_saverow from commandbutton within u_tabpg_fxcop_ppimolding
end type
type cb_saveall from commandbutton within u_tabpg_fxcop_ppimolding
end type
end forward

global type u_tabpg_fxcop_ppimolding from u_tabpg_dw
integer width = 2350
string text = "Demand Summary"
dw_2 dw_2
cb_saverow cb_saverow
cb_saveall cb_saveall
end type
global u_tabpg_fxcop_ppimolding u_tabpg_fxcop_ppimolding

type variables

datawindowchild MoldingMachinesDWC
datawindowchild MoldingToolsDWC

end variables

on u_tabpg_fxcop_ppimolding.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_saverow=create cb_saverow
this.cb_saveall=create cb_saveall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_saverow
this.Control[iCurrent+3]=this.cb_saveall
end on

on u_tabpg_fxcop_ppimolding.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_saverow)
destroy(this.cb_saveall)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_saverow.X + (cb_saverow.X - gb_1.X - gb_1.Width) + cb_saverow.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_saverow, 100, 0, 0, 0)
inv_Resize.of_Register(cb_saveall, 100, 0, 0, 0)
inv_Resize.of_Register(dw_2, 0, 0, 100, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_fxcop_ppimolding
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_fxcop_ppimolding
integer y = 212
integer width = 1737
integer height = 868
string dataobject = "d_fxcop_demandheader_primarysource"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return retrieve (dw_2.object.d1[1], dw_2.object.d2[1], dw_2.object.d3[1], dw_2.object.dfirm[1], 'Press%')

end event

event dw_1::constructor;call super::constructor;
//	Setup dropdowns.
//	Molding machines
object.primarysource.dddw.name = 'd_dddw_ppimoldingmachines'
object.primarysource.dddw.datacolumn = 'primarysource'
object.primarysource.dddw.displaycolumn = 'primarysource'
object.primarysource.dddw.autoretrieve = 'yes'
object.primarysource.dddw.percentwidth = 280
object.primarysource.dddw.vscrollbar = 'yes'
object.primarysource.dddw.hscrollbar = 'yes'
object.primarysource.protect = '0'
GetChild("primarysource", MoldingMachinesDWC)
MoldingMachinesDWC.SetTransObject(SQLCA)

//	Molding tools.
object.primarytool.dddw.name = 'd_dddw_ppimoldingtools'
object.primarytool.dddw.datacolumn = 'primarysource'
object.primarytool.dddw.displaycolumn = 'primarysource'
object.primarytool.dddw.autoretrieve = 'no'
object.primarytool.dddw.percentwidth = 280
object.primarytool.dddw.vscrollbar = 'yes'
object.primarytool.dddw.hscrollbar = 'yes'
object.primarytool.protect = '0'
GetChild("primarytool", MoldingToolsDWC)
MoldingToolsDWC.SetTransObject(SQLCA)

of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	//	Retrieve drop down
	MoldingToolsDWC.Retrieve (object.PartCode[GetRow()])
	
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("torcaraw.RawPart", object.PartCode[GetRow()])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
if	currentrow > 0 then
	//	Retrieve drop down
	MoldingToolsDWC.Retrieve (object.PartCode[CurrentRow])
	
	//	
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("torcaraw.RawPart", object.PartCode[CurrentRow])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then SetRow(row)

end event

type dw_2 from u_dw within u_tabpg_fxcop_ppimolding
integer x = 5
integer y = 76
integer width = 1737
integer height = 136
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fxcop_demandbuckets_extended"
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

type cb_saverow from commandbutton within u_tabpg_fxcop_ppimolding
integer x = 1806
integer y = 8
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save Row"
end type

type cb_saveall from commandbutton within u_tabpg_fxcop_ppimolding
integer x = 1806
integer y = 136
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save All"
end type

