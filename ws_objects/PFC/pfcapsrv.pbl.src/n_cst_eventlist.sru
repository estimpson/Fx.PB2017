$PBExportHeader$n_cst_eventlist.sru
forward
global type n_cst_eventlist from n_base
end type
end forward

global type n_cst_eventlist from n_base
end type
global n_cst_eventlist n_cst_eventlist

on n_cst_eventlist.create
TriggerEvent( this, "constructor" )
end on

on n_cst_eventlist.destroy
TriggerEvent( this, "destructor" )
end on

