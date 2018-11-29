$PBExportHeader$u_tabpg_ppimoldingshopfloormaterialalloc.sru
forward
global type u_tabpg_ppimoldingshopfloormaterialalloc from u_tabpg_ppimoldingshopfloorjobdetails
end type
type st_splitbar1 from u_st_splitbar within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type uo_rowselector2 from u_rowselector within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type gb_2 from groupbox within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type dw_serials from u_dw within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_scan from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_next from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_endalloc from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_showactive from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_showall from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_showall2 from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_showactive2 from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
type cb_printpicklist from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
end type
end forward

global type u_tabpg_ppimoldingshopfloormaterialalloc from u_tabpg_ppimoldingshopfloorjobdetails
integer width = 2469
integer height = 2184
string text = "Material Allocation"
string statustypetable = "dbo.WorkOrderDetailBillOfMaterials"
st_splitbar1 st_splitbar1
uo_rowselector2 uo_rowselector2
gb_2 gb_2
dw_serials dw_serials
cb_scan cb_scan
cb_next cb_next
cb_endalloc cb_endalloc
cb_showactive cb_showactive
cb_showall cb_showall
cb_showall2 cb_showall2
cb_showactive2 cb_showactive2
cb_printpicklist cb_printpicklist
end type
global u_tabpg_ppimoldingshopfloormaterialalloc u_tabpg_ppimoldingshopfloormaterialalloc

type variables

decimal workOrderDetailBOMLine

n_cst_shopfloortrans ShopFloorTrans

end variables

forward prototypes
public subroutine showactivebom ()
public subroutine showallbom ()
public subroutine showactivematerials ()
public subroutine showallmaterials ()
end prototypes

public subroutine showactivebom ();
long inactiveStatus
inactiveStatus = ShopFloorTrans.StatusValue("dbo.WorkOrderDetailBillOfMaterials", "Not Used")
dw_1.SetFilter("bomstatus <> " + String(inactiveStatus))
dw_1.Filter()
dw_1.Sort()
dw_1.SetRow(1)
cb_showactive.Visible = false
cb_showall.Visible = true

end subroutine

public subroutine showallbom ();
dw_1.SetFilter("")
dw_1.Filter()
dw_1.Sort()
dw_1.SetRow(1)
cb_showall.Visible = false
cb_showactive.Visible = true

end subroutine

public subroutine showactivematerials ();
long inactiveStatus
inactiveStatus = ShopFloorTrans.StatusValue("dbo.WorkOrderDetailMaterialAllocations", "Completed")
dw_serials.SetFilter("status <> " + String(inactiveStatus))
dw_serials.Filter()
dw_serials.Sort()
dw_serials.SetRow(1)
cb_showactive2.Visible = false
cb_showall2.Visible = true

end subroutine

public subroutine showallmaterials ();
dw_serials.SetFilter("")
dw_serials.Filter()
dw_serials.Sort()
dw_serials.SetRow(1)
cb_showall2.Visible = false
cb_showactive2.Visible = true

end subroutine

on u_tabpg_ppimoldingshopfloormaterialalloc.create
int iCurrent
call super::create
this.st_splitbar1=create st_splitbar1
this.uo_rowselector2=create uo_rowselector2
this.gb_2=create gb_2
this.dw_serials=create dw_serials
this.cb_scan=create cb_scan
this.cb_next=create cb_next
this.cb_endalloc=create cb_endalloc
this.cb_showactive=create cb_showactive
this.cb_showall=create cb_showall
this.cb_showall2=create cb_showall2
this.cb_showactive2=create cb_showactive2
this.cb_printpicklist=create cb_printpicklist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_splitbar1
this.Control[iCurrent+2]=this.uo_rowselector2
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_serials
this.Control[iCurrent+5]=this.cb_scan
this.Control[iCurrent+6]=this.cb_next
this.Control[iCurrent+7]=this.cb_endalloc
this.Control[iCurrent+8]=this.cb_showactive
this.Control[iCurrent+9]=this.cb_showall
this.Control[iCurrent+10]=this.cb_showall2
this.Control[iCurrent+11]=this.cb_showactive2
this.Control[iCurrent+12]=this.cb_printpicklist
end on

