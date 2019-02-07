$PBExportHeader$w_create_jobs_from_soft_queue.srw
$PBExportComments$(mps1)
forward
global type w_create_jobs_from_soft_queue from Window
end type
type dw_msp_getnotes from datawindow within w_create_jobs_from_soft_queue
end type
type dw_part_list from datawindow within w_create_jobs_from_soft_queue
end type
type dw_work_order_detail from datawindow within w_create_jobs_from_soft_queue
end type
type st_1 from statictext within w_create_jobs_from_soft_queue
end type
type sle_select_date from singlelineedit within w_create_jobs_from_soft_queue
end type
type st_percentage from statictext within w_create_jobs_from_soft_queue
end type
type st_message from statictext within w_create_jobs_from_soft_queue
end type
type sle_percentage from singlelineedit within w_create_jobs_from_soft_queue
end type
type sle_base from singlelineedit within w_create_jobs_from_soft_queue
end type
type dw_template from datawindow within w_create_jobs_from_soft_queue
end type
type lb_jobs from listbox within w_create_jobs_from_soft_queue
end type
type dw_job_detail from datawindow within w_create_jobs_from_soft_queue
end type
type ddlb_type from dropdownlistbox within w_create_jobs_from_soft_queue
end type
type dw_soft_queue from datawindow within w_create_jobs_from_soft_queue
end type
type gb_2 from groupbox within w_create_jobs_from_soft_queue
end type
type gb_1 from groupbox within w_create_jobs_from_soft_queue
end type
type gb_3 from groupbox within w_create_jobs_from_soft_queue
end type
type ddlb_value from dropdownlistbox within w_create_jobs_from_soft_queue
end type
end forward

global type w_create_jobs_from_soft_queue from Window
int X=5
int Y=4
int Width=3337
int Height=2612
boolean TitleBar=true
string Title="Soft Queue Job Creator"
long BackColor=78748035
boolean ControlMenu=true
WindowType WindowType=response!
event we_nchitest pbm_nchittest
event ue_reset pbm_custom01
event ue_create pbm_custom02
dw_msp_getnotes dw_msp_getnotes
dw_part_list dw_part_list
dw_work_order_detail dw_work_order_detail
st_1 st_1
sle_select_date sle_select_date
st_percentage st_percentage
st_message st_message
sle_percentage sle_percentage
sle_base sle_base
dw_template dw_template
lb_jobs lb_jobs
dw_job_detail dw_job_detail
ddlb_type ddlb_type
dw_soft_queue dw_soft_queue
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
ddlb_value ddlb_value
end type
global w_create_jobs_from_soft_queue w_create_jobs_from_soft_queue

type variables
String szMachine		//Machine number
String szJob		//Job number
String szSelectDate	//String formate for date
String szJobList[]		//List of jobs

STRING	i_s_filter_suffix
CONSTANT STRING	suffix_root = "qnty > 0 AND due <= "

Date dDate		//Due date

Decimal nRuntime		//Runtime
Decimal id_setuptime              //setup time

Long iWorkOrder
Long iJobCount		//Job count

st_generic_structure stParm	//Generic parm structure

Boolean bAll, bDate, ib_SelectOrder
end variables

forward prototypes
public subroutine wf_select_all (boolean bselect)
public subroutine wf_select_before_date (date ddate)
public function date wf_get_due_date ()
public subroutine wf_create_job_detail ()
public function decimal wf_parts_per_hour (string szpart)
public subroutine wf_select_mps_for_order (string szOrigin)
public subroutine wf_create_part_dropdown ()
public subroutine wf_create_group_tech_dropdown ()
public subroutine wf_create_machine_dropdown ()
public subroutine wf_create_order_dropdown ()
public subroutine wf_create_process_dropdown ()
public function decimal wf_parts_per_cycle (string szpart)
public subroutine wf_add_to_recalc_list (string szjob)
public subroutine wf_recalc_mps ()
public function integer wf_get_cycle_time (string szPart)
public function string wf_get_cycle_unit (string szPart)
public function integer wf_filter ()
public function integer wf_create_job_header (date a_d_due, decimal a_n_runtime)
end prototypes

on we_nchitest;gnv_App.of_GetFrame().SetMicroHelp( 'Ready' )
end on

event ue_reset;String 	l_s_Job

Decimal	nTotalQty

Long		iCount


If MessageBox(monsys.msg_title, "This operation will erase all untouched work orders, continue to proceed?", StopSign!, YesNo!)  = 2 then
	Return
End If

dw_part_list.Reset()				//Reset the list of processed parts

Declare CurJob Cursor For  
 Select work_order.work_order  
   From work_order  ;

Open curJob;
iJobCount	= 0

Fetch CurJob into : l_s_Job;

Do while SQLCA.SQLCode = 0 
	iJobCount ++
	szJobList[iJobCount]	= l_s_Job
	Fetch CurJob Into :l_s_Job;
Loop

