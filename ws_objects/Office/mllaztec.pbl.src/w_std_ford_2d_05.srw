$PBExportHeader$w_std_ford_2d_05.srw
forward
global type w_std_ford_2d_05 from w_label_base
end type
end forward

global type w_std_ford_2d_05 from w_label_base
end type
global w_std_ford_2d_05 w_std_ford_2d_05

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//
//   Ford 2D Label of 04/05
//   06/05 Bruce H.
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
			ls_packagetype_std, &
			ls_safetypart

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

// Safety Part
SELECT safety_part
INTO :ls_safetypart
FROM part_inventory
WHERE part = :is_part ;


//// TEST DATA *******************
//is_zone = 'LOC1-67890'
//is_linefeed = 'LOC2-67890'
//id_quantity = 123456
//is_customerpart = 'PART567 901234567 90123456'
////is_customerpart = 'PART567 901234567'
//is_lot = 'LOT4567890'
//il_serial = 1234567
//is_suppliercode = 'SUPPL'
//is_ohdestination = '12345'
//ls_container = 'BASE56789 SUFIX'
////ls_container_std = 'STD456789 SUFIX'
////ld_packsize_std = 99999999
//ld_weight = 999999
//is_dockcode = 'WD3'
//ls_safetypart = 'Y'
//is_name = 'VERY LONG PART NAME UP TO 34_WILL_BE_INCLUDED...'
//is_dname = 'FORD ASSEMBLY WIXON TRIM AND BODY BUILDERS'
//is_company = 'SUPPLIER A1 AND LOCAL DB MANUFACTURING AND MOD'
//// END TEST DATA ***************


// Define Control Chars for 2D
ls_rs = "~h1e"
ls_gs = "~h1d"
ls_eot = "~h04"

// Format 2D Data
ls_2d_data = ls_rs + "06"
ls_2d_data = ls_2d_data + ls_gs + "V" + is_suppliercode
ls_2d_data = ls_2d_data + ls_gs + "D" + upper ( string ( idt_objdate, "yymmdd" ) )
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

// Make sure destination starts with FORD
if upper(left(is_dname, 4)) <> "FORD" then
	is_dname = "FORD " + is_dname
end if

//	Initialization
ls_esc	= "~h1B"
ls_numberoflabels = "Q1"

//	Determine the number of labels to be printed
If is_nooflabels > "" Then ls_numberoflabels = "Q" + is_nooflabels

 
//  Start Printing
ll_Label = PrintOpen ( )
PrintSend ( ll_Label, ls_Esc + "A" + ls_Esc + "R" )
PrintSend ( ll_Label, ls_Esc + "AR" )
SetPointer(HourGlass!)

// Supplier Code
PrintSend ( ll_Label, ls_esc + "V40" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "SUPP (V)" )
PrintSend ( ll_Label, ls_esc + "V40" + ls_esc + "H380" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_company, 35 ) ) )
PrintSend ( ll_Label, ls_esc + "V60" + ls_esc + "H260" + ls_esc + "BG03075" + ">H" + "V" + is_suppliercode )
PrintSend ( ll_Label, ls_esc + "V65" + ls_esc + "H660" + ls_esc + "$B,100,88,0" + ls_esc + "$=" + is_suppliercode )

// Master Label
if is_type = 'S' then
	if not(lb_mixedload) then
		PrintSend ( ll_Label, ls_esc + "V40" + ls_esc + "H1040" + ls_esc + "L0101" + ls_esc + "WL1" + "MASTER LABEL" )
	end if
end if

// 2D Bar Code
PrintSend ( ll_Label, ls_esc + "V100" + ls_esc + "H1080" + ls_esc + "BK020650031" + string( ll_char_encoded, "0000" ) + ls_2d_data )

