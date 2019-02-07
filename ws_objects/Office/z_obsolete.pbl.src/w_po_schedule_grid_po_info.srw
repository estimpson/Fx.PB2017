$PBExportHeader$w_po_schedule_grid_po_info.srw
$PBExportComments$(mrs) Windows for creating new PO detail info.
forward
global type w_po_schedule_grid_po_info from Window
end type
type cb_save from commandbutton within w_po_schedule_grid_po_info
end type
type cb_close_screen from commandbutton within w_po_schedule_grid_po_info
end type
type cb_close from commandbutton within w_po_schedule_grid_po_info
end type
end forward

global type w_po_schedule_grid_po_info from Window
int X=178
int Y=260
int Width=2560
int Height=1396
boolean TitleBar=true
string Title="PO schedule grid detail information"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=popup!
event ue_initialize pbm_custom01
event ue_close pbm_custom02
cb_save cb_save
cb_close_screen cb_close_screen
cb_close cb_close
end type
global w_po_schedule_grid_po_info w_po_schedule_grid_po_info

type variables
string	is_type
boolean	ib_success
u_crosstab_po_grid_list_of_po_per_vendor	iuo_po
u_crosstab_po_grid_list_of_dropship		iuo_dropship
end variables

forward prototypes
public subroutine wf_initialize ()
public subroutine wf_center (any auo, integer ai_width, integer ai_height)
public subroutine wf_save ()
end prototypes

on ue_initialize;this.wf_initialize()
end on

on ue_close;if isvalid( iuo_po ) then
	closeuserobject( iuo_po )
end if

if isvalid( iuo_dropship) then
	closeuserobject( iuo_dropship )
end if

close( this )
end on

public subroutine wf_initialize ();/*
Description	:	To initialize the detail information screen
Author		:	Jim Wu
Start Date	:	06/07/96
Modification:
*/


/* Declaration */
s_parm_list	lstr_parm

string		ls_vendor

/* Initialization */
if classname(message.powerobjectparm) <> classname(lstr_parm) then
	messagebox( monsys.msg_title, 'Parameter class dismatches.', &
					information! )
	close( this )
end if
 
lstr_parm	= message.powerobjectparm

is_type		= lstr_parm.s_type
ib_success	= FALSE

/* Main Process */

if is_type	= 'DropShip' then
	openuserobjectwithparm( iuo_dropship, lstr_parm, 1, 1 )
	ib_success	= 	iuo_dropship.ib_success
	if ib_success then
		wf_center( iuo_dropship, iuo_dropship.width, iuo_dropship.height )
	end if
else
	openuserobjectwithparm( iuo_po, lstr_parm, 1, 1 )
	ib_success	= iuo_po.ib_success 
	if ib_success then
		wf_center( iuo_po, iuo_po.width, iuo_po.height )
	end if
end if

if not ib_success then
	this.triggerevent( 'ue_close' )
end if
end subroutine

public subroutine wf_center (any auo, integer ai_width, integer ai_height);integer	li_x, &
			li_y

li_x	= (this.width - ai_width) / 2
li_y	= (this.height - ai_height ) / 2

if li_y	> 100 then
	li_y	= 100
end if

auo.DYNAMIC move( li_x, li_y )

end subroutine

public subroutine wf_save ();if is_type	= 'DropShip' then
	iuo_dropship.triggerevent( 'ue_save' )
else
	iuo_po.triggerevent( 'ue_save' )
end if
end subroutine

on close;w_po_schedule_grid.uo_crosstab.PostEvent ( "ue_recalc_one_item" )
end on

on deactivate;this.triggerevent( 'ue_close' )
end on

on w_po_schedule_grid_po_info.create
this.cb_save=create cb_save
this.cb_close_screen=create cb_close_screen
this.cb_close=create cb_close
this.Control[]={this.cb_save,&
this.cb_close_screen,&
this.cb_close}
end on

on w_po_schedule_grid_po_info.destroy
destroy(this.cb_save)
destroy(this.cb_close_screen)
destroy(this.cb_close)
end on

on open;this.triggerevent( 'ue_initialize' )
end on

type cb_save from commandbutton within w_po_schedule_grid_po_info
int X=1920
int Y=1136
int Width=247
int Height=108
int TabOrder=10
string Text="&Save"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_save()
end on

type cb_close_screen from commandbutton within w_po_schedule_grid_po_info
int X=2231
int Y=1136
int Width=247
int Height=108
int TabOrder=20
string Text="&Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;parent.triggerevent( 'ue_close' )
end on

type cb_close from commandbutton within w_po_schedule_grid_po_info
int X=2267
int Y=1168
int Width=247
int Height=108
int TabOrder=30
boolean Visible=false
string Text="&Close"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close( parent )
end on

