$PBExportHeader$u_workorder_graph_display.sru
$PBExportComments$(mps1)
forward
global type u_workorder_graph_display from UserObject
end type
type sle_detail from singlelineedit within u_workorder_graph_display
end type
type st_2 from statictext within u_workorder_graph_display
end type
type cb_exit from commandbutton within u_workorder_graph_display
end type
type cb_new from commandbutton within u_workorder_graph_display
end type
type cb_save from commandbutton within u_workorder_graph_display
end type
type dw_workorder_graph from u_dw_workorder_graph_display within u_workorder_graph_display
end type
type st_1 from statictext within u_workorder_graph_display
end type
end forward

global type u_workorder_graph_display from UserObject
int Width=2853
int Height=940
boolean Border=true
long BackColor=77897888
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_initialize pbm_custom01
event ue_save pbm_custom02
event ue_new pbm_custom03
event ue_close pbm_custom04
event ue_select_job pbm_custom05
sle_detail sle_detail
st_2 st_2
cb_exit cb_exit
cb_new cb_new
cb_save cb_save
dw_workorder_graph dw_workorder_graph
st_1 st_1
end type
global u_workorder_graph_display u_workorder_graph_display

type variables
string	is_job
end variables

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_refresh_graph (string as_part, decimal ac_runtime)
public subroutine uf_update_graph_dw (s_parm_list astr_parm)
public function datetime uf_get_last_date_time (string as_machine)
public subroutine uf_display_job_detail (string as_workorder)
end prototypes

on ue_initialize;this.uf_initialize()
end on

on ue_save;parent.triggerevent( 'ue_save' )
end on

on ue_new;parent.triggerevent( 'ue_new' )
end on

on ue_close;parent.triggerevent( 'ue_close' )
end on

on ue_select_job;parent.triggerevent( 'ue_select_job', 0, is_job )
end on

public subroutine uf_initialize ();
end subroutine

public subroutine uf_refresh_graph (string as_part, decimal ac_runtime);string	ls_part[1]		
decimal	lc_runtime[1]

ls_part[1]		= as_part
lc_runtime[1]	= ac_runtime

dw_workorder_graph.uf_projection( ls_part, lc_runtime )
end subroutine

public subroutine uf_update_graph_dw (s_parm_list astr_parm);string	ls_workorder, &
			ls_process_id, &
			ls_machine, &
			ls_dest_machine, &
			ls_part, &
			ls_machine_number, &
			ls_process

date		ld_start_date, &
			ld_end_date, &
			ld_due_date

time		lt_start_time, &
			lt_end_time

datetime	ldt_datetime, &
			ldt_start_date, &
			ldt_end_date, &
			ldt_due_date, &
			ldt_start_time, &
			ldt_end_time



decimal	lc_runtime

ls_dest_machine	= astr_parm.s_parm_list[1]
ls_process_id		= astr_parm.s_parm_list[2]

DECLARE 	cursor_workorder CURSOR FOR  
SELECT 	work_order.work_order,  
			work_order.machine_no, 
        	work_order.runtime,   
         work_order.start_date,   
         work_order.start_time,   
         work_order.end_date,   
         work_order.end_time,   
         work_order.due_date,
			work_order.process_id  
FROM 		work_order
WHERE 	work_order.process_id = :ls_process_id and
			work_order.machine_no = :ls_dest_machine ;

dw_workorder_graph.reset()

OPEN  cursor_workorder;

FETCH cursor_workorder INTO 	:ls_workorder, 	:ls_machine,
										:lc_runtime, 		:ldt_start_date,	
										:ldt_start_time,	:ldt_end_date,		
										:ldt_end_time,		:ldt_due_date,
										:ls_process;

Do While SQLCA.SQLCode = 0	

	ld_start_date = date(ldt_start_date)	
	lt_start_time = time(ldt_start_time)
	ld_end_date = date(ldt_end_date)	
	lt_end_time = time(ldt_end_time)
	ld_due_date = date(ldt_due_date)

	If ls_process <> 'NONE' Then

		dw_workorder_graph.uf_update_graph_dw ( &
										ls_workorder, ls_machine, lc_runtime, ld_start_date, &
										lt_start_time, ld_end_date, lt_end_time, &
										ld_due_date )
	End if
	
	FETCH cursor_workorder INTO 	:ls_workorder, 	:ls_machine,
											:lc_runtime, 		:ldt_start_date,	
											:ldt_start_time,	:ldt_end_date,		
											:ldt_end_time,		:ldt_due_date,
											:ls_process;

	ld_start_date = date(ldt_start_date)	
	lt_start_time = time(ldt_start_time)
	ld_end_date = date(ldt_end_date)	
	lt_end_time = time(ldt_end_time)
	ld_due_date = date(ldt_due_date)

Loop

CLOSE cursor_workorder;

dw_workorder_graph.setsort( "machine a, work_order a" )
dw_workorder_graph.sort()

