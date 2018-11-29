$PBExportHeader$w_label_base.srw
forward
global type w_label_base from Window
end type
end forward

global type w_label_base from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_open ( )
event ue_preprocess ( )
end type
global w_label_base w_label_base

type variables
//	Instance Variable declaration
date	idt_objdate
datetime	idt_objdatetime, &
	idt_effdate
dec {0}	id_quantity
long	il_serial, &
	il_shipper, &
	il_suffix, &
	il_order
string	is_part, &
	is_lot, &
	is_location, & 
	is_unit, &
	is_origin, &
	is_custom4, &
	is_custom5, &
	is_name, & 
	is_company, &
	is_caddress1, &
	is_caddress2, &
	is_caddress3, &
	is_ecnlevel, &
	is_destination, &
	is_ohdestination, &
	is_customerpart, &	
	is_sdcustomerpart, &
	is_release, &
	is_partcrossref, &
	is_customerpo, &
	is_cname, &
	is_dname, &
	is_daddress1, &
	is_daddress2, &
	is_daddress3, &
	is_suppliercode, &
	is_nooflabels, &
	is_type, &
	is_kanban, &
	is_dockcode, &
	is_linefeed, &
	is_zone
time	ltt_objtime
st_generic_structure istr_generic

end variables

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//
//	window		: w_label_base
//	
//	Arguments	: none, but ancestor has the st_generic_structure
//	
//	Return value	: none
//
//	Development	: HGP	7/8/03	Re-formatted and cleaned up
//
//	Variables used	: Instance variables
//				idt_objdate		: To store date of object datetime
//				idt_objdatetime		: To store object datetime
//				idt_effdate		: To store effective date 
//				id_quantity		: To store object quantity
//				il_serial		: To store serial number	
//				il_shipper		: To store shipper number
//				il_suffix		: To store suffix number
//				il_order		: To store order number	
//				is_part			: To store object part number
//				is_lot			: To store object lot number
//				is_location		: To store object location	
//				is_unit			: To store object unit of measure
//				is_origin		: To store object origin
//				is_custom4		: To store object custom4 data
//				is_custom5		: To store object custom5 data
//				is_name			: To store part name
//				is_company		: To store company name
//				is_caddress1		: To store company address line 1	
//				is_caddress2		: To store company address line 2
//				is_caddress3		: To store company address line 3	
//				is_ecnlevel		: To store part ecn level
//				is_destination		: To store destination 
//				is_ohdestination	: To store order header destination
//				is_customerpart		: To store customer part
//				is_sdcustomerpart	: To store shipper detail customer part
//				is_release		: To store release number
//				is_partcrossref		: To store part cross reference
//				is_customerpo		: To store customer po number
//				is_cname		: To store customer name 	
//				is_dname		: To store destination name	
//				is_daddress1		: To store destination address line 1
//				is_daddress2		: To store destination address line 2
//				is_daddress3		: To store destination address line 3
//				is_suppliercode		: To store supplier code 
//				is_nooflabels		: To store number of labels
//				is_type			: To store object type
//				is_kanban		: To store kanban number for the object
//				is_dockcode		: To store dock code
//				is_linefeed		: To store line feed
//				is_zone			: To store zone
//				ltt_objtime		: To store the time of object datetime
//				istr_generic		: To store the argument structure
//	
//			: Local variables
//////////////////////////////////////////////////////////////////////////////////////////
//	Declarations

//	Identify serial (i.e whether it's an object serial or pallet serial)
select	type
into	:is_type
from	object
where	serial = :il_serial;
if is_type = 'S' then
	//	Get data from object table for that pallet serial
	//	Room for improvement in this area label per part # for a pallet
	select	max(object.part), max(lot), sum(quantity), max(unit_measure), max(last_date), max(destination),
		min(suffix), max(shipper), max(origin), 
		max(custom4), max(part.name), max(part.cross_ref)
	into	:is_part, :is_lot, :id_quantity, :is_unit,
		:idt_objdatetime, :is_destination, :il_suffix, :il_shipper, :is_origin,
		:is_custom4, :is_name, :is_partcrossref
	from	object
	join	part on part.part = object.part
	where	parent_serial = :il_serial;
