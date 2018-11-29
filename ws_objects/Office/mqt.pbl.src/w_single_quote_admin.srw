$PBExportHeader$w_single_quote_admin.srw
forward
global type w_single_quote_admin from w_sheet_4t
end type
type gb_2 from groupbox within w_single_quote_admin
end type
type dw_2 from datawindow within w_single_quote_admin
end type
type dw_1 from u_datawindow_key_increment_ancestor within w_single_quote_admin
end type
type gb_1 from groupbox within w_single_quote_admin
end type
end forward

global type w_single_quote_admin from w_sheet_4t
integer x = 214
integer y = 221
string title = "Quoting System"
string menuname = "m_single_quote_admin"
event type integer ue_save ( )
event ue_add ( )
event ue_delete ( )
event ue_print ( )
gb_2 gb_2
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type
global w_single_quote_admin w_single_quote_admin

type prototypes
FUNCTION boolean GetComputerNamesss ( ref string lpszName, string lpdwbuffer ) LIBRARY "Kernel32.dll" alias for "GetComputerNamesss;Ansi"
end prototypes

type variables
long		i_l_quote
string		i_s_customer
int		i_i_counter
boolean		i_b_locked
st_dda_parmlist        st_prmlst

end variables

forward prototypes
public subroutine wf_resequence ()
end prototypes

event ue_save;// Declare local variables
string					l_s_error
st_generic_structure	l_str_parm
datawindowchild		l_dwc_price,&
							l_dwc_units
int						l_i_count


dw_1.AcceptText ( )
dw_2.AcceptText ( )

if dw_1.ModifiedCount ( ) > 0 then
	if dw_1.Update ( ) = -1 then
		l_s_error = sqlca.sqlerrtext
		rollback ;
		MessageBox ( "System Message", "Unable to save quote header.  Reason:" + l_s_error, Information! )
	else
		m_single_quote_admin.mf_setmenu ( TRUE, TRUE, TRUE )  //Chris--Moved from below
		dw_2.Getchild ( "price", l_dwc_price )
		dw_2.GetChild ( "unit", l_dwc_units )
		l_dwc_price.InsertRow ( 1 )
		l_dwc_units.SetTransObject ( sqlca )
		l_dwc_units.Retrieve ( '' )
		if dw_2.ModifiedCount ( ) > 0 then
			dw_2.AcceptText ( )
			if dw_2.Update ( ) = -1 then
				l_s_error = sqlca.sqlerrtext
				rollback ;
				MessageBox ( "System Message", "Unable to save quote detail.  Reason:" + l_s_error, Information! )
			else
				UPDATE	quote
				SET		lock_flag = 0
				WHERE		quote_number = :i_l_quote ;
				commit;
				dw_2.selectrow ( 0, false )				
			end if
		end if
	end if
end if
//else
	if dw_2.ModifiedCount ( ) > 0 then
		dw_2.AcceptText ( )
		if dw_2.Update ( ) = -1 then
			l_s_error = sqlca.sqlerrtext
			rollback ;
			MessageBox ( "System Message", "Unable to save quote detail.  Reason:" + l_s_error, Information! )
		else
			UPDATE	quote
			SET		lock_flag = 0
			WHERE		quote_number = :i_l_quote ;
			if sqlca.sqlcode = 0 then
				commit;
				dw_2.selectrow ( 0, false )				
				m_single_quote_admin.mf_setmenu ( TRUE, TRUE, TRUE )
			else
				rollback;
			end if
		end if
	end if
//end if

return 1
end event

event ue_add;call super::ue_add;int		l_i_lock

SELECT	lock_flag
INTO		:l_i_lock
FROM		quote
WHERE 	quote_number = :i_l_quote ;

if f_get_value ( l_i_lock ) = 0 then
	UPDATE	quote
	SET		lock_flag = 1
	WHERE		quote_number = :i_l_quote ;
	if sqlca.sqlcode = 0 then
		commit;
		i_b_locked = TRUE
		dw_2.InsertRow ( 0 )
		dw_2.SetItem ( dw_2.RowCount ( ), "quote_number", i_l_quote )
		dw_2.SetItem ( dw_2.RowCount ( ), "sequence", dw_2.Rowcount ( ) )
		dw_2.SetItem ( dw_2.RowCount ( ), "quote_customer", dw_1.object.customer[1] )
		dw_2.SetRow ( dw_2.RowCount ( ) )
		dw_2.SetColumn ( "part" )
		dw_2.SetFocus ( )
	else
		rollback;
		MessageBox ( "System Message", "Unable to lock record.  Please try again later.", StopSign! )
	end if
