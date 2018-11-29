$PBExportHeader$n_cst_calculatorattrib.sru
$PBExportComments$Extension Calculator constructor attributes
forward
global type n_cst_calculatorattrib from pfc_n_cst_calculatorattrib
end type
end forward

global type n_cst_calculatorattrib from pfc_n_cst_calculatorattrib
end type
global n_cst_calculatorattrib n_cst_calculatorattrib

on n_cst_calculatorattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_calculatorattrib.destroy
triggerevent( this, "destructor" )
end on

