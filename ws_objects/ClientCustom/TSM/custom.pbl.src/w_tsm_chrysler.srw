$PBExportHeader$w_tsm_chrysler.srw
forward
global type w_tsm_chrysler from Window
end type
end forward

global type w_tsm_chrysler from Window
int X=1051
int Y=468
int Width=2578
int Height=1536
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_tsm_chrysler w_tsm_chrysler

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

DATETIME	d_t_date_time
DATE		d_d_date

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
			 
SELECT	order_header.customer_part,
			order_header.engineering_level,
			order_header.dock_code,
			order_header.zone_code,
			edi_setups.supplier_code
  INTO	:l_s_customer_part,
  			:l_s_change_level,
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
PrintSend ( l_l_label, c_esc + "A" + c_esc + "R" )
PrintSend ( l_l_label, c_esc + "AR" )

//  Part Number Info
PrintSend ( l_l_label, c_esc + "V050" + c_esc + "H220" + c_Esc + "S" + "PART #" )
PrintSend ( l_l_label, c_esc + "V070" + c_esc + "H220" + c_esc + "S" + "CUST (P)" )
PrintSend ( l_l_label, c_esc + "V050" + c_esc + "H340" + c_esc + "WL1" + l_s_customer_part )
PrintSend ( l_l_label, c_esc + "V110" + c_Esc + "H260" + c_Esc + "B103100" + "*" + "P" + l_s_customer_part + "*" )

//  Quantity Information
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H220" + c_esc + "S" + "QTY" )
PrintSend ( l_l_label, c_Esc + "V270" + c_esc + "H220" + c_esc + "S" + "(Q)" )
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H340" + c_esc + "WL1" + STRING ( dec_quantity ) )
PrintSend ( l_l_label, c_esc + "V310" + c_esc + "H260" + c_Esc + "B103100" + "*" + "Q" + STRING ( dec_quantity ) + "*" )
If l_s_unit <> "PC" and l_s_unit <> "EA" and l_s_unit <> "UN" Then
	PrintSend ( l_l_Label, c_Esc + "V250" + c_Esc + "H790" + c_Esc + "L0101" + c_Esc + "WL1" + l_s_unit )
End If

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H220" + c_esc + "S" + "SUPLR. ID" )
PrintSend ( l_l_label, c_esc + "V460" + c_esc + "H220" + c_esc + "S" + "ASGN (V)" )
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H370" + c_esc + "WL1" + l_s_supplier_code )
PrintSend ( l_l_label, c_esc + "V510" + c_esc + "H260" + c_esc + "B103090" + "*" + "V" + l_s_supplier_code + "*" )

//  Serial Number Information
PrintSend ( l_l_label, c_esc + "V620" + c_Esc + "H220" + c_esc + "S" + "SERIAL #" )
PrintSend ( l_l_label, c_Esc + "V640" + c_esc + "H220" + c_esc + "S" + "(3S)" )
PrintSend ( l_l_label, c_esc + "V620" + c_Esc + "H340" + c_esc + "WL1" + STRING ( l_l_serial ) )
PrintSend ( l_l_label, c_esc + "V690" + c_esc + "H260" + c_esc + "B103080" + "*" + "3S" + STRING ( l_l_serial ) + "*" )

//  Company Address Information
PrintSend ( l_l_label, c_Esc + "V050" + c_esc + "H945" + c_Esc + "S" + "SHIP FROM:" )
PrintSend ( l_l_label, c_esc + "V080" + c_esc + "H945" + c_esc + "$A,30,30,0" + c_Esc + "$=" + l_s_company )
PrintSend ( l_l_label, c_Esc + "V110" + c_esc + "H945" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_1 )
PrintSend ( l_l_label, c_Esc + "V140" + c_esc + "H945" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_2 + " " + l_s_address_3 )
//PrintSend ( l_l_label, c_Esc + "V130" + c_esc + "H945" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_3 )
PrintSend ( l_l_label, c_Esc + "V200" + c_esc + "H945" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_phone )

//  Part Description Information
PrintSend ( l_l_label, c_esc + "V250" + c_esc + "H920" + c_esc + "M" + "PART NUMBER DESCRIPTION" )
PrintSend ( l_l_label, c_Esc + "V285" + c_esc + "H920" + c_Esc + "WB1" + l_s_description_1 )
PrintSend ( l_l_label, c_Esc + "V325" + c_esc + "H920" + c_Esc + "WB1" + l_s_description_2 )
PrintSend ( l_l_label, c_esc + "V365" + c_esc + "H920" + c_esc + "WB1" + l_s_description_3 )

//  Engineering Change Level Information
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H930" + c_esc + "M" + "CHANGE" )
PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H930" + c_esc + "M" + "LETTER" )
PrintSend ( l_l_label, c_esc + "V500" + c_esc + "H930" + c_esc + "$A,75,75,0" + c_esc + "$=" + l_s_change_level )

//  Safety Item Information
IF l_s_safety_item = 'Y' THEN
	PrintSend ( l_l_label, c_esc + "V475" + c_esc + "H1080" + c_esc + "WB1" + "SAFETY" )
	PrintSend ( l_l_label, c_Esc + "V520" + c_esc + "H1095" + c_esc + "WB1" + "ITEM" )
ELSE

END IF

//  Date Information
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H1265" + c_esc + "M" + "DATE" )
PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H1275" + c_esc + "M" + "MFG" )
PrintSend ( l_l_label, c_esc + "V510" + c_Esc + "H1240" + c_esc + "WB1" + STRING ( d_d_date, "mm/dd/yy" ) )

//  Dock Location Information
PrintSend ( l_l_label, c_esc + "V620" + c_esc + "H1120" + c_esc + "S" + "DOCK" )
PrintSend ( l_l_label, c_esc + "V640" + c_esc + "H1125" + c_esc + "S" + "LOC" )
PrintSend ( l_l_label, c_esc + "V695" + c_esc + "H1095" + c_esc + "WL1" + l_s_dock_code )

//  Drop Zone Information
PrintSend ( l_l_label, c_esc + "V620" + c_esc + "H1250" + c_esc + "S" + "DROP" )
PrintSend ( l_l_label, c_esc + "V640" + c_esc + "H1250" + c_esc + "S" + "ZONE" )
PrintSend ( l_l_label, c_esc + "V695" + c_esc + "H1210" + c_esc + "WL1" + l_s_drop_zone )

//  Draw Lines
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H220" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H220" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_Esc + "V615" + c_esc + "H220" + c_Esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V045" + c_esc + "H935" + c_esc + "FW02V0201" )
PrintSend ( l_l_label, c_esc + "V245" + c_esc + "H860" + c_esc + "FW02V0191" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H860" + c_Esc + "FW02V0181" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H1070" + c_esc + "FW02V0181" )
PrintSend ( l_l_label, c_esc + "V435" + c_esc + "H1230" + c_esc + "FW02V0181" )
PrintSend ( l_l_label, c_Esc + "V615" + c_esc + "H1060" + c_esc + "FW02V0165" )
PrintSend ( l_l_label, c_esc + "V615" + c_esc + "H1200" + c_esc + "FW02V0165" )

PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )

Close ( This )






			
			
			

end event
on w_tsm_chrysler.create
end on

on w_tsm_chrysler.destroy
end on

