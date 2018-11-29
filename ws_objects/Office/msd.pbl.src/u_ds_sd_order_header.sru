$PBExportHeader$u_ds_sd_order_header.sru
forward
global type u_ds_sd_order_header from datastore
end type
end forward

global type u_ds_sd_order_header from datastore
string DataObject="d_sd_order_header"
end type
global u_ds_sd_order_header u_ds_sd_order_header

event constructor;settransobject ( sqlca )
end event

on u_ds_sd_order_header.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_sd_order_header.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

