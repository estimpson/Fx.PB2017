$PBExportHeader$u_preload_object.sru
forward
global type u_preload_object from nonvisualobject
end type
end forward

global type u_preload_object from nonvisualobject
end type
global u_preload_object u_preload_object

forward prototypes
public function boolean uf_update_mps_assigned_qty (string as_part, string as_type, string as_plant)
public function decimal uf_total_qty_in_job (string as_part, string as_plant)
public function decimal uf_total_qty_in_po (string as_part, string as_plant)
end prototypes

public function boolean uf_update_mps_assigned_qty (string as_part, string as_type, string as_plant);/*
Description	:	To calculate the MPS quantity assigned.
Author		:	Jim Wu
Start Date	:	02/27/96
Modification:
*/

/* Declaration */
decimal	lc_qty, &
			lc_qty_left

date		ld_date
time		lt_time

datetime	l_ld_date
datetime	l_lt_time

/* Initialization */

If as_type = "P" then
	lc_qty_left	=  f_get_value(uf_total_qty_in_po (as_part, as_plant))
Else
	lc_qty_left	=	f_get_value(uf_total_qty_in_job (as_part, as_plant))
End If

UPDATE master_prod_sched SET qty_assigned = 0 WHERE part = :as_part;
If SQLCA.SQLCode = 0 then
	COMMIT;
Else
	ROLLBACK;
	Return FALSE
End if

DECLARE curMPS CURSOR FOR  
 SELECT qnty,   
        dead_start,   
        start_time  
   FROM master_prod_sched  
  WHERE ( master_prod_sched.part 	= :as_part )  
ORDER BY  master_prod_sched.dead_start ASC,   
        	 master_prod_sched.start_time ASC  ;

/* Main Process */

OPEN curMPS;

FETCH curMPS INTO :lc_qty, :l_ld_date, :l_lt_time;

do while SQLCA.SQLCode = 0 AND lc_qty_left > 0 
	if lc_qty > lc_qty_left then
		lc_qty		= lc_qty_left
		lc_qty_left	= 0
	else
		lc_qty_left	-= lc_qty
	end if
	UPDATE master_prod_sched
	SET qty_assigned = lc_qty
	WHERE CURRENT of curMPS ;
loop 

CLOSE curMPS;

If SQLCA.SQLCode = 0 then
	COMMIT;
	Return TRUE
Else
	ROLLBACK;
	Return FALSE
End If

end function

public function decimal uf_total_qty_in_job (string as_part, string as_plant);/*
Description	:	To get the total quantity in job
Author		:	Jim Wu
Start Date	:	02/27/96
Modification:
*/


/* Declaration */
decimal	lc_total	= 0

/* Initialization */


/* Main Process */

If isNull(as_plant) then
	SELECT total_qty INTO :lc_total FROM v_part_qty_in_job
	WHERE part = :as_part;
Else
	SELECT total_qty INTO :lc_total FROM v_part_qty_in_job
	WHERE part = :as_part AND plant = :as_plant;
End If

return lc_total
end function

public function decimal uf_total_qty_in_po (string as_part, string as_plant);/*
Description	:	To get the total quantity in PO
Author		:	Jim Wu
Start Date	:	02/27/96
Modification:
*/


/* Declaration */
decimal	lc_total	= 0

/* Initialization */


/* Main Process */

If isNull(as_Plant) then
	SELECT total_qty INTO :lc_total FROM v_part_qty_in_po
	WHERE part_number = :as_part;
Else
	SELECT total_qty INTO :lc_total FROM v_part_qty_in_po
	WHERE part_number = :as_part AND plant = :as_plant;
End If

return lc_total
end function

on u_preload_object.create
TriggerEvent( this, "constructor" )
end on

on u_preload_object.destroy
TriggerEvent( this, "destructor" )
end on

