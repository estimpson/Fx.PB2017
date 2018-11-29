$PBExportHeader$u_tabpg_ppimoldingschedulemachinejobs.sru
forward
global type u_tabpg_ppimoldingschedulemachinejobs from u_tabpg_dw
end type
end forward

global type u_tabpg_ppimoldingschedulemachinejobs from u_tabpg_dw
integer width = 1977
string text = "Job Schedule"
end type
global u_tabpg_ppimoldingschedulemachinejobs u_tabpg_ppimoldingschedulemachinejobs

type variables

boolean Refreshing

long windowHandle

string MachineCode

datawindowchild MoldingMachinesDWC, MoldingToolsDWC
end variables

forward prototypes
public function integer save ()
end prototypes

public function integer save ();
integer updateReturn
dw_1.AcceptText()
updateReturn = dw_1.Update(true)
if	updateReturn = 1 then
	commit;
else
	msgBox("Save Failed!")
end if
return	updateReturn

end function

event constructor;call super::constructor;
//	Get necessary notifications.
windowHandle = Handle(GetParent().GetParent())
gnv_App.inv_StateMSGRouter.of_RequestNotification(this, String(windowHandle)+'.MasterDWO')

end event

on u_tabpg_ppimoldingschedulemachinejobs.create
call super::create
end on

on u_tabpg_ppimoldingschedulemachinejobs.destroy
call super::destroy
end on

event pfd_event;call super::pfd_event;
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (MachineCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO"))
		MachineCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO")
		Refresh()
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_ppimoldingschedulemachinejobs
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_ppimoldingschedulemachinejobs
string dataobject = "d_ppi_moldingschedulemachinejobs"
end type

event dw_1::constructor;call super::constructor;
//	Setup dropdowns.
//	Molding machines
GetChild("machinecode", MoldingMachinesDWC)
MoldingMachinesDWC.SetTransObject(SQLCA)

//	Molding tools.
GetChild("toolcode", MoldingToolsDWC)
MoldingToolsDWC.SetTransObject(SQLCA)

of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)

of_SetDropDownNotes(true)
iuo_Notes.of_Register("notes", iuo_Notes.DDLB)


end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(MachineCode)

end event

event dw_1::buttonclicked;call super::buttonclicked;
if row <= 0 then return

int originalSequence
choose case dwo.name
	case "b_up"
		SetRedraw(false)
		originalSequence = dw_1.object.sequence[row]
		object.sequence[row] = originalSequence - 1
		object.sequence[row - 1] = originalSequence
		Sort()
		SetRedraw(true)
		SetRow(row - 1)
	case "b_down"
		SetRedraw(false)
		originalSequence = dw_1.object.sequence[row]
		object.sequence[row] = originalSequence + 1
		object.sequence[row + 1] = originalSequence
		Sort()
		SetRedraw(true)
		SetRow(row + 1)
end choose

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
if	currentRow > 0 then
	//	Retrieve drop down
	MoldingToolsDWC.Retrieve (object.PartCode[CurrentRow])
end if

end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	//	Retrieve drop down
	MoldingToolsDWC.Retrieve (object.PartCode[GetRow()])
end if

end event

