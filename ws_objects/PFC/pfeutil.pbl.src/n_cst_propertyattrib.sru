$PBExportHeader$n_cst_propertyattrib.sru
$PBExportComments$Extension Property - attributes
forward
global type n_cst_propertyattrib from pfc_n_cst_propertyattrib
end type
end forward

global type n_cst_propertyattrib from pfc_n_cst_propertyattrib
end type
global n_cst_propertyattrib n_cst_propertyattrib

on n_cst_propertyattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_propertyattrib.destroy
triggerevent( this, "destructor" )
end on

