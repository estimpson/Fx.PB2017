$PBExportHeader$pfc_n_cst_stack.sru
$PBExportComments$PFC Stack List service
forward
global type pfc_n_cst_stack from n_cst_linkedlistbase
end type
end forward

global type pfc_n_cst_stack from n_cst_linkedlistbase
end type
global pfc_n_cst_stack pfc_n_cst_stack

forward prototypes
public function integer of_push (n_cst_linkedlistnode anv_node)
public function integer of_pop (ref n_cst_linkedlistnode anv_node)
end prototypes

public function integer of_push (n_cst_linkedlistnode anv_node);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_push
//
//	Access:  public
//
//	Arguments : 
//	anv_node  node to push.
//
//	Returns:  integer
//	same as the ancestor of_AddHead function.
//
//	Description:  
//	Push a new node onto the stack.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return of_AddHead(anv_node)


end function

public function integer of_pop (ref n_cst_linkedlistnode anv_node);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Pop
//
//	Access:  public
//
//	Arguments : 
//	anv_node  (by reference) node to be returned
//
//	Returns:  integer
//	1 = success
//	-1 = failure 
//
//	Description: 
//	Gets and removes the TOP/Head node.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Validate that the reference to get is valid.
if isnull(inv_head) or not isvalid(inv_head) then 
	return -1
end if

// Take the top node.
anv_node = inv_head

// Remove the node.
return of_remove(anv_node)
	
end function

on pfc_n_cst_stack.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_stack.destroy
TriggerEvent( this, "destructor" )
end on

