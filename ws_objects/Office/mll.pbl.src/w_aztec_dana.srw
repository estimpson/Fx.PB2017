$PBExportHeader$w_aztec_dana.srw
forward
global type w_aztec_dana from Window
end type
end forward

global type w_aztec_dana from Window
int X=1394
int Y=456
int Width=2670
int Height=1560
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=82899184
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_aztec_dana w_aztec_dana

event open;///////////////////////////////////////////////
//  Dana Label for Aztec Manufacturing Corp.
//  Created 07/27/2010
///

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
STRING	l_s_destination

DATETIME	d_t_date_time
DATE		d_d_date
INT		l_i_year
STRING	l_s_firstday
DATE		d_d_firstday
LONG		l_l_daysafter
STRING	l_s_daysafter
LONG		l_l_len_daysafter

DEC {0}	dec_quantity

////////////////////////////////////////////////
//  Populate the Variables
//

l_l_serial = LONG ( St_Parm.Value1 )

SELECT	object.last_date,
			object.quantity,
			part.name,
			object.part,
			object.unit_measure,
			object.shipper,
			object.origin
  INTO	:d_t_date_time,
  			:dec_quantity,
			:l_s_Description,
			:l_s_part,
			:l_s_unit,
			:l_l_shipper,
			:l_s_origin
  FROM	object,
  			part
 WHERE	object.part = part.part  AND
 			object.serial = :l_l_serial	;
	
/* Use Origin for shipper if needed--from packline without autostage */
If ( isnull(l_l_shipper) or l_l_shipper = 0 ) and isNumber(l_s_origin) Then
	l_l_shipper = long(l_s_origin)
End If


d_d_date = DATE ( d_t_date_time )


//  Get the day number of the year
l_i_year = year(d_d_date)
l_s_firstday = STRING ( l_i_year ) + "-1-1"

d_d_firstday = DATE ( l_s_firstday )

l_l_daysafter = ( DAYSAFTER ( d_d_firstday, d_d_date ) + 1 )
l_s_daysafter = STRING ( l_l_daysafter )

l_l_len_daysafter = LEN ( l_s_daysafter)
If l_l_len_daysafter = 1 Then
	l_s_daysafter = "000" + l_s_daysafter
ElseIf l_l_len_daysafter = 2 Then
	l_s_daysafter = "00" + l_s_daysafter
Else
	l_s_daysafter = "0" + l_s_daysafter
End If
//

			 
SELECT	order_header.customer_part,
			order_header.engineering_level,
			order_header.destination,
			order_header.dock_code,
			order_header.zone_code,
			edi_setups.supplier_code
  INTO	:l_s_customer_part,
  			:l_s_change_level,
			:l_s_destination,
			:l_s_dock_code,
			:l_s_drop_zone,
			:l_s_supplier_code
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
  
SELECT 	safety_part
  INTO 	:l_s_safety_item
  FROM 	part_inventory
 WHERE 	part = :l_s_part ;
  
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
PrintSend ( l_l_label, c_esc + "A" ) //+ c_esc + "R" )
//PrintSend ( l_l_label, c_esc + "AR" )

//  Part Number Info
PrintSend ( l_l_label, c_esc + "V035" + c_esc + "H040" + c_Esc + "S" + "PART #" )
PrintSend ( l_l_label, c_esc + "V055" + c_esc + "H040" + c_esc + "S" + "(P)" )
PrintSend ( l_l_label, c_esc + "V035" + c_esc + "H200" + c_esc + "WL1" + l_s_customer_part )
PrintSend ( l_l_label, c_esc + "V100" + c_Esc + "H080" + c_Esc + "B103100" + "*" + "P" + l_s_customer_part + "*" )

//  Quantity Information
PrintSend ( l_l_label, c_esc + "V225" + c_esc + "H040" + c_esc + "S" + "QUANTITY (Q)" )
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H160" + c_esc + "WL1" + STRING ( dec_quantity ) )
PrintSend ( l_l_label, c_esc + "V300" + c_esc + "H080" + c_Esc + "B103100" + "*" + "Q" + STRING ( dec_quantity ) + "*" )
If l_s_unit <> "PC" and l_s_unit <> "EA" and l_s_unit <> "UN" Then
	PrintSend ( l_l_Label, c_Esc + "V225" + c_Esc + "H540" + c_Esc + "WL1" + l_s_unit )
End If

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V425" + c_esc + "H040" + c_esc + "S" + "SUPPLIER (V)" )
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H160" + c_esc + "WL1" + l_s_supplier_code )
PrintSend ( l_l_label, c_esc + "V490" + c_esc + "H080" + c_esc + "B103100" + "*" + "V" + l_s_supplier_code + "*" )

//  Serial Number
PrintSend ( l_l_label, c_esc + "V615" + c_Esc + "H040" + c_esc + "S" + "SERIAL (S)" )
PrintSend ( l_l_label, c_esc + "V630" + c_Esc + "H160" + c_esc + "WL1" + STRING ( l_l_serial ) )
PrintSend ( l_l_label, c_esc + "V680" + c_esc + "H080" + c_esc + "B103080" + "*" + "S" + STRING ( l_l_serial ) + "*" )

//  Address
PrintSend ( l_l_label, c_esc + "V765" + c_Esc + "H040" + c_esc + "S" + "Aztec Mfg. Corp. 15378 Oakwood Drive Romulus, MI 48174" )


