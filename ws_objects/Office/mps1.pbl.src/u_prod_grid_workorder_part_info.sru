$PBExportHeader$u_prod_grid_workorder_part_info.sru
$PBExportComments$(mps1) Modified the save routine to save missing detail info.
forward
global type u_prod_grid_workorder_part_info from UserObject
end type
type st_1 from statictext within u_prod_grid_workorder_part_info
end type
type dw_mps from u_jw_dw_super within u_prod_grid_workorder_part_info
end type
type dw_display from datawindow within u_prod_grid_workorder_part_info
end type
type gb_2 from groupbox within u_prod_grid_workorder_part_info
end type
type gb_1 from groupbox within u_prod_grid_workorder_part_info
end type
end forward

global type u_prod_grid_workorder_part_info from UserObject
int Width=2857
int Height=740
boolean Border=true
long BackColor=77897888
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_initialize pbm_custom01
event ue_new pbm_custom02
event ue_select_job pbm_custom03
event ue_save pbm_custom04
st_1 st_1
dw_mps dw_mps
dw_display dw_display
gb_2 gb_2
gb_1 gb_1
end type
global u_prod_grid_workorder_part_info u_prod_grid_workorder_part_info

type variables
decimal	ic_orig_demand, &
	ic_demand, &
	ic_runtime, &
                id_setuptime

string	is_part, &
	is_workorder='', &
	is_process_id, &
	is_machine

date	id_end_date





end variables

forward prototypes
public subroutine uf_initialize ()
public function datetime uf_job_end_datetime (string as_machine)
public function decimal uf_mfg_lot_size (string as_part)
public function decimal uf_parts_per_hour (string as_part)
public subroutine uf_setup_screen (s_parm_list astr_parm)
public subroutine uf_recalc_runtime ()
public subroutine uf_set_workorder (string as_workorder)
public subroutine uf_save ()
public subroutine uf_calc_qty_suggested (decimal ac_qty_required)
public function decimal uf_parts_per_cycle (string as_part)
public function boolean uf_add_to_job (string as_workorder)
public function decimal uf_get_runtime (string as_workorder)
public function boolean uf_job_part_exists (string as_workorder, string as_part, ref decimal ac_qty, ref decimal ac_balance)
public function boolean uf_create_workorder (string as_workorder)
public function long uf_get_parm_value ()
end prototypes

on ue_initialize;this.uf_initialize()
end on

on ue_new;this.is_workorder	= ''

dw_display.setitem( 1, 'workorder', 'NEW' )
end on

on ue_select_job;is_workorder	= string( message.longparm, 'address' )

dw_display.setitem( 1, 'workorder', is_workorder )
end on

on ue_save;this.uf_save()
end on

public subroutine uf_initialize ();
end subroutine

public function datetime uf_job_end_datetime (string as_machine);/*
Description	:	To get the machine end datetime
Author		:	Jim Wu
Start Date	:	03/12/96
Modification:
*/
 

/* Declaration */
date		ld_date
time		lt_time

datetime	ldt_datetime, ldt_date, ldt_time

/* Initialization */


/* Main Process */
DECLARE 	curEndDateTime CURSOR FOR  
 SELECT 	work_order.end_date,   
        	work_order.end_time  
   FROM 	work_order  
  WHERE 	work_order.machine_no = :as_machine   
ORDER BY work_order.end_date DESC,   
        	work_order.end_time DESC  ;

OPEN curEndDateTime;

FETCH curEndDateTime INTO :ldt_date, :ldt_time;

if SQLCA.SQLCode = 0 then
	ldt_datetime	= datetime( date(ldt_date), time(ldt_time) )
else
	ldt_datetime	= datetime( today(), now() )
end if

CLOSE curEndDateTime;

return ldt_datetime
end function

public function decimal uf_mfg_lot_size (string as_part);/*
Description	:	To get the mfg lot size
Author		:	Jim Wu
Start Date	:	03/12/96
Modification:
*/


/* Declaration */
decimal	lc_mfg_lot_size

/* Initialization */


/* Main Process */

SELECT part_mfg.mfg_lot_size  
  INTO :lc_mfg_lot_size  
  FROM part_mfg  
 WHERE part_mfg.part = :as_part   ;

return lc_mfg_lot_size
end function

public function decimal uf_parts_per_hour (string as_part);Decimal 	lc_PartsPerHour

