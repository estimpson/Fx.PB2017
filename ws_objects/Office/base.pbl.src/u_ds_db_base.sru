$PBExportHeader$u_ds_db_base.sru
forward
global type u_ds_db_base from u_ds_base
end type
end forward

global type u_ds_db_base from u_ds_base
end type
global u_ds_db_base u_ds_db_base

event constructor;SetTransObject ( SQLCA )
end event

on u_ds_db_base.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_db_base.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

