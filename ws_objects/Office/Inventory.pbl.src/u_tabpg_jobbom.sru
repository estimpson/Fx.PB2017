$PBExportHeader$u_tabpg_jobbom.sru
forward
global type u_tabpg_jobbom from u_tabpg_dwchild
end type
type cb_substitute from commandbutton within u_tabpg_jobbom
end type
type cb_deletesub from commandbutton within u_tabpg_jobbom
end type
type cb_resetbom from commandbutton within u_tabpg_jobbom
end type
end forward

global type u_tabpg_jobbom from u_tabpg_dwchild
integer width = 2414
integer height = 1968
string text = "Job Bill of Material"
cb_substitute cb_substitute
cb_deletesub cb_deletesub
cb_resetbom cb_resetbom
end type
global u_tabpg_jobbom u_tabpg_jobbom

type variables

long WODID
n_cst_mes_inventorytrans InventoryTrans

end variables

on u_tabpg_jobbom.create
int iCurrent
call super::create
this.cb_substitute=create cb_substitute
this.cb_deletesub=create cb_deletesub
this.cb_resetbom=create cb_resetbom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_substitute
this.Control[iCurrent+2]=this.cb_deletesub
this.Control[iCurrent+3]=this.cb_resetbom
end on

on u_tabpg_jobbom.destroy
call super::destroy
destroy(this.cb_substitute)
destroy(this.cb_deletesub)
destroy(this.cb_resetbom)
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
inv_Resize.of_SetOrigSize(cb_resetbom.X + (cb_resetbom.X - gb_1.X - gb_1.Width) + cb_resetbom.Width, gb_parent.Y + gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_resetbom, 100, 0, 0, 0)
inv_Resize.of_Register(cb_substitute, 100, 0, 0, 0)
inv_Resize.of_Register(cb_deletesub, 100, 0, 0, 0)

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

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_jobbom
integer y = 248
string text = "Job BOM"
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_jobbom
integer y = 324
string dataobject = "d_dbo_mes_jobbillofmaterials"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WODID)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

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

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	return
end if

long	subForRowID
subForRowID = IsNull(object.SubForRowID[activerow], -1)
cb_deletesub.enabled = subForRowID > 0

end event

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_jobbom
string dataobject = "d_dbo_mes_joblist"
end type

event dw_parent::rowchanged;call super::rowchanged;
if	rowcount() > 0 then
	Refreshing = (WODID = object.wodid[1])
	WODID = object.wodid[1]
	Refresh()
end if

end event

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_jobbom
string text = "Job Row"
end type

type cb_substitute from commandbutton within u_tabpg_jobbom
integer x = 1810
integer y = 428
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
string text = "Substitute..."
end type

event clicked;
int bomRow
bomRow = dw_1.GetRow()
if	bomRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

//	Open dialog to create/edit BOM substitute:
long jobID, bomID
jobID = dw_1.object.WODID[bomRow]
bomID = isnull(dw_1.object.SubForRowID[bomRow], dw_1.object.WODBOMID[bomRow])
message.inv_Parm.of_SetItem("JobID", jobID)
message.inv_Parm.of_SetItem("BomID", bomID)
open(w_mes_substitutematerial)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the substitute part and substitution rate.
	string substitutePart
	decimal substitutionRate
	substitutePart = message.inv_Parm.of_GetItem("SubstitutePart")
	substitutionRate = message.inv_Parm.of_GetItem("SubstitutionRate")
	
	//	Create substitution.
	InventoryTrans.SetSubstituteMaterial(bomID, substitutePart, substitutionRate)
end if

Refreshing=true;
Refresh()

end event

type cb_deletesub from commandbutton within u_tabpg_jobbom
integer x = 1810
integer y = 560
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
boolean enabled = false
string text = "Delete Substitute"
end type

event clicked;
//	Get the substitute part and substitution rate.
long primaryBOMID
string substitutePart; setNull(substitutePart)
decimal substitutionRate = -1

//	Create substitution.
primaryBOMID = dw_1.object.SubForRowID[dw_1.getrow()]
InventoryTrans.SetSubstituteMaterial(primaryBOMID, substitutePart, substitutionRate)

Refreshing=true
Refresh()

end event

type cb_resetbom from commandbutton within u_tabpg_jobbom
integer x = 1810
integer y = 20
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
string text = "Reset BOM..."
end type

event clicked;
//	Reset job BOM.
InventoryTrans.ResetJobBOM(WODID)

Refreshing=true
Refresh()

end event

