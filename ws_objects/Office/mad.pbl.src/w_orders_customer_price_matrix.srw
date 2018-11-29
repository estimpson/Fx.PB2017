$PBExportHeader$w_orders_customer_price_matrix.srw
forward
global type w_orders_customer_price_matrix from w_sheet_4t
end type
type dw_parts_on_order from datawindow within w_orders_customer_price_matrix
end type
type st_1 from statictext within w_orders_customer_price_matrix
end type
type dw_customers from datawindow within w_orders_customer_price_matrix
end type
type sle_1 from singlelineedit within w_orders_customer_price_matrix
end type
type dw_available_parts from datawindow within w_orders_customer_price_matrix
end type
type gb_3 from groupbox within w_orders_customer_price_matrix
end type
type gb_1 from groupbox within w_orders_customer_price_matrix
end type
type dw_price_break from datawindow within w_orders_customer_price_matrix
end type
type dw_discount from datawindow within w_orders_customer_price_matrix
end type
type dw_category from datawindow within w_orders_customer_price_matrix
end type
type dw_customer_profile from datawindow within w_orders_customer_price_matrix
end type
type gb_2 from groupbox within w_orders_customer_price_matrix
end type
type gb_4 from groupbox within w_orders_customer_price_matrix
end type
end forward

global type w_orders_customer_price_matrix from w_sheet_4t
integer height = 1560
string title = "Customer Price Matrix"
string menuname = "m_orders_customer_price_matrix"
event ue_exit_program pbm_custom01
event ue_add_price pbm_custom02
event ue_save pbm_custom03
event ue_delete_price pbm_custom04
dw_parts_on_order dw_parts_on_order
st_1 st_1
dw_customers dw_customers
sle_1 sle_1
dw_available_parts dw_available_parts
gb_3 gb_3
gb_1 gb_1
dw_price_break dw_price_break
dw_discount dw_discount
dw_category dw_category
dw_customer_profile dw_customer_profile
gb_2 gb_2
gb_4 gb_4
end type
global w_orders_customer_price_matrix w_orders_customer_price_matrix

type variables
Long     il_Rows, &
            il_PriceRow, &
            il_RowCount

String    is_Customer, &
            is_Part, &
            is_Type

Boolean ib_Changed       = FALSE
Boolean ib_PriceVisible   = FALSE
Boolean ib_DeleteRow    = FALSE
Boolean ib_Part              = FALSE
Boolean ib_CustomerPart = FALSE
boolean i_b_trigger_clicked
end variables

forward prototypes
public subroutine wf_drag_new_part (string as_part, string as_customer, boolean ab_part)
public function boolean wf_delete_blank_rows (long al_rowcount)
end prototypes

on ue_exit_program;IF ib_Changed THEN
	IF MessageBox ( "Save Price", "You have not saved the pricing " + &
						 "information you have just entered for Part: " + &
						 is_Part + ".  Would you like to save this " + &
						 "information now?", Question!, YesNo! ) = 1 THEN
		ib_Changed = FALSE
		w_orders_customer_price_matrix.TriggerEvent ( "ue_save" )
		Close ( w_orders_customer_price_matrix )
	ELSE
		ib_Changed = FALSE
		Close ( w_orders_customer_price_matrix )
	END IF
ELSE
	Close ( w_orders_customer_price_matrix )
END IF							 

end on

event ue_add_price;Long l_NewRow

String s_Category

