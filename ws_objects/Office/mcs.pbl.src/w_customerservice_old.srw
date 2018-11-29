$PBExportHeader$w_customerservice_old.srw
$PBExportComments$mcs
forward
global type w_customerservice_old from w_sheet_4t
end type
type dw_parm from datawindow within w_customerservice_old
end type
type uo_1 from u_explorer_plus within w_customerservice_old
end type
type str_wheres from structure within w_customerservice_old
end type
end forward

type str_wheres from structure
	string		customer_where
	string		quote_where
	string		salesorder_where
	string		shipsched_where
	string		shiphist_where
	string		issues_where
	string		returns_where
	string		profile_where
	string		contacts_where
	string		contact_call_log_where
	string		invoices_where
end type

global type w_customerservice_old from w_sheet_4t
integer x = 832
integer y = 364
integer width = 2053
integer height = 1224
string title = "Customer Service"
string menuname = "m_customer_service_center"
long backcolor = 78682240
event type integer ue_clicked_popup ( string a_s_item )
event ue_new ( )
event ue_save ( )
event ue_delete ( )
event ue_search ( )
event ue_print ( )
event ue_sort ( )
event ue_cancel ( )
event ue_print_update ( )
event ue_refresh ( )
dw_parm dw_parm
uo_1 uo_1
end type
global w_customerservice_old w_customerservice_old

type variables
public:
datastore		i_ds_treeview,&
		i_ds_listview
int		i_i_clicked_tvrow,&
		i_i_rightclicked_tvrow,&
		i_i_prev_clicked_tvrow
string		i_s_current_customer,&
		i_s_current_destination,&
		is_issue_syntax

private:
str_wheres	i_str_wheres
long		il_lasthandle
end variables

forward prototypes
public function long wf_addtreeviewitem (datastore a_ds_treeview, long a_l_dsrow)
public function integer wf_retrieve_dw_view (string a_s_sqlsyntax)
public function integer wf_valid_drop (long a_l_quote)
public function integer wf_valid_quote (long a_l_quote)
public function integer wf_build_treeview ()
public function integer wf_retrieve_datastore (string a_s_where)
public subroutine wf_retrieve_info (string as_label, string as_customer, long al_parentrow, long al_itemlevel, long al_itemhandle)
public subroutine wf_create_shipperdetail (long al_shipper, long al_oldshipper[], long al_oldsuffix[], string as_part[])
public function integer wf_refresh_rmas (long al_parentrow)
public function integer wf_create_credit_memo (long al_rma, string as_operator)
public function integer wf_destination_scorecard (string a_s_destination, date a_dt_start, date a_dt_end)
public function string wf_parsedata (string as_data)
end prototypes

event ue_clicked_popup;//	Declare local variables
string					l_s_where
string					l_s_prevsort
string					ls_destination = ''
string					ls_customer = ''
string					ls_itemtype

boolean					l_b_retrieve

long						l_l_count
long						ll_parentrow

str_generic_search	l_str_search
st_generic_structure	l_str_parm1

datetime	l_dt_start,&
		l_dt_end
							
//	a_s_item contains Popup Menu Item (Text) that was chosen
// Based on that, take appropriate action

ls_customer = ''
ls_destination = ''

if i_i_rightclicked_tvrow > 0 then
	ll_parentrow = i_i_rightclicked_tvrow
	Do While ( ll_parentrow > 0 )
		Choose Case i_ds_treeview.object.itemtype[ll_parentrow]
			Case "Customer"
				ls_customer = wf_parsedata(i_ds_treeview.object.itemlabel[ll_parentrow])
				if ls_itemtype = '' then
					ls_itemtype = "Customer"
				end if
			Case "Destination"
				ls_destination = wf_parsedata(i_ds_treeview.object.itemlabel[ll_parentrow])
				if ls_itemtype = '' then
					ls_itemtype = "Destination"
				end if
		End Choose
		ll_parentrow = i_ds_treeview.object.parentrow[ll_parentrow]
	Loop
end if

if ls_customer > '' then
	SELECT	start_date,
				end_date
	INTO		:l_dt_start,
				:l_dt_end
	FROM		customer_additional
	WHERE		customer = :ls_customer ;
end if

select	primary_column,
		default_operator
into		:l_str_search.primary_column,
		:l_str_search.default_operator
from		dw_inquiry_files
where		datawindow_name = :a_s_item ;

setpointer ( Hourglass! ) 

Choose Case a_s_item
	Case "New Customer"
		OpenSheet ( w_customer_setup_with_destinations, gnv_App.of_GetFrame(), 0, Original! )
	Case "New Destination"
		OpenSheet ( w_customer_setup_with_destinations, gnv_App.of_GetFrame(), 0, Original! )
	Case "New Quote"
		l_str_parm1.value1 = '0'
		l_str_parm1.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_rightclicked_tvrow])
		OpenSheetWithParm ( w_single_quote_admin, l_str_parm1, gnv_App.of_GetFrame(), 0, Original! )
	Case "Edit Customer"
		OpenSheetWithParm ( w_customer_setup_with_destinations, ls_customer, gnv_App.of_GetFrame(), 0, Original! )
	Case "Edit Destination"
		ls_destination = "%%" + ls_destination
		OpenSheetWithParm ( w_customer_setup_with_destinations, ls_destination, gnv_App.of_GetFrame(), 0, Original! )
	Case "New Sales Order"
		Choose Case ls_itemtype
			Case "Destination"
				l_str_parm1.value1 = ''
				l_str_parm1.value2 = ls_destination
				l_str_parm1.value3 = ls_customer
			Case "Customer"
				l_str_parm1.value1 = ''
				l_str_parm1.value2 = ls_customer
		End Choose
		OpenWithParm ( w_add_order_type, l_str_parm1 )
		if Message.DoubleParm = 1 then
			OpenSheetWithParm ( w_blanket_order, l_str_parm1, gnv_App.of_GetFrame(), 0, Original! )
		elseif Message.DoubleParm = 2 then
			OpenSheetWithParm ( w_orders_detail, l_str_parm1, gnv_App.of_GetFrame(), 0, Original! )
		end if
	Case "New RMA"
		l_str_parm1.value1 = '0'
		l_str_parm1.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_rightclicked_tvrow]])
		l_str_parm1.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_rightclicked_tvrow])
		OpenWithParm ( w_rma_admin_entry, l_str_parm1 )
		if IsNull ( Message.DoubleParm, 0 ) = 1 then
			if uo_1.dw_1.Tag = 'RMAs' then
				uo_1.dw_1.Retrieve ( )
			end if
			wf_refresh_rmas ( i_i_rightclicked_tvrow )
		end if
	Case "Edit RMA"
		l_str_parm1.value1 = i_ds_treeview.object.itemlabel[i_i_rightclicked_tvrow]
		OpenWithParm ( w_rma_admin_entry, l_str_parm1 )
	Case "RMAs Search", "Display All RMAs"
		if a_s_item = "Display All RMAs" then
			l_s_where = ''
			l_b_retrieve = TRUE
		else
			l_str_search.s_tables[1] = "cs_returns_vw"
			l_str_search.b_allow_retrieve_all = TRUE
			OpenWithParm ( w_generic_search, l_str_search )
			l_s_where = Message.StringParm
			if l_s_where = "all" then
				l_s_where = ''
				l_b_retrieve = TRUE
			elseif l_s_where = 'cancel' then
				l_s_where = i_str_wheres.returns_where
			else
				l_s_where = " AND " + l_s_where
				l_b_retrieve = TRUE
			end if
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
				wf_retrieve_dw_view ( "SELECT * FROM cs_returns_vw WHERE destination = '" + ls_destination + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
			ELSE
				wf_retrieve_dw_view ( "SELECT * FROM cs_returns_vw WHERE destination = '" + ls_destination + "' " + l_s_where )
			end if
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.returns_where = l_s_where
			wf_refresh_rmas ( i_i_rightclicked_tvrow )
		end if
	Case "Invoice Search", "Display All Invoices"
		if a_s_item = "Display All Invoices" then
			l_s_where = ''
			l_b_retrieve = TRUE
		else
			l_str_search.s_tables[1] = "cs_invoices_vw"
			l_str_search.b_allow_retrieve_all = TRUE
			OpenWithParm ( w_generic_search, l_str_search )
			l_s_where = Message.StringParm
			if l_s_where = "all" then
				l_s_where = ''
				l_b_retrieve = TRUE
			elseif l_s_where = 'cancel' then
				l_s_where = i_str_wheres.invoices_where
			else
				l_s_where = " AND " + l_s_where
				l_b_retrieve = TRUE
			end if
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
				wf_retrieve_dw_view ( "SELECT * FROM cs_invoices_vw WHERE customer = '" + ls_customer + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
			ELSE
				wf_retrieve_dw_view ( "SELECT * FROM cs_invoices_vw WHERE customer = '" + ls_customer + "' " + l_s_where + " ORDER BY invoice_number ASC" )
			end if
			i_i_clicked_tvrow = i_ds_treeview.Find ( "itemlevel = 1", 1, i_ds_treeview.RowCount ( ) )
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.invoices_where = l_s_where
		end if
	Case "Customer Search", "Display All Customers"
		if a_s_item = "Display All Customers" then
			l_s_where = ''
			wf_retrieve_datastore ( '' )
			l_b_retrieve = TRUE
		else
			l_str_search.s_tables[1] = "cs_customers_vw"
			l_str_search.b_allow_retrieve_all = TRUE
			OpenWithParm ( w_generic_search, l_str_search )
			l_s_where = Message.StringParm
			if l_s_where = "all" then
				l_s_where = ''
				wf_retrieve_datastore ( '' )
				l_b_retrieve = TRUE
			elseif l_s_where = 'cancel' then
				l_s_where = i_str_wheres.customer_where
			else
				wf_retrieve_datastore ( l_s_where )
				l_b_retrieve = TRUE
			end if
		end if
		if l_b_retrieve then
			wf_build_treeview ( )
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			if l_s_where > '' then
				wf_retrieve_dw_view ( "SELECT * FROM cs_customers_vw WHERE "  + l_s_where + " ORDER BY customer" )
			else
				wf_retrieve_dw_view ( "SELECT * FROM cs_customers_vw ORDER BY customer" )
			end if
			i_i_clicked_tvrow = i_ds_treeview.Find ( "itemlevel = 1", 1, i_ds_treeview.RowCount ( ) )
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.customer_where = l_s_where
		end if
	Case "Quote Search"
		l_str_search.s_tables[1] = "cs_quotes_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
//			l_s_where = i_str_wheres.customer_where
			l_s_where = i_str_wheres.quote_where			
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
				wf_retrieve_dw_view ( "SELECT * FROM cs_quotes_vw WHERE cs_quotes_vw.customer = '" + ls_customer + "' AND quote_date >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND quote_date <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
			ELSE
				wf_retrieve_dw_view ( "SELECT * FROM cs_quotes_vw WHERE cs_quotes_vw.customer = '" + ls_customer + "'" + l_s_where )
			END IF
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.quote_where = l_s_where
		end if
	Case "Sales Order Search"
		l_str_search.s_tables[1] = "cs_orders_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
//			l_s_where = i_str_wheres.customer_where
			l_s_where = i_str_wheres.salesorder_where			
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
				Choose Case ls_itemtype
					Case "Customer"
						wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.customer = '" + ls_customer + "' AND order_date >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND order_date <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
					Case "Destination"
						wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.destination = '" + ls_destination + "' AND order_date >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND order_date <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
				End Choose
			ELSE
				Choose Case ls_itemtype

					Case "Customer"
						wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.customer  = '" + ls_customer + "'" + l_s_where )
					Case "Destination"
						wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.destination = '" + ls_destination + "'" + l_s_where )
				End Choose
			END IF
			uo_1.dw_1.Tag = "Sales Orders"
			uo_1.dw_1.Trigger Event ue_change_color ( "due_date", Today ( ), f_get_color_value ( "darkgreen" ), f_get_color_value ( "brown" ), f_get_color_value ( "red" ), "foreground", true )
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.salesorder_where = l_s_where
		end if
	Case "Ship Schedule Search"
//		l_str_search.s_tables[1] = "shipper"
		l_str_search.s_tables[1] = "cs_ship_schedule_vw"		
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
//			l_s_where = i_str_wheres.customer_where
			l_s_where = i_str_wheres.shipsched_where
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
//			uo_1.of_setrightpanel ( "datawindow" )
			m_customer_service_center.mf_show_cancel ( TRUE )
			Choose Case ls_itemtype
					Case "Customer"
						wf_retrieve_dw_view ( "SELECT * FROM cs_ship_schedule_vw WHERE cs_ship_schedule_vw.customer = '" + ls_customer + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
					Case "Destination"
						wf_retrieve_dw_view ( "SELECT * FROM cs_ship_schedule_vw WHERE cs_ship_schedule_vw.destination = '" + ls_destination + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
					
//				Case "Customer"
////					uo_1.dw_1.DataObject = "d_cs_ship_schedule_per_customer"
//					uo_1.dw_1.DataObject = "d_cs_ship_schedule"
//					uo_1.dw_1.SetTransObject ( sqlca )
//					uo_1.dw_1.Retrieve ( ls_customer, l_dt_start, l_dt_end ) 
//				Case "Destination"
////					uo_1.dw_1.DataObject = "d_cs_ship_schedule_per_destination"
//					uo_1.dw_1.DataObject = "d_cs_ship_schedule"
//					uo_1.dw_1.SetTransObject ( sqlca )
//					uo_1.dw_1.Retrieve ( ls_destination,l_dt_start, l_dt_end )
			End Choose
//			uo_1.dw_1.SetFilter ( l_s_where )
//			uo_1.dw_1.Filter ( )
			m_customer_service_center.mf_show_cancel ( FALSE )
			uo_1.dw_1.Tag = "Ship Schedule"
			m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.shipsched_where = l_s_where
		end if
	Case "Ship History Search"
		l_str_search.s_tables[1] = "cs_ship_history_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
			l_s_where = i_str_wheres.shiphist_where
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			Choose Case ls_itemtype
				Case "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_vw WHERE cs_ship_history_vw.customer = '" + ls_customer + "'" + l_s_where )
				Case "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_vw WHERE cs_ship_history_vw.destination = '" + ls_destination + "'" + l_s_where )
			End Choose
			uo_1.dw_1.Tag = "Ship History"
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.shiphist_where = l_s_where
		end if
// 11/20/01 added
	Case "Ship History Summary"
		uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
		Choose Case ls_itemtype
			Case "Customer"
				wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_summary_vw WHERE cs_ship_history_summary_vw.customer = '" + ls_customer + "'" + l_s_where )
			Case "Destination"
				wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_summary_vw WHERE cs_ship_history_summary_vw.destination = '" + ls_destination + "'" + l_s_where )
		End Choose
		uo_1.dw_1.Tag = "Ship History Summary"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		i_str_wheres.shiphist_where = l_s_where
// 11/20/01 added
	Case "Ship History Detail"
		uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
		Choose Case ls_itemtype
			Case "Customer"
				wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_detail_vw WHERE cs_ship_history_detail_vw.customer = '" + ls_customer + "'" + l_s_where )
			Case "Destination"
				wf_retrieve_dw_view ( "SELECT * FROM cs_ship_history_detail_vw WHERE cs_ship_history_detail_vw.destination = '" + ls_destination + "'" + l_s_where )
		End Choose
		uo_1.dw_1.Tag = "Ship History Detail"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		i_str_wheres.shiphist_where = l_s_where
		
	Case "Edit Profile"
		OpenSheetWithParm ( w_orders_customer_price_matrix, ls_customer, gnv_App.of_GetFrame(), 0, Original! )
	Case "Reset Search"
		Choose Case i_ds_treeview.object.itemtype[i_i_rightclicked_tvrow]
			Case "Customer Service"
				i_str_wheres.customer_where = ''
			Case "Quotes"
				i_str_wheres.quote_where = ''
			Case "Sales Orders"
				i_str_wheres.salesorder_where = ''
			Case "Ship Schedule"
				i_str_wheres.shipsched_where = ''
			Case "Ship History"
				i_str_wheres.shiphist_where = ''
			Case "Issues"
				i_str_wheres.issues_where = ''
			Case "RMAs"
				i_str_wheres.returns_where = ''
			Case "Profile"
				i_str_wheres.profile_where = ''
			Case "Contacts"
				i_str_wheres.contacts_where = ''
			Case "Invoices"
				i_str_wheres.invoices_where = ''
		End Choose
		uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
		uo_1.Trigger Event tv_clicked ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
	Case "New Contact"
		st_generic_structure	l_str_contactentry
		l_str_contactentry.value1 = ""		
		if ls_itemtype = 'Customer' then
			l_str_contactentry.value2 = "Customer Service"
			l_str_contactentry.value3 = ls_customer
		else	
			l_str_contactentry.value2 = ls_customer
			l_str_contactentry.value3 = ls_destination			
		end if 	
		OpenWithParm ( w_contact_entry, l_str_contactentry )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, TRUE, FALSE, FALSE, TRUE )
			CHOOSE CASE ls_itemtype
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE customer = '" + ls_customer + "'" + i_str_wheres.contacts_where )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE destination = '" + ls_destination + "'" + i_str_wheres.contacts_where )
			END CHOOSE
		end if
	case "New Issue"
		l_str_parm1.value1 = ''
		if i_ds_treeview.object.itemlevel[i_i_rightclicked_tvrow] > 1 then
			l_str_parm1.value2 = 'C'
			Choose Case ls_itemtype
				Case "Customer"
					l_str_parm1.value3 = ls_customer
				Case "Destination"
					l_str_parm1.value3 = ls_destination
			end choose
		else
			l_str_parm1.value2 = ''
			l_str_parm1.value3 = ''
		end if
		OpenSheetWithParm ( w_issue_manager, l_str_parm1, gnv_App.of_GetFrame(), 0, Original! )
	case "New Call"
		l_str_parm1.value1 = ''
		l_str_parm1.value2 = ''
		l_str_parm1.value3 = ls_customer
		l_str_parm1.value4 = ls_destination
		OpenWithParm ( w_contact_call_log_entry, l_str_parm1 )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			CHOOSE CASE ls_itemtype
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE customer = '" + ls_customer + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE destination = '" + ls_destination + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
			END CHOOSE
		end if
	Case "Contact Search"
		l_str_search.s_tables[1] = "cs_contacts_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
			l_s_where = i_str_wheres.customer_where
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			Choose Case ls_itemtype
				Case "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE cs_contacts_vw.customer = '" + ls_customer + "'" + l_s_where )
				Case "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE cs_contacts_vw.destination = '" + ls_destination + "'" + l_s_where )
			End Choose
			uo_1.dw_1.Tag = "Contacts"
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.contacts_where = l_s_where
		end if
	Case "Contact Call Log Search"
		l_str_search.s_tables[1] = "cs_contact_call_log_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
			l_s_where = i_str_wheres.customer_where
		else
			l_s_where = " AND " + l_s_where
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			Choose Case ls_itemtype
				Case "Customer"
					IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
						wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE cs_contact_call_log_vw.customer = '" + ls_customer + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND stop_date <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
					ELSE
						wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE cs_contact_call_log_vw.customer = '" + ls_customer + "'" + l_s_where )
					END IF
				Case "Destination"
					IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
						wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE cs_contact_call_log_vw.destination = '" + ls_destination + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND stop_date <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + l_s_where )
					ELSE
						wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE cs_contact_call_log_vw.destination = '" + ls_destination + "'" + l_s_where )
					END IF
			End Choose
			uo_1.dw_1.Tag = "Contact Call Log"
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			i_str_wheres.contact_call_log_where = l_s_where
		end if
	Case "Issue Search"		
		l_str_search.s_tables[1] = "cs_issues_vw"
		l_str_search.b_allow_retrieve_all = TRUE
		OpenWithParm ( w_generic_search, l_str_search )
		l_s_where = Message.StringParm
		if l_s_where = "all" then
			l_s_where = ''
			l_b_retrieve = TRUE
		elseif l_s_where = 'cancel' then
			l_s_where = i_str_wheres.customer_where
		else
			if i_ds_treeview.object.itemlevel[i_i_rightclicked_tvrow] > 1 then
				l_s_where = " AND " + l_s_where
			end if
			l_b_retrieve = TRUE
		end if
		if l_b_retrieve then
			uo_1.dw_1.DataObject = "d_issues_list"
			uo_1.tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_rightclicked_tvrow] )
			if i_ds_treeview.object.itemlevel[i_i_rightclicked_tvrow] = 1 then
				if l_s_where > '' then
					uo_1.dw_1.object.datawindow.table.select = is_issue_syntax + " where " + l_s_where
				else
					uo_1.dw_1.object.datawindow.table.select = is_issue_syntax + " where type = 'O'"
				end if
			else
				ls_customer = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_rightclicked_tvrow])
				if l_s_where > '' then
					uo_1.dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_customer + "' " + l_s_where
				else

					uo_1.dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_customer + "'"
				end if
			end if
			
			uo_1.dw_1.SetTransObject ( sqlca )
			uo_1.dw_1.Retrieve ( )
			uo_1.dw_1.Tag = "Issues"
			i_str_wheres.contacts_where = l_s_where
		end if
	Case "Delete RMA"
		if sqlca.of_delete_rma ( Long ( i_ds_treeview.object.itemlabel[i_i_rightclicked_tvrow] ), '' ) = 1 then
			wf_refresh_rmas ( i_ds_treeview.object.parentrow[i_i_rightclicked_tvrow] )
		end if
