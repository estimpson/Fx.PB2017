$PBExportHeader$w_tsm_mpl_chrysler.srw
forward
global type w_tsm_mpl_chrysler from window
end type
end forward

global type w_tsm_mpl_chrysler from window
integer x = 672
integer y = 264
integer width = 1582
integer height = 992
boolean titlebar = true
string title = "w_std_lable_for_fin"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
end type
global w_tsm_mpl_chrysler w_tsm_mpl_chrysler

type variables
St_generic_structure  Stparm
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
String szPart, szP
String szDescription
String szdestination
String szSupplier
String szCompany, szEng
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String s_NumberofLabels

Long   lSerial

Dec {0} dQuantity

Time tTime

Date dDate

Datetime dt_date_time

/////////////////////////////////////////////////
//  Initialization
//

lSerial = Long(Stparm.Value1)

  SELECT object.part,   
         object.lot,   
         object.location,   
         object.last_date,   
         object.unit_measure,   
         object.operator,   
         object.quantity,   
         object.last_time,
			object.destination
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			:szdestination 
    FROM object  
   WHERE object.serial = :lSerial   ;

Ddate = date(dt_date_time)
ttime = time(dt_date_time)

szP = Stparm.Value2

  SELECT part.name
	 INTO :szDescription
    FROM part  
   WHERE part.part = :szPart   ;

  SELECT edi_setups.supplier_code  
    INTO :szSupplier  
    FROM edi_setups  
   WHERE edi_setups.destination = :szdestination   ;

SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;

  SELECT part_mfg.engineering_level  
    INTO :szEng  
    FROM part_mfg  
   WHERE part_mfg.part = :szPart   ;

If Stparm.value11 = "" Then
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + Stparm.value11
End If

szSupplier = Stparm.value3

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
PrintSend ( ll_Label, cEsc + "V040" + cEsc + "H294" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H294" + cEsc + "M" + "(P)" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H410" + cEsc + "$A,150,150,0" + cEsc + "$=" + szP )
PrintSend ( ll_Label, cEsc + "V151" + cEsc + "H341" + cEsc + "B103095" + "*" + "P" + szP + "*" )

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V263" + cEsc + "H296" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V288" + cEsc + "H296" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V233" + cEsc + "H470" + cEsc + "$A,150,150,0" + cEsc +"$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V359" + cEsc + "H341" + cEsc + "B103095" + "*" +"Q" + String(dQuantity) + "*" )

//  Supplier Info
PrintSend ( ll_Label, cEsc + "V479" + cEsc + "H300" + cEsc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, cEsc + "V504" + cEsc + "H300" + cEsc + "M" + "(V)" )
PrintSend ( ll_Label, cEsc + "V475" + cEsc + "H450" + cEsc + "WL1" + szSupplier )
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H341" + cEsc + "B103095" + "*" + "V" + szSupplier + "*" )

//  Serial Number Info
PrintSend ( ll_Label, cEsc + "V631" + cEsc + "H296" + cEsc + "M" + "SERIAL " )
PrintSend ( ll_Label, cEsc + "V656" + cEsc + "H296" + cEsc + "M" + "(S)" )
PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H450" + cEsc + "WL1" + String(lSerial))
PrintSend ( ll_Label, cEsc + "V673" + cEsc + "H341" + cEsc + "B103095" + "*" + "S" + String(lSerial) + "*")

//  Description Info
PrintSend ( ll_Label, cEsc + "V263" + cEsc + "H850" + cEsc + "M" + "DESCRIPTION" )
PrintSend ( ll_Label, cEsc + "V283" + cEsc + "H850" + cEsc + "$A,40,40,0" + cEsc + "$=" + szDescription )

//  Date Manufactured Info
PrintSend ( ll_Label, cEsc + "V345" + cEsc + "H890" + cEsc + "M" + "DATE MFG" )
PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H870" + cEsc + "$A,50,50,0" + cEsc + "$=" + String(today()) )

//  Engineering Change Info
PrintSend ( ll_Label, cEsc + "V340" + cEsc + "H1100" + cEsc + "M" + "CHANGE" )
PrintSend ( ll_Label, cEsc + "V360" + cEsc + "H1100" + cEsc + "M" + "LETTER" )
PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H1125" + cEsc + "$A,80,80,0" + cEsc + "$=" + String(szEng) )

//  Company Info
PrintSend ( ll_Label, cEsc + "V775" + cEsc + "H296 " + cEsc + "M" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 )

//  Additional Code for Future Modifications
//PrintSend ( ll_Label, cEsc + "V490" + cEsc + "H1050" + cEsc + "$A,40,40,0" + cEsc + "$=" + "E&E : " + szPart )
//PrintSend ( ll_Label, cEsc + "V510" + cEsc + "H1070" + cEsc + "WB1" + szLot )
//PrintSend ( ll_Label, cEsc + "V631" + cEsc + "H1070" + cEsc + "M" + "FINAL LOT #" )
//PrintSend ( ll_Label, cEsc + "V775" + cEsc + "H346" + cEsc + "M" + "E&E MANUFACTURING CO. INC. PLYMOUTH MI 48170" )

//  Line Info
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V395" + cEsc + "H472" + cEsc + "FW03H0334" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H330" + cEsc + "FW03V0558" )
PrintSend ( ll_Label, cEsc + "V587" + cEsc + "H254" + cEsc + "FW03H0220" )
PrintSend ( ll_Label, cEsc + "V200" + cEsc + "H330" + cEsc + "FW03H0142" )
PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H330" + cEsc + "FW03H0142" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H251" + cEsc + "FW03V1127" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H470" + cEsc + "FW03V1127" )
PrintSend ( ll_Label, cEsc + "V400" + cEsc + "H618" + cEsc + "FW03V0757" )

//  Closing Info
PrintSend ( ll_Label, cEsc + s_NumberOfLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end on

on w_tsm_mpl_chrysler.create
end on

on w_tsm_mpl_chrysler.destroy
end on

