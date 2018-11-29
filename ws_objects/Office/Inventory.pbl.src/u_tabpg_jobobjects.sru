$PBExportHeader$u_tabpg_jobobjects.sru
forward
global type u_tabpg_jobobjects from u_tabpg_dwchild
end type
type cb_correct from commandbutton within u_tabpg_jobobjects
end type
type cb_relabel from commandbutton within u_tabpg_jobobjects
end type
end forward

global type u_tabpg_jobobjects from u_tabpg_dwchild
integer width = 2414
string text = "Job Objects"
cb_correct cb_correct
cb_relabel cb_relabel
end type
global u_tabpg_jobobjects u_tabpg_jobobjects

type variables

long WODID
n_cst_mes_inventorytrans InventoryTrans

end variables

on u_tabpg_jobobjects.create
int iCurrent
call super::create
this.cb_correct=create cb_correct
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_correct
this.Control[iCurrent+2]=this.cb_relabel
end on

on u_tabpg_jobobjects.destroy
call super::destroy
destroy(this.cb_correct)
destroy(this.cb_relabel)
end on

event pfd_event;call super::pfd_event;
//Refactor: State messages are failing with multiple subscribers to the same event.
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
//choose case EventName
//	case String(windowHandle)+".MasterDWO"
//		Refreshing = (WODID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.wodid"), -1))
//		WODID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.wodid"), -1)
//		Refresh()
//end choose

end event

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_relabel.X + (cb_relabel.X - gb_1.X - gb_1.Width) + cb_relabel.Width, gb_parent.Y + gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)
inv_Resize.of_Register(cb_correct, 100, 0, 0, 0)

//Refactor: State messages are failing with multiple subscribers to the same event.
//Descendents (detail)
//Register for notification to changes in the master.
//e.g.
//masterDWOName[1] = String(windowHandle)+".MasterDWO.wodid"
//gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

InventoryTrans = create n_cst_mes_inventorytrans

end event

event destructor;call super::destructor;
destroy InventoryTrans

end event

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_jobobjects
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_jobobjects
string dataobject = "d_dbo_mes_jobobjects"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WODID)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	cb_correct.enabled = false
	cb_relabel.enabled = false
	return
end if
cb_correct.enabled = true
cb_relabel.enabled = true

datawindowchild packageTypesDWC
if	GetChild("PackageType", packageTypesDWC) = 1 then
	packageTypesDWC.SetTransObject(SQLCA)
	packageTypesDWC.Retrieve(object.PartCode[activerow])
end if

end event

event dw_1::itemchanged;call super::itemchanged;
long	selectedRow = 0
choose case lower(dwo.name)
	case "quantity"
		decimal quantities[]; quantities = dw_1.object.Quantity.Selected;
		
		if UpperBound(quantities) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.Quantity[selectedRow] = dec(data)
			loop
		end if
	case "packagetype"
		string packageTypes[]; packageTypes = dw_1.object.PackageType.Selected;
		
		if UpperBound(packageTypes) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.PackageType[selectedRow] = data
			loop
		end if
	case "boxlabelformat"
		string boxLabelFormats[]; boxLabelFormats = dw_1.object.BoxLabelFormat.Selected;
		
		if UpperBound(boxLabelFormats) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.BoxLabelFormat[selectedRow] = data
			loop
		end if
	case "lotnumber"
		string lotNumbers[]; lotNumbers = dw_1.object.LotNumber.Selected;
		
		if UpperBound(lotNumbers) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.LotNumber[selectedRow] = data
			loop
		end if
end choose

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then
	SetRow(row)
end if

end event

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_jobobjects
string dataobject = "d_dbo_mes_joblist"
end type

event dw_parent::rowchanged;call super::rowchanged;
if	rowcount() > 0 then
	Refreshing = (WODID = object.wodid[1])
	WODID = object.wodid[1]
	Refresh()
end if

end event

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_jobobjects
string text = "Job Row"
end type

type cb_correct from commandbutton within u_tabpg_jobobjects
boolean visible = false
integer x = 1810
integer y = 436
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
string text = "Correct Box"
end type

event clicked;//
//dw_1.AcceptText()
//int jobRow
//jobRow = dw_1.GetRow()
//if	jobRow <= 0 then
//	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
//	return
//end if
//
//long jobID, firstNewSerial
//int boxes
//decimal {6} qtyToLabel, standardPack
//string packageCode, boxLabelFormat
//
//jobID = dw_1.object.WODID[jobRow]
//qtyToLabel = dw_1.object.NewQtyToLabel[jobRow]
//standardPack = dw_1.object.StandardPack[jobRow]
//packageCode = dw_1.object.PackageType[jobRow]
//boxes = dw_1.object.NewBoxesRequired[jobRow] //Ignored by procedure but returned.
//boxLabelFormat = dw_1.object.BoxLabelFormat[jobRow]
//if	InventoryTrans.NewPreObjects (jobID, qtyToLabel, standardPack, packageCode, firstNewSerial, boxes) = SUCCESS then
//	if	cbx_print.Checked then
//		long	boxSerialNumber
//		for	boxSerialNumber = firstNewSerial to firstNewSerial + boxes - 1
//			//Print Labels
//			n_cst_associative_array	printerParm
//			printerParm.of_SetItem ( "Arg1", boxSerialNumber)
//			printerParm.of_SetItem ( "Report", "Label" )
//			printerParm.of_SetItem ( "Name", boxLabelFormat )
//			Print(printerParm)
//		next
//	else
//		//mbox()
//	end if
//end if
//
//Refresh()
//
//
end event

type cb_relabel from commandbutton within u_tabpg_jobobjects
integer x = 1810
integer y = 296
integer width = 489
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Relabel"
end type

event clicked;
long procResult
long selectedRow = 0

int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long boxSerialNumber
		boxSerialNumber = dw_1.object.Serial[i]
		if	dw_1.GetItemStatus(selectedRow, 0, Primary!) = DataModified! then
			long jobID
			decimal {6} quantity
			string packageCode, lotNumber
			
			jobID = dw_1.object.WODID[i]
			quantity = dw_1.object.Quantity[i]
			packageCode = dw_1.object.PackageType[i]
			lotNumber = dw_1.object.LotNumber[i]
			if	InventoryTrans.CorrectPreObject (jobID, quantity, packageCode, lotNumber, boxSerialNumber) <> SUCCESS then
				continue
			end if
		end if
		
		//Open pre-objects
		InventoryTrans.OpenPreObject (boxSerialNumber)
		
		//Print Labels
		string boxLabelFormat
		boxLabelFormat = dw_1.object.BoxLabelFormat[i]
		if	boxLabelFormat > "" then
			n_cst_associative_array	printerParm
			printerParm.of_SetItem ( "Arg1", boxSerialNumber)
			printerParm.of_SetItem ( "Report", "Label" )
			printerParm.of_SetItem ( "Name", boxLabelFormat )
			Print(printerParm)
		end if
		
		//Close pre-objects
		InventoryTrans.ClosePreObject (boxSerialNumber)
	end if
next

end event

