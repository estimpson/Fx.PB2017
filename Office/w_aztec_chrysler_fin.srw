HA$PBExportHeader$w_aztec_chrysler_fin.srw
forward
global type w_aztec_chrysler_fin from Window
end type
end forward

global type w_aztec_chrysler_fin from Window
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
global w_aztec_chrysler_fin w_aztec_chrysler_fin

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
PrintSend ( l_l_label, c_esc + "A" ) //+ c_esc + "R" )
//PrintSend ( l_l_label, c_esc + "AR" )

//  Part Number Info
PrintSend ( l_l_label, c_esc + "V030" + c_esc + "H040" + c_Esc + "S" + "PART #" )
PrintSend ( l_l_label, c_esc + "V050" + c_esc + "H040" + c_esc + "S" + "CUST (P)" )
PrintSend ( l_l_label, c_esc + "V030" + c_esc + "H160" + c_esc + "WL1" + l_s_customer_part )
PrintSend ( l_l_label, c_esc + "V090" + c_Esc + "H080" + c_Esc + "B103100" + "*" + "P" + l_s_customer_part + "*" )

//  Quantity Information
PrintSend ( l_l_label, c_esc + "V220" + c_esc + "H040" + c_esc + "S" + "QTY" )
PrintSend ( l_l_label, c_Esc + "V240" + c_esc + "H040" + c_esc + "S" + "(Q)" )
PrintSend ( l_l_label, c_esc + "V220" + c_esc + "H210" + c_esc + "WL1" + STRING ( dec_quantity ) )
PrintSend ( l_l_label, c_esc + "V280" + c_esc + "H080" + c_Esc + "B103100" + "*" + "Q" + STRING ( dec_quantity ) + "*" )
If l_s_unit <> "PC" and l_s_unit <> "EA" and l_s_unit <> "UN" Then
	PrintSend ( l_l_Label, c_Esc + "V220" + c_Esc + "H610" + c_Esc + "L0101" + c_Esc + "WL1" + l_s_unit )
End If

//  Supplier Information
PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H040" + c_esc + "S" + "SUPLR. ID" )
PrintSend ( l_l_label, c_esc + "V430" + c_esc + "H040" + c_esc + "S" + "ASGN (V)" )
PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H190" + c_esc + "WL1" + l_s_supplier_code )
PrintSend ( l_l_label, c_esc + "V480" + c_esc + "H080" + c_esc + "B103090" + "*" + "V" + l_s_supplier_code + "*" )

//  Serial Number Information
PrintSend ( l_l_label, c_esc + "V590" + c_Esc + "H040" + c_esc + "S" + "SERIAL #" )
PrintSend ( l_l_label, c_Esc + "V610" + c_esc + "H040" + c_esc + "S" + "(3S)" )
PrintSend ( l_l_label, c_esc + "V590" + c_Esc + "H160" + c_esc + "WL1" + STRING ( l_l_serial ) )
PrintSend ( l_l_label, c_esc + "V660" + c_esc + "H080" + c_esc + "B103080" + "*" + "3S" + STRING ( l_l_serial ) + "*" )

//  Company Address Information
PrintSend ( l_l_label, c_Esc + "V030" + c_esc + "H785" + c_Esc + "S" + "SHIP FROM:" )
PrintSend ( l_l_label, c_esc + "V050" + c_esc + "H785" + c_esc + "$A,30,30,0" + c_Esc + "$=" + l_s_company )
PrintSend ( l_l_label, c_Esc + "V080" + c_esc + "H785" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_1 )
PrintSend ( l_l_label, c_Esc + "V110" + c_esc + "H785" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_2 + " " + l_s_address_3 )
//PrintSend ( l_l_label, c_Esc + "V130" + c_esc + "H785" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_address_3 )
PrintSend ( l_l_label, c_Esc + "V170" + c_esc + "H785" + c_Esc + "$A,30,30,0" + c_Esc + "$=" + l_s_phone )

