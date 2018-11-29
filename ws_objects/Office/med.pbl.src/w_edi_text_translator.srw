$PBExportHeader$w_edi_text_translator.srw
$PBExportComments$(med)
forward
global type w_edi_text_translator from Window
end type
type dw_active_release from datawindow within w_edi_text_translator
end type
type dw_1 from datawindow within w_edi_text_translator
end type
type dw_formated_kanban from datawindow within w_edi_text_translator
end type
type dw_kanban_temp from datawindow within w_edi_text_translator
end type
type st_lastdate from statictext within w_edi_text_translator
end type
type st_idle from statictext within w_edi_text_translator
end type
type p_idle from picture within w_edi_text_translator
end type
type st_percentage from statictext within w_edi_text_translator
end type
type p_1 from picture within w_edi_text_translator
end type
type st_file from statictext within w_edi_text_translator
end type
type sle_file from singlelineedit within w_edi_text_translator
end type
type cb_popup from commandbutton within w_edi_text_translator
end type
type dw_blanket_orders from datawindow within w_edi_text_translator
end type
type dw_temp from datawindow within w_edi_text_translator
end type
type dw_order from datawindow within w_edi_text_translator
end type
type dw_release from datawindow within w_edi_text_translator
end type
type dw_formated_edi from datawindow within w_edi_text_translator
end type
type dw_message from datawindow within w_edi_text_translator
end type
type dw_exception from datawindow within w_edi_text_translator
end type
type dw_edi_log from datawindow within w_edi_text_translator
end type
type gb_6 from groupbox within w_edi_text_translator
end type
type gb_5 from groupbox within w_edi_text_translator
end type
type gb_4 from groupbox within w_edi_text_translator
end type
type gb_3 from groupbox within w_edi_text_translator
end type
type gb_2 from groupbox within w_edi_text_translator
end type
type gb_1 from groupbox within w_edi_text_translator
end type
end forward

global type w_edi_text_translator from Window
int X=0
int Y=0
int Width=2949
int Height=1580
boolean TitleBar=true
string Title="Monitor EDI Control Center"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event print_datawindow pbm_custom01
event save_exception pbm_custom02
event unattend_operation pbm_custom03
event edi_raw_data_processor pbm_custom04
event edi_overlay_builder pbm_custom05
event manual pbm_custom06
event stop_translation pbm_custom07
dw_active_release dw_active_release
dw_1 dw_1
dw_formated_kanban dw_formated_kanban
dw_kanban_temp dw_kanban_temp
st_lastdate st_lastdate
st_idle st_idle
p_idle p_idle
st_percentage st_percentage
p_1 p_1
st_file st_file
sle_file sle_file
cb_popup cb_popup
dw_blanket_orders dw_blanket_orders
dw_temp dw_temp
dw_order dw_order
dw_release dw_release
dw_formated_edi dw_formated_edi
dw_message dw_message
dw_exception dw_exception
dw_edi_log dw_edi_log
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_edi_text_translator w_edi_text_translator

type variables
Integer iModBase = 20      	//The Base No for MOD
Integer ii_Kanban_ModBase = 13
Long    iLastOrder = 0           //The last order processed
Long    iCurrentOrder            //The current blanket order
Long    iBlanketRow             //The row # for order header
Long    iLastOrderRow          //The row # for last order

Long &
	il_order_row, &
	il_order_no, &
	il_last_order, &
	il_last_order_row

Integer iDeleteFlag               //1: Deleted 862
                                          //2: Deleted 830
                                          //3: Deleted Both 
Integer iEDIProcessDays       //EDI process days

String   	szDestination          //To keep the destination
String   	szPart                    //To keep the part number
String   	szCustomerPart       //To keep the cust part # 
String   	szRelease              //To keep the release #
String   	szDock                  //To keep the dock code
String   	szdWinName          //To keep the data window name
String   	szModelYear	//To keep the model year
String   	szPO		//To keep the po
String   	szShipType	//'N':Normal  'D':Dropship
String   	szLineFeedCode	//Line feed code
String   	szZoneCode	//Zone code
String   	is_LastZoneCode
String   	is_LastDockCode
String   	is_LastLineFeed
STRING	is_Custom1Header, &
	is_Custom2Header, &
	is_Custom3Header, &
	is_Custom1Detail, &
	is_Custom2Detail, &
	is_Custom3Detail, &
	is_LastCust1Head, &
	is_LastCust2Head, &
	is_LastCust3Head
String   	is_Kanban[], &
	is_null[]		

Date     dDate
Date     dLastEDIDate           //Last date for EDI process
Date     id_fab_date, &
            id_raw_date
	
Decimal 	nQuantity, &
	ic_FabCum, &
	ic_RawCum

Long     iDelCount                 //Total # of releases to delete     
Long     iDelArray[]                //List of releases to be deleted

DataWindow dWin                //Current Datawindow

Boolean bNewRelease = TRUE  //Whether processed before
Boolean bDragException
Boolean bUOP            = FALSE
Boolean bBusy	     = FALSE
Boolean b830As862     = FALSE
Boolean bUpdtGlobal   = FALSE
Boolean ib_kanban	     = FALSE

st_generic_structure stParm

Int i_Flag
end variables

forward prototypes
public subroutine wf_convert (string szvalue, integer iseq)
public subroutine wf_setup ()
public subroutine wf_transfer_to_order (integer irow)
public subroutine wf_edi_log ()
public subroutine wf_updat_order (long iorder)
public subroutine wf_delete_old_release (string sztype)
public subroutine wf_add_to_blanket_release (long irow, string sztype)
public subroutine wf_delete_obsolete_releases ()
public subroutine wf_relcalc_release ()
public function decimal wf_get_value (decimal nValue)
public subroutine wf_reassign_sequence ()
public subroutine wf_delete_mps (long isalesorder, long irowid)
public subroutine wf_save_exception ()
public function string wf_get_date_value (integer iValue)
public subroutine wf_idle ()
public subroutine wf_read_text_file (string szfilename)
public function boolean wf_check_model_year (string szdestination)
public function date wf_last_date_for_edi_process ()
public function boolean wf_check_po (string szdestination)
public function boolean wf_830_as_862 (string szdestination)
public subroutine wf_from_formated_edi_to_release (ref datawindow dwwin)
public subroutine wf_convert_kanban (string as_value, integer ai_seq)
public subroutine wf_transfer_to_kanban (integer ai_row)
public subroutine wf_parsor_kanban ()
public subroutine wf_save_kanban_data (long al_order_row, long al_kanban_row)
end prototypes

on print_datawindow;Long ll_Job

If IsNull(dWin) then
	MessageBox ("Warning", "Please click data window first before printing", Stopsign!)
	Return
Else
	If MessageBox ("System Message", "Sure to print '" + szdWinName + "'", Question!, OkCancel!) = 2 then
		Return
	End If
End If

//ll_Job	= PrintOpen()
//PrintDataWindow(ll_Job, dWin)
//PrintClose(ll_Job)

