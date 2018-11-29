$PBExportHeader$w_smart_job_completion_version2.srw
$PBExportComments$check about kanban column in label library and then check in..
forward
global type w_smart_job_completion_version2 from window
end type
type st_message from statictext within w_smart_job_completion_version2
end type
type cb_message from commandbutton within w_smart_job_completion_version2
end type
type cbx_visual_pallet from checkbox within w_smart_job_completion_version2
end type
type em_date from statictext within w_smart_job_completion_version2
end type
type st_6 from statictext within w_smart_job_completion_version2
end type
type st_timer from statictext within w_smart_job_completion_version2
end type
type st_check from statictext within w_smart_job_completion_version2
end type
type sle_percentage from singlelineedit within w_smart_job_completion_version2
end type
type st_1 from statictext within w_smart_job_completion_version2
end type
type st_part_info from statictext within w_smart_job_completion_version2
end type
type st_8 from statictext within w_smart_job_completion_version2
end type
type st_7 from statictext within w_smart_job_completion_version2
end type
type p_4 from picture within w_smart_job_completion_version2
end type
type cbx_1 from checkbox within w_smart_job_completion_version2
end type
type lb_um from listbox within w_smart_job_completion_version2
end type
type st_suffix from statictext within w_smart_job_completion_version2
end type
type cbx_stage from checkbox within w_smart_job_completion_version2
end type
type sle_operation from statictext within w_smart_job_completion_version2
end type
type st_done from statictext within w_smart_job_completion_version2
end type
type st_percentage_value from statictext within w_smart_job_completion_version2
end type
type st_percentage from statictext within w_smart_job_completion_version2
end type
type cb_show_cancel from commandbutton within w_smart_job_completion_version2
end type
type cb_show_save from commandbutton within w_smart_job_completion_version2
end type
type sle_show_pallet from singlelineedit within w_smart_job_completion_version2
end type
type st_show_pallet from statictext within w_smart_job_completion_version2
end type
type sle_show_object from singlelineedit within w_smart_job_completion_version2
end type
type st_show_object from statictext within w_smart_job_completion_version2
end type
type cb_show from commandbutton within w_smart_job_completion_version2
end type
type ddlb_units from dropdownlistbox within w_smart_job_completion_version2
end type
type dw_temp from datawindow within w_smart_job_completion_version2
end type
type ddlb_machine from dropdownlistbox within w_smart_job_completion_version2
end type
type p_drag from picture within w_smart_job_completion_version2
end type
type p_trash from picture within w_smart_job_completion_version2
end type
type st_pallet from statictext within w_smart_job_completion_version2
end type
type st_serial41 from statictext within w_smart_job_completion_version2
end type
type st_serial42 from statictext within w_smart_job_completion_version2
end type
type st_serial43 from statictext within w_smart_job_completion_version2
end type
type st_serial44 from statictext within w_smart_job_completion_version2
end type
type st_serial45 from statictext within w_smart_job_completion_version2
end type
type st_serial46 from statictext within w_smart_job_completion_version2
end type
type st_serial47 from statictext within w_smart_job_completion_version2
end type
type st_serial48 from statictext within w_smart_job_completion_version2
end type
type p_mode from picture within w_smart_job_completion_version2
end type
type st_4 from statictext within w_smart_job_completion_version2
end type
type dw_object_info from datawindow within w_smart_job_completion_version2
end type
type dw_requirement from datawindow within w_smart_job_completion_version2
end type
type sle_base from singlelineedit within w_smart_job_completion_version2
end type
type st_5 from statictext within w_smart_job_completion_version2
end type
type dw_part from datawindow within w_smart_job_completion_version2
end type
type uo_boxes_on_pallet from u_boxes_on_pallet within w_smart_job_completion_version2
end type
type dw_objects from datawindow within w_smart_job_completion_version2
end type
type p_1 from picture within w_smart_job_completion_version2
end type
type st_2 from statictext within w_smart_job_completion_version2
end type
type p_2 from picture within w_smart_job_completion_version2
end type
type st_3 from statictext within w_smart_job_completion_version2
end type
type st_10 from statictext within w_smart_job_completion_version2
end type
type gb_4 from groupbox within w_smart_job_completion_version2
end type
type gb_3 from groupbox within w_smart_job_completion_version2
end type
type gb_5 from groupbox within w_smart_job_completion_version2
end type
type gb_2 from groupbox within w_smart_job_completion_version2
end type
type gb_1 from groupbox within w_smart_job_completion_version2
end type
type uo_visual_pallet from u_pallet_contents within w_smart_job_completion_version2
end type
end forward

global type w_smart_job_completion_version2 from window
integer width = 5673
integer height = 2256
boolean titlebar = true
string title = "Packing Line (Version 2.0)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 78682240
event check_pallet pbm_custom01
event change_date pbm_custom02
event clear_screen pbm_custom03
event exit_screen pbm_custom04
event print_pallet_label pbm_custom05
event new_pallet pbm_custom06
event sort_demand pbm_custom07
event job_completion pbm_custom08
event ue_open ( )
st_message st_message
cb_message cb_message
cbx_visual_pallet cbx_visual_pallet
em_date em_date
st_6 st_6
st_timer st_timer
st_check st_check
sle_percentage sle_percentage
st_1 st_1
st_part_info st_part_info
st_8 st_8
st_7 st_7
p_4 p_4
cbx_1 cbx_1
lb_um lb_um
st_suffix st_suffix
cbx_stage cbx_stage
sle_operation sle_operation
st_done st_done
st_percentage_value st_percentage_value
st_percentage st_percentage
cb_show_cancel cb_show_cancel
cb_show_save cb_show_save
sle_show_pallet sle_show_pallet
st_show_pallet st_show_pallet
sle_show_object sle_show_object
st_show_object st_show_object
cb_show cb_show
ddlb_units ddlb_units
dw_temp dw_temp
ddlb_machine ddlb_machine
p_drag p_drag
p_trash p_trash
st_pallet st_pallet
st_serial41 st_serial41
st_serial42 st_serial42
st_serial43 st_serial43
st_serial44 st_serial44
st_serial45 st_serial45
st_serial46 st_serial46
st_serial47 st_serial47
st_serial48 st_serial48
p_mode p_mode
st_4 st_4
dw_object_info dw_object_info
dw_requirement dw_requirement
sle_base sle_base
st_5 st_5
dw_part dw_part
uo_boxes_on_pallet uo_boxes_on_pallet
dw_objects dw_objects
p_1 p_1
st_2 st_2
p_2 p_2
st_3 st_3
st_10 st_10
gb_4 gb_4
gb_3 gb_3
gb_5 gb_5
gb_2 gb_2
gb_1 gb_1
uo_visual_pallet uo_visual_pallet
end type
global w_smart_job_completion_version2 w_smart_job_completion_version2

type variables
Boolean bWaitPallet                //Waiting for pallet #
Boolean bWaitObject               //Waiting for object
Boolean bPallet = FALSE         //Job comp for pallet
Boolean bDragPallet                //Drag pallet
Boolean bDragBox                   //Drag box          
Boolean bFirstTime = TRUE      //First time
Boolean bHardQueue = FALSE  //Selected hard queue
Boolean bSoftQueue  = FALSE  //Selected soft queue
Boolean bShipping     = FALSE  //Selected shipping dock
Boolean bCompleted   = FALSE //Whether job is done
Boolean bFilter           = TRUE  //Whether the filter is on
Boolean bUseImage    = FALSE //Whether to use image
Boolean bValidPassword =  FALSE
Boolean ib_Refresh = FALSE
Boolean b_ChangeDate = FALSE
Boolean 	ib_Auto, &
	ib_Timer,&
	i_b_job_done
Long      iPalletSerial                //Pallet serial number
Long      iDemandRow              //Row# in demand window
Long      iSerialDragged            //Serial number dragged
Long      iNoDragged                //No of object dragged
Long      iTotalObjects              //Total Objects to generate
Long      iObjectRow                 //Current row in dw_obj
Long      iShipper                      //Shipper number
Long      iSuffix		    //Suffix
Long      iDemandCol	    //Col # in demand window
Long      iSalesOrder                 //Sales order#
long	i_l_clicked_row
Picture   Box[48]                      //Box picture
StaticText Serial[48]                 //Serial picture

String     szQueue                     //Schedule queue
String     szPart                         //Part number
String     szCustomerPart            //Customer part number
String     szDestination               //Destination
String     szShipperPart               //Part number in shipper
String     szDockCode                //Dock code
String     szLineFeedCode           //Line feed code
String     szShippingUM	     //UM in shipper detail
String     szCustomerPO	     //Customer PO
String     szZoneCode	     //Zone Code
String	szOperator
String	szOperatorPassword
String	is_DragMode
String	is_ParentPart
Decimal  nTotalQty                    //Total quantity
Decimal  nQtyCompleted             //Qty completed
Decimal  nQtyPacked                 //Qty packed
Decimal  nPackageTare	     //Tare wgt for package
Decimal  nStdCost		     //Standard unit cost

DataWindowChild dw_PackageChild
DataWindowChild dwUM
DataWindowChild 	idwc_Part, &
		idwc_Label, &
		idwc_Packaging
Window wLabel

st_generic_structure stParm

Date       dDate

Int	iCount, &
	ii_Sequence


Datastore		dw_shipper_parts,&
		dw_pallet_parts,&
		dw_packaging,&
		dw_units

end variables

forward prototypes
public function boolean wf_pallet_exists (long iserial)
public subroutine wf_set_part_info ()
public subroutine wf_show_visual_pallet (boolean bflag)
public subroutine wf_add_box_to_visual_pallet (long iSerial)
public subroutine wf_create_machine_dropdown ()
public function decimal wf_get_std_pack (string szpackage)
public subroutine wf_show_object_info (boolean bflag)
public function decimal wf_get_qty_packed (string szshipper, string szpart)
public subroutine wf_recalc_demand ()
public subroutine wf_reset_screen ()
public function decimal wf_package_tare (string szpackage)
public function boolean wf_auto_stage ()
public subroutine wf_get_parts ()
public function boolean wf_validate_pallet_against_shipper (long al_pallet, long al_newshipper)
public subroutine wf_attach_pallet_to_shipper (long ai_palletserial)
public subroutine wf_debug (string as_Message)
public function long wf_get_next_pallet_number ()
public subroutine wf_display_pallet (long al_palletnumber)
public subroutine wf_update_kanban (string as_kanban)
public subroutine wf_create_pallet (long ai_palletserial, string a_s_package_type)
public subroutine wf_draw_percentage (decimal a_n_qtycompleted)
public subroutine wf_send_object_to_pallet (long aipalletserial, long aiobjectserial)
public function string wf_get_schedule_queue (string a_s_machine)
public subroutine wf_create_package_dropdown (string a_s_part)
public subroutine wf_create_units_dropdown (string a_s_part)
public function string wf_get_supplier_code (string a_s_destination)
public function boolean wf_valid_part (string a_s_part)
public function string wf_get_um (string a_s_part)
public function boolean wf_valid_pallet (long a_l_serial)
public function string wf_get_std_label (string a_s_part)
public function boolean wf_update_demand (long a_l_shipper, string a_s_part, decimal a_n_qty)
public function string wf_strip_off_suffix (string a_s_part, long a_l_suffix)
public function string wf_get_note (long a_l_order, string a_s_part, long a_l_suffix)
public function string wf_get_kanban_number (integer a_l_shipper)
public function string wf_get_label_window (string a_s_label)
public function integer wf_print_pallet_label (long iserial)
public subroutine wf_create_object (long iserial, string as_operator)
public function decimal wf_get_inv_std_pack (string as_part)
public function integer wf_validate_part ()
end prototypes

on check_pallet;wf_show_object_info(TRUE)

sle_show_object.Enabled	= TRUE
sle_show_pallet.Enabled	= FALSE
cb_show_save.Enabled		= FALSE

this.SetMicroHelp("Ready")
end on

event change_date;If Not bShipping then
	MessageBox(monsys.msg_title, "This function is only for shipping demand!", StopSign!)
Else
	bFinish	= FALSE
	b_ChangeDate = TRUE
	Timer(0.5)
	OpenWithParm(w_view_calendar, String(dDate))
End If

this.SetMicroHelp("Ready")
end event

event clear_screen;int		l_i_return_code,&
			l_i_count,&
			l_i_pos, l_i_prev_pos = 1
string	l_s_origin,&
			l_s_return
long		l_l_pallets[]

if i_b_job_done then
	i_b_job_done = FALSE
	l_i_return_code = 1

	l_s_origin = String ( iShipper )

	SELECT 	count(*)
	INTO		:l_i_count
	FROM		object
	WHERE		( shipper = :iShipper OR
				origin = :l_s_origin ) AND
				type = 'S' ;

	if l_i_count > 0 then
		if MessageBox(monsys.msg_title, "This job is done, would you like to print pallet labels?", Question!, YesNo!, 1 ) = 1 then
			OpenWithParm ( w_job_done_print_pallets, iShipper )
			l_s_return = Message.StringParm
			if l_s_return > '' then
				l_i_pos = PosA ( l_s_return, "~t", l_i_pos + 1 )
				Do While ( l_i_pos > 0 )
					l_l_pallets[UpperBound ( l_l_pallets ) + 1] = Long ( MidA ( l_s_return, l_i_prev_pos, l_i_pos - l_i_prev_pos ) )
					l_i_prev_pos = l_i_pos
					l_i_pos = PosA ( l_s_return, "~t", l_i_pos + 1 )
					if l_i_pos >= LenA ( l_s_return ) then l_i_pos = 0
				Loop 
				if UpperBound ( l_l_pallets ) > 0 then
					For l_i_count = 1 to UpperBound ( l_l_pallets )
						wf_print_pallet_label ( l_l_pallets[l_i_count] )
					Next
					MessageBox(monsys.msg_title, "Pallet Label(s) has(have) been printed")
				end if
			end if
		end if
	else
		MessageBox(monsys.msg_title, "This job is done, you must select another one", Information!)
	end if
else
	l_i_return_code = MessageBox(monsys.msg_title, "This will reset the part information screen.  Are you sure you want to do this?", Question!, YesNo!) 
end if

if l_i_return_code = 1 then
	SetNull(iSuffix)
	wf_reset_screen()
	st_part_info.text	= "Packing for Inventory"
End If

this.SetMicroHelp("Ready")
end event

event exit_screen;If bPallet then
	If MessageBox(monsys.msg_title, "Do you want to print a pallet label for ?" + String(iPalletSerial), Question!, YesNo!) = 1 then
//		OpenWithParm(w_LexmaPallet59, iPalletSerial)
		MessageBox(monsys.msg_title, "Pallet Label " + String(iPalletSerial) + &
					" has been printed")
	End If		
End If

If MessageBox(monsys.msg_title, "Are you sure to exit", Question!, YesNo!) = 1 then
	close(This)
End If
end event

event print_pallet_label;If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First", StopSign!)
	Return
End If

If iObjectRow > 0 then
	if dw_objects.IsSelected ( iObjectRow ) then
		If dw_objects.GetItemString(iObjectRow, "type") = "S" then //Pallet 
			if wf_print_pallet_label(iSerialDragged) <> -1 then
				MessageBox(monsys.msg_title, "Pallet Label " + String(iSerialDragged) + " has been printed")
			end if
			return
		Else
			Messagebox(monsys.msg_title, "This is not a pallet", Stopsign!)
			return
		End If
	end if
End If

OpenWithParm ( w_print_pallet_label, iShipper )

this.SetMicroHelp("Ready")
end event

event new_pallet;string	l_s_package_type

If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First", StopSign!)
	Return
End If

SELECT 	parameters.pallet_package_type  
INTO 		:l_s_package_type  
FROM 		parameters  ;

if l_s_package_type = 'Y' then
	Open ( w_pallet_package_type )
	l_s_package_type = Message.StringParm
	choose case l_s_package_type 
		case '-1'
			return
		case '0'	
			l_s_package_type = ""
	end choose
//	if l_s_package_type = "-1" or l_s_package_type = "0" then l_s_package_type = ""
end if

if f_get_string_value(dw_part.GetItemString(1, "operator_code")) = '' then
	Messagebox ( monsys.msg_title, "Invalid operator code")
	Return 
end if 	

//OpenWithParm ( w_get_parm_value, "next_serial" ) 
//iPalletSerial = Message.DoubleParm

If SQLCA.of_getnextparmvalue ( 'next_serial',iPalletSerial ) then       // old code iPalletSerial > 0 then
	bPallet	= TRUE
	dw_part.SetItem ( 1, "field1", String(iPalletSerial) )
	wf_create_pallet(iPalletSerial, l_s_package_type)
	uo_boxes_on_pallet.uf_setup ( True, iPalletSerial )
	uo_boxes_on_pallet.Show ( )
	uo_boxes_on_pallet.BringToTop = TRUE
else
	rollback;
End if

this.SetMicroHelp("Ready")
end event

event sort_demand;Long		ll_Row, &
			ll_Suffix, &
			ll_Order, &
			ll_WorkOrder, &
			ll_Shipper
String	ls_Part, &
			ls_ParentPart

If IsNull(iDemandCol) or iDemandCol = 0 then
	MessageBox(monsys.msg_title, "Please click the column you want to sort.", StopSign!)
