$PBExportHeader$w_21cent_fin.srw
forward
global type w_21cent_fin from window
end type
end forward

global type w_21cent_fin from window
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
global w_21cent_fin w_21cent_fin

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

Long   lSerial
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

  SELECT object.part,   
         object.lot,   
         object.location,   
         object.last_date,   
         object.unit_measure,   
         object.operator,   
         object.quantity,   
         object.last_time
			//object.destination
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time 
			//:szdestination 
    FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

szTime = String(tTime)
szTimes = Mid(szTime, 1, 5)

  SELECT part.name, description_short  
    INTO :szTemp, 
			:szDescription 
    FROM part  
   WHERE part.part = :szPart   ;

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
PrintSend ( ll_Label, cEsc + "AR" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V083" + cEsc + "H296" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H300" + cEsc + "$B,60,100,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V200" + cEsc + "H300" + cEsc + "WL1" + szTemp )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H296" + cEsc + "M" + "LOT #" )
PrintSend ( ll_Label, cEsc + "V325" + cEsc + "H296" + cEsc + "WL1" + szLot )
PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H296" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H296" + cEsc + "$A,150,125,0" + cEsc + "$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H905" + cEsc + "WL1" + szUnit )

PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H296" + cEsc + "M" + "SERIAL #" )
PrintSend ( ll_Label, cEsc + "V566" + cEsc + "H300" + cEsc + "$A,110,100,0" + cEsc + "$=" + String(lserial) )
PrintSend ( ll_Label, cEsc + "V718" + cEsc + "H296" + cEsc + "B103095" + "*" + "S" + String ( lSerial ) + "*" )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H1020" + cEsc + "$A,125,100,0" + cEsc + "$=" + "F I N" )
// PrintSend ( ll_Label, cEsc + "V570" + cEsc + "H1020" + cEsc + "WB1" + "LOCAT " + szLoc)
PrintSend ( ll_Label, cEsc + "V480" + cEsc + "H1020" + cEsc + "WL1" + "OPER  ")
PrintSend ( ll_Label, cEsc + "V590" + cEsc + "H1020" + cEsc + "WL1" + "DATE  ")
//PrintSend ( ll_Label, cEsc + "V700" + cEsc + "H1020" + cEsc + "WL1" + "LOT  ") 
//if not isnull(szLot) and szLot>"" then PrintSend ( ll_Label, cEsc + "V700" + cEsc + "H1150" + cEsc + "WL1" + szLot )
//
//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H522" + cEsc + "FW02H0339" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H291" + cEsc + "FW02H0233" )
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H291" + cEsc + "FW02V1112" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H520" + cEsc + "FW02V725" )
PrintSend ( ll_Label, cEsc + "V425" + cEsc + "H425" + cEsc + "FW02V125" )
PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H425" + cEsc + "FW02H95" )
PrintSend ( ll_Label, cEsc + "V90" + cEsc + "H530" + cEsc + "FW02V195" )
PrintSend ( ll_Label, cEsc + "V90" + cEsc + "H640" + cEsc + "FW02V195" )
if isnull(szLot) or szLot="" then PrintSend ( ll_Label, cEsc + "V90" + cEsc + "H750" + cEsc + "FW02V215" )

PrintSend ( ll_Label, cEsc + szNumberofLabels )

PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )


Close ( this )
end event

on w_21cent_fin.create
end on

on w_21cent_fin.destroy
end on