For iCount = 1 to iJobCount

	l_s_Job	= szJobList[iCount]

	Select sum(workorder_detail.qty_completed )  
   Into :nTotalQty  
   From workorder_detail  
   Where workorder_detail.workorder = :l_s_Job   ;

	nTotalQty	 = f_get_value(nTotalQty)
	If nTotalQty = 0 then	

		wf_add_to_recalc_list(l_s_Job)

		Delete From workorder_detail  
   	Where workorder = :l_s_Job   ;

		Delete From work_order  
		Where work_order = :l_s_Job   ;
	
		If SQLCA.SQLCode = 0 then
			Commit;
		Else
			Rollback;
		End If

	End If

Next

Close CurJob;

wf_recalc_mps()
dw_soft_queue.Retrieve ( )
wf_filter ( )
// w_plant_monitor.ReDraw()
end event

event ue_create;DECIMAL	l_dec_origin [ ], &
			l_dec_id [ ], &
			l_n_order_no

DATETIME	l_dt_due [ ]

DATE	l_d_due [ ]

INTEGER	l_i_year, &
				l_i_month, &
				l_i_day

LONG	l_l_row, &
			l_l_selected_row, &
			l_l_total_rows, &
			l_l_source [ ]

STRING	l_s_machine, &
			l_s_part, &
			l_s_qty, &
			l_s_date, &
			l_s_process, &
			l_s_parts [ ], &
			l_s_customer, &
			l_s_destination

TIME	l_t_due [ ]

l_l_total_rows = dw_soft_queue.RowCount()
l_l_row = 1

DO WHILE ( l_l_row <= l_l_total_rows )
	IF dw_soft_queue.IsSelected ( l_l_row ) THEN
		l_s_parts [ Upperbound ( l_s_parts ) + 1 ] = dw_soft_queue.object.part [ l_l_row ]
		l_dt_due [ UpperBound ( l_dt_due ) + 1 ] = dw_soft_queue.object.due [ l_l_row ]
		l_d_due [ UpperBound ( l_d_due ) + 1 ] = Date ( l_dt_due [ UpperBound ( l_dt_due ) ] )
		l_t_due [ UpperBound ( l_t_due ) + 1 ] = Time ( l_dt_due [ UpperBound ( l_dt_due ) ] )
		l_l_source [ UpperBound ( l_l_source ) + 1 ] = dw_soft_queue.object.source [ l_l_row ]
		l_dec_origin [ UpperBound ( l_dec_origin ) + 1 ] = dw_soft_queue.object.origin [ l_l_row ]
		l_dec_id [ UpperBound ( l_dec_id ) + 1 ] = dw_soft_queue.object.id [ l_l_row ]
	END IF
	l_l_row ++
LOOP

dw_soft_queue.SetSort ("machine a, process a, part a" )
dw_soft_queue.Sort ( )

dw_soft_queue.SelectRow ( l_l_row, FALSE )
l_l_selected_row = 1
DO WHILE ( l_l_selected_row <= Upperbound ( l_s_parts ) )
	l_l_row = dw_soft_queue.Find ( "part = '" + l_s_parts [ l_l_selected_row ] + "' AND due = DateTime ( Date ( '" + String ( l_d_due [ l_l_selected_row ] ) + "' ), Time ( '" + String ( l_t_due [ l_l_selected_row ] ) + "' ) ) AND source = " + String ( l_l_source [ l_l_selected_row ] ) + " AND origin = " + String ( l_dec_origin [ l_l_selected_row ] ) + " AND id = " + String ( l_dec_id [ l_l_selected_row ] ), 1, dw_soft_queue.RowCount ( ) )
	IF l_l_row > 0 THEN
		dw_soft_queue.SelectRow ( l_l_row, TRUE )
	END IF
	l_l_selected_row ++
LOOP

