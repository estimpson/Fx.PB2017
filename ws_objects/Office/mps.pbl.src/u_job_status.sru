$PBExportHeader$u_job_status.sru
forward
global type u_job_status from UserObject
end type
type dw_qty_available from datawindow within u_job_status
end type
type dw_bill_of_material from datawindow within u_job_status
end type
type dw_work_order_detail from datawindow within u_job_status
end type
type dw_mat_issue from datawindow within u_job_status
end type
type dw_defect from datawindow within u_job_status
end type
type dw_jobcomp from datawindow within u_job_status
end type
type dw_downtime from datawindow within u_job_status
end type
type st_5 from statictext within u_job_status
end type
type st_standard from statictext within u_job_status
end type
type st_operator_hour from statictext within u_job_status
end type
type st_down_time from statictext within u_job_status
end type
type st_occurences from statictext within u_job_status
end type
type st_material_index from statictext within u_job_status
end type
type st_completion from statictext within u_job_status
end type
type sle_standard from singlelineedit within u_job_status
end type
type sle_completion from singlelineedit within u_job_status
end type
type sle_material_index from singlelineedit within u_job_status
end type
type sle_down_time from singlelineedit within u_job_status
end type
type sle_occurences from singlelineedit within u_job_status
end type
type sle_operator from singlelineedit within u_job_status
end type
type st_1 from statictext within u_job_status
end type
type st_7 from statictext within u_job_status
end type
type st_predicted from statictext within u_job_status
end type
type sle_predicted from singlelineedit within u_job_status
end type
type st_9 from statictext within u_job_status
end type
type st_actual from statictext within u_job_status
end type
type sle_actual from singlelineedit within u_job_status
end type
type st_2 from statictext within u_job_status
end type
type st_11 from statictext within u_job_status
end type
type st_12 from statictext within u_job_status
end type
type st_comp from statictext within u_job_status
end type
type st_13 from statictext within u_job_status
end type
type st_4 from statictext within u_job_status
end type
type st_3 from statictext within u_job_status
end type
type st_14 from statictext within u_job_status
end type
type gb_1 from groupbox within u_job_status
end type
type gb_2 from groupbox within u_job_status
end type
type gb_3 from groupbox within u_job_status
end type
type gb_4 from groupbox within u_job_status
end type
type gb_5 from groupbox within u_job_status
end type
type gb_6 from groupbox within u_job_status
end type
end forward

global type u_job_status from UserObject
int Width=1829
int Height=1304
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
dw_qty_available dw_qty_available
dw_bill_of_material dw_bill_of_material
dw_work_order_detail dw_work_order_detail
dw_mat_issue dw_mat_issue
dw_defect dw_defect
dw_jobcomp dw_jobcomp
dw_downtime dw_downtime
st_5 st_5
st_standard st_standard
st_operator_hour st_operator_hour
st_down_time st_down_time
st_occurences st_occurences
st_material_index st_material_index
st_completion st_completion
sle_standard sle_standard
sle_completion sle_completion
sle_material_index sle_material_index
sle_down_time sle_down_time
sle_occurences sle_occurences
sle_operator sle_operator
st_1 st_1
st_7 st_7
st_predicted st_predicted
sle_predicted sle_predicted
st_9 st_9
st_actual st_actual
sle_actual sle_actual
st_2 st_2
st_11 st_11
st_12 st_12
st_comp st_comp
st_13 st_13
st_4 st_4
st_3 st_3
st_14 st_14
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
end type
global u_job_status u_job_status

type variables
Long iRunTimeX = 572              //X pos for runtime bar
Long iRunTimeY = 121              //Y pos for runtime bar
Long iMaxWidth = 2926            //Width of the whole screen
Long iBoxHeight = 65               //Height of each box
Long iMaxBoxes = 40               //Max no of boxes showing on screen
Long iDownTimeCount              //Count for down time
Long iDefectCount                   //Count for defect
Long iJobCompCount                //Count for job completion
Long iOperatorCount                 //Count for operator
Long iMaxJobComp    = 100       //Max no of boxes for job comp objects
Long iMaxDownTime  = 40         //Max no for downtime objects
Long iMaxDefect       = 40        //Max no for defect objects
Long iJobCompInitX   = 1          //Initial pos for job completion
Long iJobCompInitY   = 321       //Initial Y pos for job completion
Long iDownInitX        = 1          //Initial X pos for down time bar
Long iDownInitY        = 521       //Initial Y pos for down time bar
Long iDefectInitX       = 1          //Initial X pos for defect bar
Long iDefectInitY       = 721       //Initial Y pos for defect bar
Long iHourWidth        = 65         //Width for block with hour
Long iCurrentPos                       //Current pos for drawing block
Long iOperatorInitY    = 921        //Initial Y pos for operator

