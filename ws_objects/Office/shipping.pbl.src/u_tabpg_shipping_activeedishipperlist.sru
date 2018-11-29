$PBExportHeader$u_tabpg_shipping_activeedishipperlist.sru
forward
global type u_tabpg_shipping_activeedishipperlist from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_shipping_activeedishipperlist
end type
end forward

global type u_tabpg_shipping_activeedishipperlist from u_tabpg_dw
integer width = 2359
cb_1 cb_1
end type
global u_tabpg_shipping_activeedishipperlist u_tabpg_shipping_activeedishipperlist

type variables

private:
string ShipperNumber
n_cst_shipping_controller _myController

end variables

forward prototypes
public function integer validateselectedshippersforshipout ()
public function integer showbeginshipout ()
end prototypes

public function integer validateselectedshippersforshipout ();
//	TransObject
n_cst_trans_shipping Trans_Shipping
Trans_Shipping = create n_cst_trans_shipping

//	Build a list of shippers that are selected for departure.
string shipperList = ""
long row, rows
long selectedArray []
string shipperArray []

SelectedArray = dw_1.Object.IsSelected.Primary
ShipperArray = dw_1.Object.ShipperNumber.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	Len(shipperList + shipperArray[row]) > 8000 then
			MessageBox(gnv_App.iapp_Object.DisplayName, "There are too many shippers selected for a combined shipout.  Selecting shippers to be combined on a single truck and try again.")
			return FAILURE
		end if
		shipperList += shipperArray[row] + ","
	end if
next

if	Trans_Shipping.VerifyShipperListForDeparture(shipperList) = SUCCESS then
	commit using SQLCA  ;
	destroy Trans_Shipping
	return SUCCESS
end if

destroy Trans_Shipping
Controller.Refresh()
return FAILURE

end function

public function integer showbeginshipout ();
//	Build a list of serials that need to have the new status.
string shipperList = ""
long row, rows
long selectedArray []
string shipperArray []

SelectedArray = dw_1.Object.IsSelected.Primary
ShipperArray = dw_1.Object.ShipperNumber.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	Len(shipperList + shipperArray[row]) > 8000 then
			MessageBox(gnv_App.iapp_Object.DisplayName, "There are too many shippers selected for a combined shipout.  Selecting shippers to be combined on a single truck and try again.")
			return FAILURE
		end if
		shipperList += shipperArray[row] + ","
	end if
next

if	not IsValid(_myController) then return FAILURE

return _myController.ShowBeginShipout(shipperList)

end function

on u_tabpg_shipping_activeedishipperlist.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on u_tabpg_shipping_activeedishipperlist.destroy
call super::destroy
destroy(this.cb_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_activeedishipperlist
string text = "Active EDI"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_activeedishipperlist
string dataobject = "d_shipping_activeedishipperlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::updateend;call super::updateend;
//	Commit changes.
commit using sqlca  ;

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	cb_1.enabled = false
	return
end if

datetime ediRejectedDT
string exceptionHandler

ediRejectedDT = object.EDIRejectedDT[activerow]
exceptionHandler = object.ExceptionHandler[activerow]

cb_1.enabled = (not IsNull(ediRejectedDT) and IsNull(exceptionHandler, "") > "")

end event

type cb_1 from commandbutton within u_tabpg_shipping_activeedishipperlist
integer x = 1806
integer y = 168
integer width = 443
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Handle Exception"
end type

event clicked;
long shipperID
string exceptionHandler

if	dw_1.RowCount() <= 0 then return

shipperID = dw_1.object.LegacyShipperID[dw_1.GetRow()]
exceptionHandler = dw_1.object.ExceptionHandler[dw_1.GetRow()]
_myController.HandleASNException(shipperID, exceptionHandler)

end event

