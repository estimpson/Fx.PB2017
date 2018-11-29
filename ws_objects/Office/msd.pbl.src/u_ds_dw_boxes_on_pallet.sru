$PBExportHeader$u_ds_dw_boxes_on_pallet.sru
forward
global type u_ds_dw_boxes_on_pallet from u_ds_db_base
end type
end forward

global type u_ds_dw_boxes_on_pallet from u_ds_db_base
string DataObject="dw_boxes_on_pallet"
end type
global u_ds_dw_boxes_on_pallet u_ds_dw_boxes_on_pallet

on u_ds_dw_boxes_on_pallet.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_dw_boxes_on_pallet.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

