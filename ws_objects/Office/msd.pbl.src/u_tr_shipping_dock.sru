$PBExportHeader$u_tr_shipping_dock.sru
forward
global type u_tr_shipping_dock from u_tr_base
end type
end forward

global type u_tr_shipping_dock from u_tr_base
end type
global u_tr_shipping_dock u_tr_shipping_dock

type variables
string	MONErrText

end variables

forward prototypes
public function integer of_get_ship_dest_pool_and_type (long al_shipper, ref string as_destination, ref string as_type, ref string as_pool_code)
public function integer of_get_bol_dest_pool_and_type (long al_bol_number, ref string as_destination, ref string as_type, ref string as_pool_code)
public function long of_checkshipper (long al_shipper)
public function long of_updatekanbaninfo (long al_shipper)
public function long of_setbolprintedstatus (long al_shipper, string as_status)
public function long of_shipout (long al_shipper, string as_pronumber, string as_trucknumber, string as_operator, ref long al_invoice, datetime adt_dateshipped)
end prototypes

public function integer of_get_ship_dest_pool_and_type (long al_shipper, ref string as_destination, ref string as_type, ref string as_pool_code);int	li_sqlcode

select	shipper.destination,
			destination.type
into		:as_destination,
			:as_type
from		shipper,
			destination
where		shipper.destination = destination.destination and
			shipper.id = :al_shipper ;

li_sqlcode = sqlca.sqlcode

select	pool_code
into		:as_pool_code
from		edi_setups
where		destination = :as_destination  ;
  
return li_sqlcode
end function

public function integer of_get_bol_dest_pool_and_type (long al_bol_number, ref string as_destination, ref string as_type, ref string as_pool_code);int		li_sqlcode

SELECT	bill_of_lading.destination,   
			destination.type  
INTO 		:as_destination,   
			:as_type  
FROM 		bill_of_lading,   
			destination  
WHERE 	bill_of_lading.destination = destination.destination and  
			bill_of_lading.bol_number = :al_bol_number    ;

li_sqlcode = sqlca.sqlcode

select	pool_code
into		:as_pool_code
from		edi_setups
where		destination = :as_destination ;

return li_sqlcode
end function

public function long of_checkshipper (long al_shipper);//************************************************************************************//
// Function Name:	of_checkshipper
//
// Description:	This function checks whether it's ready for ship outs
//
// 'Returns Codes:	Returns 0, 100, -1, -2, -3, -4, -5
//
// Log of Changes:  GPH 03-23-1999 11:15.00 Original.
//************************************************************************************//

// declare local variables
datastore	lds_Shipper
long        ll_result
string      ls_message
// create datastore
lds_Shipper = create datastore
lds_Shipper.DataObject = "d_msp_checkshipper"
lds_Shipper.SetTransObject ( sqlca )
lds_Shipper.Retrieve ( al_shipper )
if lds_shipper.rowcount() > 0 then 
	// get the result & validate
	ll_result = lds_Shipper.GetItemNumber ( 1, "result" )
	if ll_result <> 0 then
		Choose Case ll_result
			Case 100
					ls_message = "Invalid Shipper - " + string(al_shipper)			
			Case -1
					ls_message = "Status is not Approved for shipper - "+ string(al_shipper)
			Case -2
					ls_message = "Shipper - " + string(al_shipper)+" is Closed by another user"		
			Case -3
					ls_message = "Shipper - " + string(al_shipper) + " is not Staged"		
			Case -4
					ls_message = "Pack List is not printed for shipper - " + string(al_shipper)
			Case -5
					ls_message = "Bill of Lading is not printed for shipper - "	 + string(al_shipper)	
		End Choose
		Messagebox(monsys.msg_title,ls_message)
	end if 
else
	ll_result = -6
end if 	
// destroy datastore
destroy lds_Shipper
// return value
Return ll_result

end function

public function long of_updatekanbaninfo (long al_shipper);//************************************************************************************//
// Function Name:	of_updatekanbaninfo
//
// Description:	This function calls the kanban updation procedure through a dw
//
// Returns Codes:	Returns 0
//
// Log of Changes:  GPH 04-08-1999 16:31.00 Original.
//************************************************************************************//
// declare local variables
datastore	lds_kanbanrows
long        ll_result=0
long        ll_object_serial
long        ll_row
integer     li_rtn_code        
string      ls_message
string      ls_kanban_number
string      ls_kanban_status
string      ls_label
st_generic_structure lst_parm
// create datastore
lds_kanbanrows = create datastore
lds_kanbanrows.DataObject = "d_msp_update_kanban_info"
lds_kanbanrows.SetTransObject ( sqlca )
lds_kanbanrows.Retrieve ( al_shipper )
// if any rows are retrieved, process one by one
if lds_kanbanrows.rowcount() > 0 then 
	For ll_row = 1 to lds_kanbanrows.rowcount() 
 	    ls_kanban_number = lds_kanbanrows.object.#1 [ll_row]
	    ls_kanban_status = lds_kanbanrows.object.#2 [ll_row]
       ll_object_serial = lds_kanbanrows.object.#3 [ll_row]
	    ls_label         = lds_kanbanrows.object.#4 [ll_row]		 
 	    If ls_kanban_status = 'U' then 
 		    li_rtn_code = MessageBox ( monsys.msg_title, "The kanban label for the kanban number  ~r" + &
                                      ls_kanban_number + "has not been printed.  ~rWould you" + &
                                     "like to print it now?", Question!, YesNo! , 2 )
          If li_rtn_code = 1 then
					lst_parm.value1 = string(ll_object_serial)
					f_print_label ( lst_parm ) 
					li_rtn_Code = 2
          End If
       End if
		 // if printed delete the  row from kanban table
       If ls_kanban_status = 'X' or  ( ls_kanban_status = 'U' and li_Rtn_Code = 2 ) then
			 DELETE 
			   FROM kanban
			  WHERE (kanban_number = :ls_kanban_number) ;
			 // verify success status  
			 If (sqlca.sqlcode = 0) then
             commit ;
			 else
				 rollback ;
  			 end if  	 
	    End If
 	Next
End if 	
ll_result = 0 
// destroy datastore
destroy lds_kanbanrows
// return value
Return ll_result

end function

public function long of_setbolprintedstatus (long al_shipper, string as_status);long	ll_bol

select	bill_of_lading_number
into		:ll_bol
from		shipper
where		id = :al_shipper ;

if sqlca.sqlcode = 0 then
	update	bill_of_lading
	set		printed = :as_status
	where		bol_number = :ll_bol ;
end if

return sqlca.sqlcode
end function

public function long of_shipout (long al_shipper, string as_pronumber, string as_trucknumber, string as_operator, ref long al_invoice, datetime adt_dateshipped);declare ShipOut procedure for
msp_shipout :al_Shipper, :adt_dateshipped;

//	Set the operator code for the shipout and the truck pro number and truck number.
update	shipper
set	pro_number = :as_ProNumber,
		truck_number = :as_TruckNumber
where	id = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to set pro number while performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

update	shipper_detail
set	operator = :as_Operator
where	shipper = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to set operator while performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

//	Execute shipout.
execute ShipOut  ;

if SQLCode <> 0 then
	MONErrText = "Unable to execute msp_shipout while performing ShipOut.~r~n~r~n" + sqlerrtext
	close shipout ;
	return SQLCode
end if

close shipout ;

//	Retrieve invoice number.
select	invoice_number
into	:al_Invoice
from	shipper
where	id = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to retrieve invoice number performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

//	Return.
return SQLCode

end function

on u_tr_shipping_dock.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on u_tr_shipping_dock.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