IF Upperbound ( l_s_parts ) > 0 THEN

	dw_template.Reset ( )

	st_message.text = ""
	st_percentage.text = "0%"
	sle_percentage.visible = FALSE
	sle_percentage.width = 0
	sle_percentage.visible = TRUE

	For l_l_row = 1 to l_l_total_rows 

		sle_percentage.width	= sle_base.width * l_l_row / l_l_total_rows
		st_percentage.text	= String ( Truncate ( 100 * l_l_row / l_l_total_rows, 0 ) ) + "%"

		If dw_soft_queue.IsSelected(l_l_row) then

			l_s_machine	= dw_soft_queue.GetItemString(l_l_row, "machine")
			l_s_process	= dw_soft_queue.GetItemString(l_l_row, "process")
			l_s_part		= dw_soft_queue.GetItemString(l_l_row, "part")
			l_s_qty		= String(dw_soft_queue.GetItemNumber(l_l_row, "qnty") - &
										dw_soft_queue.GetItemNumber(l_l_row, "qty_assigned"))

         dDate       = Date ( dw_soft_queue.GetItemDateTime (l_l_row, "due") )

			l_i_year		= Year(ddate)
			l_i_month	= Month(ddate)
			l_i_day		= Day(ddate)

			nRuntime    = dw_soft_queue.GetItemDecimal(l_l_row, "run_time")
			id_setuptime= dw_soft_queue.GetItemDecimal(l_l_row, "setup")	
			l_n_order_no 	= dw_soft_queue.GetItemDecimal(l_l_row, "origin")

			If l_n_order_no > 0 then

				SELECT customer, destination
				  INTO :l_s_customer, :l_s_destination
				  FROM order_header
				 WHERE order_no = :l_n_order_no ;

				If SQLCA.SQLCODE = -1 Then
					MessageBox( monsys.msg_title, Sqlca.sqlerrtext )
				End If

			End If		

			l_s_date		= String(l_i_month) + "/" + String(l_i_day) + "/" + String(l_i_year)

			st_message.text	= "Machine:" + l_s_machine + " Process:" + l_s_process + " Part:" + l_s_part + " Qty:" + l_s_qty + " Date:" + l_s_date

			If dw_template.RowCount() = 0 then
				dw_template.InsertRow ( 1 )
				dw_template.object.value1 [ 1 ] = l_s_machine
				dw_template.object.value2 [ 1 ] = l_s_process
				dw_template.object.value3 [ 1 ] = l_s_part
				dw_template.object.value4 [ 1 ] = l_s_qty
				dw_template.object.value5 [ 1 ] = l_s_date
				dw_template.object.value6 [ 1 ] = String ( l_n_order_no )
				dw_template.object.value7 [ 1 ] = l_s_customer
				dw_template.object.value8 [ 1 ] = l_s_destination
			Else 
				If (dw_template.GetItemString(1, "value1") = l_s_machine) AND &
					(dw_template.GetItemString(1, "value2") = l_s_process) AND &
               (Upper( dw_template.GetItemString(1, 'value2')) <> 'NONE') then
					
					dw_template.InsertRow ( 1 )
					dw_template.object.value1 [ 1 ] = l_s_machine
					dw_template.object.value2 [ 1 ] = l_s_process
					dw_template.object.value3 [ 1 ] = l_s_part
					dw_template.object.value4 [ 1 ] = l_s_qty
					dw_template.object.value5 [ 1 ] = l_s_date
					dw_template.object.value6 [ 1 ] = string ( l_n_order_no )
					dw_template.object.value7 [ 1 ] = l_s_customer
					dw_template.object.value8 [ 1 ] = l_s_destination

				Else
					st_message.text	= "Creating work order header..."
					If wf_create_job_header(dDate, nRunTime) = 0 then
						st_message.text	= "Creating detail for work order " + String(iWorkOrder)

						wf_create_job_detail()
						st_message.text	= "Recalc job data/time for machine " + l_s_machine
						lb_jobs.AddItem(dw_template.GetItemString(1, "value1") + " # " + String(iWorkOrder))
			
					ELSE
						MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
					End If

					dw_template.Reset ( )
					dw_template.InsertRow ( 1 )
					dw_template.object.value1 [ 1 ] = l_s_machine
					dw_template.object.value2 [ 1 ] = l_s_process
					dw_template.object.value3 [ 1 ] = l_s_part
					dw_template.object.value4 [ 1 ] = l_s_qty
					dw_template.object.value5 [ 1 ] = l_s_date
					dw_template.object.value6 [ 1 ] = string ( l_n_order_no )
					dw_template.object.value7 [ 1 ] = l_s_customer
					dw_template.object.value8 [ 1 ] = l_s_destination
					
				End If
			End If			
		End If

	Next

	If dw_template.RowCount() > 0 then

		st_message.text	= "Creating work order header..."

		If wf_create_job_header(dDate, nRunTime) = 0 then
			st_message.text	= "Creating detail for work order " + String(iWorkOrder)
			wf_create_job_detail()
			st_message.text	= "Recalc job data/time for machine " + l_s_machine
			lb_jobs.AddItem(dw_template.GetItemString(1, "value1") + " # " + String(iWorkOrder))
		ELSE
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
		End If

		dw_template.Reset()
	End If

	dw_soft_queue.Retrieve ( )
	wf_filter ( )

Else
	Messagebox(monsys.msg_title, "No soft queue item is selected.", StopSign!) 
End If

st_message.text	= "" 
end event

public subroutine wf_select_all (boolean bselect);Long iRow
Long iTotalRows

iTotalRows	= dw_soft_queue.RowCount()
For iRow = 1 to iTotalRows
	dw_soft_queue.SelectRow(iRow, bSelect)
Next

end subroutine

public subroutine wf_select_before_date (date ddate);Long iRow
Long iTotalRows

iTotalRows	= dw_soft_queue.RowCount()

For iRow = 1 to iTotalRows
	If dw_soft_queue.GetItemDate(iRow, "due") <= dDate then
		dw_soft_queue.SelectRow(iRow, TRUE)
	Else
		dw_soft_queue.SelectRow(iRow, FALSE)
	End If
