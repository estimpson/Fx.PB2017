$PBExportHeader$w_detail_info_of_demand_parm.srw
forward
global type w_detail_info_of_demand_parm from w_sheet_4t
end type
type cbx_1 from checkbox within w_detail_info_of_demand_parm
end type
type dw_workorder from datawindow within w_detail_info_of_demand_parm
end type
type sle_hint from singlelineedit within w_detail_info_of_demand_parm
end type
type dw_history from datawindow within w_detail_info_of_demand_parm
end type
type p_2 from picture within w_detail_info_of_demand_parm
end type
type st_15 from statictext within w_detail_info_of_demand_parm
end type
type p_1 from picture within w_detail_info_of_demand_parm
end type
type st_14 from statictext within w_detail_info_of_demand_parm
end type
type sle_price from singlelineedit within w_detail_info_of_demand_parm
end type
type st_13 from statictext within w_detail_info_of_demand_parm
end type
type sle_type from singlelineedit within w_detail_info_of_demand_parm
end type
type st_12 from statictext within w_detail_info_of_demand_parm
end type
type sle_available from singlelineedit within w_detail_info_of_demand_parm
end type
type st_allocate from statictext within w_detail_info_of_demand_parm
end type
type st_10 from statictext within w_detail_info_of_demand_parm
end type
type sle_schedule from singlelineedit within w_detail_info_of_demand_parm
end type
type st_hard_queue from statictext within w_detail_info_of_demand_parm
end type
type sle_onhand from singlelineedit within w_detail_info_of_demand_parm
end type
type dw_objects from datawindow within w_detail_info_of_demand_parm
end type
type sle_history from singlelineedit within w_detail_info_of_demand_parm
end type
type sle_allocated from singlelineedit within w_detail_info_of_demand_parm
end type
type sle_committed from singlelineedit within w_detail_info_of_demand_parm
end type
type st_history from statictext within w_detail_info_of_demand_parm
end type
type st_7 from statictext within w_detail_info_of_demand_parm
end type
type st_6 from statictext within w_detail_info_of_demand_parm
end type
type st_5 from statictext within w_detail_info_of_demand_parm
end type
type sle_package from singlelineedit within w_detail_info_of_demand_parm
end type
type st_4 from statictext within w_detail_info_of_demand_parm
end type
type sle_um from singlelineedit within w_detail_info_of_demand_parm
end type
type st_3 from statictext within w_detail_info_of_demand_parm
end type
type sle_name from singlelineedit within w_detail_info_of_demand_parm
end type
type sle_part from singlelineedit within w_detail_info_of_demand_parm
end type
type st_2 from statictext within w_detail_info_of_demand_parm
end type
type st_1 from statictext within w_detail_info_of_demand_parm
end type
type gb_2 from groupbox within w_detail_info_of_demand_parm
end type
type gb_1 from groupbox within w_detail_info_of_demand_parm
end type
type r_1 from rectangle within w_detail_info_of_demand_parm
end type
type r_2 from rectangle within w_detail_info_of_demand_parm
end type
type r_3 from rectangle within w_detail_info_of_demand_parm
end type
type r_4 from rectangle within w_detail_info_of_demand_parm
end type
type r_5 from rectangle within w_detail_info_of_demand_parm
end type
type r_6 from rectangle within w_detail_info_of_demand_parm
end type
end forward

global type w_detail_info_of_demand_parm from w_sheet_4t
integer x = 214
integer y = 221
integer height = 1560
string title = "Quick Demand Entry"
string menuname = "m_availability_menu"
cbx_1 cbx_1
dw_workorder dw_workorder
sle_hint sle_hint
dw_history dw_history
p_2 p_2
st_15 st_15
p_1 p_1
st_14 st_14
sle_price sle_price
st_13 st_13
sle_type sle_type
st_12 st_12
sle_available sle_available
st_allocate st_allocate
st_10 st_10
sle_schedule sle_schedule
st_hard_queue st_hard_queue
sle_onhand sle_onhand
dw_objects dw_objects
sle_history sle_history
sle_allocated sle_allocated
sle_committed sle_committed
st_history st_history
st_7 st_7
st_6 st_6
st_5 st_5
sle_package sle_package
st_4 st_4
sle_um sle_um
st_3 st_3
sle_name sle_name
sle_part sle_part
st_2 st_2
st_1 st_1
gb_2 gb_2
gb_1 gb_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
r_6 r_6
end type
global w_detail_info_of_demand_parm w_detail_info_of_demand_parm

