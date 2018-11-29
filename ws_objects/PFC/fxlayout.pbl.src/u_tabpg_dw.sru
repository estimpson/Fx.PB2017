$PBExportHeader$u_tabpg_dw.sru
forward
global type u_tabpg_dw from u_tabpg_4t
end type
type dw_1 from u_fxdw within u_tabpg_dw
end type
end forward

global type u_tabpg_dw from u_tabpg_4t
event pfc_new ( )
dw_1 dw_1
end type
global u_tabpg_dw u_tabpg_dw

type variables

//	Automate linkage
dwobject MasterDWO[]
string MasterDWOName[]

end variables

forward prototypes
public function integer refresh ()
end prototypes

public function integer refresh ();
dw_1.of_Refresh(Refreshing) ; Refreshing = false
return dw_1.event pfc_retrieve()

end function

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_1.X + gb_1.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
//		masterDWO[1] = dw_1.object.machinecode

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
//		masterDWOName[1] = String(windowHandle)+".MasterDWO.machinecode"
//		gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

on u_tabpg_dw.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_dw.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
//		choose case EventName
//			case String(windowHandle)+".MasterDWO"
//				any newMachine
//				newMachine = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.machine")
//				if	not IsNull(newMachine) then
//					Refreshing = (Machine = newMachine)
//					Machine = newMachine
//					Refresh()
//				else
//					dw_1.Reset()
//				end if
//		end choose

end event

type gb_1 from u_tabpg_4t`gb_1 within u_tabpg_dw
integer x = 27
integer textsize = -10
string text = "Records"
end type

type dw_1 from u_fxdw within u_tabpg_dw
integer x = 37
integer y = 80
integer width = 1733
integer height = 996
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;call super::constructor;
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

event getfocus;call super::getfocus;
SetHasFocus(true)

end event

event losefocus;call super::losefocus;
SetHasFocus(false)

end event

event activerowchanged;call super::activerowchanged;
if	UpperBound(masterDWO)>0 and not IsNull(windowHandle) then
	n_cst_associative_array	masterEventParm
	int	i
	if	activerow > 0 and activerow <= dw_1.RowCount() then
		for i = 1 to UpperBound(masterDWO)
			masterEventParm.of_SetItem(String(windowHandle)+".MasterDWO." + masterDWO[i].name, masterDWO[i].primary[activeRow])
		next
	else
		any Empty; setnull(Empty)
		for i = 1 to UpperBound(masterDWO)
			masterEventParm.of_SetItem(String(windowHandle)+".MasterDWO." + masterDWO[i].name, Empty)
		next
	end if
	gnv_App.inv_StateMSGRouter.post of_Broadcast(masterEventParm)
end if

n_cst_associative_array	eventParm
if	activeRow > 0 and activerow <= dw_1.RowCount() then
	eventParm.of_SetItem(tag + ".ParentDWRowData", dw_1.object.data.Primary[activeRow])
	eventParm.of_SetItem("ParentDW.dataobject", dw_1.dataobject)
else
	any emptyRow[]
	eventParm.of_SetItem(tag + ".ParentDWRowData", emptyRow)
	eventParm.of_SetItem("ParentDW.dataobject", dw_1.dataobject)
end if
gnv_App.inv_StateMSGRouter.of_Broadcast(eventParm)
end event

