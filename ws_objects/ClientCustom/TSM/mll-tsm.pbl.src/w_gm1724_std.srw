$PBExportHeader$w_gm1724_std.srw
$PBExportComments$This works with a WATCOM Server !!
forward
global type w_gm1724_std from Window
end type
end forward

shared variables
STRING	s_s_destination

INTEGER	s_i_cycles = 0
end variables

global type w_gm1724_std from Window
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
global w_gm1724_std w_gm1724_std

type variables

end variables

forward prototypes
public function integer wf_explode_kanban (LONG al_order_no)
end prototypes

public function integer wf_explode_kanban (LONG al_order_no);LONG	ll_Begin, &
		ll_End, &
		ll_Counter

INTEGER	li_NumberLength, &
			li_NumberSegmentLength

STRING	ls_KANBANNumberRoot, &
		ls_TempKANBANNumber, &
		ls_BeginKANBANNumber, &
		ls_EndKANBANNumber, &
		l11, &
		l12, &
		l13, &
		l14, &
		l15, &
		l16, &
		l17, &
		ls_Zeros = '00000000'

DECIMAL {6}	ldec_StdQty
// Check if KANBAN data already exists for this order.

   SELECT	kanban_number
     INTO	:ls_TempKANBANNumber
     FROM	kanban
    WHERE	order_no = :al_order_no  ;

IF SQLCA.SQLCode <> 100 THEN
	Return 1
END IF

// Get Beginning and Ending KANBAN numbers for this order

   SELECT	begin_kanban_number,
			end_kanban_number
     INTO	:ls_BeginKANBANNumber,
			:ls_EndKANBANNumber
     FROM	order_header
    WHERE	order_no = :al_order_no  ;

IF IsNull ( ls_BeginKANBANNumber ) OR IsNull ( ls_EndKANBANNumber ) THEN
	Return 0
END IF

// Determine begin and end numeric portions of KANBAN numbers
li_NumberLength = Len ( ls_BeginKANBANNumber )

IF li_NumberLength < 1 THEN
	Return -1
END IF
IF NOT IsNumber ( Right ( ls_BeginKANBANNumber, 1 ) ) THEN
	Return -3
END IF

ll_Counter = 2
li_NumberSegmentLength = 1
DO WHILE ( IsNumber ( Right ( ls_BeginKANBANNumber, ll_Counter ) ) AND ll_Counter <= li_NumberLength )
	ll_Counter ++
	li_NumbersegmentLength ++
LOOP
ls_KANBANNumberRoot = Left ( ls_BeginKANBANNumber, li_NumberLength - li_NumberSegmentLength )
IF ls_KANBANNumberRoot <> Left ( ls_EndKANBANNumber, li_NumberLength - li_NumberSegmentLength ) THEN
	Return -2
END IF
ll_Begin = Long ( Right ( ls_BeginKANBANNumber, li_NumberSegmentLength ) )
ll_End = Long ( Right ( ls_EndKANBANNumber, li_NumberSegmentLength ) )

// Generate KANBAN data for KANBAN numbers in range

   SELECT	line11,
			line12,
			line13,
			line14,
			line15,
			line16,
			line17,
			standard_pack
     INTO	:l11,
			:l12,
			:l13,
			:l14,
			:l15,
			:l16,
			:l17,
			:ldec_StdQty
     FROM	order_header
    WHERE	order_no = :al_order_no  ;


FOR ll_Counter = ll_Begin TO ll_End
	
	ls_TempKANBANNumber = ls_KANBANNumberRoot + &
		Left ( ls_Zeros, li_NumberSegmentLength - Len ( String ( ll_Counter ) ) ) + &
		String ( ll_Counter )

	   INSERT INTO kanban
				(	order_no,
					kanban_number,
					line11,
					line12,
					line13,
					line14,
					line15,
					line16,
					line17,
					status,
					standard_quantity )
	   VALUES	(	:al_order_no,
					:ls_TempKANBANNumber,
					:l11,
					:l12,
					:l13,
					:l14,
					:l15,
					:l16,
					:l17,
					'A',
					:ldec_StdQty )  ;

