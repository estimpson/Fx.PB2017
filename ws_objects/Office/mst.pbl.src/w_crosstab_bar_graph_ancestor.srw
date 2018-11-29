$PBExportHeader$w_crosstab_bar_graph_ancestor.srw
$PBExportComments$(mst) Created a new function wf_current_start_x()
forward
global type w_crosstab_bar_graph_ancestor from Window
end type
type vsb_1 from vscrollbar within w_crosstab_bar_graph_ancestor
end type
type hsb_1 from hscrollbar within w_crosstab_bar_graph_ancestor
end type
type ln_1 from line within w_crosstab_bar_graph_ancestor
end type
type ln_2 from line within w_crosstab_bar_graph_ancestor
end type
type ln_3 from line within w_crosstab_bar_graph_ancestor
end type
type ln_4 from line within w_crosstab_bar_graph_ancestor
end type
type ln_5 from line within w_crosstab_bar_graph_ancestor
end type
type ln_6 from line within w_crosstab_bar_graph_ancestor
end type
type ln_7 from line within w_crosstab_bar_graph_ancestor
end type
end forward

type istr_key from structure
    string s_key
    decimal {2} c_value1
end type

global type w_crosstab_bar_graph_ancestor from Window
int X=1
int Y=1
int Width=2926
int Height=1917
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_initialize pbm_custom01
event ue_build_crosstab pbm_custom02
vsb_1 vsb_1
hsb_1 hsb_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
end type
global w_crosstab_bar_graph_ancestor w_crosstab_bar_graph_ancestor

type variables
long	il_grid_width

integer	ii_current_x, &
	ii_current_y, &
	ii_start_x, &
	ii_start_y, &
	ii_end_x, &
	ii_end_y, &
	ii_days_in_grid, &
	ii_mode, &
	ii_distance_y, &
	ii_date_count

decimal	ic_grid_value

istr_key	is_key_list[]

date	id_start_date

end variables

forward prototypes
public function integer wf_get_current_y (string as_key)
public subroutine wf_initialize ()
public subroutine wf_draw_key_list ()
public function boolean wf_visible_y (long al_current_y)
public function boolean wf_visible_x (long al_current_x)
public subroutine wf_draw_dates (date ad_start_date, integer ai_mode)
public subroutine wf_build_crosstab (ref datawindow adw, integer ai_key_col, integer ai_date_col, integer ai_time_col, integer ai_val_col[])
public subroutine wf_destroy_objects ()
public subroutine wf_move_y (integer ai_distance)
public subroutine wf_position_y (integer ai_distance)
public subroutine wf_draw_bar (integer ai_x, integer ai_y, string as_value[], datetime adt_datetime, long al_orig_y, string as_key)
public function integer wf_current_start_x (date ad_start, date ad_date, time at_time)
end prototypes

on ue_initialize;this.wf_initialize()
end on

public function integer wf_get_current_y (string as_key);/*
Description	:	To get the Y coordinate value for the key value
Author		:	Jim Wu
Start Date	:	03/21/96
Modification:
*/

/* Declaration */
integer	li_total

long		ll_current_y

boolean	lb_found

/* Initialization */
li_total			= upperbound( is_key_list )
lb_found			= FALSE
ll_current_y	= 0

/* Main Process */

do while li_total > 0  AND (not lb_found)
	lb_found	= ( is_key_list[ li_total ].s_key = as_key )
	if lb_found then
		ll_current_y	= is_key_list[ li_total ].c_value1
	end if
	li_total --
loop

return ll_current_y
end function

public subroutine wf_initialize ();/*
Description	:	To initialize 
Author		:	Jim Wu
Start Date	:	03/22/96
Modification:
*/


/* Declaration */


/* Initialization */
id_start_date	= today()
if isnull( ii_mode ) or ii_mode <= 0 then
	ii_mode = 1
end if

/* Main Process */

wf_draw_key_list()
wf_draw_dates(id_start_date, ii_mode)

this.triggerevent( 'ue_build_crosstab' )

vsb_1.MinPosition = 0
vsb_1.MaxPosition	= (ii_end_y - ii_start_y)

hsb_1.MinPosition	= 0
hsb_1.MaxPosition	= 7
end subroutine

public function boolean wf_visible_y (long al_current_y);return (al_current_y >= ii_start_y) AND (al_current_y <= ii_end_y )
end function

public function boolean wf_visible_x (long al_current_x);return (al_current_x >= ii_start_x ) AND (al_current_x <= ii_end_x )
end function

public subroutine wf_draw_dates (date ad_start_date, integer ai_mode);/*
Description	:	To show the list of days/dates
Author		:	Jim Wu
Start Date	:	03/22/96
Modification:
*/


/* Declaration */


/* Initialization */


/* Main Process */
//uo_date.ii_mode			= ai_mode
//uo_date.id_start_date	= ad_start_date
//uo_date.uf_draw_dates(ad_start_date)
end subroutine

public subroutine wf_build_crosstab (ref datawindow adw, integer ai_key_col, integer ai_date_col, integer ai_time_col, integer ai_val_col[]);long		ll_row, &
			ll_total, &
			ll_row_found

integer	li_current_y, &
			li_current_x, &
			li_val_ptr, &
			li_val_cnt

