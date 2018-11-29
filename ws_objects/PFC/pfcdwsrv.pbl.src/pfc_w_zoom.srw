$PBExportHeader$pfc_w_zoom.srw
$PBExportComments$PFC Zoom dialog window
forward
global type pfc_w_zoom from w_response
end type
type rb_200 from u_rb within pfc_w_zoom
end type
type rb_100 from u_rb within pfc_w_zoom
end type
type rb_75 from u_rb within pfc_w_zoom
end type
type rb_50 from u_rb within pfc_w_zoom
end type
type rb_25 from u_rb within pfc_w_zoom
end type
type st_1 from u_st within pfc_w_zoom
end type
type em_zoom from u_em within pfc_w_zoom
end type
type cb_ok from u_cb within pfc_w_zoom
end type
type cb_cancel from u_cb within pfc_w_zoom
end type
type cb_apply from u_cb within pfc_w_zoom
end type
type dw_preview from u_dw within pfc_w_zoom
end type
type gb_1 from groupbox within pfc_w_zoom
end type
type gb_3 from groupbox within pfc_w_zoom
end type
type cb_dlghelp from u_cb within pfc_w_zoom
end type
end forward

global type pfc_w_zoom from w_response
int X=850
int Y=444
int Width=1797
int Height=1008
boolean TitleBar=true
string Title="Zoom"
long BackColor=80263328
rb_200 rb_200
rb_100 rb_100
rb_75 rb_75
rb_50 rb_50
rb_25 rb_25
st_1 st_1
em_zoom em_zoom
cb_ok cb_ok
cb_cancel cb_cancel
cb_apply cb_apply
dw_preview dw_preview
gb_1 gb_1
gb_3 gb_3
cb_dlghelp cb_dlghelp
end type
global pfc_w_zoom pfc_w_zoom

type variables
Protected:
boolean	ib_dwrequestor
integer	ii_rc = -99
n_cst_zoomattrib	inv_zoomattrib


end variables

on pfc_w_zoom.create
int iCurrent
call super::create
this.rb_200=create rb_200
this.rb_100=create rb_100
this.rb_75=create rb_75
this.rb_50=create rb_50
this.rb_25=create rb_25
this.st_1=create st_1
this.em_zoom=create em_zoom
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_apply=create cb_apply
this.dw_preview=create dw_preview
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_200
this.Control[iCurrent+2]=this.rb_100
this.Control[iCurrent+3]=this.rb_75
this.Control[iCurrent+4]=this.rb_50
this.Control[iCurrent+5]=this.rb_25
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_zoom
this.Control[iCurrent+8]=this.cb_ok
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_apply
this.Control[iCurrent+11]=this.dw_preview
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.cb_dlghelp
end on

on pfc_w_zoom.destroy
call super::destroy
destroy(this.rb_200)
destroy(this.rb_100)
destroy(this.rb_75)
destroy(this.rb_50)
destroy(this.rb_25)
destroy(this.st_1)
destroy(this.em_zoom)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_apply)
destroy(this.dw_preview)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cb_dlghelp)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	Description:  Gets the zoom object passed to this window
//	and initializes the zoom window
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0   Added support for datastores
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_initialzoom

ib_disableclosequery = true

//////////////////////////////////////////////////////////////////////////////
// Get the zoom object from the message object
//////////////////////////////////////////////////////////////////////////////
inv_zoomattrib = message.PowerObjectParm

ib_dwrequestor = not (isNull (inv_zoomattrib.idw_obj) or not isValid (inv_zoomattrib.idw_obj))
if not ib_dwrequestor then
	if (isNull (inv_zoomattrib.ids_obj) or not isValid (inv_zoomattrib.ids_obj)) then
		inv_zoomattrib.ii_zoom = -1
		close (this)
	end if
end if

li_initialzoom = inv_zoomattrib.ii_zoom
inv_zoomattrib.ii_zoom = 0

//////////////////////////////////////////////////////////////////////////////
// Initialize preview area
//////////////////////////////////////////////////////////////////////////////
if ib_dwrequestor then
	dw_preview.dataobject = inv_zoomattrib.idw_obj.dataobject
	inv_zoomattrib.idw_obj.RowsCopy (1, inv_zoomattrib.idw_obj.RowCount(), primary!, &
		dw_preview, 1, primary!)
