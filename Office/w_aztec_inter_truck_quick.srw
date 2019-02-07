HA$PBExportHeader$w_aztec_inter_truck_quick.srw
forward
global type w_aztec_inter_truck_quick from Window
end type
end forward

global type w_aztec_inter_truck_quick from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_aztec_inter_truck_quick w_aztec_inter_truck_quick

type variables
st_generic_structure stparm
end variables

event open;//  Internation truck Quick
//  w_aztec_inter_truck_quick

// 5/10/03 JAC - CSR 170848
// used wyandotte navistar quick as a template

//  Variable declarations

STRING	cEsc         // Escape Code
STRING	ls_destination
STRING	ls_dockcode
STRING	ls_numberoflabels
STRING	ls_supplier_code

LONG	ll_shipperid
Long	ll_Label		  // 32-bit Open Handle

//  Get the destination from the message.
//ls_destination = message.stringparm

// Get the shipper id from the message.
Stparm = Message.PowerObjectParm
ll_shipperid = Long(Stparm.Value1)

////  Get the shipper number.
//IF NOT IsValid ( w_shipping_dock ) THEN
//	MessageBox ( "Warning.", "This label can only be printed from the Shipping Dock." )
//	Close ( this )
//	Return
//END IF
//ll_shipperid = w_shipping_dock.iShipper
//


  SELECT supplier_code  
	 INTO :ls_supplier_code  
	 FROM edi_setups, shipper  
	WHERE edi_setups.destination = shipper.destination AND
   		shipper.id = :ll_shipperid ;
			
			
//test data
//ls_supplier_code = "8939OS1"
//ll_Shipperid = 327182
//

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" )
// Change orientation for testing
// PrintSend ( ll_Label, cEsc + "R" + cEsc + "R" + cEsc + "R" )

//  Start Printing
//PrintSend ( ll_Label, cEsc + "A"  )
//PrintSend ( ll_Label, cEsc + "AR" )
//

SetPointer(HourGlass!)
//  Info

//PrintSend ( ll_Label, cEsc + "V020" + cEsc + "H095" + cEsc + "$B,80,160,0"  + cEsc + "$=" + "QUICK RECEIVE" )
PrintSend ( ll_Label, cEsc + "V332" + cEsc + "H100" + cEsc + "WB1" + "(V) VENDOR ID " )
PrintSend ( ll_Label, cEsc + "V376" + cEsc + "H105" + cEsc + "B103101" + "*" + "V" + ls_supplier_code + "*"  )
PrintSend ( ll_Label, cEsc + "V488" + cEsc + "H105" + cEsc + "M" + ls_supplier_code)
//PrintSend ( ll_Label, cEsc + "V522" + cEsc + "H100" + cEsc + "WB1"   + "(2S)          "+string(ll_shipperid) )
PrintSend ( ll_Label, cEsc + "V062" + cEsc + "H100" + cEsc + "WB1" + "QUICK RECEIVE" )
PrintSend ( ll_Label, cEsc + "V099" + cEsc + "H100" + cEsc + "WB1" + "(2S) ASN SHIPMENT ID " + cEsc + "WB1"   + string(ll_shipperid))
PrintSend ( ll_Label, cEsc + "V150" + cEsc + "H105" + cEsc + "B103101" + "*" + "2S" + string(ll_shipperid) + "*"  )
PrintSend ( ll_Label, cEsc + "V260" + cEsc + "H105" + cEsc + "M" + string(ll_shipperid) )


//  Draw Lines
//PrintSend ( ll_Label, cEsc + "N" )
//PrintSend ( ll_Label, cEsc + "V211" + cEsc + "H043" + cEsc + "FW02H800" )
//PrintSend ( ll_Label, cEsc + "V511" + cEsc + "H043" + cEsc + "FW02H800" )
//PrintSend ( ll_Label, cEsc + "V731" + cEsc + "H043" + cEsc + "FW02H800" )
//

//PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Q1" )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )

SetPointer(Arrow!)
Close ( this )

end event

on w_aztec_inter_truck_quick.create
end on

on w_aztec_inter_truck_quick.destroy
end on

