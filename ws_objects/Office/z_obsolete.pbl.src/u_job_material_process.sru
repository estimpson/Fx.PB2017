$PBExportHeader$u_job_material_process.sru
forward
global type u_job_material_process from UserObject
end type
type dw_workorder_header from datawindow within u_job_material_process
end type
type st_1 from statictext within u_job_material_process
end type
type ddlb_process_id from dropdownlistbox within u_job_material_process
end type
type st_2 from statictext within u_job_material_process
end type
type st_3 from statictext within u_job_material_process
end type
type sle_runtime from singlelineedit within u_job_material_process
end type
type st_4 from statictext within u_job_material_process
end type
type ddlb_time from dropdownlistbox within u_job_material_process
end type
type sle_tool from singlelineedit within u_job_material_process
end type
type st_5 from statictext within u_job_material_process
end type
type ddlb_lot_control from dropdownlistbox within u_job_material_process
end type
type st_7 from statictext within u_job_material_process
end type
type st_8 from statictext within u_job_material_process
end type
type sle_pred_runtime from singlelineedit within u_job_material_process
end type
type sle_cycle_time from editmask within u_job_material_process
end type
type dw_process from datawindow within u_job_material_process
end type
end forward

global type u_job_material_process from UserObject
int Width=1783
int Height=1444
boolean Border=true
long BackColor=77897888
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
event ue_save pbm_custom01
dw_workorder_header dw_workorder_header
st_1 st_1
ddlb_process_id ddlb_process_id
st_2 st_2
st_3 st_3
sle_runtime sle_runtime
st_4 st_4
ddlb_time ddlb_time
sle_tool sle_tool
st_5 st_5
ddlb_lot_control ddlb_lot_control
st_7 st_7
st_8 st_8
sle_pred_runtime sle_pred_runtime
sle_cycle_time sle_cycle_time
dw_process dw_process
end type
global u_job_material_process u_job_material_process

type variables
String szJob		//Job number
String szTool		//Tool number
String szCycleUnit		//Cycle Unit
String szProcessId		//Process Id
String szPart

Decimal iCycleTime		//Cycle time
Decimal nRunTime		//Run time
Decimal id_qtyrequired_org

Decimal i_PartsPerTime	//Parts per Hour
Decimal i_PartsPerCycle         //Parts per Cycle
Integer iFactor

Boolean b_runtime = False
Boolean ib_qtychanged = False
end variables

forward prototypes
public subroutine uf_check_cavity ()
public subroutine uf_get_process ()
public subroutine uf_get_job_info ()
public subroutine uf_recalc_detail_runtime ()
public subroutine uf_update_job ()
public subroutine uf_update_mps_assigned (string as_part)
end prototypes

event ue_setup;szJob	= a_st_parm.value2

dw_workorder_header.Retrieve(szJob)
dw_process.Retrieve(szJob)

uf_check_cavity()
uf_get_process()
uf_get_job_info()
ib_qtychanged=False

If nruntime = 0 Then
	dw_process.enabled = False
	sle_cycle_time.enabled = False
	sle_runtime.enabled = False
	ddlb_time.enabled = False
	sle_pred_runtime.enabled = False
End If
	
end event

event ue_save;String cLotControl
String ls_part
Long   ll_row

If b_runtime = False then
	sle_runtime.text = sle_pred_runtime.text
End If

szTool		= sle_tool.text
szProcessId	= ddlb_process_id.text
iCycleTime	= Integer(sle_cycle_time.text)
szCycleUnit	= ddlb_time.text
nRunTime		= Dec(sle_runtime.text)

Choose Case ddlb_lot_control.Text
	Case "Yes"
		cLotControl = 'Y'
	Case "No"
		cLotControl = 'O'
End Choose

If dw_process.Update() = 1 Then
	Commit ;

	if ib_qtychanged = true then 
	   For ll_row = 1 to dw_process.rowcount()
			 ls_part = dw_process.getitemstring(ll_row,'workorder_detail_part')
			 uf_update_mps_assigned(ls_part)
		Next
	end if 	
	
//	wmainscreen.setmicrohelp("Detail Information saved successfully...")
Else
	Rollback ;
//	wmainscreen.setmicrohelp("Unable to save the information...")
End If


UPDATE work_order  
   SET tool 						= :szTool,   
       cycle_time 				= :iCycleTime,   
       runtime 					= :nRunTime,   
       process_id 				= :szProcessId,
		 cycle_unit					= :szCycleUnit,
		 lot_control_activated 	= :cLotControl