else
	dw_preview.dataobject = inv_zoomattrib.ids_obj.dataobject
	inv_zoomattrib.ids_obj.RowsCopy (1, inv_zoomattrib.ids_obj.RowCount(), primary!, &
		dw_preview, 1, primary!)
end if


dw_preview.object.datawindow.print.preview = true

//////////////////////////////////////////////////////////////////////////////
// Initialize zoom percentages
//////////////////////////////////////////////////////////////////////////////
choose case li_initialzoom

	case 200
		rb_200.checked = true

	case 100
		rb_100.checked = true

	case 75
		rb_75.checked = true

	case 50
		rb_50.checked = true

	case 25
		rb_25.checked = true

end choose

em_zoom.text = String (li_initialzoom) + "%"
dw_preview.object.datawindow.print.preview.zoom = li_initialzoom
end event

event close;call super::close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  close
//
//	Description:
//	Treat window close from control menu as cancel operation
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

// If the return code matches the default value,
// then window is currently being closed as a Cancel operation.
if ii_rc=-99 then
	this.event pfc_cancel ()
end if
end event

event pfc_cancel;call super::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_cancel
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//	Set the return code to 0 (cancel)
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

// Set the return code to mean the window was closed by a cancel operation.
ii_rc = 0
CloseWithReturn (this, ii_rc)
end event

event pfc_apply;call super::pfc_apply;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_apply
//
//	Description:  Apply zoom factor to requesting DataWindow
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0   Added support for datastores
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_string	lnv_string

lnv_string.of_GlobalReplace (em_zoom.text, "%", "")
if IsNumber (em_zoom.text) then
	inv_zoomattrib.ii_zoom = Integer (em_zoom.text)
else
	return
end if

if ib_dwrequestor then
	inv_zoomattrib.idw_obj.object.datawindow.print.preview.zoom = inv_zoomattrib.ii_zoom
else
	inv_zoomattrib.ids_obj.object.datawindow.print.preview.zoom = inv_zoomattrib.ii_zoom	
end if

ii_rc = inv_zoomattrib.ii_zoom
cb_apply.enabled = false
end event

event pfc_default;call super::pfc_default;this.event pfc_apply()
CloseWithReturn (this, ii_rc)
end event

type rb_200 from u_rb within pfc_w_zoom
int X=87
int Y=84
int Width=297
int Height=72
string Text="200%"
end type

event clicked;call u_rb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Enable apply button and update percentage
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

if this.checked then
	cb_apply.enabled = true
end if

dw_preview.object.datawindow.print.preview.zoom = 200

em_zoom.text = "200%"
end event

type rb_100 from u_rb within pfc_w_zoom
int X=87
int Y=164
int Width=297
int Height=72
string Text="100%"
end type

event clicked;call u_rb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Enable apply button and update percentage
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

if this.checked then
	cb_apply.enabled = true
end if

dw_preview.object.datawindow.print.preview.zoom = 100

em_zoom.text = "100%"
end event

type rb_75 from u_rb within pfc_w_zoom
int X=87
int Y=244
int Width=297
int Height=72
string Text="75%"
end type

event clicked;call u_rb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Enable apply button and update percentage
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

if this.checked then
	cb_apply.enabled = true
end if

dw_preview.object.datawindow.print.preview.zoom = 75

em_zoom.text = "75%"
end event

type rb_50 from u_rb within pfc_w_zoom
int X=87
int Y=324
int Width=297
int Height=72
string Text="50%"
end type

event clicked;call u_rb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Enable apply button and update percentage
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

if this.checked then
	cb_apply.enabled = true
end if

dw_preview.object.datawindow.print.preview.zoom = 50

em_zoom.text = "50%"
end event

type rb_25 from u_rb within pfc_w_zoom
int X=87
int Y=404
int Width=297
int Height=72
string Text="25%"
end type

event clicked;call u_rb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Enable apply button and update percentage
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

if this.checked then
	cb_apply.enabled = true
end if

