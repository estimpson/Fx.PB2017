$PBExportHeader$w_yorozu_shipper.srw
forward
global type w_yorozu_shipper from Window
end type
end forward

global type w_yorozu_shipper from Window
int X=1394
int Y=456
int Width=3447
int Height=1560
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_yorozu_shipper w_yorozu_shipper

event open;///////////////////////////////////////////////
//  Chrysler Finished Label for LexaMar Corp.
//  Based on version Created 11/24/99 By J.T.M.
//

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

DATETIME	d_t_date_time
DATE		d_d_date

DEC {0}	dec_quantity

////////////////////////////////////////////////
//  Populate the Variables
//

l_l_serial = LONG ( St_Parm.Value1 )

/*
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

			 

SELECT	SUM(object.quantity) AS qty,
			object.part,
			object.unit_measure
INTO		:dec_quantity,
			:l_s_part,
			:l_s_unit
FROM		object
WHERE		object.parent_serial = :l_l_serial
GROUP BY	object.part	;
*/		
			 
			 
	
/* Use Origin for shipper if needed--from packline without autostage */
//If ( isnull(l_l_shipper) or l_l_shipper = 0 ) and isNumber(l_s_origin) Then
//	l_l_shipper = long(l_s_origin)
//End If

d_d_date = DATE ( d_t_date_time )

/*
SELECT	order_header.customer_part,
			order_header.engineering_level,
			order_header.dock_code,
			order_header.zone_code,
			order_header.customer_po,
			order_header.line_feed_code,
			edi_setups.supplier_code
  INTO	:l_s_customer_part,
  			:l_s_change_level,
			:l_s_dock_code,
			:l_s_drop_zone,
			:l_s_po_number,
			:l_s_line_feed_code,
			:l_s_supplier_code
  FROM	order_header,
			shipper_detail,
			edi_setups
 WHERE	order_header.order_no = shipper_detail.order_no AND
			edi_setups.destination = order_header.destination  AND
	      shipper_detail.shipper = :l_l_shipper AND
			shipper_detail.part_original = :l_s_part   ;
*/
			
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

//  Vendor Code
PrintSend ( l_l_label, c_esc + "V100" + c_Esc + "H220" + c_Esc + "XL0SATO" + "VENDOR CODE:" )
PrintSend ( l_l_label, c_esc + "V060" + c_esc + "H610" + c_esc + "WL1" + "VEND" )
PrintSend ( l_l_label, c_esc + "V120" + c_Esc + "H610" + c_Esc + "B103100" + "*" + "VEND" + "*" )

//  ASN Number
PrintSend ( l_l_label, c_esc + "V290" + c_Esc + "H220" + c_Esc + "XL0SATO" + "ASN NUMBER:" )
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H610" + c_esc + "WL1" + "123456789" )
PrintSend ( l_l_label, c_esc + "V310" + c_Esc + "H610" + c_Esc + "B103100" + "*" + "123456789" + "*" )

//  Date/Time
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H220" + c_Esc + "WL1" + "SHIP DATE:" )
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H320" + c_Esc + "WL1" + "01/01/10" )
PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H220" + c_Esc + "WL1" + "SHIP TIME:" )
PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H320" + c_Esc + "WL1" + "02:20" )
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H510" + c_Esc + "WL1" + "ARRIVE DATE:" )
PrintSend ( l_l_label, c_esc + "V440" + c_Esc + "H610" + c_Esc + "WL1" + "01/05/10" )
PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H510" + c_Esc + "WL1" + "ARRIVE TIME:" )
PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H610" + c_Esc + "WL1" + "03:30" )

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V680" + c_esc + "H220" + c_esc + "$A,30,30,0" + "TSM" + " " + "Auburn Hills, MI" )



////  Date Information
//PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H1265" + c_esc + "M" + "DATE" )
//PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H1275" + c_esc + "M" + "MFG" )
//PrintSend ( l_l_label, c_esc + "V510" + c_Esc + "H1240" + c_esc + "WB1" + STRING ( d_d_date, "mm/dd/yy" ) )

//  Draw Lines
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H220" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H220" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_Esc + "V590" + c_esc + "H220" + c_Esc + "FW02H1190" )

//PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H1070" + c_esc + "FW02V0181" )
//PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H1230" + c_esc + "FW02V0181" )
//PrintSend ( l_l_label, c_Esc + "V615" + c_esc + "H1060" + c_esc + "FW02V0165" )
//PrintSend ( l_l_label, c_esc + "V615" + c_esc + "H1200" + c_esc + "FW02V0165" )

PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )

Close ( This )
end event

on w_yorozu_shipper.create
end on

on w_yorozu_shipper.destroy
end on