// changed the print routine to be able print all the pages

dWin.Print()

gnv_App.of_GetFrame().SetMicroHelp("Printing completed .... ")
end on

on save_exception;If MessageBox("System Message", "Save exception data to EXCEPT.TXT", Question!, OkCancel!) = 1 then
	wf_save_exception()
	MessageBox("System Message", "Exception data has been saved", StopSign!)
End If
end on

on unattend_operation;bFinish	= TRUE
bUOP		= TRUE
Timer(0.5)

dw_message.InsertRow(1)
dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Start UOP")

wf_idle ( )

end on

on edi_raw_data_processor;Open(w_edi_raw_data_processor)

end on

on edi_overlay_builder;Open(w_edi_overlay_structure_builder)
end on

on manual;cb_popup.visible		= TRUE
st_file.visible		= TRUE
sle_file.visible		= TRUE
st_lastdate.visible	= TRUE
st_lastdate.text		= "Last Date for Process:" + String(dLastEdiDate)

sle_file.SetFocus()

end on

on stop_translation;bFinish	= TRUE
bUOP		= FALSE
Timer(0)
p_idle.visible	= FALSE
st_idle.visible= FALSE
dw_message.InsertRow(1)
dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Stop Translation / UOP")
end on

public subroutine wf_convert (string szvalue, integer iseq);String szLabel
String szYear
String szMonth
String szDay

Choose Case iSeq
	Case 0
		dw_formated_edi.InsertRow(1)
		dw_formated_edi.SetItem(1, "part", szValue)
		szLabel		= "part"
	Case 1
		dw_formated_edi.SetItem(1, "quantity", Dec(szValue))				
		szLabel		= "quantity"
	Case 2
		szYear		= MidA(szValue, 1, 2)
		szMonth		= MidA(szValue, 3, 2)
		szDay			= MidA(szValue, 5, 2)
		szValue		= szMonth + "/" + szDay + "/" + szYear	
		dw_formated_edi.SetItem(1, "date_stamp", Date(szValue))
		szLabel		= "date"
	Case 3
		dw_formated_edi.SetItem(1, "release_no", szValue)
		szLabel		= "release"
	Case 4
		dw_formated_edi.SetItem(1, "destination", szValue)
		szLabel		= "destination"
	Case 5
		dw_formated_edi.SetItem(1, "zone_code", szValue)
		szLabel		= "zone_code"
	Case 6
		dw_formated_edi.SetItem(1, "dock", szValue)
		szLabel		= "dock"
	Case 7
		dw_formated_edi.SetItem(1, "model_year", szValue)
		szLabel		= "model_year"
	Case 8
		dw_formated_edi.SetItem(1, "po", szValue)
		szLabel		= "po"
	Case 9
		dw_formated_edi.SetItem(1, "line_feed_code", szValue)
		szLabel		= "line_feed_code"
	Case 10
		dw_formated_edi.setitem(1, 'fab_cum', dec( szValue ) )
		szLabel		= 'fab_cum'

	Case	11
		dw_formated_edi.setitem(1, 'raw_cum', dec( szValue ) )
		szLabel		= 'raw_cum'

	Case 12
		if szValue > '' then
			szYear		= MidA(szValue, 1, 2)
			szMonth		= MidA(szValue, 3, 2)
			szDay			= MidA(szValue, 5, 2)
			szValue		= szMonth + "/" + szDay + "/" + szYear	
		else
			setnull( szValue )
		end if

		dw_formated_edi.SetItem(1, "fab_date", Date(szValue))
		szLabel		= "fab_date"

	Case 13

		if szValue > '' then
			szYear		= MidA(szValue, 1, 2)
			szMonth		= MidA(szValue, 3, 2)
			szDay			= MidA(szValue, 5, 2)
			szValue		= szMonth + "/" + szDay + "/" + szYear	
		else
			setnull( szValue )
		end if

		dw_formated_edi.SetItem(1, "raw_date", Date(szValue))
		szLabel		= "raw_date"

	CASE 14
		dw_formated_edi.setitem(1, 'custom1_header', szValue )
		szLabel		= 'custom1_header'

	CASE 15
		dw_formated_edi.setitem(1, 'custom2_header', szValue )
		szLabel		= 'custom2_header'

	CASE 16
		dw_formated_edi.setitem(1, 'custom3_header', szValue )
		szLabel		= 'custom3_header'

	CASE 17
		dw_formated_edi.setitem(1, 'custom1_detail', szValue )
		szLabel		= 'custom1_detail'

	CASE 18
		dw_formated_edi.setitem(1, 'custom2_detail', szValue )
		szLabel		= 'custom2_detail'

	CASE 19
		dw_formated_edi.setitem(1, 'custom3_detail', szValue )
		szLabel		= 'custom3_detail'

End Choose


end subroutine

public subroutine wf_setup ();Integer iRow


Update order_header set status = 'O' Where order_type = 'B' and (isnull(status,'O') <> 'C') ;

If SQLCA.SQLCode = -1 then
	Rollback;
	MessageBox("Warning", "Unable to set update flag", StopSign!)
	Return
Else
	Commit;
End If

dw_blanket_orders.Retrieve("B")
end subroutine

public subroutine wf_transfer_to_order (integer irow);Boolean 	bNewOrder
String	szCondition

szDestination 		= RightTrim(dw_formated_edi.GetItemString(iRow, "destination"))
szCustomerPart		= RightTrim(dw_formated_edi.GetItemString(iRow, "part"))
szRelease			= dw_formated_edi.GetItemString(iRow, "release_no")
szDock				= dw_formated_edi.GetItemString(iRow, "dock")
dDate					= dw_formated_edi.GetItemDate(iRow, "date_stamp")
nQuantity			= dw_formated_edi.GetItemNumber(iRow, "quantity")
szModelYear			= RightTrim(f_get_string_value(dw_formated_edi.GetItemString(iRow, "model_year")))
szPO					= RightTrim(f_get_string_value(dw_formated_edi.GetItemString(iRow, "po")))
szZoneCode			= dw_formated_edi.GetItemString(iRow, 'zone_code')
szLineFeedCode		= dw_formated_edi.GetItemString(iRow, 'line_feed_code')
ic_FabCum			= dw_formated_edi.GetItemNumber(iRow, 'fab_cum' )
ic_RawCum			= dw_formated_edi.GetItemNumber(iRow, 'raw_cum' )
id_fab_date			= dw_formated_edi.GetItemDate(iRow, 'fab_date' )
id_raw_date			= dw_formated_edi.GetItemDate(iRow, 'raw_date' )
is_Custom1Header		= dw_formated_edi.GetItemString ( iRow, 'custom1_header' )
is_Custom2Header		= dw_formated_edi.GetItemString ( iRow, 'custom2_header' )
is_Custom3Header		= dw_formated_edi.GetItemString ( iRow, 'custom3_header' )
is_Custom1Detail		= dw_formated_edi.GetItemString ( iRow, 'custom1_detail' )
is_Custom2Detail		= dw_formated_edi.GetItemString ( iRow, 'custom2_detail' )
is_Custom3Detail		= dw_formated_edi.GetItemString ( iRow, 'custom3_detail' )

