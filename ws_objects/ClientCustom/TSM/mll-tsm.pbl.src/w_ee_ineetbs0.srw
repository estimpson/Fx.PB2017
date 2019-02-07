$PBExportHeader$w_ee_ineetbs0.srw
forward
global type w_ee_ineetbs0 from Window
end type
type dw_2 from datawindow within w_ee_ineetbs0
end type
type dw_1 from datawindow within w_ee_ineetbs0
end type
end forward

global type w_ee_ineetbs0 from Window
int X=82
int Y=460
int Width=1819
int Height=936
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_2 dw_2
dw_1 dw_1
end type
global w_ee_ineetbs0 w_ee_ineetbs0

type variables

end variables

event open;//  Standard label for job completion

/////////////////////////////////////////////////
//  Declaration
//
St_generic_structure Stparm
Stparm = Message.PowerObjectParm

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle
Int np
Int li_Sequence    	// Sequence in the Flow Router
Int li_NextSequence  // Next Sequence in the Flow Router

String szdt,szDate,szTime
String szFrom, szOP
String cEsc         // Escape Code
String szLoc        // Location
String szLot        // Material Lot
String szUnit       // Unit Of Measure
String szOperator   // Operator
String szPart, szP, szCoil, szHeat
String ls_Description
String szdestination
String szSupplier
String szCompany, szEng, szFinal
String ls_temp
String ls_notes1, ls_notes2, ls_notes3
String szAddress1, szAddress2, szAddress3
String szNumberofLabels
String ls_NextLoc			// Next Location in the Flow Router
String ls_ParentPart 	// Parent Part
String ls_NextStep		// Next Part in the Flow Router Sequence
String szLabelname

Long   lSerial

Dec {0} dQuantity
Dec Counter
Dec {0} i, nQUN
Dec line

Time tTime

Date dDate

DateTime DT,dt_date_time

/////////////////////////////////////////////////
//  Initialization
//

//lSerial = Message.DoubleParm
lSerial = Long(Stparm.Value1)
  SELECT part,   
         lot,   
         location,   
         last_date,   
         unit_measure,   
         operator,   
         quantity,   
         last_time,
			destination,
			field1,
			field2
    INTO :szPart,
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			:szdestination,
			:szCoil,
			:szHeat 
    FROM object  
   WHERE serial = :lSerial   ;

ddate = date(dt_date_time)
ttime = Time(dt_date_time)

szFinal = Stparm.Value5
szP = szPart //Stparm.Value2

  SELECT name, description_short  
    INTO	:ls_Description 
    FROM part  
   WHERE part = :szP  ;

  SELECT supplier_code  
    INTO :szSupplier  
    FROM edi_setups  
   WHERE destination = :szdestination   ;

  SELECT company_name, address_1, address_2, address_3
	 INTO :szCompany,
		   :szAddress1,
			:szAddress2,
			:szAddress3
	 FROM parameters ;

  SELECT engineering_level  
    INTO :szEng  
    FROM part_mfg  
   WHERE part = :szPart   ;

	SELECT note
     INTO :ls_temp
     FROM object
    WHERE serial = :lSerial		;

	SELECT parent_part
	  INTO :ls_ParentPart
	  FROM activity_router
	 WHERE part = :szPart		;

	SELECT sequence
	  INTO :li_Sequence
	  FROM activity_router
	 WHERE part = :szPart
		AND parent_part = :ls_ParentPart		;

li_NextSequence = li_Sequence + 1

	SELECT part,
			 group_location
	  INTO :ls_NextStep,
			 :ls_NextLoc
	  FROM activity_router
	 WHERE parent_part = :ls_ParentPart
		AND sequence = :li_NextSequence		;
  
   SELECT name
	  INTO :szLabelname
	  FROM label_library
	 WHERE window_name = 'w_ee_ineetbs0'	;

If Stparm.value11 = "" Then 
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

ls_notes1 = Mid ( ls_temp, 1, 27 )
ls_notes2 = Mid ( ls_temp, 28, 27 )
ls_notes3 = Mid ( ls_temp, 56, 27 )

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(lSerial)

Counter = dw_1.RowCount()

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H680" + szLabelname )

