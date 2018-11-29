$PBExportHeader$u_ds_dw_blanket_order_header.sru
forward
global type u_ds_dw_blanket_order_header from u_ds_db_base
end type
end forward

global type u_ds_dw_blanket_order_header from u_ds_db_base
string DataObject="dw_blanket_order_header"
end type
global u_ds_dw_blanket_order_header u_ds_dw_blanket_order_header

on u_ds_dw_blanket_order_header.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_blanket_order_header.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

