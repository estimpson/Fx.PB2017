$PBExportHeader$w_detail_info_of_demand.srw
forward
global type w_detail_info_of_demand from window
end type
type st_9 from statictext within w_detail_info_of_demand
end type
type st_8 from statictext within w_detail_info_of_demand
end type
type sle_customer_part from singlelineedit within w_detail_info_of_demand
end type
type cb_onhand from commandbutton within w_detail_info_of_demand
end type
type dw_demand_committed from datawindow within w_detail_info_of_demand
end type
type cb_hardqueue from commandbutton within w_detail_info_of_demand
end type
type cb_shipper from commandbutton within w_detail_info_of_demand
end type
type cb_available from commandbutton within w_detail_info_of_demand
end type
type cb_allocate from commandbutton within w_detail_info_of_demand
end type
type cb_demand from commandbutton within w_detail_info_of_demand
end type
type cbx_group from checkbox within w_detail_info_of_demand
end type
type cb_delete from commandbutton within w_detail_info_of_demand
end type
type cb_add from commandbutton within w_detail_info_of_demand
end type
type cb_save from commandbutton within w_detail_info_of_demand
end type
type p_3 from picture within w_detail_info_of_demand
end type
type st_16 from statictext within w_detail_info_of_demand
end type
type p_2 from picture within w_detail_info_of_demand
end type
type st_15 from statictext within w_detail_info_of_demand
end type
type p_1 from picture within w_detail_info_of_demand
end type
type st_14 from statictext within w_detail_info_of_demand
end type
type dw_order_detail from datawindow within w_detail_info_of_demand
end type
type sle_price from singlelineedit within w_detail_info_of_demand
end type
type st_13 from statictext within w_detail_info_of_demand
end type
type sle_type from singlelineedit within w_detail_info_of_demand
end type
type st_12 from statictext within w_detail_info_of_demand
end type
type sle_available from singlelineedit within w_detail_info_of_demand
end type
type st_allocate from statictext within w_detail_info_of_demand
end type
type st_10 from statictext within w_detail_info_of_demand
end type
type sle_schedule from singlelineedit within w_detail_info_of_demand
end type
type st_hard_queue from statictext within w_detail_info_of_demand
end type
type cb_exit from commandbutton within w_detail_info_of_demand
end type
type sle_onhand from singlelineedit within w_detail_info_of_demand
end type
type sle_history from singlelineedit within w_detail_info_of_demand
end type
type sle_allocated from singlelineedit within w_detail_info_of_demand
end type
type sle_committed from singlelineedit within w_detail_info_of_demand
end type
type st_history from statictext within w_detail_info_of_demand
end type
type st_7 from statictext within w_detail_info_of_demand
end type
type st_6 from statictext within w_detail_info_of_demand
end type
type st_5 from statictext within w_detail_info_of_demand
end type
type sle_package from singlelineedit within w_detail_info_of_demand
end type
type st_4 from statictext within w_detail_info_of_demand
end type
type sle_um from singlelineedit within w_detail_info_of_demand
end type
type st_3 from statictext within w_detail_info_of_demand
end type
type sle_name from singlelineedit within w_detail_info_of_demand
end type
type sle_part from singlelineedit within w_detail_info_of_demand
end type
type st_2 from statictext within w_detail_info_of_demand
end type
type st_1 from statictext within w_detail_info_of_demand
end type
type sle_hint from singlelineedit within w_detail_info_of_demand
end type
type dw_workorder from datawindow within w_detail_info_of_demand
end type
type dw_history from datawindow within w_detail_info_of_demand
end type
type dw_objects from datawindow within w_detail_info_of_demand
end type
type gb_3 from groupbox within w_detail_info_of_demand
end type
type gb_2 from groupbox within w_detail_info_of_demand
end type
type gb_1 from groupbox within w_detail_info_of_demand
end type
type r_1 from rectangle within w_detail_info_of_demand
end type
type r_2 from rectangle within w_detail_info_of_demand
end type
type r_3 from rectangle within w_detail_info_of_demand
end type
type r_4 from rectangle within w_detail_info_of_demand
end type
type r_5 from rectangle within w_detail_info_of_demand
end type
type r_6 from rectangle within w_detail_info_of_demand
end type
end forward

global type w_detail_info_of_demand from window
integer width = 3086
integer height = 1944
boolean titlebar = true
string title = "Quick Demand Entry"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 80269524
st_9 st_9
st_8 st_8
sle_customer_part sle_customer_part
cb_onhand cb_onhand
dw_demand_committed dw_demand_committed
cb_hardqueue cb_hardqueue
cb_shipper cb_shipper
cb_available cb_available
cb_allocate cb_allocate
cb_demand cb_demand
cbx_group cbx_group
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
p_3 p_3
st_16 st_16
p_2 p_2
st_15 st_15
p_1 p_1
st_14 st_14
dw_order_detail dw_order_detail
sle_price sle_price
st_13 st_13
sle_type sle_type
st_12 st_12
sle_available sle_available
st_allocate st_allocate
st_10 st_10
sle_schedule sle_schedule
st_hard_queue st_hard_queue
cb_exit cb_exit
sle_onhand sle_onhand
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
sle_hint sle_hint
dw_workorder dw_workorder
dw_history dw_history
dw_objects dw_objects
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
r_6 r_6
end type
global w_detail_info_of_demand w_detail_info_of_demand

