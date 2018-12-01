$PBExportHeader$w_tsm_gm_ship.srw
forward
global type w_tsm_gm_ship from Window
end type
end forward

global type w_tsm_gm_ship from Window
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
global w_tsm_gm_ship w_tsm_gm_ship

type variables
CONSTANT CHAR		ESC = '~h1B'
CONSTANT STRING	DMEM = '3F'

LONG			i_l_label

st_generic_structure	i_st_parm
end variables

forward prototypes
public subroutine wf_print_label ()
public function integer brklynes (integer l_i_lynesyze, string l_s_txtin)
public subroutine wf_print_circled_inverted_delta (long ll_Label)
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
			l_s_address_1, &
			l_s_address_2, &
			l_s_address_3, &
			l_s_phone_number, &
			l_s_number_of_labels, &
			l_s_line_feed, &
			l_s_dock_code, &
			l_s_package_type, &
			l_s_operator, &
			l_s_engineering_level, &
			l_s_weight, &
			l_s_safety_part,   &
			l_s_origin, &
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
			l_s_Name1, &
			l_s_Name2, &	
			l_s_brktxt, &
			l_s_temp, &
			cEsc, &
			cRS, &
			cGS, &
			cEOT, &
			l_s_2d_data
			
Integer  l_i_char_encoded, &
			l_i_nSize, &							
			l_i_lynebrkloc, &						
			l_i_lyne1, &							
			l_i_lyne2, &							
			l_i_lynestarrt, &					
			l_i_lyneennd		

Long     l_l_serial, &
			l_l_shipper, &
			ll_Label
 

Dec {0} l_dec_quantity
Dec 	  l_dec_weight
Dec	  l_dec_tare_weight
Dec     l_dec_gross_weight

Datetime l_dt_date_time
Time 		l_t_time
Date 		l_d_date

DateTime		l_dt_ship_date


/////////////////////////////////////////////////////////////////////////////////////////////
//  Initialization
//

l_l_serial = Long ( i_st_parm.Value1 )

  SELECT part,   
         lot,   
         location,   
         unit_measure,   
         quantity,
			operator,
			engineering_level,
			weight,
			tare_weight,
			shipper,
			origin,
			package_type,
			last_time
	 INTO :l_s_part,   
         :l_s_lot,   
         :l_s_loc,   
         :l_s_unit,   
         :l_dec_quantity,
			:l_s_operator,
			:l_s_engineering_level,
			:l_dec_weight,
			:l_dec_tare_weight,
			:l_l_shipper,
			:l_s_origin,
			:l_s_package_type,
			:l_dt_date_time
    FROM object  
   WHERE serial = :l_l_serial  ;
	
/* Use Origin for shipper if needed--from packline without autostage */
If ( isnull(l_l_shipper) or l_l_shipper = 0 ) and isNumber(l_s_origin) Then
	l_l_shipper = long(l_s_origin)
End If

  SELECT	safety_part
    INTO	:l_s_safety_part
    FROM	part_inventory
   WHERE	part = :l_s_part  ;

  SELECT name
    INTO :l_s_part_description
			FROM part
   WHERE part = :l_s_part ;
	
  SELECT	order_header.customer_part,
  			order_header.line_feed_code,
			order_header.dock_code,
			edi_setups.supplier_code,
			edi_setups.destination,
			order_header.customer_po,
			order_header.line11,
			order_header.line12,
			order_header.line13,
			order_header.line14,
			order_header.line15,
			order_header.line16,
			order_header.line17
    INTO	:l_s_customer_part,
	 		:l_s_line_feed,
			:l_s_dock_code,
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
			order_header,
			shipper_detail
	WHERE	shipper_detail.part_original = :l_s_part AND
			shipper_detail.shipper = :l_l_shipper AND
			shipper_detail.order_no = order_header.order_no AND
			order_header.destination = edi_setups.destination ;

