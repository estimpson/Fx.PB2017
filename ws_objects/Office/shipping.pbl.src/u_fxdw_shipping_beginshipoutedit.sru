$PBExportHeader$u_fxdw_shipping_beginshipoutedit.sru
forward
global type u_fxdw_shipping_beginshipoutedit from u_fxdw
end type
end forward

global type u_fxdw_shipping_beginshipoutedit from u_fxdw
integer width = 2034
integer height = 888
string dataobject = "d_shipping_beginshipoutedit"
end type
global u_fxdw_shipping_beginshipoutedit u_fxdw_shipping_beginshipoutedit

type variables

string _shipperList

end variables

forward prototypes
public function integer setshipperlist (string shipperlist)
end prototypes

public function integer setshipperlist (string shipperlist);
_shipperList = shipperList
return Refresh()

end function

on u_fxdw_shipping_beginshipoutedit.create
call super::create
end on

on u_fxdw_shipping_beginshipoutedit.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_shipperList)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_shipping_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
		string	operatorCode, truckNumber, proNumber
		operatorCode = Object.OperatorCode[1]
		truckNumber = Object.TruckNumber[1]
		proNumber = Object.ProNumber[1]
		
		myController.BeginShipout(_shipperList, operatorCode, truckNumber, proNumber)
		Reset()
		
	case "p_cancel"
		Reset()
		
		myController.CancelBeginShipout()
end choose

end event

event itemchanged;call super::itemchanged;
//	Take action for password entry:
choose case lower(dwo.Name)
	case lower("OperatorPassword")
		
		string	operatorCode, operatorName
		
		select
			e.operator_code
		,	e.name
		into
			:operatorCode
		,	:operatorName
		from
			dbo.employee e
		where
			e.password = :data using SQLCA  ;
		
		if	not operatorCode > "" then
			MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid login.", StopSign!)
			return 1
		end if
		
		Object.OperatorCode[1] = operatorCode
		Object.OperatorName[1] = operatorName

end choose

end event

event itemerror;call super::itemerror;
//	Suppress default message for password errors.
if	lower(dwo.Name) = lower("OperatorPassword") then return 1

end event

