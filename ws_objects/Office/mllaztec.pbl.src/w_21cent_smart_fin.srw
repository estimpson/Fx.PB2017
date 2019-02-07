$PBExportHeader$w_21cent_smart_fin.srw
forward
global type w_21cent_smart_fin from window
end type
type dw_listoforders from datawindow within w_21cent_smart_fin
end type
end forward

global type w_21cent_smart_fin from window
integer x = 823
integer y = 360
integer width = 2729
integer height = 1208
boolean titlebar = true
string title = "Smart Fin Label Order number Selector"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
dw_listoforders dw_listoforders
end type
global w_21cent_smart_fin w_21cent_smart_fin

type variables
st_generic_structure stparm
long	il_clickedrow=0
long	il_serial=0
end variables

forward prototypes
public subroutine wf_printlabel (long al_ordercount)
end prototypes

public subroutine wf_printlabel (long al_ordercount);//  Standard label for job completion

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
String	l_S_cross_ref

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

  SELECT part.name, 
  			description_short,
			cross_Ref
    INTO :szTemp, 
			:szDescription,
			:l_s_cross_ref
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

//szPart = Stparm.Value2
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
PrintSend ( ll_Label, cEsc + "A" )    //+ cEsc + "R" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V053" + cEsc + "H146" + cEsc + "M" + "PART NO" )
PrintSend ( ll_Label, cEsc + "V053" + cEsc + "H150" + cEsc + "$A,200,100,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V170" + cEsc + "H150" + cEsc + "WL1" + szTemp )
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H146" + cEsc + "M" + "LOT #" )
PrintSend ( ll_Label, cEsc + "V295" + cEsc + "H146" + cEsc + "WL1" + l_s_cross_ref )
PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H146" + cEsc + "M" + "QUANTITY" )
PrintSend ( ll_Label, cEsc + "V380" + cEsc + "H146" + cEsc + "$A,150,125,0" + cEsc + "$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V440" + cEsc + "H855" + cEsc + "WL1" + szUnit )

PrintSend ( ll_Label, cEsc + "V520" + cEsc + "H146" + cEsc + "M" + "SERIAL #" )
PrintSend ( ll_Label, cEsc + "V530" + cEsc + "H150" + cEsc + "$A,250,175,0" + cEsc + "$=" + String(lserial) )
PrintSend ( ll_Label, cEsc + "V688" + cEsc + "H146" + cEsc + "B102095" + "*" + "S" + String ( lSerial ) + "*" )
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H870" + cEsc + "$A,125,100,0" + cEsc + "$=" + "F I N" )
PrintSend ( ll_Label, cEsc + "V540" + cEsc + "H870" + cEsc + "WB1" + "LOCAT " + szLoc)
PrintSend ( ll_Label, cEsc + "V600" + cEsc + "H870" + cEsc + "WB1" + "TIME  " + szTimes )
PrintSend ( ll_Label, cEsc + "V660" + cEsc + "H870" + cEsc + "WB1" + "DATE  " + String(dDate) )
PrintSend ( ll_Label, cEsc + "V720" + cEsc + "H870" + cEsc + "WB1" + "OPER  " + szOperator )

//  Draw Lines
//PrintSend ( ll_Label, cEsc + "N" )
//PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H522" + cEsc + "FW02H0339" )
//PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H294" + cEsc + "FW02H0230" )
//PrintSend ( ll_Label, cEsc + "V000" + cEsc + "H291" + cEsc + "FW02V1112" )
//PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H520" + cEsc + "FW02V725" )
//PrintSend ( ll_Label, cEsc + "V375" + cEsc + "H425" + cEsc + "FW02V125" )
//PrintSend ( ll_Label, cEsc + "V500" + cEsc + "H425" + cEsc + "FW02H95" )

PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )


Close ( this )
end subroutine

event open;//	Declarations
Long	ll_ordercount
Long	ll_orderno
String	ls_part

//	Initialization
Stparm = Message.PowerObjectParm
il_Serial = Long(Stparm.Value1)
bringtotop = true

//	Get data from object table for that serial
select	object.part
into	:ls_part
from	object  
where	object.serial = :il_serial;

ll_ordercount = isnull(dw_listoforders.retrieve ( ls_part ),0)

if ll_ordercount > 0 then
	if ll_ordercount = 1 then
		dw_listoforders.visible = false		
		il_clickedrow = ll_ordercount
		wf_printlabel ( ll_ordercount ) 				
	else
		dw_listoforders.visible = true
	end if 	
else
	//	print the standard fin label which is already there at the bottom of the screen
	wf_printlabel ( ll_ordercount ) 	
end if 	
end event

on w_21cent_smart_fin.create
this.dw_listoforders=create dw_listoforders
this.Control[]={this.dw_listoforders}
end on

on w_21cent_smart_fin.destroy
destroy(this.dw_listoforders)
end on

type dw_listoforders from datawindow within w_21cent_smart_fin
integer x = 91
integer y = 164
integer width = 2546
integer height = 712
integer taborder = 10
boolean titlebar = true
string title = "Select a order"
string dataobject = "d_listoforders"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

event clicked;long	ll_clickedtemp

ll_clickedtemp = row

if ll_clickedtemp > 0 then 
	il_clickedrow = ll_clickedtemp
	SelectRow ( 0, false)	
	SelectRow ( row, true )		
end if 	


end event

event buttonclicked;dw_listoforders.visible = false
//	show drop down with all orders
//	upon selecting the order number write the order no. to custom5 column in 
//	object table
if il_clickedrow > 0 then 
	wf_printlabel ( rowcount () )
end if 	

end event

