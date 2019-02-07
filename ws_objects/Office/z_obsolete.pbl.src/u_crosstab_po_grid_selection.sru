$PBExportHeader$u_crosstab_po_grid_selection.sru
$PBExportComments$(mrs) Added the vendor information display ddlb
forward
global type u_crosstab_po_grid_selection from UserObject
end type
type ddlb_plant from dropdownlistbox within u_crosstab_po_grid_selection
end type
type ddlb_mode from dropdownlistbox within u_crosstab_po_grid_selection
end type
type cbx_batch from checkbox within u_crosstab_po_grid_selection
end type
type st_2 from statictext within u_crosstab_po_grid_selection
end type
type st_1 from statictext within u_crosstab_po_grid_selection
end type
type st_time10 from statictext within u_crosstab_po_grid_selection
end type
type st_time8 from statictext within u_crosstab_po_grid_selection
end type
type st_time6 from statictext within u_crosstab_po_grid_selection
end type
type st_time4 from statictext within u_crosstab_po_grid_selection
end type
type st_time2 from statictext within u_crosstab_po_grid_selection
end type
type cbx_daily from checkbox within u_crosstab_po_grid_selection
end type
type cbx_net_out from checkbox within u_crosstab_po_grid_selection
end type
type st_time3 from statictext within u_crosstab_po_grid_selection
end type
type st_time5 from statictext within u_crosstab_po_grid_selection
end type
type st_time7 from statictext within u_crosstab_po_grid_selection
end type
type st_time9 from statictext within u_crosstab_po_grid_selection
end type
type st_time1 from statictext within u_crosstab_po_grid_selection
end type
end forward

global type u_crosstab_po_grid_selection from UserObject
int Width=2336
int Height=100
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
event ue_build_crosstab pbm_custom01
ddlb_plant ddlb_plant
ddlb_mode ddlb_mode
cbx_batch cbx_batch
st_2 st_2
st_1 st_1
st_time10 st_time10
st_time8 st_time8
st_time6 st_time6
st_time4 st_time4
st_time2 st_time2
cbx_daily cbx_daily
cbx_net_out cbx_net_out
st_time3 st_time3
st_time5 st_time5
st_time7 st_time7
st_time9 st_time9
st_time1 st_time1
end type
global u_crosstab_po_grid_selection u_crosstab_po_grid_selection

type variables
statictext	ist_time_list[10]

integer	ii_count = 1

string	is_plant="", &
	is_vendor_info
end variables

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_invisible_time_list ()
public subroutine uf_show_time_list ()
public subroutine uf_fill_plant_ddlb (ref dropdownlistbox addlb)
public subroutine uf_parent_ue_event (integer ai_value, string as_ue_event)
public function integer uf_boolean_to_int (boolean ab_value)
end prototypes

on ue_build_crosstab;parent.triggerevent( 'ue_build_crosstab' )
end on

public subroutine uf_initialize ();ist_time_list[1]	= st_time1
ist_time_list[2]	= st_time2
ist_time_list[3]	= st_time3
ist_time_list[4]	= st_time4
ist_time_list[5]	= st_time5
ist_time_list[6]	= st_time6
ist_time_list[7]	= st_time7
ist_time_list[8]	= st_time8
ist_time_list[9]	= st_time9
ist_time_list[10]	= st_time10

end subroutine

public subroutine uf_invisible_time_list ();integer	li_ptr

for li_ptr = 1 to 10
	ist_time_list[li_ptr].visible	= FALSE
next
end subroutine

public subroutine uf_show_time_list ();if ii_count >= 10 then
	ii_count = 1
end if

ist_time_list[ii_count].visible	= TRUE

ii_count ++
end subroutine

public subroutine uf_fill_plant_ddlb (ref dropdownlistbox addlb);/*
Description	:	To display plants
Author		:	Jim Wu
Start Date	:	06/16/96
Modification:
*/


/* Declaration */
string	ls_plant

/* Initialization */


/* Main Process */

DECLARE 	cursor_plant CURSOR FOR  
 SELECT 	DISTINCT destination.plant  
   FROM 	destination  
ORDER BY destination.plant ASC  ;

OPEN cursor_plant;

addlb.reset()

FETCH cursor_plant INTO :ls_plant;

do while SQLCA.SQLCode = 0
	if ls_plant > '' then
		addlb.additem( ls_plant )	
	end if

	FETCH cursor_plant INTO :ls_plant;
loop

addlb.additem( 'ALL' )

CLOSE cursor_plant;


end subroutine

public subroutine uf_parent_ue_event (integer ai_value, string as_ue_event);parent.triggerevent( as_ue_event, 0, ai_value )

end subroutine

public function integer uf_boolean_to_int (boolean ab_value);if ab_value then
	return 1
else
	return 0
end if
end function

on constructor;this.uf_initialize()
end on

