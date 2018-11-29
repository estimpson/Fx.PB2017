$PBExportHeader$w_generate_job_cost_report.srw
$PBExportComments$window for the job cost sheet
forward
global type w_generate_job_cost_report from Window
end type
type dw_bom from datawindow within w_generate_job_cost_report
end type
type dw_external2 from datawindow within w_generate_job_cost_report
end type
type dw_total_hours from datawindow within w_generate_job_cost_report
end type
type dw_start_end_time from datawindow within w_generate_job_cost_report
end type
type dw_header from datawindow within w_generate_job_cost_report
end type
type r_1 from rectangle within w_generate_job_cost_report
end type
type dw_external from datawindow within w_generate_job_cost_report
end type
type dw_machine_hours from datawindow within w_generate_job_cost_report
end type
type dw_external3 from datawindow within w_generate_job_cost_report
end type
end forward

global type w_generate_job_cost_report from Window
int X=5
int Y=4
int Width=4238
int Height=2336
boolean TitleBar=true
string Title="Job Cost Sheet "
string MenuName="m_generate_report"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_generate ( )
event ue_print ( )
dw_bom dw_bom
dw_external2 dw_external2
dw_total_hours dw_total_hours
dw_start_end_time dw_start_end_time
dw_header dw_header
r_1 r_1
dw_external dw_external
dw_machine_hours dw_machine_hours
dw_external3 dw_external3
end type
global w_generate_job_cost_report w_generate_job_cost_report

type variables
STRING    i_s_workorder, &
                 i_s_machine

end variables

event ue_generate;dw_header.retrieve ( i_s_workorder )
dw_start_end_time.retrieve ( i_s_workorder )
dw_total_hours.retrieve ( i_s_workorder, i_s_machine )
dw_machine_hours.retrieve ( i_s_machine, i_s_workorder )
dw_external.Insertrow(0)
dw_external2.Insertrow(0)
end event

event ue_print;long Job
Job = PrintOpen()
this.Print(Job, 0, 0)
PrintClose(Job)
end event

on w_generate_job_cost_report.create
if this.MenuName = "m_generate_report" then this.MenuID = create m_generate_report
this.dw_bom=create dw_bom
this.dw_external2=create dw_external2
this.dw_total_hours=create dw_total_hours
this.dw_start_end_time=create dw_start_end_time
this.dw_header=create dw_header
this.r_1=create r_1
this.dw_external=create dw_external
this.dw_machine_hours=create dw_machine_hours
this.dw_external3=create dw_external3
this.Control[]={this.dw_bom,&
this.dw_external2,&
this.dw_total_hours,&
this.dw_start_end_time,&
this.dw_header,&
this.r_1,&
this.dw_external,&
this.dw_machine_hours,&
this.dw_external3}
end on

on w_generate_job_cost_report.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_bom)
destroy(this.dw_external2)
destroy(this.dw_total_hours)
destroy(this.dw_start_end_time)
destroy(this.dw_header)
destroy(this.r_1)
destroy(this.dw_external)
destroy(this.dw_machine_hours)
destroy(this.dw_external3)
end on

event activate;IF this.MenuName <> 'm_generate_report' THEN this.Changemenu ( m_generate_report )
end event

event open;i_s_workorder = Message.StringParm

SELECT machine_no
INTO   :i_s_machine
FROM   work_order
WHERE  work_order = :i_s_workorder;

IF SQLCA.SQLCODE <> 0 THEN
      MESSAGEBOX ( 'System Message', 'Enter a valid work order!' )	
      RETURN
ELSE
      TRIGGEREVENT ( "ue_generate" )
END IF

end event

type dw_bom from datawindow within w_generate_job_cost_report
int X=46
int Y=372
int Width=4123
int Height=588
string DataObject="d_temp"
boolean Border=false
boolean LiveScroll=true
end type

type dw_external2 from datawindow within w_generate_job_cost_report
int X=1861
int Y=976
int Width=1088
int Height=664
string DataObject="d_external2"
boolean Border=false
boolean LiveScroll=true
end type

type dw_total_hours from datawindow within w_generate_job_cost_report
int X=46
int Y=1064
int Width=960
int Height=496
string DataObject="d_machine_total_hours"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SETTRANSOBJECT ( SQLCA )
end event

type dw_start_end_time from datawindow within w_generate_job_cost_report
int X=46
int Y=956
int Width=2089
int Height=96
string DataObject="d_start_end_time"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SETTRANSOBJECT ( SQLCA )
end event

type dw_header from datawindow within w_generate_job_cost_report
int X=46
int Y=24
int Width=4128
int Height=356
string DataObject="d_cost_sheet_header"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SETTRANSOBJECT ( SQLCA )
end event

type r_1 from rectangle within w_generate_job_cost_report
int X=32
int Y=16
int Width=4151
int Height=2124
boolean Enabled=false
int LineThickness=8
long LineColor=8421504
long FillColor=16777215
end type

type dw_external from datawindow within w_generate_job_cost_report
int X=46
int Y=1668
int Width=4114
int Height=428
string DataObject="d_external1"
boolean Border=false
boolean LiveScroll=true
end type

type dw_machine_hours from datawindow within w_generate_job_cost_report
int X=955
int Y=1056
int Width=910
int Height=524
boolean BringToTop=true
string DataObject="d_machine_hours"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SETTRANSOBJECT ( SQLCA )
end event

type dw_external3 from datawindow within w_generate_job_cost_report
int X=2953
int Y=980
int Width=1216
int Height=648
string DataObject="d_external3"
boolean Border=false
boolean LiveScroll=true
end type

