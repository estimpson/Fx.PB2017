$PBExportHeader$pfc_n_cst_filterattrib.sru
$PBExportComments$PFC Attributes for DataWindow Filter service
forward
global type pfc_n_cst_filterattrib from n_cst_baseattrib
end type
end forward

global type pfc_n_cst_filterattrib from n_cst_baseattrib autoinstantiate
end type
global pfc_n_cst_filterattrib pfc_n_cst_filterattrib

type variables
Public:
string	is_filter
string 	is_columns[]
string 	is_colnamedisplay[]
string 	is_dbnames[]
u_dw 	idw_dw
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
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

end event

on pfc_n_cst_filterattrib.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_filterattrib.destroy
TriggerEvent( this, "destructor" )
end on

