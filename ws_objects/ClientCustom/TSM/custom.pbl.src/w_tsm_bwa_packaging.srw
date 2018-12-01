$PBExportHeader$w_tsm_bwa_packaging.srw
forward
global type w_tsm_bwa_packaging from Window
end type
end forward

global type w_tsm_bwa_packaging from Window
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
global w_tsm_bwa_packaging w_tsm_bwa_packaging

type variables
st_generic_structure stparm
end variables

event open;//	Argument Assignment
Stparm = Message.PowerObjectParm

//	Declaration
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
String szDestAddr1, szDestAddr2, szDestAddr3, sDockCode
String szOrigin
String szHdrDest
string szPartDesc
Long   lSerial
Long   ll_shipper
Long   ll_suffix
Dec {0} dQuantity
Dec dWeight, dgWeight, dtotBoxes
Time tTime
Date dDate
datetime dt_date, dt_time
datetime ldt_effective_date
string	ls_ecl

//  Initialization
lSerial     = Long(Stparm.Value1)
//szP         = Stparm.Value2
//szSupplier  = Stparm.value3

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
If ( isnull(ll_shipper) or ll_shipper = 0 ) and isNumber(szOrigin) Then ll_shipper = long(szOrigin)

/* Correct 0 in suffix column */
If ll_suffix = 0 Then ll_suffix = -1

select	gross_weight, staged_objs, shipping_dock
into	:dgWeight, :dtotBoxes, :sDockCode
from	shipper
where	id = :ll_shipper;

dDate = date(dt_date)
ttime = time(dt_time)

SELECT	name  
INTO	:szTemp 
FROM	part  
WHERE	part.part = :szPart;

SELECT	parameters.company_name, address_1, address_2, address_3
INTO	:szCompany, :szAddress1, :szAddress2, :szAddress3 
FROM	parameters ;

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
	order_header.customer, order_header.destination, order_header.engineering_level
INTO	:s_PoNumber, :szHdrCustPart, :szCustomerName, 
	:szCustomer, :szHdrDest, :szEng
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

//	Try multiple sources for customer part
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

szDestination = Left(szDestination,30)
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

//	Receiver Info.
//PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H210" + cEsc + "L0101" + cEsc + "S" + "RECEIVER:" )
//PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H320" + cEsc + "L0101" + cEsc + "M" + szDestName )
//PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr1 )
//PrintSend ( ll_Label, cEsc + "V070" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr2 )
//PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr3 )
//

PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H210" + cEsc + "L0101" + cEsc + "S" + "RECEIVER:" )
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H320" + cEsc + "L0101" + cEsc + "M" + szDestName )
PrintSend ( ll_Label, cEsc + "V080" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr1 )
PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr2 )
PrintSend ( ll_Label, cEsc + "V120" + cEsc + "H280" + cEsc + "L0101" + cEsc + "M" + szDestAddr3 )


//	Doc/Gate Info.
//PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DOCK/GATE:" )
//PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H1000" + cEsc + "L0101" + cEsc + "M" + sDockCode )

PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DOCK/GATE:" )
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H1000" + cEsc + "L0101" + cEsc + "M" + sDockCode )


//	Supplier Info.
//PrintSend ( ll_Label, cEsc + "V080" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "SUPPLIER ADDRESS:" )
//PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szCompany )
//PrintSend ( ll_Label, cEsc + "V120" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress1 )
//PrintSend ( ll_Label, cEsc + "V140" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress2 )
//PrintSend ( ll_Label, cEsc + "V160" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress3 )
//
PrintSend ( ll_Label, cEsc + "V110" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "SUPPLIER ADDRESS:" )
PrintSend ( ll_Label, cEsc + "V130" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szCompany )
PrintSend ( ll_Label, cEsc + "V150" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress1 )
PrintSend ( ll_Label, cEsc + "V170" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress2 )
PrintSend ( ll_Label, cEsc + "V190" + cEsc + "H860" + cEsc + "L0101" + cEsc + "M" + szAddress3 )

//	Document # Info.
//PrintSend ( ll_Label, cEsc + "V115" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "DOCUMENT # (K):" )
//PrintSend ( ll_Label, cEsc + "V140" + cEsc + "H230" + cEsc + "B102095" + "*" + "K" + s_PoNumber + "*" )
//
PrintSend ( ll_Label, cEsc + "V145" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "DOCUMENT # (K):" )
PrintSend ( ll_Label, cEsc + "V170" + cEsc + "H230" + cEsc + "B102095" + "*" + "K" + s_PoNumber + "*" )