IF isnull( l_s_customer_po ) then l_s_customer_po = ""
IF isnull( l_s_line11 ) then l_s_line11 = ""
IF isnull( l_s_line12 ) then l_s_line12 = ""
IF isnull( l_s_package_type ) then l_s_package_type = ""
						
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
	WHERE Destination.Destination = :l_s_destination ;
	
  SELECT date_stamp
	INTO 	:l_dt_ship_date
	FROM  shipper
	WHERE shipper.id = :l_l_shipper ;

//// Begin Line Allocation for Part description from 1 to 2 Lines with Variable Size Font
//l_s_temp = mid(l_s_part_description,1,32)   //  note:  Monitor Part Desc = Varchar(50)
//
//// Default to Two Text Lines
//l_i_lyne1 = 0   // clear good text line one value
//l_i_lyne2 = 0   // clear good text line two value
//l_s_brktxt = ""
//
//// Only One Data Line for Part Description < 17
//IF len(l_s_temp) < 16  THEN
//	   l_s_Name1 = Mid(l_s_Temp, 1, 16)
//		l_s_Name2 = " "
//		l_i_nsize = 1
//	END IF
//	
// Only Two Data Lines for Part Description >= 17 and <= 32
//IF ((len(l_s_temp) >= 17) AND (len(l_s_temp) <= 32)) THEN
//		l_i_nsize=2
//		l_i_lynebrkloc = brklynes(17, l_s_temp)
//		IF l_i_lynebrkloc > 0 THEN
//			l_i_lyne1 = 1
//			l_s_name1 = mid(l_s_temp, 1, l_i_lynebrkloc) 
//		   l_i_Lynestarrt = l_i_lynebrkloc + 1 
//			l_i_lyneennd = len(l_s_temp) - l_i_lynebrkloc
//			l_s_brktxt = mid(l_s_temp, l_i_lynestarrt, l_i_lyneennd)
//			l_i_lynebrkloc = brklynes(17, l_s_brktxt)
//			IF l_i_lynebrkloc > 0 THEN
//				l_i_lyne2 = 1
//				l_s_Name2 = mid(l_s_brktxt, 1, 16)
//			END IF     // l_i_lynebrk > 0  text line 2
//		END IF    // l_i_lynebrk > 0  text line 1
//		
//		IF l_i_lyne1 = 0 THEN  // no breakpoint on first line
//		         l_s_Name1 = Mid(l_s_Temp, 1, 17)
//					l_s_Name2 = Mid(l_s_Temp, 18, 14)
//					l_i_lyne2 = 1	
//		END IF
//		
//		IF l_i_lyne2 = 0 THEN // no breakpoint on second line
//					l_s_Name2 = Mid(l_s_brktxt, 1, 16)
//		END IF
//END IF

// Format Phone Number to (NNN) NNN-NNNN
IF left( l_s_phone_number,1 ) = "(" THEN
	l_s_phone_number = l_s_phone_number
	ELSE
	l_s_phone_number = "(" + left( l_s_phone_number, 3 ) + ") " + &
		mid( l_s_phone_number, 4, 3 ) + "-" + mid( l_s_phone_number, 7 )
END IF

IF i_st_parm.value11 = "" THEN 
	l_s_number_of_labels = "Q1"
ELSE
	l_s_number_of_labels = "Q" + i_st_parm.value11
END IF

// Format Weight to Round Off with No Decimal Point)
l_dec_weight = round( l_dec_weight * .4536, 0 )
l_dec_tare_weight = round( l_dec_tare_weight * .4536, 0 )
l_dec_gross_weight = ( l_dec_weight + l_dec_tare_weight )

// Date and Time Manufactured
l_d_date = date(l_dt_date_time)
l_t_time = time(l_dt_date_time)

//// Test Data *******************************************
//l_s_line12 = "22345 TEST"
//l_s_line11 = "2234567"
//l_dec_quantity = 999990
//l_dec_gross_weight = 9999
//l_l_serial = 2234567
//l_s_supplier_code = "123456789"
//l_s_customer_po = "GM1234"
//l_s_customer_part = "22345678"
//l_s_package_type = "CARTON"
//l_s_part_description = "Handle and misc other pieces to use"