Else
	If iDemandRow > 0 And dw_requirement.IsSelected ( iDemandRow ) Then
		Choose Case szQueue
			Case "D"
				ls_Part = dw_requirement.GetItemString ( iDemandRow, "shipper_detail_part" )
				ll_Shipper = dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_shipper" )
				dw_requirement.SetSort(String(iDemandCol) + "a")
				dw_requirement.Sort()
				ll_Row = dw_requirement.Find ( "shipper_detail_shipper = " + &
					String ( ll_Shipper ) + " and shipper_detail_part = '" + &
					ls_Part +	"'", 1, dw_requirement.RowCount ( ) )
			Case "O"
				ll_Order = dw_requirement.GetItemNumber ( iDemandRow, "order_no" )
				ll_Suffix = dw_requirement.GetItemNumber ( iDemandRow, "suffix" )
				ls_Part = dw_requirement.GetItemString ( iDemandRow, "part_number" )
				dw_requirement.SetSort(String(iDemandCol) + "a")
				dw_requirement.Sort()
				If ll_Suffix > 0 Then
					ll_Row = dw_requirement.Find ( "order_no = " + &
						String ( ll_Order ) + " and part_number = '" + &
						ls_Part +	"' and mod_suffix = " + String ( ll_Suffix ),&
						1, dw_requirement.RowCount ( ) )
				Else
					ll_Row = dw_requirement.Find ( "order_no = " + &
						String ( ll_Order ) + " and part_number = '" + &
						ls_Part +	"' and mod_suffix = 0" ,&
						1, dw_requirement.RowCount ( ) )
				End if
			Case "F"
				ll_Order 		= dw_requirement.GetItemNumber ( iDemandRow, "order_no" )
				ll_Suffix 		= dw_requirement.GetItemNumber ( iDemandRow, "suffix" )
				ls_ParentPart 	= dw_requirement.GetItemString ( iDemandRow, "part_number" )
				ls_Part 			= dw_requirement.GetItemString ( iDemandRow, "activity_router_part_number" )
				dw_requirement.SetSort(String(iDemandCol) + "a")
				dw_requirement.Sort()
				If ll_Suffix > 0 Then
					ll_Row = dw_requirement.Find ( "order_no = " + &
						String ( ll_Order ) + " and part_number = '" + &
						ls_ParentPart + "' and mod_suffix = " + String ( ll_Suffix ) + &
						" and activity_router_part_number = '" + ls_Part + "'",&
						1, dw_requirement.RowCount ( ) )
				Else
					ll_Row = dw_requirement.Find ( "order_no = " + &
						String ( ll_Order ) + " and part_number = '" + &
						ls_ParentPart + "' and mod_suffix = 0" + &
						" and activity_router_part_number = '" + ls_Part + "'",&
						1, dw_requirement.RowCount ( ) )
				End if
			Case "H"
				ll_WorkOrder = dw_requirement.GetItemNumber ( iDemandRow, "workorder" )
				ls_Part = dw_requirement.GetItemString ( iDemandRow, "part" )
				dw_requirement.SetSort(String(iDemandCol) + "a")
				dw_requirement.Sort()
				ll_Row = dw_requirement.Find ( "workorder = '" + &
					String ( ll_WorkOrder ) + "' and part = '" + &
					ls_Part +	"'", 1, dw_requirement.RowCount ( ) )
		End Choose
		If ll_Row > 0 Then
			dw_requirement.SelectRow ( 0, False )
			dw_requirement.ScrollToRow ( ll_Row )
			dw_requirement.SelectRow ( ll_Row, True )
			iDemandRow = ll_Row
		End if
	Else
		dw_requirement.SetSort(String(iDemandCol) + "a")
		dw_requirement.Sort()
	End if
End If
	
this.SetMicroHelp("Ready")
end event

event job_completion;Str_progress l_s_Parm

Long l_i_Count
Long l_i_TotalBoxes
Long ll_Serial
int  li_Count

String 	l_s_Operator,&
			ls_allow_zero_qty
string	ls_part 
string	ls_unit
string	ls_shipunit		

decimal	ldec_requiredqty
decimal	ldec_totalqty
decimal	ldec_packedqty

Timer ( 0, This )

If bFirstTime then
	MessageBox(monsys.msg_title, "Please select machine first.", StopSign!)
	Timer ( 1, This )
	Return
End If

dw_part.AcceptText ( )

If IsNull(szPart) or (Trim(szPart) <= " ") or wf_validate_part () = 0  then
	MessageBox(monsys.msg_title, "Invalid part number.", StopSign!)
	Timer ( 1, This )
	Return
End If

If bShipping or bHardQueue or bSoftQueue then
	If iDemandRow = 0 or IsNull(iDemandRow) then
		MessageBox(monsys.msg_title, "You must select a row from the demand data window for job completion.", StopSign!)
		Timer ( 1, This )
		Return
	End If
End If

l_s_Operator		= dw_part.Getitemstring(1,"operator_code")
If IsNull(l_s_Operator) or l_s_operator='' then
	MessageBox(monsys.msg_title, "'Enter a Valid Operator Code!'", Exclamation!)
	Timer ( 1, This )
	Return
End If

SELECT jc_allow_zero_qty
  INTO :ls_allow_zero_qty
  FROM inventory_parameters ;

dw_part.SetRow(1)
If ls_allow_zero_qty = 'N' And f_get_value ( dw_part.GetItemNumber ( 1, "quantity" ) ) <= 0  then
	MessageBox(monsys.msg_title, "You must enter Quantity First!", StopSign!)
	Timer ( 1, This )
	Return
End If

If IsNull(dw_part.GetItemNumber(1, "batchboxes")) then
	MessageBox(monsys.msg_title, "You must enter Total # of Objects First!", StopSign!)
	Timer ( 1, This )
	Return
End If
	

If f_get_string_value ( dw_part.GetItemString ( 1, "label" ) ) <= " " then
	MessageBox(monsys.msg_title, "You must specify label format!", StopSign!)
	Timer ( 1, This )
	Return
End If
	
If f_get_string_value(dw_part.GetItemString(1, "part")) > " " then

	dw_part.SetRow(1)

	l_i_TotalBoxes	= dw_part.GetItemNumber ( 1, "batchboxes" )

	if szqueue = 'D' then
		if iDemandRow > 0 and dw_requirement.GetItemString ( iDemandRow, "allow_overstage" ) = 'N' then
			ls_part = dw_requirement.GetItemString ( iDemandRow, "shipper_detail_part_original" )
			ls_shipunit = dw_requirement.GetItemString ( iDemandRow, "shipper_detail_alternative_unit" )
			ls_unit = dw_part.GetItemString ( 1, "um" )
			ldec_totalqty = IsNull ( f_convert_units ( ls_unit, ls_shipunit, ls_part, l_i_totalboxes * dw_part.GetItemDecimal ( 1, "quantity" ) ), 0 )
			ldec_packedqty = IsNull ( dw_requirement.GetItemDecimal ( iDemandRow, "qty_packed" ), 0 )
			ldec_requiredqty = IsNull ( dw_requirement.GetItemDecimal ( iDemandRow, "shipper_detail_qty_required" ), 0 )
			if ldec_totalqty + ldec_packedqty > ldec_requiredqty then
				MessageBox ( monsys.msg_title, "Overstaging is not allowed for this destination!", StopSign! )
				this.SetMicroHelp("Ready")
				Timer ( 1, This )
				return
			end if
		end if
	end if
	
	nPackageTare	= wf_package_tare(dw_part.GetItemString ( 1, "packagetype" ))
	nStdCost			= f_get_value(Dec(f_get_part_info(szPart, "STANDARD COST")))

	l_s_Parm.Title		= "Generating Object"
	OpenWithParm(w_progress, l_s_Parm)
	w_progress.cb_cancel.visible	= FALSE

	For l_i_Count = 1 to l_i_TotalBoxes

		m_packline.m_operation.m_jobcompletion.Enabled	= FALSE		//cb_job_comp.Enabled	= FALSE

//		OpenWithParm ( w_get_parm_value, "next_serial" ) 
//		ll_Serial = Message.DoubleParm

		If SQLCA.of_getnextparmvalue ( 'next_serial',ll_Serial ) then  // old code ll_Serial > 0 then

			w_progress.wf_progress(l_i_Count / l_i_TotalBoxes, "Generating object " + String(ll_Serial))
	
			wf_create_object(ll_Serial,l_s_operator)

			If st_done.visible then		//If reachs 100%, stops the operation
				l_i_Count	= l_i_TotalBoxes + 1
			End If
		Else
			l_i_Count					= l_i_TotalBoxes + 1
			m_packline.m_operation.m_jobcompletion.Enabled		= TRUE
			MessageBox(monsys.msg_title, "System can not generate correct serial number, please try the operation again", StopSign!)
			rollback;
		End If
	Next 

	Close(w_progress)

Else
	MessageBox(monsys.msg_title, "Please select part first", StopSign!)
End if	

this.SetMicroHelp("Ready")
Timer ( 1, This )

end event

event ue_open;dw_shipper_parts = CREATE DataStore
dw_shipper_parts.DataObject = "d_shipper_detail_part_list"
dw_pallet_parts = CREATE DataStore
dw_pallet_parts.DataObject = "d_pallet_part_list"
dw_packaging = CREATE DataStore
dw_packaging.DataObject = "dw_list_of_packaging_per_part_size8_grey"
dw_units = CREATE DataStore
dw_units.DataObject = "dw_list_of_units_per_part"
dw_units.SetTransObject(sqlca)

wf_get_parts ( )
Timer ( 1, This )
end event

public function boolean wf_pallet_exists (long iserial);String l_s_type				//Object type
String l_s_part				//Part Number
String l_s_PalletTare		//Pallet tare weight

Long	 l_s_Row					//Current Row Number

SELECT object.type,   
       object.part,
		 object.custom1
  INTO :l_s_type,   
       :l_s_part,
		 :l_s_PalletTare
  FROM object  
 WHERE object.serial = :iSerial   ;

If IsNull(l_s_part) then
	MessageBox(monsys.msg_title, "Serial number not found", StopSign!)
	Return FALSE
Else
	If l_s_type = "S" then
		bPallet			= TRUE
		iPalletSerial	= iSerial
		l_s_Row				= dw_objects.Find("serial = " + String(iSerial), 1, 999999)		

		If l_s_Row = 0 then
			dw_objects.InsertRow(1)
			dw_objects.SetItem(1, "serial", iPalletSerial)
			dw_objects.SetItem(1, "part", "Pallet")
			dw_objects.SetItem(1, "type", "S")

		Else
			dw_objects.SelectRow(0, FALSE)
			dw_objects.SelectRow(l_s_Row, TRUE)				
		End If

		dw_part.SetItem ( 1, "field2", l_s_PalletTare )
		uo_boxes_on_pallet.uf_setup ( TRUE, iPalletSerial )
		uo_boxes_on_pallet.Show ( )
		p_mode.PictureName	= "pallet.bmp"
		dw_part.SetItem(1, "field1", String(iPalletSerial))
		wf_show_visual_pallet(TRUE)
		Return TRUE
	Else
		MessageBox (monsys.msg_title, "This is a box not a pallet", StopSign!)
		Return FALSE
	End If
End If


end function

public subroutine wf_set_part_info ();Long 		iOrder
String 	szLabel, &
			ls_PackageType, &
			ls_Unit
Dec		ld_StdPack, &
			ld_Qty

dw_part.Reset()

dw_part.InsertRow(1)

If szQueue = "D" Then
	szPart							=	dw_requirement.GetItemString(iDemandRow, "shipper_detail_part")
	szCustomerPart					=	dw_requirement.GetItemString(iDemandRow, "order_header_customer_part")
	szDestination					=	dw_requirement.GetItemString(iDemandRow, "destination_destination")
	nTotalQty						=  dw_requirement.GetItemNumber(iDemandRow, "shipper_detail_qty_required")
	iSuffix							=	dw_requirement.GetItemNumber(iDemandRow, "shipper_detail_suffix")
	iOrder							=	dw_requirement.GetItemNumber(iDemandRow, "order_header_order_no")
	ld_StdPack						=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")
	ls_PackageType					=  dw_requirement.GetItemString(iDemandRow, "package_type")	
	ls_Unit							=  dw_requirement.GetItemString(iDemandRow, "shipper_detail_alternative_unit")
	ld_Qty							=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")

//	szLabel	= f_get_string_value ( dw_requirement.GetItemString(iDemandRow, "order_detail_box_label") )
	szLabel	= f_get_string_value ( dw_requirement.GetItemString(iDemandRow, "order_detail_box_label") )
	If f_get_string_value(szLabel) = '' then
		szLabel	= wf_get_std_label(szPart)
	End If

	If iSuffix > 0 then
		szPart				= wf_strip_off_suffix(szPart, iSuffix)	
		st_suffix.text		= "Suffix:" + String(iSuffix) + " / Note:" + wf_get_note(iOrder, szPart, iSuffix)
		st_suffix.visible	= TRUE
	Else
		st_suffix.visible	= FALSE
	End If
Elseif szQueue = "H" Then
	szPart							=	dw_requirement.GetItemString(iDemandRow, "part")
	szCustomerPart					=	dw_requirement.GetItemString(iDemandRow, "work_order_customer_part")
	nTotalQty						=  dw_requirement.GetItemNumber(iDemandRow, "qty_required")
	ld_StdPack						=  dw_requirement.GetItemNumber(iDemandRow, "work_order_standard_pack")
	ld_Qty							=  dw_requirement.GetItemNumber(iDemandRow, "work_order_standard_pack")
	szLabel							= 	wf_get_std_label(szPart)
Elseif szQueue = "O" Then
	szPart							=	dw_requirement.GetItemString(iDemandRow, "part_number")
	szCustomerPart					=	dw_requirement.GetItemString(iDemandRow, "order_detail_customer_part")
	nTotalQty						=  dw_requirement.GetItemNumber(iDemandRow, "quantity")
	ld_StdPack						=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")
	ld_Qty							=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")
	ls_Unit							=  dw_requirement.GetItemString(iDemandRow, "order_detail_unit")
//	szLabel	= f_get_string_value ( dw_requirement.GetItemString(iDemandRow, "order_header_box_label") )
	szLabel	= f_get_string_value ( dw_requirement.GetItemString(iDemandRow, "order_detail_box_label") )	
	If f_get_string_value(szLabel) = '' then
		szLabel	= wf_get_std_label(szPart)
	End If
Elseif szQueue = "F" Then
	szPart							=	dw_requirement.GetItemString(iDemandRow, "activity_router_part_number")
	szCustomerPart					=	dw_requirement.GetItemString(iDemandRow, "order_detail_customer_part")
	nTotalQty						=  dw_requirement.GetItemNumber(iDemandRow, "quantity")
	ld_StdPack						=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")
	ld_Qty							=  dw_requirement.GetItemNumber(iDemandRow, "order_header_standard_pack")
	ls_Unit							=  dw_requirement.GetItemString(iDemandRow, "order_detail_unit")
	szLabel							= 	wf_get_std_label(szPart)
End if

nQtyCompleted					= 0
st_percentage.visible		= FALSE
st_percentage.width			= 20
st_percentage_value.text	= "0 %"
st_done.visible				= FALSE

dw_part.SetItem(1, "Part", szPart)
dw_part.SetItem(1, "StandardPack", ld_StdPack )
dw_part.SetItem(1, "Label", szLabel)
dw_part.SetItem(1, "PackageType", ls_PackageType )
dw_part.SetItem(1, "Description", f_get_part_info(szPart, "NAME") )
dw_part.SetItem(1, "um", ls_Unit )
dw_part.SetItem(1, "Quantity", ld_Qty )

dw_part.SetItem(1, "BatchBoxes", 1)
dw_part.SetItem(1, "part", szPart)
dw_part.SetItem(1, "label", szLabel)

wf_create_package_dropdown(szPart)
wf_create_units_dropdown(szPart)


end subroutine

public subroutine wf_show_visual_pallet (boolean bflag);IF Not cbx_visual_pallet.Checked THEN &
	bFlag = FALSE

If bFlag then
	//cbx_visual_pallet.Enabled = FALSE
	//dw_boxes_on_pallet.Retrieve(iPalletSerial)
	uo_visual_pallet.Show ( )
	uo_visual_pallet.Visible = TRUE
	//uo_visual_pallet.BringToTop = TRUE
	uo_visual_pallet.uf_setup ( iPalletSerial )
	st_pallet.text	= String(iPalletSerial)
	//wf_draw_boxes_on_pallet()			
Else
	//cbx_visual_pallet.Enabled = TRUE
	uo_visual_pallet.Hide ( )
	//wf_reset_pictures()
End If


end subroutine

public subroutine wf_add_box_to_visual_pallet (long iSerial);
end subroutine

public subroutine wf_create_machine_dropdown ();String szmachine

ddlb_machine.Reset()

Declare machine_cursor Cursor for Select Machine From Machine_Policy Where IsNull ( schedule_queue, '' ) <> 'H';

Open machine_cursor;

Fetch machine_cursor into :szmachine;

Do while sqlca.sqlcode = 0
	ddlb_machine.AddItem(szmachine)
	Fetch machine_cursor into :szmachine;
Loop

Close machine_cursor;




end subroutine

