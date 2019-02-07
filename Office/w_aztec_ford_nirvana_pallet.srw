HA$PBExportHeader$w_aztec_ford_nirvana_pallet.srw
forward
global type w_aztec_ford_nirvana_pallet from Window
end type
end forward

global type w_aztec_ford_nirvana_pallet from Window
int X=672
int Y=264
int Width=1582
int Height=992
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_aztec_ford_nirvana_pallet w_aztec_ford_nirvana_pallet

type variables
St_generic_structure ast_Parm
end variables

event open;//	Declaration
long	l_Label, &
	l_Serial, &
	l_position, &
	l_pos_string, &
	l_ordno, & 
	l_shipper
string	c_Esc, &
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
	szeng,&
	s_line_feed_code, &
	s_dock_code, &
	sz_temp, &
	sz_bef, &
	sz_aft , &
	sz_dockcode ,&
	sz_linfeed,&
	s_sch, &
	sz_add1, &
	sz_add2, &	
	sz_add3,&
	s_plant_abb,&
	szdestname,    &
	s_dest, &
	sz_comp, &
	ls_materialissuer,&
	ls_destinationcode,&
	ls_dockcode,&
	ls_destadd1,&
	ls_destadd2,&
	ls_destadd3,&
	ls_destcode,&
	ls_linecode
Dec {0} dec_Quantity
int i_len, i_cur, i_ctr
datetime    ldt_Date

//	Initialization
ast_Parm = Message.PowerObjectParm
l_Serial = LONG ( ast_Parm.Value1 )

//	Modified to represent Pallet    HR 6/29/00
//	Part and Qty where serial is parent
select	part,   
	sum(quantity) 
into	:s_Part,   
	:dec_Quantity
from	object  
where	parent_serial = :l_Serial 
group by part;

//	Dest and shipper where serial
select	destination,
	shipper
into	:s_destination,
	:l_shipper
from	object  
where 	serial = :l_Serial;

//	Modified to represent Pallet    HR 6/29/00
select	audit_trail.date_stamp
into	:ldt_Date
from	audit_trail 
where	audit_trail.serial = :l_serial and 
	audit_trail.type = 'P' ;

select	order_header.customer_part,
	order_header.line_feed_code,
	order_header.DOCK_CODE,
	order_header.zone_code,
	shipper.destination
into	:s_Cupart,
	:s_line_feed_code,
	:ls_DockCode,
	:ls_linecode,
	:s_Destination
from	order_header, shipper_detail, shipper, object
where	order_header.order_no = shipper_detail.order_no AND
	shipper.id = shipper_detail.shipper AND
	shipper_detail.shipper = object.shipper AND
	shipper_detail.part_original = object.part AND
	object.parent_serial = :l_Serial; 

select	supplier_code,
	destination,
	material_issuer
into	:s_Supplier,
	:ls_DestinationCode,
	:ls_MaterialIssuer
from	edi_setups  
where	destination = :s_destination;  

select	customer_part 
into	:s_cupart
from	shipper_detail
where	part = :s_part and shipper = :l_shipper;
	
//	Pulling Assembly Plant Code from Destination
ls_DestCode = mid (ls_DestinationCode, 3, 2)

select	address_1,
	address_2,
	address_3
into	:ls_destadd1,
	:ls_destadd2,
	:ls_destadd3
from	destination
where	destination = :s_destination;
	
//	in case if it not found in the above table find it in the part master
if isnull(s_cupart) or s_cupart = ''  then
	select	cross_ref
	into	:s_cupart  
	from	part  
	where	part = :s_part;
end if  

//	To get the order number from the shipper detail table 
select	order_no
into	:l_ordno
from	shipper_detail
where	shipper = :l_shipper and part = :s_part;
 
select	parameters.company_name, address_1, address_2, address_3
into	:szcompany,
	:szaddress1,
	:szaddress2,
	:szaddress3
from	parameters ;
 
//	Joe's addition
select	destination.scheduler,
	destination.address_1,
	destination.address_2,
	destination.address_3,
	destination.address_6,
	destination.name
into	:s_sch,
	:sz_add1,
	:sz_add2,
	:sz_add3,
	:s_plant_abb,
	:szdestname	  	
from	destination
where	destination.destination = :s_destination;

//	to get the number of copies of the label 
If ast_Parm.value11 = "" Then 
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + ast_Parm.value11
End If

//	to print part no. - extreme right portion
sz_temp = righttrim(s_cupart)
i_len = len(sz_temp)
if i_len > 0  then
	for i_cur = 1 to i_len	
		 if (mid(sz_temp,i_cur,1) = ' ' OR mid(sz_temp,i_cur,1) = '-') then	
			 i_ctr = i_cur
		 end if 
	next 
end if

if i_ctr <= 1 then 
	sz_bef = sz_temp
	sz_aft = ''
else
	sz_bef = left(sz_temp,i_ctr - 1)
	sz_aft = mid(sz_temp,(i_ctr + 1))
end if