// Define Control Chars

cRS = "~h1e"
cGS = "~h1d"
cEOT = "~h04"

// Format 2D Data
l_s_2d_data = cRS + "06" + &
	cGS + "P" + l_s_customer_part + &
	cGS + "Q" + string( l_dec_quantity ) + &
	cGS + "1JUN" + l_s_supplier_code + string( l_l_serial ) + &
	cGS + "7Q" + String( l_dec_gross_weight ) + "GT"

if l_s_line11 > "" then
	l_s_2d_data = l_s_2d_data + cGS + "20L" + l_s_line11
end if
if l_s_line12 > "" then
	l_s_2d_data = l_s_2d_data + cGS + "21L" + l_s_line12
end if
if l_s_customer_po > "" then
	l_s_2d_data = l_s_2d_data + cGS + "K" + l_s_customer_po
end if
if l_s_package_type > "" then
	l_s_2d_data = l_s_2d_data + cGS + "B" + l_s_package_type
end if

// Add Start and End
l_s_2d_data = "[)>" + l_s_2d_data + cRS + cEOT

// Calculate the Number of Characters to be Encoded on 2D Bar Code
l_i_char_encoded = len( l_s_2d_data )


cEsc = "~h1B"

/////////////////////////////////////////////////////////////////////////////////////////////
//  Main Print Routine
//

ll_Label = PrintOpen ( )

// Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )
PrintSend ( ll_Label, cEsc + "AR" )

// Address Info
PrintSend ( ll_Label, cEsc + "V50" + cEsc + "H220" + cEsc + "S" + "FROM:" )
PrintSend ( ll_Label, cEsc + "V70" + cEsc + "H220" + cEsc + "M" + left ( l_s_company, 19 ) )
PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H220" + cEsc + "M" + left ( l_s_address_1, 19 ) )
PrintSend ( ll_Label, cEsc + "V130" + cEsc + "H220" + cEsc + "M" + left ( l_s_address_2, 19 ) )
PrintSend ( ll_Label, cEsc + "V160" + cEsc + "H220" + cEsc + "M" + left ( l_s_address_3, 19 ) )
PrintSend ( ll_Label, cEsc + "V190" + cEsc + "H220" + cEsc + "M" + left ( l_s_phone_number, 19 ) )
PrintSend ( ll_Label, cEsc + "V220" + cEsc + "H220" + cEsc + "$A,30,30,0" + cEsc + "$=" + "ASSMBLD/MADE IN US" )

// Destination Info
PrintSend ( ll_Label, cEsc + "V50" + cEsc + "H525" + cEsc + "S" + "TO:" )
PrintSend ( ll_Label, cEsc + "V70" + cEsc + "H525" + cEsc + "WB1" + left ( l_s_destination_name, 22 ) )
PrintSend ( ll_Label, cEsc + "V110" + cEsc + "H525" + cEsc + "WB1" + left ( l_s_destination_address_1, 22 ) )
PrintSend ( ll_Label, cEsc + "V150" + cEsc + "H525" + cEsc + "WB1" + left ( l_s_destination_address_2, 22 ) )
//PrintSend ( ll_Label, cEsc + "V190" + cEsc + "H525" + cEsc + "WB1" + left ( l_s_destination_address_3, 22 ) )

// Dock Code Info
PrintSend ( ll_Label, cEsc + "V200" + cEsc + "H525" + cEsc + "S" + "PLANT" )
PrintSend ( ll_Label, cEsc + "V220" + cEsc + "H525" + cEsc + "S" + "DOCK" )
PrintSend ( ll_Label, cEsc + "V180" + cEsc + "H585" + cEsc + "$A,80,80,0" + cEsc + "$=" + l_s_line12 )

// 2D Bar Code
PrintSend ( ll_Label, cEsc + "V50" + cEsc + "H1000" + cEsc + "BK020650031" + string( l_i_char_encoded, "0000" ) + l_s_2d_data )

