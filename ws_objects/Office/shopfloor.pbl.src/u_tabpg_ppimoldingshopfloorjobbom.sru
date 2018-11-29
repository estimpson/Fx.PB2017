$PBExportHeader$u_tabpg_ppimoldingshopfloorjobbom.sru
forward
global type u_tabpg_ppimoldingshopfloorjobbom from u_tabpg_ppimoldingshopfloorjobdetails
end type
type cb_remove from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
end type
type cb_substitute from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
end type
type cb_manualmi from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
end type
type cb_restore from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
end type
type cb_next from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobbom from u_tabpg_ppimoldingshopfloorjobdetails
integer width = 2373
string text = "Bill Of Material"
string statustypetable = "dbo.WorkOrderDetailBillOfMaterials"
cb_remove cb_remove
cb_substitute cb_substitute
cb_manualmi cb_manualmi
cb_restore cb_restore
cb_next cb_next
end type
global u_tabpg_ppimoldingshopfloorjobbom u_tabpg_ppimoldingshopfloorjobbom

type variables

n_cst_shopfloortrans ShopFloorTrans

end variables

on u_tabpg_ppimoldingshopfloorjobbom.create
int iCurrent
call super::create
this.cb_remove=create cb_remove
this.cb_substitute=create cb_substitute
this.cb_manualmi=create cb_manualmi
this.cb_restore=create cb_restore
this.cb_next=create cb_next
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_remove
this.Control[iCurrent+2]=this.cb_substitute
this.Control[iCurrent+3]=this.cb_manualmi
this.Control[iCurrent+4]=this.cb_restore
this.Control[iCurrent+5]=this.cb_next
end on

on u_tabpg_ppimoldingshopfloorjobbom.destroy
call super::destroy
destroy(this.cb_remove)
destroy(this.cb_substitute)
destroy(this.cb_manualmi)
destroy(this.cb_restore)
destroy(this.cb_next)
end on

event constructor;call super::constructor;
//	Setup resize.
inv_Resize.of_SetOrigSize(gb_parent.X +gb_parent.Width, gb_parent.Y + cb_next.Y + cb_next.Height)
inv_Resize.of_Register(cb_remove, 100, 0, 0, 0)
inv_Resize.of_Register(cb_restore, 100, 0, 0, 0)
inv_Resize.of_Register(cb_substitute, 100, 0, 0, 0)
inv_Resize.of_Register(cb_manualmi, 100, 0, 0, 0)
inv_Resize.of_Register(cb_next, 100, 100, 0, 0)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event destructor;call super::destructor;
destroy ShopFloorTrans

end event

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloorjobbom
string text = "BOM Records"
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloorjobbom
string dataobject = "d_ppimoldingjobbom"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber, WorkOrderDetailLine)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	rowcount() < 1 then return
choose case object.status[GetRow()]
	case ShopFloorTrans.StatusValue("dbo.WorkOrderDetailBillOfMaterials", "Used")
		cb_remove.enabled = true
		cb_manualmi.enabled = true
		cb_restore.enabled = false
	case ShopFloorTrans.StatusValue("dbo.WorkOrderDetailBillOfMaterials", "Not Used")
		cb_remove.enabled = false
		cb_manualmi.enabled = true
		cb_restore.enabled = true
	case ShopFloorTrans.StatusValue("dbo.WorkOrderDetailBillOfMaterials", "Manual")
		cb_remove.enabled = false
		cb_manualmi.enabled = true
		cb_restore.enabled = true
	case else
		cb_remove.enabled = true
		cb_manualmi.enabled = true
		cb_restore.enabled = false
end choose

end event

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloorjobbom
integer width = 2281
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloorjobbom
integer width = 2295
string text = "Work Order Line"
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloorjobbom
end type

type cb_remove from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
integer x = 1806
integer y = 376
integer width = 407
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Remove"
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Check return value...
if	MsgBox("Are you sure you want to remove the selected material?", Question!, YesNo!, 2) = 1 then
	long primaryRowID
	primaryRowID = dw_1.object.rowid[dw_1.getrow()]
	
	//	Remove material.
	ShopFloorTrans.RemoveMaterial(primaryRowID)
end if

RefreshNotify()

end event

type cb_substitute from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
integer x = 1806
integer y = 632
integer width = 407
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Create Sub..."
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Open dialog to get substitution...
long primaryRowID
primaryRowID = dw_1.object.rowid[dw_1.getrow()]
message.inv_Parm.of_SetItem("PrimaryRowID", primaryRowID)
open(w_ppimoldingshopfloorsubstitute)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the substitute part and substitution rate.
	string substitutePart
	decimal substitutionRate
	substitutePart = message.inv_Parm.of_GetItem("SubstitutePart")
	substitutionRate = message.inv_Parm.of_GetItem("SubstitutionRate")
	
	//	Create substitution.
	ShopFloorTrans.CreateSubstituteMaterial(primaryRowID, substitutePart, substitutionRate)
end if

RefreshNotify()

end event

type cb_manualmi from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
integer x = 1806
integer y = 760
integer width = 407
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Manual Mat. Iss."
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Check return value...
if	MsgBox("Are you sure you want to set the selected material to manual issue and override backflushing?", Question!, YesNo!, 2) = 1 then
	long manualRowID
	manualRowID = dw_1.object.rowid[dw_1.getrow()]
	
	//	Restore material.
	ShopFloorTrans.SetManualMaterial(manualRowID)
end if

RefreshNotify()

end event

type cb_restore from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
integer x = 1806
integer y = 504
integer width = 407
integer height = 112
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Restore"
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Check return value...
if	MsgBox("Are you sure you want to restore the selected material?", Question!, YesNo!, 2) = 1 then
	long primaryRowID
	primaryRowID = dw_1.object.rowid[dw_1.getrow()]
	
	//	Restore material.
	ShopFloorTrans.RestoreMaterial(primaryRowID)
end if

RefreshNotify()

end event

type cb_next from commandbutton within u_tabpg_ppimoldingshopfloorjobbom
integer x = 1806
integer y = 1348
integer width = 407
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next >>"
end type

