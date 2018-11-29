$PBExportHeader$u_dw_workorder_graph_display.sru
$PBExportComments$(mps1)
forward
global type u_dw_workorder_graph_display from u_jw_dw_super
end type
end forward

global type u_dw_workorder_graph_display from u_jw_dw_super
int Width=2350
int Height=833
string DataObject="d_workorder_runtime_graph"
end type
global u_dw_workorder_graph_display u_dw_workorder_graph_display

type variables
long	il_start_pos = 531

integer	ii_daily_length = 201

string	is_process_id


end variables

forward prototypes
public subroutine uf_projection (string as_part[], decimal ac_qty[])
public subroutine uf_update_graph_dw (string as_workorder, string as_machine, decimal ac_runtime, date ad_start_date, time at_start_time, date ad_end_date, time at_end_time, date ad_due_date)
public function decimal uf_get_parts_per_hour (string as_part)
end prototypes

public subroutine uf_projection (string as_part[], decimal ac_qty[]);integer	li_ptr, &
			li_count

decimal	lc_runtime, &
			lc_projected_runtime

string	ls_job

s_parm_list	lstr_parm

li_count						= this.rowcount()

lstr_parm.s_parm_list	= as_part
lstr_parm.c_parm_list	= ac_qty

for li_ptr = 1 to li_count
	ls_job	= this.getitemstring( li_ptr, 'work_order' )
	f_job_runtime_projected( 	ls_job, lstr_parm, lc_runtime, &
										lc_projected_runtime )
	this.setitem( li_ptr, 'flag', 1 )
	this.accepttext()

	if lc_projected_runtime > 5000 then		//don't need to draw too long
		lc_projected_runtime = 5000
	end if


	this.setitem( li_ptr, 'extra_length', ( lc_projected_runtime ) * &
						ii_daily_length / 24 )
next
end subroutine

public subroutine uf_update_graph_dw (string as_workorder, string as_machine, decimal ac_runtime, date ad_start_date, time at_start_time, date ad_end_date, time at_end_time, date ad_due_date);long	ll_start_pos, &
		ll_end_pos, &
		ll_ini_pos, &
		ll_due_date_pos, &
		ll_current_pos

decimal	lc_hours



this.insertrow( 1 )
this.setitem( 1, 'now', today() )
this.setitem( 1, 'work_order', as_workorder )
this.setitem( 1, 'machine', as_machine )
this.setitem( 1, 'start_datetime', datetime( ad_start_date, at_end_time ) )
this.setitem( 1, 'end_datetime', datetime( ad_end_date, at_end_time ) )
this.setitem( 1, 'runtime', ac_runtime )
this.setitem( 1, 'due_date', ad_due_date )

lc_hours				=	f_hours_between( 	today(), time('00:00:00'), &
													today(), now() )
ll_current_pos		= 	il_start_pos + ( 	ii_daily_length * lc_hours / 24 )
						

lc_hours				=	f_hours_between( 	today(), time('00:00:00'), &
													ad_start_date, at_start_time )
ll_start_pos		= 	il_start_pos + ( 	ii_daily_length * lc_hours / 24 )


lc_hours				=	f_hours_between( 	today(), time('00:00:00'), &
													ad_end_date, at_end_time )
ll_end_pos			= 	il_start_pos + ( 	ii_daily_length * lc_hours / 24 )
						

lc_hours				=	f_hours_between(  today(), time('00:00:00'), &
													ad_due_date, time( '00:00:00' ) )
ll_due_date_pos	=	il_start_pos + ( 	ii_daily_length * lc_hours / 24 )

this.setitem( 1, 'current_pos',	ll_current_pos )
this.setitem( 1, 'start_pos', 	ll_start_pos )
this.setitem( 1, 'end_pos',		ll_end_pos )
this.setitem( 1, 'due_date_pos', ll_due_date_pos )
this.accepttext()
end subroutine

public function decimal uf_get_parts_per_hour (string as_part);decimal	lc_parts_per_hour

SELECT part_mfg.parts_per_hour  
  INTO :lc_parts_per_hour  
  FROM part_mfg  
 WHERE part_mfg.part = :as_part   ;

return f_get_value( lc_parts_per_hour )
end function

