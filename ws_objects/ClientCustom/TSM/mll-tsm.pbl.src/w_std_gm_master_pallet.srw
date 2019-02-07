$PBExportHeader$w_std_gm_master_pallet.srw
$PBExportComments$STANDARD GM MASTER PALLET LABEL
forward
global type w_std_gm_master_pallet from Window
end type
end forward

global type w_std_gm_master_pallet from Window
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
end type
global w_std_gm_master_pallet w_std_gm_master_pallet

type variables
st_generic_structure	i_st_parm
end variables

forward prototypes
public subroutine wf_print_label ()
public subroutine wf_print_circled_inverted_delta (long ll_label)
end prototypes

public subroutine wf_print_label ();/////////////////////////////////////////////////
//  Declaration
//


STRING	l_s_loc, &
			l_s_lot, &
			l_s_unit, &
			l_s_part, &
			l_s_customer_part, &
			l_s_customer_po, &
			l_s_description, &
			l_s_supplier_code, &
			l_s_destination, &
			l_s_company, &
			l_s_part_description, &
			l_s_Part_description_short, &
			l_s_address_1, &
			l_s_address_2, &
			l_s_address_3, &
			l_s_phone_number, &
			l_s_number_of_labels, &
			l_s_line_feed, &
			l_s_dock_code, &
			l_s_operator, &
			l_s_engineering_level, &
			l_s_package_type, &
			l_s_weight, &
			l_s_safety_part,   &
			l_s_destination_name, &
			l_s_destination_address_1, &
			l_s_destination_address_2, &
			l_s_destination_address_3, &
			l_s_line11, &
			l_s_line12, &
			l_s_line13, &
			l_s_line14, &
			l_s_line15, &
			l_s_line16, &
			l_s_line17, &
			cEsc, &
			cRS, &
			cGS, &
			cEOT, &
			l_s_2d_data
			
Integer  l_i_char_encoded, &
			l_i_child_serials, &
			i

Long     l_l_serial, &
			ll_Label, &
			l_l_shipper
 

Dec {0} l_dec_quantity
Dec {0} l_dec_box_qty
Dec 	  l_dec_weight
Dec	  l_dec_tare_weight
Dec	  l_dec_pallet_tare_weight
Dec     l_dec_gross_weight

DateTime		l_dt_ship_date

/////////////////////////////////////////////////////////////////////////////////////////////
//  Initialization
//

l_l_serial = Long ( i_st_parm.Value1 )

  SELECT part,   
         lot,   
         location,   
         unit_measure,   
			operator,
			engineering_level,
			package_type
	 INTO :l_s_part,   
         :l_s_lot,   
         :l_s_loc,   
         :l_s_unit,   
			:l_s_operator,
			:l_s_engineering_level,
			:l_s_package_type
    FROM object  
   WHERE parent_serial = :l_l_serial ;
	
  SELECT sum( quantity ),
			sum( weight ),
			sum( tare_weight ),
			count( object.serial ),
			max( quantity )
    INTO :l_dec_quantity,
			:l_dec_weight,
			:l_dec_tare_weight,
			:l_i_child_serials,
			:l_dec_box_qty
	 FROM	object
   WHERE parent_serial = :l_l_serial ;	 

  SELECT tare_weight,
  			shipper
	 INTO :l_dec_pallet_tare_weight   ,
	 		:l_l_shipper
    FROM object  
   WHERE serial = :l_l_serial ;

  SELECT	safety_part
    INTO	:l_s_safety_part
    FROM	part_inventory
   WHERE	part = :l_s_part  ;

  SELECT name, description_short
    INTO :l_s_part_description, 
			:l_s_part_description_short
    FROM part
   WHERE part = :l_s_part ;
	
  SELECT	Max ( order_header.customer_part ),
  			Max ( order_header.line_feed_code ),
			Max ( order_header.dock_code ),
			Max ( order_header.package_type ),
			Max ( edi_setups.supplier_code ),
			Max ( edi_setups.destination ),
			Max ( order_header.customer_po ),
			Max ( order_header.line11 ),
			Max ( order_header.line12 ),
			Max ( order_header.line13 ),
			Max ( order_header.line14 ),
			Max ( order_header.line15 ),
			Max ( order_header.line16 ),
			Max ( order_header.line17 )
    INTO	:l_s_customer_part,
	 		:l_s_line_feed,
			:l_s_dock_code,
			:l_s_package_type,
			:l_s_supplier_code,
			:l_s_destination,
			:l_s_customer_po,
			:l_s_line11,
			:l_s_line12,
			:l_s_line13,
			:l_s_line14,
			:l_s_line15,
			:l_s_line16,
			:l_s_line17	
	 FROM	edi_setups,
	 		object,
			order_header,
			shipper_detail
	WHERE	( CONVERT ( int, object.origin ) = shipper_detail.shipper  OR
			object.shipper = shipper_detail.shipper ) AND
			object.part = shipper_detail.part_original AND
			shipper_detail.order_no = order_header.order_no AND
			order_header.destination = edi_setups.destination AND
			parent_serial = :l_l_serial ;
				
  SELECT parameters.company_name, address_1, address_2, address_3, phone_number
	 INTO :l_s_company,
		   :l_s_address_1,
			:l_s_address_2,
			:l_s_address_3,
			:l_s_phone_number
	 FROM parameters ;

  SELECT Destination.name, address_1, address_2, address_3
	INTO 	:l_s_destination_name,
		  	:l_s_destination_address_1,
		  	:l_s_destination_address_2,
		  	:l_s_destination_address_3
	FROM  destination
	WHERE Destination =  :l_s_destination ;

  SELECT date_stamp
	INTO 	:l_dt_ship_date
	FROM  shipper
	WHERE shipper.id = :l_l_shipper ;