type variables
String szPart
String szCustomer
String szDestination
String szPlant

Dec dQty

Long  iSalesOrder
Long  iReleaseRow

Boolean bChanged = FALSE
Boolean bAllocate  = FALSE
Boolean bAvailable = FALSE
Boolean bDemand   = FALSE

Rectangle rBlock[]

Integer iBlockNo = 5
end variables

forward prototypes
public function string wf_get_shipping_um (long isalesorder)
public function string wf_get_package_type (long isalesorder)
public function decimal wf_get_accum (long isalesorder)
public function string wf_get_customer (long isalesorder)
public subroutine wf_commit_serial (long iserial)
public subroutine wf_uncommit_serial (long iserial)
public function string wf_get_destination (long isalesorder)
public function decimal wf_calc_qty_allocated (string szcustomer)
public function decimal wf_calc_committed (long isalesorder)
public function decimal wf_get_price (long isalesorder)
public subroutine wf_reset_blocks ()
public subroutine wf_show_hint (int iCount)
public function decimal wf_get_qty_in_hard_queue (string szpart)
public subroutine wf_change_cop_flag (long iorder)
end prototypes

public function string wf_get_shipping_um (long isalesorder);String szShippingUnit

  SELECT order_header.shipping_unit  
    INTO :szShippingUnit  
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

Return szShippingUnit

end function

public function string wf_get_package_type (long isalesorder);String	szPackageType

  SELECT order_header.package_type  
    INTO :szPackageType  
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;


Return szPackageType
end function

public function decimal wf_get_accum (long isalesorder);Decimal	nOurCum

  SELECT order_header.our_cum  
    INTO :nOurCum
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

Return nOurCum
end function

public function string wf_get_customer (long isalesorder);String szCustomer

SELECT order_header.customer  
  INTO :szCustomer  
  FROM order_header  
 WHERE order_header.order_no = :iSalesOrder   ;

Return szCustomer

end function

public subroutine wf_commit_serial (long iserial);UPDATE object  
   SET destination = :szCustomer  
WHERE serial = :iSerial   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_uncommit_serial (long iserial);String szCustomer

SetNull(szCustomer)

UPDATE object  
   SET destination = :szCustomer  
WHERE serial = :iSerial   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public function string wf_get_destination (long isalesorder);String szDestination

SELECT order_header.destination  
  INTO :szDestination
  FROM order_header  
 WHERE order_header.order_no = :iSalesOrder   ;

Return szDestination

end function

public function decimal wf_calc_qty_allocated (string szcustomer);Decimal nAllocated

  SELECT sum(object.std_quantity )  
    INTO :nAllocated 
    FROM object  
   WHERE object.destination = :szCustomer AND
			object.part = :szPart  ;

Return f_get_value(nAllocated)
end function

public function decimal wf_calc_committed (long isalesorder);Decimal nDemand

SELECT  sum(order_detail.std_qty)  
  INTO :nDemand  
  FROM  order_detail 
  WHERE order_detail.part_number = :szPart   ;

Return f_get_value(nDemand)
end function

public function decimal wf_get_price (long isalesorder);Decimal	nPrice

SELECT order_header.price  
  INTO :nPrice
  FROM order_header  
 WHERE order_header.order_no = :iSalesOrder   ;

Return nPrice

end function

public subroutine wf_reset_blocks ();rBlock[1]	= r_1
rBlock[2]	= r_2
rBlock[3]	= r_3
rBlock[4]	= r_4
rBlock[5]	= r_5


end subroutine

