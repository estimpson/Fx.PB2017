$PBExportHeader$w_aztec_ford_sd.srw
forward
global type w_aztec_ford_sd from Window
end type
end forward

shared variables

end variables

global type w_aztec_ford_sd from Window
int X=64
int Y=212
int Width=1385
int Height=756
boolean TitleBar=true
string Title="w_ia_ford"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
end type
global w_aztec_ford_sd w_aztec_ford_sd

type variables
st_generic_structure i_st_parm
end variables

event open;i_st_parm = Message.PowerObjectParm
/////////////////////////////////////////////////
//  Declaration
//

LONG		l_Label, &
			l_l_serial, &
			l_position, &
			l_pos_string, &
         l_ordno, & 
         l_shipper, &
			l_s_line_feed

STRING	c_Esc, &
			s_Part, &
			s_CuPart, &
			s_Customer, &
			s_destination, &
			s_Supplier, &
			s_Temp, &
			s_Name1, &
			s_Name2, &
			s_Name3, &
			s_NumberofLabels, &
			s_Suffix, &
         szcompany, &
        	szaddress1, &
			szaddress2, &
			szaddress3, &
			s_blanket_part, &
			SZ_ADD1, &
			SZ_ADD2, &	
			sz_ADD3,&
			S_LINE_FEED_CODE, &
			S_DOCK_CODE, &
			SZ_TEMP, &
			sz_bef, &
			sz_aft , &
			SZ_DOCKCODE ,&
			SZ_LINFEED ,&
			s_sch, &
			s_dest,&
			S_LONG, &
			S_LONG1, &
			S_LONG2, &
			S_LONG3,   &
			s_linecode,   &
			szDest,   &
			szDestName,    &
			s_eng_chg,    &
			s_eng_level


Dec {0} dec_Quantity

int i_len, i_cur, i_ctr

DATETIME    ldt_Date
DateTime		s_max_date

//l_s_line_feed = sle_line_feed.text

///////////////////////////////////////////////
//  Initialization
//

l_l_serial = LONG ( i_st_parm.value1 )

  SELECT PART,
			quantity,   
         shipper,
			engineering_level
    INTO :S_PART,
			:dec_Quantity,   
         :l_shipper,
			:s_eng_chg
    FROM object  
   WHERE serial = :l_l_serial   ;

select audit_trail.date_stamp
		into :ldt_Date
		from audit_trail 
		where audit_trail.serial = :l_l_serial and 
		(audit_trail.type = 'J' or audit_trail.type = 'R') ;

//SELECT		order_header.customer_part,
//				order_header.line_feed_code,
//				order_header.dock_code,
//				order_header.zone_code,
//				order_header.destination
//  INTO 		:s_Cupart,
//			  	:s_line_feed_code,
//			  	:s_DOCK_CODE,
//			  	:s_linecode,
//			 	:s_destination
//  FROM 		object, 
//  				order_header, 
//				shipper_detail,
//				shipper,
//				work_order
// WHERE		object.workorder = work_order.work_order  AND
// 				work_order.order_no = shipper_detail.order_no  AND
//				shipper_detail.shipper = shipper.id  AND
//				order_header.blanket_part = object.part  AND
//				object.serial = :l_l_serial 	;
				
SELECT	order_header.customer_part,
  			order_header.line_feed_code,
			order_header.dock_code,
			order_header.zone_code,
			order_header.destination
    INTO	:s_Cupart,
			:s_line_feed_code,
			:s_DOCK_CODE,
			:s_linecode,
			:s_destination
    FROM	order_header, 
	 		shipper_detail, 
			object
   WHERE	order_header.order_no = shipper_detail.order_no AND
			shipper_detail.shipper = object.shipper AND
			shipper_detail.part_original = object.part AND
			object.serial = :l_l_Serial  ;

	SELECT DESTINATION.SCHEDULER,
			 DESTINATION.ADDRESS_1,
   		 DESTINATION.ADDRESS_2,
			 DESTINATION.ADDRESS_3,
			 Destination.Name
	INTO   :S_SCH,
			 :SZ_ADD1,
			 :SZ_ADD2,
			 :SZ_ADD3,
			 :szDestName	  	
	FROM 	   DESTINATION,customer
	WHERE		destination.customer = customer.customer and
				destination.destination = :s_destination ;			
				
SELECT DISTINCT max ( effective_Date ),
	    effective_change_notice.engineering_level		
  INTO :s_max_date,
  		 :s_eng_level
  FROM effective_change_notice,
       object	
 WHERE effective_change_notice.part = object.part AND
       object.serial = :l_l_serial 
