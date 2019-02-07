$PBExportHeader$w_part_production.srw
forward
global type w_part_production from Window
end type
type em_noofobjs from editmask within w_part_production
end type
type st_objs from statictext within w_part_production
end type
type cb_pallet_label from commandbutton within w_part_production
end type
type sle_pallet from singlelineedit within w_part_production
end type
type cb_pallet from commandbutton within w_part_production
end type
type sle_lotnumber from singlelineedit within w_part_production
end type
type cb_9 from commandbutton within w_part_production
end type
type dw_upd_mps_qtyassigned from datawindow within w_part_production
end type
type sle_1 from singlelineedit within w_part_production
end type
type dw_woseq from datawindow within w_part_production
end type
type cb_8 from commandbutton within w_part_production
end type
type sle_scrapped_um from editmask within w_part_production
end type
type sle_total_um from editmask within w_part_production
end type
type sle_pack_um from editmask within w_part_production
end type
type p_1 from picture within w_part_production
end type
type cb_6 from commandbutton within w_part_production
end type
type st_8 from statictext within w_part_production
end type
type em_total_scrapped from editmask within w_part_production
end type
type dw_6 from datawindow within w_part_production
end type
type dw_5 from datawindow within w_part_production
end type
type st_3 from statictext within w_part_production
end type
type dw_4 from datawindow within w_part_production
end type
type cb_7 from commandbutton within w_part_production
end type
type cb_5 from commandbutton within w_part_production
end type
type cb_4 from commandbutton within w_part_production
end type
type cb_3 from commandbutton within w_part_production
end type
type em_total_parts from editmask within w_part_production
end type
type em_boxes_completed from editmask within w_part_production
end type
type em_std_box_qty from editmask within w_part_production
end type
type dw_3 from datawindow within w_part_production
end type
type st_7 from statictext within w_part_production
end type
type st_6 from statictext within w_part_production
end type
type st_5 from statictext within w_part_production
end type
type cb_2 from commandbutton within w_part_production
end type
type cb_1 from commandbutton within w_part_production
end type
type dw_1 from datawindow within w_part_production
end type
type st_1 from statictext within w_part_production
end type
type st_4 from statictext within w_part_production
end type
type st_2 from statictext within w_part_production
end type
type dw_2 from datawindow within w_part_production
end type
end forward

global type w_part_production from Window
int X=32
int Y=4
int Width=2921
int Height=2332
boolean TitleBar=true
string Title="Completion"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event type integer ue_popup_scale ( )
em_noofobjs em_noofobjs
st_objs st_objs
cb_pallet_label cb_pallet_label
sle_pallet sle_pallet
cb_pallet cb_pallet
sle_lotnumber sle_lotnumber
cb_9 cb_9
dw_upd_mps_qtyassigned dw_upd_mps_qtyassigned
sle_1 sle_1
dw_woseq dw_woseq
cb_8 cb_8
sle_scrapped_um sle_scrapped_um
sle_total_um sle_total_um
sle_pack_um sle_pack_um
p_1 p_1
cb_6 cb_6
st_8 st_8
em_total_scrapped em_total_scrapped
dw_6 dw_6
dw_5 dw_5
st_3 st_3
dw_4 dw_4
cb_7 cb_7
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
em_total_parts em_total_parts
em_boxes_completed em_boxes_completed
em_std_box_qty em_std_box_qty
dw_3 dw_3
st_7 st_7
st_6 st_6
st_5 st_5
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
st_1 st_1
st_4 st_4
st_2 st_2
dw_2 dw_2
end type
global w_part_production w_part_production

type variables
Time tStartTime

Date dStartDate

Decimal nDwTotalParts
Decimal nDwStandardPack
decimal	idec_ScaleWeight

DateTime dtDateTime

String szPackageType
String ls_operator
String is_part
String is_machine
String is_workorder
String cUndoJC
String cUndoDefects
String cUndoDownTime
String cChangeStdPack
string  is_UserStatus
string	i_s_job_change
string	is_commport

Long iJCAuditRow
Long iDefectsRow

Boolean bUndoJC
Boolean bUndoDefects
Boolean bUndoDownTime
Boolean bForced
boolean	ib_scale = FALSE
Long	il_PalletSerial=0
string	is_supervisorclose='N'
end variables

forward prototypes
public subroutine perform_completion ()
public subroutine total_scrapped ()
public subroutine wf_reset_std_pack ()
public subroutine wf_change_std_pack ()
public subroutine wf_undo_completion ()
public subroutine wf_undo_defects ()
public function boolean wf_close_job (string a_s_workorder, string a_s_part, string a_s_machine)
end prototypes

event ue_popup_scale;str_serial_interface_in		l_str_parm
str_serial_interface_out	l_str_return
Int								i_Pos
String							s_Temp
long								ll_row

l_str_parm.machine				= is_machine
l_str_parm.part					= is_part
l_str_parm.package_type			= szpackagetype
l_str_parm.parent_window		= This
l_str_parm.original_part	 	= is_part
//l_str_parm.dw_pallet_array		= dw_pallets

//Yield ( )

sle_1.Text = "machine:" + is_machine + " / part:" + is_part + " / packagetype:" + szpackagetype

OpenWithParm ( w_serial_interface, l_str_parm )

l_str_return = Message.PowerObjectParm

IF IsValid ( l_str_return ) THEN
	IF l_str_return.return_code = 1 THEN		//Normal return
		idec_ScaleWeight = l_str_return.weight
		// this needs to come from part_inventory.process_quantity
		em_std_box_qty.Text = "1"
		//
	END IF
