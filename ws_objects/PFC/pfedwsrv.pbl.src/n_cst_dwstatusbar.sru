$PBExportHeader$n_cst_dwstatusbar.sru
forward
global type n_cst_dwstatusbar from n_base
end type
end forward

global type n_cst_dwstatusbar from n_base
end type
global n_cst_dwstatusbar n_cst_dwstatusbar

type variables

w_dwstatusbar StatusBarWindow
n_cst_windowdimensions WindowDimensions

end variables

forward prototypes
public function integer setrequestor (u_dwstatusbar _statusbaruo)
public function integer position (u_dw _requestordw)
public function integer show (u_dw _requestordw, boolean _visibleflag)
public function integer sizefull (u_dw _requestordw)
public function integer sizesmall (u_dw _requestordw)
public function integer setrequestor (w_dwstatusbar _statusbarwindow)
end prototypes

public function integer setrequestor (u_dwstatusbar _statusbaruo);
return FAILURE
if	not isvalid(_StatusBarUO) or isnull(_StatusBarUO) then return FAILURE

//StatusBarUO = _StatusBarUO
return SUCCESS

end function

public function integer position (u_dw _requestordw);
integer	statusBarX, statusBarY
integer	parentX, parentY
integer	dimDWX, dimDWY, dimDWWidth, dimDWHeight // , dimDWBorder
window	requestorParentWindow

//	Validate the references.
if	IsNull(_requestorDW) or not IsValid(_requestorDW) or IsNull(StatusBarWindow) or not IsValid(StatusBarWindow) then return FAILURE

//	Get the parent window.
WindowDimensions.GetParentWindow(_requestorDW, requestorParentWindow)
if	IsNull(requestorParentWindow) or Not IsValid(requestorParentWindow) then return FAILURE

//	Get the X/Y diminates for the parent object holding this datawindow.
WindowDimensions.GetParentPosition(_requestorDW, parentX, parentY)

//	Get the DataWindow X/Y diminates, Border width, and Title width. 
dimDWX = _requestorDW.X
dimDWY = _requestorDW.Y
dimDWWidth = _requestorDW.Width
dimDWHeight = _requestorDW.Height

//	Calculate the X and Y Coordinates (check that it does not go past borders).
statusBarX = parentX + dimDWX //	+ dimDWBorder
statusBarY = parentY + dimDWY + dimDWHeight //	+ dimDWBorder

//	Position the requestor object to the calculated coordinates.
StatusBarWindow.Move (statusBarX, statusBarY)
StatusBarWindow.Width = dimDWWidth

return SUCCESS

end function

public function integer show (u_dw _requestordw, boolean _visibleflag);
integer	statusBarX, statusBarY
integer	parentX, parentY
integer	dimDWX, dimDWY, dimDWWidth, dimDWHeight // , dimDWBorder
window	requestorParentWindow

//	Validate the references.
if	IsNull(_requestorDW) or not IsValid(_requestorDW) or IsNull(StatusBarWindow) or not IsValid(StatusBarWindow) then return FAILURE
if	StatusBarWindow.Visible and _visibleFlag then return NO_ACTION
if	not StatusBarWindow.Visible and not _visibleFlag then return NO_ACTION

if	StatusBarWindow.Visible then
	_requestorDW.Height += StatusBarWindow.Height
	StatusBarWindow.Visible = false
else
	_requestorDW.Height -= StatusBarWindow.Height
	StatusBarWindow.Visible = true
end if

return Position(_requestorDW)


end function

public function integer sizefull (u_dw _requestordw);
//	Validate the references.
if	IsNull(_requestorDW) or not IsValid(_requestorDW) or IsNull(StatusBarWindow) or not IsValid(StatusBarWindow) then return FAILURE

//	Hide.
if	StatusBarWindow.Visible then
	Show(_requestorDW, false)

	//	Change height.
	StatusBarWindow.Height = StatusBarWindow.NormalHeight

	//	Show.
	Show(_requestorDW, true)
else
	//	Change height.
	StatusBarWindow.Height = StatusBarWindow.NormalHeight
end if

return Position(_requestorDW)

end function

public function integer sizesmall (u_dw _requestordw);
//	Validate the references.
if	IsNull(_requestorDW) or not IsValid(_requestorDW) or IsNull(StatusBarWindow) or not IsValid(StatusBarWindow) then return FAILURE

//	Hide.
if	StatusBarWindow.Visible then
	Show(_requestorDW, false)

	//	Change height.
	StatusBarWindow.Height = StatusBarWindow.MinimumHeight

	//	Show.
	Show(_requestorDW, true)
else
	//	Change height.
	StatusBarWindow.Height = StatusBarWindow.MinimumHeight
end if

return Position(_requestorDW)

end function

public function integer setrequestor (w_dwstatusbar _statusbarwindow);
if	not isvalid(_StatusBarWindow) or isnull(_StatusBarWindow) then return FAILURE

StatusBarWindow = _StatusBarWindow
return SUCCESS

end function

on n_cst_dwstatusbar.create
call super::create
end on

on n_cst_dwstatusbar.destroy
call super::destroy
end on