//	Quantity Info
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V150" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "QTY" )
	PrintSend ( ll_Label, ls_esc + "V175" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "(Q)" )
	PrintSend ( ll_Label, ls_esc + "V130" + ls_esc + "H280" + ls_esc + "$B,80,128,0" + ls_esc + "$=" + right( "     " + String(id_quantity,"#####0"), 6 ) )
	PrintSend ( ll_Label, ls_esc + "V240" + ls_esc + "H260" + ls_esc + "BG03090" + ">H" + "Q" + ">C" + String(id_quantity,"000000") )
	if is_unit <> "PC" and is_unit <> "EA" and is_unit <> "UN" then
		PrintSend ( ll_Label, ls_esc + "V300" + ls_esc + "H585" + ls_esc + "L0202" + ls_esc + "S" + is_unit )
	end if
end if

// Container and Gross Weight and Date
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V146" + ls_esc + "H645" + ls_esc + "L0101" + ls_esc + "M" + "CONTAINER" )
	PrintSend ( ll_Label, ls_esc + "V154" + ls_esc + "H645" + ls_esc + "$B,46,65,0" + ls_esc + "$=" + ls_container )
end if
PrintSend ( ll_Label, ls_esc + "V209" + ls_esc + "H645" + ls_esc + "L0101" + ls_esc + "M" + "GROSS WGT" )
PrintSend ( ll_Label, ls_esc + "V217" + ls_esc + "H645" + ls_esc + "$B,46,65,0" + ls_esc + "$=" + right( "     " + string( ld_weight, "#####0"), 6 ) )
PrintSend ( ll_Label, ls_esc + "V252" + ls_esc + "H830" + ls_esc + "L0101" + ls_esc + "M" + "LB" )
PrintSend ( ll_Label, ls_esc + "V272" + ls_esc + "H645" + ls_esc + "L0101" + ls_esc + "M" + "DATE" )
PrintSend ( ll_Label, ls_esc + "V280" + ls_esc + "H645" + ls_esc + "$B,46,65,0" + ls_esc + "$=" + upper ( string ( idt_objdate, "ddmmmyyyy" ) ) )

// Part
if not lb_mixedload then
	if len(ls_show_custpart) > 21 then
		PrintSend ( ll_Label, ls_esc + "V311" + ls_esc + "H220" + ls_esc + "$B,73,159,0" + ls_esc + "$=" + ls_show_custpart )
	elseif len(ls_show_custpart) > 17 then
		PrintSend ( ll_Label, ls_esc + "V311" + ls_esc + "H220" + ls_esc + "$B,90,159,0" + ls_esc + "$=" + ls_show_custpart )
	else
		PrintSend ( ll_Label, ls_esc + "V311" + ls_esc + "H220" + ls_esc + "$B,110,159,0" + ls_esc + "$=" + ls_show_custpart )
	end if
	PrintSend ( ll_Label, ls_esc + "V475" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "PART" )
	PrintSend ( ll_Label, ls_esc + "V500" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "(P)" )
	PrintSend ( ll_Label, ls_esc + "V445" + ls_esc + "H340" + ls_esc + "BG03080" + ">H" + "P" + is_customerpart )
end if

