$PBExportHeader$u_dw_tree_view_for_trans_history.sru
$PBExportComments$(mst) Datawindow user object to keep the transaction history.
forward
global type u_dw_tree_view_for_trans_history from u_dw_expandable_tree_view_object
end type
end forward

global type u_dw_tree_view_for_trans_history from u_dw_expandable_tree_view_object
string DataObject="d_expandable_tree_view_for_trans_history"
end type
global u_dw_tree_view_for_trans_history u_dw_tree_view_for_trans_history

type variables
string	is_trans_type = 'J', &
	is_from_loc

datetime	idt_datetime

decimal	ic_range = 0.01

boolean	ib_where_used = FALSE
end variables

forward prototypes
public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component)
public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_components_for_job_comp (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_components_for_combine (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_component_for_break_out (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_initialize ()
public subroutine uf_expand_components (string as_key, long al_row, long al_key_pos)
public subroutine uf_get_where_used_for_break_out (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_where_used_for_combine (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_where_used_for_material_issue (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_get_where_used (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_expand_next (string as_key, long al_row, long al_key_pos)
end prototypes

public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component);string	ls_key, &
			ls_type, &
			ls_from_loc, &
			ls_serial, &
			ls_date, &
			ls_time, &
			ls_remark

decimal	lc_qty

ls_key		= astr_component_list.s_parm_list[ ai_key_ptr ]
ls_serial	= astr_component_list.s_parm_list[ 2 ]
ls_type		= astr_component_list.s_parm_list[ 4 ]
ls_remark	= astr_component_list.s_parm_list[ 5 ]
ls_from_loc	= astr_component_list.s_parm_list[ 8 ]
ls_date		= string( date(astr_component_list.dt_parm_list[ 1 ] ) )
ls_time		= string( time(astr_component_list.dt_parm_list[ 1 ] ) )
lc_qty		= astr_component_list.c_parm_list[ 1 ]

if astr_component_list.s_type = '1' then
	this.setitem( ai_row, 'double_click_enabled', 1 )
else
	this.setitem( ai_row, 'double_click_enabled', 0 )
end if

if astr_component_list.b_parm_list[1] then		//display get where used
	this.setitem( ai_row, 'mode_for_where_used', 1 )
else
	this.setitem( ai_row, 'mode_for_where_used', 0 )
end if

this.setitem( ai_row, is_key_column, ls_serial )
this.setitem( ai_row, 'value1', ls_type ) 		//transaction type
this.setitem( ai_row, 'value2', ls_from_loc )	//from location
this.setitem( ai_row, 'value3', ls_date )
this.setitem( ai_row, 'value4', ls_time )
this.setitem( ai_row, 'remark', ls_type )
this.setitem( ai_row, 'qty',	  lc_qty  )


 
super::uf_show_key( ai_row, astr_component_list, ai_key_ptr, al_pos, ab_top_key, ab_last_component )
end subroutine

public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc

datetime	ldt_datetime

if ib_where_used then
	uf_get_where_used( as_key, astr_component_list )
else

	ll_serial	= long( as_key )

	if is_trans_type <> 'C' and is_trans_type <> 'B' and is_trans_type <> 'J' then

		DECLARE cursor_trans CURSOR FOR  
	  	SELECT 	audit_trail.part,   
	         	audit_trail.date_stamp,   
	         	audit_trail.type,   
	         	audit_trail.remarks,   
	         	audit_trail.quantity,   
	         	audit_trail.po_number,   
	         	audit_trail.shipper ,
					audit_trail.from_loc
	   FROM 		audit_trail  
	   WHERE 	audit_trail.serial = :ll_serial   
		ORDER BY audit_trail.date_stamp DESC  ;
	
		OPEN cursor_trans;
		FETCH cursor_trans INTO :ls_part, :ldt_datetime, :ls_type, 		:ls_remark,
										:lc_qty,  :ls_po,        :ls_shipper,		:ls_from_loc;
	
		do while SQLCA.SQLCode = 0
			li_count ++
			astr_component_list[li_count].s_parm_list[ 1 ] 	= &
			string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//			string( ldt_datetime ) + ' ' + string( ll_serial ) + ' ' + trim( ls_part ) 

			astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial )		//serial
			astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
			astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
			astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
			astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
			astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
			astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc
	
			astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
			astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
	
			astr_component_list[li_count].b_parm_list[ 1 ]	= FALSE
	
			if ls_type = 'B' or ls_type = 'C' or ls_type = 'J' then
				astr_component_list[li_count].s_type 	= '1'
			else		
				astr_component_list[li_count].s_type	= '0'
			end if
	
			FETCH cursor_trans INTO :ls_part, :ldt_datetime, :ls_type, 		:ls_remark,
											:lc_qty,  :ls_po,        :ls_shipper,	:ls_from_loc;
	
	
		loop
	
		CLOSE cursor_trans;
	
	else
	
		choose case is_trans_type
			case 'J'
				uf_get_components_for_job_comp( as_key, astr_component_list )
			case 'B'
				uf_get_component_for_break_out( as_key, astr_component_list )
			case 'C'
				uf_get_components_for_combine( as_key, astr_component_list )
		end choose
	
	end if
end if
end subroutine

public subroutine uf_get_components_for_job_comp (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc

datetime	ldt_datetime, &
			ldt_datetime_start, &
			ldt_datetime_end

ldt_datetime_start	= f_relativedatetime( 	date( idt_datetime ), &
															time( idt_datetime ), &
															(-1) * ic_range )

ldt_datetime_end		= f_relativedatetime(	date( idt_datetime ), &
															time( idt_datetime ), &
															ic_range )

DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.serial,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper,
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.date_stamp >= :ldt_datetime_start ) and
			( audit_trail.date_stamp <= :ldt_datetime_end ) and
			( audit_trail.to_loc		 =	 :is_from_loc )  and
			( audit_trail.type		 = 'M' )

ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++
		astr_component_list[li_count].s_parm_list[ 1 ] 	= &
		string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//		string( ldt_datetime ) + ' ' + string( ll_serial ) + ' ' + trim( ls_part ) 
		astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
		astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
		astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
		astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
		astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
		astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
		astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

		astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
		astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
		astr_component_list[li_count].b_parm_list[ 1 ]	= FALSE

		if string( ll_serial ) <> as_key then
			astr_component_list[li_count].s_type = '1'
		else
			astr_component_list[li_count].s_type = '0'
		end if


	FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_get_components_for_combine (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc, &
			ls_serial

datetime	ldt_datetime


DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.from_loc,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper , 
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.type 	= 'C' ) and
			( audit_trail.to_loc = :as_key ) 
 
ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ls_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++

	ll_serial	= long( ls_serial )
	astr_component_list[li_count].s_parm_list[ 1 ] 	= &
	string( ldt_datetime ) + '  SN:' + string( ls_serial ) + '  ' + trim( ls_part ) 

//	string( ldt_datetime ) + ' ' + ls_serial + ' ' + trim( ls_part ) 
	astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
	astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
	astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
	astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
	astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
	astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
	astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

	astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
	astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
	astr_component_list[li_count].b_parm_list[ 1 ]	= FALSE

	if string( ll_serial ) <> as_key then
		astr_component_list[li_count].s_type = '1'
	else
		astr_component_list[li_count].s_type = '0'
	end if


	FETCH cursor_trans INTO :ls_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_get_component_for_break_out (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc



datetime	ldt_datetime


ll_serial	= long( is_from_loc )

DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.serial,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper,
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.serial = :ll_serial ) 
ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++
		astr_component_list[li_count].s_parm_list[ 1 ] 	= &
		string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//		string( ldt_datetime ) + ' ' + string( ll_serial ) + ' ' + trim( ls_part ) 

		astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
		astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
		astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
		astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
		astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
		astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
		astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

		astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
		astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
		astr_component_list[li_count].b_parm_list[ 1 ]	= FALSE

		if string( ll_serial ) <> as_key then
			astr_component_list[li_count].s_type = '1'
		else
			astr_component_list[li_count].s_type = '0'
		end if


	FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_initialize ();is_key_column	= 'serial'
ii_line_count	= 12
super::uf_initialize()
end subroutine

public subroutine uf_expand_components (string as_key, long al_row, long al_key_pos);boolean	lb_enable

lb_enable		= ( this.getitemnumber( al_row, 'double_click_enabled' ) = 1 )

if lb_enable then
	is_trans_type	= this.getitemstring( al_row, 'value1' )
	is_from_loc		= this.getitemstring( al_row, 'value2' )


	idt_datetime	= datetime( date( this.getitemstring( al_row, 'value3' ) ) , &
										time( this.getitemstring( al_row, 'value4' ) ) )

//	super::uf_expand_components( as_key, al_row, al_key_pos )

   uf_expand_next ( as_key, al_row, al_key_pos ) 

end if
end subroutine

public subroutine uf_get_where_used_for_break_out (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc



datetime	ldt_datetime


DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.serial,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper,
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.from_loc = :as_key ) and
			( audit_trail.type = 'B' )
 
ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++
		astr_component_list[li_count].s_parm_list[ 1 ] 	= &
			string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//			string( ldt_datetime ) + ' ' + string( ll_serial ) + ' ' + trim( ls_part ) 
		astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
		astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
		astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
		astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
		astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
		astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
		astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

		astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
		astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
		astr_component_list[li_count].b_parm_list[ 1 ]	= TRUE //Set flag

		if string( ll_serial ) <> as_key then
			astr_component_list[li_count].s_type = '1'
		else
			astr_component_list[li_count].s_type = '0'
		end if


	FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_get_where_used_for_combine (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc, &
			ls_serial

datetime	ldt_datetime


DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.to_loc,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper , 
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.type 	= 'C' ) and
			( audit_trail.from_loc = :as_key ) 
 
ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ls_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++

	ll_serial	= long( ls_serial )
	astr_component_list[li_count].s_parm_list[ 1 ] 	= &
		string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//		string( ldt_datetime ) + ' ' + ls_serial + ' ' + trim( ls_part ) 
	astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
	astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
	astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
	astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
	astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
	astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
	astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

	astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
	astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
	astr_component_list[li_count].b_parm_list[ 1 ]	= TRUE


	if string( ll_serial ) <> as_key then
		astr_component_list[li_count].s_type = '1'
	else
		astr_component_list[li_count].s_type = '0'
	end if


	FETCH cursor_trans INTO :ls_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_get_where_used_for_material_issue (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc

datetime	ldt_datetime, &
			ldt_datetime_start, &
			ldt_datetime_end

ldt_datetime_start	= f_relativedatetime( 	date( idt_datetime ), &
															time( idt_datetime ), &
															(-1) * ic_range )

ldt_datetime_end		= f_relativedatetime(	date( idt_datetime ), &
															time( idt_datetime ), &
															ic_range )

DECLARE cursor_trans CURSOR FOR  
SELECT 	audit_trail.serial,
			audit_trail.part,   
        	audit_trail.date_stamp,   
        	audit_trail.type,   
        	audit_trail.remarks,   
        	audit_trail.quantity,   
        	audit_trail.po_number,   
        	audit_trail.shipper,
			audit_trail.from_loc
FROM 		audit_trail  
WHERE 	( audit_trail.date_stamp >= :ldt_datetime_start ) and
			( audit_trail.date_stamp <= :ldt_datetime_end ) and
			( audit_trail.to_loc		 =	 :is_from_loc )  and
			( audit_trail.type		 = 'J' )

ORDER BY audit_trail.date_stamp DESC  ;

OPEN cursor_trans;
FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
								:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
								:ls_from_loc;

do while SQLCA.SQLCode = 0
	li_count ++
		astr_component_list[li_count].s_parm_list[ 1 ] 	= &
			string( ldt_datetime ) + '  SN:' + string( ll_serial ) + '  ' + trim( ls_part ) 

//			string( ldt_datetime ) + ' ' + string( ll_serial ) + ' ' + trim( ls_part ) 
		astr_component_list[li_count].s_parm_list[ 2 ]	= string( ll_serial) 		//serial
		astr_component_list[li_count].s_parm_list[ 3 ]	= ls_part
		astr_component_list[li_count].s_parm_list[ 4 ]	= ls_type
		astr_component_list[li_count].s_parm_list[ 5 ]	= ls_remark
		astr_component_list[li_count].s_parm_list[ 6 ]	= ls_po
		astr_component_list[li_count].s_parm_list[ 7 ]	= ls_shipper
		astr_component_list[li_count].s_parm_list[ 8 ]	= ls_from_loc

		astr_component_list[li_count].c_parm_list[ 1 ]	= lc_qty
		astr_component_list[li_count].dt_parm_list[ 1 ]	= ldt_datetime
		astr_component_list[li_count].b_parm_list[ 1 ]	= TRUE

		if string( ll_serial ) <> as_key then
			astr_component_list[li_count].s_type = '1'
		else
			astr_component_list[li_count].s_type = '0'
		end if


	FETCH cursor_trans INTO :ll_serial, :ls_part, :ldt_datetime, :ls_type, 
									:ls_remark, :lc_qty,  :ls_po,        :ls_shipper,
									:ls_from_loc;

loop

CLOSE cursor_trans;


end subroutine

public subroutine uf_get_where_used (string as_key, ref s_parm_list astr_component_list[]);long		ll_serial

integer	li_count = 0

decimal	lc_qty

string	ls_part, &
			ls_type, &
			ls_remark, &
			ls_po, &
			ls_shipper, &
			ls_from_loc

datetime	ldt_datetime

ll_serial	= long( as_key )

if is_trans_type <> 'C' and is_trans_type <> 'B' and is_trans_type <> 'M'  then

	return

else

	choose case is_trans_type
		case 'M'
			uf_get_where_used_for_material_issue( as_key, astr_component_list )
		case 'B'
			uf_get_where_used_for_break_out( as_key, astr_component_list )
		case 'C'
			uf_get_where_used_for_combine( as_key, astr_component_list )
	end choose

end if
end subroutine

public subroutine uf_expand_next (string as_key, long al_row, long al_key_pos);s_parm_list	lstr_component_list[]

integer	li_count, &
			li_ptr, &
			li_row, &
			li_level, &
			li_line_ptr, &
			li_current_row

string	ls_line_col,s_tmpstr

long		ll_component_pos,l_tmpno

ll_component_pos	= al_key_pos + ii_line_width
li_row				= al_row
li_level				= this.getitemnumber( al_row, 'level' ) + 1

if li_level > ii_line_count then
	ib_out_of_limit	= TRUE
	return
end if

uf_get_components( as_key, lstr_component_list[] )

li_count	= upperbound( lstr_component_list )

if li_count	> 0 then
	this.setitem( al_row, 'has_component', 1 )
	this.setitem( al_row, 'ultimate_last_component', 0 )
end if

this.setitem( al_row, 'expanded', 1 )

for li_ptr = 1 to li_count
	ii_row_added ++
	if ib_expand_all then
		li_current_row	= ii_row_added + ii_starting_row
	else
		li_current_row	= al_row + li_ptr
	end if

	this.insertrow( li_current_row )
	this.setitem( li_current_row, 'level', li_level )

	uf_show_key( 	li_current_row , &
						lstr_component_list[ li_ptr ], &
		 				1, &
						ll_component_pos, FALSE, (li_ptr = li_count) )

//	uf_save_parent_row( al_row, li_current_row )

	for li_line_ptr = 1 to ii_line_count
		ls_line_col	= 'line' + string( li_line_ptr ) + '_visible'
		this.setitem( 	li_current_row, ls_line_col, &
							this.getitemnumber( al_row, ls_line_col ) )
	next

	if li_ptr = li_count then
		this.setitem( li_current_row, 'ultimate_last_component', 1 )
		this.setitem( li_current_row, 'line' + string( li_level ) + '_visible', 0 )
	end if

//  	if ib_expand_all then
//		uf_expand_components( this.getitemstring(li_current_row, is_key_column), &
//									 li_current_row, &
// 									 this.getitemnumber(li_current_row, 'key_pos'))
//
//	end if
next


end subroutine

on rbuttondown;call u_dw_expandable_tree_view_object::rbuttondown;string	ls_key

integer	li_expanded

long		ll_row, &
			ll_count, &
			ll_key_pos

ii_row_added	= 0	
ll_row	= this.getrow()
ll_count	= this.rowcount()

if ll_row > 0 then
	ls_key		=	this.getitemstring( ll_row, is_key_column )
	li_expanded	=	this.getitemnumber( ll_row, 'expanded' )
	ll_key_pos	=  this.getitemnumber( ll_row, 'key_pos' )

	ib_where_used	= TRUE

	is_trans_type	= this.getitemstring( ll_row, 'value1' )

	if is_trans_type = 'M' or is_trans_type = 'B' or is_trans_type = 'C' then
		if li_expanded = 1 then
			uf_hide_components( ls_key, ll_row, ll_key_pos )
		else
			ib_out_of_limit	= FALSE
			uf_expand_components( ls_key, ll_row, ll_key_pos )
			if ib_out_of_limit then
				uf_display_message()
			end if
		end if		
	end if

end if

end on

on doubleclicked;ib_where_used	= FALSE

//call super::doubleclicked

string	ls_key

integer	li_expanded

long		ll_row, &
			ll_count, &
			ll_key_pos

ii_row_added	= 0	
ll_row			= this.getclickedrow()
ll_count			= this.rowcount()

if ll_row > 0 then
	ii_starting_row	= 	ll_row
	ls_key				=	this.getitemstring( ll_row, is_key_column )
	li_expanded			=	this.getitemnumber( ll_row, 'expanded' )
	ll_key_pos			=  this.getitemnumber( ll_row, 'key_pos' )

	if li_expanded = 1 then
		uf_hide_components( ls_key, ll_row, ll_key_pos )
	else
		ib_out_of_limit	= FALSE
		uf_expand_components( ls_key, ll_row, ll_key_pos )
		if ib_out_of_limit then
			uf_display_message()
		end if
	end if		
end if

end on

on rowfocuschanged;call u_dw_expandable_tree_view_object::rowfocuschanged;// modify the expression for the record_indicator
// column so that the arrow points to the current row.
long ll_row
string ls_curr_row


ll_row = this.getrow()
if ll_row > 0 and ll_row <= this.RowCount() then 
	ls_curr_row = string( ll_row )
	
	this.Modify( "record_indicator.expression='" + &
		"if( getrow()=" + ls_curr_row + ", char( 216 ), if( isRowModified(), char(32), char(32)))' " )

	this.Modify( "record_indicator1.expression='" + &
		"if( getrow()=" + ls_curr_row + ", char( 216 ), if( isRowModified(), char(32), char(32)))' " )

end if



end on

