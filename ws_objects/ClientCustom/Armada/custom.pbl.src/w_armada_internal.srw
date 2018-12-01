$PBExportHeader$w_armada_internal.srw
$PBExportComments$armada internal label 4/4
forward
global type w_armada_internal from window
end type
end forward

global type w_armada_internal from window
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
global w_armada_internal w_armada_internal

type variables
St_generic_structure Stparm
end variables

event open;//  Standard label for job completion

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
String wzDescription
String szSupplier
String szCompany 
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szNumberofLabels
String szLabelname
String sz_last_date

Long   lSerial

INTEGER	i_JulianDate
 
Dec {0} dQuantity

DATETIME	ldt_Date, &
			ldt_Time

Datetime ldt_last_date, &
		   ldt_last_time

Time tTime

Date dDate, &
		d_FirstDayOfYear

  
/////////////////////////////////////////////////
//  Initialization
//

lSerial = Long(Stparm.Value1)

  SELECT object.lot,   
         object.location,   
         object.last_date,   
         object.unit_measure,   
         object.operator,   
         object.quantity,   
         object.last_time,
		   object.destination,
			object.part 
   		 
	INTO  :szLot,   
         :szLoc,   
         :ldt_last_date,
		   :szUnit,   
         :szOperator,   
         :dQuantity,   
         :ldt_last_time, 
     	   :szdestination,
         :szpart  
		FROM object  
	   WHERE object.serial = :lSerial   ;

//		select audit_trail.date_stamp
//		into :ldt_last_Date
//		from audit_trail
//		where audit_trail.serial = :lserial and 
//		audit_trail.type = 'J'    ;


dDate = Date ( ldt_last_Date )
tTime = Time ( ldt_last_Time )

d_FirstDayOfYear = Date ( Year ( dDate ), 1, 1 )
i_JulianDate = 10 * ( DaysAfter ( d_FirstDAyOfYear, dDate ) + 1 ) + Mod ( Year ( dDate ), 10 )

szP = Stparm.Value2
  SELECT part.part,
		  part.description_short,
		  part.description_long
    INTO :szpart, 
			:szDescription, 
			:wzDescription
    FROM part  
   WHERE part.part = :szPart   ;
	

 SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;

//SELECT  name
//	 INTO :szLabelname
//	 FROM label_library
//	WHERE window_name = 'w_armada_internal'	;

If Stparm.value11 = "" Then 
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
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
PrintSend ( ll_Label, cEsc + "V040" + cEsc + "H1000" + szLabelname )

//  Part Info
PrintSend ( ll_Label, cEsc + "V040" + cEsc + "H346" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H346" + cEsc + "M" + "(P)" )
PrintSend ( ll_Label, cEsc + "V045" + cEsc + "H380" + cEsc + "$A,180,240,0" + cEsc + "$=" + UPPER(szP ))
//PrintSend ( ll_Label, cEsc + "V151" + cEsc + "H381" + cEsc + "B103095" + "*" + "P" + UPPER(szpart) + "*" )

PrintSend ( ll_Label, cEsc + "V263" + cEsc + "H346" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V288" + cEsc + "H346" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V233" + cEsc + "H520" + cEsc + "$A,150,150,0" + cEsc +"$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V359" + cEsc + "H520" + cEsc + "B103095" + "*" +"Q" + String(dQuantity) + "*" )

//PrintSend ( ll_Label, cEsc + "V518" + cEsc + "H1050" + cEsc + "$A,40,80,0" + cEsc + "$=" + szTemp )

//PrintSend ( ll_Label, cEsc + "V480" + cEsc + "H1040" + cEsc + "WB1" + "MATERIAL LOT #" )
//PrintSend ( ll_Label, cEsc + "V545" + cEsc + "H1040" + cEsc + "WL1" + szLot )
PrintSend ( ll_Label, cEsc + "V335" + cEsc + "H1100" + cEsc + "WL1" + "ARM" )
PrintSend ( ll_Label, cEsc + "V475" + cEsc + "H1040" + cEsc + "WL1" + String(wzDescription))
PrintSend ( ll_Label, cEsc + "V635" + cEsc + "H1040" + cEsc + "M" + "MFG. JULIAN DATE" )
PrintSend ( ll_Label, cEsc + "V675" + cEsc + "H1040" + cEsc + "$A,55,55,0" + cEsc + "$=" + String ( i_JulianDate, '0000' ) + ' ' + String ( tTime, 'hh:mm' ) )

PrintSend ( ll_Label, cEsc + "V480" + cEsc + "H346" + cEsc + "M" + "LOT/SERIAL" )
PrintSend ( ll_Label, cEsc + "V504" + cEsc + "H346" + cEsc + "M" + "(S)" )
PrintSend ( ll_Label, cEsc + "V475" + cEsc + "H520" + cEsc + "WL1" + String(lSerial))
PrintSend ( ll_Label, cEsc + "V525" + cEsc + "H381" + cEsc + "B103095" + "*" + "XX" + String(lSerial) + "*")

PrintSend ( ll_Label, cEsc + "V785" + cEsc + "H325" + cEsc + "M" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 )

//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
//PrintSend ( ll_Label, cEsc + "V395" + cEsc + "H472" + cEsc + "FW03H0299" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H251" + cEsc + "FW03V1127" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H470" + cEsc + "FW03V1127" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H625" + cEsc + "FW03V1127" )

PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_armada_internal.create
end on

on w_armada_internal.destroy
end on

