$PBExportHeader$u_ds_dw_shipper_shipping_info.sru
forward
global type u_ds_dw_shipper_shipping_info from u_ds_db_base
end type
end forward

global type u_ds_dw_shipper_shipping_info from u_ds_db_base
string DataObject="dw_shipper_shipping_info"
end type
global u_ds_dw_shipper_shipping_info u_ds_dw_shipper_shipping_info

on u_ds_dw_shipper_shipping_info.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_shipper_shipping_info.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

