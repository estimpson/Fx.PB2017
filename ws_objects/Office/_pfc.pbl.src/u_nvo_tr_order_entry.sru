$PBExportHeader$u_nvo_tr_order_entry.sru
forward
global type u_nvo_tr_order_entry from nonvisualobject
end type
end forward

global type u_nvo_tr_order_entry from nonvisualobject
end type
global u_nvo_tr_order_entry u_nvo_tr_order_entry

forward prototypes
public function integer select_order_header (integer sales_order, ref string customer_part, ref string order_type)
public function integer select_order_detail_um (integer sales_order, string part, integer suffix, ref string um)
public function integer select_order_header_po (long al_order, ref string as_customerpo)
end prototypes

public function integer select_order_header (integer sales_order, ref string customer_part, ref string order_type);SELECT	customer_part,
			order_type
  INTO	:customer_part,
			:order_type
  FROM	order_header
 WHERE	order_no = :sales_order  ;

RETURN SQLCA.SQLCode
end function

public function integer select_order_detail_um (integer sales_order, string part, integer suffix, ref string um);SELECT	unit
  INTO	:um
  FROM	order_detail
 WHERE	order_no = :sales_order AND
 			part_number = :part AND	
			IsNull ( suffix, 0 ) = IsNull ( :suffix, 0 )  ;

RETURN SQLCA.SQLCode
end function

public function integer select_order_header_po (long al_order, ref string as_customerpo);SELECT	order_header.customer_po  
INTO		:as_customerpo  
FROM 		order_header 
WHERE		order_no = :al_order ;
	
return SQLCA.SQLCode
end function

on u_nvo_tr_order_entry.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_tr_order_entry.destroy
TriggerEvent( this, "destructor" )
end on

