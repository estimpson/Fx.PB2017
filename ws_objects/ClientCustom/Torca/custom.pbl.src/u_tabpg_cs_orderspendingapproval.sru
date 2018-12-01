$PBExportHeader$u_tabpg_cs_orderspendingapproval.sru
forward
global type u_tabpg_cs_orderspendingapproval from u_tabpg_dw
end type
type cb_mark from commandbutton within u_tabpg_cs_orderspendingapproval
end type
type cb_save from commandbutton within u_tabpg_cs_orderspendingapproval
end type
end forward

global type u_tabpg_cs_orderspendingapproval from u_tabpg_dw
integer width = 2450
string text = "Order Approval"
cb_mark cb_mark
cb_save cb_save
end type
global u_tabpg_cs_orderspendingapproval u_tabpg_cs_orderspendingapproval

type variables

n_cst_cs_orders OrdersTrans

end variables

on u_tabpg_cs_orderspendingapproval.create
int iCurrent
call super::create
this.cb_mark=create cb_mark
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_mark
this.Control[iCurrent+2]=this.cb_save
end on

on u_tabpg_cs_orderspendingapproval.destroy
call super::destroy
destroy(this.cb_mark)
destroy(this.cb_save)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_mark.X + (cb_mark.X - gb_1.X - gb_1.Width) + cb_mark.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_mark, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)

OrdersTrans = create n_cst_cs_orders

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.orderno

end event

event destructor;call super::destructor;
destroy OrdersTrans

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_cs_orderspendingapproval
string dataobject = "d_dbo_cs_orderspendingapproval"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then
	SetRow(row)
end if

end event

event dw_1::itemchanged;call super::itemchanged;
int i, selectedRows[]

choose case lower(dwo.name)
	case lower("OrderStatus")
		selectedRows = dw_1.object.isselected.primary
		for i = 1 to UpperBound(selectedRows)
			if	selectedRows[i] = 1 then
				dw_1.object.OrderStatus[i] = data
			end if
		next
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_cs_orderspendingapproval
string text = "Orders Pending Approval"
end type

type cb_mark from commandbutton within u_tabpg_cs_orderspendingapproval
integer x = 1819
integer y = 20
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
string text = "Mark Approved"
end type

event clicked;
int i, selectedRows[]

selectedRows = dw_1.object.isselected.primary
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		dw_1.object.OrderStatus[i] = "Approved"
	end if
next

end event

type cb_save from commandbutton within u_tabpg_cs_orderspendingapproval
integer x = 1819
integer y = 152
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
string text = "Save Approvals"
end type

event clicked;
int i
long	orderNo
string approvedRows []

approvedRows = dw_1.object.OrderStatus.primary
for i = 1 to UpperBound(approvedRows)
	if	lower(approvedRows[i]) = lower("Approved") then
		orderNo = dw_1.object.OrderNo[i]
		OrdersTrans.ApproveOrder(orderNo)
	end if
next

Refreshing=true;
Refresh()

end event

