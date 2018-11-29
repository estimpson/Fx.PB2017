$PBExportHeader$n_cst_inifile.sru
$PBExportComments$Extension INIFile service
forward
global type n_cst_inifile from pfc_n_cst_inifile
end type
end forward

global type n_cst_inifile from pfc_n_cst_inifile
end type
global n_cst_inifile n_cst_inifile

on n_cst_inifile.create
triggerevent( this, "constructor" )
end on

on n_cst_inifile.destroy
triggerevent( this, "destructor" )
end on