public function decimal wf_get_std_pack (string szpackage);Decimal nQty

  SELECT part_packaging.quantity  
    INTO :nQty  
    FROM part_packaging  
   WHERE ( part_packaging.part = :szPart ) AND  
         ( part_packaging.code = :szPackage )   ;


Return nQty
end function

public subroutine wf_show_object_info (boolean bflag);cb_show.visible			= bFlag
cb_show_save.visible		= bFlag
cb_show_cancel.visible	= bFlag
sle_show_object.visible	= bFlag
sle_show_pallet.visible	= bFlag
st_show_object.visible	= bFlag
st_show_pallet.visible	= bFlag

If Not bFlag then
	sle_show_object.Enabled	= FALSE
	sle_show_pallet.Enabled	= TRUE
	cb_show_save.Enabled		= TRUE
	sle_show_object.text		= ""
	sle_show_pallet.text		= ""
End If


end subroutine

public function decimal wf_get_qty_packed (string szshipper, string szpart);Decimal nOriginQty
Decimal nOrphanQty				//Boxes staged on other shippers
Decimal nQtyOnPallet				//Boxes on palletes staged on other shippers
Decimal nQtyReturned

Choose Case szQueue
	Case 'D'
		If iSuffix > 0 then
			Select Sum(std_quantity) Into :nOriginQty
			From	 object
			Where	 (part = :szPart) AND ( origin = :szShipper)  AND (Suffix = :iSuffix);
		Else
			Select SUM(std_quantity) INTO :nOriginQty
			From	 object
			Where	 (part = :szPart) AND ( origin = :szShipper) AND (suffix is NULL ) ;
		End If
		
		//SELECT sum(object_b.std_quantity )  INTO :nQtyOnPallet
		//  FROM object object_a,   
		//       object object_b  
		// WHERE ( object_a.serial = object_b.parent_serial ) and  
		//       ( object_a.shipper > ' ') AND
		//		 ( object_a.shipper <> :iShipper ) AND  
		//       ( object_b.part = :szPart ) AND
		//		 ( object_b.origin = :szShipper) ;    
		
		If iSuffix > 0 then
			Select SUM(std_quantity) INTO :nOrphanQty
			From   Object
			Where	(part = :szPart) AND (shipper > ' ') AND (shipper <> :szShipper) AND
					(origin = : szShipper) AND (suffix = :iSuffix);
		Else
			Select Sum(std_quantity) INTO :nOrphanQty
			From   Object
			Where	(part = :szPart) AND (shipper > ' ') AND (shipper <> :szShipper) AND
					(origin = : szShipper) AND (suffix is NULL ) ;
		End If
		
		nOriginQty		= f_convert_units("", szShippingUM, szPart, nOriginQty)
		nOrphanQty		= f_convert_units("", szShippingUM, szPart, nOrphanQty)
		
		nQtyReturned 	= f_get_value(nOriginQty) - f_get_value(nOrphanQty) 
		
		If nQtyReturned > f_get_value(nQtyPacked) then
			Return f_get_value(nQtyReturned)
		Else
			Return f_get_value(nQtyPacked)
		End If 
	Case 'H'
  		SELECT 	sum(std_quantity)  
    	INTO 		:nQtyReturned
    	FROM 		object
   	WHERE 	object.origin = :szShipper and
					object.part = :szPart   ;
		Return f_get_value ( nQtyReturned )
	Case 'O'
  		SELECT 	sum(std_quantity)  
    	INTO 		:nQtyReturned
    	FROM 		object
   	WHERE 	object.origin = :szShipper and
					object.origin = :szPart  ;
		Return f_get_value ( nQtyReturned )
End Choose

end function

public subroutine wf_recalc_demand ();Str_progress l_s_Parm

Long 		l_i_Row
Long		l_i_Shipper

Decimal	l_n_QtyCompleted

String	l_s_ShipperPart

l_s_Parm.Title	= "Recalc shipping demands"
OpenWithParm(w_progress, l_s_Parm)
w_progress.cb_cancel.visible	= FALSE

For l_i_Row = 1 to dw_requirement.RowCount() 
		l_i_Shipper			= dw_requirement.GetItemNumber(l_i_Row, "shipper_detail_shipper")
		szPart			= dw_requirement.GetItemString(l_i_Row, "shipper_detail_part")
		iSuffix			= dw_requirement.GetItemNumber(l_i_Row, "shipper_detail_suffix")
		If iSuffix > 0 then
			l_s_ShipperPart	= wf_strip_off_suffix(szPart, iSuffix)
		End If
		nQtyPacked		= dw_requirement.GetItemNumber(l_i_Row, "shipper_detail_alternative_qty")
		l_n_QtyCompleted	= wf_get_qty_packed(String(l_i_Shipper), szPart)
		dw_requirement.SetItem(l_i_Row, "shipper_detail_pack_line_qty", l_n_QtyCompleted)
		w_progress.wf_progress(l_i_Row / dw_requirement.RowCount(), "Processing shipper:" + String(l_i_Shipper))
Next

Close (w_progress)
end subroutine

public subroutine wf_reset_screen ();dw_part.Reset()
dw_part.InsertRow(1)
//dw_part.Modify ( "operator_code.Text=''" )
idwc_Packaging.Reset ( )
st_pallet.text	= ""
bShipping				= FALSE
bHardQueue				= FALSE
bSoftQueue				= FALSE
bPallet					= FALSE
ib_refresh				= FALSE
szOperator				= ""
szOperatorPassword 	= ""
SelectRow ( dw_requirement, 0, False )
dw_objects.Reset ( )
If uo_boxes_on_pallet.Visible Then
	if cbx_visual_pallet.Checked then
		//cbx_visual_pallet.TriggerEvent ( Clicked! )
		wf_show_visual_pallet ( FALSE )
		cbx_visual_pallet.Checked = FALSE
	end if
	iPalletSerial = 0
	uo_boxes_on_pallet.Hide ( )
End if
dw_requirement.Enabled = TRUE
cbx_visual_pallet.Enabled = FALSE
wf_draw_percentage ( 0 )
p_mode.PictureName = "box.bmp"
end subroutine

public function decimal wf_package_tare (string szpackage);Decimal nWeight


SELECT package_materials.weight  
  INTO :nWeight  
  FROM package_materials  
 WHERE package_materials.code = :szPackage   ;


Return nWeight

end function

public function boolean wf_auto_stage ();String szAutoStage

Select parameters.auto_stage_for_packline  
  Into :szAutoStage  
  From parameters  ;

Return (szAutoStage = 'Y')
end function

public subroutine wf_get_parts ();DataWindowChild	ldwc_PartList

if dw_part.GetChild ( "part", ldwc_PartList ) = 1 then
	ldwc_PartList.SetTransObject ( SQLCA )
	ldwc_PartList.Retrieve ( )
end if
end subroutine

public function boolean wf_validate_pallet_against_shipper (long al_pallet, long al_newshipper);Long	ll_Shipper, &
		ll_Count, &
		ll_Row

ll_Shipper = f_get_value ( dw_object_info.GetItemNumber ( 1, "shipper" ) )

if isvalid ( dw_pallet_parts ) then 
	dw_pallet_parts.SetTransObject ( sqlca )
	IF dw_pallet_parts.Retrieve ( al_Pallet ) > 0 THEN
		dw_shipper_parts.SetTransObject ( sqlca )
		IF dw_shipper_parts.Retrieve ( al_NewShipper ) > 0 THEN
			For ll_Count = 1 to dw_pallet_parts.RowCount ( )
				ll_Row = dw_shipper_parts.Find ( "part = '" + &
					dw_pallet_parts.GetItemString ( ll_Count, "part" ) + "'", 1, &
					dw_shipper_parts.RowCount ( ) )
				IF ll_Row <= 0 THEN
					IF ll_Shipper = 0 THEN
						MessageBox ( monsys.msg_title, "This pallet has parts on it " + &
							"which are not part of the requirements for shipper: " + &
							String ( al_NewShipper ) + ".", StopSign! )
						Return FALSE
					ELSE
						MessageBox ( monsys.msg_title, "This pallet is already " + &
							"committed to shipper: " + String ( ll_Shipper ) + ", and " + &
							"it has parts on it which are not part of the requirements " + &
							"for shipper: " + String ( al_NewShipper ) + ".", StopSign! )
						Return FALSE
					END IF
				ELSEIF dw_pallet_parts.GetItemString ( ll_Count, "part" ) <> &
					dw_shipper_parts.GetItemString ( ll_Row, "part" ) THEN
					IF ll_Shipper = 0 THEN
						MessageBox ( monsys.msg_title, "This pallet has parts on it " + &
							"which are not part of the requirements for shipper: " + &
							String ( al_NewShipper ) + ".", StopSign! )
						Return FALSE
					ELSE
						MessageBox ( monsys.msg_title, "This pallet is already " + &
							"committed to shipper: " + String ( ll_Shipper ) + ", and " + &
							"it has parts on it which are not part of the requirements " + &
							"for shipper: " + String ( al_NewShipper ) + ".", StopSign! )
						Return FALSE
					END IF
				END IF
			Next
		END IF
	END IF
	
	IF ll_Shipper > 0 THEN
		IF MessageBox ( monsys.msg_title, "This pallet is already committed to " + &
						"shipper: " + String ( ll_Shipper ) + ".  Are you sure you " + &
						"want to change this?", Question!, YesNo!, 2 ) = 1 THEN
			Return TRUE
		ELSE
			Return FALSE
		END IF
	ELSE
		Return TRUE
	END IF
else
	RETURN TRUE
end if 	
end function

public subroutine wf_attach_pallet_to_shipper (long ai_palletserial);Long 		iRow
Long 		iTotalRows
Long 		iSerial
Long		l_Suffix, &
			l_OldRow, &
			l_Null, &
			ll_OldOrigin
String	szOrigin, &
			s_OldOrigin, &
			s_Part, &
			ls_Message
Boolean 	bOK, &
			lb_Retrieve
Dec		ld_QtyPacked

If Not bShipping then Return

If dw_object_info.Retrieve(ai_PalletSerial) <= 0 then
	MessageBox(monsys.msg_title, "Can not find pallet " + String(ai_PalletSerial), StopSign!)
	Return
End If

If dw_object_info.GetItemString ( 1, "type" ) = "S" Then

	If Not wf_validate_pallet_against_shipper ( ai_PalletSerial, iShipper ) Then
		dw_part.SetItem ( 1, "field1", "" )
		Return
	End if

	iRow	= dw_objects.Find("serial = " + String(ai_PalletSerial), 1, dw_objects.RowCount ( ) )		

	bPallet			= TRUE
	//ai_PalletSerial	= iSerial

	If iRow = 0 Then
		dw_objects.InsertRow ( 1 )
		dw_objects.SetItem ( 1, "serial", ai_PalletSerial )
		dw_objects.SetItem ( 1, "part", "Pallet" )
		dw_objects.SetItem ( 1, "type", 'S' )
	Else
		dw_objects.SelectRow ( 0, FALSE )
		dw_objects.SelectRow ( iRow, TRUE )
	End if

	dw_part.SetItem ( 1, "field2", f_get_string_value ( dw_object_info.GetItemString ( 1, "custom1" ) ) )
	uo_boxes_on_pallet.uf_setup ( TRUE, ai_PalletSerial )
	uo_boxes_on_pallet.Show ( )
	p_mode.PictureName = "pallet.bmp"
	dw_part.SetItem ( 1, "field1", String ( ai_PalletSerial ) )
	iPalletSerial = ai_PalletSerial
	wf_show_visual_pallet ( TRUE )
Else
	MessageBox(monsys.msg_title, "This is a box not a pallet!", StopSign!)
	Return
End if

If cbx_stage.checked then	//If auto stage, stage the pallet now
	dw_object_info.SetItem(1, "shipper", iShipper )
	dw_object_info.SetItem(1, "show_on_shipper", "Y")
	dw_object_info.SetItem(1, "custom1", dw_part.GetItemString(1, "field2"))
Else
	dw_object_info.SetItem(1, "origin", String ( iShipper ) )
End If

dw_object_info.AcceptText ( )

If dw_object_info.Update() > 0 then

	uo_boxes_on_pallet.dw_boxes_on_pallet.Retrieve(ai_PalletSerial)

	iTotalRows	= uo_boxes_on_pallet.dw_boxes_on_pallet.RowCount()
	szOrigin		= String(iShipper)
	bOK			= TRUE
	iRow			= 1

//	Do while bOK AND (iRow <= iTotalRows)
	
	cb_message.Show ( )
	st_message.Show ( )
	SetPointer ( HourGlass! )

	For iRow = 1 to uo_boxes_on_pallet.dw_boxes_on_pallet.RowCount ( )

		iSerial	= uo_boxes_on_pallet.dw_boxes_on_pallet.GetItemNumber(iRow, 'serial')
		l_Suffix	= uo_boxes_on_pallet.dw_boxes_on_pallet.GetItemNumber ( iRow, "suffix" )
		s_OldOrigin = f_get_string_value ( uo_boxes_on_pallet.dw_boxes_on_pallet.GetItemString ( iRow, "origin" ) )

		//  If it is already committed to a requirement, recalc for that requirement
		IF s_OldOrigin <> "" AND s_OldOrigin <> szOrigin THEN
			IF l_Suffix > 0 THEN
				s_Part = szPart + "-" + String ( l_Suffix )
			ELSE
				s_Part = szPart
			END IF
			l_OldRow = dw_requirement.Find ( "shipper_detail_part='" + s_Part + "' AND shipper_detail_shipper=" + s_OldOrigin, 1, dw_requirement.RowCount ( ) )
			IF l_OldRow > 0 THEN
				dw_requirement.SetItem ( l_OldRow, "shipper_detail_pack_line_qty", wf_get_qty_packed ( s_OldOrigin, szPart ) )
			Else
				ld_QtyPacked = wf_get_qty_packed ( s_OldOrigin, szPart )
				ll_OldOrigin = Long(s_OldOrigin)
				Update shipper_detail set
					pack_line_qty = :ld_QtyPacked
					where part = :s_Part AND
							shipper = :ll_OldOrigin;
				lb_Retrieve = TRUE
			END IF
		END IF

		SetNull ( l_Null )

		If cbx_stage.checked then	//If auto stage, stage the box now	
			IF iSuffix > 0 THEN
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "shipper", iShipper )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "origin", szOrigin )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "show_on_shipper", 'N' )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "suffix", iSuffix )
//			  	Update object  
//		     	Set origin = :szOrigin,   
//		         shipper = :iShipper,    
//		         show_on_shipper = 'N',
//					suffix  = :iSuffix  
//		   	Where serial = :iSerial   ;
			ELSE
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "shipper", iShipper )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "origin", szOrigin )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "show_on_shipper", 'N' )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "suffix", l_Null )
//			  	Update object  
//		     	Set origin = :szOrigin,   
//		         shipper = :iShipper,    
//		         show_on_shipper = 'N',
//					suffix = :l_Null  
//		   	Where serial = :iSerial   ;
			END IF
		Else
			IF iSuffix > 0 THEN
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "origin", szOrigin )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "show_on_shipper", 'N' )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "suffix", iSuffix )
//			  	Update object  
//		     	Set origin = :szOrigin,   
//	   	       show_on_shipper = 'N',  
// 					 suffix  = :iSuffix  
//	   		Where serial = :iSerial   ;
			ELSE
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "origin", szOrigin )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "show_on_shipper", 'N' )
				uo_boxes_on_pallet.dw_boxes_on_pallet.SetItem ( iRow, "suffix", l_Null )
//			  	Update object  
//		     	Set origin = :szOrigin,   
//	   	       show_on_shipper = 'N',
//					 suffix = :l_Null  
//	   		Where serial = :iSerial   ;
			END IF
		End If
	
//		If SQLCA.SQLCode <> 0 then
//			bOK	= FALSE
//		End If
	
//		iRow ++

	Next
//	Loop

	If uo_boxes_on_pallet.dw_boxes_on_pallet.Update ( ) <> 1 Then //Not bOK then
		st_message.Hide ( )
		cb_message.Hide ( )
		ls_Message = SQLCA.SQLErrText
		Rollback;
		MessageBox(monsys.msg_title, ls_Message, StopSign!)
	Else
		st_message.Hide ( )
		cb_message.Hide ( )
		dw_requirement.SetItem ( iDemandRow, "shipper_detail_pack_line_qty", wf_get_qty_packed ( String ( iShipper ), szPart ) )
		IF dw_requirement.Update ( ) = -1 THEN
			ls_Message = SQLCA.SQLErrText
			Rollback;
			MessageBox(monsys.msg_title, ls_Message, StopSign!)
		ELSE
			Commit;
		END IF
	End If
Else
	Rollback;
End If

If lb_Retrieve Then
	dDate = Date ( em_date.Text )
	dw_requirement.Retrieve ( dDate )
End if

SetPointer ( Arrow! )
end subroutine

public subroutine wf_debug (string as_Message);Long	ll_Count

Select count(*) into :ll_Count from debug ;

Insert into debug (
		record,
		message )
values ( :ll_Count,
			:as_Message ) ;

end subroutine

public function long wf_get_next_pallet_number ();Long		ll_Serial, &
			ll_SerialPlusOne, &
			ll_DummySerial
Int		li_Count

