$PBExportHeader$u_fxdw_newquoteheader.sru
forward
global type u_fxdw_newquoteheader from u_fxdw
end type
end forward

global type u_fxdw_newquoteheader from u_fxdw
integer width = 1669
integer height = 1584
string dataobject = "d_qt_getnewquoteheader"
boolean vscrollbar = false
end type
global u_fxdw_newquoteheader u_fxdw_newquoteheader

type variables

//	Controller reference.
private n_quoting_controller _myController

//	Model data.
string _quoteNumber, _customer, _partDescription, _program, _oem
int _quoteType, _quoteYear, _quoteYearOrdinal, _ecnOrdinal, _revisionOrdinal, _modelYear
long _parentQuoteID, _eau
datetime _sop, _eop

end variables

forward prototypes
public function integer newquote ()
public function integer newecn (long parentquoteid)
public function integer newrevision (long parentquoteid)
public function integer savenewquoteheader ()
end prototypes

public function integer newquote ();
string stringNull
SetNull(stringNull)
_quoteNumber = stringNull
_customer = stringNull
_partDescription = stringNull
_program = stringNull
_oem = stringNull

int intNull
SetNull(intNull)
_quoteYear = intNull
_quoteYearOrdinal = intNull
_ecnOrdinal = intNull
_revisionOrdinal = intNull
_modelYear = intNull

long longNull
SetNull(longNull)
_parentQuoteID = longNull
_eau = longNull

datetime datetimeNull
SetNull(datetimeNull)
_sop = datetimeNull
_eop = datetimeNull

_quoteType = 0
return Refresh()

end function

public function integer newecn (long parentquoteid);
_parentQuoteID = parentQuoteID

string stringNull
SetNull(stringNull)
_quoteNumber = stringNull
_customer = stringNull
_partDescription = stringNull
_program = stringNull
_oem = stringNull

int intNull
SetNull(intNull)
_quoteYear = intNull
_quoteYearOrdinal = intNull
_ecnOrdinal = intNull
_revisionOrdinal = intNull
_modelYear = intNull

long longNull
SetNull(longNull)
_eau = longNull

datetime datetimeNull
SetNull(datetimeNull)
_sop = datetimeNull
_eop = datetimeNull

_quoteType = 1
return Refresh()

end function

public function integer newrevision (long parentquoteid);
_parentQuoteID = parentQuoteID

string stringNull
SetNull(stringNull)
_quoteNumber = stringNull
_customer = stringNull
_partDescription = stringNull
_program = stringNull
_oem = stringNull

int intNull
SetNull(intNull)
_quoteYear = intNull
_quoteYearOrdinal = intNull
_ecnOrdinal = intNull
_revisionOrdinal = intNull
_modelYear = intNull

long longNull
SetNull(longNull)
_eau = longNull

datetime datetimeNull
SetNull(datetimeNull)
_sop = datetimeNull
_eop = datetimeNull

_quoteType = 2
return Refresh()

end function

public function integer savenewquoteheader ();
if	RowCount() < 1 then return FAILURE

AcceptText()
st_newquote newQuoteValues
newQuoteValues.QuoteNumber = object.QuoteNumber[1]
newQuoteValues.QuoteDate = object.QuoteDate[1]
newQuoteValues.QuoteYear = object.QuoteYear[1]
newQuoteValues.QuoteYearOrdinal =object.QuoteYearOrdinal[1]
newQuoteValues.ECNOrdinal = object.ECNOrdinal[1]
newQuoteValues.RevisionOrdinal = object.RevisionOrdinal[1]
newQuoteValues.QuoteType = object.QuoteType[1]
newQuoteValues.ParentQuoteID = object.ParentQuoteID[1]
newQuoteValues.Customer = object.Customer[1]
newQuoteValues.PartDescription = object.PartDescription[1]
newQuoteValues.Program = object.Program[1]
newQuoteValues.EAU = object.EAU[1]
newQuoteValues.SOP = object.SOP[1]
newQuoteValues.EOP = object.EOP[1]
newQuoteValues.OEM = object.OEM[1]
newQuoteValues.ModelYear = object.ModelYear[1]

return _myController.CreateNewQuoteHeader(newQuoteValues)

end function

on u_fxdw_newquoteheader.create
call super::create
end on

on u_fxdw_newquoteheader.destroy
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

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_quoteNumber, _quoteType, string(_parentQuoteID), _customer, _partDescription, _program, _eau, string(_sop), string(_eop), _oem, _modelYear)

end event

event retrieveend;call super::retrieveend;
if	rowcount < 1 then return FAILURE

object.QuoteDate[1] = datetime(today())
_quoteNumber = object.QuoteNumber[1]
_quoteYear = object.QuoteYear[1]
_quoteYearOrdinal =object.QuoteYearOrdinal[1]
_ecnOrdinal = object.ECNOrdinal[1]
_revisionOrdinal = object.RevisionOrdinal[1]
_quoteType = object.QuoteType[1]
_parentQuoteID = object.ParentQuoteID[1]
_customer = object.Customer[1]
_partDescription = object.PartDescription[1]
_program = object.Program[1]
_eau = object.EAU[1]
_sop = object.SOP[1]
_eop = object.EOP[1]
_oem = object.OEM[1]
_modelYear = object.ModelYear[1]

return SUCCESS

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

string groupName
choose case dwo.Name
	case "p_ok"
		//	Save new quote header.
		return SaveNewQuoteHeader()
		
	case "p_cancel"
		Reset()
		return _myController.CancelNewQuoteHeader()
end choose

end event