szCondition			= "(destination = '" + RightTrim(szDestination) + "'" + ") AND " + &
			 			  "(customer_part = '" + RightTrim(szCustomerPart) + "'" + ")"

If wf_check_model_year(szDestination) then
	szCondition		= szCondition + " AND (model_year = '" + RightTrim(szModelYear) + "')"
End If

If wf_check_po(szDestination) then
	szCondition		= szCondition + " AND (customer_po = '" + RightTrim(szPO) + "')"
End If

iBlanketRow			= f_get_value(dw_blanket_orders.Find(szCondition, 1, dw_blanket_orders.RowCount()))

If iBlanketRow	 <= 0 then   							//Brand new part/destination
	szPart	= szCustomerPart
	wf_from_formated_edi_to_release(dw_exception)//Dump to exception datawindow
Else

	//Whether same order number as the last one
	iCurrentOrder	= dw_blanket_orders.GetItemNumber(iBlanketRow, "order_no")
	szPart			= dw_blanket_orders.GetItemString(iBlanketRow, "blanket_part")
	szShipType		= dw_blanket_orders.GetItemString(iBlanketRow, "ship_type")
	If IsNull(szShipType) then
		szShipType	= 'N'
	End If

	bNewOrder= (( iCurrentOrder <> iLastOrder ) AND (iLastOrder > 0))

	If (Not bNewOrder) then

		wf_from_formated_edi_to_release(dw_release)

	Else	//Start a new blanket order

		szDestination	= RightTrim(dw_blanket_orders.GetItemString(iLastOrderRow, "destination"))
		b830As862		= wf_830_as_862(szDestination)

		dw_active_release.SetFilter("sequence > 0")
		dw_active_release.Filter()
		wf_reassign_sequence()
		wf_updat_order(iLastOrder)
		dw_active_release.SetFilter("sequence > 0")
		dw_active_release.Filter()
		dw_active_release.SetSort("1a")	//Sort to delete all obsolet planning releases
		dw_active_release.Sort()
		wf_reassign_sequence()
		wf_delete_obsolete_releases()
		wf_reassign_sequence()
		dw_active_release.SetFilter("sequence > 0")
		dw_active_release.Filter()
		wf_relcalc_release()
		wf_reassign_sequence()
		
		//stParm.value1	= String(iLastOrder)
		//stParm.value2	= dw_blanket_orders.GetItemString(iLastOrderRow, "blanket_part")

		//OpenWithParm(w_calculate_committed_qty, stParm)

		dw_release.Reset()

		wf_from_formated_edi_to_release(dw_release)

	End If

	iLastOrder		= iCurrentOrder
	iLastOrderRow	= iBlanketRow
	is_LastZoneCode = szZoneCode
	is_LastDockCode	= szDock
	is_LastLineFeed	= szLineFeedCode
	is_LastCust1Head = is_Custom1Header
	is_LastCust2Head = is_Custom2Header
	is_LastCust3Head = is_Custom3Header
End If

wf_edi_log()							
end subroutine

public subroutine wf_edi_log ();Boolean bProcess

If dw_edi_log.RowCount() > 0 then
	If (dw_edi_log.GetItemString(1, "destination") 	= szDestination) &
		AND (dw_edi_log.GetItemString(1, "part")			= szPart) then
		bProcess	= FALSE
	Else
		bProcess	= TRUE
	End If
Else
	bProcess	= TRUE
End If
		
If bProcess then
	dw_edi_log.InsertRow(1)
	dw_edi_log.SetItem(1, "destination", szDestination)
	dw_edi_log.SetItem(1, "part", szPart)
	dw_edi_log.SetItem(1, "release_no", szRelease)
End If
end subroutine

public subroutine wf_updat_order (long iorder);Long iRow
Boolean b830

//Order status = 1:Deleted 862,  =2: Deleted 830,  =3: Deleted Both
	
dw_order.InsertRow(1)
dw_order.SetItem(1, "destination", dw_blanket_orders.GetItemString(iLastOrderRow, "destination"))
dw_order.SetItem(1, "part", dw_blanket_orders.GetItemSTring(iLastOrderRow, "blanket_part"))
dw_order.SetItem(1, "cust_part", dw_blanket_orders.GetItemString(iLastOrderRow, "customer_part"))
dw_order.SetItem(1, "order", dw_blanket_orders.GetItemNumber(iLastOrderRow, "order_no"))
iDeleteFlag	= Integer(dw_blanket_orders.GetItemString(iLastOrderRow, "status"))
dw_active_release.Reset()
dw_active_release.Retrieve(iOrder)

if szZoneCode > '' then
	dw_blanket_orders.SetItem(iLastOrderRow, "zone_code", is_LastZoneCode ) //szZoneCode)
end if

if szLineFeedCode > '' then
	dw_blanket_orders.SetItem(iLastOrderRow, "line_feed_code", is_LastLineFeed ) //szLineFeedCode)
end if

if szDock > '' then
	dw_blanket_orders.SetItem(iLastOrderRow, "dock_code", is_LastDockCode ) //szDock )
end if

if ic_FabCum > 0 then
	dw_blanket_orders.setitem( iLastOrderRow, 'fab_cum', ic_FabCum )
end if

if ic_RawCum > 0 then
	dw_blanket_orders.setitem( iLastOrderRow, 'raw_cum', ic_RawCum )
end if

if not( isnull( id_raw_date ) ) then
	dw_blanket_orders.setitem( iLastOrderRow, 'raw_date', id_raw_date )
end if

if not( isnull( id_fab_date ) ) then
	dw_blanket_orders.setitem( iLastOrderRow, 'fab_date', id_fab_date )
end if

dw_blanket_orders.SetItem ( iLastOrderRow, 'custom01', is_LastCust1Head )
dw_blanket_orders.SetItem ( iLastOrderRow, 'custom02', is_LastCust2Head )
dw_blanket_orders.SetItem ( iLastOrderRow, 'custom03', is_LastCust3Head )