END IF

return l_str_return.return_code
end event

public subroutine perform_completion ();// 	Declare Variables
Time	tTime
Dec	dQuantity, dWeight, dCost, dOnHand
Dec	dQtyCompleted, dStdQty
String 	szStatus, szLocationTo, szFromLoc, szUnit
String 	cQA, ls_engineering_level
string	l_s_plant, l_s_origin, ls_lotnumber
long	l_l_origin
Long 	lSerial
Date	dToday
DateTime dDateStamp

Str_progress	stParm
st_generic_structure	stParm2

Int	iCount, iTenTimes, iTotalobjs

ls_lotnumber = sle_lotnumber.text

// 	Prime and open progress window
stParm.Title = 'Job Completion'
stParm.Cancel_window = w_part_production
stParm.Cancel_event = 'Open!'

OpenWithParm ( w_progress, stParm )

// 	Initialize variables
iCount	= 0
tTime	= Now ( )
dQuantity = Dec ( em_std_box_qty.Text )
if sle_pack_um.Text <> sle_total_um.Text then
	dStdQty = f_convert_units ( sle_pack_um.Text,sle_total_um.Text,is_part,dQuantity )
else
	dStdQty = dQuantity
end if
dToday	= Today ( )
szLocationTo = is_machine
is_part	= dw_1.GetItemString ( dw_1.GetRow ( ), "workorder_detail_part" )
szFromLoc = is_machine
dDateStamp = DateTime ( Today ( ), Now ( ) )
is_workorder = is_workorder

//	Grab order number from workorder
SELECT	work_order.order_no  
INTO	:l_l_origin  
FROM	work_order  
WHERE	work_order.work_order = :is_workorder AND
	work_order.machine_no = :is_machine;

IF f_get_value ( l_l_origin ) <= 0 THEN
	SetNull ( l_s_origin )
ELSE
	l_s_origin = String ( l_l_origin )
END IF

//	Grab plant from workorder_detail
SELECT	workorder_detail.plant  
INTO	:l_s_plant  
FROM	workorder_detail  
WHERE	(workorder_detail.workorder = :is_workorder ) AND  
	(workorder_detail.part = :is_part );

//	grab standard cost from part master
SELECT	part.quality_alert  
INTO	:cQA  
FROM	part  
WHERE	part.part = :is_part;

If cQA = 'Y' Then
	szStatus = 'H'
	is_UserStatus = "On Hold"
Else
	szStatus = 'A'
	is_UserStatus = "Approved"
End if

SELECT	part_standard.cost_cum  
INTO	:dcost  
FROM	part_standard  
WHERE	part_standard.part = :is_part;

// 	grab weight from part master
SELECT	part_inventory.unit_weight,   
	part_inventory.standard_unit  
INTO	:dWeight,   
	:szUnit  
FROM	part_inventory  
WHERE	part_inventory.part = :is_part;

if idec_ScaleWeight > 0 then
	dWeight = idec_ScaleWeight
else
	setnull(dweight)  // setting the value null to weight as it's being calculated in the trigger
end if

szUnit = sle_pack_um.Text

// 	Grab engineering level from part master
SELECT	engineering_level
INTO	:ls_engineering_level
FROM	part_mfg
WHERE	part = :is_part;

iTotalobjs = integer(isnull(em_noofobjs.text,1))

if  iTotalobjs = 0 then iTotalobjs = 1

//	Grab next serial number and update parameter file
For iTenTimes = 1 to iTotalobjs  //10
	if SQLCA.of_getnextparmvalue ( 'next_serial' , lSerial ) then  
		iCount = iCount + 1
		w_progress.wf_progress ( iCount / 5, "Creating Object..." )
	
		//  Create object record
		INSERT INTO object  
			( serial,   
			part,   
			lot,   
			location,   
			last_date,   
			unit_measure,   
			operator,   
			status,   
			destination,   
			station,   
			origin,   
			cost,
			std_cost,   
			weight,   
			parent_serial,   
			note,   
			po_number,   
			quantity,   
			last_time,   
			date_due,   
			customer,
			package_type,   
			sequence,
			std_quantity,
			user_defined_status,
			workorder,
			engineering_level,
			plant )  
		VALUES ( :lSerial,   
			:is_part,   
			:ls_lotnumber,
			:szLocationTo,   
			:dDateStamp,   
			:szUnit,   
			:ls_operator,   
			:szStatus,   
			null,   
			null,   
			:l_s_origin,   
			:dCost,   
			:dCost,
			:dWeight,   
			:il_PalletSerial,   
			null,   
			null,   
			:dQuantity,   
			:dDateStamp,   
			null,   
			null,   
			:szPackageType,
			null,
			:dStdQty,
			:is_UserStatus,
			:is_workorder,
			:ls_engineering_level,
			:l_s_plant )  ;
			
		If SQLCA.SQLCode = -1 Then
			RollBack ;
		Else
			
			iCount = iCount + 1
			w_progress.wf_progress ( iCount / 5, "Updating On Hand..." )
			
			dOnHand = f_update_onhand ( is_part, dQuantity, "+" )
	
			If SQLCA.SQLCode = -1 Then
				RollBack ;
			Else
				iCount = iCount + 1
				w_progress.wf_progress ( iCount / 5, "Creating Audit Trail..." )
	
				//  Create audit trail
	
				If Not f_create_audit_trail ( lSerial, "J", "", String ( dCost ), "", "", is_workorder, "", "", "", "", "" ) Then

					Rollback;

				Else
					iCount = iCount + 1
					w_progress.wf_progress ( iCount / 5, "Printing Label..." )
	
					//  print label
					Commit ;
	
					stParm2.value1 = String ( lSerial )
					f_print_label ( stParm2 )
	
					//iTenTimes = 10
	
				End if
	
			End if
	
		End if
	else
		rollback;
	end if 
