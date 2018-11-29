$PBExportHeader$pfc_n_cst_notesattrib.sru
$PBExportComments$PFC Calendar constructor attributes
forward
global type pfc_n_cst_notesattrib from pfc_n_cst_baseattrib
end type
end forward

global type pfc_n_cst_notesattrib from pfc_n_cst_baseattrib autoinstantiate
end type

type variables
Public:

boolean 	DropDown = False
end variables

on pfc_n_cst_notesattrib.create
call super::create
end on

on pfc_n_cst_notesattrib.destroy
call super::destroy
end on