For iRow = 1 to dw_release.RowCount()

	If b830As862 then
		b830	= FALSE
	Else
		b830	= (PosA(dw_release.GetItemString(iRow, "release_no"), "SET830") > 0)
	End If

	If b830 then
		If iDeleteFlag < 2 then
			wf_delete_old_release("P")			//Delete all old planning release
			If iDeleteFlag = 1 then
				iDeleteFlag	= 3					//Deleted both already
			Else
				iDeleteFlag	= 2					//Just deleted old 830
			End If
			
			dw_blanket_orders.SetItem(iLastOrderRow, "status", String(iDeleteFlag))
			If dw_blanket_orders.Update() > 0 then
				Commit;
			Else
				Rollback;
			End If 
		End If
		wf_add_to_blanket_release(iRow, "P")				
	Else
		If (iDeleteFlag <> 1) AND (iDeleteFlag <> 3) then
			wf_delete_old_release("F")		//Delete all old planning release
			If iDeleteFlag = 2 then
				iDeleteFlag	= 3					//Deleted both already
			Else
				iDeleteFlag	= 1					//Just deleted old 862
			End If
			dw_blanket_orders.SetItem(iLastOrderRow, "status", String(iDeleteFlag))
			If dw_blanket_orders.Update() > 0 then
				Commit;
			Else
				Rollback;
			End If 
		End If
		wf_add_to_blanket_release(iRow, "F")
	End If
Next

//If dw_active_release.Update(FALSE, TRUE) > 0 then
If dw_active_release.Update( ) > 0 then
	Commit;
Else
	Rollback;
End If

dw_release.Reset()

end subroutine

public subroutine wf_delete_old_release (string sztype);Long iRow

dw_active_release.SetFilter("type = '" + szType + "'")
dw_active_release.Filter()

iRow 	= dw_active_release.RowCount()

Do While iRow > 0 
	wf_delete_mps(iLastOrder, dw_active_release.GetItemNumber(1, "row_id"))
	dw_active_release.DeleteRow(1)
	iRow	= dw_active_release.RowCount()
Loop

If dw_active_release.Update(FALSE, TRUE) > 0 then
	Commit;
Else
	Rollback;
End If	

//Reassign the sequence number for releases
dw_active_release.Retrieve(iLastOrder)

For iRow = 1 to dw_active_release.RowCount()
	dw_active_release.SetItem(iRow, "sequence", iRow)
Next

If dw_active_release.Update() > 0 then	
	Commit;
Else
	Rollback;
End If

	
end subroutine

public subroutine wf_add_to_blanket_release (long irow, string sztype);String  szRelease
Integer iLen
Long    nSequence

Randomize(0)

dw_active_release.SetFilter("sequence > 0")
dw_active_release.Filter()

dw_active_release.InsertRow(1)
dw_active_release.SetItem(1, "order_no", iLastOrder)
nSequence	= Rand(30767)
Randomize(0)
nSequence	= nSequence + Rand(30767)

dw_active_release.SetItem(1, "sequence", 2000 + nSequence)
dw_active_release.SetItem(1, "part_number", dw_release.GetItemString(iRow, "part"))
dw_active_release.SetItem(1, "destination", szDestination)
dw_active_release.SetItem(1, "flag", 1)
dw_active_release.SetItem(1, "row_id", Rand(32767))
dw_active_release.SetItem(1, "committed_qty", 0)
dw_active_release.SetItem(1, "custom01", is_Custom1Detail )
dw_active_release.SetItem(1, "custom02", is_Custom2Detail )
dw_active_release.SetItem(1, "custom03", is_Custom3Detail )

If dw_blanket_orders.GetItemString(iLastOrderRow, "artificial_cum") = "A" then
	dw_active_release.SetItem(1, "the_cum", dw_release.GetItemNumber(iRow, "quantity"))
Else
	dw_active_release.SetItem(1, "quantity", dw_release.GetItemNumber(iRow, "quantity"))
End If

dw_active_release.SetItem(1, "due_date", dw_release.GetItemDate(iRow, "date_stamp"))

If szType	= "P" then		//If this is planning
	iLen		= LenA(RightTrim(dw_release.GetItemString(iRow, "release_no")))
	szRelease= RightA(dw_release.GetItemString(iRow, "release_no"), 6)
Else
	If b830as862 then
		iLen		= LenA(RightTrim(dw_release.GetItemString(iRow, "release_no")))
		szRelease= RightA(dw_release.GetItemString(iRow, "release_no"), 6)
	Else
		szRelease= dw_release.GetItemString(iRow, "release_no")
	End If
End If

dw_active_release.SetItem(1, "release_no", szRelease)	
dw_active_release.SetItem(1, "type", szType)
dw_active_release.SetItem(1, "week_no", f_get_week_no(dw_release.GetItemDate(iRow, "date_stamp")))
dw_active_release.SetItem(1, "ship_type", szShipType)
end subroutine

public subroutine wf_delete_obsolete_releases ();Long    iRow
Boolean bDone

iRow	= dw_active_release.RowCount() 

//Found the last firm release in blanket order
Do while (Not bDone) AND (iRow >= 1) 
	If dw_active_release.GetItemString(iRow, "type") = "F" then
		bDone	= TRUE			
	Else
		iRow	= iRow - 1
	End If
Loop

If iRow > 0 then
	dw_active_release.SetFilter("(sequence < " + String(iRow)+ ")" + &
											"AND (type = 'P')")
	dw_active_release.Filter()
	Do while dw_active_release.RowCount() > 0 
		wf_delete_mps(iLastOrder, dw_active_release.GetItemNumber(1, "row_id"))
		dw_active_release.DeleteRow(1)
	Loop
	If dw_active_release.Update(False, TRUE) > 0 then
		Commit;
	Else
		Rollback;
	End If
End If
		

end subroutine

public subroutine wf_relcalc_release ();//************************************************************************
//* Declaration
//************************************************************************
Long iTotalRow
Long iRow
Long iReleaseRow
Long iOrder

Boolean bDelete
Boolean bConvert

Decimal nOurCum
Decimal nTheCum
Decimal nNetQty
Decimal nStdQty
Decimal nRatio

String  szShippingUnit
String  szPart

//************************************************************************
//* Initialization
//************************************************************************

For iRow = 1 to iDelCount
	iDelArray[iRow] = 0
Next 

iDelCount 	= 0

iOrder			= dw_blanket_orders.GetItemNumber(iLastOrderRow, "order_no")
szShippingUnit	= f_get_order_info(iOrder, "SHIPPING UNIT")
szPart			= f_get_order_info(iOrder, "BLANKET PART")

bConvert			= (Not IsNull(szShippingUnit)) AND &
					  (f_get_string_value(szShippingUnit) <> f_get_part_info(szPart, "STANDARD UNIT"))

If bConvert then
	nRatio		= f_convert_units(szShippingUnit, "", szPart, 1)
Else
	nRatio		= 1
End If

//************************************************************************
//* Main Routine
//************************************************************************

iTotalRow = dw_active_release.RowCount()

dw_active_release.SelectRow(0, FALSE)
dw_active_release.SetSort("1a")
dw_active_release.Sort()