ldt_datetime	= uf_get_last_date_time( ls_dest_machine )
lc_runtime		= 0
ld_start_date	= today()
lt_start_time	= now()
ld_end_date		= date( ldt_datetime )
lt_end_time		= lt_start_time
ls_workorder	= 'New'
ld_due_date		= today()
ls_machine		= ls_dest_machine

dw_workorder_graph.uf_update_graph_dw ( &
								ls_workorder, ls_machine, lc_runtime, ld_start_date, &
								lt_start_time, ld_end_date, lt_end_time, &
								ld_due_date )



end subroutine

public function datetime uf_get_last_date_time (string as_machine);date	ld_last_date, &
		ld_date

time	lt_last_time, &
		lt_time

datetime	ldt_last_date, &
		ldt_date, &
		ldt_last_time, &
		ldt_time
 

ld_last_date	= today()
lt_last_time	= now()

DECLARE 	cursor_end_datetime CURSOR FOR  
SELECT 	work_order.end_date,   
        	work_order.end_time  
FROM 		work_order  
WHERE 	work_order.machine_no = :as_machine   ;

OPEN cursor_end_datetime;
FETCH cursor_end_datetime INTO :ldt_date, :ldt_time;

do while SQLCA.SQLCode = 0 

	ld_last_date = date(ldt_last_date)
	ld_date = date(ldt_date)
	lt_last_time = time(ldt_last_time)
	lt_time = time(ldt_time)
 
	if datetime( ld_date, lt_time ) >= datetime( ld_last_date, lt_last_time ) then
		ld_last_date	= ld_date
		lt_last_time	= lt_time	
	end if
	FETCH cursor_end_datetime INTO :ldt_date, :ldt_time;
loop

CLOSE cursor_end_datetime;

return datetime( ld_last_date, lt_time )
end function

public subroutine uf_display_job_detail (string as_workorder);string	ls_part

integer	li_count = 1

DECLARE 	cursor_job_detail CURSOR FOR  
SELECT 	workorder_detail.part  
FROM 		workorder_detail  
WHERE 	workorder_detail.workorder = :as_workorder;

OPEN cursor_job_detail;

FETCH cursor_job_detail INTO :ls_part;

sle_detail.text	= '(Part) '

do while SQLCA.SQLCode = 0 
	
	if li_count = 1 then
		sle_detail.text	+= ls_part
	else
		sle_detail.text	+= ls_part + '/'	
	end if

	FETCH cursor_job_detail INTO :ls_part;

loop

CLOSE cursor_job_detail;
end subroutine

on constructor;this.triggerevent( 'ue_initialize' )
end on

on u_workorder_graph_display.create
this.sle_detail=create sle_detail
this.st_2=create st_2
this.cb_exit=create cb_exit
this.cb_new=create cb_new
this.cb_save=create cb_save
this.dw_workorder_graph=create dw_workorder_graph
this.st_1=create st_1
this.Control[]={this.sle_detail,&
this.st_2,&
this.cb_exit,&
this.cb_new,&
this.cb_save,&
this.dw_workorder_graph,&
this.st_1}
end on

on u_workorder_graph_display.destroy
destroy(this.sle_detail)
destroy(this.st_2)
destroy(this.cb_exit)
destroy(this.cb_new)
destroy(this.cb_save)
destroy(this.dw_workorder_graph)
destroy(this.st_1)
end on

type sle_detail from singlelineedit within u_workorder_graph_display
int X=1646
int Y=4
int Width=1170
int Height=56
int TabOrder=10
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_workorder_graph_display
int X=658
int Width=951
int Height=64
boolean Enabled=false
string Text="(Split Scrolling to view the whole graph)"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within u_workorder_graph_display
int X=2560
int Y=800
int Width=247
int Height=108
int TabOrder=50
string Text="&E&xit"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;parent.triggerevent( 'ue_close' )
end on

type cb_new from commandbutton within u_workorder_graph_display
int X=2286
int Y=800
int Width=247
int Height=108
int TabOrder=40
string Text="&New"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;parent.triggerevent( 'ue_new' )
end on

type cb_save from commandbutton within u_workorder_graph_display
int X=2011
int Y=800
int Width=247
int Height=108
int TabOrder=30
string Text="&Save"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;parent.triggerevent( 'ue_save' )
end on

type dw_workorder_graph from u_dw_workorder_graph_display within u_workorder_graph_display
int X=18
int Y=64
int Width=2798
int Height=720
int TabOrder=20
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

on clicked;call u_dw_workorder_graph_display::clicked;long ll_row

ll_row	= this.getclickedrow()

if ll_row > 0 then
	is_job	= this.getitemstring( ll_row, 'work_order' ) 
	if this.getitemstring( ll_row, 'work_order' ) <> "New" then
		uf_display_job_detail( this.getitemstring( ll_row, 'work_order' ) )
	else
		sle_detail.text	= '(Hard Queue)'
	end if
	parent.triggerevent( 'ue_select_job' )
end if
end on

type st_1 from statictext within u_workorder_graph_display
int X=18
int Width=608
int Height=72
boolean Enabled=false
string Text="Hard Queue Information"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