type variables
String szPart
String szCustomer
String szDestination
String szPlant
String szUM

Long  iSalesOrder
Long  iReleaseRow
long	il_maxrowid 
Boolean ib_Changed	= FALSE
Boolean bAllocate  		= FALSE
Boolean bAvailable 	= FALSE
Boolean bDemand   	= FALSE
Boolean bShipper		= FALSE
Boolean bHardQueue 	= FALSE
Boolean bOnHand		= TRUE

Rectangle rBlock[]

Integer iBlockNo = 5
String	is_releasetype='N'

w_global_shipping_version2 gssWindow
end variables

forward prototypes
public subroutine wf_commit_serial (long iserial)
public subroutine wf_uncommit_serial (long iserial)
public subroutine wf_reset_blocks ()
public subroutine wf_show_hint (int iCount)
public subroutine wf_change_cop_flag (long iorder)
public function boolean wf_need_to_explode ()
public subroutine wf_clear_mps ()
public subroutine wf_reset_week_no ()
public function decimal wf_get_qty_in_hard_queue (string as_part)
public function decimal wf_get_price (long al_salesorder)
public function decimal wf_calc_committed (long al_salesorder)
public function decimal wf_calc_qty_allocated (string as_customer)
public function string wf_get_destination (long al_salesorder)
public function string wf_get_customer (long al_salesorder)
public function decimal wf_get_accum (long al_salesorder)
public function string wf_get_package_type (long al_salesorder)
public function string wf_get_shipping_um (long al_salesorder)
end prototypes

public subroutine wf_commit_serial (long iserial);UPDATE object  
   SET destination = :szCustomer  
WHERE serial = :iSerial   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_uncommit_serial (long iserial);String ls_customer

SetNull(ls_customer)

UPDATE object  
   SET destination = :ls_customer  
WHERE serial = :iSerial   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

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

public function boolean wf_need_to_explode ();Long 		iRow
Long		iTotalRows

Boolean	bFound

iTotalRows	= dw_order_detail.RowCount()
iRow			= 1

bFound		= FALSE

Do while (Not bFound) AND (iRow <= iTotalRows)
	bFound	= (dw_order_detail.GetItemNumber(iRow, "flag") = 2)
	iRow ++
Loop

Return bFound
end function

public subroutine wf_clear_mps ();Long iRow
Long iTotalRows
Long iRowId

iTotalRows	= dw_order_detail.RowCount()

For iRow = 1 to iTotalRows

	If dw_order_detail.GetItemNumber(iRow, "flag") = 2 then

		iRowId 			= dw_order_detail.GetItemNumber(iRow, "row_id")

		Delete From master_prod_sched  
		Where ( origin = :iSalesOrder ) And
		  		( source = :iRowId )   ;

	End If

Next

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_reset_week_no ();Long iTotalRows
Long iRow

iTotalRows	= dw_order_detail.RowCount()

For iRow	= 1 to iTotalRows
	dw_order_detail.SetItem(iRow, "week_no", &
				f_get_week_no( date ( dw_order_detail.GetItemDatetime(iRow, 'due_date'))) )
Next

If dw_order_detail.Update() > 0 then
	Commit;
Else
	Rollback;
End If 


end subroutine

public function decimal wf_get_qty_in_hard_queue (string as_part);Decimal nQty

If f_get_part_info(as_part, "CLASS") = 'P' then //Purchased items
	SELECT sum(po_detail.standard_qty )  
   INTO :nQty  
   FROM po_detail  
   WHERE po_detail.part_number 	= :as_part  AND
			po_detail.status	 		= 'A' ;
Else

  SELECT sum(workorder_detail.qty_required - workorder_detail.qty_completed )  
    INTO :nQty  
    FROM workorder_detail  
   WHERE workorder_detail.part = :as_part   ;

End If

Return f_get_value(nQty)

end function

public function decimal wf_get_price (long al_salesorder);Decimal	lnPrice

SELECT order_header.price  
  INTO :lnPrice
  FROM order_header  
 WHERE order_header.order_no = :al_SalesOrder   ;

Return lnPrice

end function

public function decimal wf_calc_committed (long al_salesorder);Decimal lnDemand

SELECT 	sum(order_detail.std_qty)  
  INTO 	:lnDemand  
  FROM 	order_detail 
  WHERE	order_detail.part_number = :szPart   ;

Return f_get_value(lnDemand)
end function

public function decimal wf_calc_qty_allocated (string as_customer);Decimal nAllocated

  SELECT sum(object.std_quantity )  
    INTO :nAllocated 
    FROM object  
   WHERE object.destination = :as_Customer AND
			object.part = :szPart  ;

Return f_get_value(nAllocated)
end function

public function string wf_get_destination (long al_salesorder);String ls_Destination

