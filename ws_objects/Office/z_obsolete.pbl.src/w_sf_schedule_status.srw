$PBExportHeader$w_sf_schedule_status.srw
forward
global type w_sf_schedule_status from Window
end type
type cb_5 from commandbutton within w_sf_schedule_status
end type
type cb_4 from commandbutton within w_sf_schedule_status
end type
type dw_upd_mps_qtyassigned from datawindow within w_sf_schedule_status
end type
type dw_2 from datawindow within w_sf_schedule_status
end type
type cb_2 from commandbutton within w_sf_schedule_status
end type
type cb_1 from commandbutton within w_sf_schedule_status
end type
type cb_3 from commandbutton within w_sf_schedule_status
end type
type st_2 from statictext within w_sf_schedule_status
end type
type st_1 from statictext within w_sf_schedule_status
end type
type sle_1 from singlelineedit within w_sf_schedule_status
end type
type sle_2 from singlelineedit within w_sf_schedule_status
end type
type gb_2 from groupbox within w_sf_schedule_status
end type
type cbx_5 from checkbox within w_sf_schedule_status
end type
type cbx_1 from checkbox within w_sf_schedule_status
end type
type cbx_2 from checkbox within w_sf_schedule_status
end type
type cbx_3 from checkbox within w_sf_schedule_status
end type
type cbx_4 from checkbox within w_sf_schedule_status
end type
type dw_1 from datawindow within w_sf_schedule_status
end type
type gb_1 from groupbox within w_sf_schedule_status
end type
end forward

global type w_sf_schedule_status from Window
int X=5
int Y=0
int Width=3150
int Height=1896
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_5 cb_5
cb_4 cb_4
dw_upd_mps_qtyassigned dw_upd_mps_qtyassigned
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
st_2 st_2
st_1 st_1
sle_1 sle_1
sle_2 sle_2
gb_2 gb_2
cbx_5 cbx_5
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
dw_1 dw_1
gb_1 gb_1
end type
global w_sf_schedule_status w_sf_schedule_status

type variables
String szMachine

Boolean bRunning
Boolean bStop
String is_wono=''
end variables

forward prototypes
public subroutine wf_build_dw1 ()
public subroutine wf_reorder_sequences (long li_selectedsequence)
public subroutine wf_old_fn ()
public subroutine wf_close_job (string as_workorder, string as_part)
end prototypes

public subroutine wf_build_dw1 ();Boolean	lb_HeaderDone
Boolean	lb_DetailDone
Boolean	lb_Found
Int	li_NumberOfParts
Int	li_Sequence
Int	li_Count
Int	li_Count2
Long    ll_so_number
String	ls_Tool
String	ls_Part
String  ls_name
String  ls_ecn
String	ls_Parts[]
String  ls_partdesc[]
String  ls_ecnary[]
String	ls_String
String	ls_WorkOrder
String  ls_dest
String  ls_customer
Date	ld_DueDate
Date	ld_StartDate
Time	lt_StartTime

DateTime l_ld_DueDate
Datetime l_ld_StartDate
DateTime l_lt_StartTime
Dec	ld_QtyCompleted
Dec	ld_QtyRequired
Dec	ld_QtyBalance
Dec	ld_Qtys[]
Dec	ld_RunTime
String	error_syntaxfromSQL,&
	error_create
String	new_sql, &
	new_syntax
Datastore lds_woheader, &
	  lds_wodetail 
Int	li_rowno, &
	li_dtlrowno
lds_woheader=Create datastore				
new_sql  = 'SELECT	work_order.work_order, ' &   
			+ 'work_order.tool, ' &  
			+ 'work_order.due_date, ' &  
			+ 'work_order.sequence, ' &  
			+ 'work_order.start_date, ' &  
			+ 'work_order.start_time, ' &  
			+ 'work_order.runtime, ' &
			+ 'work_order.order_no, ' &			
			+ 'work_order.customer, ' &			
			+ 'work_order.destination ' &			
			+ 'FROM	work_order ' & 
			+ "WHERE	work_order.machine_no = '"+szMachine+"'" &
			+ "ORDER BY	sequence"
