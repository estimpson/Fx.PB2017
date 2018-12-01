$PBExportHeader$w_tsm_yorozu_box.srw
forward
global type w_tsm_yorozu_box from window
end type
end forward

global type w_tsm_yorozu_box from window
integer x = 1394
integer y = 456
integer width = 3447
integer height = 1560
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
end type
global w_tsm_yorozu_box w_tsm_yorozu_box

event open;

//////////////////////////////////////////////
//  Declaration of Variables
//

St_Generic_Structure St_Parm	
St_Parm = Message.PowerObjectParm

LONG		l_l_serial
LONG		l_l_label
LONG		l_l_shipper

STRING	l_s_customer_part
STRING	l_s_supplier_code
STRING	l_s_description
STRING	l_s_description_1
STRING	l_s_description_2
STRING	l_s_description_3
STRING	l_s_dock_code
STRING	l_s_change_level
STRING	l_s_company
STRING	l_s_address_1
STRING	l_S_address_2
STRING	l_s_address_3
STRING	l_s_drop_zone
STRING	l_s_safety_item
STRING	l_s_phone
STRING	l_s_number_of_labels
STRING	c_esc 
STRING	l_s_part
STRING	l_s_unit
STRING	l_s_origin
STRING	l_s_line_feed_code
STRING	l_s_po_number
STRING	l_s_address

DATETIME	d_t_date_time
DATE	d_d_date


STRING	l_s_ship_date
STRING	l_s_ship_time
STRING	l_s_arrive_date
STRING	l_s_arrive_time

DEC {0}	dec_quantity

////////////////////////////////////////////////
//  Populate the Variables
//

l_l_serial = LONG ( St_Parm.Value1 )


SELECT	object.quantity,
			part.name,
			object.part,
			object.unit_measure,
			object.shipper,
			object.origin
  INTO	:dec_quantity,
			:l_s_Description,
			:l_s_part,
			:l_s_unit,
			:l_l_shipper,
			:l_s_origin
  FROM	object,
  			part
 WHERE	object.part = part.part  AND
 			object.serial = :l_l_serial	;
			 
			 
SELECT	getdate()
INTO		:d_t_date_time
FROM		parameters	;
d_d_date = DATE ( d_t_date_time )
//t_t_time = TIME ( d_t_date_time )


	
/* Use Origin for shipper if needed--from packline without autostage */
//If ( isnull(l_l_shipper) or l_l_shipper = 0 ) and isNumber(l_s_origin) Then
//	l_l_shipper = long(l_s_origin)
//End If


SELECT	order_header.customer_part,
			order_header.engineering_level,
			order_header.dock_code,
			order_header.zone_code,
			SUBSTRING( order_header.customer_po, 1, (CASE WHEN PATINDEX('%:%', order_header.customer_po) = 0 THEN 35 ELSE PATINDEX('%:%', order_header.customer_po)-1 END )),
			order_header.line_feed_code,
			edi_setups.supplier_code,
			CONVERT (nvarchar(100), GETDATE(),1),
			LEFT(CONVERT (nvarchar(100), GETDATE(),8),5),
			CONVERT (nvarchar(100), DATEADD(dd, 1*edi_setups.id_code_type, getdate()),1),
			LEFT(CONVERT (nvarchar(100), DATEADD(dd, 1*edi_setups.id_code_type, getdate()),8),5)
  INTO	:l_s_customer_part,
  			:l_s_change_level,
			:l_s_dock_code,
			:l_s_drop_zone,
			:l_s_po_number,
			:l_s_line_feed_code,
			:l_s_supplier_code,
			:l_s_ship_date,
			:l_s_ship_time,
			:l_s_arrive_date,
			:l_s_arrive_time
  FROM	order_header,
			shipper_detail,
			edi_setups
 WHERE	order_header.order_no = shipper_detail.order_no AND
			edi_setups.destination = order_header.destination  AND
	      shipper_detail.shipper = :l_l_shipper AND
			shipper_detail.part_original = :l_s_part   ;

			
SELECT	company_name,
			address_1,
			address_2,
			address_3,
			phone_number
  INTO	:l_s_company,
  			:l_s_address_1,
			:l_s_address_2,
			:l_s_address_3,
			:l_s_phone
  FROM	parameters			;
  
l_s_address = l_s_company + " " + l_s_address_1

  
If St_parm.value11 = "" Then 
	l_s_number_of_labels = "Q1"