IF il_Rows > 0 THEN

	SELECT category
	  INTO :s_Category
	  FROM customer
	 WHERE customer = :is_Customer	;

	is_Type = dw_customer_profile.GetItemString ( il_Rows, "type" )
	is_Part = dw_customer_profile.GetItemString ( il_Rows, "part" )

	IF ib_PriceVisible AND is_Type = "B" THEN			
      l_NewRow = dw_price_break.InsertRow ( 0 ) 
		dw_price_break.ScrollToRow ( dw_price_break.RowCount ( ) + 1 )
      dw_price_break.SetItem ( l_NewRow, 3, is_Part )
      dw_price_break.SetItem ( l_NewRow, 4, is_Customer )
		dw_price_break.AcceptText ( )
		dw_price_break.SetColumn ( 1 )
		dw_price_break.SetFocus ( )
		dw_discount.Visible    = FALSE
		dw_category.Visible    = FALSE
		dw_price_break.Visible = TRUE
	ELSEIF ib_PriceVisible AND is_Type = "D" THEN
		l_NewRow = dw_discount.InsertRow ( 0 ) 
		dw_discount.ScrollToRow ( dw_discount.RowCount ( ) + 1 )
		dw_discount.SetItem ( l_NewRow, "part", is_Part )
		dw_discount.SetItem ( l_NewRow, "customer", is_Customer )
		dw_discount.AcceptText ( )
		dw_discount.SetColumn ( "price")
		dw_discount.SetFocus ( )
		dw_price_break.Visible = FALSE
		dw_category.Visible    = FALSE
		dw_discount.Visible    = TRUE
		dw_discount.modify("qty_break.tabsequence = 30")		
	ELSEIF ib_PriceVisible AND is_Type = "C" THEN
		l_NewRow = dw_category.InsertRow ( 0 ) 
		dw_category.ScrollToRow ( dw_category.RowCount ( ) + 1 )
		dw_category.SetItem ( l_NewRow, 2, is_Part )
		dw_category.SetItem ( l_NewRow, 3, is_Customer )
		dw_category.SetItem ( l_NewRow, 4, s_Category )
		dw_category.AcceptText ( )
		dw_category.SetColumn ( 1 )
		dw_category.SetFocus ( )
		dw_price_break.Visible = FALSE
		dw_discount.Visible    = FALSE
		dw_category.Visible    = TRUE
	ELSE
		MessageBox ( "Price Matrix Type", "You must choose which " + &
						 " ~"Type~" of Price Matrix you wish to attach to " + &
						 "the part in the Customer Profile window. (" + &
						 "Discount or Price Break).", StopSign!, OK! )
	END IF
ELSE
	MessageBox ( "Invalid Row", "You must first click on the row of your " + &
					 "choice in the Customer Profile window.", StopSign!, OK! )
END IF
end event

event ue_save;String s_CustUnit, &
		 s_Type, &
		 s_Part, &
		 s_Taxable, &
		 s_Category,&
		 ls_custpart, &
		 ls_update_order, &
		 ls_update_sd, &
		 ls_update_unprn_inv

Long   l_Count, &
		 l_RowCount

Dec    dec_StdPrice, &
		 dec_Price, &
		 dec_Discount, &
		 dec_Break, &
		 ld_price

dw_customer_profile.AcceptText ( )

SetPointer ( HourGlass! )

gnv_App.of_GetFrame().SetMicroHelp ( "Saving Records" )

l_RowCount = dw_customer_profile.RowCount ( )

IF l_RowCount > 0 THEN

	FOR l_Count = 1 to l_RowCount
		s_CustUnit = dw_customer_profile.GetItemString ( l_Count, "part_customer_customer_unit" )
		s_Type     = dw_customer_profile.GetItemString ( l_Count, "type" )
		s_Part     = dw_customer_profile.GetItemString ( l_Count, "part" )
		s_Taxable  = dw_customer_profile.GetItemString ( l_Count, "part_customer_taxable" )
		dec_StdPrice = dw_customer_profile.GetItemNumber ( l_Count, "part_standard_price" )
		ls_custpart = dw_customer_profile.GetItemString ( l_count, "part_customer_customer_part" )
		ls_update_order = dw_customer_profile.GetItemString ( l_count, "update_od" )
		ls_update_sd = dw_customer_profile.GetItemString ( l_count, "update_sd" )
		ls_update_unprn_inv= dw_customer_profile.GetItemString ( l_count, "update_inv" )
		ld_price 	= dw_customer_profile.GetItemDecimal ( l_count, "part_customer_blanket_price" )

		UPDATE part_customer
			SET customer_unit = :s_CustUnit,
			    type          = :s_Type,
				 taxable       = :s_Taxable,
				 customer_part = :ls_custpart
		 WHERE part = :s_Part AND customer = :is_Customer	;

		IF SQLCA.SQLCode <> 0 THEN
			MessageBox ( monsys.msg_title, "Update of Customer Profile failed!", &
							 Exclamation!, OK! )
			RollBack ;
		ELSE
				// Update open orders with the new blanket price
				IF ISNULL ( ls_update_order, 'N' ) = 'Y' THEN
						UPDATE order_header
							SET alternate_price = :ld_price
						WHERE ( isnull(order_header.status,'O') = 'O' )  and 
								( order_header.customer= :is_customer ) and
								( order_header.blanket_part = :s_part ) and
								( isnull(order_header.order_type,'B') = 'B' ) ;
								
						IF SQLCA.SQLCode = 0 THEN
					
							UPDATE order_detail, order_header
							SET order_detail.alternate_price = :ld_price
							WHERE ( order_header.order_no = order_detail.order_no ) and  
									( isnull(order_header.status,'O') = 'O' ) and 
									( order_header.customer= :is_customer ) and
									( order_detail.part_number = :s_part ) and
									( isnull(order_header.order_type,'B') = 'B' ) ;
						END IF
						
				END IF
		
				IF SQLCA.SQLCode <> 0 THEN
					MessageBox ( monsys.msg_title, "Unable to Update Price on Open Orders for part : " + s_part + " and customer:  "  + is_customer + "!", Exclamation!, OK! )
					Rollback ;
				End if
		
				// Update open shipper detail rows with the new blanket price //check..
				IF ISNULL ( ls_update_sd, 'N' ) = 'Y' THEN
					UPDATE shipper_detail, shipper
					SET shipper_detail.alternate_price = :ld_price
				   WHERE ( shipper.id = shipper_detail.shipper ) and  
				         ( shipper.status in (  'O', 'S' )  )   and 
							( shipper.customer= :is_customer ) and
							( shipper_detail.part = :s_part );
				END IF
		
				IF SQLCA.SQLCode <> 0 THEN
					MessageBox ( monsys.msg_title, "Unable to Update Price on Open Shippers for part : " + s_part + " and customer : " + is_customer +"!", Exclamation!, OK! )
					RollBack ;
				End if
		
		
				// Update open shipper detail rows with the new blanket price
				IF ISNULL ( ls_update_unprn_inv, 'N' ) = 'Y' THEN
					UPDATE shipper_detail, shipper
					SET shipper_detail.alternate_price = :ld_price
				   WHERE ( shipper.id = shipper_detail.shipper ) and  