//	Weight Info.
//PrintSend ( ll_Label, cEsc + "V185" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "NET WT. (LBS)")
//PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H880" + cEsc + "L0101" + cEsc + "M" + string(round(dWeight,2)))
//PrintSend ( ll_Label, cEsc + "V185" + cEsc + "H1050" + cEsc + "L0101" + cEsc + "S" + "GROSS WT (LBS)")
//PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H1080" + cEsc + "L0101" + cEsc + "M" + string(round(dgWeight,2)))
//PrintSend ( ll_Label, cEsc + "V185" + cEsc + "H1250" + cEsc + "L0101" + cEsc + "S" + "# OF BOXES:")
//PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H1280" + cEsc + "L0101" + cEsc + "M" + string(round(dtotBoxes,0)))
//
PrintSend ( ll_Label, cEsc + "V215" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "NET WT. (LBS)")
PrintSend ( ll_Label, cEsc + "V240" + cEsc + "H880" + cEsc + "L0101" + cEsc + "M" + string(round(dWeight,2)))
PrintSend ( ll_Label, cEsc + "V215" + cEsc + "H1050" + cEsc + "L0101" + cEsc + "S" + "GROSS WT (LBS)")
PrintSend ( ll_Label, cEsc + "V240" + cEsc + "H1080" + cEsc + "L0101" + cEsc + "M" + string(round(dgWeight,2)))
PrintSend ( ll_Label, cEsc + "V215" + cEsc + "H1250" + cEsc + "L0101" + cEsc + "S" + "# OF BOXES:")
PrintSend ( ll_Label, cEsc + "V240" + cEsc + "H1280" + cEsc + "L0101" + cEsc + "M" + string(round(dtotBoxes,0)))

//	Part Info.
//PrintSend ( ll_Label, cEsc + "V245" + cEsc + "H210" + cEsc + "M" + "PART NUMBER (P):" )
//PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H230" + cEsc + "B102095" + "*" + "P" + szP + "*"  )
//PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H720" + cEsc + "L0101"  + cEsc + "WB1" + szP )

PrintSend ( ll_Label, cEsc + "V275" + cEsc + "H210" + cEsc + "M" + "PART NUMBER (P):" )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H230" + cEsc + "B102095" + "*" + "P" + szP + "*"  )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H720" + cEsc + "L0101"  + cEsc + "WB1" + szP )

//	Revision Level Info.
//PrintSend ( ll_Label, cEsc + "V245" + cEsc + "H1050" + cEsc + "L0101" + cEsc + "M" + "Revision Level" )
PrintSend ( ll_Label, cEsc + "V275" + cEsc + "H1050" + cEsc + "L0101" + cEsc + "M" + "Revision Level" )

//	Quantity Info.
//PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "QUANTITY (Q):" )
//PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H230" + cEsc + "B102095" + "*" +"Q" + String(dQuantity) + "*" )
//PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H500" + cEsc + "L0101" + cEsc + "WL1" + String(dQuantity))
//
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "QUANTITY (Q):" )
PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H230" + cEsc + "B102095" + "*" +"Q" + String(dQuantity) + "*" )
PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H500" + cEsc + "L0101" + cEsc + "WL1" + String(dQuantity))

//	Part Description Info.
//PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DESCRIPTION:" )
//PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName1 )
//PrintSend ( ll_Label, cEsc + "V420" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName2 )
//PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName2 )
//
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DESCRIPTION:" )
PrintSend ( ll_Label, cEsc + "V430" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName1 )
PrintSend ( ll_Label, cEsc + "V450" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName2 )
PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H855" + cEsc + "L0101" + cEsc + "M" + szName2 )

//	Packing Slip Info.
//PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H850" + cEsc + "L0101" + cEsc + "M" + "PACKING SLIP # (B):" )
//PrintSend ( ll_Label, cEsc + "V500" + cEsc + "H890" + cEsc + "B102095" + "*" +"B" + String(ll_Shipper) + "*" )

