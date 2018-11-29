$PBExportHeader$pfc_n_cst_dwsrv_querymodeinfo.sru
$PBExportComments$PFC DataWindow QueryMode service
forward
global type pfc_n_cst_dwsrv_querymodeinfo from n_base
end type
end forward

global type pfc_n_cst_dwsrv_querymodeinfo from n_base autoinstantiate
end type

type variables

public:
boolean State
string ColumnName
string ProtectExpression
long TabSequence

end variables

on pfc_n_cst_dwsrv_querymodeinfo.create
call super::create
end on

on pfc_n_cst_dwsrv_querymodeinfo.destroy
call super::destroy
end on