public subroutine wf_show_hint (int iCount);sle_hint.x	= rBlock[iCount].x

CHOOSE CASE iCount
	CASE 1
		sle_hint.text	= "OnHand quantity for part"
	Case 2
		sle_hint.text	= "Demand in current order"
	Case 3
		sle_hint.text	= "Total qty allocated to the customer"
	Case 4
		sle_hint.text	= "Our shipping accum"
	Case 5
		sle_hint.text	= "Total qty in current production"
END CHOOSE

end subroutine

public function decimal wf_get_qty_in_hard_queue (string szpart);Decimal nQty

If f_get_part_info(szPart, "CLASS") = 'P' then //Purchased items
	SELECT sum(po_detail.standard_qty)  
   INTO :nQty  
   FROM po_detail  
   WHERE po_detail.part_number 	= :szPart  AND
			po_detail.status 			= 'A' ;
Else

  SELECT sum(workorder_detail.qty_required - workorder_detail.qty_completed )  
    INTO :nQty  
    FROM workorder_detail  
   WHERE workorder_detail.part = :szPart   ;

End If

Return f_get_value(nQty)

end function

public subroutine wf_change_cop_flag (long iorder);UPDATE order_detail  
   SET flag = 2  
 WHERE ( order_no = :iOrder ) AND  
       ( flag = 1 )   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

event close;call super::close;UPDATE order_detail  
   SET flag = 1  
 WHERE ( order_no = :iSalesOrder ) AND  
       ( flag = 2 )   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end event

event open;call super::open;Decimal					nCommitted
st_generic_structure stParm

stParm = Message.PowerObjectParm

wf_reset_blocks ( )

dw_objects.SetTransObject ( sqlca )
dw_history.SetTransObject ( sqlca )
dw_workorder.SetTransObject ( sqlca )

dw_objects.Modify("object_serial.color = '0~t if(IsNull(object_destination) , 0, 255)'")

szPart			= stParm.Value1
iSalesOrder		= Long ( stParm.Value2 )

this.Title		= "Quick Data Entry for Sales Order:" + String(iSalesOrder)

sle_part.text		= szPart
sle_name.text		= f_get_part_info(szPart, "NAME")
sle_um.text			= stParm.Value3
sle_package.text	= wf_get_package_type(iSalesOrder)
sle_history.text	= String(wf_get_accum(iSalesOrder))
sle_onhand.text	= f_get_part_info(szPart, "ON HAND")
sle_type.text		= f_get_part_info(szPart, "CLASS")

If sle_type.text			= "M" then
	sle_type.text			= "Manufactured"
Else
	sle_type.text			= "Purchased"
	st_hard_queue.text	= "Qty in P.O."
	dw_workorder.DataObject = 'dw_list_qty_in_po_per_part'
	dw_workorder.Title		= 'Quantity on P.O. Order'
	dw_workorder.SetTransObject(sqlca)
End If
sle_price.text		= "$" + String ( f_get_value ( wf_get_price ( iSalesOrder ) ) )

sle_schedule.text	= String(wf_get_qty_in_hard_queue(szPart))


dw_objects.Retrieve(szPart)
dw_history.Retrieve(iSalesOrder)
dw_workorder.Retrieve(szPart)

szDestination			= wf_get_destination(iSalesOrder)
szCustomer				= wf_get_customer(iSalesOrder)
sle_committed.text	= String(wf_calc_committed(iSalesOrder))
sle_allocated.text	= String(wf_calc_qty_allocated(szCustomer))
sle_available.text	= String(Dec(sle_onhand.text) - Dec(sle_allocated.text))

bChanged					= FALSE

end event