For iRow = 1 to dw_active_release.RowCount()

	If iRow = 1 then
		nOurCum 	= wf_get_value(dw_blanket_orders.GetItemNumber(iLastOrderRow, "our_cum"))
	Else
		nOurCum	= nTheCum
	End If

	If dw_blanket_orders.GetItemString(iLastOrderRow, "artificial_cum") = "N" then
		nNetQty = wf_get_value(dw_active_release.GetItemNumber(iRow, "quantity"))
		nTheCum = nOurCum + nNetQty
		nStdQty	= nNetQty * nRatio
		dw_active_release.SetItem(iRow, "std_qty", nStdQty)
	Else
		nTheCum = wf_get_value(dw_active_release.GetItemNumber(iRow, "the_cum"))
		nNetQty = nTheCum - nOurCum
		If nNetQty <= 0 then				//Send to DelArray
			nTheCum							= nOurCum
			iDelArray[iDelCount + 1]	= iRow
			iDelCount						= iDelCount + 1
		Else
			nStdQty	= nNetQty * nRatio
			dw_active_release.SetItem(iRow, "std_qty", nStdQty)
		End If
	End If
	
	dw_active_release.SetItem(iRow, "quantity", nNetQty)
	dw_active_release.SetItem(iRow, "our_cum",  nOurCum)
	dw_active_release.SetItem(iRow, "the_cum",  nTheCum)

Next 

For iRow = iDelCount to 1 Step -1
	iReleaseRow	= iDelArray[iRow]
	dw_active_release.DeleteRow(iReleaseRow)
Next	

If dw_active_release.Update() > 0 then
	Commit;
	dw_active_release.Retrieve(iLastOrder)
Else
	RollBack;
End If



end subroutine

public function decimal wf_get_value (decimal nValue);If IsNull(nValue) then
	Return 0
Else
	Return nValue
End If
end function

public subroutine wf_reassign_sequence ();Integer iRow

For iRow 	= 1 to dw_active_release.RowCount() 
	dw_active_release.SetItem(iRow, "sequence", iRow)
Next

If dw_active_release.Update() > 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_delete_mps (long isalesorder, long irowid);String szSalesOrder
String szRowId

szSalesOrder = String(iSalesOrder)
szRowId      = String(iRowId)

//------------------------ Delete the old MPS ---------------------------
DELETE FROM master_prod_sched			   	//Before accecess, wipe out all
WHERE ( origin = :szSalesOrder) AND       //old stuff
      ( source = :szRowId)   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If
end subroutine

public subroutine wf_save_exception ();Long iRow
Long iCol

Integer iFileNo

String szYear
String szMOnth
String szDay

iFileNo	= FileOpen("except.txt", LineMode!, Write!,	Shared!, Replace!) 

If iFileNo	= -1 then
	MessageBox("System Message", "Could not open EXCEPT.TXT", StopSign!)
	Return

Else

	For iRow = 1 to dw_exception.RowCount()
		w_edi_text_translator.SetMicroHelp(String(Truncate(100 * iRow / dw_exception.RowCount(), 0 )) + "% processed")
		If RightTrim(dw_exception.GetItemString(iRow, "part")) > " " then 
			FileWrite(iFileNo, f_get_string_value(dw_exception.GetItemString(iRow, "part")))	
			FileWrite(iFileNo, f_get_string_value(String(dw_exception.GetItemNumber(iRow, "quantity"))))

			szYear 	= RightA(wf_get_date_value(year(dw_exception.GetItemDate(iRow, "date_stamp"))) , 2)
			szMonth 	= wf_get_date_value(month(dw_exception.GetItemDate(iRow, "date_stamp")))
			szDay 	= wf_get_date_value(day(dw_exception.GetItemDate(iRow, "date_stamp")))
			FileWrite(iFileNo, f_get_string_value(szYear + szMonth + szDay))

			FileWrite(iFileNo, f_get_string_value(dw_exception.GetItemString(iRow, "release_no")))

			FileWrite(iFileNo, f_get_string_value(dw_exception.GetItemString(iRow, "destination")))

			FileWrite(iFileNo, f_get_string_value(dw_exception.GetItemString(iRow, "zone_code")))

			FileWrite(iFileNo, f_get_string_value(dw_exception.GetItemString(iRow, "dock")))

		End If

	Next

	FileClose(iFileNo)
				 	
End If
end subroutine

public function string wf_get_date_value (integer iValue);If iValue >= 10 then
	Return String(iValue)
Else
	Return '0' + String(iValue)
End If
end function

public subroutine wf_idle ();STRING	ls_dummy
Long x, y
Randomize(0)
TIME	lt_Now

p_idle.visible	= TRUE
st_idle.visible= TRUE

x		= p_idle.x + (50 - Rand(100))
y		= p_idle.y + (50 - Rand(100))

Move(p_idle, x, y)
Move(st_idle, x - 125, y + 120)
st_idle.textcolor	= 10000 * Rand(37000)

lt_Now = Now ( )
IF ( Mod ( Minute ( lt_Now ), 15 ) = 0 ) AND ( Second ( lt_Now ) = 0 ) THEN
	SELECT company_name
	  INTO :ls_dummy
	  FROM parameters;
END IF
//If cbx_sound.checked then 
//	Beep(1)
//End If


end subroutine

public subroutine wf_read_text_file (string szfilename);Long		iRow		//The current row number
Long   	iCol		//The current col number
Boolean 	bDone		//Whether end the loop

Timer(0)
dw_formated_edi.Reset()
dw_release.Reset()

bFinish						= FALSE
st_percentage.visible	= TRUE

If bNewRelease then
	dw_kanban_temp.reset()
	dw_kanban_temp.ImportFile( monsys.root + '\Kanban.txt', 1, 999999, 1, 999999, 1 )
	ib_kanban	= ( dw_kanban_temp.rowcount() > 0 )

	dw_temp.Reset()
	dw_temp.ImportFile(szFileName, 1, 999999, 1, 999999, 1)

	For iRow = 1 to dw_temp.RowCount()
		st_percentage.text	= String(Truncate(100 * iRow / dw_temp.RowCount(), 0)) + "% done"	
		wf_convert(dw_temp.GetItemString(iRow, 1), Mod(iRow - 1, iModBase))
		Yield()
		If bFinish then
			If MessageBox("Warning", "Stop button has been clicked! Stop process now", StopSign!, YesNo!) = 1 then
				iRow	= dw_temp.RowCount() + 1
				w_edi_text_translator.TriggerEvent('stop_translation')
			Else
				bFinish	= FALSE
			End If
		End If
	Next

	if (not bFinish) and ib_kanban then
		For iRow = 1 to dw_kanban_temp.rowcount()
			st_percentage.text	= 	String(Truncate(100 * iRow / &
											dw_kanban_temp.RowCount(), 0)) + "% done"	
			wf_convert_kanban(dw_kanban_temp.GetItemString(iRow, 1), Mod(iRow - 1, ii_Kanban_ModBase))
			Yield()
			If bFinish then
				If MessageBox("Warning", "Stop button has been clicked! Stop process now", StopSign!, YesNo!) = 1 then
					iRow	= dw_kanban_temp.RowCount() + 1
					this.TriggerEvent('stop_translation')
				Else
					bFinish	= FALSE
				End If
			End If
		Next			
	end if