//  Serial Number Info
PrintSend ( ll_Label, cEsc + "V000" + cEsc + "H035" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H035" + cEsc + "M" + "SERIAL:" )
PrintSend ( ll_Label, cEsc + "V000" + cEsc + "H135" + cEsc + "$A,200,100,0" + cEsc + "$=" + String(lSerial) )
PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H115" + cEsc + "B102080" + "*" + "S" + String(lSerial) + "*" )

//  Part Number Info
PrintSend ( ll_Label, cEsc + "V180" + cEsc + "H035" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V200" + cEsc + "H035" + cEsc + "M" + "PART:" )
PrintSend ( ll_Label, cEsc + "V185" + cEsc + "H135" + cEsc + "$A,150,80,0" + cEsc + "$=" + szP )
PrintSend ( ll_Label, cEsc + "V255" + cEsc + "H035" + cEsc + "$A,80,60,0" + cEsc + "$=" + ls_description )

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V310" + cEsc + "H035" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V330" + cEsc + "H035" + cEsc + "M" + "QTY:")
PrintSend ( ll_Label, cEsc + "V310" + cEsc + "H135" + cEsc + "$A,80,60,0" + cEsc + "$=" + String(dQuantity) )

//  Lot Number and Next Location Info
PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H035" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V390" + cEsc + "H035" + cEsc + "M" + "LOT#:" )
PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H185" + cEsc + "$A,50,50,0" + cEsc + "$=" + szLot )
PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H445" + cEsc + "M" + "NEXT LOC:" )
PrintSend ( ll_Label, cEsc + "V470" + cEsc + "H595" + cEsc + "$A,50,50,0" + cEsc + "$=" + ls_NextLoc )

//  Product Specification Info
PrintSend ( ll_Label, cEsc + "V515" + cEsc + "H035" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V525" + cEsc + "H045" + cEsc + "M" + "PRODUCT SPECIFICATION/INSTRUCTION:" )
PrintSend ( ll_Label, cEsc + "V540" + cEsc + "H095" + cEsc + "$A,50,50,0" + cEsc + "$=" + ls_notes1 )
PrintSend ( ll_Label, cEsc + "V580" + cEsc + "H095" + cEsc + "$A,50,50,0" + cEsc + "$=" + ls_notes2 )
PrintSend ( ll_Label, cEsc + "V620" + cEsc + "H095" + cEsc + "$A,50,50,0" + cEsc + "$=" + ls_notes3 )

//  Serial Number History Header Info
PrintSend ( ll_Label, cEsc + "V667" + cEsc + "H045" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V675" + cEsc + "H255" + cEsc + "M" + "SERIAL NO. HISTORY" )
PrintSend ( ll_Label, cEsc + "V695" + cEsc + "H045" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "V705" + cEsc + "H045" + cEsc + "M" + "   DATE     TIME      PRODUCED      QTY       OPER." )
PrintSend ( ll_Label, cEsc + "V725" + cEsc + "H045" + cEsc + "FW06H800" )
PrintSend ( ll_Label, cEsc + "L0101" + cEsc + "E002" + cEsc + "OB" )
PrintSend ( ll_Label, cEsc + "V735" + cEsc + "H055" + cEsc + "WB1" )

//  Serial Number History Detail Sequence
i = 1

If Counter > 9 Then 
	Counter = 9
End If

For i = 1 to Counter
	DT     = dw_1.GetItemDateTime ( i, "date_stamp" )
	szdt   = String ( DT )
	np     = Pos ( szdt, " " )
	szDate = Left ( szdt, np )
	szTime = Mid ( szdt, np, 6 )
	nQUN   = dw_1.GetItemNumber ( i, "quantity" )
	szFrom = dw_1.GetItemString ( i, "from_loc" )
	szOP   = dw_1.GetItemString ( i, "operator" )
	line   = ( i * 30 ) + 710
	
	PrintSend ( ll_Label, cEsc + "V" + String(line) + cEsc + "H035" + cEsc + "$A,20,20,0" + Trim ( szDate ) )
	PrintSend ( ll_Label, cEsc + "V" + String(line) + cEsc + "H200" + cEsc + "$A,20,20,0" + Trim ( szTime ) )
	PrintSend ( ll_Label, cEsc + "V" + String(line) + cEsc + "H325" + cEsc + "$A,20,20,0" + Trim ( szFrom ) )
	PrintSend ( ll_Label, cEsc + "V" + String(line) + cEsc + "H530" + cEsc + "$A,20,20,0" + String(nQUN) )
	PrintSend ( ll_Label, cEsc + "V" + String(line) + cEsc + "H690" + cEsc + "$A,20,20,0" + szOP )
Next

// Draw Lines
PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H195" + cEsc + "FW06V360" )
PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H305" + cEsc + "FW06V360" )
PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H520" + cEsc + "FW06V360" )
PrintSend ( ll_Label, cEsc + "V730" + cEsc + "H680" + cEsc + "FW06V360" )

//  Company Info
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H250" + cEsc + "M" + szCompany )
PrintSend ( ll_Label, cEsc + "V1090" + cEsc + "H210" + cEsc + "(410,35" )

//  Closing Info
PrintSend ( ll_Label, cEsc + "Q" + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )

OpenwithParm(w_ee_rtertic, Stparm)
Close ( this )
end event

on w_ee_ineetbs0.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on w_ee_ineetbs0.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from datawindow within w_ee_ineetbs0
int X=901
int Y=48
int Width=594
int Height=360
int TabOrder=20
boolean Visible=false
string DataObject="dw_rtertic"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_ee_ineetbs0
int X=197
int Y=48
int Width=603
int Height=360
int TabOrder=10
boolean Visible=false
string DataObject="dw_ineetbs0"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

