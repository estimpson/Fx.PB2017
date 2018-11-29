$PBExportHeader$u_ds_base.sru
forward
global type u_ds_base from datastore
end type
end forward

global type u_ds_base from datastore
end type
global u_ds_base u_ds_base

on u_ds_base.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_base.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