For li_Count = 1 to 10

	SELECT parameters.next_serial  
	  INTO :ll_Serial  
	  FROM parameters  ;
	
	If SQLCA.SQLCode <> 0 Then

		ll_Serial = -1

	Else

		ll_SerialPlusOne = ll_Serial + 1

		UPDATE parameters  
	   	SET next_serial = :ll_SerialPlusOne  ;

		If SQLCA.SQLCode = 0 Then

			Commit ;

			SELECT object.serial  
			  INTO :ll_DummySerial  
			  FROM object  
			 WHERE object.serial = :ll_Serial   ;

			If SQLCA.SQLCode = 0 Then
  				SELECT audit_trail.serial  
    			  INTO :ll_DummySerial  
    			  FROM audit_trail  
   			 WHERE audit_trail.serial = :ll_Serial   ;
				If SQLCA.SQLCode <> 0 Then
					li_Count = 10
				End if
			Else
				li_Count = 10
			End if

		Else

			Rollback ;

		End if

	End if

Next

Return ll_Serial
end function

public subroutine wf_display_pallet (long al_palletnumber);uo_boxes_on_pallet.uf_setup ( TRUE, al_PalletNumber )
uo_boxes_on_pallet.Show ( )
p_mode.PictureName = "pallet.bmp"
dw_part.SetItem ( 1, "field1", String ( al_PalletNumber ) )
iPalletSerial = al_PalletNumber
cbx_visual_pallet.Enabled = TRUE
bPallet = TRUE
wf_show_visual_pallet ( TRUE )

end subroutine

public subroutine wf_update_kanban (string as_kanban);String ls_status

SELECT status
INTO   :ls_status
FROM   kanban
WHERE  kanban_number = :as_kanban ;

IF ls_status <> 'A' THEN

	UPDATE kanban
	SET    status = 'A'
	WHERE  kanban_number = :as_kanban ;

	If SQLCA.SQLCODE = 0 THEN
		COMMIT ;
	ELSE
		ROLLBACK ;
	END IF 

END IF 
end subroutine

public subroutine wf_create_pallet (long ai_palletserial, string a_s_package_type);Date 		l_d_Date
String 	l_s_Operator
dec		l_dec_weight

l_d_Date			= Today()

If dw_part.RowCount() > 0 then
	l_s_Operator	= f_get_string_value(dw_part.GetItemString(1, "operator_code"))
Else
	l_s_Operator	= ""
End If

SELECT 	package_materials.weight  
INTO 		:l_dec_weight  
FROM 		package_materials  
WHERE 	package_materials.code = :a_s_package_type   ;

dw_object_info.Reset()
dw_object_info.InsertRow(1)

dw_object_info.SetItem(1, "part", "PALLET")
dw_object_info.SetItem(1, "serial", ai_palletserial)
dw_object_info.SetItem(1, "location", ddlb_machine.text)
dw_object_info.SetItem(1, "status", "A")
dw_object_info.SetItem(1, "operator", l_s_Operator)
dw_object_info.SetItem(1, "type", "S")
dw_object_info.SetItem(1, "custom1", dw_part.GetItemString ( 1, "field2" ) )
dw_object_info.SetItem(1, "kanban_number", wf_get_kanban_number(ishipper) )
dw_object_info.SetItem(1, "package_type", a_s_package_type )
dw_object_info.SetITem(1, "tare_weight", l_dec_weight )

If bShipping then
	dw_object_info.SetItem(1, "origin", String(iShipper))
	If cbx_stage.checked then
		dw_object_info.SetItem(1, "shipper", iShipper)
		dw_object_info.SetItem(1, "show_on_shipper", "Y")
	End If
Elseif szQueue = 'H' Or szQueue = 'O' Then
	dw_object_info.SetItem(1, "origin", String(iShipper))
End If

//If cbx_stage.checked then	//If auto stage
//	If bShipping then			//If in shipping mode
//		dw_object_info.SetItem(1, "shipper", iShipper)
//		dw_object_info.SetItem(1, "show_on_shipper", "Y")
//		dw_object_info.SetItem(1, "custom1", dw_part.GetItemString(1, "field2"))
//	Else
//		dw_object_info.SetItem ( 1, "origin", String ( iShipper ) )
//		dw_object_info.SetItem(1, "show_on_shipper", "N")
//	End If
//Else
//	dw_object_info.SetItem ( 1, "origin", String ( iShipper ) )
//	dw_object_info.SetItem(1, "show_on_shipper", "N")
//End If

If dw_object_info.Update() < 1 then
	Rollback;
Else
	If f_create_audit_trail(ai_palletserial, "P", '', '', "", "", "", "", "", "", "", "No Commit") Then
		Commit;
		iObjectRow = 1
		i_l_clicked_row = 1
		ipalletserial = ai_palletserial
		dw_objects.SelectRow ( iObjectRow, TRUE )
		dw_objects.InsertRow(1)
		dw_objects.SetItem(1, "serial", ai_palletserial)
		dw_objects.SetItem(1, "part", "PALLET")
		dw_objects.SetItem(1, "type", "S")
		dw_objects.SelectRow ( 0, False )
		dw_objects.SelectRow ( 1, True )
		dw_objects.SetRow ( 1 )
		dw_objects.TriggerEvent ( clicked! )
	
		p_mode.PictureName			= "pallet.bmp"
		dw_part.SetItem(1, "field1", String(ai_palletserial))
		wf_show_visual_pallet(TRUE)
	else
		rollback;
	end if
End If
end subroutine

public subroutine wf_draw_percentage (decimal a_n_qtycompleted);st_percentage.visible	= FALSE

If nTotalQty > 0 then
	st_percentage.Width		= (st_percentage_value.x - st_percentage.x) * (a_n_QtyCompleted / nTotalQty)
	st_percentage_value.text= String(Truncate(100 * a_n_QtyCompleted/nTotalQty, 0)) + " %"
	If a_n_QtyCompleted >= nTotalQty And Not ib_Refresh then
		a_n_QtyCompleted	= nTotalQty
		st_done.visible	= TRUE
		if cbx_1.Checked then
			f_beep(3)
			i_b_job_done = TRUE
			dw_requirement.SetFilter ( "" )
			dw_requirement.Filter ( )
			dw_requirement.SelectRow ( 0, False )
			If cbx_1.Checked Then
				dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
				dw_requirement.Filter()		
			end if
			iDemandRow = 0
			dw_objects.Reset ( )
			TriggerEvent ( "clear_screen" )
			st_percentage.Width			= 0
			st_percentage_value.text	= "0 %"
		end if
		bPallet	= FALSE
		p_mode.PictureName			= "box.bmp"
		uo_boxes_on_pallet.Hide ( )
		wf_show_visual_pallet(FALSE)
		dw_requirement.Enabled = TRUE
		dw_part.SetItem ( 1, "field1", "" )
		iPalletSerial = 0
	Else
		st_done.visible	= FALSE

	End If
End If

st_percentage.visible	= TRUE
end subroutine

public subroutine wf_send_object_to_pallet (long aipalletserial, long aiobjectserial);UPDATE object  
   SET parent_serial = :aiPalletSerial  
 WHERE serial = :aiObjectSerial   ;


If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If	
end subroutine

public function string wf_get_schedule_queue (string a_s_machine);String l_s_Queue

  SELECT machine_policy.schedule_queue  
    INTO :l_s_Queue  
    FROM machine_policy  
   WHERE machine_policy.machine = :a_s_Machine   ;

Return l_s_Queue
end function

public subroutine wf_create_package_dropdown (string a_s_part);String	l_s_Code
string	ls_previoustype
Long		ll_row

idwc_Packaging.Reset ( )
idwc_Packaging.InsertRow ( 1 )
idwc_Packaging.SetItem ( 1, "code", "" )

DECLARE	packaging CURSOR FOR  
SELECT 	part_packaging.code  
FROM 	part_packaging
	join package_materials pkm on pkm.code = part_packaging.code
where	part_packaging.part = :a_s_part and pkm.type <> 'P' 
ORDER BY part_packaging.code ASC  ;

Open packaging ;
Do
	Fetch packaging Into :l_s_Code ;
	If SQLCA.SQLCode = 0 Then
		ll_row = idwc_Packaging.InsertRow ( 0 )
		idwc_Packaging.SetItem ( ll_row, "code", l_s_Code )
	End if
Loop While SQLCA.SQLCode = 0
Close packaging ;
	
if bshipping then 
	SELECT distinct order_detail.packaging_type
	 INTO :l_s_code
	 FROM order_detail
	WHERE order_detail.part_number = :a_s_Part and
			order_detail.order_no = :isalesorder ;

	dw_part.SetItem ( 1, "packagetype", l_s_code)
	dw_part.SetItem ( 1, "StandardPack", wf_get_std_pack ( l_s_code ) )
	dw_part.SetItem ( 1, "Quantity", wf_get_std_pack ( l_s_code ) )
else
	dw_part.SetItem ( 1, "packagetype", '')
	dw_part.SetItem ( 1, "StandardPack", wf_get_inv_std_pack ( a_s_part ) )
	dw_part.SetItem ( 1, "Quantity", wf_get_inv_std_pack ( a_s_part ) )	
end if 

if idwc_Packaging.RowCount ( ) < 1 then	
	ls_previoustype = Isnull ( dw_part.GetItemString ( 1, "packagetype" ), '' )
	if ls_previoustype > '' then
		ll_row = idwc_Packaging.Find ( "packagetype='" + ls_previoustype + "'", 1, idwc_Packaging.RowCount ( ) )
		if ll_row > 0 then
			if idwc_Packaging.GetItemString ( ll_row, "code" ) <> ls_previoustype then
				dw_part.SetItem ( 1, "packagetype", "" )
				dw_part.SetItem ( 1, "StandardPack", 0 )
				dw_part.SetItem ( 1, "Quantity", 0 )
			end if
		else
			dw_part.SetItem ( 1, "packagetype", "" )
			dw_part.SetItem ( 1, "StandardPack", 0 )
			dw_part.SetItem ( 1, "Quantity", 0 )
		end if
	end if
end if

//String	l_s_Code
//string	ls_previoustype
//Long		ll_row
//
//idwc_Packaging.Reset ( )
//idwc_Packaging.InsertRow ( 1 )
//idwc_Packaging.SetItem ( 1, "code", "" )
//
//if NOT bshipping then 
//
//	 DECLARE packaging CURSOR FOR  
//	  SELECT part_packaging.code  
//	    FROM part_packaging  
//	   WHERE part_packaging.part = :a_s_Part   
//	ORDER BY part_packaging.code ASC  ;
//
//	Open packaging ;
//	Do
//		Fetch packaging Into :l_s_Code ;
//		If SQLCA.SQLCode = 0 Then
//			ll_row = idwc_Packaging.InsertRow ( 0 )
//			idwc_Packaging.SetItem ( ll_row, "code", l_s_Code )
//		End if
//	Loop While SQLCA.SQLCode = 0
//	Close packaging ;
//	
//else
//	  SELECT distinct order_detail.packaging_type
//	  	 INTO :l_s_code
//	    FROM order_detail
//	   WHERE order_detail.part_number = :a_s_Part and
//				order_detail.order_no = :isalesorder ;
//		ll_row = idwc_Packaging.InsertRow ( 0 )
//		idwc_Packaging.SetItem ( ll_row, "code", l_s_Code )
//end if 
//	
//if idwc_Packaging.RowCount ( ) > 1 then
//	dw_part.SetItem ( 1, "packagetype", idwc_Packaging.GetItemString ( 2, "code" ) )
//	dw_part.SetItem ( 1, "StandardPack", wf_get_std_pack ( dw_part.GetItemString ( 1, "packagetype" ) ) )
//	dw_part.SetItem ( 1, "Quantity", wf_get_std_pack ( dw_part.GetItemString ( 1, "packagetype" ) ) )
//else
//	ls_previoustype = Isnull ( dw_part.GetItemString ( 1, "packagetype" ), '' )
//	if ls_previoustype > '' then
//		ll_row = idwc_Packaging.Find ( "packagetype='" + ls_previoustype + "'", 1, idwc_Packaging.RowCount ( ) )
//		if ll_row > 0 then
//			if idwc_Packaging.GetItemString ( ll_row, "code" ) <> ls_previoustype then
//				dw_part.SetItem ( 1, "packagetype", "" )
//				dw_part.SetItem ( 1, "StandardPack", 0 )
//				dw_part.SetItem ( 1, "Quantity", 0 )
//			end if
//		else
//			dw_part.SetItem ( 1, "packagetype", "" )
//			dw_part.SetItem ( 1, "StandardPack", 0 )
//			dw_part.SetItem ( 1, "Quantity", 0 )
//		end if
//	end if
//end if
end subroutine

public subroutine wf_create_units_dropdown (string a_s_part);Integer 	l_i_Count

String	l_s_UM

lb_um.reset()
dwUM.reset()

f_get_units_for_part("", a_s_Part, lb_um)

For l_i_Count	= 1 to lb_um.TotalItems()
	lb_um.SelectItem(l_i_Count)
	l_s_UM	= lb_um.SelectedItem()
	dwUM.InsertRow(1)
	dwUM.SetItem(1, "value1", l_s_UM)
Next	
end subroutine

public function string wf_get_supplier_code (string a_s_destination);String l_s_Supplier

  SELECT edi_setups.supplier_code  
    INTO :l_s_Supplier  
    FROM edi_setups  
   WHERE edi_setups.destination = :a_s_Destination   ;

Return f_get_string_value(l_s_Supplier)
end function

public function boolean wf_valid_part (string a_s_part);String l_s_CurrentPart

  SELECT part.part  
    INTO :l_s_CurrentPart  
    FROM part  
   WHERE part.part = :a_s_Part and
			type = 'F'  or type = 'W';


If Trim(l_s_CurrentPart) > " " then
	Return TRUE
Else
	Return FALSE
End If
end function

public function string wf_get_um (string a_s_part);String l_s_Unit

  SELECT part_inventory.standard_unit  
    INTO :l_s_Unit  
    FROM part_inventory  
   WHERE part_inventory.part = :a_s_Part   ;

Return f_get_string_value(l_s_Unit)
end function

public function boolean wf_valid_pallet (long a_l_serial);String l_s_Type				//Object type
String l_s_Part				//Part Number
Long	 l_l_Row					//Current Row Number

SELECT object.type,   
       object.part  
  INTO :l_s_Type,   
       :l_s_Part  
  FROM object  
 WHERE object.serial = :a_l_Serial   ;

If IsNull(l_s_Part) then
	MessageBox(monsys.msg_title, "Serial number not found", StopSign!)
	Return FALSE
Else
	If l_s_Type = "S" then
		Return TRUE
	Else
		MessageBox(monsys.msg_title , "This is not a pallet", StopSign!)
		Return FALSE
	End If
End If

end function

public function string wf_get_std_label (string a_s_part);String l_s_Label

SELECT part_inventory.label_format  
  INTO :l_s_Label  
  FROM part_inventory  
 WHERE part = :a_s_Part   ;

Return l_s_Label

end function

public function boolean wf_update_demand (long a_l_shipper, string a_s_part, decimal a_n_qty);Decimal l_n_PackLineQty
String	l_s_Order

If iDemandRow < 1 Or Not dw_requirement.IsSelected ( iDemandRow ) Then Return TRUE

if szQueue = 'F' then return TRUE

If bShipping Then
	l_n_PackLineQty	= f_get_value(wf_get_qty_packed(String(a_l_Shipper), a_s_Part))

	dw_requirement.SetItem(iDemandRow, "shipper_detail_pack_line_qty", l_n_PackLineQty)

	If l_n_PackLineQty	>= dw_requirement.GetItemNumber(iDemandRow, "shipper_detail_qty_required") then
		bCompleted	= TRUE
		dw_requirement.Filter ( )
		//dw_requirement.DeleteRow(iDemandRow)
	End If

Elseif szQueue = 'H' Then
	l_n_PackLineQty	= f_get_value(wf_get_qty_packed(String(a_l_Shipper), a_s_Part))

	dw_requirement.SetItem(iDemandRow, "qty_completed", l_n_PackLineQty)

	If l_n_PackLineQty	>= dw_requirement.GetItemNumber(iDemandRow, "qty_required") then
		bCompleted	= TRUE
		dw_requirement.Filter ( )
		//dw_requirement.DeleteRow(iDemandRow)
	End If
Elseif szQueue = 'O' Then
	l_s_Order = String ( a_l_Shipper )
	If iSuffix > 0 Then
		SELECT 	sum(std_quantity) 
		INTO 		:l_n_PackLineQty
		FROM		object
		WHERE 	part = :a_s_Part and
					origin = :l_s_Order and
					suffix = :iSuffix ;
	Else
		SELECT 	sum(std_quantity) 
		INTO 		:l_n_PackLineQty
		FROM		object
		WHERE 	part = :a_s_Part and
					origin = :l_s_Order and
					suffix is null ;
	End if
//	l_n_PackLineQty	= f_get_value(wf_get_qty_packed(String(a_l_Shipper), a_s_Part))

	dw_requirement.SetItem(iDemandRow, "packline_qty", l_n_PackLineQty)

	If l_n_PackLineQty	>= dw_requirement.GetItemNumber(iDemandRow, "quantity") then
		bCompleted	= TRUE
		dw_requirement.Filter ( )
		//dw_requirement.DeleteRow(iDemandRow)
	End If
End if