Decimal nJobCompHour              //Hours for job completion
Decimal nDefectHour                 //Hours for defect
Decimal nDownHour                   //Hours for down time
Decimal nOperatorHour               //Hours for operator
Decimal nCycleTime                    //Cycle Time
Decimal nStdRunTime	      //Std run time
Decimal nMatIssueHour	      //Mat issue time
Decimal nOccurences	      //# of defect Occurences
Decimal nqtydone		      // qty completed

Rectangle JobCompList[100]      //List of all jobcomp objects
Rectangle DownTimeList[40]      //List of all downtime objects
Rectangle DefectList[40]           //List of all defect objects
Rectangle OperatorList[10]        //List of all operators

Line LineList[40]                       //List of lines

String szJob                             //Current job number
String szCycleUnit                     //Cycle unit

str_progress stParm		    //Parm for w_progress
end variables

forward prototypes
public subroutine uf_draw_graph (string as_type, decimal an_value)
public subroutine uf_build_comm_set ()
public function decimal uf_defect_occurences (string as_job)
public function decimal uf_get_accum_runtime (string as_job)
public function decimal uf_get_job_comp_percentage (string as_job)
public function decimal uf_get_material_used (string as_job, string as_part)
public function decimal uf_material_yield_index ()
public function decimal uf_total_downtime_hour (string as_job)
public function decimal uf_get_laborhours (string as_job)
end prototypes

event ue_setup;Decimal l_n_Runtime			//Hours of runtime
Decimal l_n_downtime			//Hours of downtime
Decimal l_n_Occurrences		//Occurences for the defects
Decimal l_n_MatIndex			//Index percentage for material issue
Decimal l_n_Percentage		//Percentage completed
Decimal l_n_Occurences		//Total defect occurences
Decimal ld_laborhours      //labor hours

szJob			= a_st_parm.value2

l_n_Runtime		= f_job_runtime(szJob, 2)		//Draw standard job time
nStdRunTime		= l_n_Runtime
uf_draw_graph("STANDARD", l_n_Runtime)

l_n_Runtime		= f_job_runtime(szJob, 1)		//Draw predicted job time
uf_draw_graph("PREDICTED", l_n_Runtime)

l_n_Runtime		= uf_get_accum_runtime(szJob)
uf_draw_graph("ACTUAL", l_n_Runtime)

dw_jobcomp.Retrieve(szJob, "J")
l_n_Percentage	= uf_get_job_comp_percentage(szJob)
uf_draw_graph("JOB COMP", l_n_Percentage)

dw_downtime.Retrieve(szJob)
l_n_downtime	= uf_total_downtime_hour(szJob)
uf_draw_graph("DOWN TIME", l_n_downtime)

dw_defect.Retrieve(szJob)
l_n_Occurences	= f_get_value(uf_defect_occurences(szJob))
uf_draw_graph("DEFECT", l_n_Occurences)

uf_build_comm_set()
l_n_MatIndex	= uf_material_yield_index()
uf_draw_graph("MAT ISSUE", l_n_MatIndex)

ld_laborhours = uf_get_laborhours(szjob)
uf_draw_graph("OPERATOR", ld_laborhours)

end event

