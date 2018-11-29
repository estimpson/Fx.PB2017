$PBExportHeader$u_ds_d_update_onhand.sru
forward
global type u_ds_d_update_onhand from u_ds_db_base
end type
end forward

global type u_ds_d_update_onhand from u_ds_db_base
string DataObject="d_update_onhand"
end type
global u_ds_d_update_onhand u_ds_d_update_onhand

on u_ds_d_update_onhand.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_d_update_onhand.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

