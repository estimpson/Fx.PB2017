$PBExportHeader$n_cst_filesrvwin32.sru
$PBExportComments$Extension Win32 File handler service
forward
global type n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
end forward

global type n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
global n_cst_filesrvwin32 n_cst_filesrvwin32

on n_cst_filesrvwin32.create
triggerevent( this, "constructor" )
end on

on n_cst_filesrvwin32.destroy
triggerevent( this, "destructor" )
end on

