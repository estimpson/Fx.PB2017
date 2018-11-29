$PBExportHeader$w_21cent_cust.srw
$PBExportComments$21st Century Cust Label
forward
global type w_21cent_cust from window
end type
end forward

global type w_21cent_cust from window
integer x = 823
integer y = 360
integer width = 1989
integer height = 1184
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
end type
global w_21cent_cust w_21cent_cust

type variables
st_generic_structure stparm
end variables

event open;//  21st Century Standard Customer Label
//  Declaration
Dec {0}	dQuantity
Date	dDate
datetime dt_date, dt_time
Long	ll_Label		  // 32-bit Open Handle
Long	lSerial
Long	ll_shipper
Long	ll_orderno
String	cEsc         // Escape Code
String	szLoc        // Location
String	szLot        // Material Lot
String	szUnit       // Unit Of Measure
String	szOperator   // Operator
String	szPart, szP, szHdrCustPart, szDtlCustPart
String	szCrossRef
String	szDescription
String	szdestination
String	szSupplier
String	szCompany, szEng, szLine, szFinal
String	szTemp
String	szName1
String	szName2
String	szName3
String	szAddress1, szAddress2, szAddress3
String	szNumberofLabels
String	s_PoNumber
String	szCustomerName
String	szCustomer
String	szDestName
String	szDestAddr1, szDestAddr2, szDestAddr3
String	szOrigin
String	ls_custom4
String	ls_dest
Time	tTime

//  Initialization
Stparm = Message.PowerObjectParm
lSerial     = Long(Stparm.Value1)

select
	o.part
,	o.lot
,	o.location
,	o.last_date
,	o.unit_measure
,	o.operator
,	o.quantity
,	o.last_time
,	o.destination
,	o.shipper
,	o.origin
,	coalesce
	(	o.custom4
	,	(	select
	 			max(convert(varchar, od.order_no))
	 		from
	 			dbo.order_detail od
			where
				od.part_number = o.part
				and coalesce(o.shipper, -1) <= 0
	 	)
	)
into
	:szpart,   
	:szlot,   
	:szloc,   
	:dt_date,   
	:szunit,   
	:szoperator,   
	:dquantity,   
	:dt_time, 
	:szdestination,
	:ll_shipper,
	:szorigin,
	:ls_custom4
from
	dbo.object o
where
	o.serial = :lserial;
	
ll_orderno = long ( ls_custom4 ) 

/* Use Origin for shipper if needed--from packline without autostage */
If ( isnull(ll_shipper) or ll_shipper = 0 ) and isNumber(szOrigin) Then
	ll_shipper = long(szOrigin)
End If

dDate = date(dt_date)
ttime = time(dt_time)

//	Part info
select	name  
into	:sztemp 
from	part  
where	part.part = :szpart;

//	Company info
select	parameters.company_name, address_1, address_2, address_3
into	:szcompany, :szaddress1, :szaddress2, :szaddress3 
from	parameters;

//	ECC info
select	effective_change_notice.engineering_level  
into	:szeng  
from	effective_change_notice  
where	effective_change_notice.effective_date <= :ddate
	and effective_change_notice.part = :szpart
order by effective_change_notice.effective_date desc;

if isnull(ll_shipper,0) <= 0 then
	if ll_orderno > 0 then 
		//	Blanket Order, shipper & customer info
		select	oh.customer_po,oh.customer_part,oh.customer, oh.destination, c.name
		into	:s_ponumber, :szhdrcustpart, :szcustomername, :ls_dest, :szcustomer
		from	order_header oh,
			customer c
		where	oh.customer = c.customer and 
			oh.order_no = :ll_orderno;
			
			//	Normal Order, shipper & customer info
		select	 distinct oh.customer_po,od.customer_part,oh.customer, oh.destination, c.name
		into	:s_ponumber, :szDtlCustPart, :szcustomername, :ls_dest, :szcustomer
		from	order_header oh,
			customer c,
			order_detail od
		where	oh.customer = c.customer and 
			oh.order_no = :ll_orderno and
			od.order_no = :ll_orderno and
			od.part_number = :szpart;
		
		//	Destination info
		select	destination.name,   
			destination.address_1,   
			destination.address_2,   
			destination.address_3  
		into	:szdestname,   
			:szdestaddr1,   
			:szdestaddr2,   
			:szdestaddr3  
		from	destination
		where	destination.destination = :ls_dest;
	end if 
