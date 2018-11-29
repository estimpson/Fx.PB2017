$PBExportHeader$n_dda.sru
$PBExportComments$Extension DynamicDescriptionArea class
forward
global type n_dda from pfc_n_dda
end type
end forward

global type n_dda from pfc_n_dda
end type
global n_dda n_dda

on n_dda.create
call dynamicdescriptionarea::create
triggerevent( this, "constructor" )
end on

on n_dda.destroy
call dynamicdescriptionarea::destroy
triggerevent( this, "destructor" )
end on

