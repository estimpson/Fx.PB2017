$PBExportHeader$u_ds_msp_transferinsertedrelease.sru
forward
global type u_ds_msp_transferinsertedrelease from datastore
end type
end forward

global type u_ds_msp_transferinsertedrelease from datastore
string DataObject="d_msp_transferinsertedrelease"
end type
global u_ds_msp_transferinsertedrelease u_ds_msp_transferinsertedrelease

on u_ds_msp_transferinsertedrelease.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_msp_transferinsertedrelease.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetTransObject ( SQLCA )
end event

