$PBExportHeader$w_blanketorder_inquiry.srw
forward
global type w_blanketorder_inquiry from w_inquiry_ancestor
end type
end forward

global type w_blanketorder_inquiry from w_inquiry_ancestor
string title = "Blanket Order Inquiry"
string menuname = "m_order_entry_inquiry"
long backcolor = 82899184
end type
global w_blanketorder_inquiry w_blanketorder_inquiry

forward prototypes
public function integer setactiveorder (string _destinationcode, string _customerpart, long _orderno, ref long _procresult)
end prototypes

public function integer setactiveorder (string _destinationcode, string _customerpart, long _orderno, ref long _procresult);
n_cst_blanketorders blanketOrders
blanketOrders.SetActiveOrder(_destinationCode, _customerPart, _orderNo, _procResult)

//	Return.
return 1

end function

on w_blanketorder_inquiry.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_order_entry_inquiry" then this.MenuID = create m_order_entry_inquiry
end on

on w_blanketorder_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_add;st_generic_structure	lstr_parm

lstr_parm.value1 = ''
lstr_parm.value2 = ''
lstr_parm.value3 = ''

OpenSheetWithParm ( w_blanket_order, lstr_parm, gnv_App.of_GetFrame(), 3, Original!)

end event

event ue_delete;long		l_l_row,&
			l_l_order,&
			l_l_count
int		l_i_rtn_code
boolean	l_b_no_message
string	l_s_temp, &
         l_s_dest, &
			l_s_part 

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 or NOT dw_inquiry.IsSelected ( l_l_row ) then return

l_l_order = dw_inquiry.GetItemNumber ( l_l_row, "SalesOrderNo" )

 SELECT count(order_detail.order_no)
 	INTO :l_l_count
   FROM order_detail  
  WHERE order_detail.order_no = :l_l_order   ;

If l_l_count > 0 Then
	SELECT count(shipper_detail.shipper)  
	  INTO :l_l_count
	  FROM shipper_detail,   
	       shipper  
	 WHERE ( shipper.id = shipper_detail.shipper ) AND
	       ( ( shipper_detail.order_no = :l_l_order ) AND  
	       ( shipper.status = 'O' OR  
	       shipper.status = 'S' ) )   ;
	
	If l_l_count > 0 Then
		MessageBox ( "Error", "You can not delete an order with releases committed to shippers!", StopSign! )
		Return
	else	
		If MessageBox ( "Warning", "This order contains releases!  Are you sure about deleting it?", Question!, YesNo!, 2 ) <> 1 Then
			Return
		Else
			l_b_no_message = True
		End if
	end if
End if


if l_b_no_message then
	l_i_rtn_code = 1
else
	l_i_rtn_code = MessageBox ( "Delete", "Do you really want to delete order# " + String ( l_l_order ) + "?", Question!, YesNo!, 2 )
end if

If l_i_rtn_code = 1 Then

	l_s_temp = String ( l_l_order )

	gnv_App.of_GetFrame().SetMicroHelp ( "Deleting Records..." )

   DELETE FROM master_prod_sched  
	    WHERE ( origin = :l_l_order ) ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

   // the below select statement inc by gph on 7/29/98 at 11.15 am  
   SELECT destination,blanket_part
	  INTO :l_s_dest, :l_s_part
	  FROM order_header
	 WHERE order_no = :l_l_order ;
	 
   DELETE FROM order_detail  
	      WHERE order_no = :l_l_order   ;
	
	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

   DELETE FROM order_header
	      WHERE order_no = :l_l_order   ;
	
	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if


	If dw_inquiry.DeleteRow ( l_l_row ) = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

	// deleting data from part_location table for that blanket part & destination 
	// inc by gph on 7/29/98 at 10:38 am
	DELETE 
	FROM	part_location
	WHERE	part = :l_s_part and
	       destination = :l_s_dest ;

	Commit ;

	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )
//	dw_inquiry.retrieve()
End if

dw_inquiry.SetRow ( 1 )
dw_inquiry.SetFocus ( )

end event

type st_1 from w_inquiry_ancestor`st_1 within w_blanketorder_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_blanketorder_inquiry
string dataobject = "d_blanketorder_inquiry"
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;long	l_l_order

dw_inquiry.DBcancel()

if row < 1 then return

l_l_order = GetItemNumber ( row, "SalesOrderNo" )

OpenSheetWithParm ( w_blanket_order, l_l_order, gnv_App.of_GetFrame(), 3, Original!)

end event

event dw_inquiry::retrieveend;SetPointer(Arrow!)
end event

event dw_inquiry::clicked;call super::clicked;
if	row > 0 then
	SetRow (row)
end if

end event

event dw_inquiry::itemchanged;call super::itemchanged;
choose case dwo.Name
	case "activeflag"
		//	Get the current active order for the selected order's destination and customer part group.
		long selectedSalesOrder, activeOrder
		selectedSalesOrder = object.SalesOrderNo[row]
		if data = "1" then
			string customerPart, destinationCode
			customerPart = object.customerpart[row]
			destinationCode = object.destinationcode[row]
			select
				SalesOrderNo
			into
				:activeOrder
			from
				BlanketOrderInquiry
			where
				DestinationCode = :destinationCode
			and
				CustomerPart = :customerPart
			and
				ActiveFlag = 1  ;
			
			if	activeOrder > 0 then
				if	MessageBox (monsys.msg_title, "The active order for the destination " + destinationCode + " and customer part " + customerPart + " is " + string(activeOrder) + ".  All releases for this order will be moved to order " + String (selectedSalesOrder) + ".", Information!, OkCancel!, 2) = 2 then
					object.ActiveFlag[row] = 0
					return 2
				end if
			end if
			
			//	Set active order.
			long procResult
			if	SetActiveOrder (destinationCode, customerPart, selectedSalesOrder, procResult) = 1 then
				long oldRow
				oldRow = Find ("DestinationCode = '" + destinationCode + "' and Customerpart = '" + customerPart + "' and SalesOrderNo = " + String (activeOrder), 1, RowCount())
				if	oldRow > 0 then
					object.ActiveFlag[oldRow] = 0
					object.DemandQty[row] = object.DemandQty[oldRow]
					object.DemandQty[oldRow] = object.AvailableQty[oldRow]
				end if
			else
				object.ActiveFlag[row] = 0
			end if
		else
			if selectedSalesOrder > 0 then
				if MessageBox (monsys.msg_title, "Do you want to clear the active flag for order number " + String (selectedSalesOrder) + "?", Information!, YesNo!, 2) = 2 then
					object.ActiveFlag[row] = 1
					return 2
				end if
				
				update
					order_header
				set
					status = 'O'
				where
					order_no = :selectedSalesOrder  ;
				
				commit  ;
			end if
		end if
	case "newcustomerpart"
		Update(true)
		commit  ;
end choose

end event

