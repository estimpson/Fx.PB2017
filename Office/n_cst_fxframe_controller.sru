HA$PBExportHeader$n_cst_fxframe_controller.sru
forward
global type n_cst_fxframe_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_fxframe_controller from n_cst_virtual_controller
string proxyname = "0"
integer _displaymode = 0
end type
global n_cst_fxframe_controller n_cst_fxframe_controller

type variables

private:
w_frame_office _myFrame

end variables
forward prototypes
public function integer registerframe (ref w_frame_office framewindow)
public function integer startscanning (ref n_cst_virtual_controller scanhandler)
public function integer stopscanning ()
end prototypes

public function integer registerframe (ref w_frame_office framewindow);
if	not IsValid(frameWindow) then
	return FAILURE
end if

_myFrame = frameWindow

return SUCCESS

end function

public function integer startscanning (ref n_cst_virtual_controller scanhandler);
if	not IsValid(scanHandler) or not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.StartScanning(scanHandler)

end function

public function integer stopscanning ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.StopScanning()

end function

on n_cst_fxframe_controller.create
call super::create
end on

on n_cst_fxframe_controller.destroy
call super::destroy
end on