SELECT 	part_mfg.parts_per_hour  
INTO 		:lc_PartsPerHour  
FROM 		part_mfg  
WHERE 	part_mfg.part = :as_Part;

Return 	f_get_value( lc_PartsPerHour )
end function

public subroutine uf_setup_screen (s_parm_list astr_parm);string	ls_part, &
			ls_workorder

decimal	lc_qty_required, &
			lc_qty_suggested, &
			lc_runtime, &
			lc_mfg_lot, &
			lc_total_hours, &
			lc_parts_per_hour

date		ld_date, &
			ld_last_date

integer	li_count

datetime	ld_job_end_datetime

ls_part					= astr_parm.s_key_value
is_machine				= astr_parm.s_parm_list[1]
is_process_id			= astr_parm.s_parm_list[2]
lc_qty_required		= astr_parm.c_parm_list[1]
ld_date					= astr_parm.d_parm_list[1]
ld_last_date			= astr_parm.d_parm_list[2]
lc_mfg_lot				= uf_mfg_lot_size( ls_part )
lc_parts_per_hour		= uf_parts_per_hour( ls_part )
ic_orig_demand			= lc_qty_required
ic_demand				= lc_qty_required
is_part					= ls_part

if lc_parts_per_hour > 0 then
	lc_runtime	= (lc_qty_required / lc_parts_per_hour )
else
	lc_runtime	= 0
end if

ic_runtime		= lc_runtime

dw_display.setitem( 1, 'part',				ls_part )
dw_display.setitem( 1, 'mfg_lot', 			lc_mfg_lot )
dw_display.setitem( 1, 'qty_required', 	lc_qty_required )
dw_display.setitem( 1, 'runtime',			lc_runtime )
dw_display.setitem( 1, 'workorder',			'NEW' )
dw_display.accepttext()
uf_calc_qty_suggested( lc_qty_required )

dw_mps.retrieve( ls_part, RelativeDate( ld_date, -365 ), RelativeDate ( ld_date, 365 ) ) 

dw_mps.selectrow ( 0, false )
FOR li_count = 1 to dw_mps.Rowcount ()
	IF date ( dw_mps.GetItemDatetime( li_count, "due" )  ) <= ld_last_date THEN
		dw_mps.selectrow ( li_count, true )
	END IF	
NEXT

ld_job_end_datetime	= uf_job_end_datetime(is_machine)
id_end_date				= date( ld_job_end_datetime )

parent.triggerevent( 'ue_refresh_graph' )




end subroutine

public subroutine uf_recalc_runtime ();long		ll_count, &
			ll_row

decimal	lc_qty = 0, &
			lc_parts_per_hour, &
			lc_runtime, &
			lc_demand, &
			lc_original_Demand

ll_count	= dw_mps.rowcount()

lc_original_demand = ic_orig_demand

for ll_row = 1 to ll_count
	if dw_mps.isselected( ll_row ) = true then
		lc_qty	+= dw_mps.getitemnumber( ll_row, 'balance' )
	end if
next

if lc_qty > 0 then

	lc_demand = lc_qty

	lc_parts_per_hour	= uf_parts_per_hour( is_part )

	if lc_parts_per_hour > 0 then
		lc_runtime	= ( lc_demand / lc_parts_per_hour )
	else
		lc_runtime	= 0
	end if

else
		lc_runtime	= 0
end if

ic_demand   = lc_qty
dw_display.setitem( 1, 'qty_required', lc_demand)
dw_display.setitem( 1, 'runtime', 		lc_runtime )
uf_calc_qty_suggested( ic_demand )

ic_runtime		= lc_runtime

parent.triggerevent( 'ue_refresh_graph' )


end subroutine

public subroutine uf_set_workorder (string as_workorder);if dw_display.rowcount() > 0 then
	dw_display.setitem( 1, 'workorder', as_workorder )
end if
end subroutine

public subroutine uf_save ();string					ls_workorder
long						ll_workorder
boolean					lb_success

st_generic_structure	lstr_parm

If dw_display.GetItemNumber ( 1, "qty_required" ) <= 0 then
	 MessageBox("System Message", "Quantity should be greater than zero!", Information! )
	 return
End If

ls_workorder	= upper( dw_display.getitemstring( 1, 'workorder' ) )

IF ls_workorder = 'NEW' then	//this is an existing work order

