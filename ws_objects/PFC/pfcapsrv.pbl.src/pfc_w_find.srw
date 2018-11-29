$PBExportHeader$pfc_w_find.srw
$PBExportComments$PFC Find window
forward
global type pfc_w_find from w_popup
end type
type st_findwhere from u_st within pfc_w_find
end type
type st_searchfor from u_st within pfc_w_find
end type
type ddlb_findwhere from u_ddlb within pfc_w_find
end type
type st_searchdirection from u_st within pfc_w_find
end type
type cbx_wholeword from u_cbx within pfc_w_find
end type
type cbx_matchcase from u_cbx within pfc_w_find
end type
type cb_findnext from u_cb within pfc_w_find
end type
type cb_cancel from u_cb within pfc_w_find
end type
type sle_findwhat from u_sle within pfc_w_find
end type
type ddlb_searchdirection from pfc_u_ddlb within pfc_w_find
end type
type cb_dlghelp from u_cb within pfc_w_find
end type
end forward

global type pfc_w_find from w_popup
int X=384
int Y=560
int Width=1851
int Height=592
boolean TitleBar=true
string Title="Find"
long BackColor=80263328
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event pfc_default ( )
st_findwhere st_findwhere
st_searchfor st_searchfor
ddlb_findwhere ddlb_findwhere
st_searchdirection st_searchdirection
cbx_wholeword cbx_wholeword
cbx_matchcase cbx_matchcase
cb_findnext cb_findnext
cb_cancel cb_cancel
sle_findwhat sle_findwhat
ddlb_searchdirection ddlb_searchdirection
cb_dlghelp cb_dlghelp
end type
global pfc_w_find pfc_w_find

type variables
Public:
n_cst_findattrib inv_findattrib

end variables

event pfc_default;call super::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event: 			pfc_default
//
//	Arguments: 		None
//
//	Returns:  		None
//
//	Description:  gather all inforamtion entered by the user and call event
// 					on requestor to search for the text
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

//Set Find Where index (this index is the array number the user selected).
inv_findattrib.ii_lookindex = ddlb_findwhere.finditem(ddlb_findwhere.text,1)

//Set text to Find What.
inv_findattrib.is_find = sle_findwhat.text

//Set the Direction value.
inv_findattrib.is_direction = ddlb_searchdirection.text

//Set the WholeWord flag.
inv_findattrib.ib_wholeword = cbx_wholeword.Checked

//Set the MatchCase flag.
inv_findattrib.ib_matchcase = cbx_matchcase.Checked

//Call event to process.
If inv_findattrib.ipo_requestor.dynamic event pfc_findnext(inv_findattrib) = 0 Then
	of_Messagebox("pfc_find_finishsearch", this.Title, &
		this.Title+" has finished searching.", Information!, OK!, 1)
end if

end event

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	Arguments: none
//	
// Returns:  none
//
//	Description:  	This event is used to initialize the window using the 
//						passed in nvo-structure.
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0	Corrected clipping problems when lower controls not visible
//			Adjust resizing of window to accomodate help button
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer 	li_count=0
integer	li_i=0
integer	li_adjust=0
integer	li_windowHeightAdjust
integer	li_origWindowHeight

li_windowHeightAdjust = 50
li_origWindowHeight = this.height

//Make a local copy of attributes.
inv_findattrib = message.powerobjectparm

//Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

//////////////////////////////////////////////////////////////////////////////
// Set the Enabled/Visible attributes for the appropriate controls.
//////////////////////////////////////////////////////////////////////////////

//The Whole Word control.
cbx_wholeword.Visible = inv_findattrib.ib_wholewordvisible
cbx_wholeword.Enabled = inv_findattrib.ib_wholewordenabled

//The Match Case control.
cbx_matchcase.Visible = inv_findattrib.ib_matchcasevisible
cbx_matchcase.Enabled = inv_findattrib.ib_matchcaseenabled

//The lookup controls.
ddlb_findwhere.Visible = inv_findattrib.ib_lookvisible
st_findwhere.Visible = inv_findattrib.ib_lookvisible
ddlb_findwhere.Enabled = inv_findattrib.ib_lookenabled
st_findwhere.Enabled = inv_findattrib.ib_lookenabled

//The direction controls.
ddlb_searchdirection.Visible = inv_findattrib.ib_directionvisible
st_searchdirection.Visible = inv_findattrib.ib_directionvisible
ddlb_searchdirection.Enabled = inv_findattrib.ib_directionenabled
st_searchdirection.Enabled = inv_findattrib.ib_directionenabled

//////////////////////////////////////////////////////////////////////////////
// Initialize controls with the appropriate data.
//////////////////////////////////////////////////////////////////////////////

//Set the lookup values.
If ddlb_findwhere.visible Then
	li_count = upperbound(inv_findattrib.is_lookdata)
	if li_count >0  THEN 
		for li_i=1 TO li_count
			ddlb_findwhere.additem(inv_findattrib.is_lookdisplay[li_i])
		next
	end if
	If inv_findattrib.ii_lookindex > 0 Then
		ddlb_findwhere.SelectItem(inv_findattrib.ii_lookindex)	
	Else
		ddlb_findwhere.SelectItem(1)	
	End If
End If

//Set text to Find What.
sle_findwhat.text = inv_findattrib.is_find

//Set the WholeWord flag.
If cbx_wholeword.Visible Then
	cbx_wholeword.Checked = inv_findattrib.ib_wholeword
End If

//Set the MatchCase flag.
If cbx_matchcase.Visible Then
	cbx_matchcase.Checked = inv_findattrib.ib_matchcase
End If	

