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
integer width = 2702
integer height = 1184
boolean titlebar = true
string title = "Smart Fin Label Order number Selector"
boolean controlmenu = true
windowtype windowtype = response!
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

public subroutine wf_printlabel (long al_ordercount);//	Declarations
Dec {0}	dQuantity
Date	dDate
Datetime dt_date_time
Long	ll_Label
Long	lSerial
Long	ll_orderno
String	cEsc         // Escape Code
String	szLoc        // Location
String	szLot        // Material Lot
String	szUnit       // Unit Of Measure
String	szOperator   // Operator
String	szPart
String	szDescription
String	szdestination
String	szSupplier
String	szCompany
String	szTemp
String	szName1
String	szName2
String	szName3
String	szAddress1, szAddress2, szAddress3
String	szNumberofLabels
String	szTime,szTimes
String	ls_Label
Time	tTime

//	Initialization
lSerial = il_serial

//	Get data from object table for that serial
select	object.part, object.lot, object.location, object.last_date, object.unit_measure,   
	object.operator, object.quantity, object.last_time
into	:szpart, :szlot, :szloc, :dt_date_time,	:szunit, 
	:szoperator, :dquantity, :dt_date_time 
from	object  
where	object.serial = :lserial;

if al_ordercount <= 0 then 
	//	Reassign value to the structure
	//	value1, 2 and 11 stays the same
	//	value12 should get the new box label
	stparm.value12 = 'RAWWIPFINBTW'
	//	Call f_print routine
	f_print_label ( stparm ) 		

else
	//	Get order info
	ll_orderno	= dw_listoforders.object.order_no [ il_clickedrow ]
	ls_label	= dw_listoforders.object.boxlabel [ il_clickedrow ]
	
	//	Update order no in object
	update object set custom4 = :ll_orderno where serial = :il_serial;
	commit;
	
	//	Reassign value to the structure
	//	value1, 2 and 11 stays the same
	//	value12 should get the new box label
	stparm.value12 = ls_label
	//	Call f_print routine
	f_print_label ( stparm ) 		
end if 
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
integer x = 59
integer y = 152
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

