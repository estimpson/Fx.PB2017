$PBExportHeader$u_tabpg_pottingroom_scrapobjects.sru
forward
global type u_tabpg_pottingroom_scrapobjects from u_tabpg_dw
end type
end forward

global type u_tabpg_pottingroom_scrapobjects from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_pottingroom_scrapobjects u_tabpg_pottingroom_scrapobjects

type variables

private:
constant string GB_TITLE = "Bad Harnesses"

string _pottingRoomMachineCode

end variables
forward prototypes
public function integer setnewdefectreason (string reason)
public function integer clearnewdefectreason ()
public function integer setpottingroommachine (string machinecode)
end prototypes

public function integer setnewdefectreason (string reason);
gb_1.Text = GB_TITLE + " - New Defect: " + reason
return SUCCESS

end function

public function integer clearnewdefectreason ();
gb_1.Text = GB_TITLE
return SUCCESS

end function

public function integer setpottingroommachine (string machinecode);
_pottingRoomMachineCode = machineCode
return Refresh()

end function

on u_tabpg_pottingroom_scrapobjects.create
call super::create
end on

on u_tabpg_pottingroom_scrapobjects.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_pottingroom_scrapobjects
string text = "Bad Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_pottingroom_scrapobjects
string dataobject = "d_pottingroom_defectharnesslist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_pottingRoomMachineCode)

end event