Else
	l_s_number_of_labels = "Q" + St_parm.value11
End If

l_s_description_1 = MID ( l_s_description, 1, 20 )
l_s_description_2 = MID ( l_s_description, 21, 20 )
l_s_description_3 = MID ( l_s_description, 41, 20 )

c_esc = "~h1B"

/////////////////////////////////////////////////
//  Print Label
//

l_l_label = PrintOpen ()

//  Start Print Job
PrintSend ( l_l_label, c_esc + "A" + c_esc + "R" )
PrintSend ( l_l_label, c_esc + "AR" )

//  Part Number Info
PrintSend ( l_l_label, c_esc + "V060" + c_esc + "H170" + c_Esc + "S" + "PART NO." )
PrintSend ( l_l_label, c_esc + "V080" + c_esc + "H170" + c_esc + "S" + "(P)" )
PrintSend ( l_l_label, c_esc + "V060" + c_esc + "H290" + c_esc + "WL1" + l_s_customer_part )
PrintSend ( l_l_label, c_esc + "V130" + c_Esc + "H210" + c_Esc + "B103100" + "*" + "P" + l_s_customer_part + "*" )
//PrintSend ( l_l_label, c_esc + "V060" + c_esc + "H290" + c_esc + "WL1" + "TEST PART" )
//PrintSend ( l_l_label, c_esc + "V130" + c_Esc + "H210" + c_Esc + "B103100" + "*" + "P" + STRING ( "TEST PART" ) + "*" )

//  Quantity Information
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H170" + c_esc + "S" + "QUANTITY" )
PrintSend ( l_l_label, c_Esc + "V270" + c_esc + "H170" + c_esc + "S" + "(Q)" )
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H290" + c_esc + "WL1" + STRING ( dec_quantity ) )
PrintSend ( l_l_label, c_esc + "V310" + c_esc + "H210" + c_Esc + "B103100" + "*" + "Q" + STRING ( dec_quantity ) + "*" )
//PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H290" + c_esc + "WL1" + STRING ( 100 ) )
//PrintSend ( l_l_label, c_esc + "V310" + c_esc + "H210" + c_Esc + "B103100" + "*" + "Q" + STRING ( 100 ) + "*" )
//If l_s_unit <> "PC" and l_s_unit <> "EA" and l_s_unit <> "UN" Then
//	PrintSend ( l_l_Label, c_Esc + "V250" + c_Esc + "H790" + c_Esc + "L0101" + c_Esc + "WL1" + l_s_unit )
//End If

//  Serial Number Information
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H170" + c_esc + "S" + "SERIAL" )
PrintSend ( l_l_label, c_Esc + "V460" + c_esc + "H170" + c_esc + "S" + "(S)" )
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H320" + c_esc + "WL1" + STRING ( l_l_serial ) )
PrintSend ( l_l_label, c_esc + "V510" + c_esc + "H210" + c_esc + "B103080" + "*" + "S" + STRING ( l_l_serial ) + "*" )
//PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H320" + c_esc + "WL1" + STRING ( 123456789 ) )
//PrintSend ( l_l_label, c_esc + "V510" + c_esc + "H210" + c_esc + "B103080" + "*" + "S" + STRING ( 123456789 ) + "*" )

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V620" + c_esc + "H170" + c_esc + "S" + "SUPPLIER" )
PrintSend ( l_l_label, c_esc + "V640" + c_esc + "H170" + c_esc + "S" + "(V)" )
PrintSend ( l_l_label, c_esc + "V620" + c_esc + "H290" + c_esc + "WL1" + l_s_supplier_code )
PrintSend ( l_l_label, c_esc + "V680" + c_esc + "H210" + c_esc + "B103090" + "*" + "V" + l_s_supplier_code + "*" )
//PrintSend ( l_l_label, c_esc + "V620" + c_esc + "H290" + c_esc + "WL1" + "SUPPCODE" )
//PrintSend ( l_l_label, c_esc + "V680" + c_esc + "H210" + c_esc + "B103090" + "*" + "V" + STRING ( "SUPPCODE" ) + "*" )
PrintSend ( l_l_label, c_esc + "V780" + c_esc + "H210" + c_esc + "S" + l_s_address )
//PrintSend ( l_l_label, c_esc + "V780" + c_esc + "H210" + c_esc + "S" + "TSM Auburn Hills, MI" )