new_syntax = SQLCA.SyntaxFromSQL(new_sql,'', error_syntaxfromSQL)
IF LenA(error_syntaxfromSQL) > 0 THEN
	Messagebox('Error',error_syntaxfromSQL)
	Destroy lds_woheader 	
	Return 	
ELSE
	// Generate new DataWindow
	lds_woheader.Create(new_syntax, error_create)
	IF LenA(error_create) > 0 THEN
		Messagebox('Error',error_create)
		Destroy lds_woheader 
		Return 
	END IF
END IF
lds_woheader.SetTransObject(SQLCA)
lds_woheader.Retrieve()
FOR  li_rowno = 1 to lds_woheader.rowcount()
	ls_workorder  =lds_woheader.getitemstring(li_rowno,'work_order')
	ls_Tool       =lds_woheader.getitemstring(li_rowno,'tool')
	l_ld_DueDate  =lds_woheader.getitemdatetime(li_rowno,'due_date')
	li_Sequence   =lds_woheader.getitemnumber(li_rowno,'sequence') 
	l_ld_StartDate=lds_woheader.getitemdatetime(li_rowno,'start_date')
	l_lt_StartTime=lds_woheader.getitemdatetime(li_rowno,'start_time')
	ld_RunTime    =lds_woheader.getitemnumber(li_rowno,'runtime')
	ls_customer   =lds_woheader.getitemstring(li_rowno,'customer')		
	ls_dest       =lds_woheader.getitemstring(li_rowno,'destination')				
	ll_so_number  =lds_woheader.getitemnumber(li_rowno,'order_no')				
	li_NumberOfParts = 0
	li_Count = 0
	ls_String = ''
	lds_wodetail = Create Datastore
	new_sql   = 'SELECT workorder_detail.part, ' &   
		    + 'workorder_detail.qty_completed, ' & 
		    + 'workorder_detail.qty_required, ' & 						
		    + 'workorder_detail.balance ' & 						
					+ 'FROM workorder_detail ' & 
				   + "WHERE workorder_detail.workorder = '"+ls_WorkOrder+"'"
	new_syntax = SQLCA.SyntaxFromSQL(new_sql, &
					'Style(Type=Form)', error_syntaxfromSQL)
	IF LenA(error_syntaxfromSQL) > 0 THEN
		Messagebox('Error',error_syntaxfromSQL)
		Destroy lds_woheader 
		Destroy lds_wodetail 
		Return 	
	ELSE
		// Generate new DataWindow
		lds_wodetail.Create(new_syntax, error_create)
		IF LenA(error_create) > 0 THEN
			Messagebox('Error',error_create)
			Destroy lds_woheader 
			Destroy lds_wodetail 
			Return 
		END IF
	END IF
	lds_wodetail.SetTransObject(SQLCA)
	lds_wodetail.Retrieve()
	FOR li_dtlrowno = 1 to lds_wodetail.rowcount()			
		ls_Part         = lds_wodetail.getitemstring(li_dtlrowno,'part') 
		ld_QtyCompleted = lds_wodetail.getitemdecimal(li_dtlrowno,'qty_completed')
		ld_QtyRequired  = lds_wodetail.getitemdecimal(li_dtlrowno,'qty_required')			
		ld_QtyBalance   = ld_QtyRequired - ld_QtyCompleted			
		lb_Found = False
		For li_Count = 1 to li_NumberOfParts
			If ls_Part = ls_Parts[li_Count] Then
				lb_Found = True
				li_Count = li_NumberOfParts
			End if
		Next
		If Not lb_Found Then
			li_NumberOfParts++
			ls_Parts[li_NumberOfParts] = ls_Part
			ld_Qtys[li_NumberOfParts] = ld_QtyCompleted
			// get name from part table
			Select isnull(name,'')
			  Into :ls_name
			  From part
			 Where (part= :ls_part) ; 
			ls_Partdesc[li_NumberOfParts] = isnull(ls_name,'')
			// get the ecn from ecn table
			Select isnull(engineering_level,'')
			  into :ls_ecn
			  from effective_change_notice
			 where ( part = :ls_part  and
			effective_date = (select max (effective_date )
					from effective_change_notice
					where part = :ls_part and effective_date <= getdate() ) );
			ls_ecnary[li_NumberOfParts] = isnull(ls_ecn,'')
		End if
	Next 
	Destroy lds_wodetail 
	dw_1.InsertRow ( 0 )
	dw_1.SetItem ( dw_1.RowCount ( ), "sequence", li_Sequence )
	dw_1.SetItem ( dw_1.RowCount ( ), "workorder", Long ( ls_WorkOrder ) )
	dw_1.SetItem ( dw_1.RowCount ( ), "due_date", date(l_ld_DueDate ))
	dw_1.SetItem ( dw_1.RowCount ( ), "start_date", date(l_ld_StartDate) )
	dw_1.SetItem ( dw_1.RowCount ( ), "start_time", time(l_lt_StartTime) )
	dw_1.SetItem ( dw_1.RowCount ( ), "runtime", ld_RunTime )
	dw_1.SetItem ( dw_1.RowCount ( ), "tool", ls_Tool )
	
	dw_1.SetItem ( dw_1.RowCount ( ), "required_qty", ld_QtyRequired )		
	dw_1.SetItem ( dw_1.RowCount ( ), "completed_qty",ld_QtyCompleted  )
	dw_1.SetItem ( dw_1.RowCount ( ), "balance",ld_QtyBalance  )

	dw_1.SetItem ( dw_1.RowCount ( ), "customer", ls_customer)		
	dw_1.SetItem ( dw_1.RowCount ( ), "destination",ls_dest )
	dw_1.SetItem ( dw_1.RowCount ( ), "order_no",ll_so_number )

	For li_Count = 1 to li_NumberOfParts
		ls_String = ls_String + ls_Parts[li_Count] & 
				      + "~r~n" + ls_partdesc[li_count] + "~r~n" + ls_ecnary[li_count] + "~r~n"
	Next
	dw_1.SetItem ( dw_1.RowCount ( ), "list_of_parts", ls_String )