c_Esc = "~h1B"
// SZ_DOCKCODE = MID (Ls_dockcode,0,4)
// SZ_LINFEED = MID (s_line_feed_code,0,6)
sz_dockcode	= mid (ls_dockcode,1,3)
sz_linfeed	= mid (s_line_feed_code,1,5)
s_dest	= mid (s_destination,3,2)
sz_add1 = left(sz_add1,17)
sz_add2 = left(sz_add2,17)
sz_add3 = left(sz_add3,17)
szdestname	= left(szdestname,4)

//	Main Routine

l_Label = PrintOpen ( )

//  Start Printing
PrintSend ( l_Label, c_Esc + "A" )
// Change orientation for testing
// PrintSend ( l_Label, c_Esc + "R" + c_Esc + "R" + c_Esc + "R" )

//	Label Header
PrintSend ( l_Label, c_Esc + "V20" + c_Esc + "H410" + c_Esc + "WL1" + "MASTER LABEL" )
PrintSend ( l_Label, c_Esc + "V20" + c_Esc + "H60" + c_Esc + "L0101" + "" )

//	Part Info
PrintSend ( l_Label, c_Esc + "V90" + c_Esc + "H40" + c_Esc + "M" + "PART NO" )
PrintSend ( l_Label, c_Esc + "V110" + c_Esc + "H40" + c_Esc + "M" + "(P)" )
PrintSend ( l_Label, c_Esc + "V40" + c_Esc + "H210" + c_Esc + "$B,150,150,0" + c_Esc + "$=" + sz_bef )
//PrintSend ( l_Label, c_Esc + "V70" + c_Esc + "H190" + c_Esc + "$A,120,120,0" + c_Esc + "$=" + s_cupart )
PrintSend ( l_Label, c_Esc + "V170" + c_Esc + "H140" + c_Esc + "B103095" + "*" + "P" + UPPER( sz_bef) + "*" )

//	Quantity
PrintSend ( l_Label, c_Esc + "V278" + c_Esc + "H40" + c_Esc + "M" + "QUANTITY" )
PrintSend ( l_Label, c_Esc + "V303" + c_Esc + "H40" + c_Esc + "M" + "(Q)" )
PrintSend ( l_Label, c_Esc + "V263" + c_Esc + "H190" + c_Esc + "$A,110,100,0" + c_Esc +"$=" + String(dec_Quantity) )
//PrintSend ( l_Label, c_Esc + "V360" + c_Esc + "H90" + c_Esc + "B103095" + "*" +"Q" + String(dec_Quantity) + "*" )
PrintSend ( l_Label, c_Esc + "V360" + c_Esc + "H40" + c_Esc + "B103095" + "*" +"Q" + String(dec_Quantity) + "*" )

//	Part Suffix
PrintSend ( l_Label, c_Esc + "V278" + c_Esc + "H703" + c_Esc + "M" + "PART NO." )
PrintSend ( l_Label, c_Esc + "V303" + c_Esc + "H703" + c_Esc + "M" + "(C)" )
PrintSend ( l_Label, c_Esc + "V263" + c_Esc + "H835" + c_Esc +"$B,110,100,0" + c_Esc + "$=" + UPPER(sz_aft) )
if len(sz_aft) > 0 then
PrintSend ( l_Label, c_Esc + "V360" + c_Esc + "H723" + c_Esc + "B103095" + "*" + "C" + UPPER(sz_aft) + "*" )
end if

//	R Code
PrintSend ( l_Label, c_Esc + "V474" + c_Esc + "H703" + c_Esc + "M" + "'R' CODE" )
PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H703" + c_Esc + "$A,75,85,0" + c_Esc + "$=" + UPPER(ls_LineCode))
// PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H703" + c_Esc + "$A,75,85,0" + c_Esc + "$=" + UPPER(ls_DockCode))
PrintSend ( l_Label, c_Esc + "V575" + c_Esc + "H708" + c_Esc + "$A,30,25,0" + c_Esc + "$=" + STRING(DATE( ldt_Date) ) )

//	Line Feed
PrintSend ( l_Label, c_Esc + "V474" + c_Esc + "H928" + c_Esc + "M" + "LINE FEED" )
PrintSend ( l_Label, c_Esc + "V500" + c_Esc + "H915" + c_Esc + "$A,75,85,0" + c_Esc + "$=" + UPPER(SZ_LINFEED))

//	Supplier
PrintSend ( l_Label, c_Esc + "V474" + c_Esc + "H40" + c_Esc + "M" + "SUPPLIER" )
PrintSend ( l_Label, c_Esc + "V499" + c_Esc + "H40" + c_Esc + "M" + "(V)" )
PrintSend ( l_Label, c_Esc + "V470" + c_Esc + "H190" + c_Esc + "WL1" + s_Supplier )
//PrintSend ( l_Label, c_Esc + "V513" + c_Esc + "H90" + c_Esc + "B103095" + "*" + "V" + s_Supplier + "*" )
PrintSend ( l_Label, c_Esc + "V513" + c_Esc + "H40" + c_Esc + "B103095" + "*" + "V" + s_Supplier + "*" )