End Choose

setpointer ( Arrow! ) 
return 0
end event

event ue_new;//	Declare local variables
string					ls_itemtype,&
							ls_prevsort
st_generic_structure	lstr_parm

ls_itemtype = i_ds_treeview.object.itemtype[i_i_clicked_tvrow]

// Based on current type, take appropriate action
Choose Case ls_itemtype
	Case "Customer Service"
		OpenSheet ( w_customer_setup_with_destinations, gnv_App.of_GetFrame(), 0, Original! )
	Case "Quotes"
		lstr_parm.value1 = '0'
		lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		OpenSheetWithParm ( w_single_quote_admin, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
	Case "Sales Orders"
		Choose Case i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
			Case "Destination"
				lstr_parm.value1 = ''
				lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
				lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
			Case "Customer"
				lstr_parm.value1 = ''
				lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		End Choose
		OpenWithParm ( w_add_order_type, lstr_parm )
		if Message.DoubleParm = 1 then
			OpenSheetWithParm ( w_blanket_order, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
		elseif Message.DoubleParm = 2 then
			OpenSheetWithParm ( w_orders_detail, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
		end if
	Case "Issues"
		lstr_parm.value1 = ''
		if i_ds_treeview.object.itemlevel[i_i_clicked_tvrow] > 1 then
			lstr_parm.value2 = 'C'
			Choose Case i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				Case "Destination"
					lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
				Case "Customer"
					lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
			End Choose
		else
			lstr_parm.value2 = ''
			lstr_parm.value3 = ''
		end if
		OpenSheetWithParm ( w_issue_manager, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
	Case "RMAs"
		lstr_parm.value1 = '0'
		lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
		lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		OpenWithParm ( w_rma_admin_entry, lstr_parm )
		if IsNull ( Message.DoubleParm, 0 ) = 1 then
			if uo_1.dw_1.Tag = 'RMAs' then
				uo_1.dw_1.Retrieve ( )
			end if
			wf_refresh_rmas ( i_i_clicked_tvrow )
		end if
	Case "Contacts"
		lstr_parm.value1 = ""
		IF i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] = "Destination" THEN
			lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
			lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		ELSE
			lstr_parm.value2 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
			lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		END IF
		OpenWithParm ( w_contact_entry, lstr_parm )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, TRUE, FALSE, FALSE, TRUE )
			CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE customer = '" + wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]) + "'" + i_str_wheres.contacts_where )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE destination = '" + wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]) + "'" + i_str_wheres.contacts_where )
			END CHOOSE
		end if
	Case "Contact Call Log"
		lstr_parm.value1 = ''
		lstr_parm.value2 = ''
		if i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] = "Customer" THEN
			lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
			lstr_parm.value4 = ''
		else
			lstr_parm.value3 = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]])
			lstr_parm.value4 = wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow])
		end if
		OpenWithParm ( w_contact_call_log_entry, lstr_parm )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE customer = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE destination = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
			END CHOOSE
		end if
End Choose

end event

event ue_save;// Save changes to dw_1 (Notes so far)
if uo_1.dw_1.Update ( ) = -1 then
	rollback;
	MessageBox ( "System Message", "Unable to save notes!", StopSign! )
else
	commit;
end if

end event

event ue_delete;//	Declare local variables
string	l_s_itemtype,&
			ls_contact
long		ll_row
long	ll_shipper
// Get current item type
if i_i_clicked_tvrow < 1 then return

l_s_itemtype = i_ds_treeview.object.itemtype[i_i_clicked_tvrow]

// Based on current type, take appropriate action
Choose Case l_s_itemtype
	Case "Customers"
	Case "Ship Schedule"
		if uo_1.dw_1.IsSelected ( uo_1.dw_1.GetRow ( ) ) then
			ll_shipper = uo_1.dw_1.GetItemNumber ( uo_1.dw_1.GetRow ( ), "id" )
			if MessageBox ( monsys.msg_title, "Are you sure about deleting shipper " + String ( ll_shipper ) + "?", Question!, YesNo!, 2 ) = 1 then
				if sqlca.of_deletestagedshipper ( ll_shipper ) then
					uo_1.Trigger Event tv_clicked ( il_lasthandle )
				end if
			end if
		end if
	Case "Quotes"
	Case "Sales Orders"
	Case "Issues"
	Case "RMAs"
		if uo_1.dw_1.IsSelected ( uo_1.dw_1.GetRow ( ) ) then
			if sqlca.of_delete_rma ( uo_1.dw_1.object.id[uo_1.dw_1.GetRow ( )], '' ) = 1 then
				wf_refresh_rmas ( i_i_clicked_tvrow )
				uo_1.dw_1.Retrieve ( )
//				i_i_clicked_tvrow=1
			end if
		end if
	Case "RMA"
		if uo_1.dw_1.IsSelected ( uo_1.dw_1.GetRow ( ) ) then
			sqlca.of_delete_rma ( uo_1.dw_1.object.shipper[uo_1.dw_1.GetRow ( )], uo_1.dw_1.object.part[uo_1.dw_1.GetRow ( )] )
				wf_refresh_rmas ( i_ds_treeview.object.parentrow[i_i_clicked_tvrow] )			
				uo_1.dw_1.Retrieve ( )
//				i_i_clicked_tvrow=1				
		else
			if sqlca.of_delete_rma ( Long ( i_ds_treeview.object.itemlabel[i_i_clicked_tvrow] ), '' ) = 1 then
				wf_refresh_rmas ( i_ds_treeview.object.parentrow[i_i_clicked_tvrow] )
				uo_1.dw_1.Retrieve ( )