public subroutine uf_draw_graph (string as_type, decimal an_value);Choose Case as_type

	Case "STANDARD"
		st_standard.text		= String(Truncate(an_Value, 2))

	Case "PREDICTED"
		st_predicted.text		= String(Truncate(an_Value, 2))
		sle_predicted.visible= FALSE
		sle_predicted.width	= 0
		If nStdRunTime > 0 then
			sle_predicted.width	= sle_standard.width * an_Value / nStdRunTime
		End If
		sle_predicted.visible= TRUE

	Case "ACTUAL"
		st_actual.text			= String(Truncate(an_Value, 2))
		sle_actual.visible	= FALSE
		sle_actual.width		= 0
		If nStdRunTime > 0 then
			sle_actual.width		= sle_standard.width * an_Value / nStdRunTime
		End If
		sle_actual.visible	= TRUE

	Case "JOB COMP"
		sle_completion.visible 	= FALSE
		sle_completion.width		= 0
		sle_completion.width		= sle_standard.width * (an_Value / 100)
		sle_completion.visible	= TRUE
		st_completion.text		= String(Truncate(an_Value, 2)) + "%"

	Case "MAT ISSUE"
		st_material_index.text		= String(Truncate(100 * an_Value, 2)) + "%"
		sle_material_index.visible	= FALSE
		sle_material_index.width	= 0
		sle_material_index.width	= sle_standard.width * an_Value
		sle_material_index.visible	= TRUE

	Case "OPERATOR"
		st_operator_hour.text = String(Truncate(an_value,2))
		sle_operator.visible = False
		sle_operator.width = 0 
		sle_operator.width = sle_standard.width * an_value
		sle_operator.visible = True

	Case "DEFECT"
		st_occurences.text	= String(Truncate(an_Value,0))
		sle_Occurences.visible = FALSE
		SELECT 	workorder_detail.qty_completed
		INTO		:nqtydone
		FROM		workorder_detail
		WHERE		workorder_detail.workorder=:szjob;
		If an_Value > 0 then
			sle_Occurences.width = sle_standard.width * (an_Value/(an_Value + nqtydone))
		sle_Occurences.visible = TRUE
		End If
	
	Case "DOWN TIME"
		st_down_time.text		= String(Truncate(an_Value, 2))
		sle_down_time.visible= FALSE
		sle_down_time.width	= 0
		If nStdRunTime > 0 then
			sle_down_time.width	= sle_standard.width * (an_Value / nStdRuntime)
		End If
		sle_down_time.visible= TRUE

End Choose

end subroutine

public subroutine uf_build_comm_set ();//***********************************************************************
//* Declaration
//***********************************************************************
Long iRow					//To keep the current row number
Long iTotalRows			//To keep the total number of rows in current datawindow
Long iComponentRow		//To keep the current row number in bill of material
Long iComponentTotalRows//To keep the total row # in BOM datawindow
Long iCount					//To keep the row count number
Long iTotal

String  szDescription	//To keep the part description
String  szComponent		//To keep the component
String  szType				//To keep the type of the part
String  szPart				//To keep the part number


Decimal nOnHand			//To keep the onhand quantity
Decimal nqtyC  			//To keep the qty required in work order detail
Decimal nqtyRequired		//To keep the qty required in work order detail
Decimal nComponentQty	//To keep the qty in bill of material
Decimal nQtycompleted   //To keep the qty

//***********************************************************************
//* Initialization
//***********************************************************************

dw_qty_available.Reset()
dw_qty_available.Modify("balance.color = '0~tif(balance > 0, 65280, 255)'")

//***********************************************************************
//* Main Routine
//***********************************************************************
dw_work_order_detail.Retrieve(szJob)

iTotalRows	= dw_work_order_detail.RowCount()

For iRow = 1 to iTotalRows

	szPart	= dw_work_order_detail.GetItemString(iRow, "part")
	nQtyC = f_get_value(dw_work_order_detail.GetItemNumber(iRow, "qty_completed"))
	nQtyRequired = f_get_value(dw_work_order_detail.GetItemNumber(iRow, "qty_required"))	

	dw_bill_of_material.Retrieve(szPart)
	iComponentTotalRows	= dw_bill_of_material.RowCount()

	For iComponentRow	= 1 to iComponentTotalRows

		szComponent		= dw_bill_of_material.GetItemString(iComponentRow, "part")
		szDescription	= f_get_part_info(szComponent, "NAME")
		szType			= f_get_part_info(szComponent, "CLASS")
		nComponentQty	= dw_bill_of_material.GetItemNumber(iComponentRow, "quantity")

		iCount			= dw_qty_available.Find("part = '" + szComponent + "'", 1, 99999)

   	If iCount > 0 then
			nqtyc	= dw_qty_available.GetItemNumber(iCount, "QtyRequired")
			nqtycompleted	= nqtycompleted + (nQtyc * nComponentQty)
		Else
			dw_qty_available.InsertRow(1)
			dw_qty_available.SetItem(1, "Part", szComponent)
			dw_qty_available.SetItem(1, "description", szDescription)
			dw_qty_available.SetItem(1, "type", szType)
			nqtycompleted	= (nQtyc * nComponentQty)
			iCount		= 1
		End If
		
		dw_qty_available.SetItem(iCount, "QtyRequired", nqtycompleted)
		dw_qty_available.SetItem(iCount, "Balance", nqtyRequired)		

	Next

