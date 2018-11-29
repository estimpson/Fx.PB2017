$PBExportHeader$pfc_n_cst_sortattrib.sru
$PBExportComments$PFC Attributes for DataWindow Sort service
forward
global type pfc_n_cst_sortattrib from n_cst_baseattrib
end type
end forward

global type pfc_n_cst_sortattrib from n_cst_baseattrib autoinstantiate
end type

type variables
Public:
string	is_sort
string 	is_sortcolumns[]
string	is_colnamedisplay[]
boolean 	ib_usedisplay[]
string 	is_origcolumns[]
string 	is_origorder[]
end variables

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_n_cst_sortattrib
//
//	Description:  A NVO class to hold attributes for pfc_n_cst_dwsrv_sort
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

on pfc_n_cst_sortattrib.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_sortattrib.destroy
TriggerEvent( this, "destructor" )
end on

