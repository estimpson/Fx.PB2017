$PBExportHeader$u_tabpg_leaktester_scrapobjects.sru
forward
global type u_tabpg_leaktester_scrapobjects from u_tabpg_dw
end type
end forward

global type u_tabpg_leaktester_scrapobjects from u_tabpg_dw
end type
global u_tabpg_leaktester_scrapobjects u_tabpg_leaktester_scrapobjects

type variables

private:
constant string GB_TITLE = "Bad Harnesses"

string _leakTesterMachineCode

end variables
forward prototypes
public function integer setnewdefectreason (string reason)
public function integer clearnewdefectreason ()
public function integer setleaktestermachine (string machinecode)
end prototypes

public function integer setnewdefectreason (string reason);
gb_1.Text = GB_TITLE + " - New Defect: " + reason
return SUCCESS

end function

public function integer clearnewdefectreason ();
gb_1.Text = GB_TITLE
return SUCCESS

end function

public function integer setleaktestermachine (string machinecode);
_leakTesterMachineCode = machineCode
return Refresh()

end function

on u_tabpg_leaktester_scrapobjects.create
call super::create
end on

on u_tabpg_leaktester_scrapobjects.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_leaktester_scrapobjects
string text = "Bad Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_leaktester_scrapobjects
string dataobject = "d_leaktester_defectharnesslist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_leakTesterMachineCode)

end event