Next 

em_noofobjs.text='1'

Close ( w_progress )

dw_2.SetTransObject ( sqlca )
If cb_8.Text = "Audit Trail" then
	dw_2.Retrieve ( is_workorder )
else
	dw_2.Retrieve ( is_workorder, is_machine )
End if
end subroutine

public subroutine total_scrapped ();Long iCount

Dec dTotalScrapped, dQty

dtotalScrapped=0

For iCount = 1 to dw_4.RowCount ( )

	dQty = dw_4.GetItemNumber ( iCount, "quantity" )

	dTotalScrapped = dTotalScrapped + dQty
	
Next

em_total_scrapped.Text = String ( dTotalScrapped )

  UPDATE workorder_detail  
     SET scrapped = :dTotalScrapped  
   WHERE ( workorder = :is_workorder ) AND  
         ( part = :is_part )   ;
			
  If SQLCA.SQLCode <> 0 Then
  	  RollBack ;
  Else
	  commit ;
  End if	  
end subroutine

public subroutine wf_reset_std_pack ();Dec dStdPack

dStdPack = dw_1.GetItemNumber ( 1, "part_inventory_standard_pack" )

em_std_box_qty.Text = String ( dStdPack )
end subroutine

public subroutine wf_change_std_pack ();Dec 		dStdPack
STRING	l_s_temp,&
			l_s_unit
INT		l_i_pos
st_generic_structure	l_str_parm

l_str_parm.value1 = is_part
l_str_parm.value2 = sle_pack_um.Text

OpenWithParm ( w_change_std_pack, l_str_parm )

l_s_temp = Message.StringParm
l_i_pos = PosA ( l_s_temp, '~t' )

IF l_i_pos > 0 THEN
	dStdPack = Dec ( LeftA ( l_s_temp, l_i_pos - 1 ) )
	l_s_unit = RightA ( l_s_temp, LenA ( l_s_temp ) - l_i_pos )
ELSE
	dStdPack = Dec ( l_s_temp )
END IF

If dStdPack > 0 Then em_std_box_qty.Text = String ( dStdPack )
If f_get_string_value ( l_s_unit ) > '' Then sle_pack_um.Text = l_s_unit

end subroutine

public subroutine wf_undo_completion ();String is_partNumber
Long lSerialNumber
Dec dStdQty
Dec dQty
Int iRtnCode

lSerialNumber = dw_2.GetItemNumber ( iJCAuditRow, "serial" )
is_partNumber  = dw_2.GetItemString ( iJCAuditRow, "part" )

If lSerialNumber > 0 Then

	iRtnCode = MessageBox ( "Undo", "Are you sure you want to undo completion of serial: " + String ( lSerialNumber ) + "?", Question!, YesNo!, 2 )

	If iRtnCode = 1 Then

		If cb_8.Text = "Audit Trail" then

		   SELECT object.std_quantity,
					 object.quantity
	   	  INTO :dStdQty,
					 :dQty
		     FROM object  
		    WHERE object.serial = :lSerialNumber   ;
	
			If SQLCA.SQLCode <> 0 Then
				RollBack ;
			Else
			
			   DELETE FROM object  
			    WHERE serial = :lSerialNumber   ;
	
				IF SQLCA.SQLCode <> 0 THEN
					RollBack  ;
					Return 
				END IF
	
				UPDATE workorder_detail
					SET qty_completed = qty_completed - :dStdQty,
						 balance = balance + :dStdQty
				 WHERE workorder = :is_workorder AND part = :is_partNumber  ;
		
				If SQLCA.SQLCode <> 0 Then
					RollBack ;
				Else
	
					f_update_onhand ( is_partNumber, dStdQty, '-' )
		
					If dw_2.DeleteRow ( iJCAuditRow ) = -1 Then
						RollBack ;
					Else
						If dw_2.Update ( ) = -1 Then
							RollBack ;
						Else
							Commit ;
							em_total_parts.Text = String ( Dec ( em_total_parts.Text ) - dStdQty )
							if Integer ( em_boxes_completed.text) > 0 then &
								em_boxes_completed.text = String ( Integer ( em_boxes_completed.text) - 1 )
							dw_1.Retrieve ( is_part, is_workorder )
						End if
	
					End if
		
				End if
				
			End if

		Else
		
			dStdQty 	= dw_2.GetItemNumber ( iJCAuditRow, "std_quantity" )
			dQty		= dw_2.GetItemNumber ( iJCAuditRow, "quantity" )

		   DELETE FROM audit_trail
		    WHERE serial = :lSerialNumber   ;
	
			IF SQLCA.SQLCode <> 0 THEN
				RollBack  ;
				Return 
			END IF
	
			UPDATE workorder_detail
				SET qty_completed = qty_completed - :dStdQty,
					 balance = balance + :dStdQty
			 WHERE workorder = :is_workorder AND part = :is_partNumber  ;
	
			If SQLCA.SQLCode <> 0 Then
				RollBack ;
			Else
	
				f_update_onhand ( is_partNumber, dStdQty, '-' )
		
				If dw_2.DeleteRow ( iJCAuditRow ) = -1 Then
					RollBack ;
				Else
					If dw_2.Update ( ) = -1 Then
						RollBack ;
					Else
						Commit ;
						em_total_parts.Text = String ( Dec ( em_total_parts.Text ) - dStdQty )
						if Integer ( em_boxes_completed.text) > 0 then &
							em_boxes_completed.text = String ( Integer ( em_boxes_completed.text) - 1 )
						dw_1.Retrieve ( is_part, is_workorder )
					End if
	
				End if
		
			End if
				
		End if

	End if