Next
Destroy lds_woheader

end subroutine

public subroutine wf_reorder_sequences (long li_selectedsequence);/*  Declare Variables  */
Boolean	lb_Order
Long	li_Sequence, &
	li_Loop, &
	li_curnseq
String	ls_WorkOrder
long	ll_totrows

/*  Initialize Variables  */

ll_totrows = dw_1.RowCount ( )
li_sequence = 2

For li_Loop = 1 to ll_totrows
	ls_WorkOrder = string(dw_1.object.workorder[li_loop])
	if ls_workorder = is_wono then
		dw_1.object.sequence[li_loop] = 1
	else
		dw_1.object.sequence[li_loop] = li_sequence
		li_sequence++
	end if 	
	If SQLCA.SQLCode = 0 Then
		Commit ;
	Else
		RollBack ;
	End if
next

For li_Loop = 1 to ll_totrows
	ls_WorkOrder = string(dw_1.object.workorder[li_loop])	
	li_sequence = long(dw_1.object.sequence[li_loop])
	UPDATE	work_order  
	SET	sequence = :li_sequence
	WHERE	work_order.work_order = :ls_WorkOrder;
	If SQLCA.SQLCode = 0 Then
		Commit ;
	Else
		RollBack ;
	End if
next

/*

If li_SelectedSequence = 0 Then 
	lb_Order = True
	li_SelectedSequence = dw_1.RowCount ( )
	li_Sequence = 1
Else
	li_Sequence = 2
End if

/*  Main  */