SELECT order_header.destination,
	order_header.artificial_cum
  INTO :ls_Destination,
 	:is_releasetype 
  FROM order_header  
 WHERE order_header.order_no = :al_SalesOrder   ;

Return ls_Destination

end function

public function string wf_get_customer (long al_salesorder);String ls_customer

SELECT order_header.customer  
  INTO :ls_customer  
  FROM order_header  
 WHERE order_header.order_no = :al_SalesOrder   ;

Return ls_customer

end function

public function decimal wf_get_accum (long al_salesorder);Decimal	nOurCum

  SELECT order_header.our_cum  
    INTO :nOurCum
    FROM order_header  
   WHERE order_header.order_no = :al_SalesOrder   ;

Return nOurCum
end function

public function string wf_get_package_type (long al_salesorder);String	szPackageType

  SELECT order_header.package_type  
    INTO :szPackageType  
    FROM order_header  
   WHERE order_header.order_no = :al_SalesOrder   ;

Return szPackageType
end function

public function string wf_get_shipping_um (long al_salesorder);String szShippingUnit

  SELECT order_header.shipping_unit  
    INTO :szShippingUnit  
    FROM order_header  
   WHERE order_header.order_no = :al_SalesOrder   ;

Return szShippingUnit

end function

event open;
gssWindow = gnv_App.of_GetFrame().GetActiveSheet()

Decimal	nCommitted
String	szCustPart, &
         s_art_cum

wf_reset_blocks()

il_maxrowid = 0

dw_objects.SetTransObject(sqlca)
dw_history.SetTransObject(sqlca)
dw_workorder.SetTransObject(sqlca)
dw_demand_committed.SetTransObject(sqlca)

dw_objects.Modify("object_serial.color = '0~t if(IsNull(object_destination) , 0, 255)'")
dw_order_detail.SetTabOrder("our_cum",0)

szPart			= gssWindow.szPart

iSalesOrder		= gssWindow.iSalesOrder

SELECT	Order_detail.Customer_part,
	order_detail.unit
INTO	:szCustPart,
	:szum
FROM	Order_Detail
WHERE	order_detail.part_number = :szPart and
	order_detail.order_no =:isalesorder;
	
if sqlca.sqlcode <> 0 then 
	SELECT	Order_header.Customer_part,
		order_header.shipping_unit
	INTO	:szCustPart,
		:szum
	FROM	Order_header
	WHERE	order_header.blanket_part = :szPart and
		order_header.order_no =:isalesorder;
end if	

this.Title		= "Quick Data Entry for Sales Order:" + String(iSalesOrder)

sle_part.text		= szPart
sle_customer_part.text = szCustPart
sle_name.text		= f_get_part_info(szPart, "NAME")
sle_um.text		= szum //gssWindow.st_um.text
sle_package.text	= wf_get_package_type(iSalesOrder)
sle_history.text	= String(wf_get_accum(iSalesOrder))
sle_onhand.text	= f_get_part_info(szPart, "ON HAND")
sle_type.text		= f_get_part_info(szPart, "CLASS")
szPlant				= f_get_order_info(iSalesOrder, "PLANT")
//szUM					= f_get_order_info(iSalesOrder, "SHIPPING UNIT")

If sle_type.text			= "M" then
	sle_type.text			= "Manufactured"
Else
	sle_type.text			= "Purchased"
	st_hard_queue.text	= "Qty on Order"
	dw_workorder.DataObject = 'dw_list_qty_in_po_per_part'
	dw_workorder.Title		= 'Quantity on P.O. Order'
	dw_workorder.SetTransObject(sqlca)
End If
sle_price.text		= String(wf_get_price(iSalesOrder))

sle_schedule.text	= String(wf_get_qty_in_hard_queue(szPart))

wf_change_cop_flag(iSalesOrder)

szDestination			= wf_get_destination(iSalesOrder)

dw_objects.Retrieve(szPart)
dw_order_detail.Retrieve(iSalesOrder, is_releasetype)
dw_history.Retrieve(iSalesOrder)


szCustomer				= wf_get_customer(iSalesOrder)
sle_committed.text	= String(Truncate(wf_calc_committed(iSalesOrder), 2))
sle_allocated.text	= String(Truncate(wf_calc_qty_allocated(szCustomer), 2))
sle_available.text	= String(Dec(sle_onhand.text) - Dec(sle_allocated.text))

ib_Changed					= FALSE

end event

on close;UPDATE order_detail  
   SET flag = 1  
 WHERE ( order_no = :iSalesOrder ) AND  
       ( flag = 2 )   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end on

event timer;If bFinish then
	Timer(0)
	dw_order_detail.Retrieve(iSalesOrder, is_releasetype)
	bFinish	= FALSE
End If
end event

