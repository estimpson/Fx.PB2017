$PBExportHeader$uo_pipeline.sru
forward
global type uo_pipeline from pipeline
end type
end forward

global type uo_pipeline from pipeline
end type
global uo_pipeline uo_pipeline

type variables
window	iw_ParentWindow
end variables

event pipemeter;//monitor.greal_TimerCurrent = RowsRead
end event

event pipeend;//monitor.greal_TimerCurrent = RowsRead
end event

on uo_pipeline.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on uo_pipeline.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