For li_Loop = 1 to li_SelectedSequence
	ls_WorkOrder = String ( dw_1.GetItemNumber ( li_Loop, "workorder" ) )
	li_curnseq = dw_1.GetItemNumber ( li_Loop, "sequence" ) 
	If Not lb_Order And li_curnseq = li_SelectedSequence Then
		dw_1.SetItem ( li_Loop, "sequence", 1 )
		UPDATE work_order  
		   SET sequence = 1
		 WHERE work_order.work_order = :ls_WorkOrder and sequence = :li_curnseq;
		If SQLCA.SQLCode = 0 Then
			Commit ;
		Else
			RollBack ;
		End if
	Else
		dw_1.SetItem ( li_Loop, "sequence", li_Sequence )
		UPDATE work_order  
		   SET sequence = :li_Sequence
		 WHERE work_order.work_order = :ls_WorkOrder and sequence = :li_curnseq;
		If SQLCA.SQLCode = 0 Then
			Commit ;
		Else
			RollBack ;
		End if
		li_Sequence++		
	End if
Next
*/

//If lSelectedSequence > 0 Then lSequence = 1
//
//For lLoop = 1 to lRowCount
//
//	lCurrentSequence = dw_1.GetItemNumber ( lLoop, "sequence" )
//
//	If lCurrentSequence = 1 Then
//
//		dw_1.SetItem ( lLoop, "sequence", lRowCount )
//		
//	ElseIf lSelectedSequence <> 0 And lCurrentSequence = lSelectedSequence Then
//
//		dw_1.SetItem ( lLoop, "sequence", 1 )
//
//	Else
//
//		lSequence++
//		dw_1.SetItem ( lLoop, "sequence", lSequence )
//
//	End if
//		
//Next

dw_1.SetSort ( "sequence A" ) 
dw_1.Sort ( )
end subroutine

public subroutine wf_old_fn ();Boolean		lb_HeaderDone
Boolean		lb_DetailDone
Boolean		lb_Found
Int			li_NumberOfParts
Int			li_Sequence
Int			li_Count
Int			li_Count2
String		ls_Tool
String		ls_Part
String      ls_name
String      ls_ecn
String		ls_Parts[]
String      ls_partdesc[]
String      ls_ecnary[]
String		ls_String
String		ls_WorkOrder
Date			ld_DueDate
Date			ld_StartDate
Time			lt_StartTime

DateTime		l_ld_DueDate
Datetime		l_ld_StartDate
DateTime		l_lt_StartTime

Dec			ld_QtyCompleted
Dec			ld_Qtys[]
Dec			ld_RunTime
 DECLARE	workorder CURSOR FOR  
  SELECT	work_order.work_order,   
			work_order.tool,   
			work_order.due_date,   
			work_order.sequence,   
			work_order.start_date,   
			work_order.start_time,   
			work_order.runtime  
    FROM	work_order  
   WHERE	work_order.machine_no = :szMachine
ORDER BY	sequence;

