$PBExportHeader$u_dw_bom_for_max_cop.sru
$PBExportComments$(msc) Added process id
forward
global type u_dw_bom_for_max_cop from u_dw_collaspable_bom
end type
end forward

global type u_dw_bom_for_max_cop from u_dw_collaspable_bom
string DataObject="d_dw_bom_tree_for_max_cop"
end type
global u_dw_bom_for_max_cop u_dw_bom_for_max_cop

type variables
boolean		ib_include_setup_time = FALSE
datetime		idt_due_datetime
date		id_due_date
decimal		ic_due_hour, &
		ic_due_minute, &
		ic_qty
integer		ii_day_off[], &
		ii_due_date_day_number

long		il_order, &
		il_row_id

string		is_plant, &
		is_ship_type

datawindow	idw_activity_flag
end variables

forward prototypes
public subroutine uf_save_parent_row (long al_parent_row, long al_current_row)
public function string uf_primary_machine (string as_part)
public subroutine uf_display_bom (string as_part)
public subroutine uf_calculate_deaddrop_and_due_date (long al_current_row)
public function decimal uf_process_off_days (decimal ac_hours)
public function boolean uf_assign_mps_data (long al_row)
public function boolean uf_create_mps (string as_type, string as_part, date ad_due_date, decimal ac_qty, string as_machine, decimal ac_runtime, date ad_dropdead_date, decimal ac_setup_time, string as_group_tech, string as_process_id, time at_due_time, time at_dropdead_time, long al_parent_id)
public subroutine uf_assign_dw_activity_flag (datawindow adw)
public function integer uf_generate_mps_for_activity (string as_activity)
public subroutine uf_get_part_info (string as_part, decimal ac_qty, ref decimal ac_runtime, ref decimal ac_setuptime, ref string as_process_id, ref string as_activity)
end prototypes

public subroutine uf_save_parent_row (long al_parent_row, long al_current_row);decimal	lc_runtime_ratio, &
			lc_parent_runtime_ratio, &
			lc_qty, &
			lc_runtime, &
			lc_setup_time, &
			lc_bom_qty

string	ls_part, &
			ls_type, &
			ls_machine, &
			ls_process_id, &
			ls_group_tech, &
			ls_activity

ls_part		= this.getitemstring(al_current_row, 'key' )
lc_bom_qty	= this.getitemnumber(al_current_row, 'link_qty' )
lc_qty		= this.getitemnumber(al_parent_row,  'qty' ) * lc_bom_qty
lc_parent_runtime_ratio	= this.getitemnumber( al_parent_row, 'runtime_ratio' )
this.setitem( al_current_row, 'parent_qty', &
					this.getitemnumber( al_parent_row, 'qty' ) )
this.setitem( al_current_row, 'parent_runtime_ratio', lc_parent_runtime_ratio )	

uf_get_part_info( ls_part, lc_qty, lc_runtime, &
						lc_setup_time, ls_process_id, ls_activity )

lc_runtime_ratio	=  lc_parent_runtime_ratio + lc_runtime 
this.setitem( 	al_current_row, 'setup_time', &
				 	this.getitemnumber( al_parent_row, 'setup_time' ) + lc_setup_time )
this.setitem(	al_current_row, 'parent_setup_time', &
					this.getitemnumber( al_parent_row, 'setup_time' ) )
this.setitem( al_current_row, 'runtime_ratio', lc_runtime_ratio )

this.setitem( al_current_row, 'type', f_get_part_info( ls_part, 'CLASS' ) )
this.setitem( al_current_row, 'group_tech', f_get_part_info( ls_part, 'GROUP TECH' ) )
this.setitem( al_current_row, 'machine', uf_primary_machine( ls_part ) )
this.setitem( al_current_row, 'qty', lc_qty )
this.setitem( al_current_row, 'activity_process_flag', &
				  uf_generate_mps_for_activity( ls_activity ) )
this.setitem( al_current_row, 'process_id', ls_process_id )
end subroutine

