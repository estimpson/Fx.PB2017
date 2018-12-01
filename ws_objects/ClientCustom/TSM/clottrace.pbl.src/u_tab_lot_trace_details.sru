$PBExportHeader$u_tab_lot_trace_details.sru
forward
global type u_tab_lot_trace_details from u_tab_4t
end type
end forward

global type u_tab_lot_trace_details from u_tab_4t
end type
global u_tab_lot_trace_details u_tab_lot_trace_details

event selectionchanged;call super::selectionchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_lot_trace_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

//choose case newindex
//	case 1,2
//		string nullString; SetNull(nullString)
//		myController.SetDestinationCode(nullString)
//	case else
//		u_tabpg_packaging_bulk_shipto activeTab
//		activeTab = control[newindex]
//		myController.SetDestinationCode(activeTab.GetShipTo())
//end choose
end event

