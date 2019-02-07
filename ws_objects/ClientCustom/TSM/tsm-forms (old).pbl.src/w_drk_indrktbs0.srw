$PBExportHeader$w_drk_indrktbs0.srw
forward
global type w_drk_indrktbs0 from Window
end type
type dw_1 from datawindow within w_drk_indrktbs0
end type
end forward

global type w_drk_indrktbs0 from Window
int X=23
int Y=225
int Width=2794
int Height=777
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_drk_indrktbs0 w_drk_indrktbs0

type variables
St_generic_structure  Stparm
end variables

on open;//  Smart label for Dirksen Screw Products
//	 David Cervenan
//  7/25/95

/////////////////////////////////////////////////
//  Declaration
//
Stparm = Message.PowerObjectParm

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle
int np

String cEsc         // Escape Code
String szLoc        // Location
String szLot        // Material Lot
String szUnit       // Unit Of Measure
String szOperator   // Operator
String szPart, ls_PartNo, szCoil, szHeat
String szDescription
String szdestination
String szSupplier
String szCompany, szEng, szFinal
String szTemp
String szTemp2
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szOperation, szWipNo
String szNumberofLabels
String szdt, szDate, szTime, szTimes
String szFrom, szOP
String szCustomer
String szContainer
String szMat
String ls_ParentPart

Long   lSerial

decimal {0} counter, seq, i, line, row, rowline
Dec {0} dQuantity, nPo 
Dec dNet, dGross, dTare, ld_Net1, ld_Tare1

Time tTime

Date dDate

Datetime dt_date_time

/////////////////////////////////////////////////
//  Initialization
//

lSerial = Long(Stparm.Value1)

  SELECT part,   
         lot,   
         location,   
         last_date,   
         unit_measure,   
         operator,   
         quantity,   
         last_time,
			po_number,
			destination,
			field1,
			field2,
         package_type,
         weight,
         customer
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			:nPo,
			:szdestination,
         :szCoil,
			:szHeat,  
			:szContainer,
			:dNet,
			:szCustomer
    FROM object  
   WHERE serial = :lSerial   ;

ddate = date(dt_date_time)
ttime = Time(dt_date_time)

szFinal = Stparm.Value7
ls_PartNo = Stparm.Value2

  SELECT weight
    INTO :dTare
    FROM package_materials
   WHERE code = :szContainer ;

If SQLCA.SQLCode <> 0 Then
	dTare = 0
End if

  SELECT name, 
         description_short  
    INTO :szTemp, 
			:szDescription 
    FROM part  
   WHERE part = :ls_PartNo   ;

  SELECT supplier_code  
    INTO :szSupplier  
    FROM edi_setups  
   WHERE destination = :szdestination   ;
 
  SELECT company_name, 
         address_1,
         address_2,
         address_3
	 INTO :szCompany,
		   :szAddress1,
			:szAddress2,
			:szAddress3
	 FROM parameters ;

  SELECT engineering_level  
    INTO :szEng  
    FROM part_mfg  
   WHERE part = :szPart   ;

	SELECT parent_part
	  INTO :ls_ParentPart
	  FROM activity_router
	 WHERE part = :szPart		;

If Stparm.value11 = "" Then
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(ls_PartNo)

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

//  Print Flow Router
PrintSend ( ll_Label, cEsc + "V010" + cEsc + "H300" + cEsc + "M" + "Seq. Process             WIP No.")

dw_1.SettransObject(sqlca)
dw_1.retrieve(ls_ParentPart)

Counter = dw_1.RowCount()
For i= 1 to Counter
	seq = dw_1.GetItemNUmber(i,"sequence")
	szOperation = dw_1.GetItemString(i,"code")
	szWipNo = dw_1.GetItemString(i, "part")
	szMat = dw_1.GetItemString(i, "material")
	row = 5
	line = i*40 
	row = row + line

	PrintSend ( ll_Label, cEsc + "L0101" )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H300" + cEsc + "M" + String(seq) )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H380" + cEsc + "M" + szOperation )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H620" + cEsc + "M" + szWipNo )

	If ls_PartNo <> szWipNo Then
		szTemp2 = " "
	Else 
		szTemp2 = "*"
	End If

	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H325" + cEsc + "M" + szTemp2 )	
next

//  Print Grid Lines for Flow Router
For i= 1 to 15
	row = 0
	line = i*40 
	row = row + line
	rowline = row + 30
	PrintSend ( ll_Label, cEsc + "L0101" )
	PrintSend ( ll_Label, cEsc + "V" + String(rowline) + cEsc + "H290" + cEsc + "FW04H580" )
next

//  Print Last Process & Inspection Results Section
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H310" + cEsc + "M" + "* = Last Process Completed")
PrintSend ( ll_Label, cEsc + "V690" + cEsc + "H310" + cEsc + "$A,30,30,0" + "Inspection Results - Last Process:")
PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H310" + cEsc + "$A,30,30,0" + "Approve: ________   By:     ________")
PrintSend ( ll_Label, cEsc + "V770" + cEsc + "H310" + cEsc + "$A,30,30,0" + "Reject:  ________   IR No.: ________")