on w_detail_info_of_demand_parm.create
int iCurrent
call super::create
if this.MenuName = "m_availability_menu" then this.MenuID = create m_availability_menu
this.cbx_1=create cbx_1
this.dw_workorder=create dw_workorder
this.sle_hint=create sle_hint
this.dw_history=create dw_history
this.p_2=create p_2
this.st_15=create st_15
this.p_1=create p_1
this.st_14=create st_14
this.sle_price=create sle_price
this.st_13=create st_13
this.sle_type=create sle_type
this.st_12=create st_12
this.sle_available=create sle_available
this.st_allocate=create st_allocate
this.st_10=create st_10
this.sle_schedule=create sle_schedule
this.st_hard_queue=create st_hard_queue
this.sle_onhand=create sle_onhand
this.dw_objects=create dw_objects
this.sle_history=create sle_history
this.sle_allocated=create sle_allocated
this.sle_committed=create sle_committed
this.st_history=create st_history
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.sle_package=create sle_package
this.st_4=create st_4
this.sle_um=create sle_um
this.st_3=create st_3
this.sle_name=create sle_name
this.sle_part=create sle_part
this.st_2=create st_2
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.r_6=create r_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.dw_workorder
this.Control[iCurrent+3]=this.sle_hint
this.Control[iCurrent+4]=this.dw_history
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.st_15
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.st_14
this.Control[iCurrent+9]=this.sle_price
this.Control[iCurrent+10]=this.st_13
this.Control[iCurrent+11]=this.sle_type
this.Control[iCurrent+12]=this.st_12
this.Control[iCurrent+13]=this.sle_available
this.Control[iCurrent+14]=this.st_allocate
this.Control[iCurrent+15]=this.st_10
this.Control[iCurrent+16]=this.sle_schedule
this.Control[iCurrent+17]=this.st_hard_queue
this.Control[iCurrent+18]=this.sle_onhand
this.Control[iCurrent+19]=this.dw_objects
this.Control[iCurrent+20]=this.sle_history
this.Control[iCurrent+21]=this.sle_allocated
this.Control[iCurrent+22]=this.sle_committed
this.Control[iCurrent+23]=this.st_history
this.Control[iCurrent+24]=this.st_7
this.Control[iCurrent+25]=this.st_6
this.Control[iCurrent+26]=this.st_5
this.Control[iCurrent+27]=this.sle_package
this.Control[iCurrent+28]=this.st_4
this.Control[iCurrent+29]=this.sle_um
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.sle_name
this.Control[iCurrent+32]=this.sle_part
this.Control[iCurrent+33]=this.st_2
this.Control[iCurrent+34]=this.st_1
this.Control[iCurrent+35]=this.gb_2
this.Control[iCurrent+36]=this.gb_1
this.Control[iCurrent+37]=this.r_1
this.Control[iCurrent+38]=this.r_2
this.Control[iCurrent+39]=this.r_3
this.Control[iCurrent+40]=this.r_4
this.Control[iCurrent+41]=this.r_5
this.Control[iCurrent+42]=this.r_6
end on

on w_detail_info_of_demand_parm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_1)
destroy(this.dw_workorder)
destroy(this.sle_hint)
destroy(this.dw_history)
destroy(this.p_2)
destroy(this.st_15)
destroy(this.p_1)
destroy(this.st_14)
destroy(this.sle_price)
destroy(this.st_13)
destroy(this.sle_type)
destroy(this.st_12)
destroy(this.sle_available)
destroy(this.st_allocate)
destroy(this.st_10)
destroy(this.sle_schedule)
destroy(this.st_hard_queue)
destroy(this.sle_onhand)
destroy(this.dw_objects)
destroy(this.sle_history)
destroy(this.sle_allocated)
destroy(this.sle_committed)
destroy(this.st_history)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_package)
destroy(this.st_4)
destroy(this.sle_um)
destroy(this.st_3)
destroy(this.sle_name)
destroy(this.sle_part)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.r_6)
end on

type cbx_1 from checkbox within w_detail_info_of_demand_parm
integer x = 37
integer y = 1360
integer width = 677
integer height = 64
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Group objects by plant"
end type

on clicked;If this.checked then
	dw_objects.DataObject	= "dw_objects_per_part_group_by_plant"
Else
	dw_objects.DataObject	= "dw_objects_per_part_group_by_location"
End If