//				         ( shipper.status in ( 'O', 'S' )  )   and
							( shipper.invoice_printed = 'N' ) and
							( shipper.customer= :is_customer ) and
							( shipper_detail.part = :s_part ) ;	
				END IF
		
				IF SQLCA.SQLCode <> 0 THEN
					MessageBox ( monsys.msg_title, "Unable to Update price on Unprinted Invoice for part : " + s_part + " and customer : " + is_customer + "!", Exclamation!, OK! )
					RollBack ;
				End if
			
			Commit ;
			
		END IF

	NEXT

END IF


IF is_Type = "D" THEN

	IF dw_discount.RowCount ( ) > 0 THEN
		dw_discount.AcceptText ( )
		
	  if isnull(dw_discount.getitemnumber(dw_discount.rowcount(),"qty_break")) then
			MessageBox(monsys.msg_title,"Quantity Break cannot be null",StopSign!)
			return
	  end if
	  
		FOR il_RowCount = 1 TO dw_discount.RowCount ( )
			dec_Price    = dw_discount.GetItemNumber ( il_RowCount, "price" )
			dec_Discount = dw_discount.GetItemNumber ( il_RowCount, "discount" )

			IF ( IsNull ( dec_Price ) AND IsNull ( dec_Discount ) ) OR &
				( dec_Price = 0 AND dec_Discount = 0 ) OR &
				( IsNull ( dec_Price ) AND dec_Discount = 0 ) OR &
				( dec_Price = 0 AND IsNull ( dec_Discount ) ) THEN

				IF NOT wf_delete_blank_rows ( il_RowCount ) THEN
					MessageBox ( monsys.msg_title, "Unable to delete blank " + &
									 "row in Customer Price Matrix window.  " + &
									 "However, this should not affect the " + &
									 "actual save of the information.  The " + &
									 "blank row will simply need to be deleted " + &
									 "manually.", Information!, OK! )
				END IF

			END IF

		NEXT

		IF dw_discount.Update ( ) = -1 THEN
			MessageBox ( monsys.msg_title, "Update of Discount Price failed!", &
							 Exclamation!, OK! )
			RollBack ;
		ELSE
			Commit ;
			ib_Changed = FALSE
		END IF

	END IF

ELSEIF is_Type = "B" THEN

	IF dw_price_break.RowCount ( ) > 0 THEN
		dw_price_break.AcceptText ( )

		FOR il_RowCount = 1 TO dw_price_break.RowCount ( )
			dec_Price = dw_price_break.GetItemNumber ( il_RowCount, "price" )
			dec_Break = dw_price_break.GetItemNumber ( il_RowCount, "qty_break" )

			IF ( IsNull ( dec_Price ) AND IsNull ( dec_Break ) ) OR &
				( dec_Price = 0 AND dec_Break = 0 ) OR &
				( IsNull ( dec_Price ) AND dec_Break = 0 ) OR &
				( dec_Price = 0 AND IsNull ( dec_Break ) ) THEN

				IF NOT wf_delete_blank_rows ( il_RowCount ) THEN
					MessageBox ( monsys.msg_title, "Unable to delete blank " + &
									 "row in Customer Price Matrix window.  " + &
									 "However, this should not affect the " + &
									 "actual save of the information.  The " + &
									 "blank row will simply need to be deleted " + &
									 "manually.", Information!, OK! )
				END IF

			END IF

		NEXT

		IF dw_price_break.Update ( ) = -1 THEN
			MessageBox ( monsys.msg_title, "Update of Price Break failed!", &
							 Exclamation!, OK! )
			RollBack ;
		ELSE
			Commit ;
			ib_Changed = FALSE
		END IF

	END IF

