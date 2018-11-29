$PBExportHeader$w_edit_price_promotion.srw
forward
global type w_edit_price_promotion from Window
end type
type dw_edit_price from datawindow within w_edit_price_promotion
end type
end forward

global type w_edit_price_promotion from Window
int X=1
int Y=293
int Width=2913
int Height=1541
boolean TitleBar=true
string Title="Price Promotion Entry"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=child!
event delete_promo pbm_custom01
event save_promo pbm_custom02
dw_edit_price dw_edit_price
end type
global w_edit_price_promotion w_edit_price_promotion

type variables
long l_row
end variables

on delete_promo;String s_Flag, &
		 s_Flag2

Long  i_promotion

If l_row <= 0 then 

	gnv_App.of_GetFrame().SetMicroHelp("Select a row...")
	return

Else

	i_promotion = dw_edit_price.GetItemNumber(l_row, "promotion")

	If MessageBox ("System Message", "Are you sure about deleting promotion " + string(i_promotion) + " ?", Question!, YesNo!, 2) = 1 Then
		
		dw_edit_price.deleterow(l_row)

		If dw_edit_price.Update() > 0 Then
			Commit ;
			gnv_App.of_GetFrame().SetMicroHelp("Promotion deleted..")

			s_Flag = w_customer_category_pricing.ddlb_1.Text
			s_Flag2 = w_customer_category_pricing.ddlb_2.Text

			w_customer_category_pricing.dw_category.Reset ( )
			w_customer_category_pricing.dw_price_list.Reset ( )
			w_customer_category_pricing.dw_category.Retrieve ( )
			w_customer_category_pricing.dw_price_list.Retrieve ( )

			If s_Flag = "All" Then
				w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, "", "" )
			ElseIf s_Flag = "Part" Then
				w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, s_Flag2, "" )
			Else
			   w_customer_category_pricing.wf_build_category_crosstab ( s_Flag,  "", s_Flag2)
			END IF

		Else
			Rollback ;
			gnv_App.of_GetFrame().SetMicroHelp("Unable to delete the Promotion..")
		End If

	End If

End If		
end on

on save_promo;String s_Flag
String s_flag2

If dw_edit_price.Update() > 0 Then

	Commit ;
	gnv_App.of_GetFrame().Setmicrohelp("Information Saved....")

	s_Flag = w_customer_category_pricing.ddlb_1.Text
	s_Flag2 = w_customer_category_pricing.ddlb_2.Text

	w_customer_category_pricing.dw_category.Reset ( )
	w_customer_category_pricing.dw_price_list.Reset ( )
	w_customer_category_pricing.dw_category.Retrieve ( )
	w_customer_category_pricing.dw_price_list.Retrieve ( )

	If s_Flag = "All" Then
		w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, "", "" )
	ElseIf s_Flag = "Part" Then
		w_customer_category_pricing.wf_build_category_crosstab ( s_Flag, s_Flag2, "" )
	Else
	   w_customer_category_pricing.wf_build_category_crosstab ( s_Flag,  "", s_Flag2)
	END IF

Else

	Rollback ;
	gnv_App.of_GetFrame().Setmicrohelp("Unable to save information....")

End If



end on

on activate;If gnv_App.of_GetFrame().MenuName <> "m_edit_price_promotion" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_edit_price_promotion )
end on

on open;string s_part, &
		 s_Category

s_price  st_price

st_price = Message.PowerObjectParm

s_part = st_price.spart 
s_Category = st_price.scategory 

dw_edit_price.SetTransObject(SQLCA)
dw_edit_price.Retrieve(s_part, s_Category)

end on

on w_edit_price_promotion.create
this.dw_edit_price=create dw_edit_price
this.Control[]={ this.dw_edit_price}
end on

on w_edit_price_promotion.destroy
destroy(this.dw_edit_price)
end on

type dw_edit_price from datawindow within w_edit_price_promotion
int X=33
int Y=33
int Width=2766
int Height=1377
int TabOrder=10
string DataObject="d_edit_price_promotion"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;l_row = dw_edit_price.GetclickedRow()

dw_edit_price.SelectRow(0, FALSE)
dw_edit_price.SelectRow(l_row, TRUE)
end on