dw_preview.object.datawindow.print.preview.zoom = 25

em_zoom.text = "25%"
end event

type st_1 from u_st within pfc_w_zoom
int X=87
int Y=528
int Width=302
int Height=72
string Text="Percent:"
end type

type em_zoom from u_em within pfc_w_zoom
event enchange pbm_enchange
int X=87
int Y=600
int TabOrder=20
string Mask="###"
boolean Spin=true
string DisplayData=""
string MinMax="10~~200"
end type

event enchange;call u_em::enchange;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  enchange
//
//	Description:  Update print preview
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

integer	li_zoom
string		ls_text
n_cst_string	lnv_string

ls_text = this.text
lnv_string.of_GlobalReplace (ls_text, "%", "")
if not IsNumber (ls_text) then
	return
end if

cb_apply.enabled = true
li_zoom = Integer (ls_text)

//////////////////////////////////////////////////////////////////////////////
// 200%
//////////////////////////////////////////////////////////////////////////////
if li_zoom = 200 then
	rb_200.checked = true
	rb_100.checked = false
	rb_75.checked = false
	rb_50.checked = false
	rb_25.checked = false
	return
end if

//////////////////////////////////////////////////////////////////////////////
// 100%
//////////////////////////////////////////////////////////////////////////////
if li_zoom = 100 then
	rb_200.checked = false
	rb_100.checked = true
	rb_75.checked = false
	rb_50.checked = false
	rb_25.checked = false
	return
end if

//////////////////////////////////////////////////////////////////////////////
// 75%
//////////////////////////////////////////////////////////////////////////////
if li_zoom = 75 then
	rb_200.checked = false
	rb_100.checked = false
	rb_75.checked = true
	rb_50.checked = false
	rb_25.checked = false
	return
end if

//////////////////////////////////////////////////////////////////////////////
// 50%
//////////////////////////////////////////////////////////////////////////////
if li_zoom = 50 then
	rb_200.checked = false
	rb_100.checked = false
	rb_75.checked = false
	rb_50.checked = true
	rb_25.checked = false
	return
end if

//////////////////////////////////////////////////////////////////////////////
// 25%
//////////////////////////////////////////////////////////////////////////////
if li_zoom = 25 then
	rb_200.checked = false
	rb_100.checked = false
	rb_75.checked = false
	rb_50.checked = false
	rb_25.checked = true
	return
end if

//////////////////////////////////////////////////////////////////////////////
// Custom percentage
//////////////////////////////////////////////////////////////////////////////
rb_200.checked = false
rb_100.checked = false
rb_75.checked = false
rb_50.checked = false
rb_25.checked = false

//////////////////////////////////////////////////////////////////////////////
// Preview
//////////////////////////////////////////////////////////////////////////////
dw_preview.object.datawindow.print.preview.zoom = li_zoom
end event

type cb_ok from u_cb within pfc_w_zoom
int X=242
int Y=784
int TabOrder=30
string Text="OK"
boolean Default=true
end type

event clicked;call u_cb::clicked;parent.event pfc_default()
end event

type cb_cancel from u_cb within pfc_w_zoom
int X=622
int Y=784
int TabOrder=40
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;parent.event pfc_cancel()
end event

type cb_apply from u_cb within pfc_w_zoom
int X=1001
int Y=784
int TabOrder=50
boolean Enabled=false
string Text="&Apply"
end type

event clicked;call u_cb::clicked;parent.event pfc_apply()
end event

type dw_preview from u_dw within pfc_w_zoom
int X=498
int Y=96
int Width=1184
int Height=596
int TabOrder=0
boolean HScrollBar=true
end type

event constructor;call u_dw::constructor;this.of_SetUpdateable (false)
end event

type gb_1 from groupbox within pfc_w_zoom
int X=453
int Y=24
int Width=1280
int Height=708
string Text="Preview"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within pfc_w_zoom
int X=32
int Y=24
int Width=379
int Height=708
int TabOrder=10
string Text="Zoom To"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_dlghelp from u_cb within pfc_w_zoom
int X=1381
int Y=784
int TabOrder=60
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

showHelp ("pfcdlg.hlp", topic!, 1400)
end event