else	
	//	Get data from object table for that object serial 
	select	object.part, object.lot, object.location, object.quantity, object.unit_measure,
		object.last_time, object.destination, object.suffix, object.shipper, object.origin,
		object.custom4,	object.custom5, object.kanban_number, part.name, part.cross_ref
	into	:is_part, :is_lot, :is_location, :id_quantity, :is_unit,
		:idt_objdatetime, :is_destination, :il_suffix, :il_shipper, :is_origin,
		:is_custom4, :is_custom5, :is_kanban, :is_name, :is_partcrossref
	from	object
		join part on part.part = object.part
	where	serial = :il_serial;
end if 

//	Determine the shipper number
if isnull(il_shipper,0) = 0 and isnumber(is_origin) then il_shipper = long(is_origin)

//	Fix suffix issue
if il_suffix = 0 then il_suffix = -1 // to overcome existing customer labels

//	Get Company info
select	company_name, address_1, address_2, address_3
into	:is_company, :is_caddress1, :is_caddress2, :is_caddress3
from	parameters;

//	Extract date and time
idt_objdate = date(idt_objdatetime)
ltt_objtime = time(idt_objdatetime)

//	Get effective date info
select	max(effective_date)
into	:idt_effdate
from	effective_change_notice
where	part = :is_part and effective_date <= :idt_objdate; 

//	Get ecn level info
select	engineering_level
into	:is_ecnlevel
from	effective_change_notice
where	part = :is_part and effective_date = :idt_effdate;

// Find order number if it was not set in preprocessing
if isnull(il_order,0) = 0 then
	//	Get order # from shipper detail
	select	shipper_detail.order_no,
		shipper_detail.customer_part,
		shipper_detail.release_no
	into	:il_order,
		:is_sdcustomerpart,
		:is_release
	from	shipper_detail
	where	shipper = :il_shipper and
		part_original = :is_part and 
		isnull(suffix,-1) = isnull(:il_suffix,-1);
	
	//	Determine order #
	if isnull(il_order,0) = 0 and isnumber(is_custom4) then il_order = long(is_custom4)
end if

//	Get order info
select	order_header.customer_po, order_header.customer_part, customer.name, order_header.destination,
	order_header.dock_code, order_header.line_feed_code, order_header.zone_code
into	:is_customerpo, :is_customerpart, :is_cname, :is_ohdestination,
	:is_dockcode, :is_linefeed, :is_zone
from	order_header
	join customer on customer.customer = order_header.customer
where	order_header.order_no = :il_order;

//	Determine destination
if isnull(is_destination,'') = '' then is_destination = is_ohdestination

//	Get destination info
select	destination.name, destination.address_1, destination.address_2, 
	destination.address_3, edi_setups.supplier_code
into	:is_dname, :is_daddress1, :is_daddress2, 
	:is_daddress3, :is_suppliercode
from	destination
	join edi_setups on edi_setups.destination = destination.destination
where	destination.destination = :is_destination;

//	Determine customer part
if isnull(is_customerpart,'') = '' then is_customerpart = is_sdcustomerpart
if isnull(is_customerpart,'') = '' then is_customerpart = is_partcrossref

//	Any further info could be included here. 
end event

event ue_preprocess;// Preprocessing
// Get argument structure and may set order number based on alternative calculations

//	Argument Assignment
istr_generic = Message.PowerObjectParm
il_serial = long(istr_generic.value1)	// get serial #
is_nooflabels  = istr_generic.value11

end event

event open;// Trigger a preprocess event for labels that determine order number in a different way
triggerevent('ue_preprocess')
//	Trigger user event open
triggerevent('ue_open')


end event

on w_label_base.create
end on

on w_label_base.destroy
end on

