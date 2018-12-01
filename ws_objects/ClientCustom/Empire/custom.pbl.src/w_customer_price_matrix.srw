$PBExportHeader$w_customer_price_matrix.srw
forward
global type w_customer_price_matrix from window
end type
type dw_add_profile from datawindow within w_customer_price_matrix
end type
type cb_add_cancel from commandbutton within w_customer_price_matrix
end type
type cb_add_ok from commandbutton within w_customer_price_matrix
end type
type st_add_title from statictext within w_customer_price_matrix
end type
type st_2 from statictext within w_customer_price_matrix
end type
type st_1 from statictext within w_customer_price_matrix
end type
type dw_part_info from datawindow within w_customer_price_matrix
end type
type cb_add_back from commandbutton within w_customer_price_matrix
end type
type dw_price_matrix from datawindow within w_customer_price_matrix
end type
type lb_temp from listbox within w_customer_price_matrix
end type
type dw_customer_part_list from datawindow within w_customer_price_matrix
end type
end forward

global type w_customer_price_matrix from window
integer x = 672
integer y = 264
integer width = 3099
integer height = 1836
boolean titlebar = true
string title = "Customer Price Matrix"
string menuname = "m_customer_price_matrix_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event add_item pbm_custom01
event add_price pbm_custom02
event save_item pbm_custom04
event delete_vendor pbm_custom03
event delete_price pbm_custom05
event packaging pbm_custom06
event ue_exit pbm_custom07
dw_add_profile dw_add_profile
cb_add_cancel cb_add_cancel
cb_add_ok cb_add_ok
st_add_title st_add_title
st_2 st_2
st_1 st_1
dw_part_info dw_part_info
cb_add_back cb_add_back
dw_price_matrix dw_price_matrix
lb_temp lb_temp
dw_customer_part_list dw_customer_part_list
end type
global w_customer_price_matrix w_customer_price_matrix

type variables
String 	is_Part, &
	szPart

Dec 	dBreakQty    // Current Break Qty Displayed

Long 	lRow

Boolean 	bAdd, &
              ib_cust_save_change = TRUE, &
              ib_price_save_change = TRUE, &
              ib_blanket_price = FALSE

DataWindowChild 	dwcUnitList
end variables

forward prototypes
public subroutine wf_add_mode (boolean bmode)
public subroutine wf_screen_mode (boolean bmode)
end prototypes

event add_item;wf_add_mode ( True )
end event

event add_price;String	ls_Customer
Dec		ld_Price

If dw_customer_part_list.RowCount ( ) < 1 Then
	MessageBox ( "Error", "No customers exist for adding price matrix!", StopSign! )
	Return
Elseif dw_customer_part_list.GetRow ( ) < 1 Or Not dw_customer_part_list.IsSelected ( dw_customer_part_list.GetRow ( ) ) Then
	MessageBox ( "Error", "Please select a customer to add price matrix to!", StopSign! )
	Return
End if

ls_Customer = f_get_string_value ( dw_Customer_part_list.GetItemString ( dw_customer_part_list.GetRow ( ), "Customer" ) )

SelectRow ( dw_price_matrix, 0, False )

dw_price_matrix.InsertRow ( 0 )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "price", 0 )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "Customer", ls_Customer )
dw_price_matrix.SetItem ( dw_price_matrix.RowCount ( ), "part", is_Part )

dw_price_matrix.SetRow ( dw_price_matrix.RowCount ( ) )
dw_price_matrix.SetFocus ( )
end event

on save_item;Long l_Row

Int  i_Count

Dec  d_qty

/* Routine to check if the qty break is < zero */

If dw_price_matrix.AcceptText ( ) = -1 Then Return

For i_Count = 1 to dw_price_matrix.RowCount ( ) 

   d_qty = dw_price_matrix.GetItemDecimal ( i_Count, "qty_break" )

	If Isnull(String(d_qty)) Then

	   MessageBox ( "Error", "'Qty Break' cannot be null!", Exclamation!)
      dw_price_matrix.SetRow ( i_count )
      Return

	End If

Next

/* Save Routine */

If dw_customer_part_list.Update ( ) = -1 Then

	RollBack ;
	w_customer_price_matrix.SetMicroHelp ( "Save of Customer/part list failed!" )