else
	//	Order, shipper & customer info
	select	order_header.customer_po,shipper_detail.customer_part, shipper_detail.customer_part,customer.name,order_header.customer
	into	:s_ponumber, :szhdrcustpart, :szdtlcustpart,:szcustomername, :szcustomer
	from	order_header,shipper_detail,customer
	where	order_header.order_no = shipper_detail.order_no and
		order_header.customer = customer.customer and
		shipper_detail.shipper = :ll_shipper and
		shipper_detail.part_original = :szpart;

	//	Edi info
	select	supplier_code  
	into	:szsupplier  
	from	edi_setups, 
		shipper  
	where	edi_setups.destination = shipper.destination and
		shipper.id = :ll_shipper;
	
	//	Destination info
	select	destination.name,   
		destination.address_1,   
		destination.address_2,   
		destination.address_3  
	into	:szdestname,   
		:szdestaddr1,   
		:szdestaddr2,   
		:szdestaddr3  
	from	destination, 
		shipper  
	where	destination.destination = shipper.destination and
		shipper.id = :ll_shipper;
end if 

// Try multiple sources for customer part
If isnull(szP) or szP = ''  Then
   szP = szHdrCustPart
End If

If isnull(szP) or szP = ''  Then
   szP = szDtlCustPart
End If

If isnull(szP) or szP = ''  Then
	select	customer_part 
	into	:szp
	from	shipper_detail
	where	part = :szpart and shipper = :ll_shipper;
End If

if	isnull(szP) or szP = ''  then
	select
		min(od.customer_part)
	into
		:szp
	from
		dbo.object o
		join dbo.order_detail od
			on od.part_number = o.part
	where
		o.serial = :lSerial  ;
end if

If isnull(szP) or szP = ''  Then
	select	cross_ref
	into	:szp  
	from	part  
	where	part = :szpart;
End If  

// Quick fix for case
szP = upper(szP)

If Stparm.value11 = "" Then
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

szName1 = Mid ( szTemp, 1, 25 )
szName2 = Mid ( szTemp, 26, 25 )
szName3 = Mid ( szTemp, 52, 25 )

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )
PrintSend ( ll_Label, cEsc + "AR" )
SetPointer(HourGlass!)

//  Part Info
PrintSend ( ll_Label, cEsc + "V065" + cEsc + "H270" + cEsc + "M" + "PART NO." )
PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H270" + cEsc + "M" + "(P)" )
if len(szP) < 15 then
   PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H400" + cEsc + "$B,100,160,0"  + cEsc + "$=" + szP )
   PrintSend ( ll_Label, cEsc + "V166" + cEsc + "H305" + cEsc + "B103101" + "*" + "P" + szP + "*"  )
else
   PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H400" + cEsc + "$B,60,160,0"  + cEsc + "$=" + szP )
   PrintSend ( ll_Label, cEsc + "V172" + cEsc + "H305" + cEsc + "B102095" + "*" + "P" + szP + "*"  )
end if

//  Line Feed Code Info
//PrintSend ( ll_Label, cEsc + "V065" + cEsc + "H1100" + cEsc + "L0101" + cEsc + "M" + "LINE FEED " )
//PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H1100" + cEsc + "L0204" + cEsc + "WL1" + szLine )

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V280" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V305" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V249" + cEsc + "H400" + cEsc + "$A,100,160,0" + cEsc + "$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V385" + cEsc + "H305" + cEsc + "B103101" + "*" +"Q" + String(dQuantity) + "*" )
If szUnit <> "PC" and szUnit <> "EA" and szUnit <> "UN" Then
	PrintSend ( ll_Label, cEsc + "V335" + cEsc + "H720" + cEsc + "L0101" + cEsc + "WL1" + szUnit )
End If

//  Customer PO
PrintSend ( ll_Label, cEsc + "V495" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "PO#" )
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "(K)" )
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H890" + cEsc + "L0101" + cEsc + "WL1" + s_PoNumber )
//PrintSend ( ll_Label, cEsc + "V385" + cEsc + "H850" + cEsc + "B103101" + "*" + "K" + s_PoNumber + "*" )

//  Supplier Info
PrintSend ( ll_Label, cEsc + "V495" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(V)" )
PrintSend ( ll_Label, cEsc + "V495" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + szSupplier )
if len(szSupplier) < 7 then
   PrintSend ( ll_Label, cEsc + "V543" + cEsc + "H305" + cEsc + "B103101" + "*" + "V" + szSupplier + "*"  )
else
   PrintSend ( ll_Label, cEsc + "V543" + cEsc + "H305" + cEsc + "B102101" + "*" + "V" + szSupplier + "*"  )
end if

//  Serial Number Info
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "SERIAL " )
//PrintSend ( ll_Label, cEsc + "V680" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(S)" )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + String(lSerial))
PrintSend ( ll_Label, cEsc + "V703" + cEsc + "H305" + cEsc + "B103101" + "*" + "S" + String(lSerial) + "*")