public function string uf_primary_machine (string as_part);/* 
Description	:To get the primary machine for specific part.
Author		:Jim Wu
Start Date	:01/25/96
Modification:
*/

/* Declaration */
String ls_Machine

/* Initialization */

/* Main Process */

SELECT part_machine.machine  
  INTO :ls_Machine  
  FROM part_machine  
 WHERE ( part_machine.part = :as_Part ) AND  
        ( part_machine.sequence = 1 )   ;

If IsNull(ls_Machine) or ls_Machine = '' then		//If No primary machine set as "NONE"
	ls_Machine	= "NONE"
End If

Return ls_Machine
end function

public subroutine uf_display_bom (string as_part);s_parm_list	lstr_component_list

this.ii_row_added		= 0
this.ii_starting_row	= 1

this.reset()
this.ib_expand_all	= TRUE
this.insertrow( 1 )
this.setitem( 1, 'key', as_part )
this.setitem( 1, 'qty', 1 )
lstr_component_list.s_parm_list[1]	= as_part
lstr_component_list.c_parm_list[1]	= 1
this.ib_out_of_limit	= FALSE

this.uf_show_key( 1, lstr_component_list, 1, 164, TRUE, TRUE )
this.uf_save_parent_row( 1, 1 )

this.uf_expand_components( as_part, 1, 164 )

if this.ib_out_of_limit then
	this.uf_display_message()
end if




end subroutine

public subroutine uf_calculate_deaddrop_and_due_date (long al_current_row);decimal	lc_runtime_ratio_for_due, &
			lc_runtime_ratio_for_dropdead, &
			lc_qty, &
			lc_parent_qty, &
			lc_hours_for_due, &
			lc_hours_for_dropdead, &
			lc_hours

integer	li_days, &
			li_hour, &
			li_minute, &
			li_second

date		ld_date

datetime	ldt_due_datetime

time		lt_time

lc_runtime_ratio_for_due		= this.getitemnumber( al_current_row, &
																 	'parent_runtime_ratio' )
lc_runtime_ratio_for_dropdead	= this.getitemnumber( al_current_row, &
																	'runtime_ratio' )
lc_qty								= this.getitemnumber( al_current_row, &
																	'qty' ) * this.ic_qty
lc_parent_qty						= this.getitemnumber( al_current_row, &
																	'parent_qty' ) * this.ic_qty 
lc_hours_for_due					= uf_process_off_days( &
											this.ic_qty * lc_runtime_ratio_for_due )

lc_hours_for_dropdead			= uf_process_off_days( &
											this.ic_qty * lc_runtime_ratio_for_dropdead )

if ib_include_setup_time then
	lc_hours_for_due	+= this.getitemnumber( al_current_row, 'parent_setup_time' )
	lc_hours_for_dropdead	+= this.getitemnumber( 	al_current_row, &
																	'setup_time' )
end if

this.setitem( al_current_row, 'runtime', lc_hours_for_dropdead )
this.setitem( al_current_row, 'parent_runtime', lc_hours_for_due )

//------------------------ Calculate the due date ----------------------
li_days								= ( lc_hours_for_due / 24 )
li_hour								= lc_hours_for_due - (li_days * 24 )

if li_hour > ic_due_hour +  (ic_due_minute / 60 ) then
	lt_time				= time( idt_due_datetime )
	ld_date				= date( idt_due_datetime )
	ldt_due_datetime	= datetime( relativedate( ld_date, -1 ), &
											lt_time )
											
	ic_due_hour			+= 24
else
	ldt_due_datetime	= idt_due_datetime		
end if

ld_date					= relativedate( date( ldt_due_datetime), &
												 ( -1 ) * li_days )
lc_hours					= ic_due_hour +  (ic_due_minute / 60 ) - li_hour
li_hour					= lc_hours
li_minute				= (lc_hours - li_hour ) * 60
li_second				= 0

this.setitem( 	al_current_row, 'due_datetime', datetime( ld_date, &
					time( li_hour, li_minute, li_second ) ) )

