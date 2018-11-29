$PBExportHeader$u_ds_dw_list_of_releases_sd.sru
forward
global type u_ds_dw_list_of_releases_sd from u_ds_db_base
end type
end forward

global type u_ds_dw_list_of_releases_sd from u_ds_db_base
string DataObject="dw_list_of_releases_sd"
end type
global u_ds_dw_list_of_releases_sd u_ds_dw_list_of_releases_sd

on u_ds_dw_list_of_releases_sd.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_list_of_releases_sd.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

