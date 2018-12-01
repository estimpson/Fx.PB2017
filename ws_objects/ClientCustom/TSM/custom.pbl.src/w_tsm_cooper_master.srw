$PBExportHeader$w_tsm_cooper_master.srw
forward
global type w_tsm_cooper_master from Window
end type
end forward

global type w_tsm_cooper_master from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_tsm_cooper_master w_tsm_cooper_master

type variables
st_generic_structure stparm
end variables

event open;//  Wyandotte Standard Customer Label

// 01/16/02 JAC - CSR 145216
// 01/16/02 JAC - CSR 178890
// 07/28/05 JAC - CSR 179677

/////////////////////////////////////////////////
//  Declaration
//
Stparm = Message.PowerObjectParm

Long ll_Label		  // 32-bit Open Handle

String cEsc         // Escape Code
String szLoc        // Location
String szLot        // Material Lot
String szUnit       // Unit Of Measure
String szOperator   // Operator
String szPart, szP, szHdrCustPart
String szCrossRef
String szDescription
String szdestination
String szSupplier
String szCompany, szEng, szLine, szFinal
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szNumberofLabels
String s_PoNumber
String szCustomerName
String szCustomer
String szDestName
String szDestAddr1, szDestAddr2, szDestAddr3
String szOrigin
String szHdrDest
string szPartDesc
string szSerial=''

Long   lSerial
Long   ll_shipper
Long   ll_suffix

Dec {0} dQuantity
Dec dWeight

Time tTime

Date dDate

datetime dt_date, dt_time
datetime ldt_effective_date

/////////////////////////////////////////////////
//  Initialization
//

lSerial     = Long(Stparm.Value1)

SELECT	object.part,   
	object.lot,   
	object.location,   
	object.last_date,   
	object.unit_measure,   
	object.operator,   
	object.quantity,   
	object.last_time,
	object.destination,
	object.suffix,
	object.shipper,
	object.origin,
	object.weight
INTO	:szPart,   
	:szLot,   
	:szLoc,   
	:dt_date,   
	:szUnit,   
	:szOperator,   
	:dQuantity,   
	:dt_time, 
	:szdestination,
	:ll_suffix,
	:ll_shipper,
	:szOrigin,
	:dWeight
FROM	object  
WHERE	object.serial = :lSerial;

/* Use Origin for shipper if needed--from packline without autostage */
If ( isnull(ll_shipper) or ll_shipper = 0 ) and isNumber(szOrigin) Then
	ll_shipper = long(szOrigin)
End If

/* Correct 0 in suffix column */
If ll_suffix = 0 Then
	ll_suffix = -1
End If

select	min(part_original)
into	:szPart
from	shipper_detail 
where	shipper = :ll_shipper;


select	sum(quantity)
into	:dquantity
from	object
where	parent_serial = :lSerial;

dDate = date(dt_date)
ttime = time(dt_time)

SELECT	name  
INTO	:szTemp 
FROM	part  
WHERE	part.part = :szPart;

SELECT	parameters.company_name, address_1, address_2, address_3
INTO	:szCompany, :szAddress1, :szAddress2, :szAddress3 
FROM	parameters ;

SELECT	PART_CHARACTERISTICS.USER_DEFINED_1
INTO	:szPartDesc
FROM	PART_CHARACTERISTICS
WHERE	PART_CHARACTERISTICS.PART = :szPart;


//SELECT	effective_change_notice.engineering_level  
//INTO	:szEng  
//FROM	effective_change_notice  
//WHERE	effective_change_notice.effective_date <= :dDate
//	and effective_change_notice.part = :szPart
//ORDER BY effective_change_notice.effective_date DESC;	

select	max(effective_date)
into	:ldt_effective_date
from	effective_change_notice 
where	part = :szpart;

select	engineering_level
into	:szEng
from	effective_change_notice 
where	effective_date = :ldt_effective_date
	and part = :szpart;

SELECT	order_header.customer_po,order_header.customer_part,customer.name,
	order_header.customer, order_header.destination
INTO	:s_PoNumber, :szHdrCustPart, :szCustomerName, 
	:szCustomer, :szHdrDest
FROM	order_header,shipper_detail,customer
WHERE	order_header.order_no = shipper_detail.order_no and
	order_header.customer = customer.customer and
	shipper_detail.shipper = :ll_shipper and
	shipper_detail.part_original = :szPart;

If isnull(szdestination) or szdestination = ''  Then
	szdestination = szHdrDest
End If

SELECT	supplier_code  
INTO	:szSupplier  
FROM	edi_setups  
WHERE	destination = :szDestination;

SELECT	destination.name,
	destination.address_1,   
	destination.address_2,   
	destination.address_3  
INTO	:szDestName,   
	:szDestAddr1,   
	:szDestAddr2,   
	:szDestAddr3  
FROM	destination  
WHERE	destination.destination = :szDestination;

// Try multiple sources for customer part

szP = szHdrCustPart

