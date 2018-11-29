$PBExportHeader$w_std_label_for_fin.srw
forward
global type w_std_label_for_fin from Window
end type
end forward

global type w_std_label_for_fin from Window
int X=672
int Y=264
int Width=1582
int Height=992
boolean Visible=false
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

event open;//  Standard label for job completion  - mamatha bettagere - 10/17/98 //


/////////////////////////////////////////////////
//  Declaration
//
Stparm = Message.PowerObjectParm

Long l_l_Label		  // 32-bit Open Handle

String l_s_Esc        
String l_s_Loc      
String l_s_Lot      
String l_s_Unit     
String l_s_Operator   
String l_s_Part
String l_s_Description
String l_s_destination
String l_s_Supplier
String l_s_Company
String l_s_Temp
String l_s_Name1
String l_s_Name2
String l_s_Name3
String l_s_Address1, l_s_Address2, l_s_Address3
String l_s_NumberofLabels

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
	INTO :l_s_Part,   
         :l_s_Lot,   
         :l_s_Loc,   
         :dt_Date_time,   
         :l_s_Unit,   
         :l_s_operator,   
         :dQuantity,   
         :dt_date_Time 
	 FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

  SELECT part.name, description_short  
    INTO :l_s_Temp, 
			:l_s_Description 
    FROM part  
   WHERE part.part = :l_s_Part   ;

l_s_Company 	=  'Monitor Systems Inc.'
l_s_Address1	=	'3000 Town Centre, Suite 733'
l_s_Address2	=  'Southfield, MI 48075'


If Stparm.value11 = "" Then
	l_s_NumberofLabels = "Q1"
Else
	l_s_NumberofLabels = "Q" + Stparm.value11
End If

l_s_Part = Stparm.Value2
l_s_Supplier = Stparm.Value3
l_s_Name1 = MidA ( l_s_Temp, 1, 20 )
l_s_Name2 = MidA ( l_s_Temp, 21, 20 )
l_s_Name3 = MidA ( l_s_Temp, 41, 20 )

l_s_Esc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

l_l_Label = PrintOpen ( )

//  Start Printing
PrintSend ( l_l_Label, l_s_Esc + "A" + l_s_Esc + "R" )

//  Part Info
PrintSend ( l_l_Label, l_s_Esc + "V047" + l_s_Esc + "H266" + l_s_Esc + "M" + "PART NO" )
PrintSend ( l_l_Label, l_s_Esc + "V067" + l_s_Esc + "H266" + l_s_Esc + "M" + "(P)" )
PrintSend ( l_l_Label, l_s_Esc + "V026" + l_s_Esc + "H490" + l_s_Esc + "$A,130,160,0" + l_s_Esc + "$=" + l_s_Part )
PrintSend ( l_l_Label, l_s_Esc + "V159" + l_s_Esc + "H346" + l_s_Esc + "B103095" + "*" + "P" + l_s_Temp + "*" )

//  Quantity Info
PrintSend ( l_l_Label, l_s_Esc + "V293" + l_s_Esc + "H266" + l_s_Esc + "M" + "QUANTITY" )
PrintSend ( l_l_Label, l_s_Esc + "V313" + l_s_Esc + "H266" + l_s_Esc + "M" + "(Q)" )
PrintSend ( l_l_Label, l_s_Esc + "V243" + l_s_Esc + "H490" + l_s_Esc + "$A,130,160,0" + l_s_Esc +"$=" + String ( dQuantity ) )
PrintSend ( l_l_Label, l_s_Esc + "V389" + l_s_Esc + "H346" + l_s_Esc + "B103095" + "*" +"Q" + String ( dQuantity ) + "*" )