Next
end subroutine

public function date wf_get_due_date ();Long iRow
Long iTotalRows

iTotalRows	= dw_template.RowCount() 

SetNull(dDate)
nRunTime	= 0

st_message.text	= "Calculating the due date for work order " + String(iWorkOrder)

For iRow = 1 to iTotalRows

	If IsNull(dDate) then
		dDate	= Date(dw_template.GetItemString(iRow, "value5"))
	Else
		If Date(dw_template.GetItemString(iRow, "value5")) < dDate then
			dDate	= Date(dw_template.GetItemString(iRow, "value5"))
		End If
	End If
Next

Return dDate
end function

public subroutine wf_create_job_detail ();Long iRow
Long iTotalRows
Long iDetailRow

String szPart
String l_s_WorkOrder	

Decimal nQty
Decimal nDetailQty
Decimal nPartsPerHour 
Decimal nJobRunTime
Decimal nPartsPerCycle

iTotalRows	= dw_template.RowCount()
dw_job_detail.Reset()

For iRow = 1 to iTotalRows
	
	szPart	= dw_template.GetItemString(iRow, "value3")
	nQty		= Dec(dw_template.GetItemString(iRow, "value4"))
	iDetailRow	= dw_job_detail.Find("value1 = '" + szPart + "'", 1, 999999)

	If iDetailRow > 0 then
		nDetailQty	= Dec(dw_job_detail.GetItemString(iDetailRow, "value2"))
	Else
		nDetailQty	= 0
		dw_job_detail.InsertRow(1)
		dw_job_detail.SetItem(1, "value1", szPart)
		iDetailRow	= 1
	End If				

	nDetailQty		= nDetailQty + nQty
	dw_job_detail.SetItem(1, "value2", String(nDetailQty))

Next

iTotalRows	= dw_job_detail.RowCount()

nJobRunTime	= 0

l_s_WorkOrder	= String(iWorkOrder)

For iRow = 1 to iTotalRows

	szPart			= dw_job_detail.GetItemString(iRow, "value1")
	nQty				= Dec(dw_job_detail.GetItemString(iRow, "value2"))

	st_message.text= "Processing part " + szPart + " in work order " + String(iWorkOrder)

	nPartsPerHour	= wf_parts_per_hour(szPart)
	If nPartsPerHour > 0 then
		nRunTime		= nQty / nPartsPerHour
	Else
		nRunTime		= 0		
	End If	

	nPartsPerCycle	= wf_parts_per_cycle(szPart)
	If nRunTime > nJobRunTime then
		nJobRunTime	= nRunTime
	End If

  	INSERT INTO workorder_detail  
         ( workorder,   
           part,   
           qty_required,   
           qty_completed,   
           parts_per_cycle,   
			  parts_per_hour,
           run_time,   
           scrapped,   
           balance )  
  	VALUES (:l_s_WorkOrder,   
           :szPart,   
           :nQty,
           0,   
           :nPartsPerCycle,   
			  :nPartsPerHour,
           :nRunTime,   
           null,   
           :nQty)  ;

	If SQLCA.SQLCode = 0 then
		Commit;
		stParm.value1	= szPart
		stParm.value3	= "M"

		if ib_SelectOrder then
			stParm.value5	= string( iWorkOrder )			
		end if
	
//		OpenWithParm(w_calculate_assigned_qty_in_mps, stParm) 
      f_update_qty_asgnd_part ( szPart ) // new function added by mams a sp based activity

	Else
		Rollback;
	End If

Next

UPDATE work_order  
   SET runtime = :nJobRunTime  
 WHERE work_order = :l_s_WorkOrder   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

end subroutine

public function decimal wf_parts_per_hour (string szpart);Decimal nPartsPerHour

SELECT part_mfg.parts_per_hour  
  INTO :nPartsPerHour  
  FROM part_mfg  
 WHERE part_mfg.part = :szPart   ;

Return nPartsPerHour
end function

public subroutine wf_select_mps_for_order (string szOrigin);Long iRow
Long iTotalRows

iTotalRows	= dw_soft_queue.RowCount()

For iRow = 1 to iTotalRows
	If dw_soft_queue.GetItemString(iRow, "origin") = szOrigin then
		dw_soft_queue.SelectRow(iRow, TRUE)
	Else
		dw_soft_queue.SelectRow(iRow, FALSE)
	End If
Next
end subroutine

public subroutine wf_create_part_dropdown ();String szCurrentPart

ddlb_value.Reset()

Declare PartCur Cursor for Select Part From Part where class = 'M' Using sqlca;

Open PartCur;

Fetch PartCur into :szCurrentPart;

Do while sqlca.sqlcode = 0
	ddlb_value.AddItem(szCurrentPart)
	Fetch PartCur into :szCurrentPart;
Loop

Close PartCur;

end subroutine

public subroutine wf_create_group_tech_dropdown ();String szCurrentGroupTech

ddlb_value.Reset()