WHERE  work_order = :szJob   ;

If SQLCA.SQLCode = 0 Then
	Commit ;
//	wmainscreen.setmicrohelp("Information saved successfully...")
	w_plant_monitor.recalc_machine_job_time(w_plant_monitor.st_machine.text)
	w_plant_monitor.redraw()
Else
	Rollback ;
//	wmainscreen.setmicrohelp("Unable to save the information...")
End If


end event

public subroutine uf_check_cavity ();Long iRow
Long iTotalRows

String l_s_Part

Boolean bDataMissing	= FALSE

dw_process.Retrieve(szJob)
iTotalRows	= dw_process.RowCount()
iRow			= 1

Do while (iRow <= iTotalRows) AND (Not bDataMissing)
	l_s_Part			= dw_process.GetItemString(iRow, "workorder_detail_part")
	bDataMissing	= (f_get_value(dw_process.GetItemNumber(iRow, "workorder_detail_parts_per_cycle")) = 0)
	iRow ++
Loop

If bDataMissing then
	MessageBox("Warning", "Missing cavity setup (parts/cycle) for part " + szPart, StopSign!)
End If

//cb_save.enabled	= (Not bDataMissing)


end subroutine

public subroutine uf_get_process ();String szProcess

ddlb_process_id.Reset()

Declare ProcessCur Cursor for Select Id From Process Using sqlca;

Open ProcessCur;

Fetch ProcessCur into :szProcess;

Do while sqlca.sqlcode = 0
	ddlb_process_id.AddItem(szProcess)
	Fetch ProcessCur into :szProcess;
Loop

Close ProcessCur;
end subroutine

public subroutine uf_get_job_info ();Int i_rows

Select work_order.tool,   
       work_order.process_id,   
       work_order.cycle_time,   
       work_order.cycle_unit,
		 work_order.runtime
Into   :szTool,   
       :szProcessId,   
       :iCycleTime,   
       :szCycleUnit,  
		 :nRunTime
From   work_order  
Where  work_order.work_order = :szJob   ;

SELECT	WorkOrder_detail.Parts_Per_Hour,
			workorder_Detail.Parts_per_cycle
INTO		:i_PartsPerTime,
			:i_PartsPerCycle
FROM		WorkOrder_detail
WHERE		WorkOrder_detail.WorkOrder = :szjob;

sle_tool.text				= szTool
ddlb_process_id.text		= szProcessId
sle_runtime.text			= String(nRunTime)
sle_pred_runtime.text   = String(nRunTime)
sle_cycle_time.text		= String(iCycleTime)

If IsNull(szCycleUnit) OR szCycleUnit < '' Then
	ddlb_time.text    = "Hour"
	sle_cycle_time.text = '1'
Else
	ddlb_time.text    = szCycleUnit
End If
end subroutine

public subroutine uf_recalc_detail_runtime ();Long iRow
Long iTotalRows

Decimal nQtyRequired
Decimal nQtyCompleted
Decimal nPartsPerCycle
Decimal nPartsPerHour
Decimal l_n_RunTime
Decimal nMaxRunTime
Decimal l_i_Factor
Decimal ld_cycletime

String  l_s_Part
String  ls_cycleunit

//If Dec(sle_cycle_time.text) > 0 AND (ddlb_time.text > ' ') then
//   ls_cycleunit = ddlb_time.text
//	ld_cycletime = Dec(sle_cycle_time.text)

	nMaxRunTime	= 0
	dw_process.Accepttext()
	For iRow = 1 to dw_process.RowCount() 

		l_s_Part			= dw_process.GetItemString(iRow, "workorder_detail_part")
		nQtyRequired 	= f_get_value(dw_process.GetItemNumber(iRow, "workorder_detail_qty_required"))
		nQtyCompleted	= f_get_value(dw_process.GetItemNumber(iRow, "workorder_detail_qty_completed"))
//		nPartsPerCycle	= dw_process.GetItemNumber(iRow, "workorder_detail_parts_per_cycle")
//		if npartspercycle > 0 then 
//			npartsperhour = f_parts_per_hour(ls_cycleunit, npartspercycle, ld_cycletime)
//			dw_process.setitem(irow,"workorder_detail_parts_per_hour",npartsperhour)
//	   else
         nPartsPerHour	= dw_process.GetItemNumber(iRow, "workorder_detail_parts_per_hour")					