//	ll_workorder	=  f_next_parm_value( 'serial', TRUE )
//	OpenWithParm ( w_get_parm_value, "next_serial" ) 
//	ll_workorder = Message.DoubleParm

	if SQLCA.of_getnextparmvalue ( 'next_workorder' , ll_workorder ) then 
		ls_workorder	= string( ll_workorder )
		lb_success	= uf_create_workorder( ls_workorder )
	else
		rollback;
		return
	end if 
ELSE
	lb_success	= uf_add_to_job( ls_workorder )

END IF

IF lb_success THEN
	lstr_parm.value1 = is_part
	lstr_parm.value3 = 'M'
	lstr_parm.value5 = ls_workorder
	f_update_qty_asgnd_part ( is_part ) // new function added by mams
	parent.triggerevent( 'ue_partial_update_crosstab' )
	parent.triggerevent( 'ue_close' )
ELSE
	messagebox( 'Montior for Windows', 'Failed to create workorder.', information! )
END IF						
end subroutine

public subroutine uf_calc_qty_suggested (decimal ac_qty_required);decimal	lc_mfg_lot_size, &
			lc_qty

lc_mfg_lot_size	= dw_display.getitemnumber( 1, 'mfg_lot' )
if lc_mfg_lot_size > 0 then
	lc_qty = truncate( (ac_qty_required / lc_mfg_lot_size) + 0.5, 0 ) * &
				lc_mfg_lot_size
	dw_display.setitem( 1, 'qty_suggested', lc_qty )
else
	dw_display.setitem( 1, 'qty_suggested', ac_qty_required )
end if	

end subroutine

public function decimal uf_parts_per_cycle (string as_part);Decimal nPartsPerCycle

SELECT part_mfg.parts_per_cycle  
  INTO :nPartsPerCycle  
  FROM part_mfg  
 WHERE part_mfg.part = :as_Part   ;

nPartsPerCycle	= f_get_value(nPartsPerCycle)

If nPartsPerCycle	= 0 then
	Return 1
Else
	Return nPartsPerCycle
End If
end function

public function boolean uf_add_to_job (string as_workorder);decimal	lc_runtime, &
			lc_parts_per_cycle, &
			lc_parts_per_hour, &
			lc_balance, &
			lc_qty

string	ls_workorder

integer	li_row

boolean	lb_add_new

lc_runtime		= uf_get_runtime( as_workorder ) + ic_runtime
			
UPDATE work_order  
   SET runtime = :lc_runtime  
 WHERE work_order.work_order = :as_workorder   ;

if SQLCA.SQLCode = 0 then		//Update header O.K. then update details.
	COMMIT ;
	lc_parts_per_cycle	=  uf_parts_per_cycle( is_part )
	lc_parts_per_hour		=	uf_parts_per_hour( is_part )
	lb_add_new	= not uf_job_part_exists( as_workorder, is_part, lc_qty, lc_balance )
	if lb_add_new then
		INSERT INTO workorder_detail  
			       ( workorder,   
	      	   	part,   
			         qty_required,   
           			qty_completed,   
           			parts_per_cycle,   
           			run_time,   
           			scrapped,   
           			balance,   
           			plant,   
           			parts_per_hour )  
  			VALUES ( :as_workorder,   
         		  	:is_part,   
           			:ic_demand,   
           			0,   
           			:lc_parts_per_cycle,   
           			:ic_runtime,   
           			null,   
           			:ic_demand,   
           			null,   
           			:lc_parts_per_hour )  ;

		else
			
			lc_qty		+= ic_demand
			lc_balance	+= ic_demand

  			UPDATE 	workorder_detail  
     		SET 		qty_required 	= :lc_qty,   
         			run_time 		= :ic_runtime,   
         			balance 			= :lc_balance  
   		WHERE 	workorder_detail.workorder = :as_workorder   ;

		end if

		if SQLCA.SQLCode = 0 then
			COMMIT;
			OpenWithParm( w_calculate_job_time, is_machine )
			return TRUE
		else
			ROLLBACK;
			return FALSE
		end If


		
else
	ROLLBACK;
	return FALSE
end if

	





end function

public function decimal uf_get_runtime (string as_workorder);/*
Description	:	To get the run time for specified work order
Author		:	Jim Wu
Start Date	:	03/13/96
Modification:
*/


/* Declaration */
decimal	lc_runtime

/* Initialization */