NEXT

commit  ;

Return 1
end function

on open;st_generic_structure ast_parm

/////////////////////////////////////////////////
//  Declaration
//
CHAR	lc_esc = "~h1B"

LONG	ll_serial, &
		ll_order_no, &
		ll_label

STRING	ls_begin_kanban, &
			ls_kanban_number, &
			ls_line11, &
			ls_line12, &
			ls_line13, &
			ls_line14, &
			ls_line15, &
			ls_line16, &
			ls_line17, &
			ls_lot, &
			ls_operator, &
			ls_customer_part, &
			ls_customer_po, &
			ls_supplier_code, &
			ls_eng_level, &
			ls_company, &
			ls_address_1, &
			ls_address_2, &
			ls_address_3, &
			ls_part, &
			ls_number_of_labels


DATETIME	ldt_date

DEC {6}	ldec_quantity

///////////////////////////////////////////////
//  Initialization

ast_Parm = Message.PowerObjectParm
ll_serial = Long ( ast_parm.value1 )

/*	Determine type of order...	*/
	SELECT	order_header.order_no,
				begin_kanban_number
	  INTO	:ll_order_no,
				:ls_begin_kanban
	  FROM	object, shipper_detail, order_header
	 WHERE	object.serial = :ll_serial AND
				object.shipper = shipper_detail.shipper AND
				object.part = shipper_detail.part_original AND
				shipper_detail.order_no = order_header.order_no  ;
IF ls_begin_kanban > '' THEN

/*	...this is a KANBAN order so... */

	//  1.Explode kanban table
	wf_explode_kanban ( ll_order_no )

	//  2.Check object for KANBAN...
		  SELECT	kanban_number
			 INTO	:ls_kanban_number
			 FROM	object
			WHERE	serial = :ll_serial  ;

	//	3.If this doesn't already have a kanban
	IF ls_kanban_number = "" THEN
		//	A.Get the next available KANBAN
			  SELECT	Min ( kanban_number )
				 INTO	:ls_kanban_number
				 FROM	kanban
				WHERE	order_no = :ll_order_no AND
						status = 'A'  ;
		IF	IsNull ( ls_kanban_number ) THEN
			MessageBox ( "Monitor 3.3h For Windows 95", "No available KANBAN's for order." )
			Close ( this )
			Return
		END IF

		// B.Write KANBAN to object
			  UPDATE	object
				  SET	kanban_number = :ls_kanban_number
				WHERE	serial = :ll_serial  ;

		//	C.Mark KANBAN as used
			  UPDATE	kanban
				  SET	status = 'U'
				WHERE	order_no = :ll_order_no AND
						kanban_number = :ls_kanban_number  ;

			  COMMIT  ;
	 END IF
	// 4. Get l11 through l17 for this KANBAN
		  SELECT	line11,
					line12,
					line13,
					line14,
					line15,
					line16,
					line17
			 INTO	:ls_line11,
					:ls_line12,
					:ls_line13,
					:ls_line14,
					:ls_line15,
					:ls_line16,
					:ls_line17
			 FROM	kanban
			WHERE	order_no = :ll_order_no AND
					kanban_number = :ls_kanban_number  ;
ELSE

/*	...this isn't a KANBAN order so... */

	  SELECT	line11,
				line12,
				line13,
				line14,
				line15,
				line16,
				line17
		 INTO	:ls_line11,
				:ls_line12,
				:ls_line13,
				:ls_line14,
				:ls_line15,
				:ls_line16,
				:ls_line17
	    FROM	order_header
	   WHERE order_header.order_no = :ll_order_no   ;