// Format Weight to Round Off with No Decimal Point)
l_dec_weight = round( l_dec_weight * .4536, 0 )
l_dec_tare_weight = round( ( l_dec_tare_weight + l_dec_pallet_tare_weight ) * .4536, 0 )
l_dec_gross_weight = ( l_dec_weight + l_dec_tare_weight )

// Format Phone Number to (NNN) NNN-NNNN
IF left( l_s_phone_number,1 ) = "(" THEN
	l_s_phone_number = l_s_phone_number
	ELSE
	l_s_phone_number = "(" + left( l_s_phone_number, 3 ) + ") " + &
		mid( l_s_phone_number, 4, 3 ) + "-" + mid( l_s_phone_number, 7 )
END IF

// Check for null columns
IF isnull( l_s_supplier_code ) then l_s_supplier_code = ""
//l_s_supplier_code = "123456789"

// Set up control chars for 2D codes

cRS = "~h1e"
cGS = "~h1d"
cEOT = "~h04"

//// Get data for each box
//
//dw_1.SetTransObject(SQLCA)
//dw_1.Retrieve(l_l_Serial)
//l_i_boxcnt = dw_1.Rowcount()
//
//// data limit
//if l_i_boxcnt > 27 then l_i_boxcnt = 27
//
//For i=1 to l_i_boxcnt
//	l_s_2d_data = l_s_2d_data + cRS + "06" + &
//		cGS + "P" + dw_1.GetItemString(i, "customer_part") + &
//		cGS + "1JUN" + l_s_supplier_code + string( dw_1.GetItemNumber(i, "object_serial") ) + &
//		cGS + "Q" + string( round( dw_1.GetItemNumber(i, "object_quantity"), 0 ) )
//Next
////		cGS + "S" + string( dw_1.GetItemNumber(i, "object_serial") ) + &

// Header 2D data

//// Test Data *******************************************
//l_s_line12 = "22345 TEST"
//l_s_line11 = "2234567"
//l_dec_box_qty = 6000
//l_i_boxcnt = 7000
//l_dec_quantity = 999990
//l_dec_gross_weight = 9999
//l_l_serial = 2234567
//l_s_supplier_code = "123456789"
//l_s_customer_po = "GM1234"



l_s_2d_data = cRS + "06" + cGS + "6JUN" + l_s_supplier_code + String(l_l_serial) &
		+ cGS + "P" + l_s_customer_part &
		+ cGS + "Q" + String( l_dec_box_qty ) &
		+ cGS + "7Q" + String( l_i_child_serials ) + "PK" &
		+ cGS + "7Q" + String( l_dec_quantity ) + "PL" &
		+ cGS + "7Q" + String( l_dec_gross_weight ) + "GT"
if trim(l_s_line11) > "" then
	l_s_2d_data = l_s_2d_data + cGS + "20L" + trim(l_s_line11)
end if
if trim(l_s_line12) > "" then
	l_s_2d_data = l_s_2d_data + cGS + "21L" + trim(l_s_line12)
end if
if l_s_customer_po > "" then
	l_s_2d_data = l_s_2d_data + cGS + "K" + l_s_customer_po