Next

iTotalRows	= dw_qty_available.RowCount()
//For iRow = 1 to iTotalRows
//	szPart 	= dw_qty_available.GetItemString(iRow, "part")
////	dw_qty_available.SetItem(iRow, "Balance", wf_get_material_used(szJob, szPart))
//Next

				
end subroutine

public function decimal uf_defect_occurences (string as_job);Decimal l_n_Qty

SELECT sum(defects.quantity )  
  INTO :l_n_Qty  
  FROM defects  
 WHERE defects.work_order = :as_Job   ;

Return l_n_Qty
end function

public function decimal uf_get_accum_runtime (string as_job);Decimal l_n_AccumRunTime

SELECT work_order.accum_run_time  
  INTO :l_n_AccumRunTime  
  FROM work_order  
 WHERE work_order.work_order = :as_Job   ;

Return l_n_AccumRunTime
end function

public function decimal uf_get_job_comp_percentage (string as_job);//************************************************************************
//* Declaration
//************************************************************************
Decimal	nQtyRequired		//Qty required
Decimal	nQtyCompleted		//Qty completed
Decimal	nPercentage			//Current percentage
Decimal	nAverage				//Average percentage

Integer	iCount				//Count number

//************************************************************************
//* Initialization
//************************************************************************

DECLARE 	JobDetailCur CURSOR FOR  
SELECT 	qty_required, qty_completed  
FROM 		workorder_detail 
WHERE  	workorder = :as_job;

iCount	= 0
nAverage	= 0

//************************************************************************
//* Main Routine
//************************************************************************


Open JobDetailCur;

Fetch JobDetailCur into :nQtyRequired, :nQtyCompleted;

Do while sqlca.sqlcode = 0

	iCount ++
	If nQtyRequired > 0 then
		nAverage	= nAverage + (100 * nQtyCompleted / nQtyRequired)
	End If	

	Fetch JobDetailCur into :nQtyRequired, :nQtyCompleted;
Loop

Close JobDetailCur;

IF iCount > 0 THEN
	RETURN (nAverage / iCount)
ELSE
	RETURN 0
END IF




end function

public function decimal uf_get_material_used (string as_job, string as_part);Decimal l_n_Qty

Select sum(audit_trail.std_quantity )  
  Into :l_n_Qty  
  From  audit_trail  
 Where ( audit_trail.workorder = :as_Job ) And  
       ( audit_trail.part = :as_Part )   ;

Return l_n_Qty
end function

public function decimal uf_material_yield_index ();Long iRow
Long iTotalRows

Decimal nIndex
Decimal nQtyRequired
Decimal nQtyUsed

nIndex		= 0
iTotalRows	= dw_qty_available.RowCount()
For iRow = 1 to iTotalRows

// balance field stores the total quantity required or on the work order
// qtyrequired field stored the quantity completed out the total work order qty

	nQtyRequired	= f_get_value(dw_qty_available.GetItemNumber(iRow, "Balance"))
	nQtyUsed			= f_get_value(dw_qty_available.GetItemNumber(iRow, "QtyRequired"))
	
	If nQtyRequired > 0 then
		nIndex		= nIndex + (nQtyUsed / nQtyRequired)
	End If
Next

If iTotalRows > 0 then
	nIndex	= nIndex / iTotalRows
End If

Return nIndex
end function

public function decimal uf_total_downtime_hour (string as_job);Decimal l_n_DownTime

SELECT sum(downtime.down_time )  
  INTO :l_n_DownTime  
  FROM downtime  
 WHERE downtime.job = :as_Job   ;

Return l_n_DownTime
end function

public function decimal uf_get_laborhours (string as_job);Decimal ld_lbrhours

SELECT sum(labor_hours)  
  INTO :ld_lbrhours
  FROM shop_floor_time_log
 WHERE work_order = :as_Job   ;

Return ld_lbrhours
end function