END IF

  SELECT	part,
			quantity,   
			lot,
			operator,
			last_date
    INTO :ls_part,
			:ldec_quantity,
			:ls_lot,
			:ls_operator,
			:ldt_date
    FROM object  
   WHERE serial = :ll_serial   ;

  SELECT	date_stamp
	 INTO	:ldt_Date
    FROM	audit_trail 
   WHERE	serial = :ll_serial AND
			(type = 'J' OR type = 'R')  ;

  SELECT	customer_part,
			customer_po,
			supplier_code
	 INTO	:ls_customer_part,
		 	:ls_customer_po,
		 	:ls_supplier_code
    FROM	order_header,
			edi_setups
   WHERE	order_header.order_no = :ll_order_no AND
			order_header.destination = edi_setups.destination  ;

  SELECT	part_mfg.engineering_level
    INTO	:ls_eng_level
    FROM	object,
			part_mfg 
   WHERE	object.part = part_mfg.part AND
			serial = :ll_serial  ;
 
  SELECT	parameters.company_name, address_1, address_2, address_3
	 INTO	:ls_company,
			:ls_address_1,
			:ls_address_2,
			:ls_address_3
    FROM	parameters ;
 
IF ast_parm.value11 = "" THEN
   ls_number_of_labels = "Q1"
ELSE
	ls_number_of_labels = "Q" + ast_parm.value11
END IF

/////////////////////////////////////////////////
//  Main Routine
//
ll_label = PrintOpen ( )

PrintSend ( ll_label, lc_esc + "A" + lc_esc + "R" )
PrintSend ( ll_label, lc_esc + "CS2")

//PART INFO
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V40" + lc_esc + "L0102" + lc_esc + "SPART #" )
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V70" + lc_esc + "S(P)" )
PrintSend ( ll_label, lc_esc + "H385" + lc_esc + "V20" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + Upper ( ls_customer_part ) )
PrintSend ( ll_label, lc_esc + "H330" + lc_esc + "V140" + lc_esc + "D103070" + "*P" + ls_customer_part + "*" )

////QUANTITY INFO
PrintSend ( ll_label, lc_esc + "H920" + lc_esc + "V167" + lc_esc + "L0102" + lc_esc + "SQUANTITY" ) 
PrintSend ( ll_label, lc_esc + "H920" + lc_esc + "V195" + lc_esc + "S(Q)" )
PrintSend ( ll_label, lc_esc + "H1135" + lc_esc + "V100" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + String ( ldec_quantity, "0" ) )
PrintSend ( ll_label, lc_esc + "H1010" + lc_esc + "V25" + lc_esc + "D103090" + "*Q" + String ( ldec_quantity, "0" ) + "*" )

//PO NO.
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V240" + lc_esc + "L0102" + lc_esc + "SPO #." )
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V265" + lc_esc + "S(K)" )
PrintSend ( ll_label, lc_esc + "H405" + lc_esc + "V205" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + ls_customer_po )
PrintSend ( ll_label, lc_esc + "H330" + lc_esc + "V325" + lc_esc + "D103090" + "*K" + ls_customer_po + "*" )

//DLOC
PrintSend ( ll_label, lc_esc + "H920" + lc_esc + "V240" + lc_esc + "L0102" + "DLOC" )
PrintSend ( ll_label, lc_esc + "H980" + lc_esc + "V210" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + ls_line11 )

//KANBAN
PrintSend ( ll_label, lc_esc + "H920" + lc_esc + "V355" + lc_esc + "L0102" + lc_esc + "SKANBAN #" )
PrintSend ( ll_label, lc_esc + "H1020" + lc_esc + "V335" + lc_esc + "$A,100,100,0" + lc_esc + "$=" + ls_kanban_number )
 
//SERIAL NO
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V440" + lc_esc + "L0102" + lc_esc + "SSERIAL #" )
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V470" + lc_esc + "S(3S)" )
PrintSend ( ll_label, lc_esc + "H425" + lc_esc + "V405" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + String ( ll_serial ) )
PrintSend ( ll_label, lc_esc + "H330" + lc_esc + "V527" + lc_esc + "D103090" + "*3S" + String ( ll_serial ) + "*" )