dw_objects.SetTransObject(sqlca)
dw_objects.Modify("object_serial.color = '0~t if(IsNull(object_destination) , 0, 255)'")
dw_objects.Retrieve(szPart)
end on

type dw_workorder from datawindow within w_detail_info_of_demand_parm
boolean visible = false
integer x = 439
integer y = 512
integer width = 2359
integer height = 592
integer taborder = 100
boolean titlebar = true
string title = "Assigned Jobs for current demand"
string dataobject = "dw_workorder_info_per_salesorder"
boolean vscrollbar = true
boolean livescroll = true
end type

type sle_hint from singlelineedit within w_detail_info_of_demand_parm
boolean visible = false
integer x = 439
integer y = 496
integer width = 731
integer height = 64
integer taborder = 180
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean autohscroll = false
end type

type dw_history from datawindow within w_detail_info_of_demand_parm
boolean visible = false
integer x = 439
integer y = 512
integer width = 2359
integer height = 528
integer taborder = 90
boolean titlebar = true
string title = "Shipping History"
string dataobject = "dw_shipping_history"
boolean vscrollbar = true
boolean livescroll = true
end type

type p_2 from picture within w_detail_info_of_demand_parm
integer x = 37
integer y = 864
integer width = 55
integer height = 48
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_15 from statictext within w_detail_info_of_demand_parm
integer x = 91
integer y = 864
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Objects"
boolean focusrectangle = false
end type

type p_1 from picture within w_detail_info_of_demand_parm
integer x = 37
integer y = 192
integer width = 55
integer height = 48
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_14 from statictext within w_detail_info_of_demand_parm
integer x = 91
integer y = 160
integer width = 146
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Part Info"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_price from singlelineedit within w_detail_info_of_demand_parm
integer x = 2469
integer y = 144
integer width = 402
integer height = 80
integer taborder = 170
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within w_detail_info_of_demand_parm
integer x = 2322
integer y = 160
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Price"
boolean focusrectangle = false
end type

type sle_type from singlelineedit within w_detail_info_of_demand_parm
integer x = 2469
integer y = 32
integer width = 402
integer height = 80
integer taborder = 150
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within w_detail_info_of_demand_parm
integer x = 2322
integer y = 48
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Type"
boolean focusrectangle = false
end type

type sle_available from singlelineedit within w_detail_info_of_demand_parm
integer x = 1646
integer y = 384
integer width = 329
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_allocate from statictext within w_detail_info_of_demand_parm
integer x = 1225
integer y = 288
integer width = 293
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 8421504
string text = "Allocated"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;bAllocate	= (Not bAllocate)

If bAllocate then
	dw_objects.SetFilter("object_destination = '" + szCustomer + "'")
Else
	dw_objects.SetFilter("object_serial > 0")
End If

dw_objects.Filter()


end on

type st_10 from statictext within w_detail_info_of_demand_parm
integer x = 786
integer y = 272
integer width = 297
integer height = 52
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
string text = "Demand"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;bDemand	 = (Not bDemand)

If bDemand then		//If view demand
	OpenWithParm(w_view_release_detail, szPart)
End If
end on

type sle_schedule from singlelineedit within w_detail_info_of_demand_parm
integer x = 2523
integer y = 384
integer width = 347
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_hard_queue from statictext within w_detail_info_of_demand_parm
integer x = 2542
integer y = 288
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
string text = "Hard Queue"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;dw_workorder.visible	= (Not dw_workorder.visible)

If dw_workorder.visible then
	dw_history.visible	= FALSE
End If
end on

type sle_onhand from singlelineedit within w_detail_info_of_demand_parm
integer x = 329
integer y = 384
integer width = 329
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_objects from datawindow within w_detail_info_of_demand_parm
integer x = 329
integer y = 512
integer width = 2542
integer height = 832
integer taborder = 80
string dataobject = "dw_objects_per_part_group_by_location_pm"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on itemchanged;If iReleaseRow > 0 then
	bChanged = TRUE
	this.SetItem(iReleaseRow, "flag", 1)
