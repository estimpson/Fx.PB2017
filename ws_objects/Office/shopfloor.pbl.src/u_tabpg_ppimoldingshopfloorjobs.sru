$PBExportHeader$u_tabpg_ppimoldingshopfloorjobs.sru
forward
global type u_tabpg_ppimoldingshopfloorjobs from u_tabpg_dw
end type
type cb_complete from commandbutton within u_tabpg_ppimoldingshopfloorjobs
end type
type cb_onhold from commandbutton within u_tabpg_ppimoldingshopfloorjobs
end type
type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloorjobs
end type
type cb_open from commandbutton within u_tabpg_ppimoldingshopfloorjobs
end type
type cb_start from commandbutton within u_tabpg_ppimoldingshopfloorjobs
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobs from u_tabpg_dw
integer width = 2263
string text = "Job Schedule"
cb_complete cb_complete
cb_onhold cb_onhold
uo_rowcontrol uo_rowcontrol
cb_open cb_open
cb_start cb_start
end type
global u_tabpg_ppimoldingshopfloorjobs u_tabpg_ppimoldingshopfloorjobs

type variables

string MachineCode

n_cst_shopfloortrans ShopFloorTrans

end variables

forward prototypes
public subroutine enablefunctions (integer _rowstatus)
end prototypes

public subroutine enablefunctions (integer _rowstatus);
choose case _rowStatus
	case 0
		cb_start.enabled = true
		cb_complete.enabled = true
		cb_onhold.enabled = true
		cb_open.enabled = false
	case 1
		cb_start.enabled = false
		cb_complete.enabled = true
		cb_onhold.enabled = true
		cb_open.enabled = false
	case 2
		cb_start.enabled = true
		cb_complete.enabled = false
		cb_onhold.enabled = true
		cb_open.enabled = true
	case 3
		cb_start.enabled = false
		cb_complete.enabled = false
		cb_onhold.enabled = false
		cb_open.enabled = false
	case -1
		cb_start.enabled = true
		cb_complete.enabled = true
		cb_onhold.enabled = false
		cb_open.enabled = true
	case -2
		cb_start.enabled = true
		cb_complete.enabled = true
		cb_onhold.enabled = true
		cb_open.enabled = false
	case else
		cb_start.enabled = false
		cb_complete.enabled = false
		cb_onhold.enabled = false
		cb_open.enabled = false
end choose

end subroutine

on u_tabpg_ppimoldingshopfloorjobs.create
int iCurrent
call super::create
this.cb_complete=create cb_complete
this.cb_onhold=create cb_onhold
this.uo_rowcontrol=create uo_rowcontrol
this.cb_open=create cb_open
this.cb_start=create cb_start
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_complete
this.Control[iCurrent+2]=this.cb_onhold
this.Control[iCurrent+3]=this.uo_rowcontrol
this.Control[iCurrent+4]=this.cb_open
this.Control[iCurrent+5]=this.cb_start
end on

on u_tabpg_ppimoldingshopfloorjobs.destroy
call super::destroy
destroy(this.cb_complete)
destroy(this.cb_onhold)
destroy(this.uo_rowcontrol)
destroy(this.cb_open)
destroy(this.cb_start)
end on

event constructor;call super::constructor;
//	Setup resize.
inv_Resize.of_SetOrigSize(cb_start.X + (cb_start.X - gb_1.X - gb_1.Width) + cb_start.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_start, 100, 0, 0, 0)
inv_Resize.of_Register(cb_open, 100, 0, 0, 0)
inv_Resize.of_Register(cb_complete, 100, 0, 0, 0)
inv_Resize.of_Register(cb_onhold, 100, 0, 0, 0)
inv_Resize.of_Register(uo_rowcontrol, 0, 100, 0, 0)

//	Register for notification to changes in the master.
masterDWOName[1] = String(windowHandle)+".MasterDWO.machinecode"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event pfd_event;call super::pfd_event;
//	Handle notification to changes in the master.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (MachineCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.machinecode"))
		MachineCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.machinecode")
		Refresh()
end choose

end event

event destructor;call super::destructor;
destroy ShopFloorTrans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_ppimoldingshopfloorjobs
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_ppimoldingshopfloorjobs
integer height = 880
string dataobject = "d_ppimoldingjobschedule"
end type

event dw_1::constructor;call super::constructor;
//	Get status codes.
datawindowchild statusDWC
if	GetChild("status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("dbo.WorkOrderHeaders") <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

//	Get type codes.
datawindowchild typeDWC
if	GetChild("type", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve("dbo.WorkOrderHeaders") <= 0 then
		typeDWC.InsertRow(0)
	end if
end if

of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)

of_SetDropDownNotes(true)
iuo_Notes.of_Register("notes", iuo_Notes.DDLB)


end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(MachineCode)

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
if	currentrow > 0 then
	EnableFunctions(object.Status[currentRow])
end if

end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	EnableFunctions(object.Status[GetRow()])
end if

end event

event dw_1::activerowchanged;call super::activerowchanged;
uo_RowControl.CurrentRow(activerow)

end event

type cb_complete from commandbutton within u_tabpg_ppimoldingshopfloorjobs
integer x = 1806
integer y = 264
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Complete Job"
end type

type cb_onhold from commandbutton within u_tabpg_ppimoldingshopfloorjobs
integer x = 1806
integer y = 392
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Put Job On Hold"
end type

type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloorjobs
integer x = 5
integer y = 964
integer height = 112
integer taborder = 80
boolean bringtotop = true
end type

event constructor;call super::constructor;
SetRequestor(dw_1)

end event

on uo_rowcontrol.destroy
call u_rowselector::destroy
end on

type cb_open from commandbutton within u_tabpg_ppimoldingshopfloorjobs
integer x = 1806
integer y = 136
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Open Job"
end type

type cb_start from commandbutton within u_tabpg_ppimoldingshopfloorjobs
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Start Job"
end type

event clicked;
if	dw_1.RowCount() <= 0 then
	return
end if

//	Check return value...
if	MsgBox("Please review the following job details and click Yes to start the job or No to cancel:~r~n~r~n"+ &
		"Work Order Number: " + dw_1.object.workordernumber[dw_1.getrow()] + "~r~n" +&
		"Part: " + dw_1.object.partcode[dw_1.getrow()], Question!, YesNo!, 2) = 1 then
	
	string	workOrderNumber
	long workOrderDetailSequence
	workOrderNumber = dw_1.object.workordernumber[dw_1.getrow()]
	workOrderDetailSequence = dw_1.object.workorderdetailsequence[dw_1.getrow()]
	
	//	Restore material.
	ShopFloorTrans.StartJobSetup(workOrderNumber, workOrderDetailSequence)
end if

RefreshNotify()

end event