decimal	lc_value, &
			lc_crosstab_val, &
			lc_netout, &
			lc_orig_demand, &
			lc_days

date		ld_start, &
			ld_date, &
			ld_grid_end_date

time		lt_time

string	ls_current_key, &
			ls_key, &
			ls_value[]

str_progress	lstr_parm

/* Initialization */

wf_destroy_objects()

adw.setsort( 	"#" + string( ai_key_col ) + " a " ) //Sort the key dw.
adw.sort()

ll_total				= adw.rowcount()
ld_start				= id_start_date
ld_grid_end_date	= relativedate( ld_start, ii_date_count )

ls_current_key		= ''
li_current_y		= ii_current_y
ld_grid_end_date	= relativedate( ld_start, ii_days_in_grid )
li_val_cnt			= upperbound(ai_val_col)

/* Main Process */

lstr_parm.title	= 'Creating Crosstab'
openwithparm( w_progress, lstr_parm )
w_progress.cb_cancel.visible	= FALSE

for ll_row = 1 to ll_total
	ls_key	= adw.getitemstring(ll_row, ai_key_col)	//get the current key
	w_progress.wf_progress( ll_row / ll_total, 'Building row for ' + ls_key )

	ld_date	= adw.getitemdate( ll_row, ai_date_col ) 
	lt_time	= adw.getitemtime( ll_row, ai_time_col )

	for li_val_ptr = 1 to li_val_cnt
		lc_value		= adw.getitemnumber(ll_row, &
						  ai_val_col[ li_val_ptr] )	//get the list of values
		ls_value[li_val_ptr]	= string( lc_value )
	next

	if ld_date >= ld_start AND ld_date <= ld_grid_end_date then
		if ls_key <> ls_current_key or ll_row = ll_total then	//Brand new key is found
			li_current_y	= wf_get_current_y( ls_key )
		end if

		li_current_x	= wf_current_start_x( ld_start, ld_date, lt_time )

		wf_draw_bar( li_current_x, li_current_y, ls_value, &
						 datetime( ld_date, lt_time ), li_current_y, ls_key)

	end if

	ls_current_key		= ls_key
	
next

if upperbound( is_key_list ) <= &
			((ii_end_y - ii_start_y) / ii_distance_y) then
	vsb_1.maxposition = 0
	vsb_1.minposition	= 0
end if

close(w_progress)


end subroutine

public subroutine wf_destroy_objects ();/* prototype */
end subroutine

public subroutine wf_move_y (integer ai_distance);/* prototype */
end subroutine

public subroutine wf_position_y (integer ai_distance);/* prototype */
end subroutine

public subroutine wf_draw_bar (integer ai_x, integer ai_y, string as_value[], datetime adt_datetime, long al_orig_y, string as_key);/* prototype */
end subroutine

public function integer wf_current_start_x (date ad_start, date ad_date, time at_time);decimal	lc_days
integer	li_current_x

lc_days			=( daysafter( ad_start, ad_date ) + &
					 (	hour( at_time ) / 24 ) + &
					 ( minute( at_time ) /3600 ) ) / ii_mode

li_current_x	= ii_start_x + (lc_days * il_grid_width )

return	li_current_x
end function

on close;wf_destroy_objects() 
end on

on open;this.triggerevent( 'ue_initialize' )
end on

on w_crosstab_bar_graph_ancestor.create
this.vsb_1=create vsb_1
this.hsb_1=create hsb_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.Control[]={ this.vsb_1,&
this.hsb_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_7}
end on

on w_crosstab_bar_graph_ancestor.destroy
destroy(this.vsb_1)
destroy(this.hsb_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
end on

type vsb_1 from vscrollbar within w_crosstab_bar_graph_ancestor
int X=2817
int Width=74
int Height=1745
boolean Enabled=false
boolean StdWidth=false
end type

on linedown;if this.position > this.minposition then
	this.position	-= ii_distance_y
	wf_move_y( ( -1 ) * ii_distance_y )
end if
end on

on pagedown;if this.position > this.minposition then
	this.position	-= ii_distance_y
	wf_move_y( (-1) * ii_distance_y )
end if
end on

on lineup;if this.position < this.maxposition then
	this.position	+= ii_distance_y
	wf_move_y( ii_distance_y )
end if
end on

on pageup;if this.position < this.maxposition then
	this.position	+= ii_distance_y
	wf_move_y(  ii_distance_y )
end if
end on

on moved;if this.position > this.minPosition and this.position <= this.maxPosition then
	wf_position_y( this.position )
end if
end on

type hsb_1 from hscrollbar within w_crosstab_bar_graph_ancestor
int Y=1745
int Width=2890
int Height=65
boolean Enabled=false
boolean StdHeight=false
end type

type ln_1 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=494
int BeginY=449
int EndX=494
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_2 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=823
int BeginY=449
int EndX=823
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_3 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=1153
int BeginY=449
int EndX=1153
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_4 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=1482
int BeginY=449
int EndX=1482
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_5 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=1811
int BeginY=449
int EndX=1811
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_6 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=2140
int BeginY=449
int EndX=2140
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

type ln_7 from line within w_crosstab_bar_graph_ancestor
boolean Enabled=false
int BeginX=2469
int BeginY=449
int EndX=2469
int EndY=1745
LineStyle LineStyle=dot!
int LineThickness=5
end type