GROUP BY  effective_change_notice.engineering_level	;

SELECT 		part.name,
				PART.DESCRIPTION_LONG
    INTO 	:s_Temp,
				:S_LONG 
    FROM 	part  
   WHERE 	PART.part = :s_Part ;

 SELECT edi_setups.supplier_code,
		  edi_setups.destination	  
    INTO :s_Supplier,
		  :szdest  
    FROM edi_setups  
   WHERE edi_setups.destination = :s_destination   ;  
 
// To get the order number from the shipper detail table 

  SELECT order_no
    INTO :l_ordno
    FROM shipper_detail
   WHERE shipper = :l_shipper and part = :s_part;
 
SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;
 
// to get the number of copies of the label 

If i_st_parm.value11 = "" Then 
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + i_st_parm.value11
End If

// TO PRINT PART NO. - EXTREME right portion

sz_temp = trim(s_cupart)
i_len = len(sz_temp)

if i_len > 0  then
	for i_cur = 1 to i_len	
		 if (mid(sz_temp,i_cur,1) = ' ') then	
			 i_ctr = i_cur
		 end if 
	next 
end if
if i_ctr = 0 then 
	sz_bef = sz_temp
   SZ_AFT = ''
elseif i_ctr > 1 then 
	sz_bef = left(sz_temp,i_ctr)
	sz_aft = mid(sz_temp,(i_ctr + 1),i_len)
elseif i_ctr > 0 then 
	sz_bef = LEFT(sz_temp,i_ctr) 
	sz_aft = mid(sz_temp,(i_ctr + 1),i_len)
end if 

c_Esc = "~h1B"

 SZ_DOCKCODE = MID (s_dock_code,1,3)
 SZ_LINFEED = MID (s_line_feed_code,1,5)
 s_dest = MID (SzDEST,3,2)

S_LONG1 = MID (S_LONG,1,35)
S_LONG2 = MID (S_LONG,36,35)
S_LONG3 = MID (S_LONG,71,35)

/////////////////////////////////////////////////
//  Main Routine
//

l_Label = PrintOpen ( )

//  Start Printing
PrintSend ( l_Label, c_Esc + "A" )//+ c_Esc + "R" )

//  Part Info
PrintSend ( l_Label, c_Esc + "V020" + c_Esc + "H040" + c_Esc + "M" + "PART NO" )
PrintSend ( l_Label, c_Esc + "V040" + c_Esc + "H040" + c_Esc + "M" + "(P)" )
PrintSend ( l_Label, c_Esc + "V020" + c_Esc + "H200" + c_Esc + "$A,120,130,0" + c_esc + "$=" + UPPER ( s_cupart ) )
PrintSend ( l_Label, c_Esc + "V130" + c_Esc + "H040" + c_Esc + "B103095" + "*" + "P" + UPPER( s_cupart) + "*" )

//PART_NOTE
//PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H150" + c_Esc + "S" + S_LONG1 )
//PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H170" + c_Esc + "S" + S_LONG2 )
//PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H190" + c_Esc + "S" + S_LONG3 )

//QTY
PrintSend ( l_Label, c_Esc + "V240" + c_Esc + "H040" + c_Esc + "M" + "QUANTITY" )
PrintSend ( l_Label, c_Esc + "V260" + c_Esc + "H040" + c_Esc + "M" + "(Q)" )
PrintSend ( l_Label, c_Esc + "V245" + c_Esc + "H100" + c_Esc + "$A,100,100,0" + c_Esc +"$=" + String(dec_Quantity) )
PrintSend ( l_Label, c_Esc + "V340" + c_Esc + "H040" + c_Esc + "B103095" + "*" +"Q" + String(dec_Quantity) + "*" )

//SUFFIX
PrintSend ( l_Label, c_Esc + "V240" + c_Esc + "H640" + c_Esc + "M" + "ENGINEERING LEVEL" )
PrintSend ( l_Label, c_Esc + "V260" + c_Esc + "H640" + c_Esc + "M" + "(C)" )
PrintSend ( l_Label, c_Esc + "V240" + c_Esc + "H700" + c_Esc +"$A,100,110,0" + c_Esc + "$=" + s_eng_level )

if len(sz_aft) > 0 then
PrintSend ( l_Label, c_Esc + "V340" + c_Esc + "H640" + c_Esc + "B103095" + "*" + "P" + s_eng_level + "*" )
end if