Open workorder ;
Do
		li_NumberOfParts = 0
		li_Count = 0
		ls_String = ''
	Fetch workorder Into :ls_WorkOrder, :ls_Tool, :l_ld_DueDate, :li_Sequence, :l_ld_StartDate, :l_lt_StartTime, :ld_RunTime ;
	If SQLCA.SQLCode = 0 Then
		DECLARE workorder_detail CURSOR FOR  
		 SELECT workorder_detail.part,   
		        workorder_detail.qty_completed  
   		FROM workorder_detail  
  		  WHERE workorder_detail.workorder = :ls_WorkOrder   ;
		Open workorder_detail ;
		Do
			Fetch workorder_detail Into :ls_Part, :ld_QtyCompleted ;
			If SQLCA.SQLCode = 0 Then
				lb_Found = False
				For li_Count = 1 to li_NumberOfParts
					If ls_Part = ls_Parts[li_Count] Then
						lb_Found = True
						li_Count = li_NumberOfParts
					End if
				Next
				If Not lb_Found Then
					li_NumberOfParts++
					ls_Parts[li_NumberOfParts] = ls_Part
					ld_Qtys[li_NumberOfParts] = ld_QtyCompleted
					// get name from part table
					Select name
					  Into :ls_name
					  From part
					 Where (part= :ls_part) ; 
					ls_Partdesc[li_NumberOfParts] = ls_name
					// get the ecn from ecn table
					Select engineering_level
					  into :ls_ecn
					  from effective_change_notice
					 where ( part = :ls_part  and
                        effective_date = (select max (effective_date )
								                    from effective_change_notice
													    where part = :ls_part and effective_date <= getdate() ) ) ;
					ls_ecnary[li_NumberOfParts] = ls_ecn
				End if
			Else
				lb_DetailDone = True
			End if
		Loop While Not lb_DetailDone
		Close workorder_detail ;
		dw_1.InsertRow ( 0 )
		dw_1.SetItem ( dw_1.RowCount ( ), "sequence", li_Sequence )
		dw_1.SetItem ( dw_1.RowCount ( ), "workorder", Long ( ls_WorkOrder ) )
		dw_1.SetItem ( dw_1.RowCount ( ), "due_date", date(l_ld_DueDate ))
		dw_1.SetItem ( dw_1.RowCount ( ), "start_date", date(l_ld_StartDate) )
		dw_1.SetItem ( dw_1.RowCount ( ), "start_time", time(l_lt_StartTime) )
		dw_1.SetItem ( dw_1.RowCount ( ), "runtime", ld_RunTime )
		dw_1.SetItem ( dw_1.RowCount ( ), "tool", ls_Tool )
		For li_Count = 1 to li_NumberOfParts
			ls_String = ls_String + ls_Parts[li_Count] + " -- " + String ( ld_Qtys[li_Count], "########0.00" ) & 
			                      + "~r~n" + ls_partdesc[li_count] + "~r~n" + ls_ecnary[li_count] + "~r~n"
		Next
		dw_1.SetItem ( dw_1.RowCount ( ), "list_of_parts", ls_String )
	Else
		lb_HeaderDone = True
	End if
Loop While Not lb_HeaderDone
Close workorder ;
//li_Count2 = 0
//FOR li_Count = 1 to dw_1.RowCount ( )
//	li_Sequence = dw_1.GetItemNumber ( li_Count, "sequence" )
//	IF li_Sequence = 1 THEN li_Count2 = li_Count
//NEXT
//wf_reorder_sequences ( li_Count2 )
wf_reorder_sequences ( 0 )
end subroutine

public subroutine wf_close_job (string as_workorder, string as_part);string	l_s_message
int	l_i_count
if as_part > '' then 
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
		FROM	workorder_detail
		WHERE	workorder = :as_workorder AND
			part = :as_part ;
			
		if sqlca.sqlcode <> 0 then
			l_s_message = sqlca.sqlerrtext
			rollback;
			MessageBox ( "Database Error", "Unable to save job history!~r~nReason:" + l_s_message, StopSign! )
		else	
			DELETE FROM workorder_detail  
			WHERE ( workorder_detail.workorder = :as_workorder ) AND  
			( workorder_detail.part = :as_part )   ;
			if sqlca.sqlcode <> 0 then
				l_s_message = sqlca.sqlerrtext
				rollback;
				MessageBox ( "Database Error", "Unable to delete job!~r~nReason:" + l_s_message, StopSign! )
			else
				commit;
			end if
		end if 	
ELSE
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
		FROM	workorder_detail
		WHERE	workorder = :as_workorder;
			
		if sqlca.sqlcode <> 0 then
			l_s_message = sqlca.sqlerrtext
			rollback;
			MessageBox ( "Database Error", "Unable to save job history!~r~nReason:" + l_s_message, StopSign! )
		else	
			DELETE FROM workorder_detail  
			WHERE ( workorder_detail.workorder = :as_workorder );
			if sqlca.sqlcode <> 0 then
				l_s_message = sqlca.sqlerrtext
				rollback;
				MessageBox ( "Database Error", "Unable to delete job!~r~nReason:" + l_s_message, StopSign! )
			else
				commit;
			end if
		end if 	