on u_crosstab_po_grid_selection.create
this.ddlb_plant=create ddlb_plant
this.ddlb_mode=create ddlb_mode
this.cbx_batch=create cbx_batch
this.st_2=create st_2
this.st_1=create st_1
this.st_time10=create st_time10
this.st_time8=create st_time8
this.st_time6=create st_time6
this.st_time4=create st_time4
this.st_time2=create st_time2
this.cbx_daily=create cbx_daily
this.cbx_net_out=create cbx_net_out
this.st_time3=create st_time3
this.st_time5=create st_time5
this.st_time7=create st_time7
this.st_time9=create st_time9
this.st_time1=create st_time1
this.Control[]={this.ddlb_plant,&
this.ddlb_mode,&
this.cbx_batch,&
this.st_2,&
this.st_1,&
this.st_time10,&
this.st_time8,&
this.st_time6,&
this.st_time4,&
this.st_time2,&
this.cbx_daily,&
this.cbx_net_out,&
this.st_time3,&
this.st_time5,&
this.st_time7,&
this.st_time9,&
this.st_time1}
end on

on u_crosstab_po_grid_selection.destroy
destroy(this.ddlb_plant)
destroy(this.ddlb_mode)
destroy(this.cbx_batch)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_time10)
destroy(this.st_time8)
destroy(this.st_time6)
destroy(this.st_time4)
destroy(this.st_time2)
destroy(this.cbx_daily)
destroy(this.cbx_net_out)
destroy(this.st_time3)
destroy(this.st_time5)
destroy(this.st_time7)
destroy(this.st_time9)
destroy(this.st_time1)
end on

type ddlb_plant from dropdownlistbox within u_crosstab_po_grid_selection
int X=2011
int Width=311
int Height=352
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;//messagebox( 'MONITOR for Windows', 'This feature is still under development.', information! )

if this.text = 'ALL' then
	is_plant	= ''
else
	is_plant	= this.text
end if

parent.triggerevent( 'ue_build_crosstab' )
end on

on constructor;uf_fill_plant_ddlb( ddlb_plant )
end on

type ddlb_mode from dropdownlistbox within u_crosstab_po_grid_selection
int X=1481
int Width=366
int Height=292
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"MPS Mode",&
"Kanban Mode",&
"Shortage Mode",&
"Surplus Mode",&
"HardQueue Mode"}
end type

on selectionchanged;choose case	this.text

	case 'MPS Mode'
		uf_parent_ue_event( 1, 'ue_mps_mode' )

	case 'Kanban Mode'
		uf_parent_ue_event( 0, 'ue_mps_mode' )

	case 'Shortage Mode'
		uf_parent_ue_event( 2, 'ue_mps_mode' )

	case 'Surplus Mode'
//		uf_parent_ue_event( 3, 'ue_mps_mode' )
		MessageBox ("System Message", "This feature will be available in the next realease")

	case 'HardQueue Mode'
//		uf_parent_ue_event( 4, 'ue_mps_mode' )
		MessageBox ("System Message", "This feature will be available in the next realease")

end choose


end on

on constructor;this.text	= 'MPS Mode'
end on

type cbx_batch from checkbox within u_crosstab_po_grid_selection
int X=878
int Width=402
int Height=64
int TabOrder=30
string Text="Batch Create"
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uf_parent_ue_event( 1, 'ue_set_batch_create' )
end on

type st_2 from statictext within u_crosstab_po_grid_selection
int X=1883
int Width=110
int Height=72
boolean Enabled=false
string Text="Plant"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_crosstab_po_grid_selection
int X=1335
int Width=128
int Height=72
boolean Enabled=false
string Text="Mode"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time10 from statictext within u_crosstab_po_grid_selection
int X=677
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time8 from statictext within u_crosstab_po_grid_selection
int X=613
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time6 from statictext within u_crosstab_po_grid_selection
int X=549
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time4 from statictext within u_crosstab_po_grid_selection
int X=485
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time2 from statictext within u_crosstab_po_grid_selection
int X=421
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_daily from checkbox within u_crosstab_po_grid_selection
int X=366
int Width=384
int Height=64
int TabOrder=20
string Text="Display Daily"
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uf_parent_ue_event( uf_boolean_to_int( this.checked ), 'ue_disp_daily' )
end on

type cbx_net_out from checkbox within u_crosstab_po_grid_selection
int X=18
int Width=274
int Height=64
int TabOrder=10
string Text="Net Out "
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uf_parent_ue_event( uf_boolean_to_int( this.checked ), 'ue_net_out' )
end on

type st_time3 from statictext within u_crosstab_po_grid_selection
int X=453
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time5 from statictext within u_crosstab_po_grid_selection
int X=521
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time7 from statictext within u_crosstab_po_grid_selection
int X=581
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time9 from statictext within u_crosstab_po_grid_selection
int X=645
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time1 from statictext within u_crosstab_po_grid_selection
int X=398
int Y=64
int Width=41
int Height=36
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

