$PBExportHeader$n_customdropdownattrib.sru
$PBExportComments$PFC Calendar constructor attributes
forward
global type n_customdropdownattrib from pfc_n_cst_baseattrib
end type
end forward

global type n_customdropdownattrib from pfc_n_cst_baseattrib autoinstantiate
end type

type variables
Public:
boolean 	DropDown = false
boolean	DefaultDropDown = false
string ColumnName, RestoreModifyExpression
int CustomControlIndex
int ColumnType
int DropDownStyle

end variables

on n_customdropdownattrib.create
call super::create
end on

on n_customdropdownattrib.destroy
call super::destroy
end on