IF dw_requirement.Update ( ) = 1 THEN
	Return TRUE
ELSE
	Return FALSE
END IF

//UPDATE shipper_detail  
//   SET pack_line_qty = :l_n_PackLineQty  
// WHERE ( shipper = :a_l_Shipper ) AND  
//       ( part = :a_s_Part )   ;
//
//If SQLCA.SQLCode = -1 then
//	Return FALSE
//Else
//	Return TRUE
//End If	


end function

public function string wf_strip_off_suffix (string a_s_part, long a_l_suffix);Long l_l_Pos

l_l_Pos	= PosA(a_s_Part, "-" + String(a_l_Suffix))

If l_l_Pos > 1 then
	a_s_Part	= LeftA(a_s_Part, l_l_Pos - 1)
End If

Return a_s_Part
end function

public function string wf_get_note (long a_l_order, string a_s_part, long a_l_suffix);String l_s_Note

Select order_detail.notes  
  Into :l_s_Note  
  From order_detail  
 Where ( order_detail.order_no = :a_l_order ) AND  
       ( order_detail.part_number = :a_s_part ) AND  
       ( order_detail.suffix = :a_l_suffix )   ;

Return f_get_string_value(l_s_Note)
end function

public function string wf_get_kanban_number (integer a_l_shipper);STRING s_kanban, &
		 s_status, &
		 s_temp1, &
		 s_temp2

DECLARE kanban_cursor CURSOR FOR  
SELECT kanban_number, status
FROM kanban  
WHERE status = 'A' and order_no = :isalesorder 
ORDER BY  kanban_number ASC ;

OPEN kanban_cursor ;

FETCH kanban_cursor INTO :s_kanban, :s_status ;	

CLOSE kanban_cursor ;

UPDATE kanban
SET status = 'U'
WHERE kanban_number= :s_kanban ;

COMMIT ;

Return s_kanban ;


			 
end function

public function string wf_get_label_window (string a_s_label);String a_s_Window

  SELECT report_library.object_name  
    INTO :a_s_Window  
    FROM report_library
   WHERE report_library.name = :a_s_Label   ;

Return a_s_Window

end function

public function integer wf_print_pallet_label (long iserial);String	szPalletLabel
Long	ll_Order
SetNull(szPalletLabel)
If bShipping Then
	SELECT shipper_detail.order_no  
	INTO :ll_Order
	FROM shipper_detail  
	WHERE shipper_detail.shipper = :iShipper   ;
	If SQLCA.SQLCode = 0 Then
		SELECT order_header.pallet_label  
		INTO :szPalletLabel
		FROM order_header  
		WHERE order_header.order_no = :ll_Order   ;
	End if
End if
If f_get_string_value ( szPalletLabel ) = "" Then
  SELECT report_library.object_name  
    INTO :szPalletLabel   
    FROM report_library
   WHERE report_library.name = 'PALLET';
End if

if dw_objects.rowcount() > 0 then 
	if IsNull ( dw_objects.GetItemString ( iObjectRow, "pallet_label" ), '' ) > '' then
		stparm.value12 = dw_objects.GetItemString ( iObjectRow, "pallet_label" )
	else
		If IsNull(szPalletLabel) then
			stparm.value12 = 'NOLABEL'
		Else
			stparm.value12 = 'PALLET'
		End If
	end if 	
else
	If IsNull(szPalletLabel) then
		stparm.value12 = 'NOLABEL'
	Else
		stparm.value12 = 'PALLET'
	End If
end if
stParm.Value1 = String ( iSerial )
return f_print_label ( stparm )
end function

public subroutine wf_create_object (long iserial, string as_operator);Date 		l_d_Date

String	l_s_Operator
String	l_s_TempPart
String	l_s_UM
String	l_s_PackageType
String	l_s_LabelWindow
String	l_s_Lot
String	l_s_ControlNumber
String	ls_engineering_level
String	ls_kanban
string	ls_location

Time	l_n_Time

Boolean	l_b_kanban_label
 
Decimal	l_n_Qty
Decimal	l_n_Weight
Decimal	l_n_StdQty

Long		iParentSerial

m_packline.m_operation.m_jobcompletion.Enabled		= FALSE
If bPallet AND (iPalletSerial > 0) then
	iParentSerial	= iPalletSerial
	select	location

	into	:ls_location 
	from	object
	where	serial = :iPalletserial;
Else
	SetNull(iParentSerial)
	ls_location = ddlb_machine.text
End If
 
l_d_Date				= Today()

l_s_Operator		= as_operator //f_get_string_value(dw_part.GetItemString(1, "operator"))
l_s_TempPart		= f_get_string_value(dw_part.GetItemString(1, "part"))
l_s_UM				= dw_part.GetItemString(1, "um")
l_s_PackageType	= dw_part.GetItemString( 1, "packagetype" )
l_s_Lot				= dw_part.GetItemString(1, "lot")
l_s_ControlNumber= dw_part.GetItemString(1, "controlnumber")

SELECT engineering_level
  INTO :ls_engineering_level
  FROM part_mfg
 WHERE part = :l_s_TempPart ;

l_n_Qty				= f_get_value(dw_part.GetItemNumber(1, "quantity"))
l_n_StdQty			= f_convert_units(l_s_UM, "", l_s_TempPart, l_n_Qty)
//l_n_Weight			= Dec(f_get_part_info(l_s_TempPart, "UNIT WEIGHT"))
ls_kanban 		= wf_get_kanban_number(ishipper)
l_n_Time				= Now()

dw_object_info.Reset()
dw_object_info.InsertRow(1)

dw_object_info.SetItem(1, "part", l_s_TempPart)
dw_object_info.SetItem(1, "serial", iSerial)
dw_object_info.SetItem(1, "status", "A")
dw_object_info.SetItem(1, "user_defined_status", "Approved" )
dw_object_info.SetItem(1, "operator", l_s_Operator)
dw_object_info.SetItem(1, "quantity", l_n_Qty)
dw_object_info.SetItem(1, "std_quantity", l_n_StdQty)
dw_object_info.SetItem(1, "last_time", l_n_Time)
dw_object_info.SetItem(1, "unit_measure", l_s_UM)
//dw_object_info.SetItem(1, "weight", l_n_Weight)
dw_object_info.SetItem(1, "package_type", l_s_PackageType)
dw_object_info.SetItem(1, "parent_serial", iParentSerial)
dw_object_info.SetItem(1, "lot", l_s_Lot)
dw_object_info.SetItem(1, "location", ls_location)
dw_object_info.SetItem(1, "field1", l_s_ControlNumber)
//dw_object_info.SetItem(1, "tare_weight", nPackageTare)
dw_object_info.SetItem(1, "cost", nStdCost)
dw_object_info.SetItem(1, "std_cost", nStdCost)
dw_object_info.SetItem(1, "engineering_level", ls_engineering_level )
dw_object_info.SetItem(1, "kanban_number", ls_kanban )

If iSuffix > 0 then
	dw_object_info.SetItem(1, "suffix", iSuffix)
End If

//	Validate packaging for objects built for a shipper.
if bShipping then
	//	Evaluate packaging...
	string defaultPackagingCode
	int packDisabled, packEnabled, packWarn
	n_cst_shippingtrans_partpackaging shippingTrans_PartPackaging
	shippingTrans_PartPackaging = create n_cst_shippingtrans_partpackaging
	shippingTrans_PartPackaging.VerifyPack(iShipper, l_s_TempPart, l_s_PackageType, defaultPackagingCode, packDisabled, packEnabled, packWarn)
	destroy shippingTrans_PartPackaging
	
	//	If warn, then warn.
	if	packWarn = 1 then
		int mReturn
		if	MessageBox(gnv_app.iapp_Object.DisplayName, "You are attempting to build a box with package type ~"" + l_s_PackageType + "~".  The default package type for this part is ~"" + defaultPackagingCode + "~".  Click OK to continue.", Information!, OkCancel!, 2) = 2 then
			//	Denied.
			return
		end if
	end if
	//	If not enabled, then denied
	if	packEnabled = 0 then
		MessageBox(gnv_app.iapp_Object.DisplayName, "You are attempting to build a box with package type ~"" + l_s_PackageType + "~".  The default package type for this part is ~"" + defaultPackagingCode + "~".  This package type cannot be selected.", StopSign!)
		return
	end if
end if

If bShipping then
	dw_object_info.SetItem(1, "origin", String(iShipper))
	If cbx_stage.checked then
		dw_object_info.SetItem(1, "shipper", iShipper)
		If bPallet AND (iPalletSerial > 0) then
			dw_object_info.SetItem(1, "show_on_shipper", "N")
		Else
			dw_object_info.SetItem(1, "show_on_shipper", "Y")
		End If
	End If
Elseif szQueue = 'H' Or szQueue = 'O' Then
	dw_object_info.SetItem(1, "origin", String(iShipper))
End If

If dw_object_info.Update() < 1 then
	Rollback;
Else
	If f_update_onhand(l_s_TempPart, l_n_StdQty, "+*")	= -1 Then				//Update on hand quantity
		RollBack ;
	Else
		If Not f_create_audit_trail(iSerial, "J", l_s_ControlNumber, String(nStdCost), "", "", "", "", "", "", "", "No Commit") Then 	//Create audit trail
			RollBack ;
		Else
			If ( l_s_TempPart	= szShipperPart ) And Not wf_update_demand(iShipper, l_s_TempPart, l_n_Qty) then		//If still the same part
					RollBack ;
			Else	
				Commit ;
				If dw_part.GetItemString ( 1, "label" ) <> "NOLABEL" then
					l_s_LabelWindow	= dw_part.GetItemString ( 1, "label" ) 
					If Not IsNull(l_s_LabelWindow) then
						stParm.value1	= String(iSerial)
						stParm.value2	= szCustomerPart
						stParm.value3	= wf_get_supplier_code(szDestination)
						stParm.value5	= l_s_ControlNumber
						stParm.value12 = l_s_LabelWindow //change

//						l_b_kanban_label = wf_check_label(l_s_LabelWindow)
			
						If (bShipping) AND (iDemandRow > 0) then  //If selected right shipping demand
							stParm.value4	= szLineFeedCode
							stParm.value6	= szDockCode	
							stParm.value7	= szDestination
							stParm.value8	= String(iSalesOrder)
							stParm.value9	= szCustomerPO
							stParm.value10	= szZoneCode
						End If

						If f_print_label (stparm) = 0 then
//							If l_b_kanban_label then
//								Update kanban
//							   set status = 'X'
//						      where kanban_number = :ls_kanban ;
//							
//								If sqlca.sqlcode = 0 then
//                  	         commit ;
//						   	else
//										rollback;
//										messagebox(monsys.msg_title, "Unable to print the Kanban label. "+sqlca.sqlerrtext)
//								end if
//							End If
						End If
					Else

						MessageBox(monsys.msg_title, "Invalid label program name in data base", StopSign!)
					End If
				End If
		
				If Not bPallet then
					dw_objects.InsertRow(1)
					dw_objects.SetItem(1, "serial", iSerial)
					dw_objects.SetItem(1, "part", l_s_TempPart)
					dw_objects.SetItem(1, "type", " ")
					dw_objects.SetItem(1, "std_quantity", l_n_StdQty)
					dw_objects.SetItem(1, "qty", l_n_Qty)
					dw_objects.SetItem(1, "um", l_s_UM)
//					dw_objects.SetItem(1, "weight", l_n_Weight * l_n_StdQty)
				Else
					If uo_visual_pallet.Visible Then
						uo_visual_pallet.uf_setup ( iParentSerial )
					End if
					uo_boxes_on_pallet.uf_setup ( TRUE, iParentSerial )
				End If
	
				nQtyCompleted	= nQtyCompleted + l_n_Qty
				wf_draw_percentage(nQtyCompleted)
	
			End if

		End if

	End if

End If

//cb_job_comp.Enabled	= TRUE
m_packline.m_operation.m_jobcompletion.Enabled	= TRUE
end subroutine

public function decimal wf_get_inv_std_pack (string as_part);Decimal nQty

  SELECT part_inventory.standard_pack
    INTO :nQty  
    FROM part_inventory
   WHERE ( part_inventory.part = :as_Part );

Return nQty
end function

public function integer wf_validate_part ();int	li_Count

select	count ( 1 ) 
into	:li_Count
from	part 
where	part = :szpart ;

return li_Count
end function

event open;dw_objects.SetTransObject(sqlca)
dw_requirement.SetTransObject(sqlca)
dw_object_info.SetTransObject(sqlca)

dw_part.GetChild ( "um", dwUM )
dw_part.GetChild ( "part", idwc_Part )
dw_part.GetChild ( "label", idwc_Label )
dw_part.GetChild ( "packagetype", idwc_Packaging )

dw_part.InsertRow(1)

wf_create_machine_dropdown()


szQueue	= "D"			//Initially set to "SHIPPING REQUIREMENT"

dDate		= Today()

cbx_stage.checked	= wf_auto_stage()
cbx_stage.visible	= Not cbx_stage.checked
em_date.text		= String(Today())
bFilter				= cbx_1.Checked

//Close(w_pack_line_title)

Post Event ue_open ( )
end event

event timer;String	ls_Operator, &
			ls_OperatorPassword
Long		l_Row
Datetime ldt_retrdate

if bFinish And b_ChangeDate then
	bFinish	= FALSE
	b_ChangeDate = FALSE
	Timer(1, This)
	st_percentage.Visible = False
	If szReturnedString > " " then
		dDate	= Date(szReturnedString)
		em_date.Text = String ( dDate )

		If szQueue = "H" then
			dw_requirement.DataObject 	= "dw_hard_queue_information"
			dw_requirement.SetTransObject(sqlca)
			st_6.Text			= "Hard Queue Requirement"
			dw_requirement.Retrieve(ddlb_machine.text)
			bHardQueue	= TRUE
		Else
			If szQueue = "S" then
				dw_requirement.DataObject 	= "dw_soft_queue_information"
				dw_requirement.SetTransObject(sqlca)
				st_6.Text			= "Soft Queue Requirement"
				dw_requirement.Retrieve(ddlb_machine.text)
				bSoftQueue	= TRUE
			Else
				dw_requirement.DataObject 	= "dw_shipper_detail_destination_info"
				dw_requirement.SetTransObject(sqlca)
				st_6.Text = "Shipping Requirement (" + String(dDate) + ")"
				ldt_retrdate = datetime(ddate,time("23:59:59")) 
				dw_requirement.Retrieve(ldt_retrdate)	
				bShipping	= TRUE
				If bFilter then
					dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
					dw_requirement.Filter()		
				End If
			End If
		End If
		SetNull(iSuffix)
		ls_Operator = szOperator
		ls_OperatorPassword = szOperatorPassword
		wf_reset_screen()
		st_part_info.text	= "Packing for Inventory"
		If ls_Operator > "" Then
			szOperator = ls_Operator
			szOperatorPassword = ls_OperatorPassword
		End if
		If Not bPallet Then dw_requirement.BringToTop	= TRUE
	End If
Elseif ( dw_requirement.RowCount ( ) > 0 ) And ib_Timer And &
		( dw_requirement.IsSelected ( dw_requirement.GetRow ( ) ) ) then

	If iCount >= 60 Then

		st_check.visible	= TRUE

		ib_Refresh = TRUE
		l_Row = dw_requirement.GetRow ( )

		If l_Row > 0 And dw_requirement.IsSelected ( l_Row ) Then
			idemandRow = l_row
			dw_requirement.TriggerEvent ( clicked! )

		Else
			ib_Refresh = FALSE
		End if

		iCount = 0
		st_check.visible			= FALSE
		sle_percentage.visible	= FALSE
		sle_percentage.width		= 0
		sle_percentage.visible	= TRUE

	Else
		sle_percentage.width		= sle_base.width * iCount / 60
		sle_percentage.Visible 	= True
		iCount ++

	End If	

	st_timer.Text = String ( 60 - iCount ) 

Else
	sle_percentage.Visible = FALSE
	st_timer.Text = "60"
	iCount = 0
End If
end event

event dragdrop;bDragBox		= FALSE
bDragPallet	= FALSE

If iNoDragged > 0 then
	Box[iNoDragged].Invert	= FALSE
End If

p_drag.y	= 5000
end event

