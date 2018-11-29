$PBExportHeader$n_cst_calendarattrib.sru
$PBExportComments$Extension Calendar constructor attributes
forward
global type n_cst_calendarattrib from pfc_n_cst_calendarattrib
end type
end forward

global type n_cst_calendarattrib from pfc_n_cst_calendarattrib
end type
global n_cst_calendarattrib n_cst_calendarattrib

on n_cst_calendarattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_calendarattrib.destroy
triggerevent( this, "destructor" )
end on