on u_tabpg_ppimoldingshopfloormaterialalloc.destroy
call super::destroy
destroy(this.st_splitbar1)
destroy(this.uo_rowselector2)
destroy(this.gb_2)
destroy(this.dw_serials)
destroy(this.cb_scan)
destroy(this.cb_next)
destroy(this.cb_endalloc)
destroy(this.cb_showactive)
destroy(this.cb_showall)
destroy(this.cb_showall2)
destroy(this.cb_showactive2)
destroy(this.cb_printpicklist)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_parent.X + gb_parent.Width, gb_parent.Y + cb_next.Y + cb_next.Height)
inv_Resize.of_Register(st_splitbar1, 0, 100, 100, 0)
inv_Resize.of_Register(dw_serials, 0, 100, 100, 0)
inv_Resize.of_Register(gb_2, 0, 100, 100, 0)
inv_Resize.of_Register(cb_showactive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_showall, 100, 0, 0, 0)
inv_Resize.of_Register(cb_printpicklist, 100, 0, 0, 0)
inv_Resize.of_Register(cb_showactive2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_showall2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_scan, 100, 0, 0, 0)
inv_Resize.of_Register(cb_endalloc, 100, 0, 0, 0)
inv_Resize.of_Register(cb_next, 100, 100, 0, 0)

ShowAllBOM()
ShowActiveMaterials()

//	Listen for serial allocations.
gnv_App.inv_StateMSGRouter.Register(String(WindowHandle) + ".SerialAllocated", this, false)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event pfd_event;call super::pfd_event;
choose case eventName
	case String(WindowHandle) + ".SerialAllocated"
		RefreshNotify()
end choose

end event

event destructor;call super::destructor;
destroy ShopFloorTrans

end event

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloormaterialalloc
integer y = 364
string text = "Materials"
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloormaterialalloc
integer y = 444
string dataobject = "d_ppimolding_bomalloc"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber, WorkOrderDetailSequence)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then return

