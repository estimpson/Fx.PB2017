$PBExportHeader$u_tr_monitor.sru
$PBExportComments$monitor
forward
global type u_tr_monitor from u_tr_base
end type
end forward

global type u_tr_monitor from u_tr_base
end type
global u_tr_monitor u_tr_monitor

type variables
u_nvo_tr_order_entry	oe
u_nvo_tr_admin_setups	setups
end variables

forward prototypes
public function integer uf_modify_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_remove_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_add_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_get_prod_grid_rows (ref long a_l_rows)
public function integer of_get_product_line_for_part (string as_part, ref string as_product_line)
public function integer of_get_next_issue_number (ref long al_issue_number)
public function integer of_get_defaults_for_issue (ref string as_category, ref string as_sub_category, ref string as_status)
public function integer of_calculate_multicurrency_price (string as_from, string as_to, decimal adec_price, ref decimal adec_calc_price)
public function integer of_get_currency_display_symbol (string as_currency, ref string as_symbol)
public function integer of_get_currency_unit (string as_customer, string as_vendor, string as_destination, long al_order, long al_po, long al_invoice, ref string as_units[], ref integer ai_show_euro[])
public function integer of_creatermaobject (datastore ads_objectinfo)
public function integer of_createaudittrail (ref datastore ads_audittrailinfo)
public function integer of_delete_rma (long al_shipper, string as_part)
public function integer of_createcreditmemo (long al_rma, string as_operator, ref long al_invoice)
public function boolean of_deletestagedshipper (long al_shipper)
public function boolean of_customerpoexists (string as_customerpo, string as_destination)
public function string of_getprimarylocation (string as_part)
public function decimal of_customerstandardpack (string as_customer, string as_part, string as_unit)
end prototypes

public function integer uf_modify_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  UPDATE	effective_change_notice
     SET	operator = :a_s_operator,
			notes = :a_s_notes,
			engineering_level = :a_s_engineering_level
  WHERE	:a_s_part = part AND
  			:a_dt_effective_date = effective_date  ;

Return SQLCA.SQLCode
end function

public function integer uf_remove_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  DELETE	effective_change_notice
  WHERE	:a_s_part = part AND
  			:a_dt_effective_date = effective_date AND
			:a_s_operator = operator AND
			:a_s_notes = notes AND
			:a_s_engineering_level = engineering_level  ;

Return SQLCA.SQLCode
end function

public function integer uf_add_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  INSERT	effective_change_notice
  VALUES	( :a_s_part, :a_dt_effective_date, :a_s_operator, :a_s_notes, :a_s_engineering_level )  ;

Return SQLCA.SQLCode
end function

public function integer uf_get_prod_grid_rows (ref long a_l_rows);select	count ( * )
into	:a_l_rows
from	master_prod_sched  ;

return SQLCA.SQLCode
end function

public function integer of_get_product_line_for_part (string as_part, ref string as_product_line);select	product_line
into		:as_product_line
from		part
where		part = :as_part ;

return sqlca.sqlcode
end function

public function integer of_get_next_issue_number (ref long al_issue_number);boolean	lb_done
int		li_count,&
			li_return = 0

do while not lb_done
	select	next_issue
	into		:al_issue_number
	from		parameters ;

	update	parameters
	set		next_issue = :al_issue_number + 1 ;
	
	if sqlca.sqlcode <> 0 then
		li_return = 1
		lb_done = TRUE
	else	
		select	count(*)
		into		:li_count
		from		issues
		where		issue_number = :al_issue_number ;
		
		if li_count < 1 then 
			lb_done = TRUE
			commit ;
		end if
	end if
loop

return li_return
end function

public function integer of_get_defaults_for_issue (ref string as_category, ref string as_sub_category, ref string as_status);SELECT	issues_category.category  
INTO 		:as_category  
FROM 		issues_category  
WHERE 	issues_category.default_value = 'Y'   ;