//				i_i_clicked_tvrow=1				
			end if
		end if
	Case "Contacts"
		ll_row = uo_1.dw_1.GetRow ( )
		if ll_row > 0 then
			ls_contact = uo_1.dw_1.GetItemString ( ll_row, 1 )
			if MessageBox ( "Delete", "Are you sure about deleting contact " + ls_contact + "?", Question!, YesNo!, 2 ) = 1 then
				delete from contact_call_log where contact = :ls_contact ;
				if sqlca.sqlcode = 0 then
					delete from contact where name = :ls_contact ;
					if sqlca.sqlcode = 0 then
						commit;
					else
						rollback;
						MessageBox ( "Delete", "Unable to delete contact " + ls_contact + ".", Information! )
					end if
				else
					rollback;
					MessageBox ( "Delete", "Unable to delete contact " + ls_contact + ".", Information! )
				end if

				m_customer_service_center.mf_setup ( TRUE, TRUE, FALSE, FALSE, TRUE )
				CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
					CASE "Customer"
						wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE customer = '" + wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] )+ "'" + i_str_wheres.contacts_where )
					CASE "Destination"
						wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE destination = '" + wf_parsedata(i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]) + "'" + i_str_wheres.contacts_where )
				END CHOOSE

			end if
		end if
End Choose

end event

event ue_search;if i_i_clicked_tvrow < 1 then return

i_i_rightclicked_tvrow = i_i_clicked_tvrow

// Determine current item type and trigger appropriate event
Choose Case i_ds_treeview.object.itemtype[i_i_clicked_tvrow]
	Case "Customer Service"
		Trigger Event ue_clicked_popup ( "Customer Search" )
	Case "Quotes"
		Trigger Event ue_clicked_popup ( "Quote Search" )
	Case "Sales Orders"
		Trigger Event ue_clicked_popup ( "Sales Order Search" )
	Case "Ship Schedule"
		Trigger Event ue_clicked_popup ( "Ship Schedule Search" )
	Case "Ship History"
		Trigger Event ue_clicked_popup ( "Ship History Search" )
	Case "Issues"
		Trigger Event ue_clicked_popup ( "Issue Search" )
	Case "RMAs"
		Trigger Event ue_clicked_popup ( "RMA Search" )
	Case "Part Profile"
		Trigger Event ue_clicked_popup ( "Profile Search" )
End Choose
end event

event ue_print();/*  Declare Variables  */
Long 			lInvoiceNumber
Long 			ll_row
Long 			iCount = 0
Int			l_i_RtnCode
Int      		iRtnCode

long	ll_Issues [ ]
long	test

datastore	ldw_IssuesReport
datastore	ldw_ContactCallLog

w_report_view  		l_w_instance[]
n_cst_associative_array	lnv_Parm

Choose Case uo_1.dw_1.Tag
	Case "Quotes"
		lnv_Parm.of_SetItem("Report", "Quote")
		ll_row = uo_1.dw_1.GetRow ( )
		If uo_1.dw_1.IsSelected ( ll_row ) then
			lnv_Parm.of_SetItem("Arg1", uo_1.dw_1.GetItemNumber ( ll_row, "quote_number" ))
			Print (lnv_Parm)
		end if
		

	Case "Invoices"
		/*  Loop through records and see if more than one */
		
		lnv_Parm.of_SetItem("Report", "Invoice")
		FOR ll_row = 1 TO uo_1.dw_1.RowCount ( )	
			If uo_1.dw_1.IsSelected ( ll_row ) Then
				lnv_Parm.of_SetItem("Arg1", uo_1.dw_1.GetItemNumber ( ll_row, "invoice_number" ))
				Print (lnv_Parm)
			End if	
		NEXT
	Case "Issues"
		ll_Issues = uo_1.dw_1.object.issue_number.Primary
		
		//	Print issues report.
		if UpperBound ( ll_Issues ) > 0 then
			ldw_IssuesReport = create datastore
			ldw_IssuesReport.DataObject = "d_issue_report"
			ldw_IssuesReport.SetTransObject ( SQLCA )
			
			test = ldw_IssuesReport.Retrieve ( ll_Issues )
			test = ldw_IssuesReport.Print ( )
			destroy ldw_IssuesReport
		end if
	Case "Contact Call Log"
		if uo_1.dw_1.rowcount() > 0 then 
			ldw_ContactCallLog = create datastore
			ldw_ContactCallLog.DataObject = "d_contactcalllogreport"
			ldw_ContactCallLog.SetTransObject ( SQLCA )
			
			test = ldw_ContactCallLog.Retrieve (  )
			test = ldw_ContactCallLog.Print ( )
			destroy ldw_ContactCallLog
			
		end if	
			
End Choose
end event

event ue_sort;str_sort	lstr_parm

if uo_1.dw_1.RowCount ( ) > 0 then
	lstr_parm.dw = uo_1.dw_1
	lstr_parm.title = "Select Columns to Sort By"
	OpenWithParm ( w_sort, lstr_parm )
end if
end event

event ue_cancel;uo_1.dw_1.Trigger Event ue_cancel ( )
end event

event ue_print_update;long 	l_l_Invoice
long	ll_row

FOR ll_row = 1 to uo_1.dw_1.RowCount()	
		
	if uo_1.dw_1.IsSelected ( ll_row ) then
		
		l_l_invoice = uo_1.dw_1.GetItemNumber ( ll_row, "invoice_number" )
		
		UPDATE shipper  
		SET invoice_printed = 'Y'  
	 	WHERE invoice_number = :l_l_Invoice   ;

		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			MessageBox ( monsys.msg_title, "Unable to update print flag for selected invoices!", StopSign! )

		Else
			Commit ;
			setmicrohelp ( 'Ready' )
		End if
	end if

NEXT

end event

event ue_refresh;if i_ds_treeview.object.itemtype[i_i_clicked_tvrow] = 'Issues' then uo_1.dw_1.Retrieve ( )
end event

public function long wf_addtreeviewitem (datastore a_ds_treeview, long a_l_dsrow);treeviewitem		l_tvi_item
long					l_l_new_handle,&
						l_l_parent_handle
string				l_s_temp,&
						l_s_parent_label
boolean				l_b_children

if a_ds_treeview.object.parentrow[a_l_dsrow] > 0 then
	l_l_parent_handle = a_ds_treeview.object.itemhandle[a_ds_treeview.object.parentrow[a_l_dsrow]]
else
	l_l_parent_handle = 0
end if

l_l_new_handle = uo_1.tv_1.of_additem ( FALSE, (f_numeric_value ( l_l_parent_handle ) <= 0), '', &
	( a_ds_treeview.object.expanded[a_l_dsrow] = 1 ), &
	a_ds_treeview.object.itemlabel[a_l_dsrow], a_ds_treeview.object.pictureindex[a_l_dsrow], &
	a_ds_treeview.object.selectedpictureindex[a_l_dsrow], l_l_parent_handle )
	
if l_l_new_handle > 0 then
	a_ds_treeview.object.itemhandle[a_l_dsrow] = l_l_new_handle
end if

return l_l_new_handle
end function

public function integer wf_retrieve_dw_view (string a_s_sqlsyntax);string	l_s_newsyntax,&
			l_s_error_syntaxfromSQL,&
			l_s_error_create
int		l_i_count

uo_1.of_setrightpanel ( "datawindow" )
uo_1.dw_1.reset()

uo_1.dw_1.Enabled = FALSE