ELSEIF is_Type = "C" THEN

	IF dw_category.RowCount ( ) > 0 THEN
		dw_category.AcceptText ( )

		FOR il_RowCount = 1 TO dw_category.RowCount ( )
			dec_Price = dw_category.GetItemNumber ( il_RowCount, "price" )
			s_Category = dw_category.GetItemString ( il_RowCount, "category" )

			IF ( IsNull ( dec_Price ) AND IsNull ( s_Category ) ) OR &
				( dec_Price = 0 AND IsNull ( s_Category ) ) THEN

				IF NOT wf_delete_blank_rows ( il_RowCount ) THEN
					MessageBox ( monsys.msg_title, "Unable to delete blank " + &
									 "row in Customer Price Matrix window.  " + &
									 "However, this should not affect the " + &
									 "actual save of the information.  The " + &
									 "blank row will simply need to be deleted " + &
									 "manually.", Information!, OK! )
				END IF

			END IF

		NEXT

		IF dw_category.Update ( ) = -1 THEN
			MessageBox ( monsys.msg_title, "Update of Price Break failed!", &
							 Exclamation!, OK! )
			RollBack ;
		ELSE
			Commit ;
			ib_Changed = FALSE
		END IF

	END IF

ELSE
	gnv_App.of_GetFrame().SetMicroHelp ( "Ready" )
	Return
END IF

if dw_customer_profile.update() = -1 then
	rollback;
else 
	commit;
end if

gnv_App.of_GetFrame().SetMicroHelp ( "Ready" )
end event

on ue_delete_price;Int i_delete

IF is_Type = "D" AND il_PriceRow > 0 THEN

	IF MessageBox ( "Delete Row", "Are you sure you want to delete " + &
						 "Row: " + String ( il_PriceRow ) + " for Part: " + &
						 is_Part + "?", Question!, YesNo! ) = 1 THEN
		i_delete = dw_discount.DeleteRow ( il_PriceRow )

		IF i_delete <> -1 THEN

			IF dw_discount.Update ( ) = 1 THEN
				Commit;
			ELSE
				MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
				RollBack;
				Return
			END IF

		ELSE
			MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
			Return
		END IF 

	ELSE
		Return
	END IF

ELSEIF is_Type = "B" AND il_PriceRow > 0 THEN

	IF MessageBox ( "Delete Row", "Are you sure you want to delete " + &
						 "Row: " + String ( il_PriceRow ) + " for Part: " + &
						 is_Part + "?", Question!, YesNo! ) = 1 THEN
		i_Delete = dw_price_break.DeleteRow ( il_PriceRow )

		IF i_delete <> -1 THEN

			IF dw_price_break.Update ( ) = 1 THEN
				Commit;
			ELSE
				MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
				RollBack;
				Return
			END IF

		ELSE
			MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
			Return
		END IF

	ELSE
		Return
	END IF

ELSEIF is_Type = "C" AND il_PriceRow > 0 THEN

	IF MessageBox ( "Delete Row", "Are you sure you want to delete " + &
						 "Row: " + String ( il_PriceRow ) + " for Part: " + &
						 is_Part + "?", Question!, YesNo! ) = 1 THEN
		i_Delete = dw_category.DeleteRow ( il_PriceRow )

		IF i_delete <> -1 THEN

			IF dw_category.Update ( ) = 1 THEN
				Commit;
			ELSE
				MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
				RollBack;
				Return
			END IF

		ELSE
			MessageBox ( "System Error", "Delete of Row Failed!", Exclamation!, OK! )
			Return
		END IF  

	ELSE
		Return
	END IF

ELSE
	MessageBox ( "Invalid Price", "There is either no price to delete " + &
					 "or you need to click on a row in the Customer Price " + &
					 "Matrix window.", Exclamation!, OK! )
END IF

end on

public subroutine wf_drag_new_part (string as_part, string as_customer, boolean ab_part);String s_CurrentPart

If IsNull ( as_Customer ) OR as_Customer = '' Then
  MessageBox ( "Selection Error", "You must first select a Customer.", Information!, OK! )
  dw_customers.SetFocus ( )
  Return
End If