on w_detail_info_of_demand.create
this.st_9=create st_9
this.st_8=create st_8
this.sle_customer_part=create sle_customer_part
this.cb_onhand=create cb_onhand
this.dw_demand_committed=create dw_demand_committed
this.cb_hardqueue=create cb_hardqueue
this.cb_shipper=create cb_shipper
this.cb_available=create cb_available
this.cb_allocate=create cb_allocate
this.cb_demand=create cb_demand
this.cbx_group=create cbx_group
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.p_3=create p_3
this.st_16=create st_16
this.p_2=create p_2
this.st_15=create st_15
this.p_1=create p_1
this.st_14=create st_14
this.dw_order_detail=create dw_order_detail
this.sle_price=create sle_price
this.st_13=create st_13
this.sle_type=create sle_type
this.st_12=create st_12
this.sle_available=create sle_available
this.st_allocate=create st_allocate
this.st_10=create st_10
this.sle_schedule=create sle_schedule
this.st_hard_queue=create st_hard_queue
this.cb_exit=create cb_exit
this.sle_onhand=create sle_onhand
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
this.sle_hint=create sle_hint
this.dw_workorder=create dw_workorder
this.dw_history=create dw_history
this.dw_objects=create dw_objects
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.r_6=create r_6
this.Control[]={this.st_9,&
this.st_8,&
this.sle_customer_part,&
this.cb_onhand,&
this.dw_demand_committed,&
this.cb_hardqueue,&
this.cb_shipper,&
this.cb_available,&
this.cb_allocate,&
this.cb_demand,&
this.cbx_group,&
this.cb_delete,&
this.cb_add,&
this.cb_save,&
this.p_3,&
this.st_16,&
this.p_2,&
this.st_15,&
this.p_1,&
this.st_14,&
this.dw_order_detail,&
this.sle_price,&
this.st_13,&
this.sle_type,&
this.st_12,&
this.sle_available,&
this.st_allocate,&
this.st_10,&
this.sle_schedule,&
this.st_hard_queue,&
this.cb_exit,&
this.sle_onhand,&
this.sle_history,&
this.sle_allocated,&
this.sle_committed,&
this.st_history,&
this.st_7,&
this.st_6,&
this.st_5,&
this.sle_package,&
this.st_4,&
this.sle_um,&
this.st_3,&
this.sle_name,&
this.sle_part,&
this.st_2,&
this.st_1,&
this.sle_hint,&
this.dw_workorder,&
this.dw_history,&
this.dw_objects,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.r_1,&
this.r_2,&
this.r_3,&
this.r_4,&
this.r_5,&
this.r_6}
end on

on w_detail_info_of_demand.destroy
destroy(this.st_9)
destroy(this.st_8)
destroy(this.sle_customer_part)
destroy(this.cb_onhand)
destroy(this.dw_demand_committed)
destroy(this.cb_hardqueue)
destroy(this.cb_shipper)
destroy(this.cb_available)
destroy(this.cb_allocate)
destroy(this.cb_demand)
destroy(this.cbx_group)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.p_3)
destroy(this.st_16)
destroy(this.p_2)
destroy(this.st_15)
destroy(this.p_1)
destroy(this.st_14)
destroy(this.dw_order_detail)
destroy(this.sle_price)
destroy(this.st_13)
destroy(this.sle_type)
destroy(this.st_12)
destroy(this.sle_available)
destroy(this.st_allocate)
destroy(this.st_10)
destroy(this.sle_schedule)
destroy(this.st_hard_queue)
destroy(this.cb_exit)
destroy(this.sle_onhand)
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
destroy(this.sle_hint)
destroy(this.dw_workorder)
destroy(this.dw_history)
destroy(this.dw_objects)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.r_6)
end on

type st_9 from statictext within w_detail_info_of_demand
integer x = 425
integer y = 184
integer width = 110
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Part"
boolean focusrectangle = false
end type

type st_8 from statictext within w_detail_info_of_demand
integer x = 411
integer y = 132
integer width = 265
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Customer"
boolean focusrectangle = false
end type

type sle_customer_part from singlelineedit within w_detail_info_of_demand
integer x = 690
integer y = 152
integer width = 571
integer height = 84
integer taborder = 250
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_onhand from commandbutton within w_detail_info_of_demand
integer x = 709
integer y = 256
integer width = 55
integer height = 48
integer taborder = 310
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;If cbx_group.checked then
	dw_objects.DataObject				= "dw_objects_per_part_group_by_plant"
Else
	dw_objects.DataObject				= "dw_objects_per_part_group_by_location"
End If
dw_objects.SetTransObject(sqlca)
dw_objects.Modify("object_serial.color = '0~t if(IsNull(object_destination) , 0, 255)'")
dw_objects.Retrieve(szPart)
dw_objects.visible	= TRUE
dw_objects.BringToTop= TRUE
dw_objects.Title		= "List of Objects (On Hand)"

bDemand		= FALSE
bShipper		= FALSE
bAllocate	= FALSE
bAvailable	= FALSE
bHardQueue	= FALSE
bOnHand		= TRUE

dw_objects.SetFilter("object_serial > 0")
dw_objects.Filter()
end event

type dw_demand_committed from datawindow within w_detail_info_of_demand
boolean visible = false
integer x = 434
integer y = 512
integer width = 2359
integer height = 588
integer taborder = 90
boolean titlebar = true
string title = "List of demand in order detail"
string dataobject = "dw_view_releases_by_part"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_hardqueue from commandbutton within w_detail_info_of_demand
integer x = 2743
integer y = 256
integer width = 55
integer height = 48
integer taborder = 300
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

