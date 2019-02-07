$PBExportHeader$w_gm1724_regal.srw
$PBExportComments$GM label for L and L products.
forward
global type w_gm1724_regal from Window
end type
end forward

shared variables
STRING	s_s_destination

INTEGER	s_i_cycles = 0
end variables

global type w_gm1724_regal from Window
int X=97
int Y=605
int Width=1687
int Height=961
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=16777215
boolean ControlMenu=true
WindowType WindowType=response!
end type
global w_gm1724_regal w_gm1724_regal

type variables

end variables

on open;St_generic_structure ast_Parm

/////////////////////////////////////////////////
//  Declaration
//

//ast_Parm = Message.PowerObjectParm

LONG		l_l_serial, &
			l_Label, &
			l_Serial, &
			l_position, &
			l_pos_string, &
         l_ordno, & 
         l_shipper

STRING	l_s_part, &
			c_Esc, &
			s_date, &
			s_Part, &
			s_CuPart, &
			s_Customer, &
			s_destination, &
			s_NumberofLabels, &
			s_Supplier, &
			s_Temp, &
			s_Name1, &
			s_Name2, &
			s_Name3, &
			s_Suffix, &
         szcompany, &
        	szaddress1, &
			szaddress2, &
			szaddress3, &
			s_blanket_part, &
			szeng,&
			S_CUPO, &
			S_ZONE_CODE, &
			SZ_TEMP, &
			sz_bef, &
			sz_aft , &
			SZ_LINFEED , &
			Szunit ,&
			ls_Tild , &
			ls_Caret, &
		   SZ_LOT, &
			SZ_OP, &
			 S_ENG, &
			S_DESTI, &
			sz_custom01, &
			SZ_CUSTOM02, &
			SZ_CUSTOM03, &
			S_LINEFEED, &
			S_DOCKCODE, &
			s_custom01, &
			s_custom02, &
			s_custom03, &
			s_line11, &
			s_line12, &
			s_line13, &
			s_line14, &
			s_line15, &
			s_line16, &
			s_line17


INTEGER i_julianDate,s_shipper

Dec {0} dec_Quantity

DATETIME    ldt_Date

Date	dDate  

///////////////////////////////////////////////
//  Initialization

ast_Parm = Message.PowerObjectParm
l_l_serial = Long ( ast_parm.value1 )

  SELECT
	   	part,   
         quantity,   
			unit_measure,
			LOT,
			OPERATOR,
			Last_date
    INTO 
			:s_Part,   
         :dec_Quantity,   
			:Szunit,
			:SZ_LOT,
			:SZ_OP,
			:ldt_date
    FROM object  
   WHERE serial = :l_l_Serial   ;

select audit_trail.date_stamp
		into :ldt_Date
		from audit_trail 
		where audit_trail.serial = :l_serial and 
		(audit_trail.type = 'J' or audit_trail.type = 'R');

		dDate = Date( ldt_Date )

		SELECT order_header.customer_part,
				order_header.CUSTOMER_PO,
				order_header.zone_CODE,
				ORDER_HEADER.DESTINATION,
				order_header.custom01,
				ORDER_HEADER.CUSTOM02,
				ORDER_HEADER.CUSTOM03,
				ORDER_HEADER.LINE_FEED_CODE,
				line11,
				line12,
				line13,
				line14,
				line15,
				line16,
				line17
		INTO :s_Cupart,
			  :s_CUPO,
			  :s_zone_CODE,
			  :S_DESTI,
			  :sz_custom01,
			  :SZ_CUSTOM02,
			  :SZ_CUSTOM03,		
			  :S_LINEFEED,
				:s_line11,
				:s_line12,
				:s_line13,
				:s_line14,
				:s_line15,
				:s_line16,
				:s_line17
	  FROM order_header, shipper_detail, shipper, object
	  WHERE order_header.order_no = shipper_detail.order_no AND
			  (CONVERT ( INT,object.origin ) = shipper_detail.shipper OR object.shipper = shipper_detail.shipper) AND
			  (CONVERT ( INT,object.origin ) = shipper.id OR object.shipper = shipper.id) AND
			  object.part = shipper_detail.part_original AND
			  object.serial = :l_l_serial    ;

	SELECT distinct order_detail.custom01,
			 			 order_detail.custom02,
			 			 order_detail.custom03
	INTO		:s_custom01,
				:s_custom02,
				:s_custom03
	FROM 		order_detail,order_header,shipper_detail,shipper,object
	WHERE order_detail.order_no = order_header.order_no AND
			order_header.order_no = shipper_detail.order_no AND
			shipper.id = shipper_detail.shipper AND
			shipper_detail.shipper = convert(int,object.origin) AND
			shipper_detail.part_original = object.part AND
			object.serial = :l_l_Serial  ; 

  SELECT supplier_code
		    
    INTO :s_Supplier
		    
    FROM edi_setups, shipper, object  
   WHERE shipper.id = CONVERT ( INT, object.origin) AND
			shipper.destination = edi_setups.destination AND
			serial = :l_l_serial      ;  

 SELECT part.name  
    INTO :s_Temp 
    FROM object, part  
   WHERE object.part = part.part AND
			serial = :l_l_serial    ;
 
 SELECT part_mfg.engineering_level,
		  eng_effective_date
    INTO :s_Eng, 
			:s_date
    FROM part_mfg, object  
   WHERE object.part = part_mfg.part AND
			serial = :l_l_serial ;
 
SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;
 
// to get the number of copies of the label 
Select number_of_labels
Into :s_NumberofLabels
From label_library
Where window_name = 'w_gm1724_regal'  ;

If ast_Parm.value11 = "" Then
   s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + s_NumberofLabels
End If

c_Esc = "~h1B" 

 S_NAME1 = MID (S_TEMP,1,18)
 S_NAME2 = MID (S_TEMP,19,18)

/////////////////////////////////////////////////
//  Main Routine
//

Long l_l_label
Char esc = Char (27)
l_l_Label = PrintOpen ( )

PrintSend ( l_l_Label, c_esc + "A" + c_esc + "R" )
PrintSend ( l_l_Label, c_esc + "CS2")

//PART INFO
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V40" + c_esc + "L0102" + c_esc + "SPART #" )
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V70" + c_esc + "S(P)" )
PrintSend ( l_l_Label, c_esc + "H345" + c_esc + "V20" + c_esc + "$A,110,145,0" + c_esc + "$=" + UPPER(s_cupart) )
PrintSend ( l_l_Label, c_esc + "H290" + c_esc + "V140" + c_esc + "D103070" + "*P" + s_cupart + "*" )

////QUANTITY INFO
PrintSend ( l_l_Label, c_esc + "H880" + c_esc + "V167" + c_esc + "L0102" + c_esc + "SQUANTITY" ) 
PrintSend ( l_l_Label, c_esc + "H880" + c_esc + "V195" + c_esc + "S(Q)" )
PrintSend ( l_l_Label, c_esc + "H995" + c_esc + "V100" + c_esc + "$A,110,145,0" + c_esc + "$=" + String (dec_Quantity) )
PrintSend ( l_l_Label, c_esc + "H970" + c_esc + "V25" + c_esc + "D103090" + "*Q" + String (dec_Quantity) + "*" )

//PO NO.
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V240" + c_esc + "L0102" + c_esc + "SPO #." )
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V265" + c_esc + "S(K)" )
PrintSend ( l_l_Label, c_esc + "H365" + c_esc + "V205" + c_esc + "$A,110,145,0" + c_esc + "$=" + S_CUPO )
PrintSend ( l_l_Label, c_esc + "H290" + c_esc + "V325" + c_esc + "D103090" + "*K" + S_CUPO + "*" )

//DLOC
PrintSend ( l_l_Label, c_esc + "H880" + c_esc + "V240" + c_esc + "L0102" + "DLOC" )
PrintSend ( l_l_Label, c_esc + "H920" + c_esc + "V260" + c_esc + "$A,110,145,0" + c_esc + "$=" + s_line11 )

//SERIAL NO
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V440" + c_esc + "L0102" + c_esc + "SSERIAL #" )
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V470" + c_esc + "S(3S)" )
PrintSend ( l_l_Label, c_esc + "H385" + c_esc + "V405" + c_esc + "$A,110,145,0" + c_esc + "$=" + String ( l_l_Serial ) )
PrintSend ( l_l_Label, c_esc + "H290" + c_esc + "V527" + c_esc + "D103090" + "*3S" + String ( l_l_Serial ) + "*" )