/* Main Process */

SELECT 	work_order.runtime  
INTO 		:lc_runtime  
FROM 		work_order  
WHERE 	work_order.work_order = :as_workorder;

return lc_runtime



end function

public function boolean uf_job_part_exists (string as_workorder, string as_part, ref decimal ac_qty, ref decimal ac_balance);SELECT 	workorder_detail.qty_required,   
       	qty_required - qty_completed as qty_left  
INTO 		:ac_qty,   
       	:ac_balance  
FROM 		workorder_detail  
WHERE 	( workorder_detail.workorder 	= :as_workorder ) AND  
        	( workorder_detail.part 		= :as_part )   ;

return ( SQLCA.SQLCode = 0 )

end function

public function boolean uf_create_workorder (string as_workorder);/* 
Description	:	To create a new work order / or add to an existing order.
Author		:	Jim Wu
Start Date	:	03/12/1996
Modification:
*/ 

//	Declaration
long	ll_row
long 	l_count, &
	l_row_count = 0

decimal	lc_parts_per_cycle, &
	lc_parts_per_hour

Dec   	n_order

String 	s_destination
String 	s_customer
string	ls_part
string	ls_notes
string	ls_tool

datetime ldt_end_date

datastore	lds_notes

//	Initialization
//ldt_end_date = datetime(id_end_date)

setnull(ldt_end_date)

For l_count = 1 to dw_mps.Rowcount() 
	if dw_mps.isselected( l_count ) = true then
		if isnull(ldt_end_date) then ldt_end_date = datetime(dw_mps.object.due[l_count])
	        l_row_count = l_row_count + 1
	end if
next

If l_row_Count = 1 Then
 
	n_order =  dw_mps.GetItemNumber ( l_row_count, "origin" )
	id_setuptime =  dw_mps.GetItemDecimal ( l_row_count, "setup" )
	
	If n_order > 0 then
	
		SELECT customer, destination
		INTO :s_customer, :s_destination
		FROM order_header
		WHERE order_no = :n_Order ;
	
		If SQLCA.SQLCODE = -1 Then
			MessageBox( "System Message", Sqlca.sqlerrtext )
		End If
		
		select	min(part_number)
		into	:ls_part
		from	order_detail
		where	order_no = :n_order;
		
		lds_notes = create datastore
		lds_notes.dataobject = 'd_msp_getnotes'
		lds_notes.settransobject ( sqlca ) 
		if lds_notes.retrieve ( ls_part, n_order ) > 0 then
			ls_notes = lds_notes.object.notes [ 1 ]	
		else
			ls_notes = ''
		end if	
		destroy lds_notes
		
		select	tool		
		into	:ls_tool
		from	part_machine_tool
		where	part = :ls_part ;
			
	End If	
End If

//	Main Process
INSERT INTO work_order  
	( work_order,   
	tool,   
	due_date,   
	cycles_required,   
	cycles_completed,   
	machine_no,   
	process_id,   
	customer_part,   
	setup_time,   
	cycles_hour,   
	standard_pack,   
	sequence,   
	cycle_time,   
	start_date,   
	start_time,   
	end_date,   
	end_time,   
	runtime,   
	employee,   
	type,   
	accum_run_time,   
	cycle_unit,   
	material_shortage,   
	lot_control_activated,   
	plant,
	order_no,
	destination,
	customer,
	note)
VALUES ( :as_workorder,   
	:ls_tool,   
	:ldt_end_date,   
	null,   
	null,   
	:is_machine,   
	:is_process_id,   
	null,   
	:id_setuptime,   
	null,   
	null,   
	99999,   
	null,   
	null,   
	null,   
	null,   
	null,   
	:ic_runtime,   
	null,   
	null,   
	null,   
	null,   
	null,   
	null,   
	null,
	:n_order,
	:s_destination,
	:s_customer,
	:ls_notes)  ;	
	
if SQLCA.SQLCode = 0 then
	COMMIT;
	lc_parts_per_cycle	= uf_parts_per_cycle( is_part )
	lc_parts_per_hour		= uf_parts_per_hour( is_part )
	
	INSERT INTO workorder_detail  
		( 	workorder,   
		part,   
		qty_required,   
		qty_completed,   
		parts_per_cycle,   
		run_time,   
		scrapped,   
		balance,   
		plant,   
		parts_per_hour )  
	
	VALUES ( :as_workorder,   
		:is_part,   
		:ic_demand,   
		0,   
		:lc_parts_per_cycle,   
		:ic_runtime,   
		null,   
		:ic_demand,   
		null,   
		:lc_parts_per_hour )  ;
	
	If SQLCA.SQLCode = 0 then
		COMMIT;
		OpenWithParm( w_calculate_job_time, is_machine )
		return TRUE
	Else
		ROLLBACK;
		return FALSE
	End If