on u_job_status.create
this.dw_qty_available=create dw_qty_available
this.dw_bill_of_material=create dw_bill_of_material
this.dw_work_order_detail=create dw_work_order_detail
this.dw_mat_issue=create dw_mat_issue
this.dw_defect=create dw_defect
this.dw_jobcomp=create dw_jobcomp
this.dw_downtime=create dw_downtime
this.st_5=create st_5
this.st_standard=create st_standard
this.st_operator_hour=create st_operator_hour
this.st_down_time=create st_down_time
this.st_occurences=create st_occurences
this.st_material_index=create st_material_index
this.st_completion=create st_completion
this.sle_standard=create sle_standard
this.sle_completion=create sle_completion
this.sle_material_index=create sle_material_index
this.sle_down_time=create sle_down_time
this.sle_occurences=create sle_occurences
this.sle_operator=create sle_operator
this.st_1=create st_1
this.st_7=create st_7
this.st_predicted=create st_predicted
this.sle_predicted=create sle_predicted
this.st_9=create st_9
this.st_actual=create st_actual
this.sle_actual=create sle_actual
this.st_2=create st_2
this.st_11=create st_11
this.st_12=create st_12
this.st_comp=create st_comp
this.st_13=create st_13
this.st_4=create st_4
this.st_3=create st_3
this.st_14=create st_14
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.Control[]={this.dw_qty_available,&
this.dw_bill_of_material,&
this.dw_work_order_detail,&
this.dw_mat_issue,&
this.dw_defect,&
this.dw_jobcomp,&
this.dw_downtime,&
this.st_5,&
this.st_standard,&
this.st_operator_hour,&
this.st_down_time,&
this.st_occurences,&
this.st_material_index,&
this.st_completion,&
this.sle_standard,&
this.sle_completion,&
this.sle_material_index,&
this.sle_down_time,&
this.sle_occurences,&
this.sle_operator,&
this.st_1,&
this.st_7,&
this.st_predicted,&
this.sle_predicted,&
this.st_9,&
this.st_actual,&
this.sle_actual,&
this.st_2,&
this.st_11,&
this.st_12,&
this.st_comp,&
this.st_13,&
this.st_4,&
this.st_3,&
this.st_14,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.gb_6}
end on

on u_job_status.destroy
destroy(this.dw_qty_available)
destroy(this.dw_bill_of_material)
destroy(this.dw_work_order_detail)
destroy(this.dw_mat_issue)
destroy(this.dw_defect)
destroy(this.dw_jobcomp)
destroy(this.dw_downtime)
destroy(this.st_5)
destroy(this.st_standard)
destroy(this.st_operator_hour)
destroy(this.st_down_time)
destroy(this.st_occurences)
destroy(this.st_material_index)
destroy(this.st_completion)
destroy(this.sle_standard)
destroy(this.sle_completion)
destroy(this.sle_material_index)
destroy(this.sle_down_time)
destroy(this.sle_occurences)
destroy(this.sle_operator)
destroy(this.st_1)
destroy(this.st_7)
destroy(this.st_predicted)
destroy(this.sle_predicted)
destroy(this.st_9)
destroy(this.st_actual)
destroy(this.sle_actual)
destroy(this.st_2)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_comp)
destroy(this.st_13)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_14)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
end on

type dw_qty_available from datawindow within u_job_status
int X=754
int Y=1644
int Width=329
int Height=352
int TabOrder=70
boolean Visible=false
string DataObject="dw_external_qty_available"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_bill_of_material from datawindow within u_job_status
int X=384
int Y=1644
int Width=347
int Height=352
int TabOrder=60
boolean Visible=false
string DataObject="dw_bill_of_material_qty_available"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_work_order_detail from datawindow within u_job_status
int X=37
int Y=1644
int Width=329
int Height=352
int TabOrder=50
boolean Visible=false
string DataObject="dw_workorder_detail"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_mat_issue from datawindow within u_job_status
int X=1097
int Y=1260
int Width=347
int Height=352
int TabOrder=130
boolean Visible=false
string DataObject="dw_material_issue_for_job"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_defect from datawindow within u_job_status
int X=750
int Y=1260
int Width=325
int Height=360
int TabOrder=120
boolean Visible=false
boolean Enabled=false
string DataObject="dw_defects_in_job"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_jobcomp from datawindow within u_job_status
int X=384
int Y=1260
int Width=343
int Height=360
int TabOrder=110
boolean Visible=false
string DataObject="dw_jobcomp_for_workorder"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_downtime from datawindow within u_job_status
int X=37
int Y=1260
int Width=329
int Height=360
int TabOrder=100
boolean Visible=false
string DataObject="dw_downtime_in_job"
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type st_5 from statictext within u_job_status
int X=73
int Y=1072
int Width=219
int Height=64
string Text="Time Log"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//dw_1.DataObject 	= "dw_operator_for_workorder"
//dw_1.SetTransObject(sqlca)
//dw_1.Retrieve(szJob, "L")
//dw_1.Visible		= TRUE
//dw_workorder_header.visible	= false
//dw_workorder_detail.visible	= false
end on

