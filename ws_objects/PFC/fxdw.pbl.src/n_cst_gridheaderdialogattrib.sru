$PBExportHeader$n_cst_gridheaderdialogattrib.sru
$PBExportComments$PFC Calendar constructor attributes
forward
global type n_cst_gridheaderdialogattrib from pfc_n_cst_baseattrib
end type
end forward

global type n_cst_gridheaderdialogattrib from pfc_n_cst_baseattrib autoinstantiate
end type

type variables
Public:

boolean 	DropDown = False
string ColumnType
string ColumnName
string SortOrder
string RangeFilter
string IncludeFilter
string ExcludeFilter

end variables

on n_cst_gridheaderdialogattrib.create
call super::create
end on

on n_cst_gridheaderdialogattrib.destroy
call super::destroy
end on