else
	MessageBox ( "System Message", "Another user is modifying this quote.  Please try again later.", StopSign! )
end if

end event

event ue_delete;long		l_l_row

if dw_2.rowcount() <= 0 then 
	Messagebox ( "System Message", "No detail rows to be deleted" ) 
	return
end if 

l_l_row = dw_2.GetRow ( ) 

if isnull(l_l_row,0) <= 0 then 
	Messagebox ( "System Message", "Please click on the detail row to be deleted" ) 
	return
end if 

if MessageBox ( "Delete Quote Item", "Are you sure you want to delete part " + dw_2.GetItemString ( l_l_row, "part" ) + " from this quote?", Question!, YesNo!, 2 ) = 1 then
	if dw_2.DeleteRow ( l_l_row ) = -1 then
		Messagebox ( "System Message", "Unable to delete detail item.  Please try again later.  If the problem persists, contact your system administrator.", Information! )
		dw_2.Retrieve ( i_l_quote )
	else
		if dw_2.Update ( ) = -1 then
			rollback;
			Messagebox ( "System Message", "Unable to delete detail item.  Please try again later.  If the problem persists, contact your system administrator.", Information! )
		else
			commit;
			dw_2.selectrow ( 0, false )			
			wf_resequence ( )
		end if
	end if
end if
end event

event ue_print();
n_cst_associative_array	lnv_Parm
lnv_Parm.of_SetItem("Report", "Quote")
lnv_Parm.of_SetItem("Arg1", i_l_quote)
Print (lnv_Parm)

end event

public subroutine wf_resequence ();// Declare local variables
long		l_l_count

UPDATE 	quote
SET		lock_flag = 1
WHERE		quote_number = :i_l_quote ;

if sqlca.sqlcode = 0 then
	commit ;
else
	rollback ;
	MessageBox ( "System Message", "Unable to lock quote records.  Please try again later.", Information! )
	return
end if

For l_l_count = 1 to dw_2.rowcount ( )
	dw_2.object.sequence[l_l_count] = l_l_count
next

if dw_2.update ( ) = -1 then
	rollback;
	MessageBox ( "System Message", "Unable to re-sequence the detail items on this quote.", Information! )
else
	commit;
end if

UPDATE 	quote
SET		lock_flag = 0
WHERE		quote_number = :i_l_quote ;

if sqlca.sqlcode = 0 then
	commit ;
else
	rollback ;
	MessageBox ( "System Message", "Unable to lock quote records.  Please try again later.", Information! )
	return
end if

end subroutine

event open;call super::open;// Declare local variables
st_generic_structure	l_str_parm
datawindowchild		l_dwc_dest,&
							l_dwc_price,&
							l_dwc_units
int						l_i_count


//	Setup object array for screen
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * gb_2.X + gb_2.Width, 2 * gb_1.Y + gb_2.Y + gb_2.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 0)
inv_Resize.of_Register(dw_1, 0, 0, 100, 0)
inv_Resize.of_Register(gb_2, 0, 0, 100, 100)
inv_Resize.of_Register(dw_2, 0, 0, 100, 100)

//	Get message parameter
l_str_parm 		= Message.PowerObjectParm
i_l_quote		= long ( l_str_parm.value1 )
i_s_customer	= l_str_parm.value2


//	Setup the transaction object for each datawindow
dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )


dw_1.GetChild ( "destination", l_dwc_dest )
l_dwc_dest.SetTransObject ( sqlca )
if l_dwc_dest.Retrieve ( i_s_customer, ' ' ) < 1 then   // 2nd arg is destination for more functionality
	l_dwc_dest.InsertRow ( 1 )
end if

