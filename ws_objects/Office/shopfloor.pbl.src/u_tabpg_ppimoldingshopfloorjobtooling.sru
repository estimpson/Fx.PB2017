$PBExportHeader$u_tabpg_ppimoldingshopfloorjobtooling.sru
forward
global type u_tabpg_ppimoldingshopfloorjobtooling from u_tabpg_ppimoldingshopfloorjobdetails
end type
type cb_next from commandbutton within u_tabpg_ppimoldingshopfloorjobtooling
end type
type cb_toolchange from commandbutton within u_tabpg_ppimoldingshopfloorjobtooling
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobtooling from u_tabpg_ppimoldingshopfloorjobdetails
integer width = 2400
integer height = 1584
string text = "Tooling"
cb_next cb_next
cb_toolchange cb_toolchange
end type
global u_tabpg_ppimoldingshopfloorjobtooling u_tabpg_ppimoldingshopfloorjobtooling

type variables

n_cst_shopfloortrans ShopFloorTrans

end variables

on u_tabpg_ppimoldingshopfloorjobtooling.create
int iCurrent
call super::create
this.cb_next=create cb_next
this.cb_toolchange=create cb_toolchange
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_next
this.Control[iCurrent+2]=this.cb_toolchange
end on

on u_tabpg_ppimoldingshopfloorjobtooling.destroy
call super::destroy
destroy(this.cb_next)
destroy(this.cb_toolchange)
end on

event constructor;call super::constructor;
//	Setup resize.
inv_Resize.of_SetOrigSize(gb_parent.X + gb_parent.Width, gb_parent.Y + cb_next.Y + cb_next.Height)
inv_Resize.of_Register(cb_toolchange, 100, 0, 0, 0)
inv_Resize.of_Register(cb_next, 100, 100, 0, 0)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event destructor;call super::destructor;
destroy ShopFloorTrans

end event

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloorjobtooling
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloorjobtooling
string dataobject = "d_ppimolding_jobtooling"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber)

end event

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloorjobtooling
integer width = 2267
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloorjobtooling
integer width = 2281
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloorjobtooling
end type

type cb_next from commandbutton within u_tabpg_ppimoldingshopfloorjobtooling
integer x = 1806
integer y = 1348
integer width = 407
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next >>"
end type

type cb_toolchange from commandbutton within u_tabpg_ppimoldingshopfloorjobtooling
integer x = 1806
integer y = 376
integer width = 407
integer height = 112
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Tool Change..."
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Open dialog to get new tool...
message.inv_Parm.of_SetItem("WorkOrderNumber", WorkOrderNumber)
open(w_ppimoldingtoolchange)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the new tool details.
	string moldSetter
	string newMold
	string toolChangeNotes
	moldSetter = message.inv_Parm.of_GetItem("MoldSetter")
	newMold = message.inv_Parm.of_GetItem("NewMold")
	toolChangeNotes = message.inv_Parm.of_GetItem("ToolChangeNotes")

	//	Create substitution.
	ShopFloorTrans.SetJobTool(moldSetter, WorkOrderNumber, WorkOrderDetailSequence, newMold, toolChangeNotes)
end if

RefreshNotify()

end event

