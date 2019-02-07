$PBExportHeader$u_smart_po_detail_dw.sru
$PBExportComments$The user object for the po detail data entry datawindow.
forward
global type u_smart_po_detail_dw from u_monitor_data_entry_dw
end type
end forward

global type u_smart_po_detail_dw from u_monitor_data_entry_dw
int Width=2057
int Height=440
string DataObject="dw_smart_po_detail_entry"
end type
global u_smart_po_detail_dw u_smart_po_detail_dw

type variables
w_smart_po_detail_entry_version3	iw_parent


end variables

forward prototypes
public function decimal uf_min_on_order ()
public function boolean uf_check_min_on_order ()
public subroutine uf_error (boolean ab_flag)
public function boolean uf_mark_deletion (long al_row)
public function decimal uf_get_price (decimal ac_qty, decimal ad_price)
end prototypes

public function decimal uf_min_on_order ();return iw_parent.wf_min_on_order()
end function

public function boolean uf_check_min_on_order ();return iw_parent.wf_check_min_on_order() 
end function

public subroutine uf_error (boolean ab_flag);iw_parent.wf_error(ab_flag)
end subroutine

public function boolean uf_mark_deletion (long al_row);/*
Description	:To mark the deletion of PO release.
Author		:Jim Wu
Start Date	:02/17/96
Modification:
*/


/* Declaration */


/* Initialization */


/* Main Process */
this.SetItem(al_row, "deleted", "Y")	
this.SetItem(al_row, "printed", "N")
this.SetItem(al_row, "quantity", 0)
this.SetItem(al_row, "received", 0)
this.SetItem(al_row, "balance",  0)
this.SetItem(al_row, "standard_qty", 0)
this.SetItem(al_row, "price", 0)

return TRUE
end function

public function decimal uf_get_price (decimal ac_qty, decimal ad_price);return	iw_parent.wf_get_price( ac_qty, ad_price )

end function

event itemchanged;call super::itemchanged;/*
Description	:	To check whether the quantity entered is less than min on
					order required.
Author		:	Jim Wu
Start Date	:	02/20/96
Modification:
*/

/* Declaration */
decimal	lc_qty, &
	lc_min_on_order, &
	ld_price

long		li_row

string	ls_column_name

boolean	lb_check_min_on_order

/* Initialization */
lb_check_min_on_order		= uf_check_min_on_order()
lc_min_on_order				= uf_min_on_order()

/* Main Process */

If	lb_check_min_on_order then
	li_row	= this.getrow()
	
	if li_row > 0 then
		ls_column_name	= this.getcolumnname()
		lc_qty			= dec(this.gettext())

		if ls_column_name = "quantity" then
			ld_price = object.price[row]

			this.setitem(li_row, "price", uf_get_price(lc_qty, ld_price))
			this.setitem(li_row, "printed", "N")

			if lc_min_on_order > 0 then
				if lc_qty < lc_min_on_order then
					MessageBox("Warning", "You have entered an amount less " + &
					"than the minimum order quantity of " + &
					String(lc_min_on_order) + &
					". Correct the order quantity or refer " + &
					"the vendor profile.", StopSign!)
					uf_error(TRUE)
					Return
				else
					uf_error(FALSE)
				end If	//end of lc_qty
			end If	//end of nMinOnOrder
		end if	//end of ls_column_name
	end if	//end of li_row
end If	//end of bCheckMinOnOrder


end event

on constructor;call u_monitor_data_entry_dw::constructor;iw_parent	= parent
end on

