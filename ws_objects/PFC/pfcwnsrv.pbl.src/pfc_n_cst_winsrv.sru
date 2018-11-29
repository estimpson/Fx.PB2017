$PBExportHeader$pfc_n_cst_winsrv.sru
$PBExportComments$PFC Base Window service
forward
global type pfc_n_cst_winsrv from n_base
end type
end forward

global type pfc_n_cst_winsrv from n_base
end type
global pfc_n_cst_winsrv pfc_n_cst_winsrv

type variables
Protected:
w_master		iw_requestor
end variables

forward prototypes
public function integer of_center ()
public function integer of_setrequestor (w_master aw_requestor)
end prototypes

public function integer of_center ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Center
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Centers the window relative to the dimensions of the
//	current display resolution.
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

Integer		li_screenheight
Integer		li_screenwidth
Integer		li_rc
Integer		li_x = 1
Integer		li_y = 1
environment	lenv_obj

//Check for a window association with this object
If IsNull(iw_requestor) Or Not IsValid (iw_requestor) Then
	Return -1
End If

// Get environment
If GetEnvironment (lenv_obj) = -1 Then
	Return -1
End If

// Determine current screen resolution and validate
li_screenheight = PixelsToUnits (lenv_obj.screenheight, YPixelsToUnits!)
li_screenwidth = PixelsToUnits (lenv_obj.screenwidth, XPixelsToUnits!)
If Not (li_screenheight > 0) or Not (li_screenwidth > 0) Then
	Return -1
End If

// Get center points
If li_screenwidth > iw_requestor.Width Then
	li_x = (li_screenwidth / 2) - (iw_requestor.Width / 2)
End If
If li_screenheight > iw_requestor.Height Then
	li_y = (li_screenheight / 2) - (iw_requestor.Height / 2)
End If

// Center window
li_rc = iw_requestor.Move (li_x, li_y)
If li_rc <> 1 Then
	Return -1
End If

Return 1
end function

public function integer of_setrequestor (w_master aw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetRequestor
//
//	Access:  		public
//
//	Arguments:		
//	aw_requestor	The window requesting this service
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Associates a window with this service.
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

If IsNull(aw_requestor) Or Not IsValid(aw_requestor) Then
	Return -1
End If

iw_requestor = aw_requestor
Return 1
end function

on pfc_n_cst_winsrv.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_winsrv.destroy
TriggerEvent( this, "destructor" )
end on