Else
	For iRow	= 1 to dw_exception.RowCount()

		st_percentage.text	= String(Truncate(100 * iRow / dw_exception.RowCount(), 0)) + "% done"	

		dw_formated_edi.InsertRow(1)

		For iCol = 1 to 7 

			If iCol	= 3 then
				dw_formated_edi.SetItem(1, iCol, dw_exception.GetItemDate(iRow, iCol))
			Else
				If iCol	= 4 then
					dw_formated_edi.SetItem(1, iCol, dw_exception.GetItemNumber(iRow, iCol))
				Else
					dw_formated_edi.SetItem(1, iCol, dw_exception.GetItemString(iRow, iCol))
				End If
			End If
		Next

		Yield()
		If bFinish then
			If MessageBox("Warning", "Stop button has been clicked! Stop process now", StopSign!, YesNo!) = 1 then
				iRow	= dw_exception.RowCount() + 1
				w_edi_text_translator.TriggerEvent('stop_translation')
			Else
				bFinish	= FALSE
			End If
		End If

	Next

	dw_exception.Reset()

End If

If Not bFinish then

	if ib_kanban then
		wf_parsor_kanban()
	end if

	bNewRelease	= FALSE

	dw_formated_edi.SetSort("destination a, part a, model_year a")
	dw_formated_edi.Sort()
	dw_formated_edi.SelectRow(0, FALSE)
	
	p_1.visible					= TRUE
	st_percentage.visible	= TRUE
	iLastOrder					= 0
	iCurrentOrder				= 0
	iLastOrderRow				= 0


	For iRow = 1 to dw_formated_edi.RowCount()
		p_1.y	= dw_formated_edi.y + (dw_formated_edi.Height * iRow / dw_formated_edi.RowCount()) - p_1.height
		st_percentage.text	= String(Truncate(100 * iRow / dw_formated_edi.RowCount(), 0)) + "% done"	
		If dw_formated_edi.GetItemDate(iRow, "date_stamp") <= dLastEdiDate then
			wf_transfer_to_order(iRow)
		End If
		Yield()
		If bFinish then
			If MessageBox("Warning", "Stop button has been clicked! Stop process now", StopSign!, YesNo!) = 1 then
				iRow	= dw_formated_edi.RowCount() + 1
			Else
				bFinish	= FALSE
			End If
		End If
	Next

	If (Not bFinish) then
	
		p_1.visible	= FALSE
		st_percentage.visible	= FALSE

		If iLastOrderRow > 0 then
			szDestination	= dw_blanket_orders.GetItemString(iLastOrderRow, "destination")
			iLastOrder		= dw_blanket_orders.GetItemNumber(iLastOrderRow, "order_no")
			b830As862		= wf_830_as_862(szDestination)

			wf_updat_order(iLastOrder)		//Process the last release in the datawindow
			dw_active_release.SetFilter("sequence > 0")
			dw_active_release.Filter()

			dw_active_release.SetSort("1a")	//Sort to delete all obsolet planning releases
			dw_active_release.Sort()

			wf_reassign_sequence()
			wf_delete_obsolete_releases()
			dw_active_release.SetFilter("sequence > 0")
			dw_active_release.Filter()
			wf_relcalc_release()
			wf_reassign_sequence()

		End If

	End If

End If

end subroutine

public function boolean wf_check_model_year (string szdestination);szDestination	= RightTrim(szDestination)

String szCheck

  SELECT edi_setups.check_model_year  
    INTO :szCheck  
    FROM edi_setups  
   WHERE edi_setups.destination = :szDestination   ;

If szCheck = "Y" then
	Return TRUE
Else
	Return FALSE
End If
end function

public function date wf_last_date_for_edi_process ();Integer iDays

SetNull(iDays)

SELECT parameters.edi_process_days  
  INTO :iDays  
  FROM parameters  ;

If IsNull(iDays) then
	iDays	= 365
End If

Return RelativeDate(Today(), iDays)
end function

public function boolean wf_check_po (string szdestination);szDestination	= RightTrim(szDestination)

String szCheck

  SELECT edi_setups.check_po  
    INTO :szCheck  
    FROM edi_setups  
   WHERE edi_setups.destination = :szDestination   ;

If szCheck = "Y" then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_830_as_862 (string szdestination);String szFlag

  SELECT edi_setups.release_flag  
    INTO :szFlag  
    FROM edi_setups  
   WHERE edi_setups.destination = :szDestination   ;

Return (szFlag = 'F')
end function

public subroutine wf_from_formated_edi_to_release (ref datawindow dwwin);dwWin.InsertRow(1)
dwWin.SetItem(1, "destination", 		szDestination)
dwWin.SetItem(1, "part",				szPart)
dwWin.SetItem(1, "quantity", 			nQuantity)
dwWin.SetItem(1, "release_no",  		szRelease)
dwWin.SetItem(1, "date_stamp",		dDate)
dwWin.SetItem(1, "dock",				szDock)
dwWin.SetItem(1, "zone_code", 		szZoneCode) 
dwWin.SetItem(1, "line_feed_code",	szLineFeedCode) 
dwWin.SetItem(1, "custom1_header", is_Custom1Header )
dwWin.SetItem(1, "custom2_header", is_Custom2Header )
dwWin.SetItem(1, "custom3_header", is_Custom3Header )
dwWin.SetItem(1, "custom1_detail", is_Custom1Detail )
dwWin.SetItem(1, "custom2_detail", is_Custom2Detail )
dwWin.SetItem(1, "custom3_detail", is_Custom3Detail )
end subroutine

public subroutine wf_convert_kanban (string as_value, integer ai_seq);String &
	as_label, &
	as_year, &
	as_month, &
	as_day

choose case TRUE

	case ai_seq = 0
		dw_formated_kanban.insertRow(1)
		dw_formated_kanban.setitem(1, "part", as_value)
		as_label		= "part"

	case ai_seq = 1
		dw_formated_kanban.setitem(1, "destination", as_value)
		as_label		= "destination"

	case ai_seq	= 2
		dw_formated_kanban.setitem(1, "model_year", as_value)
		as_label		= "model_year"

	case ai_seq	= 3
		dw_formated_kanban.setitem( 1, "po", as_value )
		as_label		= "po"

	case ai_seq = 4
		dw_formated_kanban.setitem( 1, 'begin_kanban', as_value )

	case ai_seq = 5
		dw_formated_kanban.setitem( 1, 'end_kanban', as_value )

	case ai_seq	>= 6 and ai_seq <= ii_kanban_modbase 
		if LeftA( as_value, 3 ) > '' then
			dw_formated_kanban.setitem( 1, "s" + LeftA( as_value, 2 ) + 'z', as_value )
		end if

end choose




end subroutine

public subroutine wf_transfer_to_kanban (integer ai_row);Boolean 	lb_new_order
String	ls_condition, &
			ls_destination, &
			ls_customer_part, &
			ls_model_year, &
			ls_po, &
			ls_part, &
			ls_ship_type, &
			ls_begin_kanban, &
			ls_end_kanban