Declare GroupTechCur Cursor for Select id From Group_technology Using sqlca;

Open GroupTechCur;

Fetch GroupTechCur into :szCurrentGroupTech;

Do while sqlca.sqlcode = 0
	ddlb_value.AddItem(szCurrentGroupTech)
	Fetch GroupTechCur into :szCurrentGroupTech;
Loop

Close GroupTechCur;

end subroutine

public subroutine wf_create_machine_dropdown ();String szCurrentMachine

ddlb_value.Reset()

Declare MachineCur Cursor for Select Machine_no From Machine Using sqlca;

Open MachineCur;

Fetch MachineCur into :szCurrentMachine;

Do while sqlca.sqlcode = 0
	ddlb_value.AddItem(szCurrentMachine)
	Fetch MachineCur into :szCurrentMachine;
Loop

Close MachineCur;

end subroutine

public subroutine wf_create_order_dropdown ();String   szCurrentOrder, &
         l_s_dest, &
			l_s_customer, &
			l_s_fullstr
			
Datetime l_d_orderdt


Declare OrderCur Cursor for Select Order_no,order_date,destination,customer From Order_header Using sqlca;

Open OrderCur;

Fetch OrderCur into :szCurrentOrder, :l_d_orderdt, :l_s_dest, :l_s_customer;

Do while sqlca.sqlcode = 0
	l_s_fullstr=trim(szcurrentorder)+'  , '+string(l_d_orderdt,'mm/dd/yy')+',  '+trim(l_s_dest)+',  '+trim(l_s_customer)
//	ddlb_value.AddItem(szCurrentOrder)
	ddlb_value.AddItem(l_s_fullstr)
//	Fetch OrderCur into :szCurrentOrder;
   Fetch OrderCur into :szCurrentOrder, :l_d_orderdt, :l_s_dest, :l_s_customer;	
Loop

Close OrderCur;

end subroutine

public subroutine wf_create_process_dropdown ();String szCurrentProcess

ddlb_value.Reset()

Declare ProcessCur Cursor for Select id From Process Using sqlca;

Open ProcessCur;

Fetch ProcessCur into :szCurrentProcess;

Do while sqlca.sqlcode = 0
	ddlb_value.AddItem(szCurrentProcess)
	Fetch ProcessCur into :szCurrentProcess;
Loop

Close ProcessCur;

end subroutine

public function decimal wf_parts_per_cycle (string szpart);Decimal nPartsPerCycle

SELECT part_mfg.parts_per_cycle  
  INTO :nPartsPerCycle  
  FROM part_mfg  
 WHERE part_mfg.part = :szPart   ;

nPartsPerCycle	= f_get_value(nPartsPerCycle)

If nPartsPerCycle	= 0 then
	Return 1
Else
	Return nPartsPerCycle
End If
end function

public subroutine wf_add_to_recalc_list (string szjob);Long 	iRow
Long 	iTotalRows

String szPart

dw_work_order_detail.Retrieve(szJob)
iTotalRows = dw_work_order_detail.RowCount()

For iRow = 1 to iTotalRows

	szPart = dw_work_order_detail.GetItemString(iRow, "part") 

	If dw_part_list.Find("value1 = '" + szPart + "'", 1, 99999) = 0 then
		dw_part_list.InsertRow(1)
		dw_part_list.SetItem(1, "value1", szPart)
	End If

Next
end subroutine

public subroutine wf_recalc_mps ();Long 		iRow
Long 		iTotalRows

String 	szPart

str_progress stProgress

stProgress.title	= "Calculating MPS"
OpenWithParm(w_progress, stProgress)

iTotalRows	= dw_part_list.RowCount()

For iRow = 1 to iTotalRows 

	szPart			= dw_part_list.GetItemString(iRow, "value1")
	w_progress.wf_progress(iRow / iTotalRows, "Processing part " + szPart)
	
	stParm.value1	= szPart	
	stParm.value3	= f_get_part_info(szPart, "TYPE")
//OpenWithParm(w_calculate_assigned_qty_in_mps, stParm)
   f_update_qty_asgnd_part ( szPart ) //new function included by mams, sp based activity

Next

Close(w_progress)
end subroutine

public function integer wf_get_cycle_time (string szPart);Int i_cycle_time

Select part_mfg.cycle_time
Into   :i_cycle_time
From   part_mfg
where  part_mfg.part = :szpart ;

Return  i_cycle_time ;
end function

public function string wf_get_cycle_unit (string szPart);String s_cycle_unit

Select part_mfg.cycle_unit
Into   :s_cycle_unit
From   part_mfg
Where  part = :szPart ;

Return s_cycle_unit ;
end function