End if

end subroutine

public subroutine wf_undo_defects ();Int iRtnCode

Date d_date
Time d_time

Datetime d_defecttime
Dec  l_d_defect_qty, &
     l_d_wod_def_qty, &
	  l_d_def_rem_qty

iRtnCode = MessageBox ( "Undo", "Are you sure you want to undo defect?", Question!, YesNo!, 2 )

If iRtnCode = 1 Then
	
  	d_date = dw_4.Getitemdate ( iDefectsRow, 'defect_date' )
	d_time = dw_4.Getitemtime ( iDefectsRow, 'defect_time' )
	d_Defecttime = datetime(d_date, d_time)

	DELETE FROM defects
   where machine = :is_machine  and 
         defect_date  = :d_defecttime and
         defect_time  = :d_defecttime and 
         part         = :is_part and
         work_order    = :is_workorder ;

	If sqlca.sqlcode = -1 Then
			RollBack ;
         MessageBox( "System Message", sqlca.sqlerrtext )
	Else
			Commit ;
         dw_4.Retrieve(is_part, is_workorder)
// calling the total_scrapped function to update workorder_detail scrapped column			
			w_part_production.total_scrapped()
	End if
End if

end subroutine

public function boolean wf_close_job (string a_s_workorder, string a_s_part, string a_s_machine);string	l_s_message
int		l_i_count

INSERT INTO workorder_detail_history  
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
	SELECT 	workorder,   
           	part,   
           	qty_required,   
           	qty_completed,   
           	parts_per_cycle,   
           	run_time,   
           	scrapped,   
           	balance,   
           	plant,   
           	parts_per_hour
	FROM		workorder_detail
	WHERE		workorder = :a_s_workorder AND
				part = :a_s_part ;

if sqlca.sqlcode <> 0 then
	l_s_message = sqlca.sqlerrtext
	rollback;
	MessageBox ( "Database Error", "Unable to save job history!~r~nReason:" + l_s_message, StopSign! )
	return FALSE
end if

DELETE FROM workorder_detail  
 WHERE ( workorder_detail.workorder = :a_s_workorder ) AND  
       ( workorder_detail.part = :a_s_part )   ;

if sqlca.sqlcode <> 0 then
	l_s_message = sqlca.sqlerrtext
	rollback;
	MessageBox ( "Database Error", "Unable to delete job!~r~nReason:" + l_s_message, StopSign! )
	return FALSE
end if

SELECT	count(*)
INTO		:l_i_count
FROM		workorder_detail
WHERE		workorder = :a_s_workorder ;

if l_i_count <= 0 then

	INSERT INTO workorder_header_history  
	         ( 	work_order,   
	           	machine_no,   
	           	sequence,   
	           	tool,   
	           	due_date,   
	           	cycles_required,   
	           	cycles_completed,   
	           	process_id,   
	           	customer_part,   
	           	setup_time,   
	           	cycles_hour,   
	           	standard_pack,   
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
					customer,
					destination)  
		SELECT	work_order,   
	           	machine_no,   
	           	sequence,   
	           	tool,   
	           	due_date,   
	           	cycles_required,   
	           	cycles_completed,   
	           	process_id,   
	           	customer_part,   
	           	setup_time,   
	           	cycles_hour,   
	           	standard_pack,   
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
					customer,
					destination
		FROM		work_order
		WHERE		work_order = :a_s_workorder  ;

	if sqlca.sqlcode <> 0 then
		l_s_message = sqlca.sqlerrtext
		rollback;
		MessageBox ( "Database Error", "Unable to save job history!~r~nReason:" + l_s_message, StopSign! )
		return FALSE
	end if
	
	DELETE FROM work_order  
	 WHERE ( work_order.work_order = :a_s_workorder ) AND  
	       ( work_order.machine_no = :a_s_machine )   ;
	
	if sqlca.sqlcode <> 0 then
		l_s_message = sqlca.sqlerrtext
		rollback;
		MessageBox ( "Database Error", "Unable to delete job!~r~nReason:" + l_s_message, StopSign! )
		return FALSE
	end if

	//	re-sequence header records
	dw_woseq.SetTransObject ( sqlca )
	dw_woseq.Retrieve ( a_s_workorder )

	for l_i_count = 1 to dw_woseq.RowCount ( )
		dw_woseq.SetItem ( l_i_count, "sequence", l_i_count )
	next	

	if dw_woseq.Update ( ) = -1 then
		rollback;
		return FALSE
	end if

end if

commit;

// update assigned qty in mps
dw_upd_mps_qtyassigned.retrieve ( a_s_part ) 

return TRUE
end function

event open;/*  Do what is necessary to set up window.  */
st_generic_structure stGenParm
Dec 	dQtyRequired
Dec 	dQtyCompleted
Dec 	dBalance
Long 	nRowNum
String	ls_StdUnit
string	ls_winwedge_loc
string	ls_winwedge_config
string	ls_scaleattached

integer	li_commport

stGenParm   = Message.PowerObjectParm
ls_operator  = stGenParm.Value1
is_part      = stGenParm.Value2
is_machine   = stGenParm.Value3
is_workorder = stGenParm.Value4

If stGenParm.Value10 = "ForceJC" Then bForced = True