end if

// Add header and trailer to 2D data

if len( l_s_2d_data ) > 2695 then l_s_2d_data = left( l_s_2d_data, 2695 )
l_s_2d_data = "[)>" + l_s_2d_data + cRS + cEOT

// Calculate the Number of Characters to be Encoded on 2D Bar Code
l_i_char_encoded = len( l_s_2d_data )


If i_st_parm.value11 = "" Then 
	l_s_number_of_labels = "Q1"
Else
	l_s_number_of_labels = "Q" + i_st_parm.value11
End If


cEsc = "~h1B"

/////////////////////////////////////////////////////////////////////////////////////////////
//  Main Print Routine
//

ll_Label = PrintOpen ( )

// Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )
PrintSend ( ll_Label, cEsc + "AR" )

// Address Info
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V50" + cEsc + "S" + "FROM:" )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V70" + cEsc + "M" + left ( l_s_company, 19 ) )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V100" + cEsc + "M" + left ( l_s_address_1, 19 ) )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V130" + cEsc + "M" + left ( l_s_address_2, 19 ) )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V160" + cEsc + "M" + left ( l_s_address_3, 19 ) )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V190" + cEsc + "M" + left ( l_s_phone_number, 19 ) )

// Destination Info
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V50" + cEsc + "S" + "TO:" )
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V70" + cEsc + "WB1" + left ( l_s_destination_name, 22 ) )
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V110" + cEsc + "WB1" + left ( l_s_destination_address_1, 22 ) )
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V150" + cEsc + "WB1" + left ( l_s_destination_address_2, 22 ) )
//PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V190" + cEsc + "WB1" + left ( l_s_destination_address_3, 22 ) )

// Dock Code Info
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V200" + cEsc + "S" + "PLANT" )
PrintSend ( ll_Label, cEsc + "H525" + cEsc + "V220" + cEsc + "S" + "DOCK" )
PrintSend ( ll_Label, cEsc + "H585" + cEsc + "V180" + cEsc + "$A,80,80,0" + cEsc + "$=" + l_s_line12 )

// Label Title & Number of Containers
PrintSend ( ll_Label, cEsc + "H1030" + cEsc + "V42" + cEsc + "$B,110,130,0" + cEsc + "$=" + "MASTER" )
PrintSend ( ll_Label, cEsc + "H1060" + cEsc + "V138" + cEsc + "$B,110,130,0" + cEsc + "$=" + "LABEL" )
//PrintSend ( ll_Label, cEsc + "H1075" + cEsc + "V190" + cEsc + "$A,50,50,0" + cEsc + "$=" + string( l_i_child_serials ) + " CONTAINERS" )

// Part Info
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V360" + cEsc + "S" + "PART" )
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V380" + cEsc + "S" + "NUMBER" )
PrintSend ( ll_Label, cEsc + "H320" + cEsc + "V340" + cEsc + "$A,120,120,0" + cEsc + "$=" + l_s_customer_part )

// Print Circled Inverted Delta Symbol if Part is a Safety Item
IF mid( l_s_safety_part, 1 ) = 'Y' THEN
	PrintSend ( ll_Label, cEsc + "H1245" + cEsc + "V370" )
	wf_print_circled_inverted_delta ( ll_Label )
END IF

//// Quantity & Eng Chg Info
//PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V260" + cEsc + "$B,40,40,0" + cEsc + "$=" + String( l_dec_quantity ) + &
//	" PCS TOTAL" )
//PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V300" + cEsc + "$B,40,40,0" + cEsc + "$=" + "REV: " + l_s_engineering_level )

// Material Handling Code Info
PrintSend ( ll_Label, cEsc + "H615" + cEsc + "V260" + cEsc + "S" + "MATERIAL HANDLING CODE" )
PrintSend ( ll_Label, cEsc + "H660" + cEsc + "V270" + cEsc + "$A,90,90,0" + cEsc + "$=" + l_s_line11 )

//// Reference Info
//PrintSend ( ll_Label, cEsc + "H1065" + cEsc + "V260" + cEsc + "S" + "REFERENCE" )
//PrintSend ( ll_Label, cEsc + "H1075" + cEsc + "V270" + cEsc + "$B,90,90,0" + cEsc + "$=" + "" )