type st_standard from statictext within u_job_status
int X=302
int Y=112
int Width=247
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_operator_hour from statictext within u_job_status
int X=338
int Y=1072
int Width=219
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_down_time from statictext within u_job_status
int X=338
int Y=900
int Width=247
int Height=72
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_occurences from statictext within u_job_status
int X=338
int Y=736
int Width=247
int Height=72
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_material_index from statictext within u_job_status
int X=338
int Y=584
int Width=247
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_completion from statictext within u_job_status
int X=338
int Y=416
int Width=247
int Height=64
boolean Enabled=false
string Text="0 %"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_standard from singlelineedit within u_job_status
int X=635
int Y=112
int Width=1024
int Height=64
int TabOrder=10
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=8388608
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_completion from singlelineedit within u_job_status
int X=635
int Y=416
int Width=823
int Height=64
int TabOrder=170
boolean AutoHScroll=false
long TextColor=65280
long BackColor=65280
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_material_index from singlelineedit within u_job_status
int X=635
int Y=584
int Width=768
int Height=64
int TabOrder=150
boolean AutoHScroll=false
long TextColor=16776960
long BackColor=16776960
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_down_time from singlelineedit within u_job_status
int X=635
int Y=900
int Width=677
int Height=64
int TabOrder=80
boolean AutoHScroll=false
long TextColor=255
long BackColor=255
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_occurences from singlelineedit within u_job_status
int X=635
int Y=736
int Width=731
int Height=64
int TabOrder=70
boolean AutoHScroll=false
long TextColor=255
long BackColor=0
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_operator from singlelineedit within u_job_status
int X=645
int Y=1072
int Width=73
int Height=64
int TabOrder=40
boolean AutoHScroll=false
long TextColor=255
long BackColor=65535
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_job_status
int X=82
int Y=112
int Width=201
int Height=56
boolean Enabled=false
string Text="Standard"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within u_job_status
int X=82
int Y=168
int Width=201
int Height=48
boolean Enabled=false
string Text="Predicted"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_predicted from statictext within u_job_status
int X=302
int Y=176
int Width=247
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_predicted from singlelineedit within u_job_status
int X=635
int Y=176
int Width=951
int Height=64
int TabOrder=30
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=32896
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within u_job_status
int X=82
int Y=232
int Width=201
int Height=48
boolean Enabled=false
string Text="Actual"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_actual from statictext within u_job_status
int X=302
int Y=240
int Width=247
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_actual from singlelineedit within u_job_status
int X=635
int Y=240
int Width=896
int Height=64
int TabOrder=190
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=8388736
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_job_status
int X=562
int Y=112
int Width=73
int Height=64
boolean Enabled=false
string Text="hrs"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within u_job_status
int X=562
int Y=176
int Width=73
int Height=64
boolean Enabled=false
string Text="hrs"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within u_job_status
int X=562
int Y=240
int Width=73
int Height=64
boolean Enabled=false
string Text="hrs"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_comp from statictext within u_job_status
int X=73
int Y=416
int Width=256
int Height=48
string Text="Completion"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within u_job_status
int X=73
int Y=584
int Width=219
int Height=64
boolean Enabled=false
string Text="Index %"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_job_status
int X=73
int Y=736
int Width=238
int Height=64
boolean Enabled=false
string Text="Occur."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_job_status
int X=73
int Y=900
int Width=256
int Height=64
boolean Enabled=false
string Text="Down Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within u_job_status
int X=571
int Y=1072
int Width=73
int Height=64
boolean Enabled=false
string Text="hrs"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77971394
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within u_job_status
int X=46
int Y=52
int Width=1650
int Height=288
int TabOrder=20
string Text="Run Time"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within u_job_status
int X=46
int Y=360
int Width=1650
int Height=128
int TabOrder=200
string Text="Job Completion"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within u_job_status
int X=46
int Y=536
int Width=1650
int Height=128
int TabOrder=180
string Text="Material Issue"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77971394
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within u_job_status
int X=46
int Y=688
int Width=1650
int Height=128
int TabOrder=160
string Text="Defects"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within u_job_status
int X=46
int Y=844
int Width=1650
int Height=144
int TabOrder=90
string Text="Down Time"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within u_job_status
int X=55
int Y=1016
int Width=1650
int Height=148
int TabOrder=140
string Text="Operator"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

