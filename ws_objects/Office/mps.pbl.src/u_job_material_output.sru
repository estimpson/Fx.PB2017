﻿$PBExportHeader$u_job_material_output.sru
forward
global type u_job_material_output from UserObject
end type
type dw_1 from datawindow within u_job_material_output
end type
end forward

global type u_job_material_output from UserObject
int Width=3401
int Height=1452
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
dw_1 dw_1
end type
global u_job_material_output u_job_material_output

event ue_setup;this.dw_1.retrieve ( a_st_parm.value2 )
end event

on u_job_material_output.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_job_material_output.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_job_material_output
int X=23
int Y=16
int Width=2683
int Height=1320
int TabOrder=10
string DataObject="dw_workorder_detail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event