/*  Update the the Machine down time start  */
tStartTime = Now ( )
dStartDate = Today ( )
dtDateTime = DateTime ( Today ( ), Now ( ) )

/*  Check if undo is allowed  */
  SELECT machine_policy.job_completion_delete,
			machine_policy.defects_delete,
			machine_policy.change_std_pack,
			machine_policy.downtime_delete,
			machine_policy.job_change,
			machine_policy.supervisorclose
    INTO :cUndoJC,
			:cUndoDefects,
			:cChangeStdPack,
			:cUndoDownTime,
			:i_s_job_change,
			:is_supervisorclose
    FROM machine_policy  
   WHERE machine_policy.machine = :is_machine   ;

If cChangeStdPack = 'Y' Then cb_3.Enabled = True

// get scale info (if attached)
SELECT	winwedge_location, 
	wwconfig_location,
	serial_interface,
	serial_port
INTO	:ls_winwedge_loc,
	:ls_winwedge_config,
	:ls_ScaleAttached,
	:li_commport
FROM	machine_serial_comm 
WHERE	machine = :is_machine ;

If SQLCA.SQLCode = 0 Then
	If ls_ScaleAttached <> '(None)' OR f_get_string_value ( ls_ScaleAttached ) <> '' Then
		// Get machine serial communications parameters
		// If valid values, open WinWedge with config file and minimize
		ib_Scale = TRUE
		is_commport = "COM" + String ( li_commport )
	else
		MessageBox ( "Serial Interface", "The configuration settings for the serial interface are not set up correctly.  Please check settings and try again.", Information! )
		ib_scale = FALSE
	END IF
End if


/*  Check for a work order and if there is none we must create
	 a new workorder */
dw_1.settransobject ( sqlca )
If dw_1.Retrieve ( is_part, is_workorder ) < 1 Then Return

dQtyRequired = f_get_value ( dw_1.GetItemNumber ( 1, "workorder_detail_qty_required" ) )
dQtyCompleted = f_get_value ( dw_1.GetItemNumber ( 1, "workorder_detail_qty_completed" ) ) 
dBalance = dQtyRequired - dQtyCompleted

dw_1.SetItem ( 1, "balance", dBalance )

dw_4.settransobject ( sqlca )
dw_4.Retrieve ( is_part, is_workorder ) 

nRowNum = dw_1.GetRow ( )

If nRowNum < 1 Then Return

ndwtotalparts   = dw_1.GetItemNumber( nRowNum, "workorder_detail_qty_completed" )
ndwstandardpack = dw_1.GetItemNumber( nRowNum, "part_inventory_standard_pack" )
ls_StdUnit		 = dw_1.GetItemString( nRowNum, "part_inventory_standard_unit" )

em_total_parts.text = String(nDwTotalParts)
em_std_box_qty.text = String(ndwstandardpack)
sle_pack_um.Text = ls_StdUnit
sle_total_um.Text = ls_StdUnit
sle_scrapped_um.Text = ls_StdUnit

dw_6.SetTransObject ( sqlca )
dw_6.Retrieve ( is_part )

total_scrapped ( )

dw_2.SetTransObject ( sqlca )
dw_2.Retrieve ( is_workorder )

UPDATE work_order  
   SET lot_control_activated = 'N'  
 WHERE work_order = :is_workorder   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit ;
End if


end event

on activate;dw_4.settransobject ( sqlca )
dw_4.Retrieve ( is_part, is_workorder )
total_scrapped ( )
end on

on w_part_production.create
this.em_noofobjs=create em_noofobjs
this.st_objs=create st_objs
this.cb_pallet_label=create cb_pallet_label
this.sle_pallet=create sle_pallet
this.cb_pallet=create cb_pallet
this.sle_lotnumber=create sle_lotnumber
this.cb_9=create cb_9
this.dw_upd_mps_qtyassigned=create dw_upd_mps_qtyassigned
this.sle_1=create sle_1
this.dw_woseq=create dw_woseq
this.cb_8=create cb_8
this.sle_scrapped_um=create sle_scrapped_um
this.sle_total_um=create sle_total_um
this.sle_pack_um=create sle_pack_um
this.p_1=create p_1
this.cb_6=create cb_6
this.st_8=create st_8
this.em_total_scrapped=create em_total_scrapped
this.dw_6=create dw_6
this.dw_5=create dw_5
this.st_3=create st_3
this.dw_4=create dw_4
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.em_total_parts=create em_total_parts
this.em_boxes_completed=create em_boxes_completed
this.em_std_box_qty=create em_std_box_qty
this.dw_3=create dw_3
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.st_4=create st_4
this.st_2=create st_2
this.dw_2=create dw_2
this.Control[]={this.em_noofobjs,&
this.st_objs,&
this.cb_pallet_label,&
this.sle_pallet,&
this.cb_pallet,&
this.sle_lotnumber,&
this.cb_9,&
this.dw_upd_mps_qtyassigned,&
this.sle_1,&
this.dw_woseq,&
this.cb_8,&
this.sle_scrapped_um,&
this.sle_total_um,&
this.sle_pack_um,&
this.p_1,&
this.cb_6,&
this.st_8,&
this.em_total_scrapped,&
this.dw_6,&
this.dw_5,&
this.st_3,&
this.dw_4,&
this.cb_7,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.em_total_parts,&
this.em_boxes_completed,&
this.em_std_box_qty,&
this.dw_3,&
this.st_7,&
this.st_6,&
this.st_5,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.st_1,&
this.st_4,&
this.st_2,&
this.dw_2}
end on

