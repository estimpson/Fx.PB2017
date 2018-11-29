$PBExportHeader$pfc_w_response.srw
$PBExportComments$PFC Response Window class
forward
global type pfc_w_response from w_master
end type
end forward

global type pfc_w_response from w_master
int X=214
int Y=221
int Width=2497
int Height=1492
WindowType WindowType=response!
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event pfc_default ( )
event pfc_cancel ( )
event pfc_apply ( )
end type
global pfc_w_response pfc_w_response

type variables

end variables

event pfc_cancel;call w_master::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_Cancel
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	This process disables the CloseQuery processing so that no
//						checks are done during the close process.
//
//		*Note:	The developer (on the descendant script) should code 
//					any specific actions prior to closing the window and then 
//					Close the window.
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

/* Allow window to close without the CloseQuery checks being performed */
ib_disableclosequery = True

end event

on pfc_w_response.create
call w_master::create
end on

on pfc_w_response.destroy
call w_master::destroy
end on