//	If quote number is sent, display.  Otherwise, insert row for new one.
Choose Case i_l_quote < 1
	Case TRUE
		dw_1.InsertRow ( 1 )
		dw_1.object.customer[1] = i_s_customer
		dw_1.object.status[1] = 'O'
		dw_1.object.status.TabSequence=0
		dw_1.object.quote_date[1] = Today ( )
		dw_1.object.expire_date[1] = Relativedate ( Today ( ), 30 )
		m_single_quote_admin.mf_setmenu ( FALSE, FALSE, TRUE )
	Case FALSE
		dw_1.Retrieve ( i_l_quote )
		dw_2.Getchild ( "price", l_dwc_price )
		dw_2.GetChild ( "unit", l_dwc_units )
		l_dwc_price.InsertRow ( 1 )
		l_dwc_units.SetTransObject ( sqlca )
		l_dwc_units.Retrieve ( '' )
		dw_2.Retrieve ( i_l_quote )
		m_single_quote_admin.mf_setmenu ( TRUE, TRUE, TRUE )
End Choose
end event

on w_single_quote_admin.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_single_quote_admin" then this.MenuID = create m_single_quote_admin
this.gb_2=create gb_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_single_quote_admin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event closequery;call super::closequery;if i_b_locked then
	UPDATE	quote
	SET		lock_flag = 0
	WHERE		quote_number = :i_l_quote ;
	if sqlca.sqlcode = 0 then
		commit;
	else
		rollback;
	end if
end if
end event

type gb_2 from groupbox within w_single_quote_admin
integer x = 18
integer y = 800
integer width = 2926
integer height = 912
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Quote Detail Info"
end type

type dw_2 from datawindow within w_single_quote_admin
event ue_keypress pbm_dwnkey
integer x = 55
integer y = 864
integer width = 2834
integer height = 816
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_quote_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keypress;Int li_current_row, &
    li_current_column
String ls_unit
IF (keydown(keyTab!) OR keydown(keyEnter!)) AND (dw_2.getcolumnname()='quantity') THEN 
	li_current_row = dw_2.getrow()
	dw_2.accepttext()
	st_prmlst.s_arg_part   = dw_2.getitemstring(li_current_row,'part')	
	
	SELECT standard_unit
	  INTO :ls_unit
	  FROM part_inventory
	 WHERE (part = :st_prmlst.s_arg_part) ; 
	 
	st_prmlst.s_arg_module = ls_unit
	st_prmlst.s_rtn_qtystr = dw_2.getitemstring(li_current_row,'dimension_qty_string')
	st_prmlst.s_rtn_qty    = dw_2.getitemnumber(li_current_row,'quantity') 
	Openwithparm(w_dda,st_prmlst)
	st_prmlst = Message.PowerObjectparm
	dw_2.setitem(li_current_row,'quantity',st_prmlst.s_rtn_qty)
	dw_2.setitem(li_current_row,'dimension_qty_string',st_prmlst.s_rtn_qtystr)
End if 

end event

event itemchanged;string	l_s_name,&
	l_s_type,&
	l_s_part,&
	l_s_customer, &
	ls_uom
dec	l_dec_cost,&
	l_dec_price
datawindowchild	l_dwc_price,&
		l_dwc_units
long	l_l_count
boolean	l_b_same

if rowcount() < 1 then return

Choose Case dwo.Name
	Case "part"
//	Commented the following lines to overcome allowing of duplicate part more than once 
//	on the same quote