//"R" CODE
PrintSend ( l_Label, c_Esc + "V460" + c_Esc + "H640" + c_Esc + "M" + "'R' CODE" )
PrintSend ( l_Label, c_Esc + "V480" + c_Esc + "H640" + c_Esc + "$A,100,110,0" + c_Esc + "$=" + UPPER(S_LINECODE))
//PrintSend ( l_Label, c_Esc + "V630" + c_Esc + "H595" + c_Esc + "$A,30,25,0" + c_Esc + "$=" + STRING(DATE( ldt_Date) ) )

//LINE FEED
PrintSend ( l_Label, c_Esc + "V460" + c_Esc + "H900" + c_Esc + "M" + "LINE FEED" )
PrintSend ( l_Label, c_Esc + "V480" + c_Esc + "H900" + c_Esc + "$A,100,110,0" + c_Esc + "$=" + s_line_feed_code )

//SUPPLIER
PrintSend ( l_Label, c_Esc + "V460" + c_Esc + "H040" + c_Esc + "M" + "SUPPLIER" )
PrintSend ( l_Label, c_Esc + "V480" + c_Esc + "H040" + c_Esc + "M" + "(V)" )
PrintSend ( l_Label, c_Esc + "V470" + c_Esc + "H200" + c_Esc + "WL1" + s_Supplier )
PrintSend ( l_Label, c_Esc + "V545" + c_Esc + "H040" + c_Esc + "B103095" + "*" + "V" + s_Supplier +  "*" )

//SERIAL
PrintSend ( l_Label, c_Esc + "V650" + c_Esc + "H040" + c_Esc + "M" + "SERIAL" )
PrintSend ( l_Label, c_Esc + "V670" + c_Esc + "H040" + c_Esc + "M" + "(S)" )
PrintSend ( l_Label, c_Esc + "V650" + c_Esc + "H200" + c_Esc + "WL1" + String(l_l_serial))
PrintSend ( l_Label, c_Esc + "V695" + c_Esc + "H040" + c_Esc + "B103080" + "*" + "S" + String(l_l_serial) + "*")

//SHIP TO
PrintSend ( l_Label, c_Esc + "V650" + c_Esc + "H620" + c_Esc + "M" + "SHIP TO:(D)" )
PrintSend ( l_Label, c_Esc + "V745" + c_Esc + "H620" + c_Esc + "L0103" + c_Esc + "S" + SzDestName )
PrintSend ( l_Label, c_Esc + "V650" + c_Esc + "H800" + c_Esc + "L0101" + c_Esc + "B103085" + "*" + S_destination + "*")
PrintSend ( l_Label, c_Esc + "V665" + c_Esc + "H620" + c_Esc + "$A,85,85,0" + c_Esc + "$=" + s_destination )
PrintSend ( l_Label, c_Esc + "V745" + c_Esc + "H842" + c_Esc + "M" + SZ_ADD1 )
PrintSend ( l_Label, c_Esc + "V770" + c_Esc + "H842" + c_Esc + "M" + SZ_ADD2 )
PrintSend ( l_Label, c_Esc + "V770" + c_Esc + "H1030" + c_Esc + "M" + SZ_ADD3 )

PrintSend ( l_Label, c_Esc + "V780" + c_Esc + "H040" + c_Esc + "S" + "Aztec Manufacturing Corp.  15378 Oakwood Drive  Romulus, Michigan  48174" )

//  Draw Lines
PrintSend ( l_label, c_Esc + "V235" + c_Esc + "H40" + c_Esc + "FW02H1400" )
PrintSend ( l_label, c_Esc + "V456" + c_Esc + "H40" + c_Esc + "FW02H1400" )
PrintSend ( l_label, c_Esc + "V645" + c_Esc + "H40" + c_Esc + "FW02H1400" )
//PrintSend ( l_label, c_Esc + "V305" + c_Esc + "H617" + c_Esc + "FW02H800" )
PrintSend ( l_label, c_Esc + "V240" + c_Esc + "H617" + c_Esc + "FW02V540" )
PrintSend ( l_label, c_Esc + "V456" + c_Esc + "H895" + c_Esc + "FW02V190" )

PrintSend ( l_Label, c_Esc + s_NumberofLabels )
PrintSend ( l_Label, c_Esc + "Z" )
PrintClose ( l_Label )
Close ( This )
end event

on w_aztec_ford_sd.create
end on

on w_aztec_ford_sd.destroy
end on