//Supplier Info
PrintSend ( l_l_Label, l_s_Esc + "V500" + l_s_Esc + "H266" + l_s_Esc + "M" + "SUPPLIER" )
PrintSend ( l_l_Label, l_s_Esc + "WL1" + l_s_Supplier )
PrintSend ( l_l_Label, l_s_Esc + "V519" + l_s_Esc + "H266" + l_s_Esc + "M" + "(V)" )
PrintSend ( l_l_Label, l_s_Esc + "V543" + l_s_Esc + "H346" + l_s_Esc + "B103095" + "*" + "V" + l_s_Supplier + "*")

//Serial #
PrintSend ( l_l_Label, l_s_Esc + "V657" + l_s_Esc + "H266" + l_s_Esc + "M" + "SERIAL #" )
PrintSend ( l_l_Label, l_s_Esc + "WL1" + String ( lSerial ) )
PrintSend ( l_l_Label, l_s_Esc + "V681" + l_s_Esc + "H266" + l_s_Esc + "M" + "(S)" )
PrintSend ( l_l_Label, l_s_Esc + "V703" + l_s_Esc + "H346" + l_s_Esc + "B103095" + "*" + "S" + String( lserial ) + "*" )

//Packer
PrintSend ( l_l_Label, l_s_Esc + "V505" + l_s_Esc + "H1000" + l_s_Esc + "M" + "PACKER" )
PrintSend ( l_l_Label, l_s_Esc + "V520" + l_s_Esc + "H1000" + l_s_Esc + "$A,30,70,0" + l_s_Esc + "$=" + l_s_Temp )

//Deliver to:
//PrintSend ( l_l_Label, l_s_Esc + "V600" + l_s_Esc + "H1000" + l_s_Esc + "M" + "DELIVERY TO:" )
PrintSend ( l_l_Label, l_s_Esc + "V630" + l_s_Esc + "H1050" + l_s_Esc + "$A,30,70,0" + l_s_Esc + "$=" + l_s_destination )
PrintSend ( l_l_Label, l_s_Esc + "V805" + l_s_Esc + "H266" + l_s_Esc + "M" + l_s_Company + "  " + l_s_Address1 + " " + l_s_Address2 + "  " + l_s_Address3 )

//Description
PrintSend ( l_l_Label, l_s_Esc + "V275" + l_s_Esc + "H835" + l_s_Esc + "M" + "DESCRIPTION" )
PrintSend ( l_l_Label, l_s_Esc + "V305" + l_s_Esc + "H835" + l_s_Esc + "WL1" + l_s_Description)

//Eng. Change
PrintSend ( l_l_Label, l_s_Esc + "V755" + l_s_Esc + "H1000" + l_s_Esc + "M" + "ENG. CHG" )

//Mfg. Date
PrintSend ( l_l_Label, l_s_Esc + "V665" + l_s_Esc + "H1000" + l_s_Esc + "M" + "MFG. DATE" )

//  Draw Lines
PrintSend ( l_l_Label, l_s_Esc + "N" )
PrintSend ( l_l_Label, l_s_Esc + "V440" + l_s_Esc + "H492" + l_s_Esc + "FW02H0290" )
PrintSend ( l_l_Label, l_s_Esc + "V603" + l_s_Esc + "H264" + l_s_Esc + "FW02H0230" )
PrintSend ( l_l_Label, l_s_Esc + "V020" + l_s_Esc + "H261" + l_s_Esc + "FW02V1127" )
PrintSend ( l_l_Label, l_s_Esc + "V020" + l_s_Esc + "H490" + l_s_Esc + "FW02V1127" )
PrintSend ( l_l_Label, l_s_Esc + "V020" + l_s_Esc + "H648" + l_s_Esc + "FW02V1127" )
PrintSend ( l_l_Label, l_s_Esc + "V020" + l_s_Esc + "H740" + l_s_Esc + "FW02V420" )


PrintSend ( l_l_Label, l_s_Esc + l_s_NumberofLabels )
PrintSend ( l_l_Label, l_s_Esc + "Z" )
PrintClose ( l_l_Label )
Close ( this )
end event

on w_std_label_for_fin.create
end on

on w_std_label_for_fin.destroy
end on

