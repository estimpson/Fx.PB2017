$PBExportHeader$u_tabpg_mes_bfhistory_recenthistory.sru
forward
global type u_tabpg_mes_bfhistory_recenthistory from u_tabpg_dw
end type
type dw_2 from u_fxdw within u_tabpg_mes_bfhistory_recenthistory
end type
type st_1 from statictext within u_tabpg_mes_bfhistory_recenthistory
end type
end forward

global type u_tabpg_mes_bfhistory_recenthistory from u_tabpg_dw
integer width = 2414
dw_2 dw_2
st_1 st_1
end type
global u_tabpg_mes_bfhistory_recenthistory u_tabpg_mes_bfhistory_recenthistory

type variables

Private:

//	Controller reference.
n_mes_bfhistory_controller _myController

//	Model data.

datetime _recentDate

end variables

forward prototypes
public function integer setrecentdate (datetime recentdate)
end prototypes

public function integer setrecentdate (datetime recentdate);
_recentDate = recentDate
dw_2.object.SelectedDT[1] = _recentDate
choose case DaysAfter(Date(_recentDate), Today())
	case 0
		st_1.Text = "Today"
	case is>0
		st_1.Text = String(DaysAfter(Date(_recentDate), Today())) + " days"
	case else
		st_1.Text = "Invalid"
end choose
return Refresh()

end function

on u_tabpg_mes_bfhistory_recenthistory.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
end on

on u_tabpg_mes_bfhistory_recenthistory.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(dw_2.X + (dw_2.X - gb_1.X - gb_1.Width) + dw_2.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(dw_2, 100, 0, 0, 0)
inv_Resize.of_Register(st_1, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mes_bfhistory_recenthistory
end type

event gb_1::constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mes_bfhistory_recenthistory
string dataobject = "d_mes_bfhistory_recenthistory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

string workOrderNumber
workOrderNumber = object.WorkOrderNumber [activerow]

_myController.SetWorkOrderNumber(workOrderNumber)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

return Retrieve(_recentDate)

end event

type dw_2 from u_fxdw within u_tabpg_mes_bfhistory_recenthistory
integer x = 1806
integer y = 28
integer width = 361
integer height = 272
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_choosedt"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(false)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

Retrieve()

end event

event clicked;call super::clicked;
object.SelectedDT.TabSequence = 1
SetColumn(1)
iuo_calendar.event pfc_dropdown()
object.SelectedDT.TabSequence = 0

end event

event pfc_dateselected;call super::pfc_dateselected;
_myController.SetRecentDate(DateTime(newDate))

end event

type st_1 from statictext within u_tabpg_mes_bfhistory_recenthistory
integer x = 1806
integer y = 336
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "N Days"
boolean focusrectangle = false
end type