// Part Info
PrintSend ( ll_Label, cEsc + "V360" + cEsc + "H220" + cEsc + "S" + "PART" )
PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H220" + cEsc + "S" + "NUMBER" )
PrintSend ( ll_Label, cEsc + "V340" + cEsc + "H320" + cEsc + "$A,120,120,0" + cEsc + "$=" + l_s_customer_part )

// Print Circled Inverted Delta Symbol if Part is a Safety Item
IF mid( l_s_safety_part, 1 ) = 'Y' THEN
	PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H1245" )
	wf_print_circled_inverted_delta ( ll_Label )
END IF

// Quantity & Eng Chg Info
PrintSend ( ll_Label, cEsc + "V260" + cEsc + "H220" + cEsc + "S" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H220" + cEsc + "$B,70,90,0" + cEsc + "$=" + String( l_dec_quantity ) )
//PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H220" + cEsc + "$B,40,40,0" + cEsc + "$=" + "REV: " + l_s_engineering_level )

// Material Handling Code Info
PrintSend ( ll_Label, cEsc + "V260" + cEsc + "H615" + cEsc + "S" + "MATERIAL HANDLING CODE" )
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H615" + cEsc + "$A,90,90,0" + cEsc + "$=" + l_s_line11 )

// Reference Info
PrintSend ( ll_Label, cEsc + "V260" + cEsc + "H1065" + cEsc + "S" + "REFERENCE" )
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H1075" + cEsc + "$B,60,90,0" + cEsc + "$=" + l_s_customer_po )

// Supplier & Serial Info
PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H220" + cEsc + "S" + "LICENSE PLATE (1J)" )
PrintSend ( ll_Label, cEsc + "V490" + cEsc + "H260" + cEsc + "BG03095" + ">H" + "1JUN" + l_s_supplier_code + &
	String(l_l_serial) )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H260" + cEsc + "WL1" + "UN" + " " + l_s_supplier_code + " " +  &
	String(l_l_serial) )

// Shipment Date Info
PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H1105" + cEsc + "S" + "SHIPMENT DATE:" )
PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H1105" + cEsc + "$A,50,50,0" + cEsc + "$=" + Upper( String( l_dt_ship_date, "ddmmmyyyy" ) ) )

// Container Type Info
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H1105" + cEsc + "S" + "CONTAINER TYPE:" )
PrintSend ( ll_Label, cEsc + "V530" + cEsc + "H1105" + cEsc + "$A,50,50,0" + cEsc + "$=" + l_s_package_type  )

// Weight Info
PrintSend ( ll_Label, cEsc + "V580" + cEsc + "H1105" + cEsc + "S" + "GROSS WEIGHT:" )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H1105" + cEsc + "$A,50,50,0" + cEsc + "$=" + String( l_dec_gross_weight ) + " KG" )

//// Part Info
//PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H220" + cEsc + "S" + "INTERNAL PART NO AND DESCRIPTION" )
//PrintSend ( ll_Label, cEsc + "V670" + cEsc + "H220" + cEsc + "WL1" + l_s_part )
//
//// Part description
//If l_i_Nsize = 1 THEN
//	PrintSend ( ll_Label, cEsc + "V750" + cEsc + "H220" + cEsc + "$A,60,60,0" + cEsc + "$=" + l_s_Name1 )
//END IF
//IF l_i_Nsize = 2 THEN
//	PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H220" + cEsc + "$A,50,50,0" + cEsc + "$=" + l_s_Name1 )
//	PrintSend ( ll_Label, cEsc + "V770" + cEsc + "H220" + cEsc + "$A,50,50,0" + cEsc + "$=" + l_s_Name2 )
//END IF

// Part Info
PrintSend ( ll_Label, cEsc + "V790" + cEsc + "H220" + cEsc + "WB1" + left( l_s_part + "   " + l_s_part_description, 37 ) )

// Serial Number Info
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H220" + cEsc + "S" + "SERIAL (S)" )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H340" + cEsc + "WB1" + String(l_l_serial))
PrintSend ( ll_Label, cEsc + "V680" + cEsc + "H260" + cEsc + "B103095" + "*" + "S" + String(l_l_serial) + "*")