on w_part_production.destroy
destroy(this.em_noofobjs)
destroy(this.st_objs)
destroy(this.cb_pallet_label)
destroy(this.sle_pallet)
destroy(this.cb_pallet)
destroy(this.sle_lotnumber)
destroy(this.cb_9)
destroy(this.dw_upd_mps_qtyassigned)
destroy(this.sle_1)
destroy(this.dw_woseq)
destroy(this.cb_8)
destroy(this.sle_scrapped_um)
destroy(this.sle_total_um)
destroy(this.sle_pack_um)
destroy(this.p_1)
destroy(this.cb_6)
destroy(this.st_8)
destroy(this.em_total_scrapped)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.em_total_parts)
destroy(this.em_boxes_completed)
destroy(this.em_std_box_qty)
destroy(this.dw_3)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.dw_2)
end on

type em_noofobjs from editmask within w_part_production
int X=512
int Y=864
int Width=489
int Height=96
int TabOrder=30
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="000"
string Text="1"
string Pointer="Arrow!"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_objs from statictext within w_part_production
int X=32
int Y=864
int Width=453
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="No. of Objs."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_pallet_label from commandbutton within w_part_production
int X=1691
int Y=1940
int Width=375
int Height=92
int TabOrder=80
boolean Visible=false
string Text="Print Pallet"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long		ll_pos
String	szPalletLabel
st_generic_structure 	stParm

SELECT report_library.object_name  
  INTO :szPalletLabel  
  FROM report_library  
 WHERE report_library.name = 'PALLET' ;

ll_pos = PosA ( sle_pallet.Text, "/" )

if ll_pos > 0 then
	OpenWithParm ( w_print_pallet_choice, sle_pallet.Text )
	stParm.Value1 = Message.StringParm
	if stParm.Value1 = "0" then return
else
	stParm.Value1 = sle_pallet.Text
end if

If IsNull(szPalletLabel) then
	stparm.value12 = 'NOLABEL'
Else
	stparm.value12 = 'PALLET'
End If

f_print_label ( stparm )

end event

type sle_pallet from singlelineedit within w_part_production
int X=1239
int Y=1940
int Width=375
int Height=92
int TabOrder=70
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_pallet from commandbutton within w_part_production
int X=1975
int Y=1248
int Width=416
int Height=224
int TabOrder=100
string Text="Pallet"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	li_error
long	ll_new_row,&
	ll_palletserial,&
	li_count
string	ls_alt_part
st_generic_structure	lstr_parm

if text = 'Pallet' then
	text = 'Clear Plt'
	// included the parameters, changed from just operator to operator & location code
	lstr_parm.value1 = ls_operator
	lstr_parm.value2 = is_part
	lstr_parm.value3 = is_machine
	// changed the parameter
	OpenWithParm ( w_pallet, lstr_parm )
	
	il_PalletSerial = Message.DoubleParm
	if il_PalletSerial <= 0 then
		li_error = -1
		text = 'Pallet'
		sle_pallet.text = ''
		sle_pallet.hide()
		cb_pallet_label.hide()
	else
		li_error = il_PalletSerial
		sle_pallet.text = string(il_PalletSerial) 
		sle_pallet.show()
		cb_pallet_label.show()
	end if
else
	text = 'Pallet'
	il_PalletSerial = 0
	sle_pallet.text = ''
	sle_pallet.hide()
	cb_pallet_label.hide()
end if 

end event

type sle_lotnumber from singlelineedit within w_part_production
int X=690
int Y=1940
int Width=471
int Height=96
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_9 from commandbutton within w_part_production
int X=32
int Y=1940
int Width=617
int Height=96
string Text="Lot Number"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_upd_mps_qtyassigned from datawindow within w_part_production
int X=1650
int Y=2040
int Width=261
int Height=188
int TabOrder=190
boolean Visible=false
string DataObject="d_qty_assigned"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

type sle_1 from singlelineedit within w_part_production
int X=37
int Y=1904
int Width=2816
int Height=80
int TabOrder=140
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_woseq from datawindow within w_part_production
int X=1865
int Y=1968
int Width=494
int Height=364
int TabOrder=200
boolean Visible=false
string DataObject="d_workorder_header_resequence"
boolean LiveScroll=true
end type

type cb_8 from commandbutton within w_part_production
int X=1239
int Y=32
int Width=617
int Height=128
int TabOrder=10
string Text="Audit Trail"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If Text = "Objects" Then
	Text = "Audit Trail"
	dw_2.DataObject = "d_jc_audit_trail"
	dw_2.SetTransObject ( sqlca )
	dw_2.Retrieve ( is_workorder )
Else
	Text = "Objects"
	dw_2.DataObject = "dw_list_of_objects_sf"
	dw_2.SetTransObject ( sqlca )
	dw_2.Retrieve ( is_workorder, is_machine )
End if


end on

type sle_scrapped_um from editmask within w_part_production
int X=1024
int Y=1152
int Width=142
int Height=96
int TabOrder=50
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="XX"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_total_um from editmask within w_part_production
int X=1024
int Y=1056
int Width=142
int Height=96
int TabOrder=40
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="XX"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pack_um from editmask within w_part_production
int X=1024
int Y=960
int Width=142
int Height=96
int TabOrder=30
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="XX"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_part_production
int X=1239
int Y=1248
int Width=270
int Height=224
string PictureName="trash.bmp"
boolean FocusRectangle=false
end type

event dragdrop;If bUndoJC Then
	wf_undo_completion ( )	
Elseif bUndoDefects Then
	wf_undo_defects ( )
End if

end event