SELECT 	issues_status.status  
INTO 		:as_status  
FROM 		issues_status  
WHERE 	issues_status.default_value = 'Y'   ;

SELECT 	issues_sub_category.sub_category  
INTO 		:as_sub_category  
FROM 		issues_sub_category  
WHERE 	issues_sub_category.default_value = 'Y'   ;

return 1
end function

public function integer of_calculate_multicurrency_price (string as_from, string as_to, decimal adec_price, ref decimal adec_calc_price);dec {6}	ldec_rate1,&
			ldec_rate2
string	ls_base_currency

select	base_currency
into		:ls_base_currency
from		parameters ;

if Isnull ( as_from,'' ) = '' then
	as_from = ls_base_currency
end if

if Isnull ( as_to, '' ) = '' then
	as_to = ls_base_currency
end if

if as_from = as_to then
	
	adec_calc_price = adec_price
	
else
	
	select	rate 
	into		:ldec_rate1 
	from		currency_conversion 
	where		effective_date = (	select	max (effective_date) 
											from		currency_conversion cc 
											where		effective_date < GetDate ( ) and 
														currency_code = :as_from ) and 
				currency_code = :as_from ;
				
	if ldec_rate1 = 0 then ldec_rate1 = 1
	
	adec_calc_price = adec_price * isnull(ldec_rate1,1)

	select	rate 
	into		:ldec_rate2 
	from		currency_conversion 
	where		effective_date = (	select	max (effective_date) 
											from		currency_conversion cc 
											where		effective_date < GetDate ( ) and 
														currency_code = :as_to ) and 
				currency_code = :as_to ;
				
	if ldec_rate2 = 0 then ldec_rate2 = 1

	adec_calc_price = adec_calc_price / isnull(ldec_rate2,1)
		
end if

return 0
end function

public function integer of_get_currency_display_symbol (string as_currency, ref string as_symbol);select	currency_display_symbol
into		:as_symbol
from		currency_conversion
where		currency_code = :as_currency ;

return sqlca.sqlcode

end function

public function integer of_get_currency_unit (string as_customer, string as_vendor, string as_destination, long al_order, long al_po, long al_invoice, ref string as_units[], ref integer ai_show_euro[]);int	li_index

