$PBExportHeader$w_tsm_npg_master.srw
forward
global type w_tsm_npg_master from w_label_base
end type
end forward

global type w_tsm_npg_master from w_label_base
end type
global w_tsm_npg_master w_tsm_npg_master

forward prototypes
public function string juliandate ()
end prototypes

public function string juliandate ();string	sYear
string	sDay
int	ione
syear = right(string(year(today())),2)
sday = string(year(today()))+'-01-01'
sday = right('000'+ string(daysafter(date(sday), today())),3)
return  sday + syear
end function

on w_tsm_npg_master.create
call super::create
end on

on w_tsm_npg_master.destroy
call super::destroy
end on

event ue_open;call super::ue_open;/////////////////////////////////////////////////////////////////////////////////////////
//
//	window		: w_test_inheritedfrombase
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
//				ltt_objtime		: To store the time of object datetime
//	
//			: Local variables
//				ls_numberoflabels	: To store the no. of labels
//				ls_name1,ls_name2,ls_name3: To store parsed part name
//				ls_esc			: To store escape character
//				ll_label		: To store the print handle
//
//////////////////////////////////////////////////////////////////////////////////////////

//	Note 7/2/07: using custom4 and custom5 columns from customer table to store the last box serial date and 
//			last box running sequential number. 
//			Also custom2 and custom3 are being used to store the box serial assigned. 
//			
//	Declarations
string	ls_numberoflabels, ls_name1, ls_name2, ls_name3, ls_esc, ls_serial, ls_sl1, ls_ecl, ls_seril
string	ls_doccode, ls_zonecode, ls_test, ls_ocustom4, ls_ccustom4, ls_ccustom5, ls_customer, ls_nextboxno
string	ls_uom
long	ll_label, ll_nextboxno
decimal ld_weight

datetime ldt_effective_date

select	max(effective_date)
into	:ldt_effective_date
from	effective_change_notice 
where	part = :is_part;

select	engineering_level
into	:ls_ecl
from	effective_change_notice 
where	effective_date = :ldt_effective_date
	and part = :is_part;
	
select	weight, custom4, unit_measure
into	:ld_weight, :ls_ocustom4, :ls_uom
from	object
where	serial = :il_serial;

select	sum(weight), min(unit_measure)
into	:ld_weight, :ls_uom
from	object
where	parent_serial = :il_serial;

select	dock_code, zone_code, customer
into	:ls_doccode, :ls_zonecode, :ls_customer
from	order_header
where	order_no = :il_order;

select	custom4, custom5 
into	:ls_ccustom4, :ls_ccustom5
from	customer
where	customer = :ls_customer;

//	Initialization
ls_esc	= "~h1B"
ls_numberoflabels = "Q1"

//	Determine the number of labels to be printed
If is_nooflabels > "" Then ls_numberoflabels = "Q" + is_nooflabels

//	Parse name/description into 3 variables
ls_Name1 = Mid ( is_name, 1, 25 )
ls_Name2 = Mid ( is_name, 26, 25 )
ls_Name3 = Mid ( is_name, 52, 25 )

//	Start Printing
ll_Label = PrintOpen ( )
PrintSend ( ll_Label, ls_esc + "A" + ls_esc + "R" )
PrintSend ( ll_Label, ls_esc + "AR" )
SetPointer(HourGlass!)