on clicked;If sle_type.text= 'Purchased' then
	If cbx_group.checked then
		dw_workorder.dataObject			= "dw_list_qty_in_po_per_part_group_plant"
	Else
		dw_workorder.dataObject			= "dw_list_qty_in_po_per_part"
	End If
End If

dw_workorder.visible		= TRUE
dw_workorder.SetTransObject(sqlca)
dw_workorder.Retrieve(szPart)
dw_workorder.BringToTop	= TRUE
bShipper		= FALSE
bAvailable	= FALSE
bAllocate	= FALSE
bDemand		= FALSE
bHardQueue	= TRUE
bOnHand		= FALSE

end on

type cb_shipper from commandbutton within w_detail_info_of_demand
integer x = 2322
integer y = 256
integer width = 55
integer height = 48
integer taborder = 290
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

on clicked;dw_history.visible		= TRUE
dw_history.bringtotop	= TRUE
cbx_group.checked			= FALSE

bDemand		= FALSE
bAllocate	= FALSE
bHardQueue	= FALSE
bAvailable	= FALSE
bShipper		= TRUE
bOnHand		= FALSE

end on

type cb_available from commandbutton within w_detail_info_of_demand
integer x = 1920
integer y = 256
integer width = 55
integer height = 48
integer taborder = 280
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

on clicked;dw_objects.Title			= "List of Objects (Available)"
dw_objects.BringToTop	= true
dw_objects.SetFilter("IsNull(object_destination)")
dw_objects.Visible		= true
cbx_group.checked			= FALSE

bDemand		= FALSE
bAllocate	= FALSE
bShipper		= FALSE
bHardQueue	= FALSE
bAvailable	= TRUE
bOnHand		= FALSE


dw_objects.Filter()

end on

type cb_allocate from commandbutton within w_detail_info_of_demand
integer x = 1518
integer y = 256
integer width = 55
integer height = 48
integer taborder = 270
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

on clicked;dw_objects.SetFilter("object_destination = '" + szCustomer + "'")
dw_objects.Title		= "List of Objects (Allocated)"
bAvailable	= FALSE
bDemand		= FALSE
bShipper		= FALSE
bHardQueue	= FALSE
bAllocate	= TRUE
bOnHand		= FALSE
dw_objects.Filter()
dw_objects.visible	=  TRUE
dw_objects.BringToTop=	TRUE
cbx_group.checked		= 	FALSE


end on

type cb_demand from commandbutton within w_detail_info_of_demand
integer x = 1115
integer y = 256
integer width = 55
integer height = 48
integer taborder = 260
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

on clicked;If cbx_group.checked then		
	dw_demand_committed.DataObject	= "dw_view_releases_by_part_group_by_plant"
Else
	dw_demand_committed.DataObject	= "dw_view_releases_by_part"
End If

dw_demand_committed.Title	= "List of demand in order detail"
dw_demand_committed.SetTransObject(sqlca)
dw_demand_committed.Retrieve(szPart)
dw_demand_committed.visible	= TRUE
dw_demand_committed.BringToTop= TRUE
bAvailable	= FALSE
bAllocate	= FALSE
bShipper		= FALSE
bHardQueue	= FALSE
bDemand		= TRUE
bOnHand		= FALSE

end on

type cbx_group from checkbox within w_detail_info_of_demand
integer x = 96
integer y = 1696
integer width = 485
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Group by plant"
end type

event clicked;Boolean bSelection


If bOnHand or bHardQueue or bDemand then

	If bOnHand then
		If this.checked then
			dw_objects.DataObject				= "dw_objects_per_part_group_by_plant"
		Else
			dw_objects.DataObject				= "dw_objects_per_part_group_by_location"
		End If

		dw_objects.SetTransObject(sqlca)
		dw_objects.Modify("object_serial.color = '0~t if(IsNull(object_destination) , 0, 255)'")
		dw_objects.Retrieve(szPart)
		dw_objects.visible	= TRUE
		dw_objects.BringToTop= TRUE		

	Else
		If bDemand then
			If this.checked then		
				dw_demand_committed.DataObject	= "dw_view_releases_by_part_group_by_plant"
			Else
				dw_demand_committed.DataObject	= "dw_view_releases_by_part"
			End If

			dw_demand_committed.SetTransObject(sqlca)
			dw_demand_committed.Retrieve(szPart)
			dw_demand_committed.Visible	= TRUE
			dw_demand_committed.BringToTop= TRUE

		Else
			If sle_type.text= 'Purchased' then
				If this.checked then
					dw_workorder.dataObject			= "dw_list_qty_in_po_per_part_group_plant"
				Else
					dw_workorder.dataObject			= "dw_list_qty_in_po_per_part"
				End If

				dw_workorder.SetTransObject(sqlca)
				dw_workorder.Retrieve(szPart)
				dw_workorder.Visible			= TRUE
				dw_workorder.BringToTop		= TRUE

			Else
				MessageBox( monsys.msg_title, "You can only group P.O. information not the work order.", StopSign! )
			End If
		End If
	End If
