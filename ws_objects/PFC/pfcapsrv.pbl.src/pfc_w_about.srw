$PBExportHeader$pfc_w_about.srw
$PBExportComments$PFC About window
forward
global type pfc_w_about from w_response
end type
type p_about from u_p within pfc_w_about
end type
type st_application from u_st within pfc_w_about
end type
type st_version from u_st within pfc_w_about
end type
type cb_ok from u_cb within pfc_w_about
end type
type st_copyright from u_st within pfc_w_about
end type
end forward

global type pfc_w_about from w_response
int X=997
int Y=540
int Width=1701
int Height=836
boolean TitleBar=true
string Title="About"
long BackColor=80263328
p_about p_about
st_application st_application
st_version st_version
cb_ok cb_ok
st_copyright st_copyright
end type
global pfc_w_about pfc_w_about

type variables
Protected:
n_cst_aboutattrib	inv_aboutattrib
end variables

event pfc_default;call w_response::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_default
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:  Performs the default operation.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation
//
//////////////////////////////////////////////////////////////////////////////

//Close the About window
Close (this)
end event

on pfc_w_about.create
int iCurrent
call super::create
this.p_about=create p_about
this.st_application=create st_application
this.st_version=create st_version
this.cb_ok=create cb_ok
this.st_copyright=create st_copyright
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_about
this.Control[iCurrent+2]=this.st_application
this.Control[iCurrent+3]=this.st_version
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.st_copyright
end on

on pfc_w_about.destroy
call super::destroy
destroy(this.p_about)
destroy(this.st_application)
destroy(this.st_version)
destroy(this.cb_ok)
destroy(this.st_copyright)
end on

event open;call w_response::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:  Open the About window with the appropriate attributes.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation
//
//////////////////////////////////////////////////////////////////////////////

//Get the PowerObjectParm.
inv_aboutattrib = Message.PowerObjectParm

// Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

// Display the Application bitmap
If Len(inv_aboutattrib.is_logo) > 0 Then
	p_about.PictureName = inv_aboutattrib.is_logo
End If

// Display the appropriate application name.
If Len(inv_aboutattrib.is_application) > 0 Then
	st_application.text = inv_aboutattrib.is_application
	this.Title = 'About '+ inv_aboutattrib.is_application
Else
	st_application.text = ''
	this.Title = 'About'
End If

// Display the appropriate application version number.
If Len(inv_aboutattrib.is_version) > 0 Then
	st_version.text = inv_aboutattrib.is_version
Else
	st_version.text = ''
End If

// Display the appropriate copyright message.
If Len(inv_aboutattrib.is_copyright) > 0 Then
	st_copyright.text = inv_aboutattrib.is_copyright
Else
	st_copyright.text = ''
End If

end event

event pfc_cancel;call super::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_credits
//
//	Arguments:  Powersoft Companion Products development
//
//	Returns:  PFC
//
//	Description:
//	Lists the PFC development team members
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Second version
//
//////////////////////////////////////////////////////////////////////////////
//
//	PFC Development team
//
//	Project leaders:
//	Mark Overbey
//	Claudio Quant
//
//	Companion Products manager:
//	Robert Burgess
//
//	Other developers:
// Brian Grimm
//	Jane Cantz
//	Tim Christodolopolous
//	Chris Hester
//	Rollin Morris
//	Alex Whitney
//
//	Special thanks also to everyone who contributed to the 
//	design and development of PFC.
//
//////////////////////////////////////////////////////////////////////////////
end event

type p_about from u_p within pfc_w_about
int X=23
int Y=24
int Width=274
int Height=244
boolean OriginalSize=true
end type

type st_application from u_st within pfc_w_about
int X=402
int Y=56
int Width=1216
int Height=72
string Text="Application name..."
long TextColor=33554432
long BackColor=79741120
end type

type st_version from u_st within pfc_w_about
int X=402
int Y=128
int Width=1216
int Height=72
string Text="Version message..."
long TextColor=33554432
long BackColor=79741120
end type

type cb_ok from u_cb within pfc_w_about
int X=1280
int Y=612
int TabOrder=20
string Text="OK"
boolean Default=true
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Execute the default functionality.
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

parent.Event pfc_default ()
end event

type st_copyright from u_st within pfc_w_about
int X=402
int Y=200
int Width=1216
int Height=224
string Text="Copyright message..."
long TextColor=33554432
long BackColor=79741120
end type

