$PBExportHeader$w_audit_trail_mst.srw
forward
global type w_audit_trail_mst from Window
end type
type dw_audit_trail from datawindow within w_audit_trail_mst
end type
end forward

global type w_audit_trail_mst from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_audit_trail dw_audit_trail
end type
global w_audit_trail_mst w_audit_trail_mst

on open;dw_audit_trail.SetTransObject(sqlca)
end on

on w_audit_trail_mst.create
this.dw_audit_trail=create dw_audit_trail
this.Control[]={ this.dw_audit_trail}
end on

on w_audit_trail_mst.destroy
destroy(this.dw_audit_trail)
end on

type dw_audit_trail from datawindow within w_audit_trail_mst
int X=531
int Y=49
int Width=494
int Height=361
int TabOrder=1
string DataObject="dw_audit_trail_mst"
boolean LiveScroll=true
end type

