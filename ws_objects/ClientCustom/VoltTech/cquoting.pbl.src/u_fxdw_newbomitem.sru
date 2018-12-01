$PBExportHeader$u_fxdw_newbomitem.sru
forward
global type u_fxdw_newbomitem from u_fxdw
end type
end forward

global type u_fxdw_newbomitem from u_fxdw
integer width = 1669
integer height = 1584
string title = "NewBOMItem"
string dataobject = "d_qtbom_newbomitem"
boolean vscrollbar = false
end type
global u_fxdw_newbomitem u_fxdw_newbomitem

type variables

//	Controller reference.
private n_quoting_newbom_controller _myController

//	Model data.
string _quoteNumber, _part, _partDescription, _commodity, _componentType, _unit, _comment
decimal _quantity

end variables

forward prototypes
public function integer savenewbomitem ()
end prototypes

public function integer savenewbomitem ();
if	RowCount() < 1 then return FAILURE

AcceptText()
//st_newquote newQuoteValues
//newQuoteValues.QuoteNumber = object.QuoteNumber[1]
//newQuoteValues.QuoteDate = object.QuoteDate[1]
//newQuoteValues.QuoteYear = object.QuoteYear[1]
//newQuoteValues.QuoteYearOrdinal =object.QuoteYearOrdinal[1]
//newQuoteValues.ECNOrdinal = object.ECNOrdinal[1]
//newQuoteValues.RevisionOrdinal = object.RevisionOrdinal[1]
//newQuoteValues.QuoteType = object.QuoteType[1]
//newQuoteValues.ParentQuoteID = object.ParentQuoteID[1]
//newQuoteValues.Customer = object.Customer[1]
//newQuoteValues.PartDescription = object.PartDescription[1]
//newQuoteValues.Program = object.Program[1]
//newQuoteValues.EAU = object.EAU[1]
//newQuoteValues.SOP = object.SOP[1]
//newQuoteValues.EOP = object.EOP[1]
//newQuoteValues.OEM = object.OEM[1]
//newQuoteValues.ModelYear = object.ModelYear[1]

return NO_ACTION
//return _myController.CreateNewQuoteHeader(newQuoteValues)

end function

on u_fxdw_newbomitem.create
call super::create
end on

on u_fxdw_newbomitem.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_quoting_controller parentController
parentController = myParentWindow.Container.of_GetItem("Controller")
_myController = parentController.GetNewBOMController()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_quoteNumber, _part, _partDescription, _commodity, _unit)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

choose case dwo.Name
	case "p_ok"
		//	Save new quote header.
//		return SaveNewQuoteHeader()
		
	case "p_cancel"
		Reset()
//		return _myController.CancelNewQuoteHeader()
end choose

end event

