$PBExportHeader$w_std_label_for_wip.srw
forward
global type w_std_label_for_wip from Window
end type
end forward

global type w_std_label_for_wip from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_std_label_for_wip w_std_label_for_wip

type variables
St_generic_structure Stparm
end variables

on open;//  Standard label for job completion

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

szPart = Stparm.Value2
szSupplier = Stparm.Value3
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
PrintSend ( ll_Label, cEsc + "V083" + cEsc + "H346" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V083" + cEsc + "H350" + cEsc + "$A,200,100,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V200" + cEsc + "H350" + cEsc + "WL1" + szTemp )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H346" + cEsc + "M" + "LOT #" )
PrintSend ( ll_Label, cEsc + "V325" + cEsc + "H346" + cEsc + "WL1" + szLot )
PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H346" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H346" + cEsc + "$A,150,125,0" + cEsc + "$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H955" + cEsc + "WL1" + szUnit )

PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H346" + cEsc + "M" + "SERIAL #" )
PrintSend ( ll_Label, cEsc + "V560" + cEsc + "H350" + cEsc + "$A,250,175,0" + cEsc + "$=" + String(lserial) )
PrintSend ( ll_Label, cEsc + "V718" + cEsc + "H346" + cEsc + "B102095" + "*" + "S" + String ( lSerial ) + "*" )
PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H1070" + cEsc + "$A,125,100,0" + cEsc + "$=" + "W I P" )
PrintSend ( ll_Label, cEsc + "V570" + cEsc + "H1070" + cEsc + "WB1" + "LOCAT " + szLoc)
PrintSend ( ll_Label, cEsc + "V630" + cEsc + "H1070" + cEsc + "WB1" + "TIME  " + szTimes )
PrintSend ( ll_Label, cEsc + "V690" + cEsc + "H1070" + cEsc + "WB1" + "DATE  " + String(dDate) )
PrintSend ( ll_Label, cEsc + "V750" + cEsc + "H1070" + cEsc + "WB1" + "OPER  " + szOperator )
//
//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H522" + cEsc + "FW02H0339" )
PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H294" + cEsc + "FW02H0230" )
PrintSend ( ll_Label, cEsc + "V000" + cEsc + "H291" + cEsc + "FW02V1112" )
PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H520" + cEsc + "FW02V725" )
PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H425" + cEsc + "FW02V125" )
PrintSend ( ll_Label, cEsc + "V500" + cEsc + "H425" + cEsc + "FW02H95" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )


Close ( this )
end on

on w_std_label_for_wip.create
end on

on w_std_label_for_wip.destroy
end on