end if 
		
SELECT	count(*)
INTO	:l_i_count
FROM	workorder_detail
WHERE	workorder = :as_workorder ;

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
	FROM	work_order
	WHERE	work_order = :as_workorder  ;

	if sqlca.sqlcode <> 0 then
		l_s_message = sqlca.sqlerrtext
		rollback;
		MessageBox ( "Database Error", "Unable to save job history!~r~nReason:" + l_s_message, StopSign! )
	else
		DELETE FROM work_order  
		 WHERE ( work_order.work_order = :as_workorder ) AND  
		       ( work_order.machine_no = :szmachine )   ;

		if sqlca.sqlcode <> 0 then
			l_s_message = sqlca.sqlerrtext
			rollback;
			MessageBox ( "Database Error", "Unable to delete job!~r~nReason:" + l_s_message, StopSign! )
		else
			commit;
			dw_1.Reset ( )
			wf_build_dw1 ( )
			is_wono = string(dw_1.object.workorder[1])
			wf_reorder_sequences ( 0 )
			// update mps qty assigned
			dw_upd_mps_qtyassigned.retrieve ( as_part )
		end if 	
	end if 		
end if 

end subroutine

event open;/*  Initialize Variables  */

szMachine = Message.StringParm

/*  Main  */

dw_2.settransobject ( sqlca )
dw_2.Retrieve ( szMachine )

wf_build_dw1 ( )
dw_1.Modify ( "running_job.Visible = 1" )

Timer ( .5 )

end event

event timer;/*  Main  */

If Not bStop Then

	If bRunning Then
		dw_1.SetItem ( 1, "onoff", "X" )
		bRunning = False
	Else
		dw_1.SetItem ( 1, "onoff", "" )
		bRunning = True
	End if

Else
		dw_1.SetItem ( 1, "onoff", "" )
End if
end event

on w_sf_schedule_status.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_upd_mps_qtyassigned=create dw_upd_mps_qtyassigned
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.sle_2=create sle_2
this.gb_2=create gb_2
this.cbx_5=create cbx_5
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.dw_upd_mps_qtyassigned,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.cb_3,&
this.st_2,&
this.st_1,&
this.sle_1,&
this.sle_2,&
this.gb_2,&
this.cbx_5,&
this.cbx_1,&
this.cbx_2,&
this.cbx_3,&
this.cbx_4,&
this.dw_1,&
this.gb_1}
end on

on w_sf_schedule_status.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_upd_mps_qtyassigned)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.gb_2)
destroy(this.cbx_5)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_5 from commandbutton within w_sf_schedule_status
int X=2354
int Y=1632
int Width=539
int Height=224
int TabOrder=70
string Text="Sort"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if gb_2.visible = true then 
	gb_2.visible = false
	cbx_1.visible = false
	cbx_2.visible = false
	cbx_3.visible = false
	cbx_4.visible = false	
	cbx_5.visible = false		
else
	SelectRow ( dw_1, 0, False )	
	cbx_1.checked = false
	cbx_2.checked = false
	cbx_3.checked = false
	cbx_4.checked = false	
	cbx_5.checked = false		
	gb_2.visible = true
	cbx_1.visible = true
	cbx_2.visible = true
	cbx_3.visible = true
	cbx_4.visible = true	
	cbx_5.visible = true		
end if 	
	

end event

type cb_4 from commandbutton within w_sf_schedule_status
int X=1778
int Y=1632
int Width=539
int Height=224
int TabOrder=60
string Text="Search"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if gb_1.visible = true then
	gb_1.visible = false
	sle_1.visible = false
	sle_2.visible = false
	st_1.visible = false
	st_2.visible = false
else
	SelectRow ( dw_1, 0, False )	
	sle_1.text = ''	
	sle_2.text = ''
	gb_1.visible = true
	sle_1.visible = true
	sle_2.visible = true
	st_1.visible = true
	st_2.visible = true
	sle_1.setfocus()