IF ab_Part THEN	                //  If dragging from the Available Parts datawindow

	SetNull ( s_CurrentPart )

	SELECT part  
     INTO :s_CurrentPart  
     FROM part_customer  
    WHERE ( customer	= :as_Customer ) AND  
          ( part 		= :as_Part )   ;

	IF IsNull ( s_CurrentPart ) THEN

		INSERT INTO part_customer ( part,
											 customer,
											 customer_part,
											 customer_standard_pack,
											 taxable,
											 customer_unit,
											 type )
								 VALUES ( :as_Part,
											 :as_Customer,
											 ' ',
											 0,
											 null,
											 null,
											 'B' )	;
		IF SQLCA.SQLCode = 0 THEN
			Commit;
			dw_customer_profile.Reset ( )
			dw_customer_profile.Retrieve ( as_Customer )
			dw_customer_profile.Sort ( )
		ELSE
			MessageBox ( "System Error", "Add of Part to the Customer Profile Window Failed!", Exclamation!, OK! )
			Rollback;
			Return
		END IF
	ELSE
		MessageBox ( "Warning", "The part that you chose already exists in the list.", Information!, OK! )
	END IF

END IF

ab_Part = FALSE
end subroutine

public function boolean wf_delete_blank_rows (long al_rowcount);Int i_delete	

IF is_Type = "D" AND al_RowCount > 0 THEN

	DELETE FROM part_customer_price_matrix
		   WHERE part     = :is_Part AND
					customer = :is_Customer AND
					( ( price is null AND
				   discount is null ) OR
					( price is null   AND
					discount = 0 )     OR
					( price = 0       AND
					discount is null ) OR
					( price = 0       AND
					discount = 0 ) )  ;

	IF SQLCA.SQLCode = 0 THEN
		Commit;
		dw_discount.DeleteRow ( al_RowCount )
		Return TRUE
	ELSE
		RollBack;
		Return FALSE
	END IF

ELSEIF is_Type = "B" AND il_RowCount > 0 THEN

	DELETE FROM part_customer_price_matrix
		   WHERE part     = :is_Part AND
					customer = :is_Customer AND
					( ( price is null  AND
				   qty_break is null ) OR
					( price is null    AND
					qty_break = 0 )     OR
					( price = 0        AND
					qty_break is null ) OR
					( price = 0        AND
					qty_break = 0 ) )  ;

	IF SQLCA.SQLCode = 0 THEN
		Commit;
		dw_price_break.DeleteRow ( al_RowCount )
		Return TRUE
	ELSE
		RollBack;
		Return FALSE
	END IF

ELSEIF is_Type = "C" AND il_RowCount > 0 THEN

	DELETE FROM part_customer_price_matrix
		   WHERE part     = :is_Part AND
					customer = :is_Customer AND
					( ( price is null  AND
				   category is null ) OR
					( price = 0        AND
					category is null ) )  ;

	IF SQLCA.SQLCode = 0 THEN
		Commit;
		dw_category.DeleteRow ( al_RowCount )
		Return TRUE
	ELSE
		RollBack;
		Return FALSE
	END IF

ELSE
	Return FALSE
END IF
end function

on resize;dw_customer_profile.Width = Width - 810
gb_2.Width = Width - 768
end on

event open;call super::open;LONG		l_l_row
STRING	l_s_unit,&
			l_s_curunit
			
is_customer = Message.StringParm

dw_customers.SetTransObject ( SQLCA )
dw_available_parts.SetTransObject ( SQLCA )
dw_customer_profile.SetTransObject ( SQLCA )
dw_discount.SetTransObject ( SQLCA )
dw_price_break.SetTransObject ( SQLCA )
dw_parts_on_order.SetTransObject ( SQLCA )
dw_category.SetTransObject ( SQLCA )

dw_customers.Retrieve ( )
dw_available_parts.Retrieve ( )

IF isnull ( is_customer, '' ) > '' THEN
	l_l_row = dw_customers.Find ( "customer = '" + is_customer + "'", 1, dw_customers.RowCount ( ) )
	IF l_l_row > 0 THEN
		dw_customers.SelectRow ( 0, FALSE )
		dw_customers.SelectRow ( l_l_row, TRUE )
		dw_customer_profile.Reset ( )
		If dw_customer_profile.Retrieve ( is_customer ) > 0 Then
			dw_customer_profile.SetSort ( '#1 A' )
			dw_customer_profile.Sort ( )
			For l_l_row = 1 to dw_customer_profile.RowCount ( )
				l_s_unit = dw_customer_profile.GetItemString(l_l_row, "part_inventory_standard_unit")
				l_s_CurUnit = dw_customer_profile.GetItemString(l_l_row, "part_customer_customer_unit")
				IF IsNull ( l_s_CurUnit ) OR l_s_CurUnit = '' THEN
					dw_customer_profile.SetItem (l_l_row, "part_customer_customer_unit" , l_s_unit)
				END IF
			NEXT
		End If
	END IF