//  Manufacturing Date 
PrintSend ( ll_Label, cEsc + "V668" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + "MFG. DATE" )
PrintSend ( ll_Label, cEsc + "V660" + cEsc + "H1020" + cEsc + "L0101" + cEsc + "WB1" + String(dDate) )

//  Description
PrintSend ( ll_Label, cEsc + "V582" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "DESCRIPTION:" )
PrintSend ( ll_Label, cEsc + "V617" + cEsc + "H805" + cEsc + "L0101" + cEsc + "WB1" + szName1 )

////  Internal Part Info
//PrintSend ( ll_Label, cEsc + "V748" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "INT PART NO" )
//PrintSend ( ll_Label, cEsc + "V740" + cEsc + "H980" + cEsc + "L0101" + cEsc + "WB1" + szPart )

//  Operator Code
PrintSend ( ll_Label, cEsc + "V708" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + "TEAM MEMBER/SHIFT" )
PrintSend ( ll_Label, cEsc + "V700" + cEsc + "H1160" + cEsc + "L0101" + cEsc + "WB1" + szOperator )

//  Engineering Change
PrintSend ( ll_Label, cEsc + "V748" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + "ENG. LEVEL" )
PrintSend ( ll_Label, cEsc + "V740" + cEsc + "H1020" + cEsc + "L0101" + cEsc + "WB1" + szEng )

//  Lot
PrintSend ( ll_Label, cEsc + "V788" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + "LOT #" )
PrintSend ( ll_Label, cEsc + "V780" + cEsc + "H980" + cEsc + "L0101" + cEsc + "WB1" + szLot )

//  Company Info
PrintSend ( ll_Label, cEsc + "V810" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + szCompany + "   " + szAddress2 )

// Customer
//PrintSend ( ll_Label, cEsc + "V788" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "CUSTOMER")
//PrintSend ( ll_Label, cEsc + "V780" + cEsc + "H980" + cEsc + "L0101" + cEsc + "WB1" + szCustomerName)
PrintSend ( ll_Label, cEsc + "V290" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "CUSTOMER:")
PrintSend ( ll_Label, cEsc + "V290" + cEsc + "H980" + cEsc + "L0101" + cEsc + "M" + szDestName)
PrintSend ( ll_Label, cEsc + "V330" + cEsc + "H805" + cEsc + "L0101" + cEsc + "M" + "DELIVER TO:")
PrintSend ( ll_Label, cEsc + "V330" + cEsc + "H980" + cEsc + "L0101" + cEsc + "M" + szDestAddr1)
PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H980" + cEsc + "L0101" + cEsc + "M" + szDestAddr2)
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H980" + cEsc + "L0101" + cEsc + "M" + szDestAddr3)


//  Additional Code for Future Modifications
//PrintSend ( ll_Label, cEsc + "V260" + cEsc + "H1150" + cEsc + "M" + "CHANGE" )
//PrintSend ( ll_Label, cEsc + "V280" + cEsc + "H1150" + cEsc + "M" + "LETTER" )
//PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H900" + cEsc + "$A,50,50,0" + cEsc + "$=" + szTemp )
//PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H900" + cEsc + "$A,40,40,0" + cEsc + "$=" + "E&E : " + szPart)
//PrintSend ( ll_Label, cEsc + "V479" + cEsc + "H1070" + cEsc + "M" + "MATERIAL LOT : " )
//PrintSend ( ll_Label, cEsc + "V510" + cEsc + "H1070" + cEsc + "WB1" + szLot )
//PrintSend ( ll_Label, cEsc + "V555" + cEsc + "H1070" + cEsc + "M" + "FINAL LOT : " )
//PrintSend ( ll_Label, cEsc + "V585" + cEsc + "H1070" + cEsc + "WB1" + szFinal )
//PrintSend ( ll_Label, cEsc + "V340" + cEsc + "H900" + cEsc + "$A,95,95,0" + cEsc + "$=" + "LOC: " + szLine )
//PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H1135" + cEsc + "WB1" + cEsc + szENG )

//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V632" + cEsc + "H273" + cEsc + "FW02H0375" )
PrintSend ( ll_Label, cEsc + "V577" + cEsc + "H648" + cEsc + "FW02H0147" )
//PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H565" + cEsc + "FW02V0380" ) 
//PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H735" + cEsc + "FW02V0380" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H273" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H490" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H648" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H578" + cEsc + "FW02V594" )

//PrintSend ( ll_Label, cEsc + "Q2" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_21cent_cust.create
end on

on w_21cent_cust.destroy
end on

