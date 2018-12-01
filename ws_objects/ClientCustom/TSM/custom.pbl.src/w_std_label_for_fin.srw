$PBExportHeader$w_std_label_for_fin.srw
forward
global type w_std_label_for_fin from Window
end type
end forward

global type w_std_label_for_fin from Window
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
global w_std_label_for_fin w_std_label_for_fin

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
         object.last_time
	INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time 
	 FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

  SELECT part.name, description_short  
    INTO :szTemp, 
			:szDescription 
    FROM part  
   WHERE part.part = :szPart   ;

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
PrintSend ( ll_Label, cEsc + "V047" + cEsc + "H266" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V067" + cEsc + "H266" + cEsc + "M" + "(P)" )
PrintSend ( ll_Label, cEsc + "V026" + cEsc + "H490" + cEsc + "$A,130,160,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V159" + cEsc + "H346" + cEsc + "B103095" + "*" + "P" + szTemp + "*" )

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V293" + cEsc + "H266" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V313" + cEsc + "H266" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V243" + cEsc + "H490" + cEsc + "$A,130,160,0" + cEsc +"$=" + String ( dQuantity ) )
PrintSend ( ll_Label, cEsc + "V389" + cEsc + "H346" + cEsc + "B103095" + "*" +"Q" + String ( dQuantity ) + "*" )

//Supplier Info
PrintSend ( ll_Label, cEsc + "V500" + cEsc + "H266" + cEsc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, cEsc + "WL1" + szSupplier )
PrintSend ( ll_Label, cEsc + "V519" + cEsc + "H266" + cEsc + "M" + "(V)" )
PrintSend ( ll_Label, cEsc + "V543" + cEsc + "H346" + cEsc + "B103095" + "*" + "V" + szSupplier + "*")

//Serial #
PrintSend ( ll_Label, cEsc + "V657" + cEsc + "H266" + cEsc + "M" + "SERIAL #" )
PrintSend ( ll_Label, cEsc + "WL1" + String ( lSerial ) )
PrintSend ( ll_Label, cEsc + "V681" + cEsc + "H266" + cEsc + "M" + "(S)" )
PrintSend ( ll_Label, cEsc + "V703" + cEsc + "H346" + cEsc + "B103095" + "*" + "S" + String( lserial ) + "*" )

//Packer
PrintSend ( ll_Label, cEsc + "V505" + cEsc + "H1000" + cEsc + "M" + "PACKER" )
PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H1000" + cEsc + "$A,30,70,0" + cEsc + "$=" + szTemp )

//Deliver to:
//PrintSend ( ll_Label, cEsc + "V600" + cEsc + "H1000" + cEsc + "M" + "DELIVERY TO:" )
PrintSend ( ll_Label, cEsc + "V630" + cEsc + "H1050" + cEsc + "$A,30,70,0" + cEsc + "$=" + szdestination )
PrintSend ( ll_Label, cEsc + "V805" + cEsc + "H266" + cEsc + "M" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 )

//Description
PrintSend ( ll_Label, cEsc + "V275" + cEsc + "H835" + cEsc + "M" + "DESCRIPTION" )
PrintSend ( ll_Label, cEsc + "V305" + cEsc + "H835" + cEsc + "WL1" + szDescription)

//Eng. Change
PrintSend ( ll_Label, cEsc + "V755" + cEsc + "H1000" + cEsc + "M" + "ENG. CHG" )

//Mfg. Date
PrintSend ( ll_Label, cEsc + "V665" + cEsc + "H1000" + cEsc + "M" + "MFG. DATE" )

//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H492" + cEsc + "FW02H0290" )
PrintSend ( ll_Label, cEsc + "V603" + cEsc + "H264" + cEsc + "FW02H0230" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H261" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H490" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H648" + cEsc + "FW02V1127" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H740" + cEsc + "FW02V420" )


PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end on

on w_std_label_for_fin.create
end on

on w_std_label_for_fin.destroy
end on