END IF
end event

on w_orders_customer_price_matrix.create
int iCurrent
call super::create
if this.MenuName = "m_orders_customer_price_matrix" then this.MenuID = create m_orders_customer_price_matrix
this.dw_parts_on_order=create dw_parts_on_order
this.st_1=create st_1
this.dw_customers=create dw_customers
this.sle_1=create sle_1
this.dw_available_parts=create dw_available_parts
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_price_break=create dw_price_break
this.dw_discount=create dw_discount
this.dw_category=create dw_category
this.dw_customer_profile=create dw_customer_profile
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parts_on_order
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_customers
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.dw_available_parts
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.dw_price_break
this.Control[iCurrent+9]=this.dw_discount
this.Control[iCurrent+10]=this.dw_category
this.Control[iCurrent+11]=this.dw_customer_profile
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
end on

on w_orders_customer_price_matrix.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parts_on_order)
destroy(this.st_1)
destroy(this.dw_customers)
destroy(this.sle_1)
destroy(this.dw_available_parts)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_price_break)
destroy(this.dw_discount)
destroy(this.dw_category)
destroy(this.dw_customer_profile)
destroy(this.gb_2)
destroy(this.gb_4)
end on

type dw_parts_on_order from datawindow within w_orders_customer_price_matrix
boolean visible = false
integer x = 1175
integer y = 1436
integer width = 494
integer height = 296
integer taborder = 120
string dataobject = "d_orders_part_list"
boolean livescroll = true
end type

type st_1 from statictext within w_orders_customer_price_matrix
integer x = 37
integer y = 892
integer width = 475
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
boolean enabled = false
string text = "Quick Add Part:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_customers from datawindow within w_orders_customer_price_matrix
event ue_unapproved_message ( )
integer x = 41
integer y = 88
integer width = 654
integer height = 684
integer taborder = 40
string dataobject = "d_orders_customer_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_unapproved_message;MessageBox ( "Existing Order", "This customer's status is " + dw_customers.GetItemString ( dw_customers.GetRow ( ), "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

event clicked;Long	l_count, &
	l_row_count
String	s_unit, &
	ls_CurUnit

IF row = 0 THEN Return
dw_Customers.SelectRow ( 0, FALSE )
IF ib_Changed THEN
	IF MessageBox ( "Save Price", "You have not saved the pricing " + &
						 "information you have just entered for Part: " + &
						 is_Part + ".  Would you like to save this " + &
						 "information now?", Question!, YesNo! ) = 1 THEN
		ib_Changed = FALSE
		w_orders_customer_price_matrix.TriggerEvent ( "ue_save" )
	ELSE
		ib_Changed = FALSE
	END IF
END IF							 

il_Rows = 0

dw_Customers.SelectRow ( row, TRUE )
is_Customer = object.customer[row]

dw_customer_profile.Reset ( )
l_Count = dw_customer_profile.Retrieve ( is_Customer )

If l_count > 0 Then
	dw_customer_profile.SetSort ( '#1 A' )
	dw_customer_profile.Sort ( )
		
	For l_row_Count = 1 to l_count 
		s_unit = dw_customer_profile.object.part_inventory_standard_unit [ l_row_count ]
		ls_CurUnit = dw_customer_profile.object.part_customer_customer_unit [ l_row_count ] 
		IF IsNull ( ls_CurUnit ) OR ls_CurUnit = '' THEN
			dw_customer_profile.SetItem (l_row_count, "part_customer_customer_unit" , s_unit)
		END IF
	NEXT
End If

dw_discount.Reset ( )
dw_discount.Visible = FALSE
dw_price_break.Reset ( )
dw_price_break.Visible = FALSE
dw_category.Reset ( )
dw_category.Visible = FALSE

il_PriceRow = 0

SetNull ( is_Part )
SetNull ( is_Type )

if object.status_type [ row ] <> 'A' then	
	Post Event ue_unapproved_message ( )
end if
end event

type sle_1 from singlelineedit within w_orders_customer_price_matrix
event keyup pbm_keyup
event mod pbm_custom01
event keydown pbm_keydown
integer x = 526
integer y = 880
integer width = 1440
integer height = 88
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event keyup;LONG	l_Row

l_Row = dw_available_parts.Find ( 'part_number = ~'' + sle_1.Text + '~'', 1, dw_available_parts.RowCount ( ) )

dw_available_parts.SelectRow ( 0, FALSE )
IF l_Row <> 0 THEN
	dw_available_parts.SelectRow ( l_Row, TRUE )