// Inverted Delta (for safety parts)
if ls_safetypart = 'Y' then
	PrintSend ( ll_Label, ls_esc + "V340" + ls_esc + "H1325" + ls_esc + "$A,82,82,0" + ls_esc + "$=" + "\" )
	PrintSend ( ll_Label, ls_esc + "V340" + ls_esc + "H1360" + ls_esc + "$A,82,82,0" + ls_esc + "$=" + "/" )
	PrintSend ( ll_Label, ls_esc + "V350" + ls_esc + "H1325" + ls_esc + "FW05H70" )
end if

// Loc 1 (Zone)
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V535" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "STR LOC 1" )
	PrintSend ( ll_Label, ls_esc + "V545" + ls_esc + "H220" + ls_esc + "$B,100,88,0" + ls_esc + "$=" + is_zone )
end if

//	Loc 2 (Linefeed)
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V535" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + "LINE FEED LOC 2" )
	PrintSend ( ll_Label, ls_esc + "V545" + ls_esc + "H820" + ls_esc + "$B,100,88,0" + ls_esc + "$=" + is_linefeed )
end if

// Supplier Area
if not lb_mixedload then
	PrintSend ( ll_Label, ls_esc + "V630" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "WB1" + is_part )
	PrintSend ( ll_Label, ls_esc + "V670" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "WB1" + left ( is_name, 34 ) )
//	PrintSend ( ll_Label, ls_esc + "V630" + ls_esc + "H680" + ls_esc + "L0101" + ls_esc + "M" + ls_container_std )
//	PrintSend ( ll_Label, ls_esc + "V650" + ls_esc + "H760" + ls_esc + "L0101" + ls_esc + "M" + string( ld_packsize_std, "#####0" ) )
end if

// Serial
if is_type = 'S' then
	if lb_mixedload then
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (5S)" )
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H460" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
		PrintSend ( ll_Label, ls_esc + "V735" + ls_esc + "H260" + ls_esc + "BG03075" + ">H" + "5S" + string( il_serial ) )
	else // Master
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (4S)" )
		PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H460" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
		PrintSend ( ll_Label, ls_esc + "V735" + ls_esc + "H260" + ls_esc + "BG03075" + ">H" + "4S" + string( il_serial ) )
	end if
else // Carton
	PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H220" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL NO (S)" )
	PrintSend ( ll_Label, ls_esc + "V705" + ls_esc + "H460" + ls_esc + "L0202" + ls_esc + "S" + string( il_serial ) )
	PrintSend ( ll_Label, ls_esc + "V735" + ls_esc + "H260" + ls_esc + "BG03075" + ">H" + "S" + string( il_serial ) )
end if

// Destination Name
PrintSend ( ll_Label, ls_esc + "V630" + ls_esc + "H910" + ls_esc + "L0101" + ls_esc + "M" + "TO" )
PrintSend ( ll_Label, ls_esc + "V655" + ls_esc + "H910" + ls_esc + "L0101" + ls_esc + "M" + upper ( left ( is_dname, 30 ) ) )

//	Destination Code
PrintSend ( ll_Label, ls_esc + "V690" + ls_esc + "H945" + ls_esc + "L0101" + ls_esc + "M" + "CUST" )
PrintSend ( ll_Label, ls_esc + "V700" + ls_esc + "H910" + ls_esc + "$B,60,88,0" + ls_esc + "$=" + left ( is_destination, 5 ) )

// Engineering Alert

// Dock Code
PrintSend ( ll_Label, ls_esc + "V630" + ls_esc + "H1265" + ls_esc + "L0101" + ls_esc + "M" + "DOCK CODE" )
PrintSend ( ll_Label, ls_esc + "V660" + ls_esc + "H1125" + ls_esc + "$B,150,128,0" + ls_esc + "$=" + left ( is_dockcode, 3 ) )


//  Draw Lines
PrintSend ( ll_label, ls_Esc + "V140" + ls_Esc + "H220" + ls_Esc + "FW02H810" )
PrintSend ( ll_label, ls_Esc + "V335" + ls_Esc + "H220" + ls_Esc + "FW02H1180" )
PrintSend ( ll_label, ls_Esc + "V525" + ls_Esc + "H220" + ls_Esc + "FW02H1180" )
PrintSend ( ll_label, ls_Esc + "V620" + ls_Esc + "H220" + ls_Esc + "FW02H1180" )

PrintSend ( ll_label, ls_Esc + "V140" + ls_Esc + "H635" + ls_Esc + "FW02V195" )
PrintSend ( ll_label, ls_Esc + "V525" + ls_Esc + "H810" + ls_Esc + "FW02V095" )
PrintSend ( ll_label, ls_Esc + "V620" + ls_Esc + "H900" + ls_Esc + "FW02V190" )


PrintSend ( ll_Label, ls_esc + ls_numberoflabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )
Close ( this )

end event
on w_std_ford_2d_05.create
call super::create
end on

on w_std_ford_2d_05.destroy
call super::destroy
end on

