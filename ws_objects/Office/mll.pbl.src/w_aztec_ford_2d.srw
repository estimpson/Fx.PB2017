$PBExportHeader$w_aztec_ford_2d.srw
forward
global type w_aztec_ford_2d from w_label_base
end type
end forward

global type w_aztec_ford_2d from w_label_base
end type
global w_aztec_ford_2d w_aztec_ford_2d

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//
//   Ford 2D Label of 10/04
//   10/04 Bruce H.
//   Mod 11/04 by Bruce H. for Aztec, particularly adjusting rotation and horizontal
//      positioning.
//
//////////////////////////////////////////////////////////////////////////////////////////
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

//	Declarations
string	ls_numberoflabels, &
			ls_esc, &
			ls_rs, &
			ls_gs, &
			ls_eot, &
			ls_2d_data, &
			ls_container, &
			ls_container_std, &
			ls_packsize_std, &
			ls_show_custpart, &
			ls_packagetype, &
			ls_packagetype_std

long		ll_label, &
			ll_char_encoded, &
			ll_partcnt, &
			ll_pos

decimal	ld_packsize_std, &
			ld_weight

boolean	lb_mixedload

// Additional Data Gather

// Check pallet for mixed load
if is_type = 'S' then
	select	count(distinct part)
	into		:ll_partcnt
	from		object
	where		object.parent_serial = :il_serial ;

	if ll_partcnt > 1 then
		lb_mixedload = true
	else
		lb_mixedload = false
	end if
else
	lb_mixedload = false
end if


if not lb_mixedload then
	// Weight, Container
	if is_type = 'S' then // master
			select	sum(weight + tare_weight),
						max(package_type)
			into		:ld_weight,
						:ls_packagetype
			from		object
			where		object.parent_serial = :il_serial ;
	else // carton
		select	weight + tare_weight,
					package_type
		into		:ld_weight,
					:ls_packagetype
		from		object
		where		object.serial = :il_serial ;
	end if
	
	select	name
	into		:ls_container
	from		package_materials
	where		code = :ls_packagetype ;

	// Standard Container and Pack Qty
	select	pm.name,
				oh.package_type,
				oh.standard_pack
	into		:ls_container_std,
				:ls_packagetype_std,
				:ld_packsize_std
	from		order_header oh
	join		package_materials pm on oh.package_type = pm.code
	where		oh.order_no = :il_order ;

end if


//// TEST DATA *******************
//is_zone = 'LOC1-67890'
//is_linefeed = 'LOC2-67890'
//id_quantity = 123456
//is_customerpart = 'PART567 901234567 90123456'
//is_lot = 'LOT4567890'
//il_serial = 1234567
//is_suppliercode = 'SUPPL'
//is_ohdestination = '12345'
//ls_container = 'BASE56789 SUFIX'
//ls_container_std = 'STD456789 SUFIX'
//ld_packsize_std = 99999999
//ld_weight = 999999
//is_dockcode = 'WD3'
//// END TEST DATA ***************


// Define Control Chars for 2D
ls_rs = "~h1e"
ls_gs = "~h1d"
ls_eot = "~h04"

// Format 2D Data
ls_2d_data = ls_rs + "06"
ls_2d_data = ls_2d_data + ls_gs + "V" + is_suppliercode
ls_2d_data = ls_2d_data + ls_gs + "18D" + upper ( string ( idt_objdate, "ddmmmyyyy" ) )
if is_dockcode > "" then
	ls_2d_data = ls_2d_data + ls_gs + "1L" + is_dockcode
end if

if lb_mixedload then
	ls_2d_data = ls_2d_data + ls_gs + "5S" + string( il_serial )
else // both carton and master
	ls_2d_data = ls_2d_data + ls_gs + "P" + is_customerpart
	ls_2d_data = ls_2d_data + ls_gs + "Q" + string( id_quantity )
	if is_zone > "" then
		ls_2d_data = ls_2d_data + ls_gs + "L" + is_zone
	end if
	if is_linefeed > "" then
		ls_2d_data = ls_2d_data + ls_gs + "20L" + is_linefeed
	end if
	if is_type = 'S' then // master only
		ls_2d_data = ls_2d_data + ls_gs + "4S" + string( il_serial )
	else // carton only
		if is_lot > "" then
			ls_2d_data = ls_2d_data + ls_gs + "1T" + is_lot
		end if
		ls_2d_data = ls_2d_data + ls_gs + "S" + string( il_serial )
	end if
end if

// Add Start and End
ls_2d_data = "[)>" + ls_2d_data + ls_rs + ls_eot

// Calculate the Number of Characters to be Encoded on 2D Bar Code
ll_char_encoded = len( ls_2d_data )

// Modify Human-readable cust part
ls_show_custpart = is_customerpart
ll_pos = pos(ls_show_custpart, ' ')
do while ll_pos > 0
	ls_show_custpart = left( ls_show_custpart, ll_pos - 1 ) + '-' + mid( ls_show_custpart, ll_pos + 1 )
	ll_pos = pos(ls_show_custpart, ' ')