workOrderDetailLine = object.wodline[activerow]
workOrderDetailBOMLine = object.bomline[activerow]
dw_serials.event pfc_Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get status codes.
datawindowchild statusDWC
if	GetChild("BOMStatus", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve(StatusTypeTable) <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

//	Get type codes.
datawindowchild typeDWC
if	GetChild("BOMType", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve(StatusTypeTable) <= 0 then
		typeDWC.InsertRow(0)
	end if
end if

end event

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloormaterialalloc
integer width = 2295
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloormaterialalloc
integer width = 2309
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloormaterialalloc
integer y = 1328
end type

type st_splitbar1 from u_st_splitbar within u_tabpg_ppimoldingshopfloormaterialalloc
integer y = 1448
integer width = 1751
boolean bringtotop = true
end type

event constructor;call super::constructor;
of_Register(gb_1, ABOVE)
of_Register(dw_1, ABOVE)
of_Register(gb_2, BELOW)
of_Register(dw_serials, BELOW)


end event

type uo_rowselector2 from u_rowselector within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 5
integer y = 1988
integer height = 112
integer taborder = 21
boolean bringtotop = true
end type

on uo_rowselector2.destroy
call u_rowselector::destroy
end on

type gb_2 from groupbox within u_tabpg_ppimoldingshopfloormaterialalloc
integer y = 1468
integer width = 1751
integer height = 640
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Serials"
end type

type dw_serials from u_dw within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 5
integer y = 1544
integer width = 1737
integer height = 444
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ppimolding_allocations"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event resize;call super::resize;
uo_rowselector2.Y = Y + Height
cb_showactive2.Y = Y
cb_showall2.Y = Y
cb_scan.Y = Y + cb_showall2.Height + 20
cb_endalloc.Y = cb_scan.Y + cb_scan.Height + 20

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get status codes.
datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("dbo.WorkOrderDetailMaterialAllocations") <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

//	Get type codes.
datawindowchild typeDWC
if	GetChild("Type", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve("dbo.WorkOrderDetailMaterialAllocations") <= 0 then
		typeDWC.InsertRow(0)
	end if
end if

//	Turn on the PowerFilter service.
SetPowerFilter(true)
PowerFilter.of_SetDW(this)

//	Turn on the sort service
of_SetSort (true)
inv_sort.of_SetStyle(inv_sort.DRAGDROP)
inv_Sort.SetColumnHeaderExt (true)

//	Turn on the filter service
of_SetFilter (true)
inv_filter.of_SetStyle(inv_filter.EXTENDED)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

end event

event pfc_retrieve;call super::pfc_retrieve;
return retrieve(WorkOrderNumber, WorkOrderDetailLine, WorkOrderDetailBOMLine)

end event

event dwlbuttonup;call super::dwlbuttonup;
PowerFilter.event post ue_buttonclicked(dwo.Type, dwo.Name)

end event

type cb_scan from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 1608
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
string text = "Scan..."
end type

event clicked;
long null; setnull(null)
message.inv_Parm.of_SetItem("WorkOrderNumber", WorkOrderNumber)
message.inv_Parm.of_SetItem("WorkOrderDetailSequence", WorkOrderDetailSequence)
message.inv_Parm.of_SetItem("Suffix", null)
message.inv_Parm.of_SetItem("ParentWindowHandle", WindowHandle)
open (w_ppimoldingallocserial)

end event

type cb_next from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 1996
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

type cb_endalloc from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 1736
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
string text = "End Alloc..."
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Open dialog to end allocation...
long serial
serial = dw_serials.object.serial[dw_serials.GetRow()]
message.inv_Parm.of_SetItem("WorkOrderNumber", WorkOrderNumber)
message.inv_Parm.of_SetItem("WorkOrderDetailLine", workOrderDetailLine)
message.inv_Parm.of_SetItem("WorkOrderDetailBOMLine", workOrderDetailBOMLine)
message.inv_Parm.of_SetItem("Serial", serial)
open (w_ppimoldingendallocserial)

//	Check return value...
if	message.DoubleParm = CONTINUE_ACTION then
	
	//	Get the empty flag,  remaining quantity, and change reason.
	int isEmpty
	decimal estimatedQtyRemaining
	string changeReason
	isEmpty = message.inv_Parm.of_GetItem("IsEmpty")
	estimatedQtyRemaining = message.inv_Parm.of_GetItem("EstimatedQtyRemaining")
	changeReason = message.inv_Parm.of_GetItem("ChangeReason")
	
	//	End allocation.
	int suffix; setNull(suffix)
	ShopFloorTrans.EndSerialAllocation(serial, WorkOrderNumber, WorkOrderDetailSequence, suffix, isEmpty = 1, EstimatedQtyRemaining, ChangeReason)
end if

RefreshNotify()

end event

type cb_showactive from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 364
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
string text = "Show Active"
end type

event clicked;
ShowActiveBOM()

end event

type cb_showall from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 492
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
string text = "Show All"
end type

event clicked;
ShowAllBOM()

end event

type cb_showall2 from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 1480
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
string text = "Show All"
end type

event clicked;
ShowAllMaterials()

end event

type cb_showactive2 from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 1480
integer width = 407
integer height = 112
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show Active"
end type

event clicked;
ShowActiveMaterials()

end event

type cb_printpicklist from commandbutton within u_tabpg_ppimoldingshopfloormaterialalloc
integer x = 1806
integer y = 620
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
string text = "Print Picklist..."
end type

event clicked;
message.inv_Parm.of_SetItem("WorkOrderNumber", WorkOrderNumber)
message.inv_Parm.of_SetItem("WorkOrderDetailSequence", WorkOrderDetailSequence)
open (w_ppimoldingprintpicklist)

end event