on w_smart_job_completion_version2.create
this.st_message=create st_message
this.cb_message=create cb_message
this.cbx_visual_pallet=create cbx_visual_pallet
this.em_date=create em_date
this.st_6=create st_6
this.st_timer=create st_timer
this.st_check=create st_check
this.sle_percentage=create sle_percentage
this.st_1=create st_1
this.st_part_info=create st_part_info
this.st_8=create st_8
this.st_7=create st_7
this.p_4=create p_4
this.cbx_1=create cbx_1
this.lb_um=create lb_um
this.st_suffix=create st_suffix
this.cbx_stage=create cbx_stage
this.sle_operation=create sle_operation
this.st_done=create st_done
this.st_percentage_value=create st_percentage_value
this.st_percentage=create st_percentage
this.cb_show_cancel=create cb_show_cancel
this.cb_show_save=create cb_show_save
this.sle_show_pallet=create sle_show_pallet
this.st_show_pallet=create st_show_pallet
this.sle_show_object=create sle_show_object
this.st_show_object=create st_show_object
this.cb_show=create cb_show
this.ddlb_units=create ddlb_units
this.dw_temp=create dw_temp
this.ddlb_machine=create ddlb_machine
this.p_drag=create p_drag
this.p_trash=create p_trash
this.st_pallet=create st_pallet
this.st_serial41=create st_serial41
this.st_serial42=create st_serial42
this.st_serial43=create st_serial43
this.st_serial44=create st_serial44
this.st_serial45=create st_serial45
this.st_serial46=create st_serial46
this.st_serial47=create st_serial47
this.st_serial48=create st_serial48
this.p_mode=create p_mode
this.st_4=create st_4
this.dw_object_info=create dw_object_info
this.dw_requirement=create dw_requirement
this.sle_base=create sle_base
this.st_5=create st_5
this.dw_part=create dw_part
this.uo_boxes_on_pallet=create uo_boxes_on_pallet
this.dw_objects=create dw_objects
this.p_1=create p_1
this.st_2=create st_2
this.p_2=create p_2
this.st_3=create st_3
this.st_10=create st_10
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_visual_pallet=create uo_visual_pallet
this.Control[]={this.st_message,&
this.cb_message,&
this.cbx_visual_pallet,&
this.em_date,&
this.st_6,&
this.st_timer,&
this.st_check,&
this.sle_percentage,&
this.st_1,&
this.st_part_info,&
this.st_8,&
this.st_7,&
this.p_4,&
this.cbx_1,&
this.lb_um,&
this.st_suffix,&
this.cbx_stage,&
this.sle_operation,&
this.st_done,&
this.st_percentage_value,&
this.st_percentage,&
this.cb_show_cancel,&
this.cb_show_save,&
this.sle_show_pallet,&
this.st_show_pallet,&
this.sle_show_object,&
this.st_show_object,&
this.cb_show,&
this.ddlb_units,&
this.dw_temp,&
this.ddlb_machine,&
this.p_drag,&
this.p_trash,&
this.st_pallet,&
this.st_serial41,&
this.st_serial42,&
this.st_serial43,&
this.st_serial44,&
this.st_serial45,&
this.st_serial46,&
this.st_serial47,&
this.st_serial48,&
this.p_mode,&
this.st_4,&
this.dw_object_info,&
this.dw_requirement,&
this.sle_base,&
this.st_5,&
this.dw_part,&
this.uo_boxes_on_pallet,&
this.dw_objects,&
this.p_1,&
this.st_2,&
this.p_2,&
this.st_3,&
this.st_10,&
this.gb_4,&
this.gb_3,&
this.gb_5,&
this.gb_2,&
this.gb_1,&
this.uo_visual_pallet}
end on

on w_smart_job_completion_version2.destroy
destroy(this.st_message)
destroy(this.cb_message)
destroy(this.cbx_visual_pallet)
destroy(this.em_date)
destroy(this.st_6)
destroy(this.st_timer)
destroy(this.st_check)
destroy(this.sle_percentage)
destroy(this.st_1)
destroy(this.st_part_info)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.p_4)
destroy(this.cbx_1)
destroy(this.lb_um)
destroy(this.st_suffix)
destroy(this.cbx_stage)
destroy(this.sle_operation)
destroy(this.st_done)
destroy(this.st_percentage_value)
destroy(this.st_percentage)
destroy(this.cb_show_cancel)
destroy(this.cb_show_save)
destroy(this.sle_show_pallet)
destroy(this.st_show_pallet)
destroy(this.sle_show_object)
destroy(this.st_show_object)
destroy(this.cb_show)
destroy(this.ddlb_units)
destroy(this.dw_temp)
destroy(this.ddlb_machine)
destroy(this.p_drag)
destroy(this.p_trash)
destroy(this.st_pallet)
destroy(this.st_serial41)
destroy(this.st_serial42)
destroy(this.st_serial43)
destroy(this.st_serial44)
destroy(this.st_serial45)
destroy(this.st_serial46)
destroy(this.st_serial47)
destroy(this.st_serial48)
destroy(this.p_mode)
destroy(this.st_4)
destroy(this.dw_object_info)
destroy(this.dw_requirement)
destroy(this.sle_base)
destroy(this.st_5)
destroy(this.dw_part)
destroy(this.uo_boxes_on_pallet)
destroy(this.dw_objects)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.st_3)
destroy(this.st_10)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_visual_pallet)
end on

event deactivate;DESTROY dw_shipper_parts 
DESTROY dw_pallet_parts 
DESTROY dw_packaging
DESTROY dw_units 

end event

event activate;//// Added for Custom menu items
//	f_build_custom_arrays("monitor.packline")
//// Added for Custom menu items
//	f_build_custom_menu(gnv_App.of_GetFrame().MenuID, wMainScreen)
//
end event

type st_message from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 923
integer y = 588
integer width = 818
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Attaching existing objects on pallet to the selected requirement ..."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_message from commandbutton within w_smart_job_completion_version2
boolean visible = false
integer x = 905
integer y = 556
integer width = 855
integer height = 272
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type cbx_visual_pallet from checkbox within w_smart_job_completion_version2
integer x = 1733
integer y = 816
integer width = 631
integer height = 40
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Visual Pallet Display"
end type

on clicked;IF bPallet THEN
	if Checked Then
		wf_show_visual_pallet ( TRUE )
	else
		wf_show_visual_pallet ( FALSE )
	end if
end if


end on

type em_date from statictext within w_smart_job_completion_version2
integer x = 2354
integer y = 1328
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_smart_job_completion_version2
integer x = 1728
integer y = 36
integer width = 1152
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Shipping Requirement"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_timer from statictext within w_smart_job_completion_version2
integer x = 1792
integer y = 880
integer width = 105
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_check from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2647
integer y = 880
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Checking"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_percentage from singlelineedit within w_smart_job_completion_version2
boolean visible = false
integer x = 1929
integer y = 888
integer width = 37
integer height = 40
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean border = false
boolean autohscroll = false
end type

type st_1 from statictext within w_smart_job_completion_version2
integer x = 2048
integer y = 1328
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "View Date"
boolean focusrectangle = false
end type

type st_part_info from statictext within w_smart_job_completion_version2
integer x = 23
integer y = 40
integer width = 1664
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Packing for Inventory"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_smart_job_completion_version2
integer x = 1842
integer y = 1328
integer width = 105
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Drop"
boolean focusrectangle = false
end type

type st_7 from statictext within w_smart_job_completion_version2
integer x = 1733
integer y = 1328
integer width = 105
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Drag"
boolean focusrectangle = false
end type

type p_4 from picture within w_smart_job_completion_version2
integer x = 1920
integer y = 1248
integer width = 96
integer height = 84
boolean originalsize = true
string picturename = "dragdrop.bmp"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_smart_job_completion_version2
integer x = 2048
integer y = 1248
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Filter On"
boolean checked = true
boolean lefttext = true
end type

on clicked;string	l_s_part
long		l_l_shipper, &
			l_l_suffix, &
			l_l_row

If Checked Then
	Choose Case szQueue
		Case "D"
			if iDemandRow > 0 Then
				if dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_qty_required" ) <= &
					dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_pack_line_qty" ) then
					i_b_job_done = TRUE
					Parent.TriggerEvent ( "clear_screen" )
					st_done.visible	= FALSE
					st_percentage.visible	= FALSE
					iDemandRow = 0
				else
					l_s_part 	= dw_requirement.GetItemString ( iDemandRow, "shipper_detail_part_original" )
					l_l_suffix	= dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_suffix" )
					l_l_shipper	= dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_shipper" )
				end if
			end if
			dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
			dw_requirement.Filter()		
			if iDemandRow > 0 then
				l_l_row = dw_requirement.Find ( "shipper_detail_part_original = '" + l_s_part + "' and shipper_detail_suffix = " + String ( l_l_suffix ) + " and shipper_detail_shipper = " + String ( l_l_shipper ), 1, dw_requirement.RowCount ( ) )
				if l_l_row > 0 then
					dw_requirement.SetRow ( l_l_row )
					dw_requirement.SelectRow ( 0, FALSE )
					dw_requirement.SelectRow ( l_l_row, TRUE )
					iDemandRow = l_l_row
				end if
			end if
		Case "H"
			dw_requirement.SetFilter("qty_required >  qty_completed")
			dw_requirement.Filter()		
		Case "O"
			dw_requirement.SetFilter("quantity >  packline_qty")
			dw_requirement.Filter()		
	End Choose
Else
	Choose Case szQueue
		Case "D"
			if iDemandRow > 0 Then
				l_s_part 	= dw_requirement.GetItemString ( iDemandRow, "shipper_detail_part_original" )
				l_l_suffix	= dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_suffix" )
				l_l_shipper	= dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_shipper" )
				dw_requirement.SetFilter("")
				dw_requirement.Filter()		
				l_l_row = dw_requirement.Find ( "shipper_detail_part_original = '" + l_s_part + "' and shipper_detail_suffix = " + String ( l_l_suffix ) + " and shipper_detail_shipper = " + String ( l_l_shipper ), 1, dw_requirement.RowCount ( ) )
				if l_l_row > 0 then
					dw_requirement.SetRow ( l_l_row )
					dw_requirement.SelectRow ( 0, FALSE )
					dw_requirement.SelectRow ( l_l_row, TRUE )
					iDemandRow = l_l_row
				end if
			else
				dw_requirement.SetFilter("")
				dw_requirement.Filter()		
			end if
		Case "H"
			dw_requirement.SetFilter("")
			dw_requirement.Filter()		
		Case "O"
			dw_requirement.SetFilter("")
			dw_requirement.Filter()		
	End Choose
End If




end on

type lb_um from listbox within w_smart_job_completion_version2
boolean visible = false
integer x = 2080
integer y = 1856
integer width = 489
integer height = 356
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_suffix from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 41
integer y = 80
integer width = 1600
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cbx_stage from checkbox within w_smart_job_completion_version2
integer x = 2501
integer y = 1248
integer width = 361
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Auto Stage"
boolean lefttext = true
end type

on clicked;//String szAutoStage
//
//If this.checked then
//	szAutoStage	= 'Y'
//Else
//	szAutoStage = 'N'
//End If
end on

type sle_operation from statictext within w_smart_job_completion_version2
integer x = 1742
integer y = 1076
integer width = 1138
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Operation Mode"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_done from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 1733
integer y = 960
integer width = 306
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "DONE!"
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_percentage_value from statictext within w_smart_job_completion_version2
integer x = 1541
integer y = 808
integer width = 160
integer height = 44
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "0% "
boolean focusrectangle = false
end type

type st_percentage from statictext within w_smart_job_completion_version2
integer y = 820
integer width = 37
integer height = 36
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_show_cancel from commandbutton within w_smart_job_completion_version2
boolean visible = false
integer x = 1408
integer y = 656
integer width = 242
integer height = 108
integer taborder = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

on clicked;wf_show_object_info(FALSE)
end on

type cb_show_save from commandbutton within w_smart_job_completion_version2
boolean visible = false
integer x = 1129
integer y = 656
integer width = 242
integer height = 108
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

on clicked;If wf_valid_pallet(Long(sle_show_pallet.Text)) then
	wf_send_object_to_pallet(Long(sle_show_pallet.text), Long(sle_show_object.text))
	wf_show_object_info(FALSE)
	wf_show_visual_pallet(TRUE)		
End If
end on

type sle_show_pallet from singlelineedit within w_smart_job_completion_version2
boolean visible = false
integer x = 1129
integer y = 496
integer width = 489
integer height = 88
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_show_pallet from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 873
integer y = 496
integer width = 215
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Pallet"
boolean focusrectangle = false
end type

type sle_show_object from singlelineedit within w_smart_job_completion_version2
boolean visible = false
integer x = 1129
integer y = 368
integer width = 489
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;Long l_l_Serial
Long l_l_PalletSerial

l_l_Serial	= Long(this.text)

SELECT object.parent_serial  
  INTO :l_l_PalletSerial
  FROM object  
 WHERE object.serial = :l_l_Serial   ;

sle_show_pallet.text	= String(l_l_PalletSerial)


end event

type st_show_object from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 873
integer y = 368
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Object "
boolean focusrectangle = false
end type

type cb_show from commandbutton within w_smart_job_completion_version2
boolean visible = false
integer x = 727
integer y = 272
integer width = 1056
integer height = 544
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type ddlb_units from dropdownlistbox within w_smart_job_completion_version2
boolean visible = false
integer x = 256
integer y = 592
integer width = 453
integer height = 448
integer taborder = 130
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on selectionchanged;dw_part.SetItem(1, "um", this.text)
end on

type dw_temp from datawindow within w_smart_job_completion_version2
boolean visible = false
integer x = 1573
integer y = 1856
integer width = 489
integer height = 356
integer taborder = 160
string dataobject = "dw_external_temp"
boolean livescroll = true
end type

type ddlb_machine from dropdownlistbox within w_smart_job_completion_version2
integer x = 2048
integer y = 960
integer width = 654
integer height = 544
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
Datetime ldt_retrdate
szQueue	= wf_get_schedule_queue(this.text)

bSoftQueue	= FALSE
bHardQueue	= FALSE
bShipping	= FALSE

dDate = Date ( em_date.Text )

If szQueue = "I" Then
	ib_Timer = FALSE
	iCount						= 0
	dw_requirement.Reset ( )
	dw_requirement.DataObject = "dw_blank_dw_gray"
	st_6.Text = ""
	dw_requirement.Enabled = FALSE
	bShipping = FALSE
	bHardQueue = FALSE
	bSoftQueue = FALSE
	cbx_stage.Enabled = FALSE
ElseIf szQueue = "H" then
	ib_Timer = TRUE
	dw_requirement.DataObject 	= "dw_hard_queue_information"
	dw_requirement.Enabled = TRUE
	dw_requirement.SetTransObject(sqlca)
	st_6.Text = "Hard Queue Requirement"
	dw_requirement.Retrieve(this.text)
	bShipping = FALSE
	bSoftQueue = FALSE
	bHardQueue	= TRUE
	cbx_stage.Enabled = FALSE
Elseif szQueue = "O" Then
	ib_Timer = TRUE
	dw_requirement.Reset ( )
	dw_requirement.DataObject = "d_packline_order_detail_information"
	dw_requirement.SetTransObject(sqlca)
	st_6.Text = "Order Detail Requirement"
	dw_requirement.Retrieve(dDate)
	dw_requirement.Enabled = TRUE
	bShipping = FALSE
	bHardQueue = FALSE
	bSoftQueue = FALSE
	cbx_stage.Enabled = FALSE
Elseif szQueue = "F" Then
	ib_Timer = TRUE
	dw_requirement.Reset ( )
	dw_requirement.DataObject = "d_packline_order_detail_router_info"
	dw_requirement.SetTransObject(sqlca)
	st_6.Text = "Order Detail Router Requirement"
	dw_requirement.Retrieve(dDate)
	dw_requirement.Enabled = TRUE
	bShipping = FALSE
	bHardQueue = FALSE
	bSoftQueue = FALSE
	cbx_stage.Enabled = FALSE
Else
	ib_Timer = TRUE
	szQueue	= 'D'
	dw_requirement.DataObject 	= "dw_shipper_detail_destination_info"
	dw_requirement.Enabled = TRUE
	dw_requirement.SetTransObject(sqlca)
	st_6.Text = "Shipping Requirement (" + String ( dDate ) + ")"
// added 23 hours & 59 minutes so that it brings up everything for that day	
	ldt_retrdate = datetime(ddate,time("23:59:59")) 
	dw_requirement.Retrieve(ldt_retrdate)	
	bHardQueue = FALSE
	bSoftQueue = FALSE
	bShipping	= TRUE
	cbx_stage.Enabled = TRUE
End If

dw_part.Enabled = TRUE
dw_requirement.BringToTop	= TRUE
end event

on modified;bFirstTime	= FALSE
end on

type p_drag from picture within w_smart_job_completion_version2
boolean visible = false
integer x = 640
integer y = 2112
integer width = 110
integer height = 92
string dragicon = "BOX.ICO"
boolean enabled = false
string picturename = "box.bmp"
boolean focusrectangle = false
end type

type p_trash from picture within w_smart_job_completion_version2
integer x = 1733
integer y = 1168
integer width = 178
integer height = 160
string picturename = "trash.bmp"
boolean focusrectangle = false
end type

event dragdrop;Boolean 	bProcess
String	ls_Part, &
			s_TempPart, &
			ls_WorkOrder, &
			ls_Order, &
			ls_Null, &
			ls_ShipperDetailPart, &
         ls_kanban,&
			l_s_temp_part
Decimal	nQty
Long		l_Origin, &
			l_Row, &
			ll_Order, &
			ll_Suffix, &
			ll_ShipperDetailShipper

IF is_DragMode = "boxes_on_pallet" OR &
	is_DragMode = "visual_pallet" THEN
	bProcess = TRUE
ELSE
	bProcess	= bDragBox
END IF

If bDragPallet Then
	uo_boxes_on_pallet.dw_boxes_on_pallet.SetTransObject ( sqlca )
	uo_boxes_on_pallet.dw_boxes_on_pallet.Retrieve(iSerialDragged)
	If uo_boxes_on_pallet.dw_boxes_on_pallet.RowCount() > 0 then
		MessageBox(monsys.msg_title, "You must empty the pallet first", StopSign!)
		bDragPallet = FALSE
		Return
	Else
		If MessageBox(monsys.msg_title, "Sure to delete empty pallet " + String(iSerialDragged) + "?", Question!, YesNo!) = 1 then
			Delete from Object Where Serial = :iSerialDragged;
			If SQLCA.SQLCode = 0 then
				//Commit;
				dw_objects.DeleteRow(iObjectRow)			
			Else
				Rollback;				
				MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
			End If
		End If
		bDragPallet = FALSE
		Return
	End If