//------------------------ Calculate the dropdead date ----------------------
li_days								= ( lc_hours_for_dropdead / 24 )
li_hour								= lc_hours_for_dropdead - (li_days * 24 )

if li_hour > ic_due_hour +  (ic_due_minute / 60 ) then
	lt_time				= time( idt_due_datetime )
	ld_date				= date( idt_due_datetime )
	ldt_due_datetime	= datetime( relativedate( ld_date, -1 ), &
											lt_time )
											
	ic_due_hour			+= 24
else
	ldt_due_datetime	= idt_due_datetime		
end if

ld_date					= relativedate( date( ldt_due_datetime), &
												 ( -1 ) * li_days )
lc_hours					= ic_due_hour +  (ic_due_minute / 60 ) - li_hour
li_hour					= lc_hours
li_minute				= (lc_hours - li_hour ) * 60
li_second				= 0

this.setitem( 	al_current_row, 'dropdead_datetime', datetime( ld_date, &
					time( li_hour, li_minute, li_second ) ) )


end subroutine

public function decimal uf_process_off_days (decimal ac_hours);//This function will process the off days. Say we have Sunday and Saturday off
//in a week. 
//Now ii_off_day[1]	= 1	:Sunday
//		ii_off_day[2]	= 2	:Monday
//Supose today is Tuesday (day# = 3 ). If you have 48 hours, then you would
//start the job at Friday (skip the Sunday and Monday)

integer	li_off_days, &
			li_weeks, &
			li_day = 0, &
			li_day_number, &
			li_ptr

decimal	lc_hours


li_off_days	= upperbound( ii_day_off )							//Total # of days off
if li_off_days > 0 then
	li_weeks			= 	truncate( ac_hours / (24 * 7 ), 0 )	//Total # of weeks
	ac_hours			+= li_off_days * li_weeks
	lc_hours			= 	ac_hours - (li_weeks * 24 * 7 )
	li_day_number	= 	ii_due_date_day_number
	do while lc_hours > 0
		for li_ptr = 1 to li_off_days 							//Whether it is off day
			if li_day_number	= ii_day_off[ li_ptr ] then
				li_day ++
			end if
		next
		lc_hours	-= 24
		if li_day_number = 1 then
			li_day_number	= 7
		else
			li_day_number --
		end if
	loop		
	ac_hours		+= (li_day * 24 )
end if	

return ac_hours
end function

public function boolean uf_assign_mps_data (long al_row);if this.getitemnumber( al_row, 'activity_process_flag' ) = 1 then
	return this.uf_create_mps( &
					this.getitemstring( al_row, 'type' ), &
					this.getitemstring( al_row, 'key' ), &
					date( this.getitemdatetime( al_row, 'due_datetime' ) ), &
					this.getitemnumber( al_row, 'qty' ) * this.ic_qty, &
					this.getitemstring( al_row, 'machine' ), &
					this.getitemnumber( al_row, 'runtime' ) - &
							this.getitemnumber( al_row, 'parent_runtime' ), &
					date( this.getitemdatetime( al_row, 'dropdead_datetime' ) ), &
					this.getitemnumber( al_row, 'setup_time') - &
							this.getitemnumber( al_row, 'parent_setup_time' ), &
					this.getitemstring( al_row, 'group_tech' ), &
					this.getitemstring( al_row, 'process_id' ), &
					time( this.getitemdatetime( al_row, 'due_datetime' ) ), &
					time( this.getitemdatetime( al_row, 'dropdead_datetime' ) ), &
					0  )

else
	return TRUE
end if



end function

public function boolean uf_create_mps (string as_type, string as_part, date ad_due_date, decimal ac_qty, string as_machine, decimal ac_runtime, date ad_dropdead_date, decimal ac_setup_time, string as_group_tech, string as_process_id, time at_due_time, time at_dropdead_time, long al_parent_id);long		ll_week_no, &
			ll_row_id

long		ls_origin
integer	ls_source

Datetime l_due_date
Datetime l_dropdead_date
Datetime l_due_time  
Datetime l_dropdead_time

