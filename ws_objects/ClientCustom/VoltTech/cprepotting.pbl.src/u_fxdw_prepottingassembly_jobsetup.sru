$PBExportHeader$u_fxdw_prepottingassembly_jobsetup.sru
forward
global type u_fxdw_prepottingassembly_jobsetup from u_fxdw
end type
end forward

global type u_fxdw_prepottingassembly_jobsetup from u_fxdw
integer width = 1806
integer height = 408
string dataobject = "d_prepottingassembly_jobsetup_edit"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_prepottingassembly_jobsetup u_fxdw_prepottingassembly_jobsetup

type variables

private:
//	Controller reference.
n_prepottingassembly_controller _myController

//	Model data.
string OperatorCode
long AssemblyBoardSerial
string _productionPart

end variables
forward prototypes
public function integer setassemblyboard (long serial)
public function integer setoperator (string code)
public function integer resetjobsetup ()
public function string getproductionpart ()
end prototypes

public function integer setassemblyboard (long serial);
if	RowCount() < 1 then
	event pfc_retrieve()
end if

AssemblyBoardSerial = serial
return Refresh()

end function

public function integer setoperator (string code);
if	RowCount() < 1 then
	event pfc_retrieve()
end if

OperatorCode = code
return Refresh()

end function

public function integer resetjobsetup ();
SetNull(OperatorCode)
SetNull(AssemblyBoardSerial)

return Refresh()

end function

public function string getproductionpart ();
return _productionPart

end function

on u_fxdw_prepottingassembly_jobsetup.create
call super::create
end on

on u_fxdw_prepottingassembly_jobsetup.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

event pfc_retrieve;call super::pfc_retrieve;
datawindowchild dropDown
if	GetChild("AssemblyBoardSerial", dropDown) = 1 then
	dropDown.SetTransObject(SQLCA)
	if	dropDown.Retrieve() <= 0 then
		dropDown.InsertRow(0)
	end if
end if
if	GetChild("Operator", dropDown) = 1 then
	dropDown.SetTransObject(SQLCA)
	if	dropDown.Retrieve() <= 0 then
		dropDown.InsertRow(0)
	end if
end if

return Retrieve()

end event

event retrieveend;call super::retrieveend;
if	OperatorCode > "" then
	object.Operator[rowcount] = OperatorCode
end if
if	AssemblyBoardSerial > 0 then
	object.AssemblyBoardSerial[rowcount] = AssemblyBoardSerial
	datawindowchild dwc
	if	GetChild("AssemblyBoardSerial", dwc) = SUCCESS then
		long row
		row = dwc.Find("ToolSerial =" + String(AssemblyBoardSerial), 1, dwc.RowCount())
		_productionPart = object.AssemblyBoardSerial.object.ProductionPart[row]
	end if		
end if

end event