public function integer wf_filter ();String l_s_datavalue
Int    l_i_pos
wf_select_all ( FALSE )
IF i_s_filter_suffix > "" THEN
	l_i_pos = 0 
	IF ddlb_type.text = 'Order' Then l_i_pos = (PosA(ddlb_value.text,' ') - 1)
	IF l_i_pos > 0 THEN 
		l_s_datavalue=LeftA(ddlb_value.text,l_i_pos )
		dw_soft_queue.SetFilter ( suffix_root + szSelectDate + i_s_filter_suffix + l_s_datavalue + "'" )			
	ELSE	
		dw_soft_queue.SetFilter ( suffix_root + szSelectDate + i_s_filter_suffix + ddlb_value.text + "'" )
	END IF 
ELSE
	dw_soft_queue.SetFilter ( suffix_root + szSelectDate  )
END IF	
Return dw_soft_queue.Filter ( )

end function

public function integer wf_create_job_header (date a_d_due, decimal a_n_runtime);STRING	l_s_process, &
	l_s_part, &
	l_s_cycle_unit, &
	l_s_work_order, &
	l_s_customer, &
	l_s_destination, &
	ls_notes, &
	ls_tool

INTEGER	l_i_cycle_time

DATETIME	l_dt_due

Decimal	l_n_order_no

if SQLCA.of_getnextparmvalue ( 'next_workorder', iWorkOrder ) then 
	l_s_work_order = String ( iWorkOrder )
	a_d_due = wf_get_due_date ( )
	l_dt_due = DateTime ( a_d_due )
	szMachine = dw_template.object.value1 [ 1 ]
	l_s_process	= dw_template.object.value2 [ 1 ]
	l_s_part = dw_template.object.value3 [ 1 ]
	l_n_order_no = Dec ( dw_template.object.value6 [ 1 ] )
	l_s_customer = dw_template.object.value7 [ 1 ]
	l_s_destination = dw_template.object.value8 [ 1 ]
	l_i_cycle_time = wf_get_cycle_time ( l_s_part )
	l_s_cycle_unit = wf_get_cycle_unit ( l_s_part )
	
	select	tool		
	into	:ls_tool
	from	part_machine_tool
	where	part = :l_s_part ;
	
//	sqlca.autocommit = true
	if dw_msp_getnotes.retrieve ( l_s_part, l_n_order_no ) > 0 then
		ls_notes = dw_msp_getnotes.object.notes [ 1 ]
	else
		ls_notes = ''
	end if 	
//	sqlca.autocommit = false
	
	IF iWorkOrder > 0 THEN
		INSERT INTO work_order
		(	work_order,
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
			start_date,
			start_time,
			end_date,
			end_time,
			runtime,
			employee,
			type,
			cycle_time,
			cycle_unit,
			accum_run_time,
			order_no,
			customer,
			destination,
			note)
		VALUES
		(	:l_s_work_Order,
			:ls_tool,
			:l_dt_due,
			null,
			null,
			:szMachine,
			:l_s_process,
			null,
			:id_setuptime,
			null,
			null,
			9999,
			null,
			null,
			null,
			null,
			:a_n_runtime,
			null,
			null,
			:l_i_cycle_time,
			:l_s_cycle_unit,
			null,
			:l_n_order_no,
			:l_s_Customer,
			:l_s_destination,
			:ls_notes)  ;
	
		IF SQLCA.SQLCode = 0 THEN
			Commit;
		ELSE
			Rollback;
		END IF
	END IF
else
	rollback;
end if 
Return SQLCA.SQLCode
end function

event open;String 	szSQL
String	szError

dw_work_order_detail.SetTransObject(sqlca)

szMachine				= Message.StringParm

szSelectDate		= "Date ('" + String (Today ( ), "yyyy/mm/dd" ) + "')"
sle_select_Date.text	= String (Today ( ) )

dw_soft_queue.Retrieve ( )
wf_filter ( )

gnv_App.of_GetFrame().SetMicroHelp( 'Ready' )



end event

on w_create_jobs_from_soft_queue.create
this.dw_msp_getnotes=create dw_msp_getnotes
this.dw_part_list=create dw_part_list
this.dw_work_order_detail=create dw_work_order_detail
this.st_1=create st_1
this.sle_select_date=create sle_select_date
this.st_percentage=create st_percentage
this.st_message=create st_message
this.sle_percentage=create sle_percentage
this.sle_base=create sle_base
this.dw_template=create dw_template
this.lb_jobs=create lb_jobs
this.dw_job_detail=create dw_job_detail
this.ddlb_type=create ddlb_type
this.dw_soft_queue=create dw_soft_queue
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.ddlb_value=create ddlb_value
this.Control[]={this.dw_msp_getnotes,&
this.dw_part_list,&
this.dw_work_order_detail,&
this.st_1,&
this.sle_select_date,&
this.st_percentage,&
this.st_message,&
this.sle_percentage,&
this.sle_base,&
this.dw_template,&
this.lb_jobs,&
this.dw_job_detail,&
this.ddlb_type,&
this.dw_soft_queue,&
this.gb_2,&
this.gb_1,&
this.gb_3,&
this.ddlb_value}
end on

