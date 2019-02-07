$PBExportHeader$u_ds_msp_updateinsertedrelease.sru
forward
global type u_ds_msp_updateinsertedrelease from datastore
end type
end forward

global type u_ds_msp_updateinsertedrelease from datastore
string DataObject="d_msp_updateinsertedrelease"
end type
global u_ds_msp_updateinsertedrelease u_ds_msp_updateinsertedrelease

on u_ds_msp_updateinsertedrelease.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_msp_updateinsertedrelease.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetTransObject ( SQLCA )
end event