//ENG CHG
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V640" + c_esc + "L0102" + c_esc + "SENG CHANGE:" )
PrintSend ( l_l_Label, c_esc + "H395" + c_esc + "V640" + c_esc + "L0101" + c_esc + "OB" + S_ENG  )

//SHIP DATE
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V675" + c_esc + "L0102" + c_esc + "S" + "MFG. SHIP DATE:" )
PrintSend ( l_l_Label, c_esc + "H415" + c_esc + "V675" + c_esc + "L0101" + c_esc + "OB" + String(dDate, "yy/mm/dd") )

//LOT NO.
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V707" + c_esc + "L0102" + c_esc + "S" + "LOT NO.:" )
PrintSend ( l_l_Label, c_esc + "H345" + c_esc + "V707" + c_esc + "L0101" + c_esc + "OB" + SZ_LOT )

//INT PART
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V742" + c_esc + "L0102" + c_esc + "S" + "INT PART:" )
PrintSend ( l_l_Label, c_esc + "H345" + c_esc + "V742" + c_esc + "L0101" + c_esc + "OB" + S_PART )

//PACKER
PrintSend ( l_l_Label, c_esc + "H255" + c_esc + "V785" + c_esc + "L0102" + c_esc + "S" + "PACKER:" )
PrintSend ( l_l_Label, c_esc + "H345" + c_esc + "V785" + c_esc + "L0101" + c_esc + "OB" + SZ_OP )

//PLT/DOCK
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V440" + c_esc + "L0102" + c_esc + "S" + "PLT/DOCK" )
PrintSend ( l_l_Label, c_esc + "H920" + c_esc + "V410" + c_esc + "$A,110,145,0" + c_esc + "$=" + s_line12 )

//ZONE_CODE,LINE_FEED & CUSTOM03
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V550" + c_esc + "L0101" + c_esc + "WB1" + s_line13 )
PrintSend ( l_l_Label, c_esc + "H1000" + c_esc + "V550" + c_esc + "L0101" + c_esc + "WB1" + s_line14 )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V590" + c_esc + "L0101" + c_esc + "WB1" + s_line15 )

//ZONE_CODE,LINE_FEED & CUSTOM03(FROM ORDER_DETAIL)
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V640" + c_esc + "L0101" + c_esc + "M" +  "CUST MISCELLANEOUS AREA" )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V653" + c_esc + "$A,70,75,0" + c_esc + "$=" +  s_line17 )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V720" + c_esc + "L0101" + c_esc + "OB" + "SUPPLIER ID:" )
PrintSend ( l_l_Label, c_esc + "H1100" + c_esc + "V720" + c_esc + "L0101" + c_esc + "OB" + s_Supplier )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V745" + c_esc + "$A,50,40,0" + c_esc + "$=" + szCompany )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V787" + c_esc + "L0101" + c_esc + "M" + szAddress1 + " " + szAddress2 )
PrintSend ( l_l_Label, c_esc + "H820" + c_esc + "V810" + c_esc + "L0101" + c_esc + "M" + szAddress3 )
//PrintSend ( l_Label, ls_Caret + "FO30,580" + ls_Caret + "CFO,15,12" + ls_Caret + "FD" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 +  ls_Caret  +  "FS"  )

//DRAW LINES
PrintSend ( l_l_Label, c_esc + "H240" + c_esc + "V225" + c_esc + "FW02H1675" ) 
PrintSend ( l_l_Label, c_esc + "H865" + c_esc + "V25" + c_esc + "FW02V400" ) 
PrintSend ( l_l_Label, c_esc + "H240" + c_esc + "V425" + c_esc + "FW02H1675" ) 
PrintSend ( l_l_Label, c_esc + "H805" + c_esc + "V427" + c_esc + "FW02V395" ) 
PrintSend ( l_l_Label, c_esc + "H240" + c_esc + "V627" + c_esc + "FW02H1675" ) 

PrintSend ( l_l_Label, c_esc +  s_NumberofLabels )
PrintSend ( l_l_Label, c_esc + "Z" )
PrintClose (l_l_label)
Close ( This )

end on

on w_gm1724_regal.create
end on

on w_gm1724_regal.destroy
end on

