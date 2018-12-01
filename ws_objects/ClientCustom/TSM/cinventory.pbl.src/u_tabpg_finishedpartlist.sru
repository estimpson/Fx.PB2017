$PBExportHeader$u_tabpg_finishedpartlist.sru
forward
global type u_tabpg_finishedpartlist from u_tabpg_dw
end type
type cb_newplanning from commandbutton within u_tabpg_finishedpartlist
end type
end forward

global type u_tabpg_finishedpartlist from u_tabpg_dw
integer width = 2619
string text = "Finished Part List"
cb_newplanning cb_newplanning
end type
global u_tabpg_finishedpartlist u_tabpg_finishedpartlist

type variables

n_cst_mes_inventorytrans InventoryTrans

end variables

on u_tabpg_finishedpartlist.create
int iCurrent
call super::create
this.cb_newplanning=create cb_newplanning
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_newplanning
end on

on u_tabpg_finishedpartlist.destroy
call super::destroy
destroy(this.cb_newplanning)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_newplanning.X + (cb_newplanning.X - gb_1.X - gb_1.Width) + cb_newplanning.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_newplanning, 100, 0, 0, 0)

InventoryTrans = create n_cst_mes_inventorytrans

//Descendents (master):
//Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//e.g.:
masterDWO[1] = dw_1.object.finishedpartcode

end event

event destructor;call super::destructor;
destroy InventoryTrans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_finishedpartlist
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_finishedpartlist
string dataobject = "d_custom_mes_finishedpartlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(false)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then
	SetRow(row)
end if

end event

type cb_newplanning from commandbutton within u_tabpg_finishedpartlist
integer x = 1810
integer y = 60
integer width = 489
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New Planning"
end type

event clicked;
InventoryTrans.NewPlanning()

Refreshing=true
Refresh()

end event

