$PBExportHeader$pfc_u_em.sru
$PBExportComments$PFC Editmask class
forward
global type pfc_u_em from editmask
end type
end forward

global type pfc_u_em from editmask
int Width=229
int Height=84
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.00"
double Increment=1
string MinMax="0~~"
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event type integer pfc_cut ( )
event type integer pfc_copy ( )
event type integer pfc_paste ( )
event type integer pfc_undo ( )
event type integer pfc_clear ( )
event type integer pfc_selectall ( )
event rbuttonup pbm_rbuttonup
event pfc_prermbmenu ( ref m_edit am_edit )
event type integer pfc_ddcalendar ( )
event type integer pfc_ddcalculator ( )
end type
global pfc_u_em pfc_u_em

type variables
Public:
u_calendar	iuo_calendar
u_calculator	iuo_calculator

Protected:
boolean	ib_autoselect
boolean	ib_rmbmenu = true
end variables

forward prototypes
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_setdropdowncalendar (boolean ab_switch)
public function integer of_setdropdowncalculator (boolean ab_switch)
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
end prototypes

event pfc_cut;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_cut
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript Cut function)
//
//	Description:	Cut the text to the clipboard.
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

Return this.Cut()
end event

event pfc_copy;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_copy
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript Copy function)
//
//	Description:	Copy the text to the clipboard.
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

Return this.Copy()
end event

event pfc_paste;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_paste
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript Paste function)
//
//	Description:	Paste the text from the clipboard.
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

Return this.Paste()
end event

event pfc_undo;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_undo
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript CanUndo function
//						0 If there is nothing to Undo.)
//
//	Description:	Cancels the last edit, restoring the text to the content
//						before the last change.
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

if this.CanUndo() then
	Return this.Undo()
end if

Return 0
end event

event pfc_clear;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_clear
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript Clear function)
//
//	Description:	Clear Text (no clipboard) functionality
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

Return this.Clear()
end event

event pfc_selectall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_selectall
//
//	(Arguments:		None)
//
//	(Returns:  		integer
//						Return value from the PowerScript SelectAl function)
//
//	Description:	Select all the text.
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

// Select all text
Return this.SelectText (1, Len (this.text))
end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttonup
//
//	Description:  Popup menu
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

boolean	lb_frame
m_edit	lm_edit
window	lw_parent
window	lw_frame
window	lw_sheet
window	lw_childparent

// Determine if RMB popup menu should occur
if not ib_rmbmenu then
	return 1
end if

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_edit = create m_edit
lm_edit.of_SetParent (this)

// Enable menu items if appropriate
lm_edit.m_edititem.m_copy.enabled = false
lm_edit.m_edititem.m_cut.enabled = false
if Len (this.SelectedText()) > 0 then
	lm_edit.m_edititem.m_copy.enabled = true
	if not this.displayonly then
		lm_edit.m_edititem.m_cut.enabled = true
	end if
end if

if Len (ClipBoard()) > 0 and not this.displayonly then
	lm_edit.m_edititem.m_paste.enabled = true
else
	lm_edit.m_edititem.m_paste.enabled = false
end if

if Len (this.text) > 0 then
	lm_edit.m_edititem.m_selectall.enabled = true
else
	lm_edit.m_edititem.m_selectall.enabled = false
end if

this.event pfc_prermbmenu (lm_edit)

lm_edit.m_edititem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
destroy lm_edit

return 1

end event

event pfc_ddcalendar;If IsValid(iuo_calendar) Then
	Return iuo_calendar.Event pfc_dropdown()
End If

Return 0

end event

event pfc_ddcalculator;
If IsValid(iuo_calculator) Then
	Return iuo_calculator.Event pfc_dropdown()
End If

Return 0

end event

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  public
//
//	Arguments:
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
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

powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

public function integer of_setdropdowncalendar (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownCalendar
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
//	Description:  Starts or stops the DropDown Calendar visual object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent

//Check arguments
If IsNull(ab_switch) Then
	Return -1
End If

// Check for an appropriate Mask Type.
If this.MaskDataType <> DateMask! Then
	Return -1
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return -1
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_calendar) THEN
		lw_parent.OpenUserObject(iuo_calendar)
		iuo_calendar.of_SetRequestor (this)
		Return 1
	END IF
ELSE 
	IF IsValid (iuo_calendar) THEN
		lw_parent.CloseUserObject(iuo_calendar)
		Return 1
	END IF	
END IF 

Return 0
end function

public function integer of_setdropdowncalculator (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
// 
//	Event:  of_SetDropDownCalculator
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
//	Description:  Starts or stops the DropDown Calculator visual object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

window lw_parent

//Check arguments
If IsNull(ab_switch) Then
	Return -1
End If

// Check for an appropriate Mask Type.
If this.MaskDataType <> DecimalMask! And &
	this.MaskDataType <> NumericMask! Then
	Return -1
End If

// Get parent window reference.
of_GetParentWindow(lw_parent)
If IsNull(lw_parent) or Not IsValid(lw_parent) Then
	Return -1
End If

IF ab_Switch THEN
	IF Not IsValid (iuo_calculator) THEN
		lw_parent.OpenUserObject(iuo_calculator)
		iuo_calculator.of_SetRequestor (this)
		Return 1
	END IF
ELSE 
	IF IsValid (iuo_calculator) THEN
		lw_parent.CloseUserObject(iuo_calculator)
		Return 1
	END IF	
END IF 

Return 0
end function

protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_MessageBox
//
//	Access:  			protected
//
//	Arguments:
//	as_id			An ID for the Message.
//	as_title  	Text for title bar
//	as_text		Text for the actual message.
//	ae_icon 		The icon you want to display on the MessageBox.
//	ae_button	Set of CommandButtons you want to display on the MessageBox.
//	ai_default  The default button.
//
//	Returns:  integer
//	Return value of the MessageBox.
//
//	Description:
//	Display a PowerScript MessageBox.  
//	Allow PFC MessageBoxes to be manipulated prior to their actual display.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return MessageBox(as_title, as_text, ae_icon, ae_button, ai_default)
end function

event getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			getfocus
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	If appropriate, notify the parent window that this
//						control got focus.
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

window 	lw_parent

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	//Notify the parent.
	of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		lw_parent.Dynamic Event pfc_ControlGotFocus (this)
	End If
End If

//If appropriate, select the entire text.
if ib_autoselect then
	this.Post Event pfc_selectall ()
end if


end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Destructor
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Perform cleanup,
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

of_SetDropDownCalendar(False)
of_SetDropDownCalculator(False)
end event

