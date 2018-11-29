$PBExportHeader$w_std_pallet_label.srw
forward
global type w_std_pallet_label from window
end type
type dw_1 from datawindow within w_std_pallet_label
end type
end forward

global type w_std_pallet_label from window
boolean visible = false
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
dw_1 dw_1
end type
global w_std_pallet_label w_std_pallet_label

type variables

end variables

event open;/////////////////////////////////////////////////
//  Declaration

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle
int i

String l_s_Shipper
String cEsc         // Escape Code
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
String s_NumberOfLabels
String l_s_Name1
String l_s_Name2
String l_s_Name3
String l_s_Address1, l_s_Address2, l_s_Address3
String l_s_Time,l_s_Times

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
			object.shipper
    INTO :l_s_Part,   
         :l_s_Lot,   
         :l_s_Loc,   
         :dt_Date_time,   
         :l_s_Unit,   
         :l_s_Operator,   
         :dQuantity,   
         :dt_date_Time, 
			:nShipper 
    FROM object  
   WHERE object.serial = :lSerial   ;
Ddate = date(dt_date_time)
ttime = time(dt_date_time)

SELECT shipper.destination  
    INTO :l_s_Destination  
    FROM shipper  
   WHERE shipper.id = :nShipper   ;

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

select
	sum(weight)
into
	:nWeight
from
	object
where
	parent_serial = :lSerial  ;

If Isnull(nShipper) or nShipper < 0 then
inSerial = dw_1.GetItemNumber(1, "serial")
  SELECT object.origin  
    INTO :l_s_Shipper  
    FROM object  
   WHERE object.serial = :inSerial   ;
nShipper = Long (l_s_Shipper)
SELECT shipper.destination  
    INTO :l_s_Destination  
    FROM shipper  
   WHERE shipper.id = :nShipper   ;
End If

If Stparm.value11 = "" Then
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + Stparm.value11
End If

l_s_Name1 = MidA ( l_s_Temp, 1, 20 )
l_s_Name2 = MidA ( l_s_Temp, 21, 20 )
l_s_Name3 = MidA ( l_s_Temp, 41, 20 )

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "%1" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H100" + cEsc + "L0101" + cEsc + "WL1" + "PALLET#  " )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H100" + cEsc + "L0202" + cEsc + "WL1" + String(lSerial) )
PrintSend ( ll_Label, cEsc + "V950" + cEsc + "H225" + cEsc + "B104130" + "*" + "S" + String(lSerial) + "*" )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H400" + cEsc + "L0101" + cEsc + "WL1" + "TOTAL BOXES" )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H400" + cEsc + "L0202" + cEsc + "WL1" + String(nCarton) )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H500" + cEsc + "L0101" + cEsc + "WL1" + "NET WEIGHT "  )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H500" + cEsc + "L0202" + cEsc + "WL1" + String(nWeight) )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H600" + cEsc + "L0101" + cEsc + "WL1" + "SHIPPER#" )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H600" + cEsc + "L0202" + cEsc + "WL1" + String(nShipper) )
PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H700" + cEsc + "L0101" + cEsc + "WL1" + "DESTINATION" )
PrintSend ( ll_Label, cEsc + "V650" + cEsc + "H700" + cEsc + "L0202" + cEsc + "WL1" + l_s_Destination )
PrintSend ( ll_Label, cEsc + s_NumberOfLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_std_pallet_label.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_std_pallet_label.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_std_pallet_label
integer x = 197
integer y = 128
integer width = 983
integer height = 440
integer taborder = 1
string dataobject = "dw_pallet"
boolean livescroll = true
end type

