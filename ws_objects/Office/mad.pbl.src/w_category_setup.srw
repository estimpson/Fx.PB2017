$PBExportHeader$w_category_setup.srw
forward
global type w_category_setup from w_sheet_4t
end type
type dw_category from datawindow within w_category_setup
end type
end forward

global type w_category_setup from w_sheet_4t
integer height = 1560
string title = "Category Setup"
string menuname = "m_category_setup"
event ue_add pbm_custom01
event ue_delete pbm_custom02
event ue_save pbm_custom03
event ue_cancel pbm_custom04
dw_category dw_category
end type
global w_category_setup w_category_setup

type variables
Boolean	ib_Change = FALSE, &
	ib_changed

String   is_Category
Long    il_CatRow
end variables

event ue_add;Long l_NewRow, &
	  l_RowCount

l_RowCount = dw_category.RowCount ( )

IF l_RowCount >= 25 THEN
	MessageBox ( "Category Setup", &
		"The maximum of 25 categories has been met.  Unable" + &
		"to add a new category!", StopSign!, OK! )
	Return
ELSE 
	l_NewRow = dw_category.InsertRow ( 0 ) 
	dw_category.ScrollToRow ( dw_category.RowCount ( ) + 1 )
	dw_category.AcceptText ( )
	dw_category.SetColumn ( 1 )
	dw_category.SetFocus ( )
END IF

ib_Change = TRUE
end event

event ue_delete;LONG		l_l_row_count, &
			l_l_row

BOOLEAN	l_b_Found

SELECT	Count ( customer )
  INTO	:l_l_row_count
  FROM	customer
 WHERE	category = :is_Category  ;

l_b_Found = ( l_l_row_count > 0 )
IF l_b_Found THEN
	MessageBox ( 'Monitor For Windows', 'Category has been attached to ' + &
		String ( l_l_row_count ) + ' customer(s).  Unable to delete.', StopSign!, OK! )
ELSE
	l_l_row = 0
	DO WHILE dw_category.GetSelectedRow ( l_l_row ) > 0
		l_l_row = dw_category.GetSelectedRow ( l_l_row )
		dw_category.DeleteRow ( l_l_row )
		ib_change = TRUE
	LOOP
END IF
end event

event ue_save;IF ib_change THEN
	dw_category.AcceptText ( )
	IF dw_category.Update ( ) = -1 THEN
		MessageBox ( "Monitor for Windows", "Save of Category Failed!", StopSign!, OK! )
		Rollback;
	Else
		Commit;
		ib_changed = TRUE
		ib_change = FALSE
		MessageBox ( "Save Category Setup", "The information saved successfully!", Exclamation!, OK! )
	END IF
END IF

end event

event ue_cancel;INTEGER	l_i_decision
String 	s_Flag

IF ib_change = TRUE THEN
	l_i_decision = MessageBox ( 'Monitor for Windows', 'Save changes to categories?', Question!, YesNoCancel!, 1 )
	IF l_i_decision = 1 THEN
		TriggerEvent ( 'ue_save' )
	ELSEIF l_i_decision = 3 THEN
		Return
	END IF
	w_customer_category_pricing.dw_category.Reset ( )
	w_customer_category_pricing.dw_price_list.Reset ( )
	w_customer_category_pricing.dw_category.Retrieve ( )
	w_customer_category_pricing.dw_price_list.Retrieve ( )
	IF ib_changed = TRUE THEN
		s_Flag = w_customer_category_pricing.ddlb_1.Text
		IF NOT IsNull ( s_Flag ) AND s_Flag <> "" THEN
			w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, "", "" )
		END IF
	END IF
END IF

Close ( This )
end event

event open;call super::open;dw_category.SetTransObject ( SQLCA )
dw_category.Retrieve ( )
end event

on w_category_setup.create
int iCurrent
call super::create
if this.MenuName = "m_category_setup" then this.MenuID = create m_category_setup
this.dw_category=create dw_category
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_category
end on

on w_category_setup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_category)
end on

event resize;dw_category.Resize ( Width - 78, Height - 152 )
end event

type dw_category from datawindow within w_category_setup
integer x = 18
integer y = 24
integer width = 2418
integer height = 844
integer taborder = 10
string dataobject = "d_category_setup"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;ib_change = TRUE
end event

event itemchanged;ib_change = TRUE
end event

on clicked;Long l_Row

l_Row = dw_category.RowCount ( )

IF l_Row > 0 THEN
	dw_category.SelectRow ( 0, FALSE )
	il_CatRow = dw_category.GetClickedRow ( )

	IF il_CatRow > 0 THEN
		dw_category.SelectRow ( il_CatRow, TRUE )
		is_Category = dw_category.GetItemString ( il_CatRow, "code" )
	END IF

END IF


end on