// PCI Info
PrintSend ( ll_Label, cEsc + "V640" + cEsc + "H990" + cEsc + "$B,30,40,0" + cEsc + "$=" + left( l_s_line13, 24 ) )
PrintSend ( ll_Label, cEsc + "V680" + cEsc + "H990" + cEsc + "$B,30,40,0" + cEsc + "$=" + left( l_s_line14, 24 ) )
PrintSend ( ll_Label, cEsc + "V720" + cEsc + "H990" + cEsc + "$B,30,40,0" + cEsc + "$=" + left( l_s_line15, 24 ) )
PrintSend ( ll_Label, cEsc + "V760" + cEsc + "H990" + cEsc + "$B,30,40,0" + cEsc + "$=" + left( l_s_line16, 24 ) )
PrintSend ( ll_Label, cEsc + "V800" + cEsc + "H990" + cEsc + "$B,30,40,0" + cEsc + "$=" + left( l_s_line17, 24 ) )


// Draw Lines

// Horz between Company Address and Quantity
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H220" + cEsc + "FW03H1280" )
// Horz between Quantity and Part Number
PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H220" + cEsc + "FW03H1280" )
// Horz between Part Number and Supplier/Serial Number
PrintSend ( ll_Label, cEsc + "V450" + cEsc + "H220" + cEsc + "FW03H1280" )
// Horz between Supplier/Serial Number and Serial Number
PrintSend ( ll_Label, cEsc + "V640" + cEsc + "H220" + cEsc + "FW03H1280" )
// Horz between Serial Number and Internal Part Number
PrintSend ( ll_Label, cEsc + "V780" + cEsc + "H220" + cEsc + "FW03H760" )
// Vert between Company Address and Destination
PrintSend ( ll_Label, cEsc + "V50" + cEsc + "H515" + cEsc + "FW03V0200" )
// Vert between Destination and 2D Bar Code
PrintSend ( ll_Label, cEsc + "V50" + cEsc + "H980" + cEsc + "FW03V0200" )
// Vert between Quantity and Material Handling
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H595" + cEsc + "FW03V100" )
// Vert between Material Handling and Reference
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H1045" + cEsc + "FW03V100" )
// Vert between Supplier/Serial Number and Shipment Date
PrintSend ( ll_Label, cEsc + "V450" + cEsc + "H1095" + cEsc + "FW03V0190" )
// Vert between Serial Number and PCI
PrintSend ( ll_Label, cEsc + "V640" + cEsc + "H980" + cEsc + "FW03V0220" )

PrintSend ( ll_Label, cEsc + l_s_number_of_labels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )

end subroutine
public function integer brklynes (integer l_i_lynesyze, string l_s_txtin);integer l_i_poynter, l_i_starrt, l_i_ennd, l_i_loupe, l_i_txtsyze

l_i_poynter=0
l_i_starrt=0
l_i_ennd=0

l_i_loupe = l_i_lynesyze  // size of text per line
l_i_txtsyze = len(l_s_txtin)  // length of string in

do while l_i_loupe <> 0
	if mid(l_s_txtin,l_i_loupe,1) = " " then        //  found blank,    clean break point
        l_i_poynter = l_i_loupe
		  l_i_loupe = 1
		  end if
	l_i_Loupe = l_i_loupe - 1
loop
if l_i_txtsyze < l_i_lynesyze then l_i_poynter = l_i_txtsyze + 1

return(l_i_poynter)
end function

public subroutine wf_print_circled_inverted_delta (long ll_Label);Constant String	D01 = '0000003FFC000000'
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

//PrintSend (ll_Label, esc + 'GH001001' + D65 )

PrintSend (ll_Label, esc + 'GH008008' )
PrintSend (ll_Label, D01 + D02 + D03 + D04 + D05 + D06 + D07 + D08 + D09 + D10 + &
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

on w_tsm_gm_ship.create
end on

on w_tsm_gm_ship.destroy
end on