Else

	If dw_price_matrix.Update ( ) = -1 Then

		RollBack ;
		w_customer_price_matrix.SetMicroHelp ( "Save of price matrix failed!" )

	Else

		Commit ;
      ib_price_save_change = TRUE
      w_customer_price_matrix.SetMicroHelp ( "Price Matrix saved...." )

	End if

End if


end on

on delete_vendor;//  Declare Variables
Long		ll_Row
String	ls_Customer
Int		li_RtnCode
Boolean	bDeleteMatrix

//  Initialize Variables
ll_Row = dw_Customer_part_list.GetRow ( )

//  Main
If ll_Row < 1 Then
	MessageBox ( "Error", "You must select a Customer to delete!", StopSign! )
	Return
End if

ls_Customer = dw_Customer_part_list.GetItemString ( ll_Row, "Customer" )

If dw_price_matrix.RowCount ( ) > 0 Then
	li_RtnCode = MessageBox ( "Delete Customer", "Are you sure you want to delete " + ls_Customer + " and the price matrix associated with them?", Question!, YesNo!, 2 )
	bDeleteMatrix = True
Else
	li_RtnCode = MessageBox ( "Delete Customer", "Are you sure you want to delete " + ls_Customer + "?", Question!, YesNo!, 2 )
End if


If li_RtnCode = 1 Then
	If bDeleteMatrix Then
		DELETE FROM part_Customer_price_matrix
		 WHERE ( Customer = :ls_Customer ) AND  
       		 ( part = :is_Part )   ;

		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			MessageBox ( "Error", "Deletion of price matrix failed!  Unable to delete Customer.", StopSign! )
			Return
		End if
	End if
		DELETE FROM part_Customer
		 WHERE ( part = :is_Part ) AND  
		       ( Customer = :ls_Customer )   ;

		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			MessageBox ( "Error", "Deletion of Customer " + ls_Customer + " failed!", StopSign! )
			Return
		Else
			Commit ;
		End if	

	dw_Customer_part_list.Retrieve ( is_Part )
	If bDeleteMatrix Then dw_price_matrix.Retrieve ( is_Part, ls_Customer )

End if


end on

on delete_price;//  Declare Variables
Long	ll_Row
Int	li_RtnCode
Dec	{2} ld_BreakQty

//  Initialize Variables
ll_Row = dw_price_matrix.GetRow ( )

//  Main
If ll_Row < 1 Then
	MessageBox ( "Error", "You must choose a break quantity to delete!", StopSign! )
	Return
End if

ld_BreakQty = f_get_value ( dw_price_matrix.GetItemNumber ( ll_Row, "qty_break" ) )
li_RtnCode = MessageBox ( "Delete Break Quantity", "Are you sure you want to delete break quantity " + String ( ld_BreakQty ) + "?", Question!, YesNo!, 2 )

If li_RtnCode = 1 Then
	dw_price_matrix.DeleteRow ( ll_Row )
	If dw_price_matrix.Update ( ) = -1 Then
		RollBack ;
		MessageBox ( "Error", "Deletion of break quantity failed!", StopSign! )
	Else
		Commit ;
	End if
End if
end on

event packaging;szPart = dw1.GetItemString ( 1, "part" )

OpenSheetWithParm ( w_part_package_materials, szPart, wMainScreen, 0, Layered! )
end event

on ue_exit;Integer imess1, imess2

If NOT ib_cust_save_change Then
	imess1 = Messagebox ("Warning", "Do you want to save the changes?", &
								Exclamation!, YesNoCancel!, 1)
	If imess1 = 1 Then
      w_customer_price_matrix.cb_add_ok.TriggerEvent ( Clicked! )

	Elseif imess1 = 2 Then
		ib_cust_save_change= TRUE

	Else
		Return

	End If
End If

If NOT ib_price_save_change Then
	imess2 = Messagebox ("Warning", "Do you want to save the changes?", &
								Exclamation!, YesNoCancel!, 1)
	If imess2 = 1 Then
      w_customer_price_matrix.TriggerEvent ( "save_item" )

	Elseif imess2 = 2 Then
		ib_price_save_change = TRUE

	Else
		Return

	End If
End If

If ib_cust_save_change AND ib_price_save_change Then

	Close (This)

End If
end on

public subroutine wf_add_mode (boolean bmode);DataWindowChild	ldwc_units