Else
	If this.checked then
		this.checked	= FALSE
		MessageBox("Warning", "You can only group ON_HAND, DEMAND and PO information.", StopSign!)
	End If
End If



end event

type cb_delete from commandbutton within w_detail_info_of_demand
integer x = 1993
integer y = 1680
integer width = 261
integer height = 108
integer taborder = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Delete"
end type

event clicked;Int  iRow

Long iRow_Id

String szSalesOrder
String szRowId

iRow	= iReleaseRow

If MessageBox ( monsys.msg_title, "Are you sure you want to delete release?", Question!, OKCancel! ) = 1 Then
	If iRow > 0 then
		iRow_id = dw_order_detail.GetItemNumber(iRow, "row_id")
		szSalesOrder = String(iSalesOrder)
		szRowId		 = String(iRow_Id)

		DELETE FROM master_prod_sched  
		WHERE ( origin = :szSalesOrder ) AND  
     			( source = :szRowId )   ;
		If SQLCA.SQLCode = 0 then
			Commit;
		Else
			Rollback;
		End If

		dw_order_detail.DeleteRow(iRow)
		ib_Changed = TRUE

	Else
		MessageBox ( monsys.msg_title, "Please click the row first!", StopSign!)
	End If

	iReleaseRow = 0
Else
End If
end event

type cb_add from commandbutton within w_detail_info_of_demand
integer x = 1719
integer y = 1680
integer width = 247
integer height = 108
integer taborder = 190
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add"
end type

event clicked;Int	iTotalRow
Int	li_Randno, &
	li_found
boolean	lb_findseq=true

String	szType, ls_customerpart

iTotalRow = dw_order_detail.RowCount()

// after generating the random number check whether that already exist in the dw or table
// if so, re-generate the number
do while lb_findseq
	Randomize(0)
	li_Randno = Rand ( 4999 )
	li_found = dw_order_detail.find ( "sequence = "+string(li_randno),1, dw_order_detail.rowcount())
	if li_found = 0 then
		lb_findseq = false		
		select	count(sequence)
		into	:li_found
		from	order_detail
		where	order_no = :iSalesOrder and 
			sequence = :li_Randno;
		if li_found = 0 then lb_findseq = false
	end if 	
loop 

dw_order_detail.SelectRow(0, FALSE)
dw_order_detail.InsertRow(1)
dw_order_detail.SetItem(1, "order_no", iSalesOrder)
dw_order_detail.SetItem(1, "sequence", li_Randno)
dw_order_detail.SetItem(1, "part_number", szPart)
dw_order_detail.SetItem(1, "row_id", 0)
dw_order_detail.SetItem(1, "destination", szDestination )
dw_order_detail.SetItem(1, "committed_qty", 0)
dw_order_detail.SetItem(1, "flag", 2)
dw_order_detail.SetItem(1, "plant", szPlant)
dw_order_detail.SetItem(1, "ship_type", 'N')
dw_order_detail.SetItem(1, "unit", szUM)

SELECT	order_header.artificial_cum,
	order_header.customer_part
INTO	:szType,
	:ls_customerpart
FROM	order_header  
WHERE	order_header.order_no = :iSalesOrder   ;

If szType = "A" then
	dw_order_detail.SetItem(1, "the_cum", 0)
	dw_order_detail.SetItem(1, "our_cum", Dec(sle_history.text))
	dw_order_detail.SetTabOrder("our_cum", 0)
	dw_order_detail.SetTabOrder("quantity",0)
Else
	dw_order_detail.SetItem(1, "quantity", 0)
	dw_order_detail.SetTabOrder("the_cum", 0)
	dw_order_detail.SetTabOrder("our_cum", 0)
	dw_order_detail.SetItem(1, "our_cum", Dec(sle_history.text))
End If

dw_order_detail.SetItem(1, "type", "F")
dw_order_detail.SetItem(1, "customer_part", ls_customerpart)
dw_order_detail.ScrollToRow(1)

iReleaseRow = 1
ib_Changed		= TRUE

dw_order_detail.SetFocus ( )
end event

type cb_save from commandbutton within w_detail_info_of_demand
integer x = 2286
integer y = 1680
integer width = 247
integer height = 108
integer taborder = 180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;Long	ll_Row
long	ll_rowcount

str_super_cop_parms lstr_super_cop_parms

ll_rowcount = dw_order_detail.RowCount ( )

for ll_row = 1 to ll_rowcount
	if isnull(dw_order_detail.getitemnumber ( ll_row, "row_id" ), 0 ) = 0 then
		dw_order_detail.setitem ( ll_row, "row_id", il_maxrowid + 1 )
		il_maxrowid ++
	end if
next

