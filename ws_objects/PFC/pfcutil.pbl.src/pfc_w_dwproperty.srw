$PBExportHeader$pfc_w_dwproperty.srw
$PBExportComments$PFC DataWindow Property - The main window
forward
global type pfc_w_dwproperty from w_response
end type
type cb_ok from u_cb within pfc_w_dwproperty
end type
type tab_property from u_tab_dwproperty within pfc_w_dwproperty
end type
type cb_dlghelp from u_cb within pfc_w_dwproperty
end type
type tab_property from u_tab_dwproperty within pfc_w_dwproperty
end type
end forward

global type pfc_w_dwproperty from w_response
int Width=1307
int Height=1592
boolean TitleBar=true
string Title="DataWindow Properties - "
long BackColor=80263328
boolean ControlMenu=false
event type integer pfc_applyothers ( string as_servicename,  boolean ab_desiredstate )
cb_ok cb_ok
tab_property tab_property
cb_dlghelp cb_dlghelp
end type
global pfc_w_dwproperty pfc_w_dwproperty

type variables
Protected:

n_cst_dwpropertyattrib inv_attrib

end variables

on pfc_w_dwproperty.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.tab_property=create tab_property
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.tab_property
this.Control[iCurrent+3]=this.cb_dlghelp
end on

on pfc_w_dwproperty.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.tab_property)
destroy(this.cb_dlghelp)
end on

event open;integer 	li_rc
integer	li_row
u_dw		ldw_obj
string	ls_dataobject

SetPointer (HourGlass!)

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

// Update the title to include the databoject name.
this.Title += ' ' + inv_attrib.idw_requestor.DataObject

// Perform Initialize.
li_rc = tab_property.Event pfc_PropertyStart(inv_attrib)
If li_rc <= 0 Then 
	Close(This)
	Return
End If

// Reset the information on the tab/tabpages.
li_rc = tab_property.Event pfc_PropertyOpen()

Return

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

// Apply the changes.
this.Event pfc_apply()

// Close the window.
Close(this)
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

event pfc_cancel;call super::pfc_cancel;Close(This)
end event

type cb_ok from u_cb within pfc_w_dwproperty
int X=512
int Y=1368
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

type tab_property from u_tab_dwproperty within pfc_w_dwproperty
int X=18
int Y=28
int TabOrder=10
end type

type cb_dlghelp from u_cb within pfc_w_dwproperty
int X=891
int Y=1368
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

int	li_helpindex

// Determine help index based on selected tab
li_helpindex = (tab_property.selectedTab * 100) + 10000

showHelp ("pfcdlg.hlp", topic!, li_helpindex)
end event

