$PBExportHeader$n_cst_dwpropertyattrib.sru
$PBExportComments$Extension DataWindow Property - attributes
forward
global type n_cst_dwpropertyattrib from pfc_n_cst_dwpropertyattrib
end type
end forward

global type n_cst_dwpropertyattrib from pfc_n_cst_dwpropertyattrib
end type
global n_cst_dwpropertyattrib n_cst_dwpropertyattrib

on n_cst_dwpropertyattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_dwpropertyattrib.destroy
triggerevent( this, "destructor" )
end on

