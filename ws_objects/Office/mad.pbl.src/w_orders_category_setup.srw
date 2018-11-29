$PBExportHeader$w_orders_category_setup.srw
forward
global type w_orders_category_setup from w_sheet_4t
end type
type dw_2 from datawindow within w_orders_category_setup
end type
type dw_category from datawindow within w_orders_category_setup
end type
type cb_2 from commandbutton within w_orders_category_setup
end type
type cb_1 from commandbutton within w_orders_category_setup
end type
type dw_1 from datawindow within w_orders_category_setup
end type
end forward

global type w_orders_category_setup from w_sheet_4t
integer height = 1560
string title = "Customer/Category Setup"
string menuname = "m_category_for_pricing"
event ue_save pbm_custom01
dw_2 dw_2
dw_category dw_category
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_orders_category_setup w_orders_category_setup

type variables
Boolean ib_Changed = FALSE
end variables

forward prototypes
public subroutine wf_recalc ()
end prototypes

event ue_save;string	l_s_message

dw_1.AcceptText ( )

if dw_1.Update ( ) = -1 then
	l_s_message = sqlca.sqlerrtext
	rollback;
	MessageBox ( "Database Error", "Unable to save window contents!~r~nReason:" + l_s_message, StopSign! )
	return
else
	commit;
end if

//wf_recalc()

//Close ( Parent )
end event

public subroutine wf_recalc ();long				ll_current_row,&
					ll_count
boolean			lb_done
string			ls_category,&
					ls_part,&
					ls_premium,&
					ls_type,&
					ls_customer,&
					ls_old_category
dec				ldec_markup,&
					ldec_premium,&
					ldec_price,&
					ldec_std_price,&
					ldec_new_premium

str_Progress 	lstr_parm

Do While NOT lb_done
	ll_current_row = dw_1.GetNextModified ( ll_current_row, PRIMARY! )
	if ll_current_row < 1 then
		lb_done = TRUE
	else
		ls_old_category	= dw_1.GetItemString ( ll_current_row, "category", PRIMARY!, TRUE )
		ls_category			= dw_1.GetItemString ( ll_current_row, "category" )
		ls_customer			= dw_1.GetItemString ( ll_current_row, "customer" )

		dw_category.Retrieve ( ls_category )
		ldec_markup		= dw_category.GetItemNumber ( 1, "markup" )
		ldec_premium	= dw_category.GetItemNumber ( 1, "premium" )
		ls_type			= dw_category.GetItemString ( 1, "multiplier" )

		delete	from part_customer_price_matrix
					from part_customer,
					part_customer_price_matrix
		where		( part_customer_price_matrix.part = part_customer.part ) and
					( part_customer_price_matrix.customer = part_customer.customer ) and
					( part_customer.type = 'C' ) and
					( part_customer_price_matrix.category = :ls_old_category );

		if sqlca.sqlcode = 0 then
			commit ;
		else
			messagebox("System Message", sqlca.sqlerrtext )
		end If

		if dw_2.Retrieve ( ls_customer ) > 0 then
	
			lstr_parm.Title	= "Updating Part/Customer"
			OpenWithParm ( w_progress, lstr_parm )
		
			For ll_count = 1 to dw_2.RowCount ( )
				w_progress.wf_progress( ll_count / dw_2.rowcount ( ), "Updating Part: " + ls_part )
				ldec_new_premium = ldec_premium
				ls_part 		= dw_2.GetItemString ( ll_count, "part" )
				ls_customer	= dw_2.GetItemString ( ll_count, "customer" )
		  		SELECT price, premium
		    	  INTO :ldec_std_price,
						 :ls_premium  
		    	  FROM part_standard  
		  		 WHERE part_standard.part = :ls_part   ;
				if f_get_string_value ( upper ( ls_premium ) ) <> "Y" then
					ldec_new_premium = 0
				end if
				Choose Case ls_type
					Case "+"
						ldec_price = ldec_std_price + ldec_markup + ldec_new_premium
					Case "-"
						ldec_price = ldec_std_price - ldec_markup + ldec_new_premium
					Case "%"
						ldec_price = (ldec_std_price + ( ldec_std_price * ldec_markup * 0.01)) + ldec_new_premium
					Case "x"
						ldec_price = ldec_std_price * ldec_markup + ldec_new_premium
				End Choose

  				INSERT INTO part_customer_price_matrix  
         				( part,   
				           customer,   
				           code,   
				           price,   
				           qty_break,   
				           discount,   
				           category )  
				  VALUES ( :ls_part,   
				           :ls_customer,   
				           null,   
				           :ldec_price,   
				           0,   
				           0,   
				           :ls_category )  ;

				if sqlca.sqlcode <> 0 then
					rollback;
				end if
			Next
			Close ( w_progress )
		end if
	end if
Loop

If dw_1.Update ( ) = -1 then
	rollback;
else
	commit;
end if


end subroutine

on open;dw_1.Retrieve ( )

end on

on w_orders_category_setup.create
int iCurrent
call super::create
if this.MenuName = "m_category_for_pricing" then this.MenuID = create m_category_for_pricing
this.dw_2=create dw_2
this.dw_category=create dw_category
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_category
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_orders_category_setup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_category)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event resize;call super::resize;dw_1.width = width - 50
dw_1.height = height - 100
dw_1.modify ( "customer.width ='"+string ( dw_1.width * 0.45 ) + "'")
dw_1.modify ( "category.width ='"+string ( dw_1.width * 0.45 ) + "'")
end event

type dw_2 from datawindow within w_orders_category_setup
boolean visible = false
integer x = 347
integer y = 272
integer width = 494
integer height = 360
integer taborder = 20
string dataobject = "d_part_list_per_part_customer"
boolean livescroll = true
end type

on constructor;SetTransObject ( sqlca )
end on

type dw_category from datawindow within w_orders_category_setup
boolean visible = false
integer x = 1061
integer y = 416
integer width = 50
integer height = 360
integer taborder = 30
string dataobject = "d_category_setup_per"
boolean livescroll = true
end type

on constructor;SetTransObject ( sqlca )
end on

type cb_2 from commandbutton within w_orders_category_setup
boolean visible = false
integer x = 357
integer y = 888
integer width = 347
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancel"
boolean cancel = true
end type

on clicked;Close ( w_orders_category_setup )
end on

type cb_1 from commandbutton within w_orders_category_setup
boolean visible = false
integer x = 736
integer y = 888
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&OK"
end type

on clicked;string	l_s_message

dw_1.AcceptText ( )

if dw_1.Update ( ) = -1 then
	l_s_message = sqlca.sqlerrtext
	rollback;
	MessageBox ( "Database Error", "Unable to save window contents!~r~nReason:" + l_s_message, StopSign! )
	return
else
	commit;
end if

//wf_recalc()

Close ( Parent )


end on

type dw_1 from datawindow within w_orders_category_setup
integer x = 32
integer y = 28
integer width = 1051
integer height = 912
integer taborder = 10
string dataobject = "d_orders_category_setup"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;datawindowchild	ldwc_category

dw_1.GetChild('category', ldwc_category)

// Set the transaction object for the child

ldwc_category.SetTransObject(SQLCA)

// Populate the child with values for eastern states

ldwc_category.Retrieve()
ldwc_category.insertrow(1)

// Set transaction object for main DW and retrieve

dw_1.SetTransObject(SQLCA)

//dw_1.Retrieve()
end event

on itemchanged;//ib_Changed = TRUE
end on