l_s_newsyntax = SQLCA.SyntaxFromSQL(a_s_sqlsyntax, 'Style(Type=Grid) text(border=6 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)

IF LenA(l_s_error_syntaxfromSQL) > 0 THEN
	// Display errors
	Messagebox ( "Error",  l_s_error_syntaxfromSQL )
ELSE
	// Generate new DataWindow
	string l_s_text
	uo_1.dw_1.Create(l_s_newsyntax, l_s_error_create)
	IF LenA(l_s_error_create) > 0 THEN
		MessageBox ( "Error",  l_s_error_create )
		return -1
	ELSE
		For l_i_count = 1 to Integer ( uo_1.dw_1.object.datawindow.column.count )
			l_s_text = "#" + String ( l_i_count ) + ".Alignment='0'"
			uo_1.dw_1.Modify ( l_s_text ) 
		next
		uo_1.dw_1.Object.DataWindow.Selected.Mouse = "No"
		uo_1.dw_1.SetTransObject(SQLCA)
		m_customer_service_center.mf_show_cancel ( TRUE )
		uo_1.dw_1.Retrieve()
		m_customer_service_center.mf_show_cancel ( FALSE )
		commit;
	END IF
END IF

uo_1.dw_1.Enabled = TRUE

return 1
end function

public function integer wf_valid_drop (long a_l_quote);return 1
end function

public function integer wf_valid_quote (long a_l_quote);// Declare local variables
int		l_i_count

// Make sure quote is open and not expired
if uo_1.dw_1.object.status[uo_1.dw_1.GetRow ( )] <> 'O' then return 0
if uo_1.dw_1.object.expire_date[uo_1.dw_1.GetRow ( )] < DateTime ( Today ( ), Now ( ) )  then return 0


// Check detail items for non-part items
SELECT	Count (part)
INTO		:l_i_count
FROM		quote_detail
WHERE		quote_number = :a_l_quote AND
			part NOT IN (SELECT part FROM part);


// If a non-part item was found exit
if l_i_count > 0 then return 0


// If more than one part is in quote_detail, a normal order is created.
// If only one part is in quote_detail prompt the user for the order type
SELECT	count(part)
INTO		:l_i_count
FROM		quote_detail
WHERE		quote_number = :a_l_quote ;

if l_i_count > 1 then
	return 2
elseif l_i_count = 1 then
	return MessageBox ( "Type of Order", "Would you like to create a blanket order from this quote?  If you answer yes, a blanket order will be created.  If you answer no, a normal order will be created.", Question!, YesNoCancel!, 1 )
else
	return 0
end if
end function

public function integer wf_build_treeview ();long	l_l_count

uo_1.tv_1.DeleteItem ( 0 )

For l_l_count = 1 to i_ds_treeview.RowCount ( )
	wf_addtreeviewitem ( i_ds_treeview, l_l_count )
Next

return 1
end function

public function integer wf_retrieve_datastore (string a_s_where);string		l_s_newsyntax,&
		l_s_error_syntaxfromsql,&
		l_s_error_create,&
		l_s_text,&
		l_s_customer,&
		l_s_customer_temp, &
		l_s_destination, & 
		l_s_destination_temp
datastore	l_ds_customer,&
		l_ds_destination, &
		lds_invoices, &
		lds_rmas
long		l_l_count,&
		l_l_count2,&
		l_l_row,&
		l_l_toprow,&
		l_l_customerrow,&
		l_l_destinationrow
long		ll_custrowcount
long		ll_destrowcount
long		ll_parentrma
long		ll_rmarow
long		ll_rmarowcount
datetime	l_dt_start
datetime	l_dt_end
int		li_pos, &
		li_len

// Instantiate customer and destination datawindows
l_ds_customer		= CREATE datastore
l_ds_destination	= CREATE datastore
lds_rmas				= CREATE datastore

if a_s_where > '' then
	a_s_where = " where " + a_s_where + " order by customer"
else
	a_s_where = " order by customer"	
end if 

if g_s_platform = 'Sybase SQL Anywhere' then
	l_s_newsyntax = SQLCA.SyntaxFromSQL("select left(rtrim(customer)+space((20-length(rtrim(customer)))),20)+' '+name from cs_customers_vw " + a_s_where, 'Style(Type=Grid) text(border=6 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
else
	l_s_newsyntax = SQLCA.SyntaxFromSQL("select left(rtrim(customer)+space((20-len(rtrim(customer)))),20)+' '+name from cs_customers_vw " + a_s_where, 'Style(Type=Grid) text(border=6 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
end if 	
			
if LenA(l_s_error_syntaxfromSQL) > 0 then
	// Display errors
	Messagebox ( "Error",  l_s_error_syntaxfromSQL )
	DESTROY l_ds_customer
	return -1
end if

// Generate new customer DataWindow
l_ds_customer.Create(l_s_newsyntax, l_s_error_create)
if LenA(l_s_error_create) > 0 then
	MessageBox ( "Error",  l_s_error_create )
	DESTROY l_ds_customer
	return -1
end if

l_ds_customer.SetTransObject(SQLCA)
l_ds_customer.Retrieve()
commit;

i_ds_treeview.Reset ( )

l_l_row = i_ds_treeview.InsertRow ( 0 )
i_ds_treeview.object.itemlabel[l_l_row] 				= "Customer Service"
i_ds_treeview.object.parentlabel[l_l_row] 			= ""
i_ds_treeview.object.pictureindex[l_l_row]			= 1
i_ds_treeview.object.selectedpictureindex[l_l_row] = 1
i_ds_treeview.object.expanded[l_l_row] 				= 1
i_ds_treeview.object.itemhandle[l_l_row] 				= 0
i_ds_treeview.object.itemtype[l_l_row] 				= "Customer Service"
i_ds_treeview.object.itemlevel[l_l_row] 				= 1
i_ds_treeview.object.parentrow[l_l_row] 				= 0
l_l_toprow = l_l_row

ll_custrowcount = l_ds_customer.RowCount ( )
For l_l_count = 1 to ll_custrowcount

	// Add customer item
	l_s_customer = l_ds_customer.object.#1[l_l_count]
	l_s_customer_temp = wf_parsedata(l_s_customer)
	
	SELECT	start_date,
		end_date
	INTO	:l_dt_start,
		:l_dt_end
	FROM	customer_additional
	WHERE	customer = :l_s_customer_temp ;

	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= l_s_customer
	i_ds_treeview.object.parentlabel[l_l_row] 			= "Customer Service"
	i_ds_treeview.object.pictureindex[l_l_row]			= 2
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 2
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Customer"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.startdate[l_l_row]				= Today ( )
	i_ds_treeview.object.enddate[l_l_row]					= Today ( )
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_toprow
	l_l_customerrow = l_l_row
	
	// Add Quote item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Quotes"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 4
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 4 
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Quotes"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Sales Order item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Sales Orders"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 5
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 5 
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Sales Orders"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Ship Schedule item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Ship Schedule"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 6
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 6
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Ship Schedule"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Ship History item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Ship History"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 7
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 7
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Ship History"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow
	
	// Add Invoices Item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Invoices"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 13
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 13
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Invoices"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow
	
	// Add Issues item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Issues"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 8
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 8
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Issues"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Part Profile item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Part Profile"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 10
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 10
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Part Profile"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Notes item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Notes"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 11
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 11
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Notes"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Contacts Item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Contacts"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 12
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 12
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Contacts"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	// Add Contact Call Log Item
	l_l_row = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[l_l_row] 				= "Contact Call Log"
	i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
	i_ds_treeview.object.pictureindex[l_l_row]			= 12
	i_ds_treeview.object.selectedpictureindex[l_l_row] = 12
	i_ds_treeview.object.expanded[l_l_row] 				= 0
	i_ds_treeview.object.itemhandle[l_l_row] 				= 0
	i_ds_treeview.object.itemtype[l_l_row] 				= "Contact Call Log"
	i_ds_treeview.object.itemlevel[l_l_row] 				= 2
	i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow

	if g_s_platform = 'Sybase SQL Anywhere' then
		l_s_newsyntax = SQLCA.SyntaxFromSQL("select left(rtrim(destination)+space((10-length(rtrim(destination)))),10)+' '+name from destination where customer = '" + l_s_customer_temp + "'", 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
	else
		l_s_newsyntax = SQLCA.SyntaxFromSQL("select left(rtrim(destination)+space((10-len(rtrim(destination)))),10)+' '+name from destination where customer = '" + l_s_customer_temp + "'", 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
	end if 	

	if LenA(l_s_error_syntaxfromSQL) > 0 then
		// Display errors
		Messagebox ( "Error",  l_s_error_syntaxfromSQL )
		DESTROY l_ds_destination
		return -1
	end if

	// Generate new destination DataWindow
	l_ds_destination.Create(l_s_newsyntax, l_s_error_create)
	if LenA(l_s_error_create) > 0 then
		MessageBox ( "Error",  l_s_error_create )
		DESTROY l_ds_destination
		return -1
	end if

	l_ds_destination.SetTransObject(SQLCA)
	l_ds_destination.Retrieve()
	commit;
	
	ll_destrowcount = l_ds_destination.RowCount ( )
	For l_l_count2 = 1 to ll_destrowcount
		
		// Add destination item
		l_s_destination = l_ds_destination.object.#1[l_l_count2]
		l_s_destination_temp = wf_parsedata(l_s_destination)
		
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= l_s_destination
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_customer
		i_ds_treeview.object.pictureindex[l_l_row]			= 3
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 3
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Destination"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 3
		i_ds_treeview.object.startdate[l_l_row]				= Today ( )
		i_ds_treeview.object.enddate[l_l_row]					= Today ( )
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_customerrow
		l_l_destinationrow = l_l_row
		
		// Add Sales Order item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Sales Orders"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 5
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 5 
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Sales Orders"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow

		// Add Ship Schedule item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Ship Schedule"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 6
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 6
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Ship Schedule"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow

		// Add Ship History item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Ship History"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 7
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 7
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Ship History"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow

		// Add Issues item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Issues"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 8
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 8
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Issues"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow

		// Add Returns item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "RMAs"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 9
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 9
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "RMAs"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow
		ll_parentrma = l_l_row
		
		IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
			l_s_newsyntax = SQLCA.SyntaxFromSQL( "SELECT id FROM cs_returns_vw WHERE destination = '" + l_s_destination_temp + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + i_str_wheres.returns_where, 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
		ELSE
			l_s_newsyntax = SQLCA.SyntaxFromSQL( "SELECT id FROM cs_returns_vw WHERE destination = '" + l_s_destination_temp + "' " + i_str_wheres.returns_where, 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
		END IF

		if LenA(l_s_error_syntaxfromSQL) > 0 then
			// Display errors
			Messagebox ( "Error",  l_s_error_syntaxfromSQL )
			DESTROY lds_rmas
			return -1
		end if
		
		// Generate new customer DataWindow
		lds_rmas.Create(l_s_newsyntax, l_s_error_create)
		if LenA(l_s_error_create) > 0 then
			MessageBox ( "Error",  l_s_error_create )
			DESTROY lds_rmas
			return -1
		end if
		
		lds_rmas.SetTransObject(SQLCA)
		lds_rmas.Retrieve()
		commit;
	
		ll_rmarowcount = lds_rmas.RowCount ( )
	
		for ll_rmarow = 1 to ll_rmarowcount
			// Add Invoice Number item
			l_l_row = i_ds_treeview.InsertRow ( 0 )
			i_ds_treeview.object.itemlabel[l_l_row] 				= String ( lds_rmas.object.#1[ll_rmarow] )
			i_ds_treeview.object.parentlabel[l_l_row] 			= "RMAs"
			i_ds_treeview.object.pictureindex[l_l_row]			= 9
			i_ds_treeview.object.selectedpictureindex[l_l_row] = 9
			i_ds_treeview.object.expanded[l_l_row] 				= 0
			i_ds_treeview.object.itemhandle[l_l_row] 				= 0
			i_ds_treeview.object.itemtype[l_l_row] 				= "RMA"
			i_ds_treeview.object.itemlevel[l_l_row] 				= 3
			i_ds_treeview.object.parentrow[l_l_row]				= ll_parentrma
		next

		// Add Contacts Item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Contacts"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 12
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 12
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Contacts"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow

		// Add Contact Call Log Item
		l_l_row = i_ds_treeview.InsertRow ( 0 )
		i_ds_treeview.object.itemlabel[l_l_row] 				= "Contact Call Log"
		i_ds_treeview.object.parentlabel[l_l_row] 			= l_s_destination
		i_ds_treeview.object.pictureindex[l_l_row]			= 12
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 12
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= 0
		i_ds_treeview.object.itemtype[l_l_row] 				= "Contact Call Log"
		i_ds_treeview.object.itemlevel[l_l_row] 				= 4
		i_ds_treeview.object.parentrow[l_l_row]				= l_l_destinationrow
	
	Next
	
Next

DESTROY l_ds_customer
DESTROY l_ds_destination
DESTROY lds_rmas

l_l_row = i_ds_treeview.InsertRow ( 0 )
i_ds_treeview.object.itemlabel[l_l_row] 				= "Issues"
i_ds_treeview.object.parentlabel[l_l_row] 			= ""
i_ds_treeview.object.pictureindex[l_l_row]			= 8
i_ds_treeview.object.selectedpictureindex[l_l_row] = 8
i_ds_treeview.object.expanded[l_l_row] 				= 1
i_ds_treeview.object.itemhandle[l_l_row] 				= 0
i_ds_treeview.object.itemtype[l_l_row] 				= "Issues"
i_ds_treeview.object.itemlevel[l_l_row] 				= 1

return 1
end function

public subroutine wf_retrieve_info (string as_label, string as_customer, long al_parentrow, long al_itemlevel, long al_itemhandle);string		l_s_newsyntax,&
				l_s_error_syntaxfromsql,&
				l_s_error_create,&
				l_s_text,&
				l_s_customer,&
				l_s_destination
datastore	lds_invoices,&
				l_ds_destination
long			l_l_count,&
				l_l_count2,&
				l_l_row,&
				l_l_toprow,&
				l_l_customerrow,&
				l_l_destinationrow

// Instantiate customer and destination datawindows
lds_invoices		= CREATE datastore

if as_label = 'Display All Invoices' then
	l_s_newsyntax = SQLCA.SyntaxFromSQL("select invoice_number from shipper where customer = '"+as_customer+"'", '', l_s_error_syntaxfromSQL )
			
	if LenA(l_s_error_syntaxfromSQL) > 0 then
		// Display errors
		Messagebox ( "Error",  l_s_error_syntaxfromSQL )
		DESTROY lds_invoices
	end if

	// Generate new customer DataWindow
	lds_invoices.Create(l_s_newsyntax, l_s_error_create)
	if LenA(l_s_error_create) > 0 then
		MessageBox ( "Error",  l_s_error_create )
		DESTROY lds_invoices
	end if

	lds_invoices.SetTransObject(SQLCA)
	lds_invoices.Retrieve()
	commit;
	
	For l_l_count = 1 to lds_invoices.RowCount ( )

		// Add invoice item
		l_s_customer = string ( lds_invoices.object.#1[l_l_count] )
		l_l_row = i_ds_treeview.InsertRow ( i_i_rightclicked_tvrow )
		i_ds_treeview.object.itemlabel[l_l_row] 				=  l_s_customer  
		i_ds_treeview.object.parentlabel[l_l_row] 			= "Invoices"
		i_ds_treeview.object.pictureindex[l_l_row]			= 1
		i_ds_treeview.object.selectedpictureindex[l_l_row] = 1
		i_ds_treeview.object.expanded[l_l_row] 				= 0
		i_ds_treeview.object.itemhandle[l_l_row] 				= al_itemhandle
		i_ds_treeview.object.itemtype[l_l_row] 				= "Invoice"
		i_ds_treeview.object.itemlevel[l_l_row] 				= al_itemlevel 
		i_ds_treeview.object.startdate[l_l_row]				= Today ( )
		i_ds_treeview.object.enddate[l_l_row]					= Today ( )
		i_ds_treeview.object.parentrow[l_l_row]				= al_parentrow
		l_l_customerrow = l_l_row
		
		wf_addtreeviewitem ( i_ds_treeview, l_l_count )

	Next
	
end if

i_ds_treeview.print ()

DESTROY lds_invoices


end subroutine

public subroutine wf_create_shipperdetail (long al_shipper, long al_oldshipper[], long al_oldsuffix[], string as_part[]);/* 02-11-2000 KAZ Removed reference to microhelp, was confusing the user.  Issue # 13047  */


DataStore	lds_ShipperDetail

long			ll_count, &
				ll_rowcount

integer 		li_return = 1 

// create datastore for shipper detail
lds_ShipperDetail = create DataStore
lds_ShipperDetail.DataObject = "d_rma_shipper_detail"
lds_ShipperDetail.SetTransObject ( SQLCA )

// insert a row and set the values
If lds_ShipperDetail.retrieve ( al_oldshipper, al_oldsuffix, as_part ) > 0 then
	
	ll_rowcount = lds_ShipperDetail.rowcount()
	
	for ll_count = 1 to  ll_rowcount

		lds_shipperdetail.setitem ( ll_count, 44, lds_shipperdetail.object.shipper[ll_count] )
		lds_shipperdetail.setitem ( ll_count, 45, lds_shipperdetail.object.suffix[ll_count] )
		lds_shipperdetail.setitem ( ll_count, 1, al_shipper )
		lds_shipperdetail.setitem ( ll_count, 11, 'I' )
		lds_shipperdetail.setitem ( ll_count, 3, - ( lds_shipperdetail.object.#3 [ ll_count ] ) )
		lds_shipperdetail.setitem ( ll_count, 4, 0 )
		lds_shipperdetail.setitem ( ll_count, 5, - ( lds_shipperdetail.object.#5 [ ll_count ] ) )
		lds_shipperdetail.setitem ( ll_count, 6, 0 )
		lds_shipperdetail.setitem ( ll_count, 15, 0 )
		lds_shipperdetail.setitem ( ll_count, 16, 0 )
		lds_shipperdetail.setitem ( ll_count, 17, 0 )
		lds_shipperdetail.setitem ( ll_count, 24, 0 )
		lds_shipperdetail.setitem ( ll_count, 25, 0 ) 
		
	next

end if

Openwithparm ( w_rma_shipper_detail_entry, lds_shipperdetail )

//if li_return = 0 then 																							-  CHG 02-11-2000 KAZ
//																															-  CHG 02-11-2000 KAZ
//	setmicrohelp ( 'Shipper Detail has been created successfully!' )									-  CHG 02-11-2000 KAZ
//																															-  CHG 02-11-2000 KAZ
//else																													-  CHG 02-11-2000 KAZ
//																															-  CHG 02-11-2000 KAZ
//	setmicrohelp ( 'Unable to create rows!' )																	-  CHG 02-11-2000 KAZ
//																															-  CHG 02-11-2000 KAZ
//end if																													-  CHG 02-11-2000 KAZ

destroy lds_shipperdetail
	


end subroutine

public function integer wf_refresh_rmas (long al_parentrow);datetime		l_dt_start
datetime		l_dt_end

string		l_s_newsyntax
string		l_s_customer
string		l_s_error_syntaxfromsql
string		l_s_error_create
string		l_s_destination

long			ll_newrow
long			ll_row
long			ll_rowcount
long			ll_first = 0
long			ll_last = 0
long			ll_parentrow

datastore	lds_rmas

// find parent row and delete all children from datastore
ll_rowcount = i_ds_treeview.RowCount ( )

for ll_row = 1 to ll_rowcount
	ll_parentrow = i_ds_treeview.object.parentrow[ll_row]
	if ll_parentrow = al_parentrow then
		ll_first = ll_row
		ll_row = ll_rowcount
	end if
next

if ll_first > 0 then
	for ll_row = ll_first to ll_rowcount
		ll_parentrow = i_ds_treeview.object.parentrow[ll_row]
		if ll_parentrow <> al_parentrow then
			ll_row = ll_rowcount
		else
			ll_last = ll_row
		end if
	next
end if

if ll_first > 0 and ll_last > 0 then
	for ll_row = 1 to ( ll_last - ll_first + 1 )
		uo_1.tv_1.DeleteItem ( i_ds_treeview.object.itemhandle[ll_first] )
		i_ds_treeview.DeleteRow ( ll_first )
		ll_rowcount --
	next
	for ll_row = 1 to ll_rowcount
		if i_ds_treeview.object.parentrow[ll_row] > ll_last then
			i_ds_treeview.object.parentrow[ll_row] = i_ds_treeview.object.parentrow[ll_row] - ( ll_last - ll_first + 1 )
		end if
	next
end if

// get customer's start and stop dates

lds_rmas = CREATE datastore

l_s_destination = wf_parsedata(i_ds_treeview.object.parentlabel[al_parentrow])
l_s_customer = wf_parsedata(i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[al_parentrow]])

SELECT	start_date,
	end_date
INTO	:l_dt_start,
	:l_dt_end
FROM	customer_additional
WHERE	customer = :l_s_customer ;

IF NOT IsNull ( l_dt_start ) AND NOT IsNull ( l_dt_end ) THEN
	l_s_newsyntax = SQLCA.SyntaxFromSQL( "SELECT id FROM cs_returns_vw WHERE destination = '" + l_s_destination + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd" ) + "'" + i_str_wheres.returns_where, 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
ELSE
	l_s_newsyntax = SQLCA.SyntaxFromSQL( "SELECT id FROM cs_returns_vw WHERE destination = '" + l_s_destination + "' " + i_str_wheres.returns_where, 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', l_s_error_syntaxfromSQL)
END IF
			
if LenA(l_s_error_syntaxfromSQL) > 0 then
	// Display errors
	Messagebox ( "Error",  l_s_error_syntaxfromSQL )
	DESTROY lds_rmas
	return -1
end if

lds_rmas.Create(l_s_newsyntax, l_s_error_create)
if LenA(l_s_error_create) > 0 then
	MessageBox ( "Error",  l_s_error_create )
	DESTROY lds_rmas
	return -1
end if

lds_rmas.SetTransObject(SQLCA)
lds_rmas.Retrieve()
commit;

ll_rowcount = lds_rmas.RowCount ( )

for ll_row = 1 to ll_rowcount
	// Add RMA item
	ll_newrow = i_ds_treeview.InsertRow ( 0 )
	i_ds_treeview.object.itemlabel[ll_newrow] 				= String ( lds_rmas.object.#1[ll_row] )
	i_ds_treeview.object.parentlabel[ll_newrow] 				= "RMAs"
	i_ds_treeview.object.pictureindex[ll_newrow]				= 9
	i_ds_treeview.object.selectedpictureindex[ll_newrow] 	= 9
	i_ds_treeview.object.expanded[ll_newrow] 					= 0
	i_ds_treeview.object.itemhandle[ll_newrow] 				= 0
	i_ds_treeview.object.itemtype[ll_newrow] 					= "RMA"
	i_ds_treeview.object.itemlevel[ll_newrow] 				= 3
	i_ds_treeview.object.parentrow[ll_newrow]					= al_parentrow
	// refresh treeview
	wf_addtreeviewitem ( i_ds_treeview, ll_newrow )
next

destroy lds_rmas

return 0

end function

public function integer wf_create_credit_memo (long al_rma, string as_operator);long ll_invoice = 0

if sqlca.of_createcreditmemo ( al_rma, as_operator, ll_invoice ) = 0 then
	messagebox ( monsys.msg_title, 'Invoice: ' + string ( ll_invoice ) + ' was created successfully for RMA shippper :' + string ( al_rma )  + '!', Information! )
	return 1
else
	messagebox ( monsys.msg_title, 'Unable to create Credit Memo', Information! )
	return 0
end if
end function

public function integer wf_destination_scorecard (string a_s_destination, date a_dt_start, date a_dt_end);long			l_l_quote_count,&
				l_l_order_count,&
				l_l_ships_count,&
				l_l_shiph_count,&
				l_l_issues_count,&
				l_l_pastdue_count,&
				l_l_return_count,&
				l_l_cr_left_op,&
				l_l_cr_right_op,&
				l_l_otd_left_op,&
				l_l_otd_right_op,&
				l_l_rr_left_op,&
				l_l_rr_right_op
dec 			l_dec_quote_amount,&
				l_dec_order_amount,&
				l_dec_ships_amount,&
				l_dec_shiph_amount,&
				l_dec_issues_amount,&
				l_dec_pastdue_amount,&
				l_dec_return_amount,&
				l_dec_closure_rate,&
				l_dec_ontime_rate,&
				l_dec_return_rate,&
				l_dec_cr_left_op,&
				l_dec_cr_right_op,&
				l_dec_otd_left_op,&
				l_dec_otd_right_op,&
				l_dec_rr_left_op,&
				l_dec_rr_right_op,&
				l_dec_border_amount,&
				l_dec_norder_amount
string		l_s_sql_syntax,&
				l_s_sql_syntax2,&
				l_s_temp
datetime		l_dt_start,&
				l_dt_end

// Adding 5 years (ie 365 * 5 ) to get the start & the end date in relativedate function
if (isnull(a_dt_start) or a_dt_start = Today()) then 
	l_dt_start = DateTime ( RelativeDate(Today (), -1825), Time ( "00:00:01" ) )
else
	l_dt_start = DateTime ( a_dt_start, Time ( "00:00:01" ) )
end if

if (isnull(a_dt_end) or a_dt_end = Today()) then
	l_dt_end = DateTime ( RelativeDate(Today (), 1825), Time ( "23:59:59" ) )
else
	l_dt_end = DateTime ( a_dt_end, Time ( "23:59:59" ) )
end if

// Get the # and $ of quotes for this customer
select	count(q.quote_number)
into	:l_l_quote_count
from 	quote q
where 	q.status <> 'C' and 
	q.destination = :a_s_destination and 
	q.quote_date >= :l_dt_start and 
	q.quote_date <= :l_dt_end ;

if l_l_quote_count > 0 then 
	select	isnull(sum(qd.quantity * qd.price),0)
	into	:l_dec_quote_amount
	from 	quote q,
		quote_detail qd
	where 	q.quote_number = qd.quote_number and
		q.status <> 'C' and 
		q.destination = :a_s_destination and 
		q.quote_date >= :l_dt_start and 
		q.quote_date <= :l_dt_end ;
else
	l_dec_quote_amount = 0 
end if 	
		
// Get the # and $ of orders for this customer
select	count(*) 
into	:l_l_order_count
from 	order_header 
where 	isnull(order_header.status,'') <> 'C' and 
	destination = :a_s_destination and 
	order_date >= :l_dt_start and 
	order_date <= :l_dt_end ;

if l_l_order_count > 0 then
	select 	isnull(sum(IsNull ( b.price, 0 ) * IsNull(b.quantity,0)),0) 
	into	:l_dec_border_amount
	from 	order_header a, order_detail b 
	where 	a.order_no = b.order_no and 

		a.order_type = 'B' and 
		isnull(a.status,'') <> 'C' and 
		a.destination = :a_s_destination and 
		order_date >= :l_dt_start and 
		order_date <= :l_dt_end ;
	
	select 	isnull(sum(IsNull ( b.price, 0 ) * IsNull(b.quantity,0)),0) 
	into	:l_dec_norder_amount
	from 	order_header a, order_detail b 
	where 	a.order_no = b.order_no and 
		a.order_type = 'N' and 
		isnull(a.status,'') <> 'C' and 
		a.destination = :a_s_destination and 
		order_date >= :l_dt_start and 
		order_date <= :l_dt_end ;
				
	l_dec_order_amount = l_dec_border_amount + l_dec_norder_amount

else
	l_dec_order_amount = 0
end if
			

// Get the # and $ of ship schedules for this customer
select 	count(s.id),
	isnull(sum(IsNull ( sd.price, 0 ) * IsNull(sd.qty_packed,0)),0)
into	:l_l_ships_count,
	:l_dec_ships_amount
from	shipper s,
	shipper_detail sd
where 	s.id = sd.shipper and
	( s.status = 'O' or s.status = 'S' ) and 
	( s.type='O' or s.type='Q' or s.type='V' or s.type is null ) and 
	s.destination = :a_s_destination and 
	s.date_stamp >= :l_dt_start and 
	s.date_stamp <= :l_dt_end ;


// Get the # of ship histories for this customer
select 	count(s.id)
into	:l_l_shiph_count
from	shipper s
where 	s.destination = :a_s_destination  and 
	s.date_shipped >= :l_dt_start and 
	s.date_shipped <= :l_dt_end and
	(s.status = 'C' or s.status = 'Z' ) and 
	( s.type='O' or s.type='Q' or s.type='V' or s.type is null );

if l_l_shiph_count > 0 then 
	select 	isnull(sum(IsNull(sd.price,0)*IsNull(sd.qty_packed,0)),0)
	into	:l_dec_shiph_amount
	from	shipper_detail sd
	where 	sd.shipper in ( select id from shipper s where 
		s.destination = :a_s_destination  and 
		s.date_shipped >= :l_dt_start and 
		s.date_shipped <= :l_dt_end and

		(s.status = 'C' or s.status = 'Z' ) and 
		( s.type='O' or s.type='Q' or s.type='V' or s.type is null ));
		
end if 		

// Issues will go here
select	count(*)
into	:l_l_issues_count
from	cs_issues_vw
where	origin = :a_s_destination and
	type = 'O' 
	AND start_date >= :l_dt_start AND start_date <= :l_dt_end ;

// Get the # of past due orders
select 	count(*) 
into	:l_l_pastdue_count
from 	order_header 
where 	datediff(day,(select min(due_date) from order_detail where order_detail.order_no = order_header.order_no),GetDate()) > 0 and 
	isnull(order_header.status,'') <> 'C' and 
	order_header.destination = :a_s_destination and 
	order_date >= :l_dt_start and 
	order_date <= :l_dt_end ;

if l_l_pastdue_count > 0 then
	select	isnull(sum(IsNull ( price, 0 ) * IsNull((	select	sum(isnull(quantity,0))
	from	order_detail
	where	order_detail.order_no = order_header.order_no),0)),0) 
	into	:l_dec_border_amount
	from 	order_header
	where 	order_type = 'B' and 
		datediff(day,(select min(due_date) from order_detail where order_detail.order_no = order_header.order_no),GetDate()) > 0 and 
		isnull(order_header.status,'') <> 'C' and 
		order_header.destination = :a_s_destination and 
		order_date >= :l_dt_start and 
		order_date <= :l_dt_end ;
	
	select 	isnull(sum(IsNull ( b.price, 0 ) * IsNull(b.quantity,0)),0) 
	into	:l_dec_norder_amount
	from 	order_header a, order_detail b 
	where 	a.order_no = b.order_no and 
		datediff(day,(select min(due_date) from order_detail where order_detail.order_no = a.order_no),GetDate()) > 0 and 
		a.order_type = 'N' and 
		isnull(a.status,'') <> 'C' and 
		a.destination = :a_s_destination and 
		order_date >= :l_dt_start and 
		order_date <= :l_dt_end ;
				
	l_dec_pastdue_amount = l_dec_border_amount + l_dec_norder_amount
else
	l_dec_pastdue_amount = 0
end if


// Get the # and $ of returns for this customer
select 	count(*),
	isnull(sum(IsNull(qty_packed,0) * IsNull(price,0)),0)
into	:l_l_return_count,
	:l_dec_return_amount
from	cs_rma_detail_vw
	join cs_returns_vw on id = shipper
where 	cs_returns_vw.status <> 'C' and cs_returns_vw.status <> 'E' and
	destination = :a_s_destination and 
	date_stamp >= :l_dt_start and 
	date_stamp <= :l_dt_end ;


// Get the closure rate for the date range given
select	count(*) 
into	:l_l_cr_left_op
from 	quote 
where 	quote.status <> 'C' and 
	customer = :a_s_destination and 
	quote_date >= :l_dt_start and 
	quote_date <= :l_dt_end ;

select 	count(*) 
into	:l_l_cr_right_op
from 	quote 
where 	customer = :a_s_destination and 
	quote_date >= :l_dt_start and 
	quote_date <= :l_dt_end ;

if IsNull(l_l_cr_right_op) or l_l_cr_right_op = 0 then
	l_dec_closure_rate = 0
else
	l_dec_closure_rate = l_l_cr_left_op / l_l_cr_right_op
end if

// Get the on-time delivery rating for the date range given
select 	count(*) 
into	:l_l_otd_left_op
from 	shipper 
where 	date_shipped is null and 
	customer = :a_s_destination and 
	date_stamp >= :l_dt_start and 
	date_stamp <= :l_dt_end ;

select 	count(*) 
into	:l_l_otd_right_op
from 	shipper 
where 	customer = :a_s_destination and 
	date_stamp >= :l_dt_start and 
	date_stamp <= :l_dt_end ;
			
if IsNull(l_l_otd_right_op) or l_l_otd_right_op = 0 then
	l_dec_ontime_rate = 0
else
	l_dec_ontime_rate = l_l_otd_left_op / l_l_otd_right_op
end if


// Get the return rating for the date range given
select 	sum(IsNull(qty_packed,0))
into	:l_l_rr_left_op
from 	cs_rma_detail_vw
	join cs_returns_vw on id = shipper
where 	cs_returns_vw.status <> 'C' and 
	customer = :a_s_destination and 
	date_stamp >= :l_dt_start and 
	date_stamp <= :l_dt_end ;

select 	sum(IsNull(sd.qty_packed,0)) 
into	:l_l_rr_right_op
from 	shipper s, shipper_detail sd 
where 	s.id = sd.shipper and 
	s.customer = :a_s_destination and 
	s.date_shipped >= :l_dt_start and 
	s.date_shipped <= :l_dt_end ;
			
if IsNull(l_l_rr_right_op) or l_l_rr_right_op = 0 then
	l_dec_return_rate = 0
else
	l_dec_return_rate = l_l_rr_left_op / l_l_rr_right_op
end if

uo_1.dw_1.Reset ( )
uo_1.dw_1.InsertRow ( 1 )
uo_1.dw_1.object.quote_count[1] = l_l_quote_count
uo_1.dw_1.object.order_count[1] = l_l_order_count
uo_1.dw_1.object.ships_count[1] = l_l_ships_count
uo_1.dw_1.object.shiph_count[1] = l_l_shiph_count
uo_1.dw_1.object.issues_count[1] = l_l_issues_count
uo_1.dw_1.object.pastdue_count[1] = l_l_pastdue_count
uo_1.dw_1.object.return_count[1] = l_l_return_count
uo_1.dw_1.object.quote_amount[1] = l_dec_quote_amount
uo_1.dw_1.object.order_amount[1] = l_dec_order_amount
uo_1.dw_1.object.ships_amount[1] = l_dec_ships_amount
uo_1.dw_1.object.shiph_amount[1] = l_dec_shiph_amount
uo_1.dw_1.object.pastdue_amount[1] = l_dec_pastdue_amount
uo_1.dw_1.object.return_amount[1] = l_dec_return_amount
uo_1.dw_1.object.closure_rate[1] = l_dec_closure_rate
uo_1.dw_1.object.ontime_rate[1] = l_dec_ontime_rate
uo_1.dw_1.object.return_rate[1] = l_dec_return_rate

return 1

end function

public function string wf_parsedata (string as_data);string	ls_parseddata
//int	li_i, li_pos, li_len

//int	li_pos=0, &
//	li_nextpos=0, &
//	li_len

//for li_i = 1 to 10
//	if mid(as_data, li_i,1) = ' ' then li_pos = li_i
//next
//

//li_pos = pos(as_data, ' ', 1)
//li_nextpos = pos(as_data, ' ', li_pos+1)
//if li_nextpos = 11 then li_pos = li_nextpos

//li_len = len(as_data)

//if li_pos > 0 then 
//	ls_parseddata = trim(left(as_data, (li_len - (li_len - (li_pos - 1) ))))
	ls_parseddata = trim(LeftA(as_data, 10))	
//else
//	ls_parseddata = as_data
//end if 	

return ls_parseddata
end function

on w_customerservice_old.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_customer_service_center" then this.MenuID = create m_customer_service_center
this.dw_parm=create dw_parm
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parm
this.Control[iCurrent+2]=this.uo_1
end on

on w_customerservice_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parm)
destroy(this.uo_1)
end on

event resize;call super::resize;//  Resize explorer user object
uo_1.height = height - 125
uo_1.width 	= width - 75
end event

event activate;call super::activate;long 	ll_rowcount
long	ll_row

//  Enable/Disable toolbar items depending on current tree view item
if i_i_clicked_tvrow > 0 then
	Choose Case i_ds_treeview.object.itemtype[i_i_clicked_tvrow]
		Case "Customer Service", "Quotes", "Sales Order", "RMA"
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
		Case "Invoices"
			ll_rowcount = uo_1.dw_1.RowCount ( )
			for ll_row = 1 to ll_rowcount
				if uo_1.dw_1.IsSelected ( ll_row ) then
					Exit
				end if
			next
			if ll_row = ll_rowcount then
				m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			else

				m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
			end if
		Case "Ship Schedule"
			ll_rowcount = uo_1.dw_1.RowCount ( )
			for ll_row = 1 to ll_rowcount
				if uo_1.dw_1.IsSelected ( ll_row ) then
					Exit
				end if
			next
			if ll_row = ll_rowcount then
				m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
			else
				m_customer_service_center.mf_setup ( FALSE, TRUE, FALSE, FALSE, TRUE )
			end if
		Case "Customer", "Ship History"
			m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		Case "Part Profile", "Notes"
			m_customer_service_center.mf_setup ( FALSE, FALSE, TRUE, FALSE, FALSE )
		Case "Issues"
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
			m_customer_service_center.m_file.m_refresh.enabled = true
	End Choose
else
	m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
end if
end event

type dw_parm from datawindow within w_customerservice_old
boolean visible = false
integer x = 1170
integer y = 736
integer width = 494
integer height = 364
integer taborder = 20
boolean livescroll = true
end type

type uo_1 from u_explorer_plus within w_customerservice_old
event type integer ue_dragdropopen ( long a_l_handle,  string a_s_tag )
integer width = 1975
integer height = 1072
integer taborder = 10
string dragicon = "Application!"
end type

event ue_dragdropopen;long						ll_shipper
long						ll_oldshipper[]
long						ll_oldsuffix[]
long						ll_rma

treeviewitem			l_tvi_item
st_generic_structure	l_str_parm

String 					ls_operator, &
							ls_part[], &
							ls_newsyntax, &
							ls_error_syntaxfromsql, &
							ls_error_create

datastore 				lds_rmadetail

lds_rmadetail		= create datastore

tv_1.GetItem ( a_l_handle, l_tvi_item )

Choose Case a_s_tag
	Case "Quotes"
		long	l_l_quote
		l_l_quote = dw_1.object.quote_number[dw_1.GetRow ( )]
		l_str_parm.value1 = String ( l_l_quote )
		Choose Case wf_valid_quote ( l_l_quote )
			Case 1
				SetPointer ( HourGlass! )
				OpenSheetWithParm ( w_blanket_order, l_str_parm, gnv_App.of_GetFrame(), 0, Original! )
			Case 2
				SetPointer ( HourGlass! )
				OpenSheetWithParm ( w_orders_detail, l_str_parm, gnv_App.of_GetFrame(), 0, Original! )
			Case 3
				// cancelled
			Case else
				MessageBox ( "System Message", "This quote is closed or has expired.  Unable to continue.", StopSign! )
		End Choose
	Case "Sales Orders"
	Case "Ship History"
		ll_shipper	  = long ( l_tvi_item.label )
		ll_oldshipper = dw_1.object.#1.Selected
		ll_oldsuffix  = dw_1.object.#3.Selected
		ls_part		  = dw_1.object.#2.Selected
		
		wf_create_shipperdetail ( ll_shipper, ll_oldshipper, ll_oldsuffix , ls_part ) 
	Case "RMAs"
		ll_Rma = dw_1.object.#1[dw_1.getrow()]
		
		// create datastore to check if there are rows to be deleted	
		ls_newsyntax = SQLCA.SyntaxFromSQL( "SELECT * FROM cs_rma_detail_vw WHERE qty_packed = 0 or - ( qty_packed ) < - ( qty_required ) and shipper = " + string ( ll_Rma ), 'Style(Type=Grid) text(border=6 background.mode=2 background.color=12632256 font.weight=700)', ls_error_syntaxfromSQL)
		if LenA(ls_error_syntaxfromSQL) <= 0 then
			lds_rmadetail.Create(ls_newsyntax, ls_error_create)
			lds_rmadetail.SetTransObject(SQLCA)
		end if
		
		// inform the user if there are unprocessed rma detail items.
		if lds_rmadetail.Retrieve() > 0 then
			if MessageBox ( monsys.msg_title, "System will delete all unproccessed items on the RMA.  ~r" + &
												 "The credit will only be issued to items that were received back. ~r" + &
												 "Would you like to continue? ", StopSign!, YesNo!, 1 )	= 2 then
					 return 1
			end if
		end if
		destroy lds_rmadetail ;
		
		Open ( w_std_password )
		ls_operator = message.stringparm 
	
		if ls_operator > '' then
			if wf_create_credit_memo ( ll_rma, ls_operator ) = 1 then
				if uo_1.dw_1.Tag = 'RMAs' then
					uo_1.dw_1.Retrieve ( )
				end if
				wf_refresh_rmas ( i_i_clicked_tvrow )
			end if
		else
			MessageBox ( monsys.msg_title, "Unable to issue credit memo!", StopSign! )			
		end if
End Choose

return 1
end event

on uo_1.destroy
call u_explorer_plus::destroy
end on

event tv_constructor;uo_1.tv_1.deleteitems 		= FALSE
uo_1.tv_1.editlabels			= FALSE
uo_1.tv_1.hasbuttons			= TRUE
uo_1.tv_1.haslines			= TRUE
uo_1.tv_1.hideselection		= FALSE
uo_1.tv_1.linesatroot		= TRUE
uo_1.tv_1.pictureheight		= 16
uo_1.tv_1.picturewidth		= 16
uo_1.tv_1.AddPicture ( "globes.ico" )			// Customer Service 1
uo_1.tv_1.AddPicture ( "mask.ico" )				// Each Customer 2
uo_1.tv_1.AddPicture ( "map.bmp" )				// Destination 3
uo_1.tv_1.AddPicture ( "dollar2.ico" )			// Quotes 4
uo_1.tv_1.AddPicture ( "clipbrd.ico" )			// Sales Order 5
uo_1.tv_1.AddPicture ( "truck2.ico" )			// Ship Schedule 6
uo_1.tv_1.AddPicture ( "graphup.ico" )			// Ship History 7
uo_1.tv_1.AddPicture ( "folderin.ico" )		// Issues 8
uo_1.tv_1.AddPicture ( "recycle.ico" )			// Returns 9
uo_1.tv_1.AddPicture ( "hierarch.bmp" )		// Part Profile 10
uo_1.tv_1.AddPicture ( "pencil.ico" )			// Notes 11
uo_1.tv_1.AddPicture ( "objcomm.bmp" )			// Contacts 12
uo_1.tv_1.AddPicture ( "about.ico" )			//invoices 13

return 1
end event

event ue_setup;long				l_l_count

i_ds_treeview.DataObject = "d_customer_treeview_external"
i_str_wheres.customer_where = "customer = ''"

wf_retrieve_datastore ( i_str_wheres.customer_where )

wf_build_treeview ( )

tv_1.SelectItem ( 1 )
wf_retrieve_dw_view ( "SELECT * FROM cs_customers_vw where customer = '' ORDER BY create_date DESC" )
i_i_clicked_tvrow = i_ds_treeview.Find ( "itemlevel = 1", 1, i_ds_treeview.RowCount ( ) )

m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )


end event

event constructor;call super::constructor;// Create instance of treeview datastore
i_ds_treeview = CREATE datastore

end event

event destructor;call super::destructor;// Destroy instance of treeview datastore
DESTROY i_ds_treeview

end event

event tv_clicked;//	Declare local variables
long	l_l_parenthandle,&
	l_l_row
long	ll_parentrow
long	ll_count

treeviewitem	l_tvi_item

string	l_s_itemtype,&
	l_s_prevsort,&
	ls_customer
string	ls_itemtype
string	ls_destination
datetime l_dt_start,&
	 l_dt_end
						
//int	li_pos, &
//	li_len

// If not a valid treeview item is clicked then exit
if handle < 1 then return 1

// Get current item
tv_1.GetItem ( handle, l_tvi_item )

// Find current item in treeview datastore
l_l_row = i_ds_treeview.Find ( "itemhandle = " + string ( l_tvi_item.itemhandle ), 1, i_ds_treeview.RowCount ( ) )

IF l_l_row < 1 THEN return 1

if i_i_clicked_tvrow < 1 then return 1

// Assign clicked row to instance var
i_i_clicked_tvrow = l_l_row

SetMicroHelp ( "" )

ll_parentrow = i_i_clicked_tvrow
Do While ( ll_parentrow > 0 )
	Choose Case i_ds_treeview.object.itemtype[ll_parentrow]
		Case "Customer"
			ls_customer = wf_parsedata(i_ds_treeview.object.itemlabel[ll_parentrow])
			if ls_itemtype = '' then
				ls_itemtype = "Customer"
			end if
		Case "Destination"
			ls_destination = wf_parsedata(i_ds_treeview.object.itemlabel[ll_parentrow])
			if ls_itemtype = '' then
				ls_itemtype = "Destination"
			end if
	End Choose
	ll_parentrow = i_ds_treeview.object.parentrow[ll_parentrow]
Loop
if ls_customer > '' then

	select	count(customer)
	into		:ll_count
	from		customer_additional
	where		customer = :ls_customer ;

	if ll_count <= 0 then
		insert into customer_additional ( customer, type )
			values ( :ls_customer, ' ' ) ;
			
		if sqlca.sqlcode = 0 then
			commit;
		else
			rollback;
			MessageBox ( monsys.msg_title, "Unable to create customer_additional record!", StopSign! )
			return -1
		end if
	end if
	
	SELECT	isnull(start_date,dateadd ( yy, -5, GetDate ( ) ) ),
		isnull(end_date,dateadd ( yy, 5, GetDate ( ) ) )
	INTO	:l_dt_start,
		:l_dt_end
	FROM	customer_additional
	WHERE	customer = :ls_customer ;
	
	l_dt_start = datetime ( date ( l_dt_start) , time ( '00:00:01') ) 
 	l_dt_end = datetime ( date ( l_dt_end) , time ( '23:59:59') ) 
	
end if

il_lasthandle = handle

SetPointer ( HourGlass! )

m_customer_service_center.m_file.m_refresh.enabled = false

// Get current item type and take appropriate action
Choose Case i_ds_treeview.object.itemtype[i_i_clicked_tvrow]
	Case "Customer Service"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		if i_str_wheres.customer_where > '' then
			wf_retrieve_dw_view ( "SELECT * FROM cs_customers_vw WHERE "  + i_str_wheres.customer_where + " ORDER BY customer " )
		else
			wf_retrieve_dw_view ( "SELECT * FROM cs_customers_vw ORDER BY customer " )
		end if
		dw_1.Tag = "Customer Service"
	Case "Customer"
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		uo_1.of_setrightpanel ( "datawindow" )
		dw_1.DataObject = "d_customer_scorecard"
		dw_1.SetTransObject ( sqlca )
		SetMicroHelp ( "Getting customer data from database, please wait..." )
		dw_1.Retrieve ( ls_customer )
		dw_1.Tag = "Customer"
	
	Case "Destination"
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		uo_1.of_setrightpanel ( "datawindow" )
		dw_1.DataObject = "d_customer_scorecard"
		dw_1.SetTransObject ( sqlca )
//		wf_destination_scorecard ( l_tvi_item.label, date(l_dt_start), date(l_dt_end))
		wf_destination_scorecard ( ls_destination, date(l_dt_start), date(l_dt_end))		

//		This was included to disable editing of dates on individual destination
//		If they want to do that they have to go back to the customer sc and then 
//		change it there
		dw_1.settaborder ( "start_date", 0)
		dw_1.settaborder ( "end_date", 0)
		dw_1.modify ( "displaynote.visible = 0" )
		dw_1.modify ( "start_date.Background.color = " + String ( f_get_color_value ( "gray" ) ) )
		dw_1.modify ( "end_date.Background.color = " + String ( f_get_color_value ( "gray" ) ) )		
		
		dw_1.Tag = "Destination"
		dw_1.SetItem ( 1, "start_date", l_dt_start )
		dw_1.SetItem ( 1, "end_date", l_dt_end )
	Case "Quotes"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		wf_retrieve_dw_view ( "SELECT * FROM cs_quotes_vw WHERE cs_quotes_vw.customer = '" + ls_customer + "' AND quote_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND quote_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "'" + i_str_wheres.quote_where )
		dw_1.Tag = "Quotes"
	Case "Sales Orders"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		Choose Case ls_itemtype
			Case "Customer"
				wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.customer = '" + ls_customer + "' AND order_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND order_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "'" + i_str_wheres.salesorder_where )
			Case "Destination"
				wf_retrieve_dw_view ( "SELECT * FROM cs_orders_vw WHERE cs_orders_vw.destination = '" + ls_destination + "' AND order_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND order_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "'" + i_str_wheres.salesorder_where )
		End Choose
		dw_1.Tag = "Sales Orders"
		dw_1.Trigger Event ue_change_color ( "due_date", Today ( ), f_get_color_value ( "darkgreen" ), f_get_color_value ( "brown" ), f_get_color_value ( "red" ), "foreground", true )
	Case "Ship Schedule"
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		uo_1.of_setrightpanel ( "datawindow" )
		m_customer_service_center.mf_show_cancel ( TRUE )
		dw_1.DataObject = "d_cs_ship_schedule"
		CHOOSE CASE ls_itemtype
			CASE "Customer"
				dw_1.SetTransObject ( sqlca )
				dw_1.Retrieve ( ls_customer, DateTime ( Date ( l_dt_start ), Time ( "00:00:01" ) ), DateTime ( Date ( l_dt_end ), Time ( "23:59:59" ) ) )
			CASE "Destination"
				dw_1.SetTransObject ( sqlca )
				dw_1.Retrieve ( ls_destination, DateTime ( Date ( l_dt_start ), Time ( "00:00:01" ) ), DateTime ( Date ( l_dt_end ), Time ( "23:59:59" ) ) )
		END CHOOSE
//		dw_1.SetFilter ( i_str_wheres.shipsched_where )
//		dw_1.Filter ( )
		m_customer_service_center.mf_show_cancel ( FALSE )
		dw_1.Tag = "Ship Schedule"
	Case "Ship History"
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
			CASE "Customer"
				wf_retrieve_dw_view ( "select * from cs_ship_history_vw where customer = '" + ls_customer + "' AND date_shipped >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND date_shipped <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) +  "'" + i_str_wheres.shiphist_where )
			CASE "Destination"

				wf_retrieve_dw_view ( "select * from cs_ship_history_vw where destination = '" + ls_destination + "' AND date_shipped >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND date_shipped <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) +  "'" + i_str_wheres.shiphist_where )
		END CHOOSE
		dw_1.Tag = "Ship History" 
	Case "RMA"
		m_customer_service_center.mf_setup ( FALSE, TRUE, FALSE, FALSE, TRUE )
		wf_retrieve_dw_view ( "select * from cs_rma_detail_vw where shipper = " + i_ds_treeview.object.itemlabel[i_i_clicked_tvrow] )
		dw_1.Tag = "RMA" 
	Case "Invoices"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		wf_retrieve_dw_view ( "SELECT * FROM cs_invoices_vw WHERE customer = '" + ls_customer + "' AND date_shipped >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND date_shipped <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "'" + i_str_wheres.invoices_where )
		dw_1.Tag = "Invoices"
	Case "Issues"
		parent.event Activate ( )
		m_customer_service_center.m_file.m_refresh.enabled = true		

		dw_1.DataObject = "d_issues_list"
		dw_1.SetTransObject ( sqlca )
		is_issue_syntax = dw_1.object.datawindow.table.select

		if i_ds_treeview.object.itemlevel[i_i_clicked_tvrow] = 1 then
			if isnull(i_str_wheres.issues_where,'') > '' then
				dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' " + i_str_wheres.issues_where
			else
				dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE type = 'O' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' "
			end if
		else
			CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				CASE "Customer"
					if isnull(i_str_wheres.issues_where, '') > '' then
						dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_customer + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' " + i_str_wheres.issues_where
					else
						dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_customer + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' "
					end if
				CASE "Destination"
					if isnull(i_str_wheres.issues_where, '') > '' then
						dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_destination + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' " + i_str_wheres.issues_where
					else
						dw_1.object.datawindow.table.select = is_issue_syntax + " WHERE origin = '" + ls_destination + "' AND start_date >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND start_date <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' "
					end if
			END CHOOSE
		end if
		dw_1.SetTransObject ( sqlca )
		dw_1.Retrieve ( )
		dw_1.Tag = "Issues"
	Case "RMAs"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		wf_retrieve_dw_view ( "SELECT * FROM cs_returns_vw WHERE destination = '" + ls_destination + "' AND date_stamp >= '" + String ( l_dt_start, "yyyy/mm/dd hh:mm:ss" ) + "' AND date_stamp <= '" + String ( l_dt_end, "yyyy/mm/dd hh:mm:ss" ) + "' " + i_str_wheres.returns_where )
		dw_1.Tag = "RMAs"
	Case "Part Profile"
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		wf_retrieve_dw_view ( "SELECT * FROM cs_part_profile_vw WHERE cs_part_profile_vw.customer = '" + ls_customer + "'" + i_str_wheres.profile_where )
		dw_1.Tag = "Part Profile"
	Case "Notes"
		m_customer_service_center.mf_setup ( FALSE, FALSE, TRUE, FALSE, FALSE )
		uo_1.of_setrightpanel ( "datawindow" )
		dw_1.DataObject = "d_customer_notes"
		dw_1.SetTransObject ( sqlca )
		m_customer_service_center.mf_show_cancel ( TRUE )
		dw_1.Retrieve ( ls_customer )
		m_customer_service_center.mf_show_cancel ( FALSE )
		dw_1.Tag = "Notes"
	Case "Contacts"
		m_customer_service_center.mf_setup ( TRUE, TRUE, FALSE, FALSE, TRUE )
		CHOOSE CASE ls_itemtype
			CASE "Customer"
				wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE customer = '" + ls_customer + "'" + i_str_wheres.contacts_where )
			CASE "Destination"
				wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE destination = '" + ls_destination + "'" + i_str_wheres.contacts_where )
		END CHOOSE
		dw_1.Tag = "Contacts"
	Case "Contact Call Log"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
		CHOOSE CASE ls_itemtype
			CASE "Customer"
				wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE customer = '" + ls_customer + "' and start_date >= '"+string(l_dt_start, 'yyyy/mm/dd hh:mm:ss') +"' and start_date <= '"+string(l_dt_end,'yyyy/mm/dd hh:mm:ss')+"'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
			CASE "Destination"
				wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE destination = '" + ls_destination + "' and start_date >= '"+string(l_dt_start, 'yyyy/mm/dd hh:mm:ss') +"' and start_date <= '"+string(l_dt_end,'yyyy/mm/dd hh:mm:ss')+"'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
		END CHOOSE
		dw_1.Tag = "Contact Call Log"
End Choose
SetMicroHelp ( "" )
SetPointer ( Arrow! )

return 0
end event

event tv_dragdrop;treeviewitem			l_tvi_item
long						l_l_order,&
							l_l_row
st_generic_structure	l_str_parm
string					l_s_prevsort,&
							l_s_temp

if handle < 1 then return 1

SetPointer ( HourGlass! )

tv_1.GetItem ( handle, l_tvi_item )

l_l_row = i_ds_treeview.Find ( "itemhandle = " + string ( handle ), 1, i_ds_treeview.RowCount ( ) )

if l_l_row > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.itemlabel[l_l_row] then 
		return 1
	end if
else
	return 1
end if

SetPointer ( HourGlass! )

CHOOSE CASE i_ds_treeview.object.itemtype[l_l_row]
	CASE "Sales Orders"
		if source.Tag <> "Quotes" then return 1
		if source.DragIcon <> "clipbrd.ico" then return 1
	CASE "RMA"
		if source.Tag <> "Ship History" then return 1
		if source.DragIcon <> "recycle.ico" then return 1
	CASE "Invoices"
		if source.Tag <> "RMAs" then return 1
		if source.DragIcon <> "about.ico" then return 1
	CASE ELSE
		return 1
END CHOOSE

SetPointer ( HourGlass! )

dw_1.Drag ( End! )

Post Event ue_dragdropopen ( handle, dw_1.Tag )

SetPointer ( Arrow! )

return 0
end event

event tv_rightclicked;window				l_w_mdiframe
int					l_i_count
treeviewitem		l_tvi_item
string				l_s_prevsort
m_explorer_base	l_m_popup,&
						l_m_popupitems[]
boolean				l_b_nomenu

if handle < 1 then 
	tv_1.SelectItem ( i_i_clicked_tvrow )
	return 1
end if

tv_1.GetItem ( handle, l_tvi_item )

if NOT l_tvi_item.Selected then
	tv_1.SelectItem ( i_i_clicked_tvrow )
	return 1
end if

i_i_rightclicked_tvrow = i_ds_treeview.Find ( "itemhandle = " + string ( l_tvi_item.itemhandle ), 1, i_ds_treeview.RowCount ( ) )

if i_i_rightclicked_tvrow > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.itemlabel[i_i_rightclicked_tvrow] then
		i_i_rightclicked_tvrow = 0
		tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_clicked_tvrow] )
		return 1
	end if
else
	tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_clicked_tvrow] )
	return 1
end if

Choose Case i_ds_treeview.object.itemtype[i_i_rightclicked_tvrow]
	Case "Customer Service"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Customer"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Customer Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
		l_m_popupitems[4] = CREATE m_explorer_base
		l_m_popupitems[4].Item[1].Text = "Display All Customers"
	Case "Customer"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Customer"
	Case "Destination"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Destination"
	Case "Quotes"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Quote"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Quote Search"
		l_m_popupitems[3] = CREATE m_explorer_base

		l_m_popupitems[3].Item[1].Text = "Reset Search"
	Case "Sales Orders"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Sales Order"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Sales Order Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
	Case "Ship Schedule"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Ship Schedule Search"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Reset Search"
	Case "Ship History"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Ship History Search"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Ship History Summary"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Ship History Detail"
		l_m_popupitems[4] = CREATE m_explorer_base
		l_m_popupitems[4].Item[1].Text = "Reset Search"

	Case "Invoices"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Invoice Search"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Reset Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Display All Invoices"
	Case "RMAs"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New RMA"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "RMAs Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
		l_m_popupitems[4] = CREATE m_explorer_base
		l_m_popupitems[4].Item[1].Text = "Display All RMAs"
	Case "RMA"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit RMA"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Delete RMA"
	Case "Invoice"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Invoice"
	Case "Part Profile"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Profile"
	Case "Contacts"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Contact"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Contact Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
	Case "Contact Call Log"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Call"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Contact Call Log Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
	Case "Issues"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "New Issue"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Issue Search"
		l_m_popupitems[3] = CREATE m_explorer_base
		l_m_popupitems[3].Item[1].Text = "Reset Search"
//		l_m_popupitems[4] = CREATE m_explorer_base
//		l_m_popupitems[4].Item[1].Text = "Word/Phrase Search"
	Case Else
		l_b_nomenu = TRUE
End Choose

if NOT l_b_nomenu then

	l_m_popup = CREATE m_explorer_base

	l_w_mdiframe = Parent.ParentWindow ( )

	For l_i_count = 1 to UpperBound ( l_m_popupitems )
		l_m_popup.m_action.Item[l_i_count] = l_m_popupitems[l_i_count].Item[1]
	Next
	
	if isvalid ( l_w_mdiframe ) then
		l_m_popup.m_action.PopMenu ( l_w_mdiframe.PointerX(), l_w_mdiframe.PointerY() )
	else
		l_m_popup.m_action.PopMenu ( Parent.PointerX(), Parent.PointerY() )
	end if
	
	if i_i_clicked_tvrow > 0 then &
		tv_1.SelectItem ( i_ds_treeview.object.itemhandle[i_i_clicked_tvrow] )
	
end if

return 0
end event

event dw_clicked;// If not a valid clicked datawindow row then exit
if row < 1 then
	m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, FALSE )
	return 0
end if

// Get the current item type from dw_1.tag and take appropriate action
Choose Case dw_1.Tag
	Case "Customer"
	Case "Quotes"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
		Super::Event dw_clicked ( xpos, ypos, row, dwo )
		dw_1.DragIcon = "not.ico"
		dw_1.Drag ( Begin! )
	Case "Sales Orders"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
		Super::Event dw_clicked ( xpos, ypos, row, dwo )
	Case "Ship Schedule"
		m_customer_service_center.mf_setup ( FALSE, TRUE, FALSE, FALSE, TRUE )
		Super::Event dw_clicked ( xpos, ypos, row, dwo )
	Case "Ship History"
//		Super::Event dw_clicked ( xpos, ypos, row, dwo )
		m_customer_service_center.mf_setup ( FALSE, FALSE, FALSE, FALSE, TRUE )
		dw_1.SelectRow ( row, NOT dw_1.IsSelected ( row ) )
		dw_1.DragIcon = "not.ico"
		dw_1.Drag ( Begin! )
	Case "Issues"
		// Turn all selections off in dw_1
		dw_1.SelectRow ( 0, FALSE )
		
		// If not a valid doubleclicked row then exit
		if row < 1 then return 0
		
		// Select doubleclicked row
		dw_1.SelectRow ( row, TRUE )
	Case "RMAs"
		m_customer_service_center.mf_setup ( FALSE, TRUE, FALSE, FALSE, TRUE )
		Super::Event dw_clicked ( xpos, ypos, row, dwo )
		dw_1.DragIcon = "not.ico"
		dw_1.Drag ( Begin! )
	Case "RMA"
		m_customer_service_center.mf_setup ( FALSE, TRUE, FALSE, FALSE, TRUE )
		Super::Event dw_clicked ( xpos, ypos, row, dwo )
	Case "Invoices"
		m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, TRUE, TRUE )
		dw_1.SelectRow ( row, NOT dw_1.IsSelected ( row ) )
	Case "Part Profile"
	Case "Notes"
	case "Contacts", "Contact Call Log"
		dw_1.SelectRow ( 0, FALSE )
		if row < 1 then return 0
		dw_1.SelectRow ( row, TRUE )
End Choose

return 0
end event

event dw_doubleclicked;// Declare local variables
long						l_l_data
string					l_s_data
st_generic_structure	l_str_parm

// Turn all selections off in dw_1
dw_1.SelectRow ( 0, FALSE )

// If not a valid doubleclicked row then exit
if row < 1 then return 0

// Select doubleclicked row
if dw_1.dataobject <> 'd_customer_scorecard' then dw_1.SelectRow ( row, TRUE )

// Get label from treeview and take appropriate action
Choose Case i_ds_treeview.object.itemlabel[i_i_clicked_tvrow]
	Case "Quotes"
		l_str_parm.value1 = String ( dw_1.GetItemNumber ( row, "quote_number" ) )
		l_str_parm.value2 = dw_1.GetItemString ( row, "customer" )
		OpenSheetWithParm ( w_single_quote_admin, l_str_parm, gnv_App.of_GetFrame(), 0, Original! )
	Case "Sales Orders"
		l_l_data = dw_1.GetItemNumber ( row, "order_no" )
		OpenSheetWithParm ( w_decide_order, l_l_data, gnv_App.of_GetFrame(), 0, Original! )
	Case "Ship Schedule"
		l_l_data = dw_1.GetItemNumber ( row, "id" )
		OpenSheetWithParm ( w_cs_shipping_schedule, l_l_data, gnv_App.of_GetFrame(), 0, Original! )
	Case "Ship History"
		l_l_data = dw_1.GetItemNumber ( row, 1 )
		OpenSheetWithParm ( w_cs_ship_history, l_l_data, gnv_App.of_GetFrame(), 0, Original! )
	Case "Issues"
		l_str_parm.value1 = String ( dw_1.GetItemNumber ( row, "issue_number" ) )
		l_str_parm.value2 = string ( dw_1.GetItemNumber ( 1,   "issue_number" ) )
		l_str_parm.value3 = string ( dw_1.GetItemNumber ( dw_1.Rowcount(), "issue_number" ) )
		OpenSheetWithParm ( w_issue_manager, l_str_parm, gnv_App.of_GetFrame(), 0, Original! )
	Case "RMAs"
		l_str_parm.value1 = String ( dw_1.object.#1[row] )
		OpenWithParm ( w_rma_admin_entry, l_str_parm )
	Case "Part Profile"
		l_s_data = i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]
		OpenSheetWithParm ( w_orders_customer_price_matrix, l_s_data, gnv_App.of_GetFrame(), 0, Original! )
	Case "Notes"
	Case "Contacts"
		l_str_parm.value1 = dw_1.GetItemString ( row, 1 )
		IF i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] = "Destination" THEN
			l_str_parm.value2 = i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
			l_str_parm.value3 = i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]
		ELSE
			l_str_parm.value2 = i_ds_treeview.object.parentlabel[i_i_clicked_tvrow]
		END IF
		OpenWithParm ( w_contact_entry, l_str_parm )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, TRUE, FALSE, FALSE, TRUE )
			CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE customer = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contacts_where )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contacts_vw WHERE destination = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contacts_where )
			END CHOOSE
		end if
	Case "Contact Call Log"
		l_str_parm.value1 = dw_1.GetItemString ( row, 1 )
		l_str_parm.value2 = String ( dw_1.GetItemDateTime ( row, 2 ), "mm/dd/yyyy hh:mm:ss" )
		OpenWithParm ( w_contact_call_log_entry, l_str_parm )
		if Message.DoubleParm = 1 then
			m_customer_service_center.mf_setup ( TRUE, FALSE, FALSE, FALSE, TRUE )
			CHOOSE CASE i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]]
				CASE "Customer"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE customer = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
				CASE "Destination"
					wf_retrieve_dw_view ( "SELECT * FROM cs_contact_call_log_vw WHERE destination = '" + i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] + "'" + i_str_wheres.contact_call_log_where + " order by start_date desc" )
			END CHOOSE
		end if
	Case "Invoices"
		If dw_1.object.type[row] = 'M' Then
			l_str_Parm.Value1 = "ManualInvoice"
			l_str_Parm.Value2 = String ( dw_1.object.invoice_number[row] )
		Else
			l_str_Parm.Value1 = String( dw_1.object.invoice_number[row] )  
		End if										 
		OpenSheetWithParm ( w_invoice_detail, l_str_Parm, gnv_App.of_GetFrame(), 0, Original! )
End Choose

return 0
end event

event ue_pre_setup;call super::ue_pre_setup;uo_1.st_1.x = 1000
uo_1.of_resize ( )


end event

event tv_dragwithin;treeviewitem			l_tvi_item
long						l_l_order,&
							l_l_row
st_generic_structure	l_str_parm
string					l_s_prevsort,&
							l_s_temp

if handle < 1 then
	if source.DragIcon <> "not.ico" then &
		source.DragIcon = "not.ico"
	return 1
end if

tv_1.GetItem ( handle, l_tvi_item )

l_l_row = i_ds_treeview.Find ( "itemhandle = " + string ( handle ), 1, i_ds_treeview.RowCount ( ) )

if l_l_row > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.itemlabel[l_l_row] then 
		if source.DragIcon <> "not.ico" then &
			source.DragIcon = "not.ico"
		return 1
	end if
else
	if source.DragIcon <> "not.ico" then &
		source.DragIcon = "not.ico"
	return 1
end if

Choose Case dw_1.Tag
	Case "Quotes"
		if i_ds_treeview.object.itemlevel[l_l_row] > 1 then
			IF i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[l_l_row]] = "Customer"  THEN
				IF i_ds_treeview.object.parentlabel[l_l_row] <> i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] THEN 
					if source.DragIcon <> "not.ico" then &
						source.DragIcon = "not.ico"
					return 1
				end if
			ELSE
				IF i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[l_l_row]] <> i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] OR &
					i_ds_treeview.object.parentlabel[l_l_row] <> uo_1.dw_1.GetItemString ( uo_1.dw_1.GetRow ( ), "destination" ) THEN 
					if source.DragIcon <> "not.ico" then &
						source.DragIcon = "not.ico"
					return 1
				end if
			END IF
			if l_tvi_item.Label = "Sales Orders" then
				if source.DragIcon <> "clipbrd.ico" then &
					source.DragIcon = "clipbrd.ico"
			else
				if source.DragIcon <> "not.ico" then &
					source.DragIcon = "not.ico"
			end if
		else
			if source.DragIcon <> "not.ico" then &
				source.DragIcon = "not.ico"
		end if
	Case "Ship History"
		if i_ds_treeview.object.itemlevel[l_l_row] > 2 then
			IF i_ds_treeview.object.itemtype[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] = "Customer" THEN
				if i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_ds_treeview.object.parentrow[l_l_row]]] <> i_ds_treeview.object.parentlabel[i_i_clicked_tvrow] then 
					if source.DragIcon <> "not.ico" then &
						source.DragIcon = "not.ico"
					if i_i_clicked_tvrow > 0 then
						tv_1.SelectItem ( i_i_clicked_tvrow )
					end if
					return 1
				end if
			ELSE
				if i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_ds_treeview.object.parentrow[l_l_row]]] <> i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] then 
					if source.DragIcon <> "not.ico" then &
						source.DragIcon = "not.ico"
					if i_i_clicked_tvrow > 0 then
						tv_1.SelectItem ( i_i_clicked_tvrow )
					end if
					return 1
				end if
			END IF
			if i_ds_treeview.object.itemtype[l_l_row] = "RMA" then
				tv_1.SelectItem ( handle )
				if source.DragIcon <> "recycle.ico" then
					source.DragIcon = "recycle.ico"
				end if
			else
				if i_i_clicked_tvrow > 0 then
					tv_1.SelectItem ( i_i_clicked_tvrow )
				end if
				if source.DragIcon <> "not.ico" then
					source.DragIcon = "not.ico"
				end if
			end if
		else
			if source.DragIcon <> "not.ico" then &
				source.DragIcon = "not.ico"
		end if
	Case "RMAs"
		if i_ds_treeview.object.itemlevel[l_l_row] > 1 then
			IF i_ds_treeview.object.parentlabel[l_l_row] <> i_ds_treeview.object.parentlabel[i_ds_treeview.object.parentrow[i_i_clicked_tvrow]] THEN 
				if i_i_clicked_tvrow > 0 then
					tv_1.SelectItem ( i_i_clicked_tvrow )
				end if
				if source.DragIcon <> "not.ico" then &
					source.DragIcon = "not.ico"
				return 1
			end if
			if i_ds_treeview.object.itemtype[l_l_row] = "Invoices" then
				if source.DragIcon <> "about.ico" then &
					source.DragIcon = "about.ico"
			else
				if i_i_clicked_tvrow > 0 then
					tv_1.SelectItem ( i_i_clicked_tvrow )
				end if
				if source.DragIcon <> "not.ico" then &
					source.DragIcon = "not.ico"
			end if
		else
			if i_i_clicked_tvrow > 0 then
				tv_1.SelectItem ( i_i_clicked_tvrow )
			end if
			if source.DragIcon <> "not.ico" then &
				source.DragIcon = "not.ico"
		end if
	Case else
		if i_i_clicked_tvrow > 0 then
			tv_1.SelectItem ( i_i_clicked_tvrow )
		end if
		if source.DragIcon <> "not.ico" then
			source.DragIcon = "not.ico"
		end if
