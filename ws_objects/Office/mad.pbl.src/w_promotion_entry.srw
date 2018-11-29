$PBExportHeader$w_promotion_entry.srw
forward
global type w_promotion_entry from w_sheet_4t
end type
type dw_1 from datawindow within w_promotion_entry
end type
type cb_1 from commandbutton within w_promotion_entry
end type
type cb_2 from commandbutton within w_promotion_entry
end type
type vsb_1 from vscrollbar within w_promotion_entry
end type
type dw_2 from datawindow within w_promotion_entry
end type
end forward

global type w_promotion_entry from w_sheet_4t
integer height = 1560
string title = "Promotion Maintenance"
string menuname = "m_promotion_entry"
event ue_save pbm_custom01
event ue_new ( )
event ue_cancel ( )
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
vsb_1 vsb_1
dw_2 dw_2
end type
global w_promotion_entry w_promotion_entry

type variables
Boolean ib_Changed = FALSE
end variables

event ue_save;String s_Part, &
		 s_Customer, &
		 s_Category, &
		 s_Flag, &
		 s_Flag2

Long l_Promotion

Date d_Today, &
	  d_Date[2]

Dec  dec_Price

d_Today  = Today ( )

d_Date[1] = dw_1.GetItemDate ( 1, "start_date" )
d_Date[2] = dw_1.GetItemDate ( 1, "end_date" )

s_category = dw_1.GetItemString( 1, "category" )
s_part     = dw_1.GetItemString( 1, "part" )
s_customer = dw_1.GetItemString( 1, "customer" )

IF DaysAfter ( d_Today, d_Date[1] ) < 0 OR &
	DaysAfter ( d_Today, d_Date[2] ) < 0 THEN
	MessageBox ( "Promotion Setup", "You cannot enter a date for " + &
					 "Start Date or End Date for a Promotion that is " + &
					 "earlier than today's date.", Exclamation!, OK! )

	dw_1.SetColumn ( "start_date" )
	dw_1.SetFocus ( )
	Return
ELSEIF DaysAfter ( d_Date[1], d_Date[2] ) < 0 THEN
	MessageBox ( "Promotion Setup", "You cannot enter a date for " + &
					 "End Date that is earlier than Start Date.", &
					 Exclamation!, OK! )

	dw_1.SetColumn ( "end_date" )
	dw_1.SetFocus ( )
	Return
END IF

SELECT Max ( promotion )
  INTO :l_Promotion
  FROM price_promotion	;

IF IsNull ( l_Promotion ) THEN l_Promotion = 0

dw_1.SetItem ( 1, "promotion", l_Promotion + 1 )

IF (isnull(s_customer) or s_customer <= '') Then
	MessageBox("System Message", "Customer cannot be null!")
	dw_1.SetFocus()
	Return
End If

IF (isnull(s_category) or s_category <= '') Then
	MessageBox("System Message", "Category cannot be null!")
	dw_1.SetFocus()
	Return
End If


SELECT promotion
INTO   :l_promotion
FROM   price_promotion
WHERE  category = :s_Category AND
		 part     = :s_part AND
		 customer = :s_customer ;

If SQLCA.SQLCODE = 0 THEN
	MessageBox ("System Message", "This Customer has a Promotion assigned!")
	dw_1.SetColumn ( "category" )
	dw_1.SetFocus ( )
	Return
End If

IF ib_Changed THEN
	IF dw_1.Update ( ) <> -1 THEN
		s_Part     = dw_1.GetItemString ( 1, "part" )
		s_Customer = dw_1.GetItemString ( 1, "customer" )
		s_Category = dw_1.GetItemString ( 1, "category" )
		dec_Price  = dw_1.GetItemDecimal ( 1, "price" )

		UPDATE part_customer_price_matrix
			SET price = :dec_Price
		 WHERE part     = :s_Part AND
				 customer = :s_Customer	;

		IF SQLCA.SQLCode = 0 THEN
			Commit;
			MessageBox ( "Save Promotion", "The information saved successfully.", Information!, OK! )
//			Close ( w_promotion_entry )
			w_customer_category_pricing.dw_category.Reset ( )
			w_customer_category_pricing.dw_price_list.Reset ( )
			w_customer_category_pricing.dw_category.Retrieve ( )
			w_customer_category_pricing.dw_price_list.Retrieve ( )

			s_Flag = w_customer_category_pricing.ddlb_1.Text
			s_Flag2 = w_customer_category_pricing.ddlb_2.Text
	
			IF NOT IsNull ( s_Flag ) OR s_Flag <> "" THEN
				w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, s_Flag2, "" )
			END IF

		ELSE
			Rollback;
			MessageBox ( "Save Promotion", "Save of Promotion Failed!", Exclamation!, OK! )
			Return
		END IF
	END IF
END IF
dw_1.hide()
dw_2.show()
dw_2.retrieve()
end event

event ue_new;dw_1.SetTransObject ( SQLCA )
dw_1.InsertRow ( 1 )
dw_1.show()
dw_1.SetItem(1, "start_Date", today())
dw_2.hide()
end event

event ue_cancel;dw_1.reset()
dw_1.hide()
dw_2.show()
end event

event open;call super::open;//dw_1.SetTransObject ( SQLCA )
//dw_1.InsertRow ( 1 )
//
//dw_1.SetItem(1, "start_Date", today())

long	ll_width
long	ll_height

ll_width = width
ll_height = height

dw_2.resize ( ll_width - 100, ll_height - 100 )
end event

on w_promotion_entry.create
int iCurrent
call super::create
if this.MenuName = "m_promotion_entry" then this.MenuID = create m_promotion_entry
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.vsb_1=create vsb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.vsb_1
this.Control[iCurrent+5]=this.dw_2
end on