If bMode Then
	wf_screen_mode ( False )
	cb_add_back.Show ( )
	cb_add_ok.Show ( )
	cb_add_cancel.Show ( )
	st_add_title.Show ( )
	dw_add_profile.SetTransObject ( sqlca )
	dw_add_profile.InsertRow ( 1 )
	dw_add_profile.GetChild ( "customer_unit", ldwc_units )
	ldwc_units.Retrieve ( is_part )
	dw_add_profile.SetItem ( 1, "type", 'B' )
	dw_add_profile.Show ( )
	dw_add_profile.SetFocus ( )
Else
	cb_add_ok.Hide ( )
	cb_add_cancel.Hide ( )
	st_add_title.Hide ( )
	dw_add_profile.Hide ( )
	cb_add_back.Hide ( )
	wf_screen_mode ( True )
End if
end subroutine

public subroutine wf_screen_mode (boolean bmode);dw_Customer_part_list.Enabled = bMode
dw_price_matrix.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_add.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_addprice.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_delete.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_deleteprice.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_save.Enabled = bMode
m_Customer_price_matrix_menu.m_file.m_close.Enabled = bMode

end subroutine

event open;//  Set Hourglass
SetPointer ( HourGlass! )

//  Declare Local Variables
String	ls_Customer

//  Initialize Variables
gnv_App.of_GetFrame().ChangeMenu ( m_customer_price_matrix_menu )
is_Part = Message.StringParm

//  Declare DataWindows
dw_customer_part_list.SetTransObject ( sqlca )
dw_price_matrix.SetTransObject ( sqlca )
dw_part_info.SetTransObject ( sqlca )

dw_part_info.Retrieve ( is_Part )

//  Retrieve All Of the Possible Combos

If dw_customer_part_list.Retrieve ( is_Part ) > 0 Then
	dw_customer_part_list.SetRow ( 1 )
	SelectRow ( dw_customer_part_list, 1, True )
	ls_Customer = f_get_string_value ( dw_customer_part_list.GetItemString ( 1, "customer" ) )
	dw_price_matrix.Retrieve ( is_Part, ls_Customer )
End if
end event

on w_customer_price_matrix.create
if this.MenuName = "m_customer_price_matrix_menu" then this.MenuID = create m_customer_price_matrix_menu
this.dw_add_profile=create dw_add_profile
this.cb_add_cancel=create cb_add_cancel
this.cb_add_ok=create cb_add_ok
this.st_add_title=create st_add_title
this.st_2=create st_2
this.st_1=create st_1
this.dw_part_info=create dw_part_info
this.cb_add_back=create cb_add_back
this.dw_price_matrix=create dw_price_matrix
this.lb_temp=create lb_temp
this.dw_customer_part_list=create dw_customer_part_list
this.Control[]={this.dw_add_profile,&
this.cb_add_cancel,&
this.cb_add_ok,&
this.st_add_title,&
this.st_2,&
this.st_1,&
this.dw_part_info,&
this.cb_add_back,&
this.dw_price_matrix,&
this.lb_temp,&
this.dw_customer_part_list}
end on

on w_customer_price_matrix.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_add_profile)
destroy(this.cb_add_cancel)
destroy(this.cb_add_ok)
destroy(this.st_add_title)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_part_info)
destroy(this.cb_add_back)
destroy(this.dw_price_matrix)
destroy(this.lb_temp)
destroy(this.dw_customer_part_list)
end on

type dw_add_profile from datawindow within w_customer_price_matrix
boolean visible = false
integer x = 997
integer y = 364
integer width = 1051
integer height = 1008
integer taborder = 80
string dataobject = "d_customer_add_profile"
boolean border = false
end type

on itemerror;dw_add_profile.SetText ( "" )
end on

event itemchanged;ib_cust_save_change = False

IF dwo.name = 'blanket_price' THEN
	ib_blanket_price = TRUE
END IF
end event

on editchanged;ib_cust_save_change = False
end on

event constructor;DataWindowChild	ldwc_units

GetChild ( "customer_unit", ldwc_units )

ldwc_units.SetTransObject ( sqlca )
ldwc_units.InsertRow ( 0 )
end event

event retrieveend;DataWindowChild	ldwc_units

GetChild ( "customer_unit", ldwc_units )

ldwc_units.Retrieve ( is_part )
end event

type cb_add_cancel from commandbutton within w_customer_price_matrix
boolean visible = false
integer x = 1541
integer y = 1404
integer width = 293
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

event clicked;dw_add_profile.reset()
ib_cust_save_change = TRUE
ib_blanket_price = FALSE