end if 	
end event

type dw_upd_mps_qtyassigned from datawindow within w_sf_schedule_status
int X=2921
int Y=1644
int Width=192
int Height=164
int TabOrder=120
boolean Visible=false
string DataObject="d_qty_assigned"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

type dw_2 from datawindow within w_sf_schedule_status
int X=41
int Y=32
int Width=2889
int Height=256
int TabOrder=10
string DataObject="dw_machine_header"
boolean Border=false
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_sf_schedule_status
int X=50
int Y=1632
int Width=539
int Height=224
int TabOrder=30
string Text="Start"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;/*  Declare Variables  */

Long lRow = 0
Long lLoop


/*  Initialize Variables  */

bStop = False

For lLoop = 1 to dw_1.RowCount ( )

	If dw_1.IsSelected ( lLoop ) Then lRow = lLoop

Next

wf_reorder_sequences ( lRow )

end on

type cb_1 from commandbutton within w_sf_schedule_status
int X=1202
int Y=1632
int Width=539
int Height=224
int TabOrder=40
string Text="Exit"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_3 from commandbutton within w_sf_schedule_status
int X=626
int Y=1632
int Width=539
int Height=224
int TabOrder=50
string Text="Stop"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
Int	iRtnCode
String	ls_WorkOrder, &
	ls_part_list, & 
	ls_part 
int	li_level
string	ls_supervisorclose

//if isnull(szoperator,'') = '' then 
	szOperator = ''
	Open ( w_touch_keypad )
	
	do while IsValid ( w_touch_keypad )
	loop
	If szOperator = "" Then Return
//end if 

//	get machine policy setting
select	supervisorclose
into	:ls_supervisorclose
from	machine_policy
where	machine = :szmachine;

if isnull(ls_supervisorclose,'N') = 'Y' then 

	select	isnull(operatorlevel,-1)
	into	:li_level
	from	employee
	where	operator_code = :szoperator;
	
	if (isnull(li_level,-1)<> 0) then
		messagebox( monsys.msg_title,"Sorry, user doesn't have permission to close the workorder")
		Return
	end if 	
end if 	
ls_WorkOrder = String ( dw_1.GetItemNumber ( 1, "workorder" ) )

iRtnCode = Messagebox ( Monsys.msg_title, "Do you wish to close all jobs (i.e. different parts ) on this workorder "+ls_WorkOrder+" ?", Question!, YesNo!, 2 ) 	
if iRtnCode = 1 then 
	bStop = True	
	wf_close_job(ls_WorkOrder,"")	
else	
	ls_part_list= dw_1.GetItemstring ( 1, "list_of_parts" )
	ls_part     = LeftA(ls_part_list,(PosA(ls_part_list,"~r~n") - 1)) 
	iRtnCode = MessageBox ( Monsys.msg_title, "Do you wish to close part: "+ls_part+" on workorder #: "+ls_WorkOrder+" ?", Question!, YesNo!, 1 )
	If iRtnCode = 1 Then
		bStop = True		
		wf_close_job(ls_WorkOrder,ls_part)
	End if
end if


end event

type st_2 from statictext within w_sf_schedule_status
int X=402
int Y=996
int Width=448
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Workorder:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-15
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_sf_schedule_status
int X=407
int Y=808
int Width=251
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Part:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-15
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_sf_schedule_status
int X=951
int Y=768
int Width=1687
int Height=168
int TabOrder=100
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="123456789012345678901234"
long TextColor=33554432
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long	ll_foundrow=0
string	ls_searchstr

ls_searchstr = text
ll_foundrow = dw_1.find ( "Pos(list_of_parts,'"+ls_searchstr+"') > 0", 1, dw_1.rowcount () )
if ll_foundrow > 0 then 
	dw_1.scrolltorow ( ll_foundrow )
	SelectRow ( dw_1, 0, False )
	SelectRow ( dw_1, ll_foundRow, True )
	is_wono = string(dw_1.object.workorder[ll_foundrow])	