If isnull(szP) or szP = ''  Then
	SELECT	customer_part 
	INTO	:szP
	FROM	shipper_detail
	WHERE	part_original = :szPart and shipper = :ll_shipper and
		IsNull ( suffix, -1 ) = IsNull ( :ll_Suffix, -1 );
End If

If isnull(szP) or szP = ''  Then
	SELECT	cross_ref
	INTO	:szP  
	FROM	part  
	WHERE	part = :szPart;
End If  

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

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )
PrintSend ( ll_Label, cEsc + "AR" )
SetPointer(HourGlass!)

//  Part Info
PrintSend ( ll_Label, cEsc + "V056" + cEsc + "H270" + cEsc + "M" + "PART NO." )
PrintSend ( ll_Label, cEsc + "V080" + cEsc + "H270" + cEsc + "M" + "(P)" )
if len(szP) < 15 then
   PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H400" + cEsc + "$B,55,120,0"  + cEsc + "$=" + szP )
   PrintSend ( ll_Label, cEsc + "V136" + cEsc + "H305" + cEsc + "B103100" + "*" + "P" + szP + "*"  )
else
   PrintSend ( ll_Label, cEsc + "V005" + cEsc + "H400" + cEsc + "$B,55,120,0"  + cEsc + "$=" + szP )
   PrintSend ( ll_Label, cEsc + "V136" + cEsc + "H305" + cEsc + "B102095" + "*" + "P" + szP + "*"  )
end if

PrintSend ( ll_Label, cEsc + "V136" + cEsc + "H1050" + cEsc + "L0101" + cEsc + "WL1" + 'MASTER LABEL')

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V275" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + String(dQuantity))
PrintSend ( ll_Label, cEsc + "V305" + cEsc + "H305" + cEsc + "B103100" + "*" +"Q" + String(dQuantity) + "*" )

//  Customer PO
PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H820" + cEsc + "L0101" + cEsc + "M" + "PURCHASE ORDER NO." )
PrintSend ( ll_Label, cEsc + "V275" + cEsc + "H820" + cEsc + "L0101" + cEsc + "M" + "(K)" )
if len(s_PoNumber) < 9 then
	PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H850" + cEsc + "B103095" + "*" + "K" + s_PoNumber + "*" )
else
	PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H850" + cEsc + "B102095" + "*" + "K" + s_PoNumber + "*" )
end if
PrintSend ( ll_Label, cEsc + "V412" + cEsc + "H850" + cEsc + "L0101" + cEsc + "WL1" + s_PoNumber )

//  Supplier Info
PrintSend ( ll_Label, cEsc + "V465" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, cEsc + "V490" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(V)" )
PrintSend ( ll_Label, cEsc + "V465" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + szSupplier )
if len(szSupplier) < 9 then
   PrintSend ( ll_Label, cEsc + "V512" + cEsc + "H305" + cEsc + "B103095" + "*" + "V" + szSupplier + "*"  )
else
   PrintSend ( ll_Label, cEsc + "V512" + cEsc + "H305" + cEsc + "B102095" + "*" + "V" + szSupplier + "*"  )
end if

szSerial = right(('000000000' + string(lSerial)), 9)

//  Serial Number Info
PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "SERIAL " )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H270" + cEsc + "L0101" + cEsc + "M" + "(M)" )
//PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + String(lSerial))
//PrintSend ( ll_Label, cEsc + "V673" + cEsc + "H305" + cEsc + "B103100" + "*" + "M" + String(lSerial) + "*")
PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + szSerial)
PrintSend ( ll_Label, cEsc + "V673" + cEsc + "H305" + cEsc + "B103100" + "*" + "M" + szSerial + "*")

//  Manufacturing Date 
PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H930" + cEsc + "L0101" + cEsc + "M" + "MFG. DATE" )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H975" + cEsc + "L0101" + cEsc + "WB1" + String(dDate) )

//  Engineering Change
PrintSend ( ll_Label, cEsc + "V710" + cEsc + "H930" + cEsc + "L0101" + cEsc + "M" + "ENG. LEVEL" )
PrintSend ( ll_Label, cEsc + "V735" + cEsc + "H975" + cEsc + "L0101" + cEsc + "WB1" + szEng )
PrintSend ( ll_Label, cEsc + "V790" + cEsc + "H1175" + cEsc + "L0101" + cEsc + "S" + 'COOPERMT' )

//  Company Info
PrintSend ( ll_Label, cEsc + "V790" + cEsc + "H270" + cEsc + "L0101" + cEsc + "S" + szCompany + "   " + szAddress3 )

//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V632" + cEsc + "H243" + cEsc + "FW02H0217" )
PrintSend ( ll_Label, cEsc + "V503" + cEsc + "H460" + cEsc + "FW02H0350" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H243" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H460" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H618" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V038" + cEsc + "H700" + cEsc + "FW02V460" )

//PrintSend ( ll_Label, cEsc + "Q2" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event
on w_tsm_cooper_master.create
end on

on w_tsm_cooper_master.destroy
end on