// License Plate (Supplier & Serial Info)
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V460" + cEsc + "S" + "LICENSE PLATE (6J)" )
PrintSend ( ll_Label, cEsc + "H260" + cEsc + "V490" + cEsc + "BG03095" + ">H" + "6JUN" + l_s_supplier_code + &
	String(l_l_serial) )
PrintSend ( ll_Label, cEsc + "H280" + cEsc + "V590" + cEsc + "WL1" + "UN" + " " + l_s_supplier_code + " " +  &
	String(l_l_serial) )

// Shipment Date Info
//PrintSend ( ll_Label, cEsc + "H1105" + cEsc + "V460" + cEsc + "S" + "SHIPMENT DATE:" )
//PrintSend ( ll_Label, cEsc + "H1125" + cEsc + "V455" + cEsc + "$A,60,60,0" + cEsc + "$=" + Upper(String( l_dt_ship_date, "ddmmmyyyy" ) ) )
			
// Weight Info
PrintSend ( ll_Label, cEsc + "H1105" + cEsc + "V460" + cEsc + "S" + "GROSS WEIGHT:" )
PrintSend ( ll_Label, cEsc + "H1245" + cEsc + "V450" + cEsc + "$A,45,50,0" + cEsc + "$=" + String( l_dec_gross_weight ) + " KG" )

// Total Quantity
PrintSend ( ll_Label, cEsc + "H1105" + cEsc + "V508" + cEsc + "S" + "TOTAL QTY:" )
PrintSend ( ll_Label, cEsc + "H1245" + cEsc + "V498" + cEsc + "$A,45,50,0" + cEsc + "$=" + String( l_dec_quantity ) )


// Pack Count
PrintSend ( ll_Label, cEsc + "H1105" + cEsc + "V556" + cEsc + "S" + "# PACKS:" )
PrintSend ( ll_Label, cEsc + "H1245" + cEsc + "V546" + cEsc + "$A,45,50,0" + cEsc + "$=" + String( l_i_child_serials ) )

// Quantity Per Pack
PrintSend ( ll_Label, cEsc + "H1105" + cEsc + "V604" + cEsc + "S" + "QTY/PACK:" )
PrintSend ( ll_Label, cEsc + "H1245" + cEsc + "V594" + cEsc + "$A,45,50,0" + cEsc + "$=" + String( l_dec_box_qty ) )

// 2D Bar Code
//PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V650" + cEsc + "S" + "MASTER" )
//PrintSend (ll_Label, cEsc + "H220" + cEsc + "V670" + cEsc + "S" + "DATA" )
//PrintSend ( ll_Label, cEsc + "H300" + cEsc + "V660" + cEsc + "BK030950000" + string( l_i_char_encoded, "0000" ) + l_s_2d_data )
//NOTE: printed much smaller than standards to allow max # of boxes.  Std size only allows about 4.
PrintSend ( ll_Label, cEsc + "H290" + cEsc + "V660" + cEsc + "BK020650026" + string( l_i_char_encoded, "0000" ) + l_s_2d_data )



// Draw Lines
//PrintSend ( ll_Label, cEsc + "N" )

// Horz between Company Address and Part Number
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V250" + cEsc + "FW03H1175" )
// Horz between Part Number and Quantity
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V350" + cEsc + "FW03H1175" )
// Horz between Quantity and Supplier/Serial Number
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V450" + cEsc + "FW03H1175" )
// Horz between Supplier/Serial Number and 2D Bar Code
PrintSend ( ll_Label, cEsc + "H220" + cEsc + "V640" + cEsc + "FW03H1175" )
// Vert between Company Address and Destination
PrintSend ( ll_Label, cEsc + "H515" + cEsc + "V50" + cEsc + "FW03V0200" )
// Vert between Destination and Title
PrintSend ( ll_Label, cEsc + "H980" + cEsc + "V50" + cEsc + "FW03V0200" )
// Vert between Quantity and Material Handling
PrintSend ( ll_Label, cEsc + "H595" + cEsc + "V250" + cEsc + "FW03V100" )
// Vert between Material Handling and Reference
PrintSend ( ll_Label, cEsc + "H1045" + cEsc + "V250" + cEsc + "FW03V100" )
// Vert between Supplier/Serial Number and Shipment Date
PrintSend ( ll_Label, cEsc + "H1095" + cEsc + "V450" + cEsc + "FW03V0410" )

PrintSend ( ll_Label, cEsc + l_s_number_of_labels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )

end subroutine
public subroutine wf_print_circled_inverted_delta (long ll_label);String	cEsc

