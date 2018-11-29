$PBExportHeader$u_scannerbox.sru
forward
global type u_scannerbox from u_fxdw
end type
end forward

global type u_scannerbox from u_fxdw
integer width = 1787
integer height = 364
boolean enabled = false
string dataobject = "d_scanbox"
event timer pbm_timer
end type
global u_scannerbox u_scannerbox

type variables

private:
boolean _isScanning = false
n_cst_virtual_controller _scanHandler
n_tmg _timer
long _defaultKeyboardLayout = 0

string ScannedValue
string ValueName = "Scan"

end variables

forward prototypes
public subroutine stopscanning ()
public function integer startscanning (n_cst_virtual_controller scanHandler)
public function integer setvaluename (string name)
public function integer resetscanbox ()
public function integer resumescanning ()
end prototypes

event timer;
//	Get focus back to here.
_timer.Stop()
post SetFocus()

end event

public subroutine stopscanning ();
_isScanning = false
Enabled = false


end subroutine

public function integer startscanning (n_cst_virtual_controller scanHandler);
if	not IsValid(scanHandler) or IsNull(scanHandler) then
	return FAILURE
end if

_scanHandler = scanHandler
_isScanning = true
Enabled = true
SetFocus()
return SUCCESS

end function

public function integer setvaluename (string name);
if	isnull(name) then return FAILURE

ValueName = name

return ResetScanBox()

end function

public function integer resetscanbox ();
Reset()
InsertRow(0)

object.valuename[1] = ValueName

return SUCCESS

end function

public function integer resumescanning ();
_isScanning = true
Enabled = true
SetFocus()
return SUCCESS

end function

event resize;call super::resize;
//	Give controls full width.
Object.gb_1.Width = PixelsToUnits(newwidth, XPixelsToUnits!) - 2 * Long(Object.gb_1.X)
Object.scanvalue.Width = PixelsToUnits(newwidth, XPixelsToUnits!) - 2 * Long(Object.scanvalue.X)

end event

event losefocus;call super::losefocus;
if	_defaultKeyboardLayout > 0 then
	n_cst_user32 user32
	user32.ActivateKeyboardLayout(_defaultKeyboardLayout, user32.KLF_REORDER)
end if

if	_isScanning then
	_timer.Start(.5)
end if

end event

on u_scannerbox.create
call super::create
end on

on u_scannerbox.destroy
call super::destroy
end on

event itemchanged;call super::itemchanged;
if	lower(dwo.name) = "scanvalue" then
	ScannedValue = data

	if	IsValid(_scanHandler) then
		_scanHandler.HandleScan(data)
	end if
	
	ResetScanBox()
end if

end event

event constructor;call super::constructor;
_timer = create n_tmg
_timer.of_SetSingle(true)
_timer.inv_Single.of_Register(this, "Timer", 1)
_timer.Stop()
of_SetRowSelect(false)
of_SetUpdateable(false)

end event

event getfocus;call super::getfocus;
n_cst_user32 user32
if	_defaultKeyboardLayout = 0 then
	_defaultKeyboardLayout = user32.GetKeyboardLayout(0)
end if

user32.ActivateKeyboardLayout(user32.LANG_US_ENGLISH, user32.KLF_REORDER)

end event