ll_week_no			= f_get_week_no(ad_due_date)
ls_origin			= il_order
ls_source			= il_row_id
ll_row_id			= f_get_row_id(il_order)
l_due_date    		=  DateTime( ad_due_date )
l_dropdead_date 	=  DateTime( ad_dropdead_date )
l_due_time  		=  DateTime( ad_due_date, at_due_time )
l_dropdead_time	=  DateTime( ad_dropdead_date, at_dropdead_time )

INSERT INTO master_prod_sched  
         ( type,   
           part,   
           due,   
           qnty,   
           source,   
           source2,   
           origin,   
           rel_date,   
           tool,   
           workcenter,   
           machine,   
           run_time,   
           run_day,   
           dead_start,   
           material,   
           job,   
           material_qnty,   
           setup,   
           location,   
           field1,   
           field2,   
           field3,   
           field4,   
           field5,   
           status,   
           sched_method,   
           qty_completed,   
           process,   
           tool_num,   
           workorder,   
           qty_assigned,   
           due_time,   
           start_time,   
           id,   
           parent_id,   
           begin_date,   
           begin_time,   
           end_date,   
           end_time,   
           po_number,   
           po_row_id,   
           week_no,
			  plant,
			  ship_type )  
  VALUES ( :as_Type,   
           :as_Part,   
           :ad_due_date,   
           :ac_Qty,   
           :ls_source,   
           null,   
           :ls_origin,   
           null,   
           null,   
           null,   
           :as_Machine,   
           :ac_RunTime,   
           null,   
           :ad_dropdead_date,   
           null,   
           '',   
           null,   
           :ac_Setup_Time,   
           null,   
           :as_Group_Tech,   
           null,   
           null,   
           null,   
           null,   
           'S',   
           null,   
           null,   
           :as_Process_Id,   
           null,   
           null,   
           0,   
           :at_due_time,   
           :at_dropdead_time,   
           :ll_row_id,   
           :al_parent_id,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :ll_week_no,
			  :is_plant,
			  :is_ship_type )  ;

If SQLCA.SQLCode = -1 then
	RollBack;
	return FALSE
Else
	Commit;
	return TRUE
End If


end function

public subroutine uf_assign_dw_activity_flag (datawindow adw);idw_activity_flag	= adw
end subroutine

public function integer uf_generate_mps_for_activity (string as_activity);integer	li_row, &
			li_count, &
			li_return = 1

if not isvalid( idw_activity_flag ) then
	return 1
end if

li_count	= idw_activity_flag.rowcount()
li_row	= 1

do while (li_row <= li_count )
	if idw_activity_flag.getitemstring( li_row, 1 ) = as_activity then
		if idw_activity_flag.getitemstring( li_row, 2 ) = 'Y' then
			li_return	= 1
		else
			li_return	= 0
		end if
		exit
	end if
	li_row ++
loop

return li_return

end function

public subroutine uf_get_part_info (string as_part, decimal ac_qty, ref decimal ac_runtime, ref decimal ac_setuptime, ref string as_process_id, ref string as_activity);Decimal 	lc_PartsPerHour

SELECT part_mfg.parts_per_hour  , part_mfg.setup_time, process_id, activity
  INTO :lc_PartsPerHour  , :ac_setuptime, :as_process_id, :as_activity
  FROM part_mfg  
 WHERE part_mfg.part = :as_Part   ;

if isnull( as_process_id) or as_process_id = '' then
	as_process_id	= 'NONE'
end if

ac_RunTime	= 0
if isnull( ac_setuptime ) then
	ac_setuptime	= 0
end if

If Not (IsNull(lc_PartsPerHour)) then
	If lc_PartsPerHour	> 0 then
		ac_RunTime   		   = ac_Qty / lc_PartsPerHour
		If IsNull(ac_RunTime) then
			ac_RunTime = 0
		End If		
	Else
		ac_RunTime = 0
	End If			
End If



end subroutine

on doubleclicked;return 
end on