Constant String	D01 = '0000003FFC000000'
Constant String	D02 = '000003FFFFC00000'
Constant String	D03 = '00001FFFFFF80000'
Constant String	D04 = '00007FC003FE0000'
Constant String	D05 = '0001FC00003F8000'
Constant String	D06 = '0003F000000FC000'
Constant String	D07 = '0007C0000003E000'
Constant String	D08 = '001F00000000F800'
Constant String	D09 = '003E000000007C00'
Constant String	D10 = '007C000000003E00'
Constant String	D11 = '00F0000000000F00'
Constant String	D12 = '01FFFFFFFFFFFF80'
Constant String	D13 = '01FFFFFFFFFFFF80'
Constant String	D14 = '03FFFFFFFFFFFFC0'
Constant String	D15 = '07C0000000000FE0'
Constant String	D16 = '0FE0000000000EF0'
Constant String	D17 = '0EE0000000001E70'
Constant String	D18 = '1EF0000000001C78'
Constant String	D19 = '1C70000000003C38'
Constant String	D20 = '3C7800000000383C'
Constant String	D21 = '383800000000781C'
Constant String	D22 = '383C00000000701C'
Constant String	D23 = '701C00000000700E'
Constant String	D24 = '701E00000000F00E'
Constant String	D25 = '700E00000000E00E'
Constant String	D26 = '700F00000001E00E'
Constant String	D27 = 'E00700000001C007'
Constant String	D28 = 'E00780000003C007'
Constant String	D29 = 'E003800000038007'
Constant String	D30 = 'E003C00000078007'
Constant String	D31 = 'E001C00000070007'
Constant String	D32 = 'E001E000000F0007'
Constant String	D33 = 'E000E000000E0007'
Constant String	D34 = 'E000F000000E0007'
Constant String	D35 = 'E0007000001E0007'
Constant String	D36 = 'E0007800001C0007'
Constant String	D37 = 'E0003800003C0007'
Constant String	D38 = 'E0003C0000380007'
Constant String	D39 = '70001C000078000E'
Constant String	D40 = '70001E000078000E'
Constant String	D41 = '70000E0000F0000E'
Constant String	D42 = '70000F0000E0000E'
Constant String	D43 = '3800070000E0001C'
Constant String	D44 = '3800078001E0001C'
Constant String	D45 = '3C00038001C0003C'
Constant String	D46 = '1C0003C003C00038'
Constant String	D47 = '1E0001C003800078'
Constant String	D48 = '0E0001E007800070'
Constant String	D49 = '0F0000E0070000F0'
Constant String	D50 = '078000F00F0001E0'
Constant String	D51 = '03C000700E0003C0'
Constant String	D52 = '01C000781E000380'
Constant String	D53 = '01E000381C000780'
Constant String	D54 = '00F0003C1C000F00'
Constant String	D55 = '007C001C3C003E00'
Constant String	D56 = '003E001E38007C00'
Constant String	D57 = '001F000E7800F800'
Constant String	D58 = '0007C00F7003E000'
Constant String	D59 = '0003F007F00FC000'
Constant String	D60 = '0001FC07E03F8000'
Constant String	D61 = '00007FC3E3FE0000'
Constant String	D62 = '00001FFFFFF80000'
Constant String	D63 = '000003FFFFC00000'
Constant String	D64 = '0000003FFC000000'

cEsc = "~h1b"

//PrintSend (ll_label, cEsc + 'GH001001' + D65 )

PrintSend (ll_label, cEsc + 'GH008008' )
PrintSend (ll_label, D01 + D02 + D03 + D04 + D05 + D06 + D07 + D08 + D09 + D10 + &
	D11 + D12 + D13 + D14 + D15 + D16 + D17 + D18 + D19 + D20 + D21 + D22 + D23 + &
	D24 + D25 + D26 + D27 + D28 + D29 + D30 + D31 + D32 + D33 + D34 + D35 + D36 + &
	D37 + D38 + D39 + D40 + D41 + D42 + D43 + D44 + D45 + D46 + D47 + D48 + D49 + &
	D50 + D51 + D52 + D53 + D54 + D55 + D56 + D57 + D58 + D59 + D60 + D61 + D62 + &
	D63 + D64 )
end subroutine

event open;i_st_parm = Message.PowerObjectParm

//label = CREATE label

wf_print_label ( )

Close ( this )
end event

on w_std_gm_master_pallet.create
end on

on w_std_gm_master_pallet.destroy
end on