//		end if 	

      if npartsperhour = 0 then npartsperhour=1 
		
		l_n_RunTime		= (nQtyRequired - nQtyCompleted) * (1 / nPartsPerhour)

		If l_n_RunTime > nMaxRunTime then
			nMaxRunTime	= l_n_RunTime
		End If

	Next
//	sle_pred_runtime.text	= String(Truncate((nMaxRunTime*l_i_Factor),2))
	sle_pred_runtime.text	= String(Truncate((nMaxRunTime),2))	

//End If
	

end subroutine

public subroutine uf_update_job ();//  UPDATE workorder_detail  
//     SET run_time = :nRunTime,
//			parts_per_hour = :nPartsPerHour  
//   WHERE ( workorder = :szJob ) AND  
//         ( part = :szPart )   ;
//
//	If SQLCA.SQLCode = 0 then
//		Commit;
//	Else
//		Rollback;
//	End If
end subroutine

public subroutine uf_update_mps_assigned (string as_part);datastore	lds_mps
SQLCA.autocommit = TRUE
lds_mps = create datastore
lds_mps.DataObject = "d_msp_update_mps_assignedqty"	
lds_mps.SetTransObject ( sqlca )
lds_mps.Retrieve (as_part, 0)
SQLCA.autocommit = FALSE
if lds_mps.rowcount() > 0 then 
	if lds_mps.object.result[1] <> 0 then Messagebox(monsys.msg_title,'Unable to update mps assigned quantity')
else	
	Messagebox(monsys.msg_title,'Unable to update mps assigned quantity')			
end if 	
destroy lds_mps

end subroutine

on u_job_material_process.create
this.dw_workorder_header=create dw_workorder_header
this.st_1=create st_1
this.ddlb_process_id=create ddlb_process_id
this.st_2=create st_2
this.st_3=create st_3
this.sle_runtime=create sle_runtime
this.st_4=create st_4
this.ddlb_time=create ddlb_time
this.sle_tool=create sle_tool
this.st_5=create st_5
this.ddlb_lot_control=create ddlb_lot_control
this.st_7=create st_7
this.st_8=create st_8
this.sle_pred_runtime=create sle_pred_runtime
this.sle_cycle_time=create sle_cycle_time
this.dw_process=create dw_process
this.Control[]={this.dw_workorder_header,&
this.st_1,&
this.ddlb_process_id,&
this.st_2,&
this.st_3,&
this.sle_runtime,&
this.st_4,&
this.ddlb_time,&
this.sle_tool,&
this.st_5,&
this.ddlb_lot_control,&
this.st_7,&
this.st_8,&
this.sle_pred_runtime,&
this.sle_cycle_time,&
this.dw_process}
end on

on u_job_material_process.destroy
destroy(this.dw_workorder_header)
destroy(this.st_1)
destroy(this.ddlb_process_id)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_runtime)
destroy(this.st_4)
destroy(this.ddlb_time)
destroy(this.sle_tool)
destroy(this.st_5)
destroy(this.ddlb_lot_control)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.sle_pred_runtime)
destroy(this.sle_cycle_time)
destroy(this.dw_process)
end on

type dw_workorder_header from datawindow within u_job_material_process
int X=334
int Y=1472
int Width=494
int Height=360
int TabOrder=80
boolean Visible=false
string DataObject="dw_workorder_header_info"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type st_1 from statictext within u_job_material_process
int X=50
int Y=36
int Width=311
int Height=64
boolean Enabled=false
string Text="Process Id"
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

type ddlb_process_id from dropdownlistbox within u_job_material_process
int X=379
int Y=20
int Width=471
int Height=480
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_job_material_process
int X=50
int Y=164
int Width=247
int Height=72
boolean Enabled=false
string Text="Tool"
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

type st_3 from statictext within u_job_material_process
int X=37
int Y=292
int Width=311
int Height=148
boolean Enabled=false
string Text="Processed Run Time"
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

type sle_runtime from singlelineedit within u_job_material_process
int X=379
int Y=308
int Width=471
int Height=96
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
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

on modified;b_runtime = true

sle_pred_runtime.text = sle_runtime.text


end on

type st_4 from statictext within u_job_material_process
int X=887
int Y=24
int Width=297
int Height=72
boolean Enabled=false
string Text="Cycle Time"
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

type ddlb_time from dropdownlistbox within u_job_material_process
int X=1275
int Y=160
int Width=475
int Height=308
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Day",&
"Hour",&
"Minute",&
"Second"}
end type

event selectionchanged;If  		ddlb_time.text = "Day"  THEN
			sle_cycle_time.text	= String(1/(icycletime*24))