//  PO Number
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H650" + c_esc + "S" + "PO NO." )
PrintSend ( l_l_label, c_esc + "V270" + c_esc + "H650" + c_esc + "S" + "(K)" )
PrintSend ( l_l_label, c_esc + "V270" + c_esc + "H740" + c_esc + "WL1" + l_s_po_number )
PrintSend ( l_l_label, c_esc + "V330" + c_esc + "H650" + c_esc + "B103090" + "*" + "K" + l_s_po_number + "*" )
//PrintSend ( l_l_label, c_esc + "V270" + c_esc + "H740" + c_esc + "WL1" + "TEST12345" )
//PrintSend ( l_l_label, c_esc + "V330" + c_esc + "H650" + c_esc + "B103090" + "*" + "K" + "TEST12345" + "*" )

//  Store Location
PrintSend ( l_l_label, c_esc + "V450" + c_esc + "H930" + c_esc + "S" + "STORE LOCATION" )
PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H930" + c_esc + "WL1" + l_s_line_feed_code )
//PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H930" + c_esc + "WL1" + "1234567890" )

//  Ship Date/Time
PrintSend ( l_l_label, c_esc + "V640" + c_Esc + "H930" + c_Esc + "WL1" + "SHIP DATE:" )
PrintSend ( l_l_label, c_esc + "V710" + c_Esc + "H930" + c_Esc + "WL1" + l_s_ship_date )


//  Draw Lines
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H170" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H170" + c_esc + "FW02H0740" )
PrintSend ( l_l_label, c_Esc + "V615" + c_esc + "H170" + c_Esc + "FW02H0740" )
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H630" + c_esc + "FW02V0191" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H910" + c_Esc + "FW02V0382" )


PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )




////////////////////
//  Print ASN Label
////////////////////

l_l_label = PrintOpen ()

//  Start Print Job
PrintSend ( l_l_label, c_esc + "A" + c_esc + "R" )
PrintSend ( l_l_label, c_esc + "AR" )


//  Vendor Code
PrintSend ( l_l_label, c_esc + "V100" + c_Esc + "H180" + c_Esc + "WL1" + "VENDOR CODE:" )
PrintSend ( l_l_label, c_esc + "V060" + c_esc + "H590" + c_esc + "WL1" + l_s_supplier_code )
PrintSend ( l_l_label, c_esc + "V120" + c_Esc + "H590" + c_Esc + "B103100" + "*" + l_s_supplier_code + "*" )

//  ASN Number
PrintSend ( l_l_label, c_esc + "V310" + c_Esc + "H180" + c_Esc + "WL1" + "ASN NUMBER:" )
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H590" + c_esc + "WL1" + STRING ( l_l_shipper ) )
PrintSend ( l_l_label, c_esc + "V310" + c_Esc + "H590" + c_Esc + "B103100" + "*" + STRING ( l_l_shipper ) + "*" )

//  Ship Date/Time
PrintSend ( l_l_label, c_esc + "V470" + c_Esc + "H180" + c_Esc + "XL0" + "SHIP DATE:" )
PrintSend ( l_l_label, c_esc + "V470" + c_Esc + "H440" + c_Esc + "XL0" + l_s_ship_date )
PrintSend ( l_l_label, c_esc + "V520" + c_Esc + "H180" + c_Esc + "XL0" + "SHIP TIME:" )
PrintSend ( l_l_label, c_esc + "V520" + c_Esc + "H440" + c_Esc + "XL0" + l_s_ship_time )
//  Arrive Date/Time
PrintSend ( l_l_label, c_esc + "V470" + c_Esc + "H730" + c_Esc + "XL0" + "ARRIVE DATE:" )
PrintSend ( l_l_label, c_esc + "V470" + c_Esc + "H1070" + c_Esc + "XL0" + l_s_arrive_date )
PrintSend ( l_l_label, c_esc + "V520" + c_Esc + "H730" + c_Esc + "XL0" + "ARRIVE TIME:" )
PrintSend ( l_l_label, c_esc + "V520" + c_Esc + "H1070" + c_Esc + "XL0" + l_s_arrive_time )

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V750" + c_esc + "H180" + c_esc + "XL0" + l_s_address )

//  Draw Lines
PrintSend ( l_l_label, c_esc + "V240" + c_esc + "H180" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H180" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_Esc + "V610" + c_esc + "H180" + c_Esc + "FW02H1190" )


PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )


Close ( This )
end event

on w_tsm_yorozu_box.create
end on

on w_tsm_yorozu_box.destroy
end on

