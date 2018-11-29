$PBExportHeader$u_job_cost.sru
$PBExportComments$incomplete object..
forward
global type u_job_cost from UserObject
end type
type dw_1 from datawindow within u_job_cost
end type
end forward

global type u_job_cost from UserObject
int Width=3438
int Height=1452
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
dw_1 dw_1
end type
global u_job_cost u_job_cost

event ue_setup;this.dw_1.retrieve ( a_st_parm.value2 )
end event

on u_job_cost.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_job_cost.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_job_cost
int X=9
int Y=16
int Width=3397
int Height=1308
int TabOrder=10
string DataObject="d_cost_sheet_header"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