If dw_order_detail.Update() > 0 then
	Commit;

	wf_reset_week_no()

	bNoCommit		= FALSE
	OpenWithParm(w_recalc_release_in_blanket_order, iSalesOrder)	

	If gssWindow.bPartMode then
		gssWindow.create_crosstab(szPart, gssWindow.dDate7)
	Else
		gssWindow.create_crosstab(szDestination, gssWindow.dDate7)
	End If

	IF wf_need_to_explode( ) THEN
		IF f_ask_minicop ( ) THEN
			IF MessageBox(monsys.msg_title, "Do you want to run mini COP?", Question!, YesNo!) = 1 THEN	
				lstr_super_cop_parms.a_regen_all = 'Y'
				lstr_super_cop_parms.a_order_no = isalesorder
				Openwithparm ( w_bom_explode, lstr_super_cop_parms )
				bFinish	= TRUE
				timer ( 0.5 )
			END IF
		END IF
	END IF
//	dw_order_detail.Retrieve ( isalesorder, is_releasetype )
	ib_Changed	= FALSE
	
Else
	Rollback;
End If


end event

type p_3 from picture within w_detail_info_of_demand
integer x = 110
integer y = 1344
integer width = 55
integer height = 48
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_16 from statictext within w_detail_info_of_demand
integer x = 165
integer y = 1344
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Release"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_2 from picture within w_detail_info_of_demand
integer x = 110
integer y = 688
integer width = 55
integer height = 48
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_15 from statictext within w_detail_info_of_demand
integer x = 183
integer y = 688
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Objects"
boolean focusrectangle = false
end type

type p_1 from picture within w_detail_info_of_demand
integer x = 110
integer y = 224
integer width = 55
integer height = 48
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_14 from statictext within w_detail_info_of_demand
integer x = 178
integer y = 220
integer width = 215
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Part Info"
boolean focusrectangle = false
end type

type dw_order_detail from datawindow within w_detail_info_of_demand
integer x = 443
integer y = 1136
integer width = 2359
integer height = 512
integer taborder = 140
string dataobject = "dw_release_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;iReleaseRow	= row

If iReleaseRow > 0 then

	If Long(this.object.flag[row]) = 0 then
		dw_order_detail.SetItem(iReleaseRow, "flag", 2)
	Else
		dw_order_detail.SetItem(iReleaseRow, "flag", 0)
	End If 

End If


end event

on constructor;setTransObject(sqlca)
end on

event itemchanged;Dec  d_the_cum
Dec  d_our_cum

ib_changed = TRUE

If dw_order_detail.Getcolumnname() = "the_cum" Then

	d_the_cum = Integer(dw_order_detail.GetText())
   d_our_cum = dw_order_detail.GetItemNumber( 1, "our_cum" )

   If d_the_cum < d_our_cum Then

		MessageBox ( "DataWindow Error", "The cum qty cannot be lesser than ~r our cum qty!", Stopsign! )
		dw_order_Detail.SetText("")
      Return	
 
	End If

End If
end event

event editchanged;ib_Changed = TRUE

this.SetItem(iReleaseRow, "flag", 2)


end event

event clicked;iReleaseRow = row

this.SetRow(iReleaseRow)


end event

event retrieverow;if GetItemNumber ( row, "row_id" ) > il_maxrowid then
	il_maxrowid = GetItemNumber ( row, "row_id" )
end if
end event

type sle_price from singlelineedit within w_detail_info_of_demand
integer x = 2327
integer y = 152
integer width = 402
integer height = 80
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within w_detail_info_of_demand
integer x = 2080
integer y = 160
integer width = 151
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Price"
boolean focusrectangle = false
end type

type sle_type from singlelineedit within w_detail_info_of_demand
boolean visible = false
integer x = 2395
integer y = 32
integer width = 402
integer height = 80
integer taborder = 220
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

type st_12 from statictext within w_detail_info_of_demand
boolean visible = false
integer x = 2249
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

type sle_available from singlelineedit within w_detail_info_of_demand
integer x = 1646
integer y = 400
integer width = 329
integer height = 88
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_allocate from statictext within w_detail_info_of_demand
integer x = 1262
integer y = 288
integer width = 293
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Allocated"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;//bAllocate	= (Not bAllocate)
//
//If bAllocate then
//	dw_objects.SetFilter("object_destination = '" + szCustomer + "'")
//Else
//	dw_objects.SetFilter("object_serial > 0")
//End If
//
//dw_objects.Filter()
//
//
end on

type st_10 from statictext within w_detail_info_of_demand
integer x = 859
integer y = 272
integer width = 297
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Demand"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;//bDemand	 = (Not bDemand)
//
//If bDemand	then
//	dw_demand_committed.Retrieve(szPart)
//	dw_demand_committed.visible	= TRUE
//	bAvailable	= FALSE
//	bAllocate	= FALSE
//Else
//	dw_demand_committed.visible	= FALSE
//End If
end on

type sle_schedule from singlelineedit within w_detail_info_of_demand
integer x = 2450
integer y = 400
integer width = 347
integer height = 88
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_hard_queue from statictext within w_detail_info_of_demand
integer x = 2469
integer y = 288
integer width = 315
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Hard Queue"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;//dw_workorder.visible	= (Not dw_workorder.visible)
//
//If dw_workorder.visible then
//	dw_history.visible	= FALSE
//End If
end on