on w_create_jobs_from_soft_queue.destroy
destroy(this.dw_msp_getnotes)
destroy(this.dw_part_list)
destroy(this.dw_work_order_detail)
destroy(this.st_1)
destroy(this.sle_select_date)
destroy(this.st_percentage)
destroy(this.st_message)
destroy(this.sle_percentage)
destroy(this.sle_base)
destroy(this.dw_template)
destroy(this.lb_jobs)
destroy(this.dw_job_detail)
destroy(this.ddlb_type)
destroy(this.dw_soft_queue)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.ddlb_value)
end on

event activate;IF gnv_App.of_GetFrame().menuname <> 'm_soft_queue' THEN &
	gnv_App.of_GetFrame().Changemenu ( m_soft_queue )
end event

event close;LONG	l_l_count, &
		l_l_array_count

ANY	l_a_machine[]

STRING l_s_machine[], &
  		 l_s_temp
			
BOOLEAN l_b_found = FALSE
			
// build the array of machines..

IF lb_jobs.TotalItems () = 0  THEN
	
	CLOSE ( THIS ) 

ELSE

	FOR l_l_count = 1 TO lb_jobs.TotalItems () 

      IF l_l_count = 1 THEN
			 l_s_temp	= lb_jobs.Text (1)
			 l_s_temp 	= LeftA ( l_s_temp,  PosA ( l_s_temp, " # ", 1 ) - 1  )
			 l_s_machine[ 1 ] = l_s_temp	
		ELSE
			l_s_temp = lb_jobs.Text ( l_l_count )
			l_s_temp = LeftA ( l_s_temp, PosA ( l_s_temp, " # ", 1 )  - 1 )
         l_l_array_count = 1 
			DO 
				IF l_s_machine[l_l_array_count] = l_s_temp THEN
					l_b_found = TRUE
					EXIT
				ELSE
					l_b_found = FALSE
				END IF
				l_l_array_count++ 
			LOOP WHILE ( l_l_array_count <= UPPERBOUND ( l_s_machine ) AND NOT l_b_found )
			
			IF NOT l_b_found THEN
				l_s_machine[upperbound( l_s_machine) + 1 ] = l_s_temp	
			END IF
		END IF
	NEXT

	l_a_machine = l_s_machine[]

	CLOSE ( THIS ) 
//	w_plant_monitor.TRIGGER EVENT ue_redraw_job ( l_a_machine )
	
END IF


end event

type dw_msp_getnotes from datawindow within w_create_jobs_from_soft_queue
int X=32
int Y=1820
int Width=297
int Height=196
int TabOrder=130
boolean Visible=false
string DataObject="d_msp_getnotes"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca ) 
end event

type dw_part_list from datawindow within w_create_jobs_from_soft_queue
int X=1915
int Y=1820
int Width=494
int Height=352
int TabOrder=150
boolean Visible=false
string DataObject="dw_external_template"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_work_order_detail from datawindow within w_create_jobs_from_soft_queue
int X=1371
int Y=1820
int Width=494
int Height=352
int TabOrder=140
boolean Visible=false
string DataObject="dw_work_order_detail"
boolean LiveScroll=true
end type

type st_1 from statictext within w_create_jobs_from_soft_queue
int X=37
int Y=48
int Width=219
int Height=36
boolean Enabled=false
string Text="Date "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-6
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_select_date from singlelineedit within w_create_jobs_from_soft_queue
event double_clicked pbm_lbuttondblclk
event we_nchitest pbm_nchittest
int X=37
int Y=88
int Width=247
int Height=60
int TabOrder=50
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event double_clicked;OpenWithParm ( w_view_calendar, this.text )

IF message.stringparm > ' ' THEN
	this.text = message.stringparm
	dDate	 = Date ( this.text )
	szSelectDate	= "Date ('" + String(dDate, "yyyy/mm/dd") + "')"
	wf_filter ( )
	wf_select_all ( TRUE )
END IF
end event

on we_nchitest;gnv_App.of_GetFrame().setmicrohelp( 'Double click to pop up calendar' )
end on

event modified;dDate	 = Date(this.text)

szSelectDate = "Date ('" + String ( dDate, "yyyy/mm/dd" ) + "')"

wf_filter ( )

wf_select_all ( TRUE )

end event

type st_percentage from statictext within w_create_jobs_from_soft_queue
int X=2066
int Y=64
int Width=128
int Height=64
boolean Enabled=false
string Text="0 %"
boolean FocusRectangle=false
long TextColor=255
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_message from statictext within w_create_jobs_from_soft_queue
int X=823
int Y=144
int Width=1225
int Height=64
boolean Enabled=false
string Text="Message"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_percentage from singlelineedit within w_create_jobs_from_soft_queue
int X=823
int Y=64
int Width=37
int Height=64
int TabOrder=30
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_base from singlelineedit within w_create_jobs_from_soft_queue
int X=823
int Y=64
int Width=1225
int Height=64
int TabOrder=20
boolean Enabled=false
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_template from datawindow within w_create_jobs_from_soft_queue
int X=946
int Y=1820
int Width=366
int Height=348
int TabOrder=120
boolean Visible=false
string DataObject="dw_external_template_soft_queue"
boolean LiveScroll=true
end type

