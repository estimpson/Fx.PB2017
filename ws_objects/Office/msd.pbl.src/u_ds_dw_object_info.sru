$PBExportHeader$u_ds_dw_object_info.sru
forward
global type u_ds_dw_object_info from u_ds_db_base
end type
end forward

global type u_ds_dw_object_info from u_ds_db_base
string DataObject="dw_object_info"
end type
global u_ds_dw_object_info u_ds_dw_object_info

on u_ds_dw_object_info.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_object_info.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

