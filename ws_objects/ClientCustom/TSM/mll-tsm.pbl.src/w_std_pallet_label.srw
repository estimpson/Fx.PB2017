$PBExportHeader$w_std_pallet_label.srw
forward
global type w_std_pallet_label from Window
end type
end forward

global type w_std_pallet_label from Window
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
global w_std_pallet_label w_std_pallet_label

type variables

end variables

event open;/////////////////////////////////////////////////
//  Declaration

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle
int i

String szShipper
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
String s_NumberOfLabels
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szTime,szTimes


Long inSerial
Long   lSerial

Dec {0} dQuantity, nCarton, nWeight, nShipper

Time tTime

Date dDate

Datetime dt_date_time

st_generic_structure Stparm

/////////////////////////////////////////////////
//  Initialization
//

Stparm = Message.PowerObjectParm
lSerial = Long(stparm.Value1)
  SELECT object.part,   
         object.lot,   
         object.location,   
         object.last_date,   
         object.unit_measure,   
         object.operator,   
         object.quantity,   
         object.last_time,
			//object.destination,
			object.shipper
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			//:szdestination,
			:nShipper 
    FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

SELECT shipper.destination  
    INTO :szDestination  
    FROM shipper  
   WHERE shipper.id = :nShipper   ;

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

select
	sum(weight)
,	min(serial)
into
	:nWeight
,	:inSerial
from
	object
where
	parent_serial = :lSerial  ;

If Isnull(nShipper) or nShipper < 0 then
  SELECT object.origin  
    INTO :szShipper  
    FROM object  
   WHERE object.serial = :inSerial   ;
nShipper = Long (szShipper)
SELECT shipper.destination  
    INTO :szDestination  
    FROM shipper  
   WHERE shipper.id = :nShipper   ;
End If

If Stparm.value11 = "" Then
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + Stparm.value11
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
PrintSend ( ll_Label, cEsc + "A" + cEsc + "%1" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H100" + cEsc + "L0202" + cEsc + "WL1" + "PALLET #  " )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H250" + cEsc + "L0303" + cEsc + "WL1" + String(lSerial) )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H400" + cEsc + "B104130" + "*" + "S" + String(lSerial) + "*" )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H600" + cEsc + "L0101" + cEsc + "M" + "LOCATION :" )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H650" + cEsc + "L0101" + cEsc + "WB1" + szloc )

//PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + "TOTAL BOXES" )
//PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H400" + cEsc + "L0202" + cEsc + "WL1" + String(nCarton) )
//PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H500" + cEsc + "L0101" + cEsc + "WL1" + "NET WEIGHT "  )
//PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H500" + cEsc + "L0202" + cEsc + "WL1" + String(nWeight) )
//PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H600" + cEsc + "L0101" + cEsc + "WL1" + "SHIPPER#" )
//PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H600" + cEsc + "L0202" + cEsc + "WL1" + String(nShipper) )
//PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H700" + cEsc + "L0101" + cEsc + "WL1" + "DESTINATION" )
//PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H700" + cEsc + "L0202" + cEsc + "WL1" + szDestination )
PrintSend ( ll_Label, cEsc + s_NumberOfLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event
on w_std_pallet_label.create
end on

on w_std_pallet_label.destroy
end on

