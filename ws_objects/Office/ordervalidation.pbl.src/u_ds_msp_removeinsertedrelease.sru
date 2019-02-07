$PBExportHeader$u_ds_msp_removeinsertedrelease.sru
forward
global type u_ds_msp_removeinsertedrelease from datastore
end type
end forward

global type u_ds_msp_removeinsertedrelease from datastore
string DataObject="d_msp_removeinsertedrelease"
end type
global u_ds_msp_removeinsertedrelease u_ds_msp_removeinsertedrelease

on u_ds_msp_removeinsertedrelease.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_msp_removeinsertedrelease.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetTransObject ( SQLCA )
end event

