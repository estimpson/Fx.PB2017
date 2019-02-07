$PBExportHeader$w_std_label_for_wip.srw
forward
global type w_std_label_for_wip from Window
end type
end forward

global type w_std_label_for_wip from Window
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
global w_std_label_for_wip w_std_label_for_wip

type variables
St_generic_structure Stparm
end variables

event open;//  Standard label for job completion - mamatha bettagere -  10/17/98 */

/////////////////////////////////////////////////
//  Declaration
//

Stparm = Message.PowerObjectParm

Long ll_Label		  // 32-bit Open Handle

String l_s_Esc         // Escape Code
String l_s_Loc        // Location
String l_s_Lot        // Material Lot
String l_s_Unit       // Unit Of Measure
String l_s_Operator   // Operator
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
String l_s_Time,l_s_Times
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
    INTO :l_s_Part,   
         :l_s_Lot,   
         :l_s_Loc,   
         :dt_Date_time,   
         :l_s_Unit,   
         :l_s_Operator,   
         :dQuantity,   
         :dt_date_Time 
    FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

l_s_Time = String(tTime)
l_s_Times = MidA(l_s_Time, 1, 5)

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

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, l_s_Esc + "A" + l_s_Esc + "R" )

//  Part Info
PrintSend ( ll_Label, l_s_Esc + "V083" + l_s_Esc + "H346" + l_s_Esc + "M" + "PART NO" )
PrintSend ( ll_Label, l_s_Esc + "V083" + l_s_Esc + "H350" + l_s_Esc + "$A,200,100,0" + l_s_Esc + "$=" + l_s_Part )
PrintSend ( ll_Label, l_s_Esc + "V200" + l_s_Esc + "H350" + l_s_Esc + "WL1" + l_s_Temp )
PrintSend ( ll_Label, l_s_Esc + "V300" + l_s_Esc + "H346" + l_s_Esc + "M" + "LOT #" )
PrintSend ( ll_Label, l_s_Esc + "V325" + l_s_Esc + "H346" + l_s_Esc + "WL1" + l_s_Lot )
PrintSend ( ll_Label, l_s_Esc + "V400" + l_s_Esc + "H346" + l_s_Esc + "M" + "QUANTITY" )
PrintSend ( ll_Label, l_s_Esc + "V410" + l_s_Esc + "H346" + l_s_Esc + "$A,150,125,0" + l_s_Esc + "$=" + String(dQuantity) )
PrintSend ( ll_Label, l_s_Esc + "V470" + l_s_Esc + "H955" + l_s_Esc + "WL1" + l_s_Unit )

PrintSend ( ll_Label, l_s_Esc + "V550" + l_s_Esc + "H346" + l_s_Esc + "M" + "SERIAL #" )
PrintSend ( ll_Label, l_s_Esc + "V560" + l_s_Esc + "H350" + l_s_Esc + "$A,250,175,0" + l_s_Esc + "$=" + String(lserial) )
PrintSend ( ll_Label, l_s_Esc + "V718" + l_s_Esc + "H346" + l_s_Esc + "B102095" + "*" + "S" + String ( lSerial ) + "*" )
PrintSend ( ll_Label, l_s_Esc + "V300" + l_s_Esc + "H1070" + l_s_Esc + "$A,125,100,0" + l_s_Esc + "$=" + "W I P" )
PrintSend ( ll_Label, l_s_Esc + "V570" + l_s_Esc + "H1070" + l_s_Esc + "WB1" + "LOCAT " + l_s_Loc)
PrintSend ( ll_Label, l_s_Esc + "V630" + l_s_Esc + "H1070" + l_s_Esc + "WB1" + "TIME  " + l_s_Times )
PrintSend ( ll_Label, l_s_Esc + "V690" + l_s_Esc + "H1070" + l_s_Esc + "WB1" + "DATE  " + String(dDate) )
PrintSend ( ll_Label, l_s_Esc + "V750" + l_s_Esc + "H1070" + l_s_Esc + "WB1" + "OPER  " + l_s_Operator )
//
//  Draw Lines
PrintSend ( ll_Label, l_s_Esc + "N" )
PrintSend ( ll_Label, l_s_Esc + "V375" + l_s_Esc + "H522" + l_s_Esc + "FW02H0339" )
PrintSend ( ll_Label, l_s_Esc + "V375" + l_s_Esc + "H294" + l_s_Esc + "FW02H0230" )
PrintSend ( ll_Label, l_s_Esc + "V000" + l_s_Esc + "H291" + l_s_Esc + "FW02V1112" )
PrintSend ( ll_Label, l_s_Esc + "V375" + l_s_Esc + "H520" + l_s_Esc + "FW02V725" )
PrintSend ( ll_Label, l_s_Esc + "V375" + l_s_Esc + "H425" + l_s_Esc + "FW02V125" )
PrintSend ( ll_Label, l_s_Esc + "V500" + l_s_Esc + "H425" + l_s_Esc + "FW02H95" )
PrintSend ( ll_Label, l_s_Esc + l_s_NumberofLabels )
PrintSend ( ll_Label, l_s_Esc + "Z" )
PrintClose ( ll_Label )


Close ( this )
end event

on w_std_label_for_wip.create
end on

on w_std_label_for_wip.destroy
end on

