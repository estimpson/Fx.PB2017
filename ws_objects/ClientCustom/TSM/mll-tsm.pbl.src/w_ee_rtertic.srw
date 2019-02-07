$PBExportHeader$w_ee_rtertic.srw
forward
global type w_ee_rtertic from Window
end type
type dw_1 from datawindow within w_ee_rtertic
end type
end forward

global type w_ee_rtertic from Window
int X=23
int Y=225
int Width=1674
int Height=941
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_ee_rtertic w_ee_rtertic

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
String szPart, ls_PartNo
String szDescription
String szdestination
String szSupplier
String szCompany, szEng
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szOperation, szLocation, szWipNo
String szNumberofLabels
String ls_ParentPart
String ls_Temp2

Long   lSerial

decimal {0} counter, seq, i, line, row, rowline
Dec {0} dQuantity, nPo

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
         object.last_time, po_number,
			object.destination
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			:nPo,
			:szdestination 
    FROM object  
   WHERE object.serial = :lSerial   ;

ddate = date(dt_date_time)
ttime = Time(dt_date_time)

  SELECT part.name, description_short  
    INTO :szTemp, 
			:szDescription 
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
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

ls_PartNo = Stparm.Value2
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
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H1300" + "E&E_rtertic" ) 

//  Part Info
PrintSend ( ll_Label, cEsc + "V050" + cEsc + "H600" + cEsc + "WB1" + "MANUFACTURING ROUTE SHEET" )
PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H650" + cEsc + "WB1" + szCompany )

PrintSend ( ll_Label, cEsc + "V140" + cEsc + "H370" + cEsc + "M" + "Final Part:" )
PrintSend ( ll_Label, cEsc + "V160" + cEsc + "H370" + cEsc + "$A,200,100,0" + cEsc + "$=" + szPart )

PrintSend ( ll_Label, cEsc + "V265" + cEsc + "H370" + cEsc + "M" + "Serial:" + cEsc + "WB1" + String(lSerial) )
PrintSend ( ll_Label, cEsc + "V265" + cEsc + "H670" + cEsc + "M" + "Description: " + cEsc + "WB1" + szTemp )

PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H305" + cEsc + "FW04H1140" )
PrintSend ( ll_Label, cEsc + "V335" + cEsc + "H320" + cEsc + "M" + "Seq.         Operation                 WIP No.              Location" )
PrintSend ( ll_Label, cEsc + "V367" + cEsc + "H305" + cEsc + "FW04H1140" )
//PrintSend ( ll_Label, cEsc + "V407" + cEsc + "H305" + cEsc + "FW04H1200" )
//PrintSend ( ll_Label, cEsc + "V447" + cEsc + "H305" + cEsc + "FW04H1200" )

SELECT activity_router.parent_part
  INTO :ls_ParentPart
  FROM activity_router
 WHERE activity_router.part = :szPart   ;

dw_1.SettransObject(sqlca)
dw_1.retrieve(ls_ParentPart)
 
Counter = dw_1.RowCount()
For i= 1 to Counter
	seq = dw_1.GetItemNUmber(i,"sequence")
	szOperation = dw_1.GetItemString(i,"code")
	szWipNo = dw_1.GetItemString ( i, "part" )
	szLocation = dw_1.GetItemString(i,"group_location")
	row = 337
	line = i*45 
	row = row + line
	
	If ls_PartNo <> szWipNo Then
		ls_Temp2 = " "
	Else
		ls_Temp2 = "*"
	End If 

	PrintSend ( ll_Label, cEsc + "L0101" )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H315" + cEsc + "M" + String(seq) )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H335" + cEsc + "M" + ls_Temp2 )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H455" + cEsc + "M" + szOperation )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H765" + cEsc + "M" + szWipNo )
	PrintSend ( ll_Label, cEsc + "V" + String(row) + cEsc + "H1150" + cEsc + "M" + szLocation )
Next

For i= 1 to 10
row = 337
line = i*45 
row = row + line
rowline = row + 30
PrintSend ( ll_Label, cEsc + "L0101" )
PrintSend ( ll_Label, cEsc + "V" + String(rowline) + cEsc + "H305" + cEsc + "FW04H1140" )
next

PrintSend ( ll_Label, cEsc + "L0000" )
PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H305" + cEsc + "FW04V460" )
PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H440" + cEsc + "FW04V460" )
PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H750" + cEsc + "FW04V460" )
//PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H975" + cEsc + "FW04V460" )
PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H1140" + cEsc + "FW04V460" )
PrintSend ( ll_Label, cEsc + "V317" + cEsc + "H1420" + cEsc + "FW04V460" )
PrintSend ( ll_Label, cEsc + "V790" + cEsc + "H305" + cEsc + "M" + "* Operation just completed" )
PrintSend ( ll_Label, cEsc + szNumberofLabels )

//******************************************

PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end on

on w_ee_rtertic.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_ee_rtertic.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_ee_rtertic
int X=229
int Y=77
int Width=1212
int Height=301
int TabOrder=1
string DataObject="dw_rtertic"
boolean LiveScroll=true
end type