ls_destination 		= RightTrim(dw_formated_kanban.GetItemString(ai_row, "destination"))
ls_customer_part		= RightTrim(dw_formated_kanban.GetItemString(ai_row, "part"))
ls_model_year			= RightTrim(f_get_string_value(dw_formated_kanban.GetItemString(ai_row, "model_year")))
ls_po						= RightTrim(f_get_string_value(dw_formated_kanban.GetItemString(ai_row, "po")))
ls_begin_kanban		= dw_formated_kanban.GetItemString( ai_row, 'begin_kanban' )
ls_end_kanban			= dw_formated_kanban.GetItemString( ai_row, 'end_kanban' )

ls_condition			= 	"(destination = '" + RightTrim(ls_destination) + "'" + ") AND " + &
			 			  		"(customer_part = '" + RightTrim(ls_customer_part) + "'" + ")"

if wf_check_model_year(ls_destination) then
	ls_condition		= ls_condition + " AND (model_year = '" + RightTrim(ls_model_year) + "')"
end if

if wf_check_po(ls_destination) then
	ls_condition		= ls_condition + " AND (customer_po = '" + RightTrim(szPO) + "')"
end if

il_order_row			= f_get_value(dw_blanket_orders.Find(ls_condition, 1, dw_blanket_orders.RowCount()))

If il_order_row	 <= 0 then   							//Brand new part/destination
	ls_part	= ls_customer_part
	//wf_from_formated_edi_to_release(dw_exception)	//Dump to exception datawindow
Else
	//find a matching order
	wf_save_kanban_data( il_order_row, ai_row )
End If

//wf_edi_log()							
end subroutine

public subroutine wf_parsor_kanban ();long	&
	ll_row

dw_formated_kanban.setsort( "destination a, part a, model_year a" )
dw_formated_kanban.sort()
dw_formated_kanban.selectRow( 0, FALSE )
	
il_last_order			= 0
il_order_no				= 0
il_last_order_row		= 0

for ll_row = 1 to dw_formated_kanban.rowcount()
	wf_transfer_to_kanban(ll_row)
	Yield()
	if bFinish then
		if messagebox("Warning", "Stop button has been clicked! Stop process now", StopSign!, YesNo!) = 1 then
			ll_row	= dw_formated_kanban.RowCount() + 1
		else
			bFinish	= FALSE
		end If
	end If
next


end subroutine

public subroutine wf_save_kanban_data (long al_order_row, long al_kanban_row);string 	ls_line, &
			ls_begin_kanban, &
			ls_end_kanban

integer	li_ptr
					
for li_ptr = 11 to 17
	ls_line	= dw_formated_kanban.getitemstring( &
								al_kanban_row, 's' + string( li_ptr ) + 'z' )	
	ls_line	= trim(RightA( ls_line, LenA( ls_line ) - 3 ))
	dw_blanket_orders.setitem(al_order_row, &
							 'line' + string( li_ptr ) , ls_line )	
next

ls_begin_kanban	= dw_formated_kanban.getitemstring( al_kanban_row, &
																		'begin_kanban' )
ls_end_kanban		= dw_formated_kanban.getitemstring( al_kanban_row, &
																		'end_kanban' )

dw_blanket_orders.setitem( al_order_row, &
						'begin_kanban_number', trim(ls_begin_kanban) )

dw_blanket_orders.setitem( al_order_row, &
						'end_kanban_number', trim(ls_end_kanban) )

if dw_blanket_orders.update() > 0 then
	COMMIT;		
else
	ROLLBACK;
end if


									

end subroutine

event timer;Long iRow
Long l_Handle

STRING	ls_EDI_Path, &
		ls_MonitorINIPath

ls_MonitorINIPath = monsys.root + '\monitor.ini'
IF NOT FileExists ( ls_MonitorINIPath ) THEN
	ls_MonitorINIPath = 'c:\windows\monitor.ini'
	IF NOT FileExists ( ls_MonitorINIPath ) THEN
		Timer ( 0 )
		MessageBox ( 'Monitor for Windows', 'Unable to locate Monitor.ini file!' )
		Return
	End IF
END IF

ls_EDI_Path = ProfileString ( ls_MonitorINIPath, 'EDI PARMS', 'EDIDirectory', 'c:' )

cb_popup.visible	= FALSE
st_file.visible	= FALSE
sle_file.visible	= FALSE

If bUOP AND FileExists(ls_EDI_Path + "\EDIDATA.TXT") then

	Timer(0, This)
	bBusy				= TRUE
	p_idle.visible	= FALSE
	st_idle.visible= FALSE


	bNewRelease	= TRUE

	dw_message.InsertRow(1)
	dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Translate releases")

	wf_read_text_file(ls_EDI_Path + "\EDIDATA.TXT")

	dw_message.InsertRow(1)
	dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Done the release translation")

	FileDelete(ls_EDI_Path + "\EDIDATA.TXT")
	FileDelete(ls_EDI_Path + "\KANBAN.TXT")

	bBusy				= FALSE	
	Timer(0.5, This)
	bUOP				= TRUE
	bFinish			= TRUE
	wf_idle ( )

ElseIf (FileExists(ls_EDI_Path + "\DX-XF-FF.080")) or (FileExists(ls_EDI_Path + "\DX-XF-FF.MON")) then

	Timer ( 0, This )

	dw_message.InsertRow(1)

	dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Start Raw data Processor")

	bFinish	= FALSE

	OpenSheetWithParm(w_edi_raw_data_processor, 'AUTO', gnv_App.of_GetFrame(), 3, Original!)

	dw_message.InsertRow(1)
	dw_message.SetItem(1, 1, String(Today()) + " " + String(Now()) + " " + "Exit from raw data processor")

	Timer ( 0.5, This )

Elseif bUOP Then

	wf_idle()

End If
end event

on activate;gnv_App.of_GetFrame().ChangeMenu(m_edi)
end on

event open;dw_blanket_orders.SetTransObject(sqlca)
dw_active_release.SetTransObject(sqlca)

dLastEDIDate	= wf_last_date_for_edi_process()

wf_setup()
end event

