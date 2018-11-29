$PBExportHeader$u_ds_d_shipping_kanban.sru
forward
global type u_ds_d_shipping_kanban from u_ds_db_base
end type
end forward

global type u_ds_d_shipping_kanban from u_ds_db_base
string DataObject="d_shipping_kanban"
end type
global u_ds_d_shipping_kanban u_ds_d_shipping_kanban

on u_ds_d_shipping_kanban.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_d_shipping_kanban.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