wf_add_mode ( False )
end event

type cb_add_ok from commandbutton within w_customer_price_matrix
boolean visible = false
integer x = 1070
integer y = 1404
integer width = 293
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
boolean default = true
end type

event clicked;String	ls_Customer, &
   		ls_CustomerList, &
			ls_CustomerPart, &
			ls_part, &
			ls_customer1

Long     ll_Rows, &
			ll_Row, &
		   ll_Counter, &
		   ll_StdPack, &
         l_Row_Count, &
         l_Row_Count1

Dec      d_standard_pack, &
			ld_price

st_generic_Structure lst_values


/* To check IF the standard pack is null */

dw_add_profile.Setitem ( 1, "part", is_part )

IF dw_add_profile.AcceptText ( ) = -1 THEN
	dw_add_profile.SetFocus ( )
	Return
END IF

/* Initialize the variables */

ls_Customer = dw_add_profile.GetItemString ( 1, "customer" )
ls_CustomerPart = dw_add_profile.GetItemString ( 1, "customer_part" )
d_standard_pack = dw_add_profile.GetItemNumber ( 1, "customer_standard_pack" )
ld_price =  dw_add_profile.GetItemDecimal ( 1, "blanket_price" )
ls_part	=  dw_add_profile.GetItemString ( 1, "part" )

/* check routine */

IF String(d_standard_pack) = '' OR IsNull (d_standard_pack) THEN
	Messagebox ( monsys.msg_title, "Standard Pack must have a value!", Exclamation! )
	dw_add_profile.SetColumn( "customer_standard_pack" )
	Return
END IF

IF ls_CustomerPart = '' OR IsNull (ls_CustomerPart)  THEN
	Messagebox ( monsys.msg_title, "You must enter the customer part!", Exclamation! )
	dw_add_profile.SetColumn( "customer_part" )
	Return
END IF

// check if blanket_price is changed and check if other tables need to be updated - mnb01/22/04
/*IF ib_blanket_price THEN
	
		select customer
		into :ls_customer1
		from part_customer
		where part= :ls_part and 
				customer= :ls_customer ;
				
		IF SQLCA.SQLCODE = 0 THEN
			
				lst_values.value1 = ls_part
				lst_values.value2 = ls_customer
				lst_values.value3 = 'w_customer_price_matrix'
	
				openwithparm ( w_price_update_query, lst_values )
				
				lst_values = message.powerobjectparm
				
				IF lst_values.value1 = 'Y' THEN
						UPDATE order_header
							SET alternate_price = :ld_price
						WHERE ( isnull(order_header.status,'O') = 'O' )  and 
								( order_header.customer= :ls_customer ) and
								( order_header.blanket_part = :ls_part ) and
								( isnull(order_header.order_type,'B') = 'B' ) ;
								
						IF SQLCA.SQLCode = 0 THEN
					
							UPDATE order_detail, order_header
							SET order_detail.alternate_price = :ld_price
							WHERE ( order_header.order_no = order_detail.order_no ) and  
									( isnull(order_header.status,'O') = 'O' ) and 
									( order_header.customer= :ls_customer ) and
									( order_detail.part_number = :ls_part ) and
									( isnull(order_header.order_type,'B') = 'B' ) ;
						END IF
				END IF
		
				IF lst_values.value2 = 'Y' THEN
						UPDATE shipper_detail, shipper
						SET shipper_detail.alternate_price = :ld_price
						WHERE ( shipper.id = shipper_detail.shipper ) and  
								( shipper.status in (  'O', 'S' )  )   and 
								( shipper.customer= :ls_customer ) and
								( shipper_detail.part = :ls_part );			
						
						IF SQLCA.SQLCode <> 0 THEN
							MessageBox ( monsys.msg_title, "Unable to Update Price on Open Shippers for part : " + ls_part + " and customer : " + ls_customer +"!", Exclamation!, OK! )
						END IF
		
				END IF
		
				IF lst_values.value3 = 'Y' THEN
						UPDATE shipper_detail, shipper
						SET shipper_detail.alternate_price = :ld_price
						WHERE ( shipper.id = shipper_detail.shipper ) and
								( shipper.invoice_printed = 'N' ) and
								( shipper.customer= :ls_customer ) and
								( shipper_detail.part = :ls_part );			
								
						IF SQLCA.SQLCode <> 0 THEN
							MessageBox ( monsys.msg_title, "Unable to Update price on Unprinted Invoice for part : " + ls_part + " and customer : " + ls_customer + "!", Exclamation!, OK! )
						END IF
				END IF
		END IF	
	
END IF*/

