$PBExportHeader$u_ds_msp_createinsertedrelease.sru
forward
global type u_ds_msp_createinsertedrelease from datastore
end type
end forward

global type u_ds_msp_createinsertedrelease from datastore
string DataObject="d_msp_createinsertedrelease"
end type
global u_ds_msp_createinsertedrelease u_ds_msp_createinsertedrelease

on u_ds_msp_createinsertedrelease.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_msp_createinsertedrelease.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetTransObject ( SQLCA )
end event