type lb_jobs from listbox within w_create_jobs_from_soft_queue
int X=2249
int Y=64
int Width=1024
int Height=1632
int TabOrder=90
boolean VScrollBar=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_job_detail from datawindow within w_create_jobs_from_soft_queue
int X=379
int Y=1820
int Width=494
int Height=352
int TabOrder=110
boolean Visible=false
string DataObject="dw_external_template"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type ddlb_type from dropdownlistbox within w_create_jobs_from_soft_queue
int X=293
int Y=56
int Width=475
int Height=580
int TabOrder=10
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All",&
"Group Tech",&
"Machine",&
"Order",&
"Part",&
"Process Id",&
"Unselect All"}
end type

event selectionchanged;ddlb_value.reset()
ddlb_value.width=475
ddlb_value.x=293
CHOOSE CASE this.text

	CASE "All"

		bDate	= FALSE
		ib_SelectOrder	= FALSE
		bAll = TRUE
		ddlb_value.visible = FALSE
		i_s_filter_suffix = ""
		ddlb_value.text = ""

	CASE "Order"

		bDate	= FALSE
		bAll	= FALSE
		ib_SelectOrder	= TRUE
      ddlb_value.width=1250
      ddlb_value.x=37		
		ddlb_value.visible	= TRUE
		wf_create_order_dropdown ( )
		i_s_filter_suffix = " and string(origin) = '"
		ddlb_value.text = ""

	CASE "Part"
		ib_SelectOrder	= FALSE
		bDate	= FALSE
		bAll	= FALSE
		ddlb_value.width=800
		ddlb_value.x=37		
		ddlb_value.visible	= TRUE
		wf_create_part_dropdown ( )
		i_s_filter_suffix = " and part = '"
		ddlb_value.text = ""

	CASE "Process Id"
		ib_SelectOrder	= FALSE
		bDate	= FALSE
		bAll	= FALSE
		ddlb_value.visible	= TRUE
		wf_create_process_dropdown ( )
		i_s_filter_suffix = " and process = '"
		ddlb_value.text = ""

	CASE "Machine"
		ib_SelectOrder	= FALSE
		bDate	= FALSE
		bAll	= FALSE
		ddlb_value.visible	= TRUE
		wf_create_machine_dropdown ( )
		i_s_filter_suffix = " and machine = '"
		ddlb_value.text = ""

	CASE "Group Tech"
		ib_SelectOrder	= FALSE
		bDate	= FALSE
		bAll	= FALSE
		ddlb_value.visible	= TRUE
		wf_create_group_tech_dropdown()
		i_s_filter_suffix = " and part_group_technology = '"
		ddlb_value.text = ""
		
	CASE "Unselect All"
		wf_select_all ( FALSE )
		Return

END CHOOSE
ddlb_value.TRIGGER EVENT SelectionChanged ( 0 )

end event

event constructor;text = 'All'
end event

type dw_soft_queue from datawindow within w_create_jobs_from_soft_queue
int X=18
int Y=268
int Width=2194
int Height=1452
int TabOrder=80
string DataObject="dw_machine_soft_queue_for_all"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;IF row > 0 THEN
	
	IF THIS.IsSelected ( ROW ) THEN
		THIS.SELECTROW ( ROW, FALSE )
	ELSE
		THIS.SELECTROW ( ROW, TRUE )
	END IF

END IF
end event

on rbuttondown;integer	li_col

li_col	= this.getcolumn ()
if li_col > 0 then
	this.setsort( '#' + string( li_col ) + ' a'  )
	this.sort()
end if	
end on

event clicked;STRING 	l_s_name

l_s_name = dw_soft_queue.GetObjectAtPointer ()
l_s_name = LeftA ( l_s_name, PosA ( l_s_name, "_t~t", 1 ) - 1)

IF l_s_name > '' THEN
	dw_soft_queue.setsort ( l_s_name + ", A" )
	dw_soft_queue.sort()
END IF
end event

event constructor;SetTransObject ( SQLCA )
end event

type gb_2 from groupbox within w_create_jobs_from_soft_queue
int X=791
int Width=1426
int Height=256
int TabOrder=60
string Text="Message Center"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_create_jobs_from_soft_queue
int X=2226
int Width=1079
int Height=1728
int TabOrder=100
string Text="Job Created"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_create_jobs_from_soft_queue
int X=18
int Width=768
int Height=256
int TabOrder=40
string Text="Select"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_value from dropdownlistbox within w_create_jobs_from_soft_queue
int X=293
int Y=160
int Width=475
int Height=496
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;wf_filter ( )
dw_soft_queue.SetSort ( "machine a, process a, part a" )
dw_soft_queue.Sort ( )
wf_select_all ( TRUE )

end event