on w_promotion_entry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.vsb_1)
destroy(this.dw_2)
end on

type dw_1 from datawindow within w_promotion_entry
boolean visible = false
integer x = 41
integer y = 40
integer width = 1696
integer height = 1024
integer taborder = 10
string dataobject = "d_promotion_entry"
boolean border = false
boolean livescroll = true
end type

on itemchanged;String s_Customer, &
		 s_Category, &
		 s_Column

s_Column = dw_1.GetColumnName ( )

IF s_Column = "customer" THEN
	s_Customer = dw_1.GetItemString ( 1, "customer" )

	SELECT category
	  INTO :s_Category
	  FROM customer
	 WHERE customer = :s_Customer	;

	dw_1.SetItem ( 1, "category", s_Category )

END IF

ib_Changed = TRUE
end on

type cb_1 from commandbutton within w_promotion_entry
boolean visible = false
integer x = 978
integer y = 960
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "OK"
boolean default = true
end type

on clicked;String s_Part, &
		 s_Customer, &
		 s_Category, &
		 s_Flag, &
		 s_Flag2

Long l_Promotion

Date d_Today, &
	  d_Date[2]

Dec  dec_Price

d_Today  = Today ( )

d_Date[1] = dw_1.GetItemDate ( 1, "start_date" )
d_Date[2] = dw_1.GetItemDate ( 1, "end_date" )

s_category = dw_1.GetItemString( 1, "category" )
s_part     = dw_1.GetItemString( 1, "part" )
s_customer = dw_1.GetItemString( 1, "customer" )

IF DaysAfter ( d_Today, d_Date[1] ) < 0 OR &
	DaysAfter ( d_Today, d_Date[2] ) < 0 THEN
	MessageBox ( "Promotion Setup", "You cannot enter a date for " + &
					 "Start Date or End Date for a Promotion that is " + &
					 "earlier than today's date.", Exclamation!, OK! )

	dw_1.SetColumn ( "start_date" )
	dw_1.SetFocus ( )
	Return
ELSEIF DaysAfter ( d_Date[1], d_Date[2] ) < 0 THEN
	MessageBox ( "Promotion Setup", "You cannot enter a date for " + &
					 "End Date that is earlier than Start Date.", &
					 Exclamation!, OK! )

	dw_1.SetColumn ( "end_date" )
	dw_1.SetFocus ( )
	Return
END IF

SELECT Max ( promotion )
  INTO :l_Promotion
  FROM price_promotion	;

IF IsNull ( l_Promotion ) THEN l_Promotion = 0

dw_1.SetItem ( 1, "promotion", l_Promotion + 1 )

IF s_category < '' Then
	MessageBox("System Message", "Category cannot be null!")
	dw_1.SetFocus()
	Return
End If

SELECT promotion
INTO   :l_promotion
FROM   price_promotion
WHERE  category = :s_Category AND
		 part     = :s_part AND
		 customer = :s_customer ;

If SQLCA.SQLCODE = 0 THEN
	MessageBox ("System Message", "This Customer has a Promotion assigned!")
	dw_1.SetColumn ( "category" )
	dw_1.SetFocus ( )
	Return
End If

IF ib_Changed THEN
	IF dw_1.Update ( ) <> -1 THEN
		s_Part     = dw_1.GetItemString ( 1, "part" )
		s_Customer = dw_1.GetItemString ( 1, "customer" )
		s_Category = dw_1.GetItemString ( 1, "category" )
		dec_Price  = dw_1.GetItemDecimal ( 1, "price" )

		UPDATE part_customer_price_matrix
			SET price = :dec_Price
		 WHERE part     = :s_Part AND
				 customer = :s_Customer	;

		IF SQLCA.SQLCode = 0 THEN
			Commit;
			MessageBox ( "Save Promotion", "The information saved successfully.", Information!, OK! )
			Close ( w_promotion_entry )
			w_customer_category_pricing.dw_category.Reset ( )
			w_customer_category_pricing.dw_price_list.Reset ( )
			w_customer_category_pricing.dw_category.Retrieve ( )
			w_customer_category_pricing.dw_price_list.Retrieve ( )

			s_Flag = w_customer_category_pricing.ddlb_1.Text
			s_Flag2 = w_customer_category_pricing.ddlb_2.Text
	
			IF NOT IsNull ( s_Flag ) OR s_Flag <> "" THEN
				w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, s_Flag2, "" )
			END IF

		ELSE
			Rollback;
			MessageBox ( "Save Promotion", "Save of Promotion Failed!", Exclamation!, OK! )
			Return
		END IF
	END IF
END IF
end on

type cb_2 from commandbutton within w_promotion_entry
boolean visible = false
integer x = 1349
integer y = 960
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancel"
boolean cancel = true
end type

event clicked;//Close ( w_promotion_entry )
end event

type vsb_1 from vscrollbar within w_promotion_entry
boolean visible = false
integer x = 512
integer y = 60
integer width = 59
integer height = 80
boolean stdwidth = false
end type

type dw_2 from datawindow within w_promotion_entry
integer x = 37
integer y = 20
integer width = 3131
integer height = 1760
integer taborder = 20
string dataobject = "d_price_promotion_listing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject ( sqlca ) 
retrieve()
end event

event doubleclicked;s_price	st_price
st_price.spart = object.part [ row ] 
st_price.scategory = object.category [ row ]
OpenSheetwithparm(w_edit_price_promotion, st_price, w_promotion_entry , 3, Original!)
retrieve()

end event

