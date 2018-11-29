$PBExportHeader$u_arrival_inquiry.sru
forward
global type u_arrival_inquiry from datawindow
end type
end forward

global type u_arrival_inquiry from datawindow
int Width=2889
int Height=1692
int TabOrder=10
string DataObject="d_rd_arrivals_inquiry"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type
global u_arrival_inquiry u_arrival_inquiry

event constructor;settransobject ( sqlca )
end event

