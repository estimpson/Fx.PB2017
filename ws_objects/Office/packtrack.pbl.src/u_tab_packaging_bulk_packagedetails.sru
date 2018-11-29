$PBExportHeader$u_tab_packaging_bulk_packagedetails.sru
forward
global type u_tab_packaging_bulk_packagedetails from u_tab_4t
end type
end forward

global type u_tab_packaging_bulk_packagedetails from u_tab_4t
end type
global u_tab_packaging_bulk_packagedetails u_tab_packaging_bulk_packagedetails

event selectionchanged;call super::selectionchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_packaging_bulk_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case newindex
	case 1,2
		string nullString; SetNull(nullString)
		myController.SetDestinationCode(nullString)
	case else
		u_tabpg_packaging_bulk_shipto activeTab
		activeTab = control[newindex]
		myController.SetDestinationCode(activeTab.GetShipTo())
end choose

end event