//	Lot/Serial
PrintSend ( l_Label, c_Esc + "V623" + c_Esc + "H40" + c_Esc + "M" + "LOT/SERIAL" )
PrintSend ( l_Label, c_Esc + "V651" + c_Esc + "H40" + c_Esc + "M" + "(S)" )
PrintSend ( l_Label, c_Esc + "V618" + c_Esc + "H190" + c_Esc + "WL1" + String(l_Serial))
//PrintSend ( l_Label, c_Esc + "V663" + c_Esc + "H90" + c_Esc + "B103095" + "*" + "S" + String(l_Serial) + "*")
PrintSend ( l_Label, c_Esc + "V673" + c_Esc + "H40" + c_Esc + "B103095" + "*" + "S" + String(l_Serial) + "*")

//	Ship to
PrintSend ( l_Label, c_Esc + "V625" + c_Esc + "H588" + c_Esc + "S" + "SHIP TO:" )
PrintSend ( l_Label, c_Esc + "V620" + c_Esc + "H1090" + c_Esc + "S" + "DOCK ID" )
PrintSend ( l_Label, c_Esc + "V626" + c_Esc + "H745" + c_Esc + "M" + "(D)" )
PrintSend ( l_Label, c_Esc + "V646" + c_Esc + "H745" + c_Esc + "M" + s_dest )

// PrintSend ( l_Label, c_Esc + "V625" + c_Esc + "H588"  + c_Esc + "$A,75,85,0" + c_Esc + "$=" + SzDestName)
// PrintSend ( l_Label, c_Esc + "V720" + c_Esc + "H332" + c_Esc + "L0103" + c_Esc + "S" + SzDestName )
PrintSend ( l_Label, c_Esc + "V619" + c_Esc + "H793" + c_Esc +  "B103095" + "*" + "D" + S_Dest + "*")
//PrintSend ( l_Label, c_Esc + "V620" + c_Esc + "H1070" + c_Esc + "$A,75,85,0" + c_Esc + "$=" + sz_DockCode )
PrintSend ( l_Label, c_Esc + "V620" + c_Esc + "H1090" + c_Esc + "$A,85,95,0" + c_Esc + "$=" + left(sz_DockCode,2) )

//	joe's changes
// PrintSend ( l_Label, c_Esc + "V620" + c_Esc + "H1070" + c_Esc + "$A,75,85,0" + c_Esc + "$=" + UPPER(ls_DockCode))
PrintSend ( l_Label, c_Esc + "V720" + c_Esc + "H598" + c_Esc + "$A,25,50,0" + c_Esc + "$=" + "FORD MOTOR" )
// PrintSend ( l_Label, c_Esc + "V722" + c_Esc + "H828" + c_Esc + "S" + ls_DestAdd1 )
// PrintSend ( l_Label, c_Esc + "V742" + c_Esc + "H828" + c_Esc + "S" + ls_DestAdd2 )
// PrintSend ( l_Label, c_Esc + "V762" + c_Esc + "H828" + c_Esc + "S" + ls_DestAdd3 )

PrintSend ( l_Label, c_Esc + "V645" + c_Esc + "H608" + c_Esc + "$A,65,50,0" + c_Esc + "$=" + s_plant_abb )
PrintSend ( l_Label, c_Esc + "V722" + c_Esc + "H808" + c_Esc + "M" + SZ_ADD1 )
PrintSend ( l_Label, c_Esc + "V742" + c_Esc + "H808" + c_Esc + "M" + SZ_ADD2 )
PrintSend ( l_Label, c_Esc + "V762" + c_Esc + "H808" + c_Esc + "M" + SZ_ADD3 )

PrintSend ( l_Label, c_Esc + "V780" + c_Esc + "H040" + c_Esc + "S" + "Aztec Manufacturing Corp.  15378 Oakwood Drive  Romulus, Michigan  48174" )

//  Draw Lines
//PrintSend ( l_Label, c_Esc + "N" )
//PrintSend ( l_Label, c_Esc + "V1275" + c_Esc + "H285" + c_Esc + "OB" + s_part )

PrintSend ( l_label, c_Esc + "V273" + c_Esc + "H40" + c_Esc + "FW02H1142" )
PrintSend ( l_label, c_Esc + "V465" + c_Esc + "H40" + c_Esc + "FW02H1142" )
PrintSend ( l_label, c_Esc + "V613" + c_Esc + "H40" + c_Esc + "FW02H1142" )

PrintSend ( l_label, c_Esc + "V273" + c_Esc + "H569" + c_Esc + "FW02V500" )
PrintSend ( l_label, c_Esc + "V465" + c_Esc + "H895" + c_Esc + "FW02V148" )
PrintSend ( l_label, c_Esc + "V613" + c_Esc + "H1085" + c_Esc + "FW02V102" )

PrintSend ( l_Label, c_Esc + s_NumberofLabels )
PrintSend ( l_Label, c_Esc + "Z" )
PrintClose ( l_Label )
Close ( this )

end event

on w_aztec_ford_nirvana_pallet.create
end on

on w_aztec_ford_nirvana_pallet.destroy
end on