End If

If bProcess then
	IF is_DragMode = "visual_pallet" THEN
		iSerialDragged = uo_visual_pallet.il_Serial
		uo_visual_pallet.ib_DragObject = FALSE
	ELSEIF is_DragMode = "boxes_on_pallet" THEN
		iSerialDragged = uo_boxes_on_pallet.il_Serial
		uo_boxes_on_pallet.ib_DragObject = FALSE
	END IF

	IF szShipperPart > '' AND szQueue = 'D' THEN // included this check if it is packed against shipping requirement.
		SELECT	part
		INTO		:l_s_temp_part
		FROM 		object
		WHERE		serial = :iSerialDragged ;

		l_s_temp_part = f_get_string_value ( l_s_temp_part )

		IF l_s_temp_part > '' THEN
			IF l_s_temp_part <> szShipperPart THEN 
				rollback;
				RETURN
			end if 	
		END IF
	END IF

	If MessageBox(monsys.msg_title, "Sure to delete serial " + String(iSerialDragged), StopSign!, YesNo!) = 1 then
		dw_object_info.Retrieve(iSerialDragged)
		If dw_object_info.RowCount() > 0 then
			ls_Part		= dw_object_info.GetItemString(1, "part")
			nQty		= dw_object_info.GetItemNumber(1, "std_quantity")
			l_Origin	= Long ( f_get_string_value ( dw_object_info.GetItemString ( 1, "origin" ) ) )
			ll_Suffix 	= dw_object_info.GetItemNumber ( 1, "suffix" )
			ls_kanban	= dw_object_info.GetItemString(1, "kanban_number")

			dw_object_info.DeleteRow(1) 
			If dw_object_info.Update() < 1 then
				Rollback;
			Else
				//Commit;
				f_update_onhand(ls_Part, nQty, "-*")
				f_undo_audit_trail(iSerialDragged)
			End If
		Else
			MessageBox(monsys.msg_title, "Serial " + String(iSerialDragged) + " does not exist anymore", StopSIGN!)
		End If

		If bPallet then
			uo_boxes_on_pallet.dw_boxes_on_pallet.Retrieve(uo_boxes_on_pallet.il_PalletSerial)
			wf_show_visual_pallet(TRUE)
		Else		
			dw_objects.DeleteRow(iObjectRow)
		End If

		If bShipping AND l_Origin > 0 Then //iDemandRow > 0 then
			s_TempPart = ls_Part
			If iSuffix > 0 then
				szShipperPart	= wf_strip_off_suffix(ls_Part, iSuffix)
				s_TempPart = ls_Part + "-" + String ( iSuffix )
			End If
			nQtyCompleted	= wf_get_qty_packed(String(l_Origin), ls_Part)
			ll_ShipperDetailShipper = dw_requirement.GetItemNumber ( iDemandRow, "shipper_detail_shipper" )
			ls_ShipperDetailPart = dw_requirement.GetItemString ( iDemandRow, "shipper_detail_part" )
			If ( ll_ShipperDetailShipper <> l_Origin ) Or &
				( ls_ShipperDetailPart <> ls_Part ) Then
				if cbx_1.Checked then
					dw_requirement.SetFilter ( "" )
					dw_requirement.Filter ( )
				end if
				l_Row = dw_requirement.Find ( "shipper_detail_shipper = " + &
					String ( l_Origin ) + " and shipper_detail_part = '" + &
					s_TempPart +	"'", 1, dw_requirement.RowCount ( ) )
				If l_Row > 0 Then
					dw_requirement.SetItem ( l_Row, "shipper_detail_pack_line_qty", nQtyCompleted )
				End if

				If dw_requirement.Update ( ) = 1 Then //SQLCA.SQLCode = 0 Then
					//Commit ;
				Else
					RollBack ;
				End if
				if cbx_1.Checked then
					dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
					dw_requirement.Filter()		
					iDemandRow = dw_requirement.Find ( "shipper_detail_shipper = " + String ( ll_ShipperDetailShipper ) + &
										" and shipper_detail_part = '" + ls_ShipperDetailPart + "'", 1, &
										dw_requirement.RowCount ( ) )
				end if
			Else
				dw_requirement.SetItem(iDemandRow, "shipper_detail_pack_line_qty", nQtyCompleted)
				If dw_requirement.Update ( ) = -1 Then
					RollBack ;
				Else
					//Commit ;
				End if
			End if
		Elseif szQueue = 'H' Then
			nQtyCompleted	= wf_get_qty_packed(String(l_Origin), ls_Part)
			ls_WorkOrder = String ( l_Origin )

			l_Row = dw_requirement.Find ( "workorder = '" + &
				ls_WorkOrder + "' and part = '" + &
				ls_Part +	"'", 1, dw_requirement.RowCount ( ) )

			If l_Row > 0 Then
				dw_requirement.SetItem ( l_Row, "qty_completed", nQtyCompleted )
			End if

			If dw_requirement.Update ( ) = 1 Then //SQLCA.SQLCode = 0 Then
				//Commit ;
			Else
				RollBack ;
			End if
		Elseif szQueue = 'O' Then

			ll_Order = l_Origin
			ls_Order = String ( ll_Order )

			If ll_Suffix > 0 Then
				
				SELECT 	sum(std_quantity) 
				INTO 		:nQtyCompleted
				FROM		object
				WHERE 	part = :ls_Part and
							origin = :ls_Order and
							suffix = :ll_Suffix ;
	
				nQtyCompleted = f_get_value ( nQtyCompleted )

				l_Row = dw_requirement.Find ( "order_no = " + &
					ls_Order + " and part_number = '" + &
					ls_Part +	"' and mod_suffix = " + String ( ll_Suffix ),&
					1, dw_requirement.RowCount ( ) )
				If l_Row > 0 Then
					dw_requirement.SetItem ( l_Row, "packline_qty", nQtyCompleted )
				End if

			Else

				SELECT 	sum(std_quantity) 
				INTO 		:nQtyCompleted
				FROM		object
				WHERE 	part = :ls_Part and
							origin = :ls_Order and
							suffix is null ;
	
				nQtyCompleted = f_get_value ( nQtyCompleted )

				l_Row = dw_requirement.Find ( "order_no = " + &
					ls_Order + " and part_number = '" + &
					ls_Part +	"' and mod_suffix = 0" ,&
					1, dw_requirement.RowCount ( ) )
				If l_Row > 0 Then
					dw_requirement.SetItem ( l_Row, "packline_qty", nQtyCompleted )
				End if

			End if

			If dw_requirement.Update ( ) <> 1 Then 
				RollBack ;
			End if
		Elseif szQueue = 'F' Then
			dw_requirement.Retrieve ( dDate )
				If iSuffix > 0 Then
					l_Row = dw_requirement.Find ( "order_no = " + &
						String ( l_Origin ) + " and part_number = '" + &
						is_ParentPart + "' and mod_suffix = " + String ( iSuffix ) + &
						" and activity_router_part_number = '" + szPart + "'",&
						1, dw_requirement.RowCount ( ) )
				Else
					SetNull ( ls_Null )
					l_Row = dw_requirement.Find ( "order_no = " + &
						String ( l_Origin ) + " and part_number = '" + &
						is_ParentPart + "' and mod_suffix = 0" + &
						" and activity_router_part_number = '" + szPart + "'",&
						1, dw_requirement.RowCount ( ) )
				End if
			If l_Row > 0 Then
				dw_requirement.SelectRow ( 0, False )

				dw_requirement.SelectRow ( l_Row, True )
				dw_requirement.ScrollToRow ( l_Row )
			End if
		End If
	Else
		bDragBox		= FALSE
		bDragPallet	= FALSE
		is_DragMode = ""
		Return
	End If
End If

Commit ;

wf_update_kanban(ls_kanban)

//nQtyCompleted	= wf_get_qty_packed(String(l_Origin), szPart)

wf_draw_percentage(nQtyCompleted)

is_DragMode = ""
bDragBox		= FALSE
bDragPallet	= FALSE

Drag ( End! )


end event

type st_pallet from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2702
integer y = 1168
integer width = 165
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_serial41 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 1751
integer y = 48
integer width = 146
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial42 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 1897
integer y = 48
integer width = 133
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial43 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2025
integer y = 48
integer width = 128
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial44 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2176
integer y = 48
integer width = 133
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial45 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2304
integer y = 48
integer width = 128
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial46 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2446
integer y = 48
integer width = 133
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial47 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2574
integer y = 48
integer width = 151
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type st_serial48 from statictext within w_smart_job_completion_version2
boolean visible = false
integer x = 2738
integer y = 48
integer width = 151
integer height = 36
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "100000"
boolean focusrectangle = false
end type

type p_mode from picture within w_smart_job_completion_version2
integer x = 2519
integer y = 1168
integer width = 105
integer height = 80
string picturename = "box.bmp"
boolean focusrectangle = false
end type

event clicked;Long		l_Row
String	ls_Type

If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First", StopSign!)
	Return
End If

If bPallet then
	bPallet	= FALSE
	p_mode.PictureName			= "box.bmp"
	uo_boxes_on_pallet.Hide ( )
	wf_show_visual_pallet(FALSE)
	dw_requirement.Enabled = TRUE
	dw_part.SetItem ( 1, "field1", "" )
	iPalletSerial = 0
	cbx_visual_pallet.Enabled = FALSE
Else
	l_Row = dw_objects.GetRow ( )
	If l_Row < 1 Or Not dw_objects.IsSelected ( l_Row ) Then
		MessageBox(monsys.msg_title, "Please create or specify a pallet before continuing!")
	Else
		ls_Type = f_get_string_value ( dw_objects.GetItemString ( l_Row, "type" ) )
		If ls_Type <> "S" Then
			MessageBox(monsys.msg_title, "Please create or specify a pallet before continuing!")
			Return
		End if
		iObjectRow = l_row
		bPallet	= TRUE
		iPalletSerial = dw_objects.GetItemNumber ( l_Row, "serial" )
		p_mode.PictureName	= "pallet.bmp"
		uo_boxes_on_pallet.Show ( )
		uo_boxes_on_pallet.uf_setup ( TRUE, iPalletSerial )
		uo_boxes_on_pallet.BringToTop = TRUE
		dw_requirement.Enabled = FALSE
		dw_part.SetItem ( 1, "field1", String ( iPalletSerial ) )
		wf_show_visual_pallet(TRUE)
		cbx_visual_pallet.Enabled = TRUE
	End if
End If	
end event

type st_4 from statictext within w_smart_job_completion_version2
integer x = 2048
integer y = 1168
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Operation Mode"
boolean focusrectangle = false
end type

type dw_object_info from datawindow within w_smart_job_completion_version2
boolean visible = false
integer x = 18
integer y = 1472
integer width = 480
integer height = 768
integer taborder = 150
boolean titlebar = true
string dataobject = "dw_object_information"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_requirement from datawindow within w_smart_job_completion_version2
integer x = 1728
integer y = 112
integer width = 1152
integer height = 692
integer taborder = 50
string dataobject = "dw_shipper_detail_destination_info"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Int		i_Count
Boolean	lb_Clicked
String	ls_WorkOrder, &
			ls_OrderNo
Dec		ld_QtyCompleted
Long		ll_Order

If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First.", StopSign!)
	Return
End If

bUseImage					= FALSE

If ib_Refresh Then
	if row > 0 then iDemandRow = row // GetRow ( )
	If iDemandRow < 1 Then 
		ib_Refresh = FALSE
		Return
	ElseIf Not IsSelected ( iDemandRow ) Then 
		ib_Refresh = FALSE
		For i_Count = 1 to RowCount ( )
			If IsSelected ( i_Count ) Then
				iDemandRow = i_Count
				i_Count = RowCount ( )
			End if
		Next
	End if
Else
	lb_Clicked					= TRUE
	iDemandRow					= row
	iDemandCol					= this.GetClickedColumn()
End if

m_packline.m_operation.m_jobcompletion.Enabled	= TRUE

If iDemandRow > 0 then
	If lb_Clicked Then iPalletSerial = 0
	ib_Timer = TRUE
	If szQueue = "D" then
		iSalesOrder	= this.GetItemNumber(iDemandRow, "order_header_order_no")					
		If Not ib_Refresh Then 
			wf_set_part_info()
			dw_part.SetItem ( 1, "field1", "" )
		End if

		bShipping		= TRUE
		iSalesOrder		= this.GetItemNumber(iDemandRow, "order_header_order_no")
		iShipper			= this.GetItemNumber(iDemandRow, "shipper_detail_shipper")
		szDockCode		= this.GetItemString(iDemandRow, "order_header_dock_code")
		szLineFeedCode	= this.GetItemString(iDemandRow, "order_header_line_feed_code")
		szZoneCode		= this.GetItemString(iDemandRow, "order_header_zone_code")
		szCustomerPO	= this.GetItemString(iDemandRow, "order_header_customer_po")
		szShipperPart	= szPart
		iSuffix			= f_get_value ( this.GetItemNumber(iDemandRow, "shipper_detail_suffix") )
		nQtyPacked		= dw_requirement.GetItemNumber(iDemandRow, "shipper_detail_alternative_qty")	
		szShippingUM	= dw_requirement.GetItemString(iDemandRow, "shipper_detail_alternative_unit")		
		nQtyCompleted	= wf_get_qty_packed(String(iShipper), szShipperPart)
		szDestination	= this.GetItemString(iDemandRow, "destination_destination")
		st_part_info.text	= "Packing for: " + LeftA(this.GetItemString(iDemandRow, "destination_name"),20) + "  Shipper:" + String(iShipper)
		This.SetItem(iDemandRow, "shipper_detail_pack_line_qty", nQtyCompleted)
		nTotalQty			= this.GetItemNumber(iDemandRow, "shipper_detail_qty_required")

		wf_draw_percentage(nQtyCompleted)

		If Update ( ) = -1 Then
			Rollback ;
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
		Else
			Commit ;
		End if

		SelectRow(0, FALSE)
		SelectRow(iDemandRow, TRUE)
		SetRow ( iDemandRow )

	Elseif szQueue = "H" Then

		If Not ib_Refresh Then 
			wf_set_part_info()				//Set up part information
			dw_part.SetItem ( 1, "field1", "" )
		End if

//		iShipper 		= GetItemNumber ( iDemandRow, "workorder" )
//		ls_WorkOrder 	= String ( iShipper )

		ls_workorder = GetItemstring ( iDemandRow, "workorder" )


		SELECT 	Sum(std_quantity) 
		INTO		:nQtyCompleted
		FROM		object 
		WHERE 	origin = :ls_WorkOrder and
					part = :szPart ;

		SetItem ( iDemandRow, "qty_completed", nQtyCompleted )
		st_part_info.text	= "Packing for Work Order: " + GetItemString(iDemandRow, "workorder")
		nTotalQty		= GetItemNumber(iDemandRow, "qty_required")
		wf_draw_percentage(nQtyCompleted)

		If Update ( ) = -1 Then
			Rollback ;
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
		Else
			Commit ;
		End if

		SelectRow(0, FALSE)
		SelectRow(iDemandRow, TRUE)
		SetRow ( iDemandRow )

	Elseif szQueue = "O" Then
		If Not ib_Refresh Then 
			wf_set_part_info()				//Set up part information
			dw_part.SetItem ( 1, "field1", "" )
		End if

		ll_Order = GetItemNumber(iDemandRow, "order_no")
		ii_Sequence	= GetItemNumber ( iDemandRow, "order_detail_sequence" )
		iSuffix = f_get_value ( GetItemNumber ( iDemandRow, "order_detail_suffix" ) )
		iShipper = ll_Order
		ls_OrderNo = String ( ll_Order )

		If iSuffix > 0 Then
			SELECT 	Sum(std_quantity) 
			INTO		:nQtyCompleted
			FROM		object 
			WHERE 	origin = :ls_OrderNo and
						part = :szPart and 
						suffix = :iSuffix ;
		Else
			SELECT 	Sum(std_quantity) 
			INTO		:nQtyCompleted
			FROM		object 
			WHERE 	origin = :ls_OrderNo and
						part = :szPart and
						suffix is null ;
		End if
		SetItem ( iDemandRow, "packline_qty", nQtyCompleted )
		st_part_info.text	= "Packing for Order: " + ls_OrderNo
		nTotalQty		= GetItemNumber(iDemandRow, "quantity")
		wf_draw_percentage(nQtyCompleted)

		If Update ( ) = -1 Then
			Rollback ;
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
		Else
			Commit ;
		End if

		SelectRow(0, FALSE)
		SelectRow(iDemandRow, TRUE)
		SetRow ( iDemandRow )
	Elseif szQueue = "F" Then
		If Not ib_Refresh Then 
			wf_set_part_info()				//Set up part information
			dw_part.SetItem ( 1, "field1", "" )
		End if

		ll_Order = GetItemNumber(iDemandRow, "order_no")
		ii_Sequence	= GetItemNumber ( iDemandRow, "sequence" )
		iSuffix = f_get_value ( GetItemNumber ( iDemandRow, "suffix" ) )
		iShipper = ll_Order
		ls_OrderNo = String ( ll_Order )

		st_part_info.text	= "Packing for Order: " + ls_OrderNo
		nTotalQty		= GetItemNumber(iDemandRow, "quantity")

		SelectRow(0, FALSE)
		SelectRow(iDemandRow, TRUE)
		SetRow ( iDemandRow )
	End If

	If ib_Refresh Then ib_Refresh = FALSE

	If lb_Clicked And uo_boxes_on_pallet.Visible Then &
		p_mode.TriggerEvent ( clicked! )
	dw_objects.PostEvent ( "ue_refresh_requirement" )
