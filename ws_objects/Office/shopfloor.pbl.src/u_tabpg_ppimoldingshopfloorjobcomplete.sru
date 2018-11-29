$PBExportHeader$u_tabpg_ppimoldingshopfloorjobcomplete.sru
forward
global type u_tabpg_ppimoldingshopfloorjobcomplete from u_tabpg_ppimoldingshopfloorjobdetails
end type
type dw_jobcomplete from u_dw within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_jobcomplete from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_undo from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_scan from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_showall from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_showactive from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
type cb_correct from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobcomplete from u_tabpg_ppimoldingshopfloorjobdetails
integer width = 2930
integer height = 1856
string text = "Job Complete"
string statustypetable = "dbo.BackflushHeaders"
dw_jobcomplete dw_jobcomplete
cb_jobcomplete cb_jobcomplete
cb_undo cb_undo
cb_scan cb_scan
cb_showall cb_showall
cb_showactive cb_showactive
cb_correct cb_correct
end type
global u_tabpg_ppimoldingshopfloorjobcomplete u_tabpg_ppimoldingshopfloorjobcomplete

type variables

n_cst_shopfloortrans ShopFloorTrans

end variables

forward prototypes
public subroutine showallserials ()
public subroutine showactiveserials ()
end prototypes

public subroutine showallserials ();
dw_1.SetFilter("")
dw_1.Filter()
dw_1.Sort()
dw_1.SetRow(1)
cb_showall.Visible = false
cb_showactive.Visible = true

end subroutine

public subroutine showactiveserials ();
long inactiveStatus
inactiveStatus = ShopFloorTrans.StatusValue("dbo.BackflushHeaders", "Deleted")
dw_1.SetFilter("bfstatus <> " + String(inactiveStatus))
dw_1.Filter()
dw_1.Sort()
dw_1.SetRow(1)
cb_showactive.Visible = false
cb_showall.Visible = true

end subroutine

on u_tabpg_ppimoldingshopfloorjobcomplete.create
int iCurrent
call super::create
this.dw_jobcomplete=create dw_jobcomplete
this.cb_jobcomplete=create cb_jobcomplete
this.cb_undo=create cb_undo
this.cb_scan=create cb_scan
this.cb_showall=create cb_showall
this.cb_showactive=create cb_showactive
this.cb_correct=create cb_correct
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_jobcomplete
this.Control[iCurrent+2]=this.cb_jobcomplete
this.Control[iCurrent+3]=this.cb_undo
this.Control[iCurrent+4]=this.cb_scan
this.Control[iCurrent+5]=this.cb_showall
this.Control[iCurrent+6]=this.cb_showactive
this.Control[iCurrent+7]=this.cb_correct
end on

on u_tabpg_ppimoldingshopfloorjobcomplete.destroy
call super::destroy
destroy(this.dw_jobcomplete)
destroy(this.cb_jobcomplete)
destroy(this.cb_undo)
destroy(this.cb_scan)
destroy(this.cb_showall)
destroy(this.cb_showactive)
destroy(this.cb_correct)
end on

event constructor;call super::constructor;
//	Setup resize.
inv_Resize.of_SetOrigSize(gb_parent.X +gb_parent.Width, gb_parent.Y + gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_jobcomplete, 100, 0, 0, 0)
inv_Resize.of_Register(cb_correct, 100, 0, 0, 0)
inv_Resize.of_Register(cb_undo, 100, 0, 0, 0)
inv_Resize.of_Register(cb_scan, 100, 0, 0, 0)
inv_Resize.of_Register(cb_showall, 100, 0, 0, 0)
inv_Resize.of_Register(cb_showactive, 100, 0, 0, 0)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event destructor;call super::destructor;
destroy ShopFloorTrans

end event

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloorjobcomplete
integer y = 716
integer width = 2359
string text = "Serials"
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloorjobcomplete
integer y = 796
integer width = 2345
string dataobject = "d_ppimolding_jobcompletes"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get status codes.
datawindowchild statusDWC
if	GetChild("BFStatus", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve(StatusTypeTable) <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

//	Get type codes.
datawindowchild typeDWC
if	GetChild("BFType", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve(StatusTypeTable) <= 0 then
		typeDWC.InsertRow(0)
	end if
end if

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber, WorkOrderDetailLine)

end event

event dw_1::activerowchanged;call super::activerowchanged;
dw_jobcomplete.SetRedraw(false)
dw_jobcomplete.Reset()
if	activerow <= 0 then return
dw_jobcomplete.InsertRow(0)
dw_jobcomplete.object.serial[1] = object.serial[activerow]
dw_jobcomplete.object.productiondt[1] = object.productiondt[activerow]
dw_jobcomplete.object.partcode[1] = object.partcode[activerow]
dw_jobcomplete.object.packagetype[1] = object.packagetype[activerow]
dw_jobcomplete.object.qtyproduced[1] = object.qtyproduced[activerow]
dw_jobcomplete.object.labelformat[1] = object.labelformat[activerow]
dw_jobcomplete.SetRedraw(true)
cb_jobcomplete.visible = not (isnull(object.serial[activerow], -1) > 0)
cb_correct.visible = (isnull(object.serial[activerow], -1) > 0)
cb_undo.visible = (isnull(object.serial[activerow], -1) > 0)

end event

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloorjobcomplete
integer width = 2889
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloorjobcomplete
integer width = 2903
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloorjobcomplete
integer y = 1680
end type

type dw_jobcomplete from u_dw within u_tabpg_ppimoldingshopfloorjobcomplete
integer y = 348
integer width = 2354
integer height = 352
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_shopfloor_jobcomplete"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_jobcomplete from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 364
integer width = 407
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Job Complete"
end type

event clicked;
if	dw_jobcomplete.RowCount() <= 0 then
	return
end if

//	Restore material.
string packageType
decimal qtyProduced
qtyProduced = dw_jobcomplete.object.qtyproduced[1]
packageType = dw_jobcomplete.object.packagetype[1]

long newSerial
int i;
for	i = 1 to dw_jobcomplete.object.boxes[1]
	if	ShopFloorTrans.Production(workOrderNumber, workOrderDetailLine, packageType, qtyProduced, newSerial) <> SUCCESS then
		exit
	end if
next

RefreshNotify()

end event

type cb_undo from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 492
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Undo"
end type

type cb_scan from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 716
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Scan..."
end type

type cb_showall from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 844
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Show All"
end type

type cb_showactive from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 844
integer width = 407
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Show Active"
end type

type cb_correct from commandbutton within u_tabpg_ppimoldingshopfloorjobcomplete
integer x = 2414
integer y = 364
integer width = 407
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Correct"
end type