//	Part Info
PrintSend ( ll_Label, ls_esc + "V056" + ls_esc + "H250" + ls_esc + "M" + "PART#" )
PrintSend ( ll_Label, ls_esc + "V080" + ls_esc + "H250" + ls_esc + "M" + "(P)" )
if len(is_customerpart) < 15 then
   PrintSend ( ll_Label, ls_esc + "V025" + ls_esc + "H350" + ls_esc + "$B,55,120,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V135" + ls_esc + "H280" + ls_esc + "B102100" + "*" + "P" + is_customerpart + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V025" + ls_esc + "H350" + ls_esc + "$B,55,120,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V135" + ls_esc + "H280" + ls_esc + "B102100" + "*" + "P" + is_customerpart + "*"  )
end if

//	Quantity Info
PrintSend ( ll_Label, ls_esc + "V265" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "QUANTITY" )
PrintSend ( ll_Label, ls_esc + "V285" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "(Q)" )
PrintSend ( ll_Label, ls_esc + "V275" + ls_esc + "H390" + ls_esc + "L0101" + ls_esc + "WL1"  + String(id_quantity) )
PrintSend ( ll_Label, ls_esc + "V325" + ls_esc + "H280" + ls_esc + "B102100" + "*" +"Q" + String(id_quantity) + "*" )
//if is_unit <> "PC" and is_unit <> "EA" and is_unit <> "UN" then &
//	PrintSend ( ll_Label, ls_esc + "V245" + ls_esc + "H720" + ls_esc + "L0101" + ls_esc + "WL1" + is_unit )
//
//	Customer PO
PrintSend ( ll_Label, ls_esc + "V056" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "PART DESCRIPTION" )
PrintSend ( ll_Label, ls_esc + "V125" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + ls_name1 )
if len(is_name) > 25 then
	PrintSend ( ll_Label, ls_esc + "V150" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + ls_name2 )		
end if

PrintSend ( ll_Label, ls_esc + "V026" + ls_esc + "H1220" + ls_esc + "$B,50,120,0"  + ls_esc + "$=MASTER"  )
PrintSend ( ll_Label, ls_esc + "V130" + ls_esc + "H1220" + ls_esc + "$B,50,120,0"  + ls_esc + "$=LABEL"  )

//	Destination
PrintSend ( ll_Label, ls_esc + "V265" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "SHIP FROM" )
PrintSend ( ll_Label, ls_esc + "V295" + ls_esc + "H805" + ls_esc + "L0100" + ls_esc + "S" + is_company)
PrintSend ( ll_Label, ls_esc + "V325" + ls_esc + "H805" + ls_esc + "L0100" + ls_esc + "S" + is_caddress1)
PrintSend ( ll_Label, ls_esc + "V355" + ls_esc + "H805" + ls_esc + "L0100" + ls_esc + "S" + is_caddress2)
PrintSend ( ll_Label, ls_esc + "V385" + ls_esc + "H805" + ls_esc + "L0100" + ls_esc + "S" + is_caddress3)

PrintSend ( ll_Label, ls_esc + "V265" + ls_esc + "H1120" + ls_esc + "M" + "SHIP TO" )
PrintSend ( ll_Label, ls_esc + "V295" + ls_esc + "H1120" + ls_esc + "L0100" + ls_esc + "S" + is_dname)
PrintSend ( ll_Label, ls_esc + "V325" + ls_esc + "H1120" + ls_esc + "L0100" + ls_esc + "S" + is_daddress1)
PrintSend ( ll_Label, ls_esc + "V355" + ls_esc + "H1120" + ls_esc + "L0100" + ls_esc + "S" + is_daddress2)
PrintSend ( ll_Label, ls_esc + "V385" + ls_esc + "H1120" + ls_esc + "L0100" + ls_esc + "S" + is_daddress3)

//	Supplier Info
PrintSend ( ll_Label, ls_esc + "V455" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "SUPLR ID" )
PrintSend ( ll_Label, ls_esc + "V480" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "(V)" )
PrintSend ( ll_Label, ls_esc + "V470" + ls_esc + "H390" + ls_esc + "L0101" + ls_esc + "WL1" + is_suppliercode )
if len(is_suppliercode) < 9 then
   PrintSend ( ll_Label, ls_esc + "V520" + ls_esc + "H280" + ls_esc + "B102095" + "*" + "V" + is_suppliercode + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V520" + ls_esc + "H280" + ls_esc + "B102095" + "*" + "V" + is_suppliercode + "*"  )
end if

//	Ship from Info
PrintSend ( ll_Label, ls_esc + "V455" + ls_esc + "H880" + ls_esc + "L0101" + ls_esc + "M" + "CHANGE LEVEL" )
PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H920" + ls_esc + "L0202" + ls_esc + "M" + isnull(ls_ecl,'') )

PrintSend ( ll_Label, ls_esc + "V455" + ls_esc + "H1150" + ls_esc + "L0101" + ls_esc + "M" + "WEIGHT" )
PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H1160" + ls_esc + "L0202" + ls_esc + "M" + string(round(ld_weight,0)) + ' LBS') 

PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H880" + ls_esc + "L0101" + ls_esc + "M" + "STATION" )
PrintSend ( ll_Label, ls_esc + "V695" + ls_esc + "H920" + ls_esc + "L0202" + ls_esc + "M" + ls_doccode)

PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H1150" + ls_esc + "L0101" + ls_esc + "M" + "DROP ZONE" )
PrintSend ( ll_Label, ls_esc + "V695" + ls_esc + "H1160" + ls_esc + "L0202" + ls_esc + "M" + ls_zonecode)

ls_nextboxno = '000'
if ls_ocustom4 = '' then setnull(ls_ocustom4)
if isnull(ls_ocustom4,'') = '' then
if ls_ccustom4 = '' then setnull(ls_ccustom4)
	if isnull(ls_ccustom4,'') > '' then
		if date(ls_ccustom4) = today() then
			if ls_ccustom5 = '' then setnull(ls_ccustom5)
			ll_nextboxno = long(isnull(ls_ccustom5,'0')) + 1
			ls_nextboxno = right( ('000'+string(ll_nextboxno)), 3)
			ls_ccustom4 = string(today())
			ls_ccustom5 = ls_nextboxno
		else
			ls_nextboxno = '001'
			ls_ccustom4 = string(today())
			ls_ccustom5 = ls_nextboxno
		end if 
	else
		ls_nextboxno = '001'
		ls_ccustom4 = string(today())
		ls_ccustom5 = ls_nextboxno
	end if
else
	ls_nextboxno = ls_ocustom4
end if

update	object
set	custom4 = :ls_nextboxno
where	serial = :il_serial;

update	customer
set	custom4 = :ls_ccustom4,
	custom5 = :ls_nextboxno
where	customer = :ls_customer;	

COMMIT;

ls_seril = isnull(ls_ecl,'')+juliandate()+ls_nextboxno

ls_serial = "4S"+trim(ls_seril)

//	Serial Number Info
PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL " )
PrintSend ( ll_Label, ls_esc + "V665" + ls_esc + "H250" + ls_esc + "L0101" + ls_esc + "M" + "(4S)" )
PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H390" + ls_esc + "L0101" + ls_esc + "WL1" + ls_seril)
PrintSend ( ll_Label, ls_esc + "V695" + ls_esc + "H280" + ls_esc + "B102100" + "*" + ls_serial + "*")

//  Draw Lines
PrintSend ( ll_Label, ls_esc + "N" )
PrintSend ( ll_Label, ls_esc + "V632" + ls_esc + "H020" + ls_esc + "FW02H0430" )
PrintSend ( ll_Label, ls_esc + "V225" + ls_esc + "H020" + ls_esc + "FW02H0240" )
PrintSend ( ll_Label, ls_esc + "V320" + ls_esc + "H260" + ls_esc + "FW02H0190" )
PrintSend ( ll_Label, ls_esc + "V550" + ls_esc + "H447" + ls_esc + "FW02H0370" )
PrintSend ( ll_Label, ls_esc + "V285" + ls_esc + "H447" + ls_esc + "FW02H0370" )
PrintSend ( ll_Label, ls_esc + "V028" + ls_esc + "H260" + ls_esc + "FW02V1147" )
PrintSend ( ll_Label, ls_esc + "V028" + ls_esc + "H447" + ls_esc + "FW02V1147" )
PrintSend ( ll_Label, ls_esc + "V028" + ls_esc + "H628" + ls_esc + "FW02V1147" )

PrintSend ( ll_Label, ls_esc + ls_numberoflabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )

Close ( this )
end event