//  Part Description Information
PrintSend ( l_l_label, c_esc + "V220" + c_esc + "H700" + c_esc + "M" + "PART NUMBER DESCRIPTION" )
PrintSend ( l_l_label, c_Esc + "V255" + c_esc + "H700" + c_Esc + "WB1" + l_s_description_1 )
PrintSend ( l_l_label, c_Esc + "V295" + c_esc + "H700" + c_Esc + "WB1" + l_s_description_2 )
PrintSend ( l_l_label, c_esc + "V335" + c_esc + "H700" + c_esc + "WB1" + l_s_description_3 )

//  Engineering Change Level Information
PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H700" + c_esc + "M" + "CHANGE" )
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H700" + c_esc + "M" + "LETTER" )
PrintSend ( l_l_label, c_esc + "V470" + c_esc + "H700" + c_esc + "$A,75,75,0" + c_esc + "$=" + l_s_change_level )

//  Safety Item Information
IF l_s_safety_item = 'Y' THEN
	PrintSend ( l_l_label, c_esc + "V445" + c_esc + "H900" + c_esc + "WB1" + "SAFETY" )
	PrintSend ( l_l_label, c_Esc + "V490" + c_esc + "H905" + c_esc + "WB1" + "ITEM" )
ELSE

END IF

//  Date Information
PrintSend ( l_l_label, c_esc + "V410" + c_esc + "H1055" + c_esc + "M" + "DATE" )
PrintSend ( l_l_label, c_esc + "V440" + c_esc + "H1065" + c_esc + "M" + "MFG" )
PrintSend ( l_l_label, c_esc + "V480" + c_Esc + "H1040" + c_esc + "WB1" + STRING ( d_d_date, "mm/dd/yy" ) )

//  Dock Location Information
PrintSend ( l_l_label, c_esc + "V590" + c_esc + "H0900" + c_esc + "S" + "DOCK" )
PrintSend ( l_l_label, c_esc + "V610" + c_esc + "H0905" + c_esc + "S" + "LOC" )
PrintSend ( l_l_label, c_esc + "V665" + c_esc + "H0885" + c_esc + "WL1" + l_s_dock_code )

//  Drop Zone Information
PrintSend ( l_l_label, c_esc + "V590" + c_esc + "H1050" + c_esc + "S" + "DROP" )
PrintSend ( l_l_label, c_esc + "V610" + c_esc + "H1050" + c_esc + "S" + "ZONE" )
PrintSend ( l_l_label, c_esc + "V665" + c_esc + "H1000" + c_esc + "WL1" + l_s_drop_zone )

//  Draw Lines
PrintSend ( l_l_label, c_esc + "V215" + c_esc + "H020" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H020" + c_esc + "FW02H1190" )
PrintSend ( l_l_label, c_Esc + "V585" + c_esc + "H020" + c_Esc + "FW02H1190" )

PrintSend ( l_l_label, c_esc + "V015" + c_esc + "H775" + c_esc + "FW02V0201" )

PrintSend ( l_l_label, c_esc + "V215" + c_esc + "H690" + c_esc + "FW02V0191" )
PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H690" + c_Esc + "FW02V0181" )

PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H0850" + c_esc + "FW02V0181" )
PrintSend ( l_l_label, c_esc + "V405" + c_esc + "H1035" + c_esc + "FW02V0181" )

PrintSend ( l_l_label, c_Esc + "V585" + c_esc + "H0890" + c_esc + "FW02V0165" )
PrintSend ( l_l_label, c_esc + "V585" + c_esc + "H1040" + c_esc + "FW02V0165" )

PrintSend ( l_l_label, c_esc + l_s_number_of_labels )
PrintSend ( l_l_label, c_esc + "Z" )
PrintClose ( l_l_label )

Close ( This )






			
			
			

end event

on w_aztec_chrysler_fin.create
end on

on w_aztec_chrysler_fin.destroy
end on