End Choose


return 0
end event

event tv_dragleave;Choose case source.ClassName ( )
	Case "dw_1"
		if i_i_clicked_tvrow > 0 then
			tv_1.SelectItem ( i_i_clicked_tvrow )
		end if
		if source.DragIcon <> "not.ico" then
			source.DragIcon = "not.ico"
		end if
end choose

return 0
end event

event dw_itemchanged;// Declare local variables
date		l_dt_start,&
		l_dt_end
treeviewitem	l_tvi_item
string		l_s_customer, &
		l_s_Destination
dec		l_n_closure_rate,&
		l_n_ontime_rate,&
		l_n_return_rate
long		l_l_count

// If not a valid itemchanged row then exit
if row < 1 then return 1

// Get current item from dw_1.tag and take appropriate action
Choose Case dw_1.Tag
	Case "Customers"
	Case "Customer"
		tv_1.GetItem ( tv_1.FindItem ( CurrentTreeItem!, 0 ), l_tvi_item )
		l_s_customer = wf_parsedata(l_tvi_item.label)
		dw_1.AcceptText ( )
		if dw_1.Update ( ) = 1 then
			commit;
		else
			rollback;
			MessageBox ( "Customer Service", "Unable to update customer data!", Exclamation! )
			return 1
		end if
		l_dt_start = Date ( dw_1.GetItemDateTime ( 1, "start_date" ) )
		l_dt_end = Date ( dw_1.GetItemDateTime ( 1, "end_date" ) )
		i_ds_treeview.object.startdate[i_i_clicked_tvrow]	= l_dt_start
		i_ds_treeview.object.enddate[i_i_clicked_tvrow] = l_dt_end
		dw_1.retrieve ( l_s_customer) 
	Case "Destination"

		dw_1.settaborder ( "start_date", 0)
		dw_1.settaborder ( "end_date", 0)		
		dw_1.modify ( "start_date.Color = " + String ( f_get_color_value ( "darkgray" ) ) )
		dw_1.modify ( "end_date.Color = " + String ( f_get_color_value ( "darkgray" ) ) )		
		
	Case "Quotes"
	Case "Sales Orders"
	Case "Ship Schedule"
	Case "Ship History"
	Case "Issues"
	Case "RMAs"
	Case "Part Profile"
	Case "Notes"
End Choose

return 0
end event

event dw_retrievestart;if dw_1.dataobject = "d_customer_scorecard" then
	SetPointer ( HourGlass! )
end if

return 0

end event

event dw_retrieveend;if dw_1.dataobject = "d_customer_scorecard" then
	SetPointer ( Arrow! )
end if

return 0

end event

event dw_retrieverow;if dw_1.dataobject = "d_customer_scorecard" then
	SetPointer ( HourGlass! )
end if

return 0

end event

