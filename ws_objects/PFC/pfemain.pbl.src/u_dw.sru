$PBExportHeader$u_dw.sru
$PBExportComments$Extension DataWindow class
forward
global type u_dw from pfc_u_dw
end type
end forward

global type u_dw from pfc_u_dw
event pfd_event ( string eventname,  n_cst_associative_array eventmessage )
event activerowchanged ( long activerow )
event activerowtimer ( )
end type
global u_dw u_dw

type variables

Public:
boolean asyncActiveRow = false

integer	ii_Column

long	il_HScrollPos
long	il_VScrollPos
long	il_Row
privatewrite long _activeRow

n_cst_dwsrv_search inv_search
n_cst_dwsrv_linkdwsearch	inv_LinkDWSearch
u_dwstatusbar StatusBarUO
w_dwstatusbar StatusBarWindow

Protected:
boolean	ib_Redraw = true
boolean	ib_Refresh = false
boolean	Retrieving = false

n_cst_windowdimensions WindowDimensions

Private:
n_tmg _activeRowTimer

end variables

forward prototypes
public function integer setredraw (boolean ab_redraw)
public function integer of_refresh (boolean ab_refresh)
public function integer of_setsearch (boolean ab_switch)
public function integer of_settransobject (n_tr atr_object)
public function integer of_setlinkdwsearch (boolean ab_switch)
public function integer setstatusbar (boolean _flag)
public function integer sort ()
end prototypes

event pfd_event(string eventname, n_cst_associative_array eventmessage);
choose case EventName
	case "Connect"
		SetTransObject (itr_Object)
end choose

end event

event activerowchanged(long activerow);
SetRedraw(true)

end event

event activerowtimer();
_activeRowTimer.Stop()
event activerowchanged(_activeRow)

end event

public function integer setredraw (boolean ab_redraw);
//	Record redraw.
ib_Redraw = ab_Redraw

//	Return.
return super::SetRedraw ( ib_Redraw )
end function

public function integer of_refresh (boolean ab_refresh);
//	Set refresh.
ib_Refresh = ab_Refresh

//	Retrieve.
return 0

end function

public function integer of_setsearch (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetDropdownSearch
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDownDataWindow search services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_search) Or Not IsValid (inv_search) THEN
		inv_search = Create n_cst_dwsrv_search
		inv_search.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_search) THEN
		Destroy inv_search
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer of_settransobject (n_tr atr_object);
//	Ask for notification of reconnects.
gnv_App.inv_StateMsgRouter.of_RequestNotification (this, "Connect")

//	Invoke ancestor script.
return super::of_SetTransObject (atr_Object)

end function

