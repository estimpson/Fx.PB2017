$PBExportHeader$pfc_w_dwpropertyservices.srw
$PBExportComments$PFC DataWindow Property - The service window
forward
global type pfc_w_dwpropertyservices from w_response
end type
type cb_ok from u_cb within pfc_w_dwpropertyservices
end type
type tab_property from u_tab_dwproperty_srv within pfc_w_dwpropertyservices
end type
type cb_dlghelp from u_cb within pfc_w_dwpropertyservices
end type
type cb_cancel from u_cb within pfc_w_dwpropertyservices
end type
type tab_property from u_tab_dwproperty_srv within pfc_w_dwpropertyservices
end type
end forward

global type pfc_w_dwpropertyservices from w_response
int X=1445
int Y=452
int Width=1417
int Height=1376
long BackColor=80263328
cb_ok cb_ok
tab_property tab_property
cb_dlghelp cb_dlghelp
cb_cancel cb_cancel
end type
global pfc_w_dwpropertyservices pfc_w_dwpropertyservices

type variables
Protected:

n_cst_dwpropertyattrib inv_attrib

end variables

on pfc_w_dwpropertyservices.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.tab_property=create tab_property
this.cb_dlghelp=create cb_dlghelp
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.tab_property
this.Control[iCurrent+3]=this.cb_dlghelp
this.Control[iCurrent+4]=this.cb_cancel
end on

on pfc_w_dwpropertyservices.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.tab_property)
destroy(this.cb_dlghelp)
destroy(this.cb_cancel)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	Description:
//	 Open the Property window.
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

integer 	li_rc
integer	li_row
u_dw		ldw_obj
string	ls_dataobject

// Get the Message.
If IsValid(Message.PowerObjectParm) Then
	If Message.PowerObjectParm.ClassName() = inv_attrib.ClassName() Then
		inv_attrib = Message.PowerObjectParm
	End If
End If

// There is nothing to update.
ib_disableclosequery = True
of_SetUpdateable(False)

// Validate.
If IsNull(inv_attrib) Or Not IsValid(inv_attrib) Then
	Close (this)
End If
If IsNull(inv_attrib.idw_requestor) or Not IsValid(inv_attrib.idw_requestor) Then 
	Close(this)
End If
// If not type u_dw Then Close(This)

// Place the window.
If IsValid(inv_attrib.iw_main) Then
	this.Move (inv_attrib.iw_main.X + 200, inv_attrib.iw_main.Y + 250)
End If

tab_property.Event pfc_PropertyStart(inv_attrib)

tab_property.Event pfc_PropertyOpen()
end event

event pfc_apply;call super::pfc_apply;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_apply
//
//	Description:
//	 Apply all requested changes.
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

tab_property.Event pfc_PropertyApply()
end event

event pfc_default;call super::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_default
//
//	Description:
//	 Perform all requested changes.
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

// Validate all data.
If tab_property.Event pfc_PropertyValidation() <= 0 Then
	// Do not close.
	Return
End If

// Apply the changes.
this.Event pfc_apply()

// Close the window.
Close(this)
end event

event pfc_cancel;call super::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_Cancel
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:
//	Close the window.
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

Close(this)

end event

type cb_ok from u_cb within pfc_w_dwpropertyservices
int X=256
int Y=1152
int TabOrder=20
string Text="OK"
boolean Default=true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:
//	 Perform all requested changes.
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

Parent.Event pfc_default()
end event

type tab_property from u_tab_dwproperty_srv within pfc_w_dwpropertyservices
int X=18
int Y=20
int Width=1335
int Height=1096
int TabOrder=10
end type

type cb_dlghelp from u_cb within pfc_w_dwpropertyservices
int X=1001
int Y=1152
int TabOrder=30
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

showHelp ("pfcdlg.hlp", topic!, 10400)
end event

type cb_cancel from u_cb within pfc_w_dwpropertyservices
int X=626
int Y=1152
int TabOrder=2
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:
//	 Cancel the operation.
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

Parent.Event pfc_cancel()
end event

