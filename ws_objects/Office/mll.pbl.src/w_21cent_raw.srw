$PBExportHeader$w_21cent_raw.srw
forward
global type w_21cent_raw from window
end type
end forward

global type w_21cent_raw from window
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
global w_21cent_raw w_21cent_raw

type variables
st_generic_structure stparm
end variables

event open;//  Standard label for raw

/////////////////////////////////////////////////
//  Declaration
//

Stparm = Message.PowerObjectParm

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle

String cEsc         // Escape Code
String szLoc        // Location
String szLot        // Material Lot
String szUnit       // Unit Of Measure
String szOperator   // Operator
String szPart
String szPartType
String szDescription
String szdestination
String szSupplier
String szCompany
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szNumberofLabels
String szVendorName
String szUserDef


Long   lSerial
Long   lPONum

String szTime,szTimes
Dec {0} dQuantity

Time tTime

Date dDate

Datetime dt_date_time

/////////////////////////////////////////////////
//  Initialization
//

//lSerial = Message.DoubleParm
lSerial = Long(Stparm.Value1)

select
	at.part
,	at.lot
,	at.to_loc
,	at.date_stamp
,	at.unit
,	at.operator
,	coalesce(o.quantity, at.quantity)
,	at.po_number
into
	:szPart
,   :szLot
,	:szLoc
,	:dt_Date_time
,	:szUnit
,	:szOperator
,	:dQuantity
,	:lPONum
from
    dbo.audit_trail at
    left join dbo.object o
        on o.serial = at.serial
where
    at.serial = :lSerial
    and at.date_stamp =
		(	select
				min(at2.date_stamp)
			from
				audit_trail at2
			where
				at2.serial = at.serial
		)  ;

Ddate = date(dt_date_time)
ttime = time(dt_date_time)

szTime = String(tTime)
szTimes = Mid(szTime, 1, 5)


  SELECT part.name, description_short, part.type  
    INTO :szTemp, 
			:szDescription,
			:szPartType
    FROM part  
   WHERE part.part = :szPart   ;

  SELECT vendor.name  
    INTO :szVendorName
    FROM vendor, po_header  
   WHERE vendor.code = po_header.vendor_code and
   		po_header.po_number = :lPONum ;


	string loc
	string locationList[]
	execute immediate "if @@trancount = 0 then begin transaction getLocationes end save transaction getLocations" using SQLCA;

	declare Locations cursor for
		select
			LocationCode
		from
			PartPutAwayLocations
		where
			PartCode = :szPart
		order by LocationCode using SQLCA ;

	open Locations;

	do while sqlca.sqlcode = 0
		fetch
			Locations
		into
			:loc ;

		locationList[UpperBound(locationList) + 1] = loc 
	loop

	close Locations ;
	execute immediate "rollback transaction getLocations" using SQLCA;
	
	
	SELECT user_defined_1
	  INTO :szUserDef
	  FROM part_characteristics
	WHERE part = :szPart  ;

	

//  SELECT edi_setups.supplier_code  
//    INTO :szSupplier  
//    FROM edi_setups  
//   WHERE edi_setups.destination = :szdestination   ;

SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;
	

If Stparm.value11 = "" Then
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

szName1 = Mid ( szTemp, 1, 20 )
szName2 = Mid ( szTemp, 21, 20 )
szName3 = Mid ( szTemp, 41, 20 )

cEsc = "~h1B"
/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V083" + cEsc + "H296" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H300" + cEsc + "$B,60,100,0" + cEsc + "$=" + szPart )

PrintSend ( ll_Label, cEsc + "V199" + cEsc + "H296" + cEsc + "M" + "LOT #" )
PrintSend ( ll_Label, cEsc + "V255" + cEsc + "H296" + cEsc + "WB1" + szLot )

PrintSend ( ll_Label, cEsc + "V199" + cEsc + "H746" + cEsc + "M" + "VENDOR" )
PrintSend ( ll_Label, cEsc + "V255" + cEsc + "H746" + cEsc + "WB1" + mid(szVendorName,1,20) )

PrintSend ( ll_Label, cEsc + "V299" + cEsc + "H296" + cEsc + "M" + "DESCRIPTION" )
PrintSend ( ll_Label, cEsc + "V325" + cEsc + "H296" + cEsc + "WB1" + MID(szTemp,1,35) )

PrintSend ( ll_Label, cEsc + "V299" + cEsc + "H1026" + cEsc + "M" + "DATE RCVD:" )
PrintSend ( ll_Label, cEsc + "V349" + cEsc + "H1076" + cEsc + "WB1" + string(dDate,"MM/DD/YY" ) )

// boxes
PrintSend ( ll_Label, cEsc + "V213" + cEsc + "H1226" + cEsc + "FW0202V030H030" )
PrintSend ( ll_Label, cEsc + "V245" + cEsc + "H1226" + cEsc + "FW0202V030H030" )
PrintSend ( ll_Label, cEsc + "V223" + cEsc + "H1270" + cEsc + "M" + "VIRGIN" )
PrintSend ( ll_Label, cEsc + "V255" + cEsc + "H1270" + cEsc + "M" + "REGRIND" )

PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H1096" + cEsc + "WL1" + "21" + cEsc + "M" + "st"+ cEsc + "WL1"+" CPC" )
PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H1116" + cEsc + "$A,150,125,0" + cEsc + "$=" + "OK")
PrintSend ( ll_Label, cEsc + "V560" + cEsc + "H1066" + cEsc + "WL1" + "INCOMING" )
PrintSend ( ll_Label, cEsc + "V620" + cEsc + "H1036" + cEsc + "WL1" + "INSPECTION" )
PrintSend ( ll_Label, cEsc + "V713" + cEsc + "H1040" + cEsc + "M" + "DATE: " )
PrintSend ( ll_Label, cEsc + "V783" + cEsc + "H1040" + cEsc + "M" + "INSP: " )

PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H296" + cEsc + "M" + "QUANTITY" )
If dQuantity > 0 then
	PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H296" + cEsc + "$A,150,125,0" + cEsc + "$=" + String(dQuantity) )
Else
	PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H296" + cEsc + "$A,150,125,0" + cEsc + "$=" + String(dQuantity) )
	PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H596" + cEsc + "WL1" + "REVERSED")
	PrintSend ( ll_Label, cEsc + "V402" + cEsc + "H586" + cEsc + "(260,60" )
End If
PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H905" + cEsc + "WL1" + szUnit )

PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H296" + cEsc + "M" + "SERIAL #" )
If szPartType <> "N" Then
	PrintSend ( ll_Label, cEsc + "V566" + cEsc + "H300" + cEsc + "$A,110,100,0" + cEsc + "$=" + String(lserial) )
Else
	PrintSend ( ll_Label, cEsc + "V566" + cEsc + "H300" + cEsc + "$A,110,100,0" + cEsc + "$=" + String(lserial) )
	PrintSend ( ll_Label, cEsc + "V566" + cEsc + "H750" + cEsc + "WL1" + "NON-INV")
	PrintSend ( ll_Label, cEsc + "V560" + cEsc + "H740" + cEsc + "(225,60" )
End If
PrintSend ( ll_Label, cEsc + "V718" + cEsc + "H296" + cEsc + "B103095" + "*" + "S" + String ( lSerial ) + "*" )
//
//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H191" + cEsc + "FW02V1112" )
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H391" + cEsc + "FW02V1112" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H522" + cEsc + "FW02H0339" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H291" + cEsc + "FW02H0233" )
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H291" + cEsc + "FW02V1112" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H520" + cEsc + "FW02V725" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H455" + cEsc + "FW02V125" )
// PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H425" + cEsc + "FW02V125" )
PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H391" + cEsc + "FW02H66" )
PrintSend ( ll_Label, cEsc + "V685" + cEsc + "H191" + cEsc + "FW02H100" )
PrintSend ( ll_Label, cEsc + "V241" + cEsc + "H191" + cEsc + "FW02H100" )

PrintSend ( ll_Label, cEsc + "V90" + cEsc + "H733" + cEsc + "FW02V217" )
PrintSend ( ll_Label, cEsc + "V90" + cEsc + "H803" + cEsc + "FW02V217" )
// PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H425" + cEsc + "FW02H95" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )

PrintSend ( ll_Label, cEsc + "Z" )

//	Print locations
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

PrintSend ( ll_Label, cEsc + "V083" + cEsc + "H296" + cEsc + "M" + "LOCATIONS" )
int i
int iVShift = 120
string sVShift
for i = 1 to UpperBound(locationList) - 1
	if i < 20 then
		sVShift = "V" + string(iVShift)
		PrintSend ( ll_Label, cEsc + sVShift + cEsc + "H296" + cEsc + "WB1" + string(locationList[i]) )
		iVShift = iVShift + 35
	else
		PrintSend ( ll_Label, cEsc + "V783" + cEsc + "H296" + cEsc + "M" + "...see warehouse log book for more." )
		exit
	end if
next


//	Print MSDS
PrintSend ( ll_Label, cEsc + "R" )
//PrintSend ( ll_Label, cEsc + "N" )

PrintSend ( ll_Label, cEsc + "V900" + cEsc + "H035" + cEsc + "(60,55" )
PrintSend ( ll_Label, cEsc + "V905" + cEsc + "H110" + cEsc + "WL1" + "HEALTH")
PrintSend ( ll_Label, cEsc + "V895" + cEsc + "H030" + cEsc + "(700,65" )
PrintSend ( ll_Label, cEsc + "V905" + cEsc + "H045" + cEsc + "WL1" + Mid(szUserDef, 1, 1) )

PrintSend ( ll_Label, cEsc + "V970" + cEsc + "H035" + cEsc + "(60,55" )
PrintSend ( ll_Label, cEsc + "V975" + cEsc + "H110" + cEsc + "WL1" + "FLAMMABILITY")
PrintSend ( ll_Label, cEsc + "V965" + cEsc + "H030" + cEsc + "(70,65" )
PrintSend ( ll_Label, cEsc + "V975" + cEsc + "H045" + cEsc + "WL1" + Mid(szUserDef, 2, 1) )

PrintSend ( ll_Label, cEsc + "V1040" + cEsc + "H035" + cEsc + "(60,55" )
PrintSend ( ll_Label, cEsc + "V1045" + cEsc + "H110" + cEsc + "WL1" + "REACTIVITY")
PrintSend ( ll_Label, cEsc + "V1035" + cEsc + "H030" + cEsc + "(700,65" )
PrintSend ( ll_Label, cEsc + "V1045" + cEsc + "H045" + cEsc + "WL1" + Mid(szUserDef, 3, 1) )

PrintSend ( ll_Label, cEsc + "V1110" + cEsc + "H035" + cEsc + "(60,55" )
PrintSend ( ll_Label, cEsc + "V1115" + cEsc + "H110" + cEsc + "WL1" + "PROTECTIVE EQUIPMENT")
PrintSend ( ll_Label, cEsc + "V1105" + cEsc + "H030" + cEsc + "(70,65" )
PrintSend ( ll_Label, cEsc + "V1115" + cEsc + "H045" + cEsc + "WL1" + Mid(szUserDef, 4, 1) )



PrintSend ( ll_Label, cEsc + "Z" )

PrintClose ( ll_Label )


Close ( this )
end event

on w_21cent_raw.create
end on

on w_21cent_raw.destroy
end on