loop

//	Initialization
ls_esc	= "~h1B"
ls_numberoflabels = "Q1"

//	Determine the number of labels to be printed
If is_nooflabels > "" Then ls_numberoflabels = "Q" + is_nooflabels

 
//  Start Printing
ll_Label = PrintOpen ( )
//PrintSend ( ll_Label, ls_Esc + "A" + ls_Esc + "R" )
PrintSend ( ll_Label, ls_Esc + "A" )
PrintSend ( ll_Label, ls_Esc + "AR" )
SetPointer(HourGlass!)

//// Change orientation for testing
//PrintSend ( ll_Label, ls_Esc + "R" + ls_Esc + "R" + ls_Esc + "R" )

// Address Info
PrintSend ( ll_Label, ls_esc + "V20" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "FROM" )
PrintSend ( ll_Label, ls_esc + "V45" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_company, 24 ) ) )
PrintSend ( ll_Label, ls_esc + "V70" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_caddress1, 24 ) ) )
PrintSend ( ll_Label, ls_esc + "V95" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_caddress2, 24 ) ) )
PrintSend ( ll_Label, ls_esc + "V120" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_caddress3, 24 ) ) )
PrintSend ( ll_Label, ls_esc + "V185" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "MADE IN USA" )

// Destination Info
PrintSend ( ll_Label, ls_esc + "V20" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + "TO" )
PrintSend ( ll_Label, ls_esc + "V45" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_dname, 30 ) ) )
PrintSend ( ll_Label, ls_esc + "V70" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_daddress1, 30 ) ) )
PrintSend ( ll_Label, ls_esc + "V95" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_daddress2, 30 ) ) )
PrintSend ( ll_Label, ls_esc + "V120" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_daddress3, 30 ) ) )

// Loc 1 (Zone)
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V155" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + "STR" )
	PrintSend ( ll_Label, ls_esc + "V175" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + "LOC 1" )
	PrintSend ( ll_Label, ls_esc + "V130" + ls_esc + "H485" + ls_esc + "$B,60,88,0" + ls_esc + "$=" + is_zone )
end if

// 2D Bar Code
PrintSend ( ll_Label, ls_esc + "V20" + ls_esc + "H870" + ls_esc + "BK020650031" + string( ll_char_encoded, "0000" ) + ls_2d_data )

//	Quantity Info
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V213" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "QTY" )
	PrintSend ( ll_Label, ls_esc + "V231" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "(Q)" )
	PrintSend ( ll_Label, ls_esc + "V212" + ls_esc + "H60" + ls_esc + "L0303" + ls_esc + "S" + String(id_quantity, "######0") )
	PrintSend ( ll_Label, ls_esc + "V250" + ls_esc + "H60" + ls_esc + "BG03055" + ">H" + "Q" + ">C" + String(id_quantity,"000000") )
	if is_unit <> "PC" and is_unit <> "EA" and is_unit <> "UN" then
		PrintSend ( ll_Label, ls_esc + "V212" + ls_esc + "H305" + ls_esc + "L0202" + ls_esc + "M" + is_unit )
	end if
end if

//	Loc 2 (Linefeed)
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V220" + ls_esc + "H395" + ls_esc + "L0101" + ls_esc + "M" + "LINE FEED LOC 2" )
	PrintSend ( ll_Label, ls_esc + "V230" + ls_esc + "H395" + ls_esc + "$B,60,88,0" + ls_esc + "$=" + is_linefeed )
end if

//	Destination Code
PrintSend ( ll_Label, ls_esc + "V220" + ls_esc + "H840" + ls_esc + "L0101" + ls_esc + "M" + "CUST" )
PrintSend ( ll_Label, ls_esc + "V230" + ls_esc + "H840" + ls_esc + "$B,60,88,0" + ls_esc + "$=" + left ( is_destination, 5 ) )

// Part
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V315" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "PART NO (P)" )
	PrintSend ( ll_Label, ls_esc + "V315" + ls_esc + "H60" + ls_esc + "$B,76,128,0" + ls_esc + "$=" + ls_show_custpart )
	PrintSend ( ll_Label, ls_esc + "V420" + ls_esc + "H60" + ls_esc + "BG03075" + ">H" + "P" + is_customerpart )
end if

// Engineering Alert
// Delta (for safety parts

// Supplier Code
PrintSend ( ll_Label, ls_esc + "V505" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "SUPP (V)" )
PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H60" + ls_esc + "BG03055" + ">H" + "V" + is_suppliercode )
PrintSend ( ll_Label, ls_esc + "V505" + ls_esc + "H420" + ls_esc + "$B,60,88,0" + ls_esc + "$=" + is_suppliercode )

// Container and Gross Weight
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V540" + ls_esc + "H620" + ls_esc + "L0101" + ls_esc + "M" + "CONTAINER" )
	PrintSend ( ll_Label, ls_esc + "V560" + ls_esc + "H620" + ls_esc + "L0202" + ls_esc + "S" + ls_container )
