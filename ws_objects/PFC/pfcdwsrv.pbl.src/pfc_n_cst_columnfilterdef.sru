$PBExportHeader$pfc_n_cst_columnfilterdef.sru
$PBExportComments$PFC Attributes for DataWindow Filter service
forward
global type pfc_n_cst_columnfilterdef from n_cst_baseattrib
end type
end forward

global type pfc_n_cst_columnfilterdef from n_cst_baseattrib autoinstantiate
end type

type variables
Public:
string	ColumnName, FilterVerb, FilterValue

end variables

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_n_cst_filterattrib
//
//	Description:  A NVO class to hold attributes for pfc_n_cst_dwsrv_filter
//				     service object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

end event

on pfc_n_cst_columnfilterdef.create
call super::create
end on

on pfc_n_cst_columnfilterdef.destroy
call super::destroy
end on