Else
	SelectRow ( 0, False )
End If	
end event

on retrieveend;If cbx_1.Checked Then
	Choose Case szQueue
		Case "D"
			dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
			dw_requirement.Filter()		
		Case "H"
			dw_requirement.SetFilter("qty_required >  qty_completed")
			dw_requirement.Filter()		
		Case "O"
			dw_requirement.SetFilter("quantity >  packline_qty")
			dw_requirement.Filter()		
	End Choose
Else
	dw_requirement.SetFilter("")
	dw_requirement.Filter()		
End If

Sort ( )


end on

on updateend;//If cbx_1.Checked Then
//	Choose Case szQueue
//		Case "D"
//			dw_requirement.SetFilter("shipper_detail_qty_required >  shipper_detail_pack_line_qty")
//			dw_requirement.Filter()		
//		Case "H"
//			dw_requirement.SetFilter("qty_required >  qty_completed")
//			dw_requirement.Filter()		
//		Case "O"
//			dw_requirement.SetFilter("quantity >  packline_qty")
//			dw_requirement.Filter()		
//	End Choose
//Else
//	dw_requirement.SetFilter("")
//	dw_requirement.Filter()		
//End If
//
//If GetRow ( ) > 0 Then &
//	ScrollToRow ( GetRow ( ) )
//
//
end on

event doubleclicked;int	li_colnumber
string	ls_colname, ls_col
ls_col = dwo.name
ls_colname = LeftA ( ls_col, (LenA ( ls_col) - 2) )
if ls_colname > '' then
	dw_requirement.setsort ( ls_colname + " a" ) 
	dw_requirement.sort ( ) 
end if 	
end event

type sle_base from singlelineedit within w_smart_job_completion_version2
integer x = 1920
integer y = 880
integer width = 233
integer height = 52
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_smart_job_completion_version2
integer x = 1737
integer y = 876
integer width = 1138
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Machine"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_part from datawindow within w_smart_job_completion_version2
integer x = 14
integer y = 140
integer width = 1664
integer height = 656
integer taborder = 80
boolean enabled = false
string dataobject = "dw_external_part_info"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	s_null_value,&
			l_s_type
			
Long		l_l_serial,&
			l_l_shipper,&
			l_l_row, &
			iRow

bUseImage	= FALSE

SetNull(s_null_value)

Choose Case dwo.name
		
	Case "part"

		Boolean bOk = TRUE

		iCount = 0

		Timer ( 0, Parent )

		If bShipping then
			If MessageBox(monsys.msg_title, "Changing part number will make your packing for inventory instead of a shipper, are you sure you want to do this?", Question!, YesNo!) = 1 then
				SelectRow ( dw_requirement, 0, FALSE )
				bOk	= TRUE
				SetNull(iSuffix)
				szQueue = "I" 
				ib_Timer = FALSE
				iCount	= 0
				dw_requirement.Reset ( )
				dw_requirement.DataObject = "dw_blank_dw_gray"
				st_6.Text = ""
				dw_requirement.Enabled = FALSE
				bShipping = FALSE
				bHardQueue = FALSE
				bSoftQueue = FALSE
				cbx_stage.Enabled = FALSE
			Else
				bOk	= FALSE
			End If
		ElseIf szQueue = 'O' Or szQueue = 'F' then
			If MessageBox(monsys.msg_title, "Changing part number will make your packing for inventory instead of an order, are you sure you want to do this?", Question!, YesNo!) = 1 then
				SelectRow ( dw_requirement, 0, FALSE )
				bOk	= TRUE
				SetNull(iSuffix)
			Else
				bOk	= FALSE
			End If
		ElseIf szQueue = 'H' then
			If MessageBox(monsys.msg_title, "Changing part number will make your packing for inventory instead of a work order, are you sure you want to do this?", Question!, YesNo!) = 1 then
				SelectRow ( dw_requirement, 0, FALSE )
				bOk	= TRUE
				SetNull(iSuffix)
			Else

				bOk	= FALSE
			End If
		End If
		
		If bOk then
			If wf_valid_part(this.GetText()) then
				ib_Timer = FALSE
				st_part_info.Text	= "Packing for Inventory"
				bShipping			= FALSE
				setnull(iSuffix)
				bUseImage			= FALSE
				szPart				= this.GetText()
				st_suffix.visible	= FALSE
		
				wf_create_package_dropdown(szPart)
				wf_create_units_dropdown(szPart)
				dw_part.SetItem(1, "um", wf_get_um(szPart))
				dw_part.SetItem(1, "part", szPart)
				szCustomerPart	= szPart
				nTotalQty		= 0
				SetItem ( 1, "label", wf_get_std_label(szPart) )
			Else
				SetNull(szPart)
				Timer ( 0, Parent )
				MessageBox(monsys.msg_title, "Invalid Part Number", StopSign!)
			End If
		End If
	
		Timer ( 1, Parent )
		
	Case "packagetype"
		SetItem ( 1, "StandardPack", wf_get_std_pack ( data ) )
		SetItem ( 1, "Quantity", wf_get_std_pack ( data ) )

	Case "field1"
		If Trim ( GetText ( ) ) > "" then

			l_l_serial = Long ( GetText ( ) )

			SELECT	type,
						shipper
			INTO		:l_s_type,
						:l_l_shipper
			FROM		object
			WHERE		serial = :l_l_serial ;

			if f_get_string_value ( l_s_type ) <> 'S' then
				MessageBox ( monsys.msg_title, "This object is not a pallet!", StopSign! )
				return
			end if

			If bShipping Then
				if l_l_shipper <> iShipper then
					If iDemandRow > 0 And dw_requirement.IsSelected ( iDemandRow ) Then
						wf_attach_pallet_to_shipper ( l_l_serial )
					else
						wf_display_pallet ( l_l_serial )
					end if
				else
					l_l_row = dw_objects.Find ( "serial = " + String ( l_l_serial ), 1, dw_objects.RowCount ( ) )
					if l_l_row > 0 then
						dw_objects.SetRow ( l_l_row )
						dw_objects.SelectRow ( 0, FALSE )
						dw_objects.SelectRow ( l_l_row, TRUE )
						p_mode.TriggerEvent ( clicked! )
					else
						wf_display_pallet ( l_l_serial )
					end if
				end if
			Else
				wf_display_pallet ( Long ( GetText ( ) ) )
			End if
		End If

End Choose


end event

on itemfocuschanged;

end on

event clicked;If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First", StopSign!)
	Return
//else
//	wf_get_parts ( ) 
End If

end event

event constructor;SetTransObject ( SQLCA )
end event

type uo_boxes_on_pallet from u_boxes_on_pallet within w_smart_job_completion_version2
event ue_hide pbm_custom01
event ue_drag pbm_custom02
boolean visible = false
integer x = 14
integer y = 872
integer width = 1678
integer height = 536
integer taborder = 40
borderstyle borderstyle = stylelowered!
end type

on ue_hide;call u_boxes_on_pallet::ue_hide;bPallet							= FALSE
p_mode.picturename			= "box.bmp"
st_pallet.visible				= FALSE
This.Hide ( )
dw_part.SetItem ( 1, "field1", "" )
wf_show_visual_pallet(FALSE)
dw_requirement.Enabled		= TRUE
end on

on ue_drag;call u_boxes_on_pallet::ue_drag;bDragPallet = FALSE
is_DragMode = "boxes_on_pallet"

end on

on uo_boxes_on_pallet.destroy
call u_boxes_on_pallet::destroy
end on

type dw_objects from datawindow within w_smart_job_completion_version2
event ue_refresh_requirement pbm_custom01
integer x = 9
integer y = 948
integer width = 1687
integer height = 468
string dragicon = "BOX.ICO"
string dataobject = "dw_external_objects"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_refresh_requirement;Long	ll_Serial, &
	ll_ParentSerial, &
	ll_Row, &
	ll_TempSerial, &
	ll_rowcount, &
	ll_currow
	
String	ls_Part, &
	ls_Unit, &
	ls_Type, &
	ls_Origin
Dec	ldec_Qty, &
	ldec_StdQty, &
	ldec_Weight
datastore	lds_objectslist

lds_objectslist = create datastore
lds_objectslist.dataobject = 'd_msp_packlineobjectslist'
lds_objectslist.settransobject ( sqlca )
//sqlca.autocommit = true

//	Harish, the ls_Origin was being used uninitialized.
ls_Origin = String ( iShipper )
ll_rowcount = lds_objectslist.retrieve ( iShipper, ls_origin )
//sqlca.autocommit = false

/*
 DECLARE requirement_objects CURSOR FOR  
  SELECT object.serial,   
         object.part,   
         object.quantity,   
         object.unit_measure,   
         object.std_quantity,   
         object.weight,   
         object.type,
			object.parent_serial  
    FROM object  
   WHERE ( object.shipper = :iShipper )
	 UNION
  SELECT object.serial,   
         object.part,   
         object.quantity,   
         object.unit_measure,   
         object.std_quantity,   
         object.weight,   
         object.type,
			object.parent_serial  
    FROM object  
	 WHERE ( object.origin = :ls_Origin )   
ORDER BY 1 ASC  ;
*/

If RowCount ( ) > 0 Then
	If IsSelected ( GetRow ( ) ) Then
		If GetItemString ( GetRow ( ), "type" ) = "S" Then
			ll_TempSerial = GetItemNumber ( GetRow ( ), "serial" ) //ll_TempSerial )
		End if
	End if
Else
	ll_TempSerial = 0
End if

Reset ( )

ls_Origin = String ( iShipper )

/*
Open requirement_objects ;

Do
	Fetch requirement_objects into :ll_Serial,:ls_Part,:ldec_Qty,:ls_Unit,:ldec_StdQty,:ldec_Weight,:ls_Type, :ll_ParentSerial ;
	If SQLCA.SQLCode = 0 Then
		If f_get_value ( ll_ParentSerial ) = 0 Then
			ll_Row = InsertRow ( 0 )
			SetItem ( ll_Row, "serial", ll_Serial )
			SetItem ( ll_Row, "part", ls_Part )
			SetItem ( ll_Row, "qty", ldec_Qty )
			SetItem ( ll_Row, "um", ls_Unit )
			SetItem ( ll_Row, "std_quantity", ldec_StdQty )
			SetItem ( ll_Row, "weight", ldec_Weight )
			SetItem ( ll_Row, "type", ls_Type )
		End if
	End if
Loop While SQLCA.SQLCode = 0

Close requirement_objects ;
*/

for ll_currow = 1 to ll_rowcount
	ll_serial = lds_objectslist.object.serial [ ll_currow ]
	ls_part   = lds_objectslist.object.part [ ll_currow ]
	ldec_qty  = lds_objectslist.object.quantity [ ll_currow ]
	ls_Unit   = lds_objectslist.object.unit_measure [ ll_currow ]
	ldec_StdQty = lds_objectslist.object.std_quantity [ ll_currow ]
	ldec_Weight = lds_objectslist.object.weight [ ll_currow ]
	ls_type	    = lds_objectslist.object.type [ ll_currow ]
	ll_ParentSerial = lds_objectslist.object.parent_serial [ ll_currow ]
	
	If f_get_value ( ll_ParentSerial ) = 0 Then
		ll_Row = InsertRow ( 0 )
		SetItem ( ll_Row, "serial", ll_Serial )
		SetItem ( ll_Row, "part", ls_Part )
		SetItem ( ll_Row, "qty", ldec_Qty )
		SetItem ( ll_Row, "um", ls_Unit )
		SetItem ( ll_Row, "std_quantity", ldec_StdQty )
		SetItem ( ll_Row, "weight", ldec_Weight )
		SetItem ( ll_Row, "type", ls_Type )
	End if
next 

If ll_TempSerial > 0 Then
	ll_Row = Find ( "serial = " + String ( ll_TempSerial ), 1, RowCount ( ) )
	If ll_Row > 0 Then
		If GetItemNumber ( ll_Row, "serial" ) = ll_TempSerial Then
			iObjectRow = ll_row
			iPalletSerial = ll_TempSerial
			SelectRow ( ll_Row, TRUE )
		End if
	End if
End if

destroy lds_objectslist

end event

event clicked;Long iRow

if i_l_clicked_row > 0 then
	iRow = i_l_clicked_row
else
	iRow = this.GetClickedRow()
end if

iPalletSerial	= 0
iObjectRow		= 0

If bFirstTime then
	MessageBox(monsys.msg_title, "Please Select Machine First", StopSign!)
	Return
End If

If iRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)
	iObjectRow	= iRow
	If this.GetItemString(iRow, "type") = "S" then
		iPalletSerial 	= this.GetItemNumber(iRow, "serial")
		bDragPallet		= TRUE
		bDragBox			= FALSE
		this.DragIcon	= "pallet.ico"
		//If bPallet Then wf_show_visual_pallet ( TRUE )
	Else
		bDragPallet		= FALSE
		bDragBox			= TRUE
		this.DragIcon	= "box.ico"
	End if		
	if i_l_clicked_row > 0 then
		i_l_clicked_row = 0
	else
		this.Drag(begin!)
	end if
	iSerialDragged	= this.GetItemNumber(iRow, "serial")
Else
	SelectRow ( dw_objects, 0, False )
	If bPallet Then 
		bPallet = False
		wf_show_visual_pallet ( FALSE )
	End if
End If
end event

event doubleclicked;Long iRow

iRow	= this.getclickedrow()

bPallet	= FALSE

If iRow > 0 then
	If this.GetItemString(iRow, "type")	= "S" then
		iPalletSerial					= this.GetItemNumber(iRow, "serial")
		uo_boxes_on_pallet.uf_setup ( TRUE, iPalletSerial )
		uo_boxes_on_pallet.Visible = TRUE
		uo_boxes_on_pallet.BringToTop = TRUE
		dw_part.SetItem ( 1, "field1", String ( iPalletSerial ) )
		bPallet							= TRUE
		p_mode.PictureName			= "Pallet.bmp"		
		wf_show_visual_pallet(TRUE)	
		cbx_visual_pallet.Enabled = TRUE
		Yield ( )
		dw_part.Setfocus ( )
	Else
		MessageBox(monsys.msg_title, "No detail for box", StopSign!)
		p_mode.PictureName			= "Box.bmp"
	End If
End If
end event

on dragdrop;bDragPallet	= FALSE
bDragBox		= FALSE
end on

event constructor;DataWindowChild	ldwc_dddw

ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.Retrieve ( )
end event

type p_1 from picture within w_smart_job_completion_version2
integer x = 1202
integer y = 880
integer width = 55
integer height = 52
string picturename = "box.bmp"
boolean focusrectangle = false
end type

type st_2 from statictext within w_smart_job_completion_version2
integer x = 1280
integer y = 880
integer width = 96
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Box"
boolean focusrectangle = false
end type

type p_2 from picture within w_smart_job_completion_version2
integer x = 1408
integer y = 880
integer width = 55
integer height = 52
string picturename = "pallet.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_smart_job_completion_version2
integer x = 1477
integer y = 880
integer width = 119
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Pallet"
boolean focusrectangle = false
end type

type st_10 from statictext within w_smart_job_completion_version2
integer x = 14
integer y = 868
integer width = 1650
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Objects Generated"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_smart_job_completion_version2
integer x = 1714
integer y = 832
integer width = 1184
integer height = 228
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_3 from groupbox within w_smart_job_completion_version2
integer y = 832
integer width = 1705
integer height = 592
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_5 from groupbox within w_smart_job_completion_version2
integer x = 1714
integer y = 1040
integer width = 1184
integer height = 384
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_2 from groupbox within w_smart_job_completion_version2
integer x = 1714
integer width = 1184
integer height = 820
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_1 from groupbox within w_smart_job_completion_version2
integer width = 1705
integer height = 804
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type uo_visual_pallet from u_pallet_contents within w_smart_job_completion_version2
event ue_hide pbm_custom01
event ue_drag pbm_custom02
boolean visible = false
integer x = 1723
integer y = 36
integer width = 1166
integer height = 768
integer taborder = 90
end type

on ue_hide;call u_pallet_contents::ue_hide;bPallet							= FALSE
p_mode.picturename			= "box.bmp"
st_pallet.visible				= FALSE
uo_boxes_on_pallet.Hide ( )
dw_part.SetItem ( 1, "field1", "" )
wf_show_visual_pallet(FALSE)
dw_requirement.Enabled		= TRUE
end on

on ue_drag;call u_pallet_contents::ue_drag;is_DragMode = "visual_pallet"

end on

on uo_visual_pallet.destroy
call u_pallet_contents::destroy
end on