End If
end on

on doubleclicked;Long iRow
Long iSerial

iRow	= this.GetClickedRow()

this.SelectRow(0, FALSE)

If iRow > 0 then
	this.SelectRow(iRow, TRUE)
	iSerial	= this.GetItemNumber(iRow, "object_serial")
	If this.GetItemString(iRow, "object_destination") = szCustomer then
		wf_uncommit_serial(iSerial)
	Else
		wf_commit_serial(iSerial)
	End If
End If

this.Retrieve(szPart)
sle_committed.text= String(wf_calc_committed(iSalesOrder))
sle_allocated.text= String(wf_calc_qty_allocated(szCustomer))
sle_available.text= String(Dec(sle_onhand.text) - Dec(sle_allocated.text))


end on

on clicked;iReleaseRow	= this.GetClickedRow()

end on

type sle_history from singlelineedit within w_detail_info_of_demand_parm
integer x = 2085
integer y = 384
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_allocated from singlelineedit within w_detail_info_of_demand_parm
integer x = 1207
integer y = 384
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_committed from singlelineedit within w_detail_info_of_demand_parm
integer x = 768
integer y = 384
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_history from statictext within w_detail_info_of_demand_parm
integer x = 2085
integer y = 288
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
string text = "Ship History"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;dw_history.visible	= (Not dw_history.visible)

If dw_history.visible	= TRUE then
	dw_workorder.visible	= FALSE
End If
end on

type st_7 from statictext within w_detail_info_of_demand_parm
integer x = 1682
integer y = 288
integer width = 293
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
string text = "Available"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;bAvailable= (Not bAvailable)

If bAvailable then
	dw_objects.SetFilter("IsNull(object_destination)")
Else
	dw_objects.SetFilter("object_serial > 0")
End If

dw_objects.Filter()

end on

type st_6 from statictext within w_detail_info_of_demand_parm
integer x = 786
integer y = 320
integer width = 297
integer height = 52
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
boolean enabled = false
string text = "Committed"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_detail_info_of_demand_parm
integer x = 366
integer y = 288
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421504
boolean enabled = false
string text = "On Hand"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_package from singlelineedit within w_detail_info_of_demand_parm
integer x = 1481
integer y = 144
integer width = 731
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_detail_info_of_demand_parm
integer x = 1207
integer y = 160
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Package"
boolean focusrectangle = false
end type

type sle_um from singlelineedit within w_detail_info_of_demand_parm
integer x = 530
integer y = 144
integer width = 562
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_detail_info_of_demand_parm
integer x = 329
integer y = 160
integer width = 178
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "UM"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_detail_info_of_demand_parm
integer x = 1481
integer y = 32
integer width = 731
integer height = 80
integer taborder = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_part from singlelineedit within w_detail_info_of_demand_parm
integer x = 530
integer y = 32
integer width = 562
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_detail_info_of_demand_parm
integer x = 1207
integer y = 48
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Name"
boolean focusrectangle = false
end type

type st_1 from statictext within w_detail_info_of_demand_parm
integer x = 329
integer y = 48
integer width = 178
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Part"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_detail_info_of_demand_parm
integer x = 18
integer y = 480
integer width = 293
integer height = 864
integer taborder = 110
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_detail_info_of_demand_parm
integer x = 18
integer width = 293
integer height = 480
integer taborder = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type r_1 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 329
integer y = 256
integer width = 329
integer height = 128
end type

type r_2 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 768
integer y = 256
integer width = 329
integer height = 128
end type

type r_3 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 1646
integer y = 256
integer width = 329
integer height = 128
end type

type r_4 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 2085
integer y = 256
integer width = 329
integer height = 128
end type

type r_5 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 2523
integer y = 256
integer width = 347
integer height = 128
end type

type r_6 from rectangle within w_detail_info_of_demand_parm
long linecolor = 8421504
integer linethickness = 5
long fillcolor = 8421504
integer x = 1207
integer y = 256
integer width = 329
integer height = 128
end type

