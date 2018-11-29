$PBExportHeader$pfc_w_sqlspyinspect.srw
$PBExportComments$PFC SQL Spy Inspect window
forward
global type pfc_w_sqlspyinspect from w_response
end type
type cb_step from u_cb within pfc_w_sqlspyinspect
end type
type cb_cancel from u_cb within pfc_w_sqlspyinspect
end type
type cb_cancelall from u_cb within pfc_w_sqlspyinspect
end type
type mle_currentheading from u_mle within pfc_w_sqlspyinspect
end type
type mle_currentsyntax from u_mle within pfc_w_sqlspyinspect
end type
type cb_resume from u_cb within pfc_w_sqlspyinspect
end type
type cb_dlghelp from u_cb within pfc_w_sqlspyinspect
end type
end forward

global type pfc_w_sqlspyinspect from w_response
int Width=1614
int Height=812
boolean TitleBar=true
string Title="SQLSpy - Inspect Current SQL"
long BackColor=80263328
boolean ControlMenu=false
cb_step cb_step
cb_cancel cb_cancel
cb_cancelall cb_cancelall
mle_currentheading mle_currentheading
mle_currentsyntax mle_currentsyntax
cb_resume cb_resume
cb_dlghelp cb_dlghelp
end type
global pfc_w_sqlspyinspect pfc_w_sqlspyinspect

type variables

end variables

forward prototypes
protected subroutine of_populatebeforeclose (commandbutton acb_pressed)
end prototypes

protected subroutine of_populatebeforeclose (commandbutton acb_pressed);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_populatebeforeclose
//
//	Access:  		protected
//
//	Arguments:
//	acb_pressed		The command button pressed.
//
//	Returns:  		(None)
//	
//	Description:	Close this window after updating the SQLspy service of all
//						relevant information.
//
//		Note:			Close with return values-
//						0 caller's processing should continue as normal.
//						1 If functionality available, caller's proccessing should stop.
//						2 Caller's processing should skip this request and
//						  execute the next request (if available).
//						-1 if an error occurs.
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

integer li_rc = -1

//Notify the SQLSpy service of any updates
gnv_app.inv_debug.inv_sqlspy.of_SetCurrentHeading(mle_currentheading.Text)
gnv_app.inv_debug.inv_sqlspy.of_SetCurrentSyntax(mle_currentsyntax.Text)

//Set the return code.
If acb_pressed = cb_cancel Then
	li_rc = 2
ElseIf acb_pressed = cb_cancelall Then
	li_rc	= 1
ElseIf acb_pressed = cb_step Then
	li_rc = 0
ElseIf acb_pressed = cb_resume Then
	//Change the BatchMode in the SQLspy service.
	gnv_app.inv_debug.inv_sqlspy.of_SetBatchMode (True)
	li_rc	= 0
End If

//Close this window with the appropriate return code.
CloseWithReturn (this, li_rc)

Return
end subroutine

on pfc_w_sqlspyinspect.create
int iCurrent
call super::create
this.cb_step=create cb_step
this.cb_cancel=create cb_cancel
this.cb_cancelall=create cb_cancelall
this.mle_currentheading=create mle_currentheading
this.mle_currentsyntax=create mle_currentsyntax
this.cb_resume=create cb_resume
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_step
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_cancelall
this.Control[iCurrent+4]=this.mle_currentheading
this.Control[iCurrent+5]=this.mle_currentsyntax
this.Control[iCurrent+6]=this.cb_resume
this.Control[iCurrent+7]=this.cb_dlghelp
end on

on pfc_w_sqlspyinspect.destroy
call super::destroy
destroy(this.cb_step)
destroy(this.cb_cancel)
destroy(this.cb_cancelall)
destroy(this.mle_currentheading)
destroy(this.mle_currentsyntax)
destroy(this.cb_resume)
destroy(this.cb_dlghelp)
end on

event pfc_preopen;call super::pfc_preopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_pre_open
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Handle processing that occurs before the open event.
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

// Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

//Set focus on the Current SQLSyntax detail
SetFocus(mle_currentsyntax)

//Prepare window for user interaction.
mle_currentheading.Text = gnv_app.inv_debug.inv_sqlspy.of_GetCurrentHeading()
mle_currentsyntax.Text = gnv_app.inv_debug.inv_sqlspy.of_GetCurrentSyntax()

//If appropriate, start the Preference service.
If gnv_app.of_IsRegistryAvailable() Then
	If Len(gnv_app.of_GetUserKey())> 0 Then 
		of_SetPreference(True)
	End If
Else
	If Len(gnv_app.of_GetUserIniFile()) > 0 Then
		of_SetPreference(True)
	End If
End If

end event

type cb_step from u_cb within pfc_w_sqlspyinspect
int X=1202
int Y=44
int TabOrder=30
string Text="&Step"
boolean Default=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Call window function to Close this window after 
//						populating with the appropriate return values.
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

//Populate Communications object before closing the window.
of_populatebeforeclose(this)

end event

type cb_cancel from u_cb within pfc_w_sqlspyinspect
int X=1202
int Y=280
int TabOrder=50
string Text="&Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Call window function to Close this window after 
//						populating with the appropriate return values.
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

//Populate Communications object before closing the window.
of_populatebeforeclose(this)

end event

type cb_cancelall from u_cb within pfc_w_sqlspyinspect
int X=1202
int Y=388
int TabOrder=60
string Text="Cancel &All"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Call window function to Close this window after 
//						populating with the appropriate return values.
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

//Populate Communications object before closing the window.
of_populatebeforeclose(this)

end event

type mle_currentheading from u_mle within pfc_w_sqlspyinspect
int X=32
int Y=40
int Width=1120
int Height=84
int TabOrder=10
boolean AutoVScroll=false
boolean HideSelection=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=1090519039
end type

type mle_currentsyntax from u_mle within pfc_w_sqlspyinspect
int X=32
int Y=148
int Width=1120
int Height=532
int TabOrder=20
boolean VScrollBar=true
end type

type cb_resume from u_cb within pfc_w_sqlspyinspect
int X=1202
int Y=152
int TabOrder=40
string Text="&Resume"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Call window function to Close this window after 
//						populating with the appropriate return values.
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

//Populate Communications object before closing the window.
of_populatebeforeclose(this)

end event

type cb_dlghelp from u_cb within pfc_w_sqlspyinspect
int X=1202
int Y=516
int TabOrder=70
string Text="&Help"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Description:
//	Display PFC dialog help
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

showHelp ("pfcdlg.hlp", topic!, 10600)
end event

