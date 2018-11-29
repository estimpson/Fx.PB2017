$PBExportHeader$u_nvo_dw_design.sru
forward
global type u_nvo_dw_design from nonvisualobject
end type
end forward

global type u_nvo_dw_design from nonvisualobject
end type
global u_nvo_dw_design u_nvo_dw_design

on u_nvo_dw_design.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_dw_design.destroy
TriggerEvent( this, "destructor" )
end on