else
	SelectRow ( dw_1, 0, False )	
//	bStop = False
//	wf_reorder_sequences ( ll_foundrow )
end if 	
visible = false
sle_2.visible = false
st_1.visible = false
st_2.visible = false
gb_1.visible = false
end event

type sle_2 from singlelineedit within w_sf_schedule_status
int X=946
int Y=968
int Width=782
int Height=168
int TabOrder=110
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1234567890"
long TextColor=33554432
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long	ll_foundrow=0
long	ll_searchstr

ll_searchstr = long(text)
ll_foundrow = dw_1.find ( "workorder="+string(ll_searchstr)+"", 1, dw_1.rowcount () )
if ll_foundrow > 0 then 
	dw_1.scrolltorow ( ll_foundrow )
	SelectRow ( dw_1, 0, False )
	SelectRow ( dw_1, ll_foundRow, True )
	is_wono = string(dw_1.object.workorder[ll_foundrow])		
else
	SelectRow ( dw_1, 0, False )	
//	bStop = False
//	wf_reorder_sequences ( ll_foundrow )
end if 	
visible = false
sle_1.visible = false
st_1.visible = false
st_2.visible = false
gb_1.visible = false

end event

type gb_2 from groupbox within w_sf_schedule_status
int X=1170
int Y=280
int Width=1193
int Height=1260
int TabOrder=80
boolean Visible=false
string Text="Sort"
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_5 from checkbox within w_sf_schedule_status
int X=1312
int Y=444
int Width=859
int Height=196
boolean Visible=false
string Text="Part"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.setsort ( "list_of_parts A")
dw_1.sort()
gb_2.visible = false
cbx_1.visible = false
cbx_2.visible = false
cbx_3.visible = false
cbx_4.visible = false
cbx_5.visible = false
end event

type cbx_1 from checkbox within w_sf_schedule_status
int X=1317
int Y=644
int Width=859
int Height=196
boolean Visible=false
string Text="Work Order"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.setsort ( "workorder A")
dw_1.sort()
gb_2.visible = false
cbx_1.visible = false
cbx_2.visible = false
cbx_3.visible = false
cbx_4.visible = false
cbx_5.visible = false

end event

type cbx_2 from checkbox within w_sf_schedule_status
int X=1317
int Y=868
int Width=859
int Height=196
boolean Visible=false
string Text="Customer"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.setsort ( "customer A")
dw_1.sort()
gb_2.visible = false
cbx_1.visible = false
cbx_2.visible = false
cbx_3.visible = false
cbx_4.visible = false
cbx_5.visible = false

end event

type cbx_3 from checkbox within w_sf_schedule_status
int X=1317
int Y=1092
int Width=859
int Height=196
boolean Visible=false
string Text="Sales Order"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.setsort ( "order_no A")
dw_1.sort()
gb_2.visible = false
cbx_1.visible = false
cbx_2.visible = false
cbx_3.visible = false
cbx_4.visible = false
cbx_5.visible = false

end event

type cbx_4 from checkbox within w_sf_schedule_status
int X=1317
int Y=1316
int Width=859
int Height=196
boolean Visible=false
string Text="Default"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.setsort ( "sequence A")
dw_1.sort()
gb_2.visible = false
cbx_1.visible = false
cbx_2.visible = false
cbx_3.visible = false
cbx_4.visible = false
cbx_5.visible = false

end event

type dw_1 from datawindow within w_sf_schedule_status
int X=55
int Y=316
int Width=2834
int Height=1280
int TabOrder=20
string DataObject="d_schedule_status"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;/*  Main  */
If Row < 1 Then
	SelectRow ( dw_1, 0, False )
	Return
End if

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, Row, True )

is_wono = string(object.workorder[row])

end event

on retrieveend;SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, 1, True )
end on

type gb_1 from groupbox within w_sf_schedule_status
int X=325
int Y=664
int Width=2354
int Height=536
int TabOrder=90
boolean Visible=false
string Text="Search "
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