//Set the Direction attribute.
If ddlb_searchdirection.visible Then
	If Lower(inv_findattrib.is_direction)= 'up' Then
		ddlb_searchdirection.Text = 'Up'
	Else
		ddlb_searchdirection.Text = 'Down'
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Resize window and Move controls, if appropriate.
//////////////////////////////////////////////////////////////////////////////

//If the lookup controls are not visible, moving of other controls is required.
if ddlb_findwhere.visible = False then
	// calculate Y position to adjust.
	li_adjust = sle_findwhat.y - ddlb_findwhere.y

	// move other controls up.
	cbx_matchcase.y = cbx_matchcase.y - li_adjust
	cbx_wholeword.y = cbx_wholeword.y - li_adjust
	ddlb_searchdirection.y = ddlb_searchdirection.y - li_adjust
	sle_findwhat.y = sle_findwhat.y - li_adjust
	st_searchdirection.y = st_searchdirection.y - li_adjust
	st_searchfor.y = st_searchfor.y - li_adjust

	//Resize the window to match the adjustment
	this.height = this.height - li_windowHeightAdjust
	
	//Set focus on the appropriate control.
	sle_findwhat.SetFocus()	
end if

//If the wholeword is not visible, move the matchcase control.
If cbx_wholeword.visible = False and cbx_matchcase.Visible Then
	cbx_matchcase.Y = cbx_wholeword.Y

	// Only resize window height if not previously resized
	if this.height = li_origWindowHeight then
		this.height = this.height - li_windowHeightAdjust
	end if
End If

//If all bottom conrols are not visible, adjust the size of the window.
If ddlb_searchdirection.Visible=False And cbx_wholeword.visible = False And &
	cbx_matchcase.Visible= False Then

	// Only resize window height if not previously resized
	if this.height = li_origWindowHeight then
		this.height = this.height - li_windowHeightAdjust
	end if
End If
end event

on pfc_w_find.create
int iCurrent
call super::create
this.st_findwhere=create st_findwhere
this.st_searchfor=create st_searchfor
this.ddlb_findwhere=create ddlb_findwhere
this.st_searchdirection=create st_searchdirection
this.cbx_wholeword=create cbx_wholeword
this.cbx_matchcase=create cbx_matchcase
this.cb_findnext=create cb_findnext
this.cb_cancel=create cb_cancel
this.sle_findwhat=create sle_findwhat
this.ddlb_searchdirection=create ddlb_searchdirection
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_findwhere
this.Control[iCurrent+2]=this.st_searchfor
this.Control[iCurrent+3]=this.ddlb_findwhere
this.Control[iCurrent+4]=this.st_searchdirection
this.Control[iCurrent+5]=this.cbx_wholeword
this.Control[iCurrent+6]=this.cbx_matchcase
this.Control[iCurrent+7]=this.cb_findnext
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.sle_findwhat
this.Control[iCurrent+10]=this.ddlb_searchdirection
this.Control[iCurrent+11]=this.cb_dlghelp
end on

on pfc_w_find.destroy
call super::destroy
destroy(this.st_findwhere)
destroy(this.st_searchfor)
destroy(this.ddlb_findwhere)
destroy(this.st_searchdirection)
destroy(this.cbx_wholeword)
destroy(this.cbx_matchcase)
destroy(this.cb_findnext)
destroy(this.cb_cancel)
destroy(this.sle_findwhat)
destroy(this.ddlb_searchdirection)
destroy(this.cb_dlghelp)
end on

type st_findwhere from u_st within pfc_w_find
int X=32
int Y=48
int Width=288
int Height=72
string Text="Find wher&e"
long BackColor=79416533
end type

type st_searchfor from u_st within pfc_w_find
int X=32
int Y=176
int Width=288
int Height=72
string Text="Fi&nd what"
long BackColor=79416533
end type

type ddlb_findwhere from u_ddlb within pfc_w_find
int X=320
int Y=48
int Width=1056
int Height=308
int TabOrder=10
boolean Sorted=false
int Accelerator=101
end type

type st_searchdirection from u_st within pfc_w_find
int X=32
int Y=304
int Width=288
int Height=72
string Text="&Search"
long BackColor=79416533
end type

type cbx_wholeword from u_cbx within pfc_w_find
int X=864
int Y=312
int Width=443
int Height=72
int TabOrder=40
string Text="Whole &Word"
long BackColor=79416533
end type

type cbx_matchcase from u_cbx within pfc_w_find
int X=864
int Y=404
int Width=443
int Height=72
int TabOrder=50
string Text="Match &Case  "
long BackColor=79416533
end type

type cb_findnext from u_cb within pfc_w_find
int X=1435
int Y=48
int TabOrder=60
string Text="&Find Next"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			clicked
//
//	Arguments: 		None
//	
//	Returns:  		None
//
//	Description:  	Perform the find next functionality.
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

Parent.Event pfc_Default()
end event

type cb_cancel from u_cb within pfc_w_find
int X=1435
int Y=164
int TabOrder=70
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event: 		 	clicked
//
//	Arguments: 		None
//
//	Returns:  		None
//
//	Description:  	Close this window
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

Close(Parent)
end event

type sle_findwhat from u_sle within pfc_w_find
int X=320
int Y=176
int Width=1056
int Height=80
int TabOrder=20
int Accelerator=110
end type

type ddlb_searchdirection from pfc_u_ddlb within pfc_w_find
int X=320
int Y=304
int Height=208
int TabOrder=30
boolean Sorted=false
int Accelerator=115
long BackColor=1090519039
string Item[]={"Down",&
"Up"}
end type

type cb_dlghelp from u_cb within pfc_w_find
int X=1435
int Y=280
int TabOrder=80
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

showHelp ("pfcdlg.hlp", topic!, 400)
end event