type cb_exit from commandbutton within w_detail_info_of_demand
integer x = 2560
integer y = 1680
integer width = 247
integer height = 108
integer taborder = 170
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E&xit"
end type

event clicked;If ib_Changed = TRUE Then
	If MessageBox(monsys.msg_title, "Release window has been changed, are you sure you want to exit?", Question!, YesNo!) = 1 then
		Close(parent)
	End If
Else
	Close(parent)
End If
end event

type sle_onhand from singlelineedit within w_detail_info_of_demand
integer x = 439
integer y = 400
integer width = 329
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_history from singlelineedit within w_detail_info_of_demand
integer x = 2048
integer y = 400
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_allocated from singlelineedit within w_detail_info_of_demand
integer x = 1243
integer y = 400
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_committed from singlelineedit within w_detail_info_of_demand
integer x = 841
integer y = 400
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_history from statictext within w_detail_info_of_demand
integer x = 2053
integer y = 288
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Ship History"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;//dw_history.visible	= (Not dw_history.visible)
//
//If dw_history.visible	= TRUE then
//	dw_workorder.visible	= FALSE
//End If
end on

type st_7 from statictext within w_detail_info_of_demand
integer x = 1664
integer y = 288
integer width = 293
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Available"
alignment alignment = center!
boolean focusrectangle = false
end type

on clicked;bAvailable= (Not bAvailable)

If bAvailable then
	dw_objects.SetFilter("IsNull(object_destination)")
	bAllocate	= FALSE
	bDemand		= FALSE
Else
	dw_objects.SetFilter("object_serial > 0")
End If

dw_objects.Filter()

end on

type st_6 from statictext within w_detail_info_of_demand
integer x = 859
integer y = 320
integer width = 297
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Committed"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_detail_info_of_demand
integer x = 475
integer y = 288
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "On Hand"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_package from singlelineedit within w_detail_info_of_demand
integer x = 2331
integer y = 40
integer width = 603
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_detail_info_of_demand
integer x = 2080
integer y = 48
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Package"
boolean focusrectangle = false
end type

type sle_um from singlelineedit within w_detail_info_of_demand
integer x = 1467
integer y = 152
integer width = 562
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_detail_info_of_demand
integer x = 1285
integer y = 156
integer width = 110
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "UM"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_detail_info_of_demand
integer x = 1467
integer y = 40
integer width = 562
integer height = 80
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_part from singlelineedit within w_detail_info_of_demand
integer x = 695
integer y = 40
integer width = 562
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_detail_info_of_demand
integer x = 1285
integer y = 52
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Name"
boolean focusrectangle = false
end type

type st_1 from statictext within w_detail_info_of_demand
integer x = 462
integer y = 44
integer width = 178
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Part"
boolean focusrectangle = false
end type

type sle_hint from singlelineedit within w_detail_info_of_demand
boolean visible = false
integer x = 439
integer y = 492
integer width = 731
integer height = 64
integer taborder = 320
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean autohscroll = false
end type

type dw_workorder from datawindow within w_detail_info_of_demand
boolean visible = false
integer x = 439
integer y = 512
integer width = 2359
integer height = 588
integer taborder = 110
boolean titlebar = true
string title = "Assigned Jobs for current demand"
string dataobject = "dw_workorder_info_per_salesorder"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_history from datawindow within w_detail_info_of_demand
boolean visible = false
integer x = 439
integer y = 512
integer width = 2359
integer height = 592
integer taborder = 100
boolean titlebar = true
string title = "Shipping History"
string dataobject = "dw_shipping_history"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_objects from datawindow within w_detail_info_of_demand
integer x = 439
integer y = 512
integer width = 2359
integer height = 592
integer taborder = 80
boolean titlebar = true
string title = "List of Objects"
string dataobject = "dw_objects_per_part_group_by_location"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;If iReleaseRow > 0 then
	ib_Changed = TRUE
	this.SetItem(iReleaseRow, "flag", 1)
End If
end event

event doubleclicked;Long iRow
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


end event

event clicked;iReleaseRow	= row

end event

type gb_3 from groupbox within w_detail_info_of_demand
integer x = 91
integer y = 1104
integer width = 311
integer height = 544
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
end type

type gb_2 from groupbox within w_detail_info_of_demand
integer x = 91
integer y = 480
integer width = 311
integer height = 624
integer taborder = 130
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
end type

type gb_1 from groupbox within w_detail_info_of_demand
integer x = 91
integer y = 32
integer width = 311
integer height = 448
integer taborder = 230
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
end type

type r_1 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 439
integer y = 256
integer width = 329
integer height = 128
end type

type r_2 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 841
integer y = 256
integer width = 329
integer height = 128
end type

type r_3 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 1646
integer y = 256
integer width = 329
integer height = 128
end type

type r_4 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 2048
integer y = 260
integer width = 329
integer height = 128
end type

type r_5 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 2450
integer y = 252
integer width = 347
integer height = 128
end type

type r_6 from rectangle within w_detail_info_of_demand
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 78682240
integer x = 1248
integer y = 256
integer width = 329
integer height = 128
end type