//	For l_l_count = 1 to rowcount ( )
//		if l_l_count <> row then
//			if object.part[l_l_count] = data then
//				l_b_same = TRUE
//				l_l_count = rowcount ( )
//			end if
//		end if
//	Next
//	
//	if l_b_same then
//		MessageBox ( "System Message", "You cannot enter the same part twice on a quote.  Please try your selection again.", Information! )
//		object.part[row] = ''
//		return 2
//	end if
	
	select	name,
		standard_unit
	into	:l_s_name,
		:ls_uom
	from	part,
		part_inventory
	where	part.part = part_inventory.part	and
		part.part = :data ;
	
	if sqlca.sqlcode = 0 then
		object.product_name[row] = l_s_name
		select	cost_cum
		into	:l_dec_cost
		from	part_standard
		where	part_standard.part = :data ;
		object.cost[row] = l_dec_cost
		l_s_customer = object.quote_customer[row]
		select	type
		into	:l_s_type
		from	part_customer
		where	part = :data and
			customer = :l_s_customer;
		GetChild ( "price", l_dwc_price )
		l_dwc_price.SetTransObject ( sqlca )
		Choose Case Upper ( f_get_string_value ( l_s_type ) )
			Case "B"
				l_dwc_price.Retrieve ( data, l_s_customer )
			Case Else
				l_dwc_price.Retrieve ( '', '' )
				l_dec_price = f_calculate_customer_price ( data, l_s_customer, object.quantity[row] )
				object.price[row] = l_dec_price
		End Choose
		GetChild ( "unit", l_dwc_units )
		l_dwc_units.SetTransObject ( sqlca )
		l_dwc_units.Retrieve ( data )
	else
		GetChild ( "unit", l_dwc_units )
		l_dwc_units.SetTransObject ( sqlca )
		l_dwc_units.Retrieve ( '' )
	end if
	setitem (row, 'unit', ls_uom ) 

	Case "quantity"
		l_s_part = object.part[row]
		l_s_customer = object.quote_customer[row]
		select	type
		into	:l_s_type
		from	part_customer
		where	part = :l_s_part and
			customer = :l_s_customer ;
		Choose	Case Upper ( f_get_string_value ( l_s_type ) )
			Case "B"
			Case Else
//	7/26/01	Changed all the std_qty column reference to quantity column as no 
//	conversion is required at this stage
//	8/7/01	Changed it back to std_qty, as that is how the system should work
				object.price[row] = f_calculate_customer_price ( l_s_part, l_s_customer, object.std_qty[row] )
//				object.price[row] = f_calculate_customer_price ( l_s_part, l_s_customer, object.quantity[row] )				
		End Choose
	Case "cost"
		l_dec_cost = dec ( data )
		l_dec_price = object.price[row]
	Case "price"
		l_dec_price = dec ( data )
		l_dec_cost = object.cost[row]
	Case "margin"
		object.price[row] 	= ( ( 100 + dec ( data ) ) * object.cost[row] ) / 100
		l_dec_cost = object.cost[row]
		l_dec_price = object.price[row]
	Case "profit"
		object.price[row]	= ( dec ( data ) + object.cost[row] ) / object.std_qty[row]
//		object.price[row]	= ( dec ( data ) + object.cost[row] ) / object.quantity[row]		
		l_dec_cost = object.cost[row]
		l_dec_price = object.price[row]
End Choose

if l_dec_price > 0 and l_dec_cost > 0 then
	object.profit[row]	= ( l_dec_price - l_dec_cost ) * object.std_qty[row]
//	object.profit[row]	= ( l_dec_price - l_dec_cost ) * object.quantity[row]	
	object.margin[row] 	= ( ( ( 100 * l_dec_price ) / l_dec_cost ) - 100 ) / 100
end if

end event

event rowfocuschanged;if rowcount() < 1 then return
if currentrow > 0 then 
	datawindowchild	l_dwc_units
	GetChild ( "unit", l_dwc_units )
	l_dwc_units.SetTransObject ( sqlca )
	l_dwc_units.Retrieve ( object.part[currentrow] )
end if 	
end event

event constructor;dataobject = "d_quote_detail"
SetTransObject ( sqlca )
end event

event clicked;selectrow ( 0, false ) 
selectrow ( row, true ) 

end event

type dw_1 from u_datawindow_key_increment_ancestor within w_single_quote_admin
integer x = 55
integer y = 96
integer width = 2853
integer height = 672
integer taborder = 10
string dataobject = "d_quote_header"
boolean border = false
boolean livescroll = false
end type

event constructor;//datawindowchild	ldwc_dddw
//GetChild ( "destination", ldwc_dddw )
//ldwc_dddw.SetTransObject ( sqlca )
//ldwc_dddw.InsertRow ( 1 )
//
i_s_key_table	= "quote"
i_s_key_column	= "quote_number"
end event

event updateend;call super::updateend;i_l_quote = object.quote_number[1]
end event

event retrieveend;if rowcount() > 0 then
	i_l_quote = object.quote_number[1]
end if
end event

type gb_1 from groupbox within w_single_quote_admin
integer x = 18
integer y = 16
integer width = 2926
integer height = 784
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Quote Header Info"
end type