if isnull(as_customer,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		customer
	where		customer = :as_customer ;
end if

if isnull(as_vendor,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		vendor
	where		code = :as_vendor ;
end if

if isnull(as_destination,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		destination
	where		destination = :as_destination ;
end if

if isnull(al_order,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		order_header
	where		order_no = :al_order ;
end if

if isnull(al_po,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		po_header
	where		po_number = :al_po ;
end if

if isnull(al_invoice,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]

	from		shipper
	where		invoice_number = :al_invoice ;
end if

if li_index = 0 then
	li_index++
	select	base_currency
	into		:as_units[li_index]
	from		parameters ;
	ai_show_euro[1] = 1
end if

return 0

end function

public function integer of_creatermaobject (datastore ads_objectinfo);//************************************************************************************//
// Function Name:	of_creatermaobject
//
// Description:	This function initializes the datastores to create object and audit trail rows.
//						Calls the create object and audit trail services..
//
// Syntax:			LONG of_create	(	ads_objectinfo datastore by reference )
//
// Where:		   ads_objectinfo is the datastore that has all default values to create object 
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the object  
//
// Log of Changes:
// MB 06-01-1999 10:11:00  Original.
//************************************************************************************//

constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

datastore lds_objectinfo

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if IsValid ( ads_objectinfo ) then
	
	if ads_objectinfo.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		//	create updateable datastore to create new serial
		lds_objectinfo = create datastore
		lds_objectinfo.dataobject = 'd_object_info'
		lds_objectinfo.settransobject ( sqlca )
		
		//	copy the object info to the updateable datastore
		if ads_objectinfo.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_objectinfo, BEGINROW, Primary! ) = 1 THEN
			if lds_objectinfo.update() > 0 then				
				li_returnvalue = 0
			else
				li_returnvalue = -1
			end if
		end if
			
		destroy lds_objectinfo
			
	end if
	
end if

//  return
return li_returnvalue
end function

public function integer of_createaudittrail (ref datastore ads_audittrailinfo);//************************************************************************************//
// Function Name:	of_CreateAuditTrail
//
// Description:	This function create audit trail entries for the serial number being passed
//
// Syntax:			LONG of_create	(	DATASTORE *	ads_audittrailinfo )
//
// Where:			ads_audittrailinfo - datastore that has all the initial values for audit trail row
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the audit trail enty.  
//
// Log of Changes:
// MB 06-01-1999 12:34:00 Original.
//************************************************************************************//

constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

datastore lds_audit_trail_info

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if IsValid ( ads_audittrailinfo ) then

	if ads_audittrailinfo.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		lds_audit_trail_info = create datastore
		lds_audit_trail_info.dataobject = 'd_audit_trail_info'
		lds_audit_trail_info.settransobject ( sqlca )

		//	copy the object info to the updateable datastore
		if ads_audittrailinfo.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_audit_trail_info, BEGINROW, Primary! ) = 1 THEN
			if lds_audit_trail_info.update() > 0 then
				commit ;
				li_returnvalue = 0
			else
				rollback ;
				li_returnvalue = -1
			end if
		end if
		
		destroy lds_audit_trail_info
			
	end if
end if

//  return
return li_returnvalue


end function

public function integer of_delete_rma (long al_shipper, string as_part);// declare local variables
integer		li_count
string		ls_message

// check the detail to make sure no objects have been received against it.
if as_part > '' then
	select	count ( shipper )
	into		:li_count
	from		shipper_detail
	where		shipper = :al_shipper and
				part = :as_part and
				qty_packed < 0 ;
	ls_message = "Are you sure about deleting this RMA?"
else
	select	count ( shipper )
	into		:li_count
	from		shipper_detail
	where		shipper = :al_shipper and
				qty_packed < 0 ;
	ls_message = "Are you sure about deleting this RMA?  (All detail items will be deleted also)."
end if

			
if li_count > 0 then
	MessageBox ( monsys.msg_title, "You can only delete RMA's that haven't been received against!", Information! )
	return 0
else
	Choose Case MessageBox ( monsys.msg_title, ls_message, Question!, YesNo!, 2 )
		Case 1
			if as_part > '' then
				delete from shipper_detail
				where shipper = :al_shipper and
						part = :as_part ;

				if sqlca.sqlcode = 0 then
					commit ;
				else
					rollback;
					MessageBox ( monsys.msg_title, "Unable to delete RMA detail!", StopSign! )
					return 0
				end if
			else
//	Commented the below line to retain the detail items, for history purposes				
//				delete from shipper_detail
//				where shipper = :al_shipper ;
//
				if sqlca.sqlcode = 0 then
//	Changed the below statement from delete to update, as we don't want to get rid 
//	of the shipper
//					delete from shipper
//					where id = :al_shipper ;

					update	shipper
					set	status = 'E'
					where id = :al_shipper ;
					
					if sqlca.sqlcode = 0 then
						commit ;
					else
						rollback;
						MessageBox ( monsys.msg_title, "Unable to delete RMA header!", StopSign! )
						return 0
					end if
				else
					rollback;
					MessageBox ( monsys.msg_title, "Unable to delete RMA detail!", StopSign! )
					return 0
				end if
			end if
		Case Else
			return 0
	End Choose
end if

return 1
end function

public function integer of_createcreditmemo (long al_rma, string as_operator, ref long al_invoice);//************************************************************************************//
// Function Name:	of_createcreditmemo
//
// Description:	This function creates a credit memo for a particular rma shipper 
//
// Syntax:			LONG of_createcreditmemo ( al_rma long by value, 
//															as_operator string by value 
//															al_invoice long by reference )
//						
// Where:		   al_rma is the shipper for which credit memo needs to be created
//						as_operator is the operator trying to create the credit memo.
//						al_invoice  is the invoice number that will be returned from the stored proc
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the object  
//
// Log of Changes:
// MB 06-17-1999 11:36:00  Original.
//	MB 07-07-1999 modified, included the operator code.
//	MB 07-19-1999 modified, included invoice number argument.
//************************************************************************************//

integer	li_returnvalue

datastore lds_creditmemo

//	create updateable datastore to create credit memo ( invoice )
lds_creditmemo = create datastore
lds_creditmemo.dataobject = 'd_msp_credit_memo'
lds_creditmemo.settransobject ( sqlca )

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if lds_creditmemo.Retrieve ( al_rma, as_operator, al_invoice ) > 0 then
	li_returnvalue = lds_creditmemo.object.result [1]
	al_invoice		= lds_creditmemo.object.invoice_number [1]
	if li_returnvalue = 0 then 
		commit ;
	else
		rollback ;
	end if
else
	li_returnvalue = -1
end if

destroy lds_creditmemo ;

//  return
return li_returnvalue
end function

public function boolean of_deletestagedshipper (long al_shipper);update	object
set	shipper = null,
	show_on_shipper = 'N',
	kanban_number = ''
where	shipper = :al_shipper ;

if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to update object.", StopSign! )
	return false
end if

delete from shipper_container
where shipper = :al_shipper ;
	
if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to delete shipper containers.", StopSign! )
	return false
end if

delete from shipper_detail
where shipper = :al_shipper ;
	
if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to delete shipper detail.", StopSign! )
	return false
end if

update 	shipper
set	status = 'E'
where	id = :al_shipper ;

if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to update shipper.", StopSign! )
	return false
end if

Commit;
return true
end function

public function boolean of_customerpoexists (string as_customerpo, string as_destination);integer	li_count

select	count(order_no)
into	:li_count
from	order_header
where	customer_po = :as_customerpo and
	destination = :as_destination ;

return ( isnull(li_count,0) > 0 )
end function

public function string of_getprimarylocation (string as_part);string	ls_location

select	primary_location
into	:ls_location
from	part_inventory
where	part = :as_part ;

return isnull(ls_location,'')
end function

public function decimal of_customerstandardpack (string as_customer, string as_part, string as_unit);// function:		of_customerstandardpack
// description:	gets the standard pack for the customer / part starting at the part_customer
//						level and ending up at the part_inventory level if none is found.
//	arguments:		as_customer		customer code
//						as_part			part number
//						as_unit			ordered unit
//	returns:			decimal			standard pack quantity
// changes (date user notes)
// 3/31/00	cbr	created

// declare local variables
decimal	ldec_stdpack
string	ls_unit

// get standard pack and unit from part customer table
select	customer_standard_pack,
			customer_unit
into		:ldec_stdpack,
			:ls_unit
from		part_customer
where		customer = :as_customer and
			part = :as_part ;

// if record doesn't exist or standard pack is 0 get from part_inventory
if isnull ( ldec_stdpack, 0 ) <= 0 then
	select	standard_pack,
				standard_unit
	into		:ldec_stdpack,
				:ls_unit
	from		part_inventory
	where		part = :as_part ;
end if

// convert standard pack quantity to ordered unit
ldec_stdpack = f_convert_units ( ls_unit, as_unit, as_part, isnull(ldec_stdpack,0) )

// set to zero if less than zero
if isnull(ldec_stdpack,0) <= 0 then
	ldec_stdpack = 0
end if

// return the standard pack quantity
return ldec_stdpack

end function

on u_tr_monitor.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on u_tr_monitor.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;oe = CREATE u_nvo_tr_order_entry
setups = CREATE u_nvo_tr_admin_setups
end event

event destructor;call super::destructor;DESTROY oe
DESTROY setups
end event