//  Print Serial Number Info
PrintSend ( ll_Label, cEsc + "V010" + cEsc + "H880" + cEsc + "M" + "Serial No." )
PrintSend ( ll_Label, cEsc + "$A,150,100,0" + cEsc + "$=" + String(lSerial) )
PrintSend ( ll_Label, cEsc + "V095" + cEsc + "H890" + cEsc + "B102095" + "*" + "S" + String(lSerial) + "*" )

//  Print Customer Info
PrintSend ( ll_Label, cEsc + "V205" + cEsc + "H880" + cEsc + "M" + "Customer:" )
PrintSend ( ll_Label, cEsc + "V220" + cEsc + "H880" + cEsc + "$A,75,75,0" + cEsc + "$=" + szCustomer )

//  Print Part & Eng. Change Info
PrintSend ( ll_Label, cEsc + "V295" + cEsc + "H880" + cEsc + "M" + "Part No:" )
PrintSend ( ll_Label, cEsc + "V310" + cEsc + "H880" + cEsc + "$A,75,75,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V295" + cEsc + "H1280" + cEsc + "M" + "Rev:" )
PrintSend ( ll_Label, cEsc + "V310" + cEsc + "H1280" + cEsc + "$A,75,75,0" + cEsc + "$=" + szEng )

//  Print Lot & SO Info
PrintSend ( ll_Label, cEsc + "V385" + cEsc + "H880" + cEsc + "M" + "Heat/Lot No:" )
PrintSend ( ll_Label, cEsc + "V385" + cEsc + "H1180" + cEsc + "M" + "SO No:" )
PrintSend ( ll_Label, cEsc + "V405" + cEsc + "H880" + cEsc + "$A,50,50,0" + cEsc + "$=" + szLot )

//  Print Quantity Info
PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H880" + cEsc + "M" + "Qty:" )
PrintSend ( ll_Label, cEsc + "V480" + cEsc + "H980" + cEsc + "$A,175,100,0" + cEsc + "$=" + String(dQuantity) )

//  Print Process/Receiving Info
ld_Tare1 = Truncate ( dTare, 2 )
ld_Net1 = Truncate ( dNet, 2 )
szTime = String(tTime)
szTimes = Mid (szTime,1 , 5)
dGross = ( ld_Tare1 + ld_Net1 )

PrintSend ( ll_Label, cEsc + "V585" + cEsc + "H980" + cEsc + "M" + "Process/Receiving Info" )
PrintSend ( ll_Label, cEsc + "V615" + cEsc + "H880" + cEsc + "M" + "Date: " + String(today()) )
PrintSend ( ll_Label, cEsc + "V615" + cEsc + "H1170" + cEsc + "M" + "Container: " )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H880" + cEsc + "M" + "Time: " + szTimes )
PrintSend ( ll_Label, cEsc + "V655" + cEsc + "H1170" + cEsc + "M" + "Qty: " + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V695" + cEsc + "H880" + cEsc + "M" + "Mach No: " + szLoc )
PrintSend ( ll_Label, cEsc + "V695" + cEsc + "H1170" + cEsc + "M" + "Gross Wt: " + String( dGross ) )
PrintSend ( ll_Label, cEsc + "V735" + cEsc + "H880" + cEsc + "M" + "Oper: " + szOperator )
PrintSend ( ll_Label, cEsc + "V735" + cEsc + "H1170" + cEsc + "M" + "Net Wt: " + String( ld_Net1 ) )

//  Print Label Lines
PrintSend ( ll_Label, cEsc + "V033" + cEsc + "H290" + cEsc + "FW04H580" )
PrintSend ( ll_Label, cEsc + "V830" + cEsc + "H355" + cEsc + "FW04V635" )
PrintSend ( ll_Label, cEsc + "V830" + cEsc + "H570" + cEsc + "FW04V635" )
PrintSend ( ll_Label, cEsc + "V830" + cEsc + "H865" + cEsc + "FW06V820" )
PrintSend ( ll_Label, cEsc + "V195" + cEsc + "H865" + cEsc + "FW06H700" )
PrintSend ( ll_Label, cEsc + "V285" + cEsc + "H865" + cEsc + "FW06H700" )
PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H865" + cEsc + "FW06H700" )
PrintSend ( ll_Label, cEsc + "V450" + cEsc + "H865" + cEsc + "FW06H700" )
PrintSend ( ll_Label, cEsc + "V575" + cEsc + "H865" + cEsc + "FW06H700" )
PrintSend ( ll_Label, cEsc + "V605" + cEsc + "H980" + cEsc + "FW02H330" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose (ll_Label)
Close (this)

end on

on w_drk_indrktbs0.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_drk_indrktbs0.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_drk_indrktbs0
int X=97
int Y=81
int Width=2597
int Height=301
int TabOrder=1
string DataObject="dw_rtertic"
boolean LiveScroll=true
end type

