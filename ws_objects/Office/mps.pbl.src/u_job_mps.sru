$PBExportHeader$u_job_mps.sru
forward
global type u_job_mps from UserObject
end type
type dw_mps from datawindow within u_job_mps
end type
end forward

global type u_job_mps from UserObject
int Width=3438
int Height=1452
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
dw_mps dw_mps
end type
global u_job_mps u_job_mps

event ue_setup;this.dw_mps.Retrieve(a_st_parm.value2)
end event

on u_job_mps.create
this.dw_mps=create dw_mps
this.Control[]={this.dw_mps}
end on

on u_job_mps.destroy
destroy(this.dw_mps)
end on

type dw_mps from datawindow within u_job_mps
int X=18
int Y=12
int Width=2651
int Height=1304
int TabOrder=10
string DataObject="d_mps_per_workorder"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