Else
	ROLLBACK;
	return FALSE
End If
end function

public function long uf_get_parm_value ();Long ll_workorder

DECLARE mp_get_parm_value PROCEDURE FOR 'dbo.mp_save_worder;1' ;

EXECUTE mp_get_parm_value ;

FETCH mp_get_parm_value INTO :ll_workorder ;

If ll_workorder > 0 Then
	Messagebox("Message", "Successful")
	commit ;
Else
	Messagebox("Message", "Sorry, UnSuccessful")
	Rollback ;
End if

CLOSE mp_get_parm_value ;

RETURN ll_workorder
end function

on constructor;this.triggerevent( 'ue_intialize' )
end on

on u_prod_grid_workorder_part_info.create
this.st_1=create st_1
this.dw_mps=create dw_mps
this.dw_display=create dw_display
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.dw_mps,&
this.dw_display,&
this.gb_2,&
this.gb_1}
end on

on u_prod_grid_workorder_part_info.destroy
destroy(this.st_1)
destroy(this.dw_mps)
destroy(this.dw_display)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_1 from statictext within u_prod_grid_workorder_part_info
int X=2176
int Width=640
int Height=48
boolean Enabled=false
string Text="( Double click to deselect )"
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

type dw_mps from u_jw_dw_super within u_prod_grid_workorder_part_info
int X=1390
int Y=64
int Width=1390
int Height=624
int TabOrder=20
string DataObject="dw_unscheduled_mps"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event doubleclicked;call super::doubleclicked;LONG	ll_row

ll_row	= THIS.getclickedrow()

IF ll_row > 0 THEN
	THIS.selectrow( ll_row, NOT THIS.isselected( ll_row ) )
	uf_recalc_runtime()
	dw_display.accepttext()
END IF
end event

on clicked;return
end on

type dw_display from datawindow within u_prod_grid_workorder_part_info
int X=165
int Y=76
int Width=1097
int Height=600
int TabOrder=10
string DataObject="d_external_prod_sched_demand_generator"
boolean Border=false
boolean LiveScroll=true
end type

on constructor;this.insertrow(1)
this.bringtotop	= TRUE
end on

on losefocus;this.accepttext()
end on

event itemchanged;long		ll_count, &
			ll_row

decimal	lc_qty = 0, &
			lc_parts_per_hour, &
			lc_runtime, &
			lc_demand, &
			lc_original_Demand

decimal	lc_mfg_lot_size, &
			lc_qty_required

if this.getcolumnname( ) = 'qty_required' then
	this.accepttext()

	lc_qty_required	= dec(this.gettext())
	ic_orig_demand		= lc_qty_required

	if lc_qty_required > 0 then

		lc_demand = lc_qty_required

		lc_parts_per_hour	= uf_parts_per_hour( is_part )

		if lc_parts_per_hour > 0 then
			lc_runtime	= ( lc_demand / lc_parts_per_hour )
		else
			lc_runtime	= 0
		end if

	else
		lc_runtime	= 0
	end if

	ic_demand   = lc_qty_required
	dw_display.setitem( 1, 'runtime', 		lc_runtime )
	uf_calc_qty_suggested( ic_demand )

	ic_runtime		= lc_runtime

	parent.triggerevent( 'ue_refresh_graph' )

end if

//decimal	lc_mfg_lot_size, &
//			lc_qty_required, &
//			lc_qty
//
//if this.getcolumnname( ) = 'qty_required' then
//	this.accepttext()
//	lc_qty_required	= dec(this.gettext())
//	ic_orig_demand		= lc_qty_required
//	uf_recalc_runtime()
//end if
end event

type gb_2 from groupbox within u_prod_grid_workorder_part_info
int X=1358
int Width=1463
int Height=720
int TabOrder=40
string Text="MPS Information"
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within u_prod_grid_workorder_part_info
int Width=1353
int Height=720
int TabOrder=30
string Text="Part Information"
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