ELSEIF	ddlb_time.text = "Hour" THEN
			sle_cycle_time.text	= String(1/(icycletime))

ELSEIF	ddlb_time.text = "Minute" THEN
			sle_cycle_time.text	= String(1/(icycletime/60))

ELSE	
			ddlb_time.text = "Second"
			sle_cycle_time.text	= String(1/(icycletime/(60*60)))
End IF
	

uf_recalc_detail_runtime()


end event

type sle_tool from singlelineedit within u_job_material_process
int X=379
int Y=148
int Width=471
int Height=96
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
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

type st_5 from statictext within u_job_material_process
int X=896
int Y=276
int Width=293
int Height=128
boolean Enabled=false
string Text="Lot Control Activated"
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

type ddlb_lot_control from dropdownlistbox within u_job_material_process
int X=1275
int Y=296
int Width=471
int Height=208
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Yes",&
"No"}
end type

type st_7 from statictext within u_job_material_process
int X=887
int Y=152
int Width=270
int Height=72
boolean Enabled=false
string Text="Cycle Unit"
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

type st_8 from statictext within u_job_material_process
int X=37
int Y=456
int Width=320
int Height=124
boolean Enabled=false
string Text="Predicted Run Time"
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

type sle_pred_runtime from singlelineedit within u_job_material_process
int X=375
int Y=456
int Width=471
int Height=88
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
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

type sle_cycle_time from editmask within u_job_material_process
int X=1275
int Y=20
int Width=471
int Height=100
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.00"
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Integer iRow

Decimal nPartspertime

icycletime = Integer(sle_cycle_time.text)

If icycletime < 1 Then
		MessageBox("Error", "Cycle time cannot be lesser than one!", Stopsign!)
		sle_cycle_time.text = ''
		sle_cycle_time.SetFocus()
End If

For iRow = 1 to dw_process.RowCount()

	nPartspertime = dw_process.GetItemDecimal(iRow, "workorder_detail_parts_per_hour", &
							primary!, True )
	dw_process.SetItem(iRow, "workorder_detail_parts_per_hour", &
				f_parts_per_hour(ddlb_time.text, npartspertime, icycletime))

	uf_recalc_detail_runtime()

Next
					
end event

type dw_process from datawindow within u_job_material_process
int X=18
int Y=604
int Width=1737
int Height=728
int TabOrder=80
string DataObject="d_process_detail_info"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca ) 
end event

event itemchanged;dec ld_qtyr
dec ld_qtyc
string ls_part
id_qtyrequired_org = this.getitemdecimal(row,"workorder_detail_qty_required")
Choose Case dwo.name 
	Case "workorder_detail_parts_per_hour"
			i_partspertime = Dec(this.GetText())
			uf_recalc_detail_runtime()
	Case "workorder_detail_parts_per_cycle"
			this.SetItem(this.GetRow(), "workorder_detail_parts_per_hour", &
							 f_parts_per_hour(ddlb_time.text, &
							 						Dec(this.GetText()), &
													Integer(sle_cycle_time.text)))
			i_partspercycle = Dec(this.GetText())
			i_partspertime = Dec(this.GetText())
			uf_recalc_detail_runtime()
	Case "workorder_detail_qty_required"
		   ld_qtyr = Dec(this.Gettext())
			ld_qtyc = this.getitemdecimal(row,"workorder_detail_qty_completed")
			if  ld_qtyr < ld_qtyc then
				Messagebox(monsys.msg_title,"Required qty cannot be less than or equal to completed qty")
            this.setitem(row,"workorder_detail_qty_required",id_qtyrequired_org)	         															
				Return 1
			else	
            this.setitem(row,"workorder_detail_balance",(ld_qtyr - ld_qtyc))	         			
				ib_qtychanged = True 
				uf_recalc_detail_runtime()
			end if 	
End Choose		

//If this.GetColumnName() = "workorder_detail_parts_per_hour" Then
//
//	i_partspertime = Dec(this.GetText())
//	uf_recalc_detail_runtime()
//
//End If
//
//If this.GetColumnName()	= 'workorder_detail_parts_per_cycle' then
//
//	this.SetItem(this.GetRow(), "workorder_detail_parts_per_hour", &
//					 f_parts_per_hour(ddlb_time.text, &
//					 						Dec(this.GetText()), &
//											Integer(sle_cycle_time.text)))
//	i_partspercycle = Dec(this.GetText())
//	i_partspertime = Dec(this.GetText())
//	uf_recalc_detail_runtime()
//End If
end event

event itemerror;Return 1
end event