end if
PrintSend ( ll_Label, ls_esc + "V505" + ls_esc + "H965" + ls_esc + "L0101" + ls_esc + "M" + "GROSS WGT" )
PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H1015" + ls_esc + "L0202" + ls_esc + "S" + string( ld_weight, "#####0" ) )
PrintSend ( ll_Label, ls_esc + "V535" + ls_esc + "H1165" + ls_esc + "L0101" + ls_esc + "M" + "LB" )

// Supplier Area
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V600" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "WB1" + is_part )
	PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "WB1" + left ( is_name, 34 ) )
	PrintSend ( ll_Label, ls_esc + "V600" + ls_esc + "H480" + ls_esc + "L0101" + ls_esc + "M" + ls_container_std )
	PrintSend ( ll_Label, ls_esc + "V620" + ls_esc + "H560" + ls_esc + "L0101" + ls_esc + "M" + string( ld_packsize_std, "#####0" ) )
end if
PrintSend ( ll_Label, ls_esc + "V600" + ls_esc + "H740" + ls_esc + "L0101" + ls_esc + "M" + "DATE" )
PrintSend ( ll_Label, ls_esc + "V620" + ls_esc + "H725" + ls_esc + "L0101" + ls_esc + "M" + upper ( string ( idt_objdate, "ddmmmyyyy" ) ) )

if is_type = 'S' then
	if lb_mixedload then
		PrintSend ( ll_Label, ls_esc + "V745" + ls_esc + "H500" + ls_esc + "L0202" + ls_esc + "M" + "MIXED LABEL" )
	else
		PrintSend ( ll_Label, ls_esc + "V745" + ls_esc + "H500" + ls_esc + "L0202" + ls_esc + "M" + "MASTER LABEL" )
	end if
end if

// Serial
if is_type = 'S' then
	if lb_mixedload then
		PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (5S)" )
		PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H260" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H60" + ls_esc + "BG03075" + ">H" + "5S" + string( il_serial ) )
	else // Master
		PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (4S)" )
		PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H260" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H60" + ls_esc + "BG03075" + ">H" + "4S" + string( il_serial ) )
	end if
else // Carton
	PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H20" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (S)" )
	PrintSend ( ll_Label, ls_esc + "V675" + ls_esc + "H260" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
	PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H60" + ls_esc + "BG03075" + ">H" + "S" + string( il_serial ) )
end if

// Dock Code
PrintSend ( ll_Label, ls_esc + "V600" + ls_esc + "H880" + ls_esc + "L0101" + ls_esc + "M" + "DOCK CODE" )
if is_type = 'S' then
	PrintSend ( ll_Label, ls_esc + "V590" + ls_esc + "H905" + ls_esc + "$B,158,185,0" + ls_esc + "$=" + left ( is_dockcode, 3 ) )
	if lb_mixedload then
		PrintSend ( ll_Label, ls_esc + "V750" + ls_esc + "H895" + ls_esc + "L0202" + ls_esc + "S" + "MIXED LABEL" )
	else
		PrintSend ( ll_Label, ls_esc + "V750" + ls_esc + "H895" + ls_esc + "L0202" + ls_esc + "S" + "MASTER LABEL" )
	end if
else
	PrintSend ( ll_Label, ls_esc + "V585" + ls_esc + "H905" + ls_esc + "$B,158,210,0" + ls_esc + "$=" + left ( is_dockcode, 3 ) )
end if

//  Draw Lines
PrintSend ( ll_label, ls_Esc + "V210" + ls_Esc + "H20" + ls_Esc + "FW02H810" )
PrintSend ( ll_label, ls_Esc + "V305" + ls_Esc + "H20" + ls_Esc + "FW02H1180" )
PrintSend ( ll_label, ls_Esc + "V495" + ls_Esc + "H20" + ls_Esc + "FW02H1180" )
PrintSend ( ll_label, ls_Esc + "V590" + ls_Esc + "H20" + ls_Esc + "FW02H1180" )

PrintSend ( ll_label, ls_Esc + "V20" + ls_Esc + "H385" + ls_Esc + "FW02V190" )
PrintSend ( ll_label, ls_Esc + "V210" + ls_Esc + "H385" + ls_Esc + "FW02V095" )
PrintSend ( ll_label, ls_Esc + "V210" + ls_Esc + "H830" + ls_Esc + "FW02V095" )
PrintSend ( ll_label, ls_Esc + "V495" + ls_Esc + "H610" + ls_Esc + "FW02V095" )
PrintSend ( ll_label, ls_Esc + "V590" + ls_Esc + "H870" + ls_Esc + "FW02V190" )


PrintSend ( ll_Label, ls_esc + ls_numberoflabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )
Close ( this )

end event

on w_aztec_ford_2d.create
call super::create
end on

on w_aztec_ford_2d.destroy
call super::destroy
end on