type cb_6 from commandbutton within w_part_production
int X=1257
int Y=2064
int Width=270
int Height=224
int TabOrder=180
boolean Enabled=false
string Text="Undo"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on dragdrop;If bUndoJC Then

Elseif bUndoDefects Then

End if
end on

type st_8 from statictext within w_part_production
int X=32
int Y=1152
int Width=453
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Total Scrapped "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_total_scrapped from editmask within w_part_production
int X=512
int Y=1152
int Width=489
int Height=96
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="########0.00####"
string Pointer="Arrow!"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_6 from datawindow within w_part_production
int X=1239
int Y=768
int Width=1605
int Height=464
int TabOrder=20
string DataObject="d_package_type_sf"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event clicked;//  This event is being triggered by retrieveend event so it is possible
//	that the values of xpos, ypos, and dwobject may be invalid.

DECIMAL { 6 }	dec_6_quantity

IF row < 1 THEN Return

SelectRow ( 0, FALSE )
SelectRow ( row, TRUE )

szPackageType = object.package_materials_code [ row ]
dec_6_quantity = object.part_packaging_quantity [ row ]

em_std_box_qty.Text = String ( dec_6_quantity )
sle_pack_um.Text = object.part_packaging_unit [ row ]

// check to see if part / package type includes a scale
if ib_scale then
	if IsNull ( object.serial_type[row], '(None)') <> '(None)' THEN
		ib_scale = TRUE
	else
		ib_scale = FALSE
	end if
end if
end event

event retrieveend;dwobject dummy

IF rowcount > 0 THEN
	TRIGGER EVENT clicked ( 0, 0, 1, dummy )
END IF
end event

type dw_5 from datawindow within w_part_production
int X=69
int Y=1920
int Width=489
int Height=356
int TabOrder=150
boolean Visible=false
string DataObject="d_insert_object_manually"
boolean LiveScroll=true
end type

type st_3 from statictext within w_part_production
int X=37
int Y=1268
int Width=1129
int Height=64
boolean Enabled=false
string Text="Defects Audit Trail"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_4 from datawindow within w_part_production
int X=32
int Y=1344
int Width=1129
int Height=544
string DragIcon="MONITOR.ICO"
string DataObject="d_defects"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;iDefectsRow = dw_4.GetClickedRow ( )

SelectRow ( dw_4, 0, False )

If iDefectsRow > 0 Then

	SelectRow ( dw_4, iDefectsRow, True )

	If cUndoDefects = 'Y' Then
		bUndoDefects = True
		bUndoDownTime = False
		bUndoJC = False
		Drag ( Begin! )
	End if

End if


end on

type cb_7 from commandbutton within w_part_production
int X=2080
int Y=1488
int Width=768
int Height=192
int TabOrder=120
string Text="Defects Auto"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array	lncst_aa
lncst_aa.of_setitem("machine",is_machine)
lncst_aa.of_setitem("workorder",is_workorder)
lncst_aa.of_setitem("part",is_part)
openwithparm (w_sf_big_defect_select, lncst_aa)
end event

type cb_5 from commandbutton within w_part_production
int X=1239
int Y=1488
int Width=768
int Height=192
int TabOrder=110
string Text="Display Defects"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array	lncst_aa
lncst_aa.of_setitem("machine",is_machine)
lncst_aa.of_setitem("workorder",is_workorder)
lncst_aa.of_setitem("part",is_part)

openwithparm ( w_shop_defects_gr, lncst_aa )

end event

type cb_4 from commandbutton within w_part_production
int X=1239
int Y=1696
int Width=768
int Height=192
int TabOrder=130
string Text="Enter Defects"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array	lncst_aa
lncst_aa.of_setitem("machine",is_machine)
lncst_aa.of_setitem("workorder",is_workorder)
lncst_aa.of_setitem("part",is_part)
lncst_aa.of_setitem("operator",ls_operator)
openwithparm (w_number_enter, lncst_aa)
end event

type cb_3 from commandbutton within w_part_production
int X=1536
int Y=1248
int Width=416
int Height=224
int TabOrder=170
boolean Enabled=false
string Text="Options"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;OpenWithParm ( w_options, is_machine )

Choose Case Message.DoubleParm


	Case 1  // Change std pack qty
		wf_change_std_pack ( )

	Case 2  // Reset std pack
		wf_reset_std_pack ( )

End Choose


end event

type em_total_parts from editmask within w_part_production
int X=512
int Y=1056
int Width=489
int Height=96
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="########0.00####"
string Pointer="Arrow!"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_boxes_completed from editmask within w_part_production
int X=690
int Y=2080
int Width=471
int Height=96
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,###"
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_std_box_qty from editmask within w_part_production
int X=512
int Y=960
int Width=489
int Height=96
boolean Enabled=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="########0.00####"
string Pointer="Arrow!"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_3 from datawindow within w_part_production
int X=1879
int Y=32
int Width=965
int Height=128
string DataObject="d_clock"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

type st_7 from statictext within w_part_production
int X=32
int Y=960
int Width=453
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Pack Qty"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_part_production
int X=32
int Y=1056
int Width=453
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Total Qty "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_part_production
int X=32
int Y=2080
int Width=617
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Objects Packed"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_part_production
int X=2414
int Y=1248
int Width=416
int Height=224
int TabOrder=90
string Text="Complete"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
Long	nboxes
Long	nRowNum
int	l_i_rtn_code
Dec	nTotal
Dec	nStd
Dec	nPack
Dec	dQtyRequired
Dec	dBalance
Dec	dQtyCompleted
Dec	dNewRunTime
string	ls_lotnumber, ls_lotcheck, ls_prevlotnumber
int	li_level
setnull(ls_lotnumber)