////  Part Description Information
//PrintSend ( l_l_label, c_esc + "V220" + c_esc + "H700" + c_esc + "M" + "PART NUMBER DESCRIPTION" )
//PrintSend ( l_l_label, c_Esc + "V255" + c_esc + "H700" + c_Esc + "WB1" + l_s_description_1 )
//PrintSend ( l_l_label, c_Esc + "V295" + c_esc + "H700" + c_Esc + "WB1" + l_s_description_2 )
//PrintSend ( l_l_label, c_esc + "V335" + c_esc + "H700" + c_esc + "WB1" + l_s_description_3 )


//  Ship To
PrintSend ( l_l_label, c_esc + "V215" + c_esc + "H620" + c_esc + "S" + "SHIP TO (D)" )
PrintSend ( l_l_label, c_esc + "V235" + c_esc + "H770" + c_esc + "WL1" + l_s_destination )
PrintSend ( l_l_label, c_esc + "V305" + c_esc + "H685" + c_esc + "B103080" + "*" + "D" + l_s_destination + "*" )


////  Engineering Change Level Information
//PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H700" + c_esc + "M" + "CHANGE" )
//PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H700" + c_esc + "M" + "LETTER" )
//PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H700" + c_esc + "$A,75,75,0" + c_esc + "$=" + l_s_change_level )


//  Date
PrintSend ( l_l_label, c_esc + "V425" + c_esc + "H620" + c_esc + "S" + "DATE (DB)" )
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H770" + c_esc + "WL1" + l_s_daysafter )
PrintSend ( l_l_label, c_esc + "V490" + c_esc + "H685" + c_esc + "B103100" + "*" + "DB" + l_s_daysafter + "*" )

//  Rev Level
PrintSend ( l_l_label, c_esc + "V615" + c_Esc + "H620" + c_esc + "S" + "REV. LEVEL (DC)" )
PrintSend ( l_l_label, c_esc + "V630" + c_Esc + "H770" + c_esc + "WL1" + STRING ( l_s_change_level ) )
PrintSend ( l_l_label, c_esc + "V680" + c_esc + "H685" + c_esc + "B103100" + "*" + "DC" + STRING ( l_s_change_level ) + "*" )


////  Safety Item Information
//IF l_s_safety_item = 'Y' THEN
//	PrintSend ( l_l_label, c_esc + "V445" + c_esc + "H900" + c_esc + "WB1" + "SAFETY" )
//	PrintSend ( l_l_label, c_Esc + "V490" + c_esc + "H905" + c_esc + "WB1" + "ITEM" )
//ELSE
//
//END IF

////  Date Information
//PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H1055" + c_esc + "M" + "DATE" )
//PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H1065" + c_esc + "M" + "MFG" )
//PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H1040" + c_esc + "WB1" + STRING ( d_d_date, "mm/dd/yy" ) )

////  Dock Location Information
//PrintSend ( l_l_label, c_esc + "V590" + c_esc + "H0900" + c_esc + "S" + "DOCK" )
//PrintSend ( l_l_label, c_esc + "V610" + c_esc + "H0905" + c_esc + "S" + "LOC" )
//PrintSend ( l_l_label, c_esc + "V665" + c_esc + "H0885" + c_esc + "WL1" + l_s_dock_code )

////  Drop Zone Information
//PrintSend ( l_l_label, c_esc + "V590" + c_esc + "H1050" + c_esc + "S" + "DROP" )
//PrintSend ( l_l_label, c_esc + "V610" + c_esc + "H1050" + c_esc + "S" + "ZONE" )
//PrintSend ( l_l_label, c_esc + "V665" + c_esc + "H1000" + c_esc + "WL1" + l_s_drop_zone )



//  Draw Lines
PrintSend ( l_l_label, c_esc + "V205" + c_esc + "H020" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H020" + c_esc + "FW04H1190" )
PrintSend ( l_l_label, c_Esc + "V595" + c_esc + "H020" + c_Esc + "FW02H1190" )
PrintSend ( l_l_label, c_Esc + "V785" + c_esc + "H020" + c_Esc + "FW04H1190" )

//PrintSend ( l_l_label, c_esc + "V015" + c_esc + "H775" + c_esc + "FW02V0201" )

//PrintSend ( l_l_label, c_esc + "V215" + c_esc + "H690" + c_esc + "FW02V0191" )
//PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H690" + c_Esc + "FW02V0181" )

PrintSend ( l_l_label, c_esc + "V205" + c_esc + "H610" + c_esc + "FW02V0201" )
PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H610" + c_Esc + "FW02V0191" )
PrintSend ( l_l_label, c_esc + "V595" + c_esc + "H610" + c_Esc + "FW02V0191" )

//PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H0850" + c_esc + "FW02V0181" )
//PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H1035" + c_esc + "FW02V0181" )

//PrintSend ( l_l_label, c_Esc + "V585" + c_esc + "H0890" + c_esc + "FW02V0165" )
//PrintSend ( l_l_label, c_esc + "V585" + c_esc + "H1040" + c_esc + "FW02V0165" )

PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )

Close ( This )






			
			
			

end event

on w_aztec_dana.create
end on

on w_aztec_dana.destroy
end on