ELSE
	dw_available_parts.ScrollToRow ( dw_available_parts.Find ( 'part_number >= ~'' + sle_1.Text + '~'', 1, dw_available_parts.RowCount ( ) ) )
END IF
end event

on mod;This.Text = Upper ( This.Text )

IF f_valid_part_number ( This.Text ) THEN
	is_Part = This.Text
	ib_Part = TRUE
	IF IsNull ( is_Customer ) OR is_Customer = "" THEN
		MessageBox ( "Selection Error", "You must first select a Customer.", Information!, OK! )
		dw_customers.SetFocus ( )
		Return
	ELSE
		wf_drag_new_part ( is_Part, is_Customer, ib_Part )
		This.Text = ""
		dw_customer_profile.Retrieve ( is_Customer )
	END IF 
ELSE
	f_beep ( 3 )
	MessageBox ( "Warning", "This part does not exist in the system!", Information!, OK! )
	sle_1.Text = ""
END IF
end on

on keydown;IF KeyDown ( keyEnter! ) THEN
	sle_1.TriggerEvent ( "mod" )
END IF
end on

type dw_available_parts from datawindow within w_orders_customer_price_matrix
event deletemessage ( string as_message )
integer x = 41
integer y = 988
integer width = 1925
integer height = 424
integer taborder = 110
string dragicon = "MONITOR.ICO"
string dataobject = "d_orders_price_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event deletemessage;Messagebox ( 'Warning', as_message ) 
end event

event clicked;IF row > 0 THEN
	dw_available_parts.SelectRow ( 0, FALSE )
	dw_available_parts.SelectRow ( row, TRUE )
	is_Part = object.part_number [ row ] //this.GetItemString ( row, "part_number" )
	IF NOT f_valid_part_number ( is_Part ) THEN
		f_beep ( 3 )
		MessageBox ( "Warning", "This part does not exist in the system!", Information!, OK! )
		Return
	ELSE
		dw_available_parts.Drag ( Begin! )
		ib_Part = TRUE
	END IF
END IF

end event

event dragdrop;IF ib_CustomerPart THEN
	dw_parts_on_order.Reset ( )
	dw_parts_on_order.Retrieve ( is_Part, is_Customer )
	IF dw_parts_on_order.RowCount ( ) > 0 THEN
		post event deletemessage ("Part: " + is_Part + " exists on an " + &
				"order for Customer: " + is_Customer + " in the " + &
				"system.  Unable to remove Part/Customer " ) 
	ELSE
		if dw_price_break.retrieve ( is_customer, is_part ) > 0 then 
			post event deletemessage ( "Price break(s) for Part: " + is_Part + " and " + &
					"Customer: " + is_Customer + " exist in the " + &
					"system.  Unable to remove Part/Customer " ) 
		else
			DELETE	FROM part_customer
			WHERE	( customer = :is_Customer ) AND  
				( part	= :is_Part )   ;
		
			IF SQLCA.SQLCode = 0 THEN
				Commit;
				dw_customer_profile.Reset ( )
				dw_customer_profile.Retrieve ( is_Customer )
			ELSE
				MessageBox ( "System Error", "Removal of the Part/Customer Relationship Failed!", Exclamation!, OK! )
				Rollback;
			END IF
		end if 	
	END IF
END IF
ib_CustomerPart = FALSE
ib_Part         = FALSE

end event

type gb_3 from groupbox within w_orders_customer_price_matrix
integer x = 14
integer y = 800
integer width = 1970
integer height = 632
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
string text = "Available Parts"
end type

type gb_1 from groupbox within w_orders_customer_price_matrix
integer x = 18
integer y = 16
integer width = 699
integer height = 776
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
string text = "Customers"
end type

type dw_price_break from datawindow within w_orders_customer_price_matrix
boolean visible = false
integer x = 2016
integer y = 884
integer width = 837
integer height = 528
integer taborder = 90
string dataobject = "d_orders_cust_price_matrix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

on clicked;dw_price_break.SelectRow ( 0, FALSE )

il_PriceRow = dw_price_break.GetClickedRow ( )

dw_price_break.SelectRow ( il_PriceRow, TRUE )
end on

on itemchanged;ib_Changed = TRUE
end on

type dw_discount from datawindow within w_orders_customer_price_matrix
boolean visible = false
integer x = 2016
integer y = 884
integer width = 837
integer height = 528
integer taborder = 70
string dataobject = "d_orders_discount_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

on clicked;dw_discount.SelectRow ( 0, FALSE )

il_PriceRow = dw_discount.GetClickedRow ( )

dw_discount.SelectRow ( il_PriceRow, TRUE )
end on

on itemchanged;ib_Changed = TRUE
end on