//	verify whether lot check is enabled or not
select	shop_floor_check_lot
into	:ls_lotcheck
from	parameters;

if isnull(ls_lotcheck,'N') = 'Y' then
	select	lot 
	into	:ls_prevlotnumber
	from	audit_trail  
	where	serial = (select max(serial) from audit_trail where part = :is_part and type = 'J');	
	//	check if value is populated in sle_lotnumber 
	if isnull(sle_lotnumber.text) or LenA(trim(sle_lotnumber.text)) <= 0 then
		if isnull(ls_prevlotnumber) or LenA(trim(ls_prevlotnumber)) <= 0 then
			Messagebox (monsys.msg_title,'Lot Control is enabled, make sure data is entered in lot number column')
			return
		else	
			if Messagebox (monsys.msg_title,'Lot Control is enabled. Do you want the system to get a previously assigned lot number',Question!,YesNo!,2) = 1 then
				sle_lotnumber.text = ls_prevlotnumber
				ls_lotnumber = sle_lotnumber.text				
			else
				return
			end if
		end if	
	else
		ls_lotnumber = sle_lotnumber.text
	end if 
end if 	

if ib_scale then
	if szpackagetype > '' then
		if Parent.Trigger Event ue_popup_scale ( ) <> 1 then return
	end if
end if

nBoxes = f_get_value ( Long(em_boxes_completed.text) )
nPack  = f_get_value ( Dec(em_std_box_qty.Text) )
if sle_pack_um.Text <> sle_total_um.Text then
	nStd   = f_convert_units ( sle_pack_um.Text,sle_total_um.Text,is_part,nPack )
else
	nStd   = nPack
end if
nTotal = f_get_value ( Dec(em_total_parts.text) )
 
If nStd <= 0 Then
	MessageBox ( "Error", "Standard pack quantity must be greater than 0!", StopSign! )
	Return
End if

em_boxes_completed.text = String(f_get_value (nboxes) + 1)
em_total_parts.text = String(f_get_value (nTotal) + nStd)

//  Update the datawindow
If dw_1.RowCount ( ) < 1 Then Return

ndwtotalparts = Dec(em_total_parts.text)
dw_1.SetItem( 1, "workorder_detail_qty_completed", ndwtotalparts )
dQtyRequired = f_get_value ( dw_1.GetItemNumber ( 1, "workorder_detail_qty_required" ) )
dBalance = dQtyRequired - ndwtotalparts
dw_1.SetItem ( 1, "balance", dBalance )

If dw_1.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
End if

dw_1.Reset ( )
dw_1.Retrieve ( is_part, is_workorder )

// Add Object and generate audit trail
perform_completion ( )

dNewRunTime = f_job_runtime ( is_workorder, 1 )

UPDATE work_order  
   SET runtime = :dNewRunTime  
 WHERE work_order = :is_workorder   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit ;
End if

OpenWithParm ( w_calculate_job_time, is_machine )

dw_1.Retrieve ( is_part, is_workorder )

if dw_1.GetItemNumber ( 1, "balqty" ) <= 0 then

	if isnull(is_supervisorclose,'N')='Y' then 
		
		select	isnull(operatorlevel,-1)
		into	:li_level
		from	employee
		where	operator_code = :ls_operator;
		
		if (isnull(li_level,-1)<>0) then
			messagebox( monsys.msg_title,"Sorry, user doesn't have permission to close the workorder")
			Return
		end if 	
	end if 	

	if i_s_job_change = "N" then
		MessageBox ( "Job Completed", "This job has been completed!  The next job in the queue will be started.", Information! )
		if wf_close_job ( is_workorder, is_part, is_machine ) then
			w_machine.wf_retrieve_workorder_dw ( )
			Close ( Parent )
		end if
	else
		l_i_rtn_code = MessageBox ( "Job Completed", "This job has been completed!  Do you want to close it?", Question!, YesNo!, 1 )
		if l_i_rtn_code = 1 then
			if wf_close_job ( is_workorder, is_part, is_machine ) then
				w_machine.wf_retrieve_workorder_dw ( )
				Close ( Parent )
			end if
		end if
	end if
end if
end event

type cb_1 from commandbutton within w_part_production
int X=2080
int Y=1696
int Width=768
int Height=192
int TabOrder=160
string Text="Exit"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_1.update ( ) = 1 then
	Commit;
Else
	Rollback;
End if



close (parent)
end on

type dw_1 from datawindow within w_part_production
int X=32
int Y=160
int Width=1129
int Height=696
boolean Enabled=false
string DataObject="dw_workorder_detail_status"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type st_1 from statictext within w_part_production
int X=32
int Y=32
int Width=1129
int Height=128
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Production"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_part_production
int X=1239
int Y=688
int Width=1605
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Packaging Types"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_part_production
int X=517
int Y=368
int Width=1605
int Height=80
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Job Completion Audit Trail"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_part_production
int X=1239
int Y=160
int Width=1605
int Height=512
string DragIcon="MONITOR.ICO"
string DataObject="d_jc_audit_trail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

on clicked;iJCAuditRow = dw_2.GetClickedRow ( )

SelectRow ( dw_2, 0, False )

If iJCAuditRow > 0 Then

	SelectRow ( dw_2, iJCAuditRow, True )

	If cUndoJC = 'Y' Then
		bUndoDefects = False
		bUndoDownTime = False
		bUndoJC = True
		Drag ( Begin! )
	End if

End if
end on

