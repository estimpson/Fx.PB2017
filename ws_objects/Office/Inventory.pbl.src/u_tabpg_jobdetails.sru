$PBExportHeader$u_tabpg_jobdetails.sru
forward
global type u_tabpg_jobdetails from u_tabpg_dw
end type
type cb_generate from commandbutton within u_tabpg_jobdetails
end type
type cbx_print from checkbox within u_tabpg_jobdetails
end type
type cb_manualjob from commandbutton within u_tabpg_jobdetails
end type
type cb_closejob from commandbutton within u_tabpg_jobdetails
end type
type cb_movejob from commandbutton within u_tabpg_jobdetails
end type
end forward

global type u_tabpg_jobdetails from u_tabpg_dw
integer width = 2341
string text = "Job Details"
cb_generate cb_generate
cbx_print cbx_print
cb_manualjob cb_manualjob
cb_closejob cb_closejob
cb_movejob cb_movejob
end type
global u_tabpg_jobdetails u_tabpg_jobdetails

type variables

string MachineCode
n_cst_mes_inventorytrans InventoryTrans

end variables

on u_tabpg_jobdetails.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.cbx_print=create cbx_print
this.cb_manualjob=create cb_manualjob
this.cb_closejob=create cb_closejob
this.cb_movejob=create cb_movejob
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.cbx_print
this.Control[iCurrent+3]=this.cb_manualjob
this.Control[iCurrent+4]=this.cb_closejob
this.Control[iCurrent+5]=this.cb_movejob
end on

on u_tabpg_jobdetails.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.cbx_print)
destroy(this.cb_manualjob)
destroy(this.cb_closejob)
destroy(this.cb_movejob)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_generate.X + (cb_generate.X - gb_1.X - gb_1.Width) + cb_generate.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_generate, 100, 0, 0, 0)
inv_Resize.of_Register(cbx_print, 100, 0, 0, 0)
inv_Resize.of_Register(cb_manualjob, 100, 0, 0, 0)
inv_Resize.of_Register(cb_closejob, 100, 0, 0, 0)
inv_Resize.of_Register(cb_movejob, 100, 0, 0, 0)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.WODID

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.machinecode"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