dw_add_profile.AcceptText ( )

IF dw_add_profile.Update ( ) = 1 THEN
	Commit ;
   ib_cust_save_change = TRUE
	ib_blanket_price = FALSE
Else
	Rollback ;  
END IF

wf_add_mode ( False )

IF dw_Customer_part_list.Retrieve ( is_Part ) > 0 THEN

	ll_Row = dw_Customer_part_list.find ( "customer = '" + ls_Customer + "' and " + &
		"customer_part = '" + ls_CustomerPart + "'", 1, dw_Customer_part_list.RowCount ( ) )

	IF ll_Row > 0 THEN
		dw_Customer_part_list.SetRow ( ll_Row )
		SelectRow ( dw_Customer_part_list, 0, False )
		SelectRow ( dw_Customer_part_list, ll_Row, True )
		dw_price_matrix.SetTransObject ( sqlca )
		dw_price_matrix.Retrieve ( is_Part, ls_Customer )
	END IF

END IF

end event

type st_add_title from statictext within w_customer_price_matrix
boolean visible = false
integer x = 951
integer y = 268
integer width = 1102
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Add Part / Customer Profile"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_customer_price_matrix
integer x = 1957
integer y = 128
integer width = 914
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Price Matrix"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_customer_price_matrix
integer x = 18
integer y = 128
integer width = 1902
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Part / Customer List"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_part_info from datawindow within w_customer_price_matrix
integer x = 37
integer y = 16
integer width = 1262
integer height = 96
integer taborder = 10
boolean enabled = false
string dataobject = "d_vendor_matrix_part_info"
boolean border = false
end type

type cb_add_back from commandbutton within w_customer_price_matrix
boolean visible = false
integer x = 933
integer y = 240
integer width = 1129
integer height = 1340
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type dw_price_matrix from datawindow within w_customer_price_matrix
integer x = 1957
integer y = 208
integer width = 914
integer height = 1200
integer taborder = 20
string dataobject = "d_customer_price_matrix"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on itemchanged;ib_price_save_change = False
end on

on editchanged;ib_price_save_change = False
end on

on itemerror;dw_price_matrix.SetText ( "" )
end on

on clicked;//  Declare Variables
Long	ll_Row

//  Initialize Variables
ll_Row = This.GetClickedRow ( )

//  Main
If ll_Row < 1 Then Return

This.SetRow ( ll_Row )

SelectRow ( This, 0, False )
SelectRow ( This, ll_Row, True )

end on

type lb_temp from listbox within w_customer_price_matrix
boolean visible = false
integer x = 795
integer y = 700
integer width = 494
integer height = 360
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_customer_part_list from datawindow within w_customer_price_matrix
integer x = 18
integer y = 208
integer width = 1902
integer height = 1200
integer taborder = 60
string dataobject = "d_customer_part_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;Long		l_Row
String	s_Customer, &
         s_Part

//	Initialize Variables
l_Row = row //dw_customer_part_list.GetClickedRow ( )

If l_Row < 1 Then Return

s_Customer = This.GetItemString ( l_Row, "Customer" ) 
s_Part     = This.GetItemString ( l_Row, "customer_part" )

dw_price_matrix.SetTransObject ( sqlca )
dw_price_matrix.Retrieve ( is_Part, s_Customer )

cb_add_back.Show ( )
cb_add_ok.Show ( )
cb_add_cancel.Show ( )
st_add_title.Show ( )
dw_add_profile.Show ( )
dw_add_profile.SetFocus ( )
dw_add_profile.SetTransObject ( sqlca )
dw_add_profile.Retrieve ( s_Customer, s_part)
dw_add_profile.visible = true

end event

on clicked;//	Declare Local Variables
Long		ll_Row
String	ls_Customer

//	Initialize Variables
ll_Row = This.GetClickedRow ( )
SelectRow ( This, 0, False )
If ll_Row < 1 Then Return
This.SetRow ( ll_Row )
SelectRow ( This, ll_Row, True )
ls_Customer = f_get_string_value ( This.GetItemString ( ll_Row, "Customer" ) )
dw_price_matrix.SetTransObject ( sqlca )
dw_price_matrix.Retrieve ( is_Part, ls_Customer )
end on