public function integer of_setlinkdwsearch (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  of_SetLinkDWSearch
//
//	(Arguments: boolean
//   TRUE  - Start (create) the service
//   FALSE - Stop (destroy ) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//
//	Description:  Starts or stops the DropDownDataWindow search services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check arguments
If IsNull(ab_switch) Then
	Return FAILURE
End If

IF ab_Switch THEN
	IF IsNull(inv_LinkDWSearch) Or Not IsValid (inv_LinkDWSearch) THEN
		inv_LinkDWSearch = Create n_cst_dwsrv_LinkDWSearch
		inv_LinkDWSearch.of_SetRequestor ( this )
		Return SUCCESS
	END IF
ELSE 
	IF IsValid (inv_LinkDWSearch) THEN
		Destroy inv_LinkDWSearch
		Return SUCCESS
	END IF	
END IF 

Return NO_ACTION
end function

public function integer setstatusbar (boolean _flag);
window lw_parent
n_cst_notesattrib lnv_notesattrib

//Check arguments
if	IsNull(_flag) then
	return FAILURE
end if

// Get parent window reference.
WindowDimensions.GetParentWindow(this, lw_parent)
if	IsNull(lw_parent) or Not IsValid(lw_parent) then
	return FAILURE
end if

if	_flag then
	if not IsValid (StatusBarUO) then
		//	Create statusbar.
		//lw_parent.OpenUserObject(StatusBarUO)
		Open(StatusBarWindow, lw_parent)
		//StatusBarUO.SetRequestor (this)
		StatusBarWindow.SetRequestor(this)
		return SUCCESS
	end if
else
	if	IsValid (StatusBarWindow) then
		//lw_parent.CloseUserObject(StatusBarUO)
		Close(StatusBarWindow)
		return SUCCESS
	end if
end if

return NO_ACTION
end function

public function integer sort ();
int sortReturn
sortReturn = super::Sort()

if	not Retrieving then
	event activerowchanged(getrow())
end if

return sortReturn
end function

event doubleclicked;call super::doubleclicked;
// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_doubleclicked ( xpos, ypos, row, dwo ) 
END IF 

end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Destructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	
//	Destroy the instantiated datawindow services attached to this dw.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added cleanup for new 6.0 services.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetLinkDWSearch (false)
SetStatusBar(false)
destroy _activeRowTimer

end event

event retrievestart;call super::retrievestart;
//	Start retrieving.
Retrieving = true

//	Record current positions.
il_HScrollPos = Long ( object.datawindow.horizontalscrollposition )
il_VScrollPos = Long ( object.datawindow.verticalscrollposition )
ii_Column = GetColumn ()
il_Row = GetRow ( )

//	Set redraw off to prevent flicker.
super::SetRedraw ( false )
end event

event retrieveend;call super::retrieveend;
//	Done retrieving.
Retrieving = false

//	If refresh, set positions.
if	ib_Refresh then
	object.datawindow.horizontalscrollposition = String ( il_HScrollPos )
	object.datawindow.verticalscrollposition = String ( il_VScrollPos )
	SetColumn (ii_Column)
	SetRow ( il_Row )
	ib_Refresh = false
end if
event activerowchanged(getrow())

//	Set single row select.
if	IsValid(inv_RowSelect) then
	SelectRow (0, false) 
	SelectRow (getrow(), true) 
end if

//	Restore redraw.
super::SetRedraw ( ib_Redraw )

end event

event itemfocuschanged;call super::itemfocuschanged;
If IsValid(inv_DropDownSearch) Then
	inv_DropDownSearch.Event pfc_itemfocuschanged (row, dwo)
End If

If IsValid(inv_Search) Then
	inv_Search.Event pfc_itemfocuschanged (row, dwo)
End If

end event

event editchanged;call super::editchanged;
If IsValid(inv_DropDownSearch) Then
	inv_DropDownSearch.Event pfc_editchanged (row, dwo, data)
End If

If IsValid(inv_Search) Then
	inv_Search.Event pfc_editchanged (row, dwo, data)
End If

end event

on u_dw.create
call super::create
end on

on u_dw.destroy
call super::destroy
end on

event rowfocuschanged;call super::rowfocuschanged;
if	not Retrieving then
	if	asyncActiveRow then
		_activeRow = currentRow
		if	IsValid(_activeRowTimer) then
			_activeRowTimer.Stop()
			_activeRowTimer.Start(.1)
		end if
	else
		event activerowchanged(currentrow)
	end if
end if

end event

event resize;call super::resize;
if	IsValid(StatusBarWindow) then
	StatusBarWindow.Position()
end if

end event

event getfocus;call super::getfocus;
if	isvalid(StatusBarUO) then
	StatusBarUO.ParentFocus = true
	StatusBarUO.post Show()
end if

if	isvalid(StatusBarWindow) then
	StatusBarWindow.ParentFocus = true
	StatusBarWindow.post Show()
end if

end event

event losefocus;call super::losefocus;
if	isvalid(StatusBarUO) then
	StatusBarUO.ParentFocus = false
	StatusBarUO.post Show()
end if

if	isvalid(StatusBarWindow) then
	StatusBarWindow.ParentFocus = false
	Timer(1,StatusBarWindow)
end if

end event

event constructor;call super::constructor;_activeRowTimer = create n_tmg
_activeRowTimer.of_SetSingle(true)
_activeRowTimer.inv_Single.of_Register(this, "activerowtimer", .1)
_activeRowTimer.Stop()

end event

