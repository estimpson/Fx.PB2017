$PBExportHeader$u_ds_dw_view_release_detail.sru
forward
global type u_ds_dw_view_release_detail from u_ds_db_base
end type
end forward

global type u_ds_dw_view_release_detail from u_ds_db_base
string DataObject="dw_view_release_detail_sd"
end type
global u_ds_dw_view_release_detail u_ds_dw_view_release_detail

on u_ds_dw_view_release_detail.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_view_release_detail.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