PrintSend ( ll_Label, cEsc + "V500" + cEsc + "H850" + cEsc + "L0101" + cEsc + "M" + "PACKING SLIP # (B):" )
PrintSend ( ll_Label, cEsc + "V530" + cEsc + "H890" + cEsc + "B102095" + "*" +"B" + String(ll_Shipper) + "*" )

//	Supplier Info.
//PrintSend ( ll_Label, cEsc + "V545" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "SUPPLIER (V):" )
//PrintSend ( ll_Label, cEsc + "V570" + cEsc + "H230" + cEsc + "B102095" + "*" + "V" + szSupplier + "*" )
//PrintSend ( ll_Label, cEsc + "V570" + cEsc + "H630" + cEsc + "L0101" + cEsc + "WB1" + szSupplier )
//
PrintSend ( ll_Label, cEsc + "V555" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "SUPPLIER (V):" )
PrintSend ( ll_Label, cEsc + "V580" + cEsc + "H230" + cEsc + "B102095" + "*" + "V" + szSupplier + "*" )
PrintSend ( ll_Label, cEsc + "V580" + cEsc + "H630" + cEsc + "L0101" + cEsc + "WB1" + szSupplier )


//	Serial Number Info.
PrintSend ( ll_Label, cEsc + "V690" + cEsc + "H210" + cEsc + "L0101" + cEsc + "M" + "SERIAL (S):" )
PrintSend ( ll_Label, cEsc + "V720" + cEsc + "H230" + cEsc + "B102095" + "*" + "S" + String(lSerial) + "*")
PrintSend ( ll_Label, cEsc + "V720" + cEsc + "H550" + cEsc + "L0101" + cEsc + "WL1" + String(lSerial))

//	Manufacturing Date Info.
//PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DATE:" )
//PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H920" + cEsc + "L0101" + cEsc + "M" + String(dDate) )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H850" + cEsc + "L0101" + cEsc + "S" + "DATE:" )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H920" + cEsc + "L0101" + cEsc + "M" + String(dDate) )

//	Engineering Change Info.
//PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H1100" + cEsc + "L0101" + cEsc + "S" + "ENGINEERING LEVEL:" )
//PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H1290" + cEsc + "L0101" + cEsc + "M" + Left(szEng,7) )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H1100" + cEsc + "L0101" + cEsc + "S" + "ENGINEERING LEVEL:" )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H1290" + cEsc + "L0101" + cEsc + "M" + Left(szEng,7) )

//	Batch no. Info.
PrintSend ( ll_Label, cEsc + "V690" + cEsc + "H850" + cEsc + "L0101" + cEsc + "M" + "BATCH NO. (H):" )
PrintSend ( ll_Label, cEsc + "V720" + cEsc + "H870" + cEsc + "B102095" + "*" + "H" + szSupplier + "*")

////  Draw Lines

PrintSend ( ll_Label, cEsc + "N" )
//PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H020" + cEsc + "FW02H0220" )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H020" + cEsc + "FW02H0250" )
//PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H180" + cEsc + "FW02H0190" )
//PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H180" + cEsc + "FW02H0060" )
PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H210" + cEsc + "FW02H0190" )
PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H210" + cEsc + "FW02H0060" )

//PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H370" + cEsc + "FW02H0500" )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H400" + cEsc + "FW02H0470" )
//PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H615" + cEsc + "FW02H0065" )
PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H645" + cEsc + "FW02H0035" )

//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H075" + cEsc + "FW02V570" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H105" + cEsc + "FW02V570" )
//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H180" + cEsc + "FW02V570" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H210" + cEsc + "FW02V570" )
//PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H110" + cEsc + "FW02V635" )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H140" + cEsc + "FW02V635" )
//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H460" + cEsc + "FW02V570" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H490" + cEsc + "FW02V570" )
//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H615" + cEsc + "FW02V570" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H645" + cEsc + "FW02V570" )
//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H240" + cEsc + "FW02V1200" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H270" + cEsc + "FW02V1200" )
//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H370" + cEsc + "FW02V1200" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H400" + cEsc + "FW02V1200" )
//PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H535" + cEsc + "FW02V620" )
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H545" + cEsc + "FW02V650" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H680" + cEsc + "FW02V1200" )

//PrintSend ( ll_Label, cEsc + "Q2" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event
on w_tsm_bwa_packaging.create
end on

on w_tsm_bwa_packaging.destroy
end on