InventoryTrans = create n_cst_mes_inventorytrans

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (MachineCode = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.machinecode"), ""))
		MachineCode = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.machinecode"), "")
		Refresh()
end choose

end event

event destructor;call super::destructor;
destroy InventoryTrans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_jobdetails
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_jobdetails
string dataobject = "d_dbo_mes_joblist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(false)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(MachineCode)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	cb_generate.enabled = false
	return
end if
cb_generate.enabled = true

datawindowchild packageTypesDWC
if	GetChild("PackageType", packageTypesDWC) = 1 then
	packageTypesDWC.SetTransObject(SQLCA)
	packageTypesDWC.Retrieve(object.PartCode[activerow])
end if

end event

event dw_1::itemchanged;call super::itemchanged;
decimal standardPack, newQtyToLabel, newBoxesRequired
string	packageType
choose case lower(dwo.Name)
	case lower("NewQtyToLabel")
		packageType = object.PackageType[row]
		standardPack = object.StandardPack[row]
		newQtyToLabel = dec(data)
		newBoxesRequired = round(newQtyToLabel / standardPack, 2)
	case lower("PackageType")
		packageType = data
		
		datawindowchild packageTypesDWC
		if	GetChild("PackageType", packageTypesDWC) = 1 then
			long packageTypeRow
			packageTypeRow = packageTypesDWC.GetRow()
			standardPack = packageTypesDWC.GetItemNumber(packageTypeRow, "StandardPack")
		end if
		newQtyToLabel = object.NewQtyToLabel[row]
		newBoxesRequired = round(newQtyToLabel / standardPack, 2)
	case lower("StandardPack")
		packageType = object.PackageType[row]
		standardPack = dec(data)
		newQtyToLabel = object.NewQtyToLabel[row]
		newBoxesRequired = round(newQtyToLabel / standardPack, 2)
	case lower("NewBoxesRequired")
		packageType = object.PackageType[row]
		standardPack = object.StandardPack[row]
		newBoxesRequired = dec(data)
		newQtyToLabel = newBoxesRequired * standardPack
	case else
		return
//		packageType = object.PackageType[row]
//		standardPack = object.StandardPack[row]
//		newBoxesRequired = object.NewBoxesRequired[row]
//		newQtyToLabel =object.NewQtyToLabel[row]
end choose
object.NewQtyToLabel[row] = newQtyToLabel
object.PackageType[row] = packageType
object.StandardPack[row] = standardPack
object.NewBoxesRequired[row] = newBoxesRequired
end event

event dw_1::clicked;call super::clicked;
if	row > 0 then
	SetRow(row)
end if

end event

type cb_generate from commandbutton within u_tabpg_jobdetails
integer x = 1810
integer y = 60
integer width = 489
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate Serials"
end type

event clicked;
dw_1.AcceptText()
int jobRow
jobRow = dw_1.GetRow()
if	jobRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long jobID, firstNewSerial
int boxes
decimal {6} qtyToLabel, standardPack
string packageCode, lotNumber, boxLabelFormat

jobID = dw_1.object.WODID[jobRow]
qtyToLabel = dw_1.object.NewQtyToLabel[jobRow]
standardPack = dw_1.object.StandardPack[jobRow]
packageCode = dw_1.object.PackageType[jobRow]
lotNumber = dw_1.object.LotNumber[jobRow]
boxes = dw_1.object.NewBoxesRequired[jobRow] //Ignored by procedure but returned.
boxLabelFormat = dw_1.object.BoxLabelFormat[jobRow]
if	InventoryTrans.NewPreObjects (jobID, qtyToLabel, standardPack, packageCode, lotNumber, firstNewSerial, boxes) = SUCCESS then
	if	cbx_print.Checked then
		long	boxSerialNumber
		for	boxSerialNumber = firstNewSerial to firstNewSerial + boxes - 1
			//Open pre-objects
			InventoryTrans.OpenPreObject (boxSerialNumber)
			
			//Print Labels
			n_cst_associative_array	printerParm
			printerParm.of_SetItem ( "Arg1", boxSerialNumber)
			printerParm.of_SetItem ( "Report", "Label" )
			printerParm.of_SetItem ( "Name", boxLabelFormat )
			Print(printerParm)
			
			//Close pre-objects
			InventoryTrans.ClosePreObject (boxSerialNumber)
		next
	else
		//mbox()
	end if
end if

Refreshing=true
Refresh()


end event

type cbx_print from checkbox within u_tabpg_jobdetails
integer x = 1851
integer y = 204
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Print Labels"
boolean checked = true
end type

type cb_manualjob from commandbutton within u_tabpg_jobdetails
integer x = 1810
integer y = 312
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
string text = "Manual Job..."
end type

event clicked;

//	Open dialog to create/edit BOM substitute:
message.inv_Parm.of_SetItem("Machine", MachineCode)
open(w_mes_manualjob)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the substitute part and substitution rate.
	string partCode
	string billToCode
	string machineCodeManualJob
	string nullString; SetNull(nullString)
	decimal buildQty
	datetime dueDT
	partCode = isnull(message.inv_Parm.of_GetItem("Part"), nullString)
	billToCode = isnull(message.inv_Parm.of_GetItem("BillTo"), nullString)
	buildQty = isnull(message.inv_Parm.of_GetItem("BuildQty"), -1)
	machineCodeManualJob = isnull(message.inv_Parm.of_GetItem("Machine"), nullString)
	dueDT = isnull(message.inv_Parm.of_GetItem("DueDT"), DateTime(Date("1900-01-01")))
	
	//	Create substitution.
	string manualWorkOrderNumber
	InventoryTrans.ScheduleManualJob(manualWorkOrderNumber, partCode, billtoCode, machineCodeManualJob, buildQty, dueDT)
end if

Refreshing=true;
Refresh()

end event

type cb_closejob from commandbutton within u_tabpg_jobdetails
integer x = 1810
integer y = 444
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
string text = "Close Job..."
end type

event clicked;
dw_1.AcceptText()
int jobRow
jobRow = dw_1.GetRow()
if	jobRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long jobID
jobID = dw_1.object.WODID[jobRow]

if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to close this job?", Question!, YesNo!, 2) = 1 then
	InventoryTrans.CloseJob (jobID)
end if


Refreshing=true
Refresh()


end event

type cb_movejob from commandbutton within u_tabpg_jobdetails
integer x = 1810
integer y = 576
integer width = 489
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Move Job..."
end type

event clicked;
dw_1.AcceptText()
int jobRow
jobRow = dw_1.GetRow()
if	jobRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long jobID
jobID = dw_1.object.WODID[jobRow]

//	Open dialog to create/edit BOM substitute:
message.inv_Parm.of_SetItem("JobID", jobID)
open(w_mes_movejob)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the selected new machine.
	string newMachineCode
	string nullString; SetNull(nullString)
	newMachineCode = isnull(message.inv_Parm.of_GetItem("NewMachine"), nullString)
	
	InventoryTrans.MoveJob(jobID, newMachineCode)
end if

Refreshing=true;
Refresh()


end event