on w_edi_text_translator.create
this.dw_active_release=create dw_active_release
this.dw_1=create dw_1
this.dw_formated_kanban=create dw_formated_kanban
this.dw_kanban_temp=create dw_kanban_temp
this.st_lastdate=create st_lastdate
this.st_idle=create st_idle
this.p_idle=create p_idle
this.st_percentage=create st_percentage
this.p_1=create p_1
this.st_file=create st_file
this.sle_file=create sle_file
this.cb_popup=create cb_popup
this.dw_blanket_orders=create dw_blanket_orders
this.dw_temp=create dw_temp
this.dw_order=create dw_order
this.dw_release=create dw_release
this.dw_formated_edi=create dw_formated_edi
this.dw_message=create dw_message
this.dw_exception=create dw_exception
this.dw_edi_log=create dw_edi_log
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.dw_active_release,&
this.dw_1,&
this.dw_formated_kanban,&
this.dw_kanban_temp,&
this.st_lastdate,&
this.st_idle,&
this.p_idle,&
this.st_percentage,&
this.p_1,&
this.st_file,&
this.sle_file,&
this.cb_popup,&
this.dw_blanket_orders,&
this.dw_temp,&
this.dw_order,&
this.dw_release,&
this.dw_formated_edi,&
this.dw_message,&
this.dw_exception,&
this.dw_edi_log,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_edi_text_translator.destroy
destroy(this.dw_active_release)
destroy(this.dw_1)
destroy(this.dw_formated_kanban)
destroy(this.dw_kanban_temp)
destroy(this.st_lastdate)
destroy(this.st_idle)
destroy(this.p_idle)
destroy(this.st_percentage)
destroy(this.p_1)
destroy(this.st_file)
destroy(this.sle_file)
destroy(this.cb_popup)
destroy(this.dw_blanket_orders)
destroy(this.dw_temp)
destroy(this.dw_order)
destroy(this.dw_release)
destroy(this.dw_formated_edi)
destroy(this.dw_message)
destroy(this.dw_exception)
destroy(this.dw_edi_log)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_active_release from datawindow within w_edi_text_translator
int X=1957
int Y=868
int Width=896
int Height=544
int TabOrder=180
string DataObject="dw_list_of_releases_white7"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;dWin	= this
szdWinName	= "Release Detail Data Window"
end on

type dw_1 from datawindow within w_edi_text_translator
int X=3191
int Y=2528
int Width=494
int Height=360
int TabOrder=140
boolean LiveScroll=true
end type

type dw_formated_kanban from datawindow within w_edi_text_translator
int X=1051
int Y=1464
int Width=283
int Height=376
int TabOrder=130
boolean Visible=false
string DataObject="d_external_mapped_kanban_data"
boolean LiveScroll=true
end type

type dw_kanban_temp from datawindow within w_edi_text_translator
int X=686
int Y=1464
int Width=320
int Height=368
int TabOrder=120
boolean Visible=false
string DataObject="d_external_dw_for_edi_conversion"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_lastdate from statictext within w_edi_text_translator
int X=1170
int Y=768
int Width=603
int Height=48
boolean Visible=false
string Text="The Last Date for Process:"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_idle from statictext within w_edi_text_translator
int X=1042
int Y=320
int Width=613
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Waiting for EDIDATA.TXT"
boolean FocusRectangle=false
long TextColor=255
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_idle from picture within w_edi_text_translator
int X=1289
int Y=192
int Width=110
int Height=96
boolean Visible=false
string PictureName="logo2.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

type st_percentage from statictext within w_edi_text_translator
int X=329
int Y=768
int Width=283
int Height=56
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_edi_text_translator
int X=951
int Y=32
int Width=55
int Height=48
boolean Visible=false
string PictureName="logo2.bmp"
boolean FocusRectangle=false
end type

type st_file from statictext within w_edi_text_translator
int X=1152
int Y=496
int Width=731
int Height=64
boolean Visible=false
string Text="EDI Text File Path and Name"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_file from singlelineedit within w_edi_text_translator
int X=1170
int Y=592
int Width=695
int Height=96
int TabOrder=20
boolean Visible=false
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Integer iRow

bFinish	= FALSE
wf_read_text_file(this.text)		//Preprocess the EDI text file

st_file.visible		= FALSE
sle_file.visible		= FALSE
cb_popup.visible		= FALSE
st_lastdate.visible	= FALSE
end event

type cb_popup from commandbutton within w_edi_text_translator
int X=1097
int Y=464
int Width=841
int Height=432
int TabOrder=90
boolean Visible=false
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_blanket_orders from datawindow within w_edi_text_translator
int X=347
int Y=1464
int Width=320
int Height=368
int TabOrder=110
boolean Visible=false
string DataObject="dw_list_of_all_blanket_orders"
boolean LiveScroll=true
end type

type dw_temp from datawindow within w_edi_text_translator
int X=9
int Y=1464
int Width=320
int Height=368
int TabOrder=100
boolean Visible=false
string DataObject="d_external_dw_for_edi_conversion"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_order from datawindow within w_edi_text_translator
int X=1957
int Y=64
int Width=896
int Height=704
int TabOrder=70
string DataObject="dw_external_processed_order"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Long iRow

dWin	= this
szdWinName	= "List of Processed Blanket Orders"

iRow	= this.GetClickedRow()

If iRow > 0 then
	dw_active_release.Retrieve(this.GetItemNumber(iRow, "order"))
Else
	dw_active_release.Reset()
End If
end on

type dw_release from datawindow within w_edi_text_translator
int X=1399
int Y=1464
int Width=283
int Height=376
int TabOrder=60
boolean Visible=false
string DataObject="d_external_edi_text_file"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_formated_edi from datawindow within w_edi_text_translator
int X=37
int Y=64
int Width=914
int Height=704
int TabOrder=200
string DataObject="dw_external_mapped_edi_data"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;If bDragException then
	bDragException	= FALSE
	bNewRelease		= FALSE
	wf_setup ( )
	wf_read_text_file("")
End If
end event

on clicked;dWin	= this
szdWinName	= "Formated Raw Release Data"
end on

type dw_message from datawindow within w_edi_text_translator
int X=1006
int Y=64
int Width=896
int Height=704
int TabOrder=80
string DataObject="dw_read_line_char80"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_exception from datawindow within w_edi_text_translator
int X=37
int Y=860
int Width=914
int Height=544
int TabOrder=160
string DragIcon="DRAG1PG.ICO"
string DataObject="d_external_edi_text_file"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;dWin	= this
szdWinName	= "Exception Report"
IF row > 0 THEN
	this.Drag(begin!)
	bDragException	= TRUE
END IF
end event

type dw_edi_log from datawindow within w_edi_text_translator
int X=1006
int Y=864
int Width=896
int Height=544
int TabOrder=170
string DataObject="d_external_edi_log"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;dWin	= this
szdWinName	= "Receiving Log Report"
end on

type gb_6 from groupbox within w_edi_text_translator
int X=1920
int Y=800
int Width=969
int Height=640
int TabOrder=150
string Text="Current Release in Order"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_edi_text_translator
int X=969
int Y=800
int Width=951
int Height=640
int TabOrder=190
string Text="Receiving Log"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_edi_text_translator
int Y=800
int Width=969
int Height=640
int TabOrder=30
string Text="Exception"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_edi_text_translator
int X=1920
int Width=969
int Height=800
int TabOrder=40
string Text="Processed Blanket Order"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_edi_text_translator
int X=969
int Width=951
int Height=800
int TabOrder=50
string Text="Message"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_edi_text_translator
int Width=969
int Height=800
int TabOrder=10
string Text="Mapped EDI Raw Data"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