//ENG CHG
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V640" + lc_esc + "L0102" + lc_esc + "SENG CHANGE:" )
PrintSend ( ll_label, lc_esc + "H435" + lc_esc + "V640" + lc_esc + "L0101" + lc_esc + "OB" + ls_eng_level  )

//SHIP DATE
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V675" + lc_esc + "L0102" + lc_esc + "S" + "MFG. SHIP DATE:" )
PrintSend ( ll_label, lc_esc + "H455" + lc_esc + "V675" + lc_esc + "L0101" + lc_esc + "OB" + String ( ldt_date, "yy/mm/dd") )

//LOT NO.
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V707" + lc_esc + "L0102" + lc_esc + "S" + "LOT NO.:" )
PrintSend ( ll_label, lc_esc + "H385" + lc_esc + "V707" + lc_esc + "L0101" + lc_esc + "OB" + ls_lot )

//INT PART
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V742" + lc_esc + "L0102" + lc_esc + "S" + "INT PART:" )
PrintSend ( ll_label, lc_esc + "H385" + lc_esc + "V742" + lc_esc + "L0101" + lc_esc + "OB" + ls_part )

//PACKER
PrintSend ( ll_label, lc_esc + "H295" + lc_esc + "V785" + lc_esc + "L0102" + lc_esc + "S" + "PACKER:" )
PrintSend ( ll_label, lc_esc + "H385" + lc_esc + "V785" + lc_esc + "L0101" + lc_esc + "OB" + ls_operator )

//PLT/DOCK
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V440" + lc_esc + "L0102" + lc_esc + "S" + "PLT/DOCK" )
PrintSend ( ll_label, lc_esc + "H960" + lc_esc + "V410" + lc_esc + "$A,110,145,0" + lc_esc + "$=" + ls_line12 )

//ZONE_CODE,LINE_FEED & CUSTOM03
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V550" + lc_esc + "L0101" + lc_esc + "WB1" + ls_line13 )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V550" + lc_esc + "L0101" + lc_esc + "WB1" + ls_line14 )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V590" + lc_esc + "L0101" + lc_esc + "WB1" + ls_line15 )

//ZONE_CODE,LINE_FEED & CUSTOM03(FROM ORDER_DETAIL)
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V640" + lc_esc + "L0101" + lc_esc + "M" +  "CUST MISCELLANEOUS AREA" )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V653" + lc_esc + "$A,70,75,0" + lc_esc + "$=" +  ls_line17 )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V720" + lc_esc + "L0101" + lc_esc + "OB" + "SUPPLIER ID:" )
PrintSend ( ll_label, lc_esc + "H1140" + lc_esc + "V720" + lc_esc + "L0101" + lc_esc + "OB" + ls_supplier_code )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V745" + lc_esc + "$A,50,40,0" + lc_esc + "$=" + ls_company )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V787" + lc_esc + "L0101" + lc_esc + "M" + ls_address_1 + " " + ls_address_2 )
PrintSend ( ll_label, lc_esc + "H860" + lc_esc + "V810" + lc_esc + "L0101" + lc_esc + "M" + ls_address_3 )

//DRAW LINES
PrintSend ( ll_label, lc_esc + "H280" + lc_esc + "V225" + lc_esc + "FW02H1100" ) 
PrintSend ( ll_label, lc_esc + "H905" + lc_esc + "V25" + lc_esc + "FW02V400" ) 
PrintSend ( ll_label, lc_esc + "H280" + lc_esc + "V425" + lc_esc + "FW02H1100" ) 
PrintSend ( ll_label, lc_esc + "H845" + lc_esc + "V427" + lc_esc + "FW02V395" ) 
PrintSend ( ll_label, lc_esc + "H280" + lc_esc + "V627" + lc_esc + "FW02H1100" ) 

PrintSend ( ll_label, lc_esc +  ls_number_of_labels )
PrintSend ( ll_label, lc_esc + "Z" )
PrintClose ( ll_label )
Close ( this )
end on

on w_gm1724_std.create
end on

on w_gm1724_std.destroy
end on