type dw_category from datawindow within w_orders_customer_price_matrix
boolean visible = false
integer x = 2016
integer y = 884
integer width = 837
integer height = 528
integer taborder = 100
string dataobject = "d_orders_category_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

on clicked;dw_category.SelectRow ( 0, FALSE )

il_PriceRow = dw_category.GetClickedRow ( )

dw_category.SelectRow ( il_PriceRow, TRUE )
end on

type dw_customer_profile from datawindow within w_orders_customer_price_matrix
integer x = 754
integer y = 88
integer width = 2094
integer height = 684
integer taborder = 30
string dragicon = "MONITOR.ICO"
string dataobject = "d_orders_part_customer_profile"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Long   l_NumberRows

IF row = 0 THEN return

IF ib_Changed THEN
	IF MessageBox ( monsys.msg_title, "You have not saved the pricing " + &
			"information you have just entered for Part: " + &
			is_Part + ".  Would you like to save this " + &
			"information now?", Question!, YesNo! ) = 1 THEN
		ib_Changed = FALSE
		w_orders_customer_price_matrix.TriggerEvent ( "ue_save" )
	ELSE
		ib_Changed = FALSE
	END IF
END IF							 

il_PriceRow  = 0
l_NumberRows = RowCount ( )

if i_b_trigger_clicked then
	il_Rows	= row //GetRow ( )
else
	il_Rows  = row //GetClickedRow ( )
end if

IF l_NumberRows > 0 AND row > 0 THEN

	this.SelectRow ( 0, FALSE )
//	this.SelectRow ( Row, TRUE )
	is_Type = object.type [ row ] 
	is_Part = object.part [ row ] 

	IF is_Type = "B" THEN
		dw_price_break.Reset ( )
		dw_price_break.Retrieve ( is_Customer, is_Part )
		dw_discount.Visible    = FALSE
		dw_category.Visible    = FALSE
		dw_price_break.Visible = TRUE
		ib_PriceVisible = TRUE
	ELSEIF is_Type = "D" THEN
		dw_discount.Reset ( )
		dw_discount.Retrieve ( is_Customer, is_Part )
		dw_price_break.Visible = FALSE
		dw_category.Visible    = FALSE
		dw_discount.Visible    = TRUE
		ib_PriceVisible = TRUE
	ELSE
		dw_price_break.Visible = FALSE
		dw_discount.Visible    = FALSE
		dw_category.Visible    = FALSE
		ib_PriceVisible        = FALSE
	END IF
END IF

IF NOT f_valid_part_number ( is_Part ) THEN
	i_b_trigger_clicked = FALSE
	f_beep ( 3 )
	MessageBox ( monsys.msg_title, "This part does not exist in the system!", Information!, OK! )
	Return
ELSE
	if NOT i_b_trigger_clicked then
		dw_customer_profile.Drag ( Begin! )
		ib_CustomerPart = TRUE
	else
		i_b_trigger_clicked = FALSE
	end if
END IF
end event

event itemchanged;string	l_s_part,&
	l_s_customer

if row = 0 then return

Choose Case dwo.name 

	Case "type"
		if GetText ( ) = 'C' then
			l_s_customer 	= object.part_customer_customer [ row ] 
			l_s_part	= object.part [ row ] 
			
			DELETE	FROM part_customer_price_matrix
			WHERE	customer = :l_s_customer AND
				part = :l_s_part ;
			if sqlca.sqlcode = 0 then
				commit;
			else
				rollback;
			end if
		end if
		
		i_b_trigger_clicked = TRUE
		TriggerEvent ( Clicked! )
		
End Choose


end event

event dragdrop;wf_drag_new_part ( is_Part, is_Customer, ib_Part )

ib_Part         = FALSE
ib_CustomerPart = FALSE
end event

event constructor;DataWindowChild	ldwc_units

GetChild ( "part_customer_customer_unit", ldwc_units )

ldwc_units.SetTransObject ( sqlca )
ldwc_units.InsertRow ( 0 )
end event

event rowfocuschanged;DataWindowChild	ldwc_units

if currentrow > 0 then
	
	GetChild ( "part_customer_customer_unit", ldwc_units )
	
	if ldwc_units.Retrieve ( object.part[currentrow] ) < 1 then
		ldwc_units.InsertRow ( 0 )
	end if
end if
end event

type gb_2 from groupbox within w_orders_customer_price_matrix
integer x = 731
integer y = 16
integer width = 2144
integer height = 776
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
string text = "Customer Profile"
end type

type gb_4 from groupbox within w_orders_customer_price_matrix
integer x = 1998
integer y = 800
integer width = 878
integer height = 632
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
string text = "Customer Price Matrix"
end type

