$PBExportHeader$w_check_same_destination_version2.srw
forward
global type w_check_same_destination_version2 from window
end type
type pb_part_note from picturebutton within w_check_same_destination_version2
end type
type pb_foot_note from picturebutton within w_check_same_destination_version2
end type
type sle_current_qty from singlelineedit within w_check_same_destination_version2
end type
type sle_current_qty_1 from editmask within w_check_same_destination_version2
end type
type st_um2 from statictext within w_check_same_destination_version2
end type
type st_um1 from statictext within w_check_same_destination_version2
end type
type cb_note_save from commandbutton within w_check_same_destination_version2
end type
type mle_note from multilineedit within w_check_same_destination_version2
end type
type dw_shipper_detail from datawindow within w_check_same_destination_version2
end type
type st_10 from statictext within w_check_same_destination_version2
end type
type st_7 from statictext within w_check_same_destination_version2
end type
type st_4 from statictext within w_check_same_destination_version2
end type
type sle_total_wgt from singlelineedit within w_check_same_destination_version2
end type
type sle_wgt_exclude from singlelineedit within w_check_same_destination_version2
end type
type mle_1 from multilineedit within w_check_same_destination_version2
end type
type st_1 from statictext within w_check_same_destination_version2
end type
type st_14 from statictext within w_check_same_destination_version2
end type
type st_13 from statictext within w_check_same_destination_version2
end type
type st_12 from statictext within w_check_same_destination_version2
end type
type sle_rec_quantity from singlelineedit within w_check_same_destination_version2
end type
type sle_estimatedweight from singlelineedit within w_check_same_destination_version2
end type
type st_8 from statictext within w_check_same_destination_version2
end type
type st_6 from statictext within w_check_same_destination_version2
end type
type sle_stdpack from singlelineedit within w_check_same_destination_version2
end type
type sle_customer from singlelineedit within w_check_same_destination_version2
end type
type st_3 from statictext within w_check_same_destination_version2
end type
type cb_clear from commandbutton within w_check_same_destination_version2
end type
type sle_due_date from singlelineedit within w_check_same_destination_version2
end type
type st_5 from statictext within w_check_same_destination_version2
end type
type cb_cancel from commandbutton within w_check_same_destination_version2
end type
type cb_save from commandbutton within w_check_same_destination_version2
end type
type gb_5 from groupbox within w_check_same_destination_version2
end type
type gb_4 from groupbox within w_check_same_destination_version2
end type
type gb_3 from groupbox within w_check_same_destination_version2
end type
type sle_quantity from singlelineedit within w_check_same_destination_version2
end type
type sle_destination from singlelineedit within w_check_same_destination_version2
end type
type cb_note from commandbutton within w_check_same_destination_version2
end type
type dw_shipper_header from datawindow within w_check_same_destination_version2
end type
type gb_2 from groupbox within w_check_same_destination_version2
end type
type cb_detail_exit from commandbutton within w_check_same_destination_version2
end type
type dw_1 from datawindow within w_check_same_destination_version2
end type
type st_2 from statictext within w_check_same_destination_version2
end type
type st_9 from statictext within w_check_same_destination_version2
end type
type ddlb_parts_list from dropdownlistbox within w_check_same_destination_version2
end type
type gb_1 from groupbox within w_check_same_destination_version2
end type
type sle_part from singlelineedit within w_check_same_destination_version2
end type
type dw_detail from datawindow within w_check_same_destination_version2
end type
type cb_detail from commandbutton within w_check_same_destination_version2
end type
end forward

global type w_check_same_destination_version2 from window
integer width = 4878
integer height = 2652
boolean titlebar = true
string title = "Create a Shipper"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 78682240
event close_window pbm_custom01
pb_part_note pb_part_note
pb_foot_note pb_foot_note
sle_current_qty sle_current_qty
sle_current_qty_1 sle_current_qty_1
st_um2 st_um2
st_um1 st_um1
cb_note_save cb_note_save
mle_note mle_note
dw_shipper_detail dw_shipper_detail
st_10 st_10
st_7 st_7
st_4 st_4
sle_total_wgt sle_total_wgt
sle_wgt_exclude sle_wgt_exclude
mle_1 mle_1
st_1 st_1
st_14 st_14
st_13 st_13
st_12 st_12
sle_rec_quantity sle_rec_quantity
sle_estimatedweight sle_estimatedweight
st_8 st_8
st_6 st_6
sle_stdpack sle_stdpack
sle_customer sle_customer
st_3 st_3
cb_clear cb_clear
sle_due_date sle_due_date
st_5 st_5
cb_cancel cb_cancel
cb_save cb_save
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
sle_quantity sle_quantity
sle_destination sle_destination
cb_note cb_note
dw_shipper_header dw_shipper_header
gb_2 gb_2
cb_detail_exit cb_detail_exit
dw_1 dw_1
st_2 st_2
st_9 st_9
ddlb_parts_list ddlb_parts_list
gb_1 gb_1
sle_part sle_part
dw_detail dw_detail
cb_detail cb_detail
end type
global w_check_same_destination_version2 w_check_same_destination_version2

type variables
String szDestination
String szSCAC                        //SCAC
String szTransMode                //Trans Mode
String szDockCode                 //Dock code
String szPlant                        //Plant code
String szPartNote                  //Part note
String szFootNote                  //Foot note
String szPart                          //Current part number
String szCurrentDock              //Whether check dock #
String szCurrentModelYear      //Whether check model year
String szFOB                         //To keep the FOB
String ls_GroupNo
string	is_currency

Decimal nStdPack                 //Std pack for the part
Decimal nQty                        //The current quantity

Long iShipper
Long iOrder		//The sales order number

Date     dReleaseDate
Date	dDate1
Date	dDate2
Date	dDate3
Date	dDate4
Date	dDate5
Date	dDate6
Date	dDate7

Boolean bEnterFootNote          //Enter the foot note
Boolean bEnterPartNote           //Enter the part note
Boolean bFootNote                 //Whether have foot note
Boolean bPartNote                  //Whether have part note
Boolean bNew                        //Whether this is new shipper
Boolean bCheckDock              //Whether check dock 
Boolean bCheckModelYear       //Whether check model yr
Boolean bDateMode_today       //Whether today 
Boolean bDateMode_tomorrow  //Whether tomorrow
Boolean bDateMode_release     //Whether release date
Boolean bDateMode_Sunday	    //Whether Sunday
Boolean bDateMode_Monday	    //Whether Monday
Boolean bDateMode_Tuesday   //Whether Tuesday
Boolean bDateMode_Wednesday //Whether Wednesday
Boolean bDateMode_Thursday  //Whether Thursday
Boolean bDateMode_Friday	    //Whether Friday
Boolean bDateMode_Saturday   //Whether Saturday
Boolean bDateMode_AnyDay     //Whether AnyDay
Boolean bQtyModified  = FALSE//Whether qty be modified

Integer   iilast=0
Boolean bmultipleselect=False // multiple selection flag

w_global_shipping_version2 gssWindow
end variables

forward prototypes
public function string wf_get_customer (string szdestination)
public subroutine wf_save ()
public subroutine wf_setup_screen ()
public subroutine wf_get_std_pack (long iorder)
public subroutine wf_get_trans_mode ()
public subroutine wf_setup_shipper_datawindow (long ishipper)
public subroutine wf_setup_shipper_weight (long ishipper)
public function decimal wf_calc_shipper_weight (long ishipper)
public function long wf_shipper_detail_row (string szpart)
public subroutine wf_set_note_bmp ()
public subroutine wf_get_dock_model_year (long isalesorder)
public subroutine wf_show_detail (boolean bFlag)
public subroutine wf_enable_buttons (boolean bFlag)
public function string wf_get_freight_type (string szdestination)
public function decimal wf_get_tax_rate (string szdestination)
public function boolean wf_same_part_different_order (long ishipper, string szpart, long iorder)
public function date next_day (date today)
public function string wf_get_dcsstatus (string as_destination)
public function string getterms ()
end prototypes

event close_window;close(this)
end event

public function string wf_get_customer (string szdestination);String szCustomer

Select destination.customer  
Into 	:szCustomer  
From 	destination  
Where destination.destination = :szDestination   ;

Return szCustomer

end function

public subroutine wf_save ();String 	szCustomer
integer	li_item

If IsNull ( iShipper ) then
	if sqlca.of_getnextparmvalue ( "shipper", iShipper ) then
		dw_shipper_header.SetItem(1, "id", iShipper)
		dw_shipper_header.SetItem(1, "tax_rate", wf_get_tax_rate(szDestination))
	else
		rollback;
		return
	end if
End If
	
dw_shipper_header.SetItem(1, "status", "O")
dw_shipper_header.SetItem(1, "destination", szDestination)
dw_shipper_header.SetItem(1, "notes", szFootNote)
dw_shipper_header.SetItem(1, "model_year", szCurrentModelYear)
dw_shipper_header.SetItem(1, "invoiced", "N")
dw_shipper_header.SetItem(1, "invoice_printed", "N")
dw_shipper_header.SetItem(1, "picklist_printed", "N")
dw_shipper_header.SetItem(1, "printed", "N")
szCustomer	= wf_get_customer(szDestination)
dw_shipper_header.SetItem(1, "customer", szCustomer)
dw_shipper_header.SetItem(1, "terms", getTerms())
dw_shipper_header.SetItem(1, "currency_unit", is_currency )
dw_shipper_header.SetItem(1, "cs_status", wf_get_dcsstatus(szdestination))

If dw_shipper_header.Update() > 0 then
	Commit;
	gssWindow.iShipper    = iShipper
	gssWindow.bCancel     = FALSE		//Tell parent window, this is a real operation
	gssWindow.bNewShipper = FALSE		//Tell parent window not to create a new shipper
	gssWindow.szNote		= szPartNote
	gssWindow.nQty			= dec(sle_current_qty.text)
	gssWindow.szShippingUnit = st_um2.text
	gssWindow.TriggerEvent("create_shipper")
	li_item = ddlb_parts_list.SelectItem ( szPart, 1 )
	if li_item > 0 then
	   ddlb_parts_list.deleteitem( li_item )
	end if
   if (ddlb_parts_list.totalitems() = 0) then 
  	   Close(w_check_same_destination_version2)
	end if 	  
Else
	Rollback;
End If
end subroutine

public subroutine wf_setup_screen ();Long nSuggestQty
Integer nBoxes
String szStdpack, szScac, szPlant, szTransmode, szDockCode, szUnit, 	s_datemode

s_datemode = ""
sle_quantity.SetFocus()
if bmultipleselect=false then
   wf_get_std_pack(iorder)   
   sle_destination.text	= szDestination
   sle_due_date.text		= String(gssWindow.dDueDate)
   sle_customer.text    = wf_get_customer(szDestination)
   sle_stdpack.text		= String(Truncate(nStdPack, 2))
   szPart					= sle_part.text  
   nQty						= gssWindow.dw_range_weights.object.part_qty[1] 
   dReleaseDate			= gssWindow.dw_range_weights.object.due_date[1]
else
   wf_get_std_pack(iorder)	
   nQty						= Truncate(Dec(sle_current_qty.text),2)
	sle_part.text        = szpart
	sle_destination.text = szdestination
	sle_due_date.text		= String(dReleaseDate)
   sle_quantity.text		= String(Truncate(nqty, 2))	
   sle_customer.text    = wf_get_customer(szDestination)
   sle_stdpack.text		= String(Truncate(nStdPack, 2))	
//   dReleaseDate			= gssWindow.dDueDate
end if 

If nStdPack > 0 then
	nBoxes					= Truncate((nQty / nStdPack) + 0.99 , 0)
	nSuggestQty				= Truncate( nStdPack * nBoxes , 2)
	sle_rec_quantity.text= String(nSuggestQty)
End If

wf_get_trans_mode()			//Get trans mode/plant/scac information
wf_get_dock_model_year(gssWindow.iSalesOrder)	

//st_um1.text					= f_get_order_info(gssWindow.iSalesOrder, "SHIPPING UNIT")
st_um1.text = ''
	SELECT unit
	  INTO :st_um1.text
	  FROM order_detail
	 WHERE order_no = :gssWindow.iSalesOrder and part_number = :szPart and IsNull ( suffix, 0 ) = IsNull ( :gssWindow.iSuffix, 0 )  ;

If IsNull (st_um1.text) then
	st_um1.text				= f_get_part_info(szPart, "STANDARD UNIT")
End If

st_um2.text					= st_um1.text

SetNull(iShipper)

dw_shipper_header.Reset()
dw_shipper_header.InsertRow(1)

bDateMode_today	= FALSE
bDateMode_tomorrow= FALSE
bDateMode_release = FALSE

// Inc by gph on 3/14 at 10.44 am, changed if to choose case

s_datemode = gssWindow.ddlb_date_selection.text

CHOOSE CASE s_datemode
	CASE 	"Today"   	
			bDateMode_today 		= TRUE
	CASE 	"Tomorrow" 
			bDateMode_tomorrow 	= TRUE
	CASE 	"Release Date"
			bDateMode_release		= TRUE
	CASE 	"Sunday"
			bDateMode_Sunday		= TRUE
	CASE 	"Monday"
			bDateMode_Monday		= TRUE
	CASE 	"Tuesday"
			bdateMode_Tuesday		= TRUE
	CASE 	"Wednesday"
			bdateMode_Wednesday	= TRUE
	CASE	"Thursday"
			bDateMode_Thursday	= TRUE
	CASE	"Friday"
			bDateMode_Friday		= TRUE
	CASE	"Saturday"
			bDateMode_Saturday	= TRUE
	CASE	"AnyDay"
			bDateMode_AnyDay		= TRUE
END CHOOSE

wf_setup_shipper_datawindow(iShipper)		//Set datawindow screen
wf_setup_shipper_weight(iShipper)
wf_set_note_bmp()
end subroutine

public subroutine wf_get_std_pack (long iorder);String	ls_OrderType

szPart = gssWindow.szPart

SELECT order_header.standard_pack,   
       order_header.order_type,   
       order_header.dock_code,   
       order_header.plant,   
       order_header.notes,
		 order_header.currency_unit
  INTO :nStdPack,   
       :ls_OrderType,   
       :szDockCode,   
       :szPlant,   
       :szFootNote,
		 :is_currency
  FROM order_header  
 WHERE order_header.order_no = :iOrder   ;

If ls_OrderType = 'N' Then
	SELECT order_detail.notes,   
	       order_detail.plant,   
	       order_detail.group_no  
	  INTO :szPartNote,   
	       :szPlant,   
	       :ls_GroupNo  
	  FROM order_detail  
	 WHERE ( order_detail.order_no = :iOrder ) AND  
	       ( order_detail.part_number = :szPart ) and
			 IsNull ( suffix, 0 ) = IsNull ( :gssWindow.iSuffix, 0 )  ;

	SELECT part_inventory.standard_pack  
	  INTO :nStdPack  
	  FROM part_inventory  
	 WHERE part_inventory.part = :szPart   ;
End if

If Trim(szPartNote) > " " then
	bPartNote	= TRUE
End If

end subroutine

public subroutine wf_get_trans_mode ();String szDockFlag			//Whether need to check dock code
String szModelYearFlag	//Whether need to check model year

 SELECT destination_shipping.
	scac_code, 
	trans_mode,  
	fob,
	dock_code_flag,
	model_year_flag,
	note_for_shipper
   INTO 	:szScac,   
        	:szTransmode,
			:szFob,
			:szDockFlag,
			:szModelYearFlag,
			:szFootNote

   FROM destination_shipping  
  WHERE destination_shipping.destination = :szDestination   ;

bCheckDock			= (szDockFlag 		= "N")
bCheckModelYear	= (szModelYearFlag= "N")

If IsNull(bCheckDock) then
	bCheckDock	= FALSE
End If

If IsNull(bCheckModelYear) then
	bCheckModelYear	= FALSE
End If

If IsNull(bCheckDock) then
	bCheckDock	= FALSE
End If

If Trim(szFootNote) > " " then
	bFootNote	= TRUE
End If
end subroutine

public subroutine wf_setup_shipper_datawindow (long ishipper);Date d[1 TO 7]
dDate2 = next_day(dDate1)
dDate3 = next_day(dDate2)
dDate4 = next_day(dDate3)
dDate5 = next_day(dDate4)
dDate6 = next_day(dDate5)
dDate7 = next_day(dDate6)
d[1] =dDate1
d[2] =dDate2
d[3] =dDate3
d[4] =ddate4
d[5] =dDate5
d[6] =ddate6
d[7] =dDate7

String day_selected
integer i

dw_shipper_header.SetItem(1, "id", iShipper)
dw_shipper_header.SetItem(1, "ship_via", szScac)
dw_shipper_header.SetItem(1, "plant", szPlant)

If bDateMode_today then
	dw_shipper_header.SetItem(1, "date_stamp", Today())
ElseIf bDateMode_tomorrow then
		dw_shipper_header.SetItem(1, "date_stamp", RelativeDate(Today(), 1))
Elseif bDateMode_Release then
		dw_shipper_header.SetItem(1, "date_stamp", dReleaseDate)
Elseif bDateMode_Anyday then
		dw_shipper_header.SetItem(1, "date_stamp", Today())
Else

	//***If the shipping is 'day-specific' THEN *****

	day_selected = gssWindow.ddlb_date_selection.text
		i=1
		DO WHILE DayName(d[i]) <> day_selected
			i=i+1
		LOOP
	dw_shipper_header.SetItem(1, "date_stamp",d[i])

End If

dw_shipper_header.SetTabOrder("id", 0)
dw_shipper_header.SetItem(1, "shipping_dock", szDockCode)
dw_shipper_header.SetItem(1, "trans_mode", szTransMode)
dw_shipper_header.SetItem(1, "location", szFob)
dw_shipper_header.SetItem(1, "customer", wf_get_customer(szDestination))
dw_shipper_header.SetItem(1, "freight_type", wf_get_freight_type(szDestination))
dw_shipper_header.setItem(1, "freight", 0)

dw_shipper_header.SetItem(1, "cs_status", wf_get_dcsstatus(szdestination))
end subroutine

public subroutine wf_setup_shipper_weight (long ishipper);Decimal nPartWgt		= 0
Decimal nWgtExclude 	= 0
Decimal nTotalWgt		= 0

nPartWgt							= f_calc_part_weight(szPart, nQty)
sle_estimatedweight.text	= String(Truncate(nPartWgt, 2))

nWgtExclude				= wf_calc_shipper_weight(iShipper) 
sle_wgt_exclude.text	= String(Truncate(nWgtExclude, 2))

nTotalWgt				= nWgtExclude + nPartWgt
sle_total_wgt.text	= String(Truncate(nTotalWgt, 2))
		

end subroutine

public function decimal wf_calc_shipper_weight (long ishipper);String szPart

Long iRow

Decimal nQty
Decimal nTotalWgt = 0

dw_shipper_detail.Retrieve(iShipper)

For iRow = 1 to dw_shipper_detail.RowCount()
	szPart		= dw_shipper_detail.GetItemString(iRow, "part")
	nQty			= dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_qty_required")
	nTotalWgt	= nTotalWgt + f_calc_part_weight(szPart, nQty)
Next

Return nTotalWgt



end function

public function long wf_shipper_detail_row (string szpart);Long 		iRow
Boolean 	bDone

iRow 	= 1
bDone	= FALSE


Do while (Not bDone) AND ( iRow <= dw_shipper_detail.RowCount())
	If dw_shipper_detail.GetItemString(iRow, "part") = szPart then
		bDone = TRUE
	Else
		iRow ++
	End If
Loop

If iRow > dw_shipper_detail.RowCount() then
	Return 0
Else
	Return iRow
End If

end function

public subroutine wf_set_note_bmp ();If IsNull(iShipper) then
	pb_foot_note.pictureName	= "noteno.bmp"
	pb_part_note.pictureName	= "noteno.bmp"
Else
	If bFootNote then
		pb_foot_note.PictureName	= "noteyes.bmp"
	Else
		pb_foot_note.PictureName	= "noteno.bmp"
	End If

	If bPartNote then
		pb_part_note.PictureName	= "noteyes.bmp"
	Else
		pb_part_note.PictureName	= "noteno.bmp"
	End If
End If


	
end subroutine

public subroutine wf_get_dock_model_year (long isalesorder);  SELECT order_header.model_year,   
         order_header.dock_code
    INTO :szCurrentModelYear,   
         :szCurrentDock
    FROM order_header
   WHERE order_header.order_no = :iSalesOrder   ;

//If Trim(szPartNote) > " " then
//	bPartNote	= TRUE
//End If
//
end subroutine

public subroutine wf_show_detail (boolean bFlag);cb_detail.visible			= bFlag
cb_detail_exit.visible	= bFlag
dw_detail.visible			= bFlag
end subroutine

public subroutine wf_enable_buttons (boolean bFlag);cb_clear.enabled	= bFlag
cb_save.enabled	= bFlag
cb_cancel.enabled	= bFlag
end subroutine

public function string wf_get_freight_type (string szdestination);String szFreightType

  SELECT destination_shipping.freight_type  
    INTO :szFreightType  
    FROM destination_shipping  
   WHERE destination_shipping.destination = :szDestination   ;

Return szFreightType

end function

public function decimal wf_get_tax_rate (string szdestination);Decimal nTaxRate

  SELECT destination.salestax_rate  
    INTO :nTaxRate  
    FROM destination  
   WHERE destination.destination = :szDestination   ;

Return nTaxRate

end function

public function boolean wf_same_part_different_order (long ishipper, string szpart, long iorder);Long iCurrentOrder

SELECT shipper_detail.order_no  
  INTO :iCurrentOrder  
  FROM shipper_detail  
 WHERE ( shipper_detail.shipper = :iShipper ) AND  
       ( shipper_detail.part = :szPart )   ;

If SQLCA.SQLCode = 0 then
	Return (iCurrentOrder <> iOrder)
Else
	Return FALSE
End If
end function

public function date next_day (date today);Integer iMonth				//Number of month
Integer iYear				//Number of year
Integer iDay				//Number of day
Integer iDaysInMonth		//Total days in month

iDay   = day(today)
iMonth = month(today)
iYear  = year(today)

If iDay = days_in_month(iMonth, iYear) then
	iDay = 1
	If iMonth = 12 then
		iMonth = 1
		iYear  = iYear + 1
	Else
		iMonth = iMonth + 1
	End If
Else
	iDay = iDay + 1
End If

Return Date(iYear, iMonth, iDay) 
end function

public function string wf_get_dcsstatus (string as_destination);string ls_dcsstatus

select	cs_status
into	:ls_dcsstatus
from	destination  
where	destination = :as_Destination;

Return ls_dcsstatus

end function

public function string getterms ();
string terms

select
	coalesce(oh.term, c.terms)
into
	:terms
from
	dbo.customer c
	join dbo.destination d on
		c.customer = d.customer
	left join
		dbo.order_header oh on
		oh.order_no = :iOrder
where
	d.destination = :szDestination  ;

return terms

end function

event open;
gssWindow = gnv_App.of_GetFrame().GetActiveSheet()

//	Declaration
Int	licur, &
	lilast 

//	Initialization
dDate1	= today()
dw_1.SetTransObject(sqlca)
dw_shipper_header.SetTransObject(sqlca)
dw_shipper_detail.SetTransObject(sqlca)
dw_detail.SetTransObject(sqlca)

bNew	= TRUE
iilast	= gssWindow.dw_range_weights.rowcount() // used for multiple selection
szDestination = message.StringParm

//	Main Routine
ddlb_parts_list.reset()	// reset the list box
if iilast > 1 then   // if multiple selection is done
	// assign items from dw into list box
	For licur=1 to iilast
		ddlb_parts_list.additem(gssWindow.dw_range_weights.object.part[licur])		
	Next 
	sle_part.hide()
	ddlb_parts_list.show()
	ddlb_parts_list.bringtotop=TRUE
	bmultipleselect=true
	ddlb_parts_list.setfocus()
elseif iilast = 1 then // if it's is equal to one execute the below code
	ddlb_parts_list.hide()	
	ddlb_parts_list.additem(gssWindow.dw_range_weights.object.part[1])		     
	sle_part.text= gssWindow.dw_range_weights.object.part[1]
	sle_part.show()
	bmultipleselect=false
	Timer(0.5)	
	sle_current_qty.text	= String(Truncate(gssWindow.dw_range_weights.object.part_qty[1], 2))
	sle_quantity.text	= String(Truncate(gssWindow.dw_range_weights.object.part_qty[1], 2))
	iOrder	= gssWindow.dw_range_weights.object.sales_order[1]
	dw_1.Retrieve(szDestination)
	wf_setup_screen()
	sle_current_qty.SetFocus()	
end if

/* the following code was there earlier, before the above conditional 
   statement was included on 1/26/98. It's based on the single/multiple 
	selection */
	
//szDestination = message.StringParm
//sle_current_qty.text	= String(Truncate(gssWindow.nQty, 2))
//iOrder					= gssWindow.iSalesOrder
//dw_1.Retrieve(szDestination)
//wf_setup_screen()
//sle_current_qty.SetFocus()
end event

event timer;If Not bQtyModified then
	If sle_current_qty.backcolor	= sle_quantity.backcolor then
		sle_current_qty.backcolor	= sle_total_wgt.backcolor
	Else
		sle_current_qty.backcolor	= sle_total_wgt.backcolor
	End If
Else
	sle_current_qty.backcolor		= sle_quantity.backcolor
End If

If bFootNote then
	If pb_foot_note.picturename="noteno.bmp" then
		pb_foot_note.picturename="noteyes.bmp" 
	Else
		pb_foot_note.picturename="noteno.bmp" 
	End If
Else
	pb_foot_note.picturename = "noteno.bmp"
End If

If bPartNote then
	If pb_part_note.picturename="noteno.bmp" then
		pb_part_note.picturename="noteyes.bmp" 
	Else
		pb_part_note.picturename="noteno.bmp" 
	End If
Else
	pb_part_note.picturename	="noteno.bmp"
End If


end event

on deactivate;//Close(this)
end on

on w_check_same_destination_version2.create
this.pb_part_note=create pb_part_note
this.pb_foot_note=create pb_foot_note
this.sle_current_qty=create sle_current_qty
this.sle_current_qty_1=create sle_current_qty_1
this.st_um2=create st_um2
this.st_um1=create st_um1
this.cb_note_save=create cb_note_save
this.mle_note=create mle_note
this.dw_shipper_detail=create dw_shipper_detail
this.st_10=create st_10
this.st_7=create st_7
this.st_4=create st_4
this.sle_total_wgt=create sle_total_wgt
this.sle_wgt_exclude=create sle_wgt_exclude
this.mle_1=create mle_1
this.st_1=create st_1
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.sle_rec_quantity=create sle_rec_quantity
this.sle_estimatedweight=create sle_estimatedweight
this.st_8=create st_8
this.st_6=create st_6
this.sle_stdpack=create sle_stdpack
this.sle_customer=create sle_customer
this.st_3=create st_3
this.cb_clear=create cb_clear
this.sle_due_date=create sle_due_date
this.st_5=create st_5
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.sle_quantity=create sle_quantity
this.sle_destination=create sle_destination
this.cb_note=create cb_note
this.dw_shipper_header=create dw_shipper_header
this.gb_2=create gb_2
this.cb_detail_exit=create cb_detail_exit
this.dw_1=create dw_1
this.st_2=create st_2
this.st_9=create st_9
this.ddlb_parts_list=create ddlb_parts_list
this.gb_1=create gb_1
this.sle_part=create sle_part
this.dw_detail=create dw_detail
this.cb_detail=create cb_detail
this.Control[]={this.pb_part_note,&
this.pb_foot_note,&
this.sle_current_qty,&
this.sle_current_qty_1,&
this.st_um2,&
this.st_um1,&
this.cb_note_save,&
this.mle_note,&
this.dw_shipper_detail,&
this.st_10,&
this.st_7,&
this.st_4,&
this.sle_total_wgt,&
this.sle_wgt_exclude,&
this.mle_1,&
this.st_1,&
this.st_14,&
this.st_13,&
this.st_12,&
this.sle_rec_quantity,&
this.sle_estimatedweight,&
this.st_8,&
this.st_6,&
this.sle_stdpack,&
this.sle_customer,&
this.st_3,&
this.cb_clear,&
this.sle_due_date,&
this.st_5,&
this.cb_cancel,&
this.cb_save,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.sle_quantity,&
this.sle_destination,&
this.cb_note,&
this.dw_shipper_header,&
this.gb_2,&
this.cb_detail_exit,&
this.dw_1,&
this.st_2,&
this.st_9,&
this.ddlb_parts_list,&
this.gb_1,&
this.sle_part,&
this.dw_detail,&
this.cb_detail}
end on

on w_check_same_destination_version2.destroy
destroy(this.pb_part_note)
destroy(this.pb_foot_note)
destroy(this.sle_current_qty)
destroy(this.sle_current_qty_1)
destroy(this.st_um2)
destroy(this.st_um1)
destroy(this.cb_note_save)
destroy(this.mle_note)
destroy(this.dw_shipper_detail)
destroy(this.st_10)
destroy(this.st_7)
destroy(this.st_4)
destroy(this.sle_total_wgt)
destroy(this.sle_wgt_exclude)
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.sle_rec_quantity)
destroy(this.sle_estimatedweight)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.sle_stdpack)
destroy(this.sle_customer)
destroy(this.st_3)
destroy(this.cb_clear)
destroy(this.sle_due_date)
destroy(this.st_5)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.sle_quantity)
destroy(this.sle_destination)
destroy(this.cb_note)
destroy(this.dw_shipper_header)
destroy(this.gb_2)
destroy(this.cb_detail_exit)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_9)
destroy(this.ddlb_parts_list)
destroy(this.gb_1)
destroy(this.sle_part)
destroy(this.dw_detail)
destroy(this.cb_detail)
end on

event closequery;This.SetFocus()
gssWindow.bNewShipper = FALSE   //Don't generate new shipper
gssWindow.bCancel     = TRUE


end event

type pb_part_note from picturebutton within w_check_same_destination_version2
integer x = 1463
integer y = 1628
integer width = 78
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "noteno.bmp"
alignment htextalign = left!
end type

event clicked;If bEnterFootNote then
	MessageBox("Warning", "Save foot note first", StopSign!)
	Return
End If

If bEnterPartNote then
	MessageBox("Warning", "You are in part note now", StopSign!)
	Return
End If

bEnterFootNote = FALSE
bEnterPartNote	= TRUE

mle_note.text	= ""

cb_note.visible		= TRUE
cb_note_save.visible	= TRUE
mle_note.visible		= TRUE
mle_note.Text			= szPartNote

wf_enable_buttons(FALSE)

mle_note.SetFocus()
end event

type pb_foot_note from picturebutton within w_check_same_destination_version2
integer x = 1079
integer y = 1628
integer width = 78
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "noteno.bmp"
alignment htextalign = left!
end type

event clicked;If bEnterPartNote then
	MessageBox("Warning", "Save part note first", StopSign!)
	Return
End If

If bEnterFootNote then
	MessageBox("Warning", "You are in foot note now", StopSign!)
	Return
End If

bEnterFootNote = TRUE
bEnterPartNote	= FALSE
mle_note.text	= ""

cb_note.visible		= TRUE
cb_note_save.visible	= TRUE
mle_note.visible		= TRUE
mle_note.Text			= szFootNote


wf_enable_buttons(FALSE)
mle_note.SetFocus()
end event

type sle_current_qty from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 1040
integer width = 375
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;bQtyModified	= TRUE

IF IsNumber ( sle_current_qty.text ) AND Dec ( sle_current_qty.text ) > 0 THEN
	nQty	= Dec ( sle_current_qty.text )
	wf_setup_shipper_weight ( iShipper )
ELSE
   MessageBox ( monsys.msg_title, "Quantity must be greater than zero!", Exclamation! )
	sle_current_qty.Text = ""
	sle_current_qty.SetFocus ( )
END IF
end event

type sle_current_qty_1 from editmask within w_check_same_destination_version2
boolean visible = false
integer x = 1490
integer y = 1944
integer width = 375
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string mask = "###,###"
end type

on modified;bQtyModified	= TRUE

If Sign(Dec(sle_current_qty.Text)) = -1 Then 
	MessageBox ( "DataWindow Error", "Quantity cannot be negative!", Exclamation!)
   sle_current_qty.Text = ""
	Return
End If

nQty	= Dec(this.text)

wf_setup_shipper_weight(iShipper)
end on

type st_um2 from statictext within w_check_same_destination_version2
integer x = 914
integer y = 1048
integer width = 91
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "UM"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_um1 from statictext within w_check_same_destination_version2
integer x = 901
integer y = 268
integer width = 105
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "UM"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_note_save from commandbutton within w_check_same_destination_version2
boolean visible = false
integer x = 2546
integer y = 1392
integer width = 247
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;If bEnterFootNote then
	szFootNote	= mle_note.text
	bFootNote	= (Trim(szFootNote) > " ")
Else
	szPartNote	= mle_note.text
	dw_shipper_detail.SetItem (1, "note", szPartNote)
	bPartNote	= (Trim(szPartNote) > " ")
End If

bEnterFootNote	= FALSE
bEnterPartNote	= FALSE

cb_note.visible		= FALSE
cb_note_save.visible	= FALSE
mle_note.visible		= FALSE

wf_enable_buttons(TRUE)
end event

type mle_note from multilineedit within w_check_same_destination_version2
boolean visible = false
integer x = 1134
integer y = 1020
integer width = 1664
integer height = 360
integer taborder = 160
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
borderstyle borderstyle = stylelowered!
end type

type dw_shipper_detail from datawindow within w_check_same_destination_version2
boolean visible = false
integer x = 27
integer y = 1752
integer width = 1385
integer height = 272
integer taborder = 170
string dataobject = "dw_shipper_detail"
boolean livescroll = true
end type

type st_10 from statictext within w_check_same_destination_version2
integer x = 1573
integer y = 1648
integer width = 279
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Part Note"
boolean focusrectangle = false
end type

type st_7 from statictext within w_check_same_destination_version2
integer x = 1184
integer y = 1648
integer width = 279
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Foot Note"
boolean focusrectangle = false
end type

type st_4 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 1580
integer width = 366
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Total Est Wgt"
boolean focusrectangle = false
end type

type sle_total_wgt from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 1576
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_wgt_exclude from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 1408
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type mle_1 from multilineedit within w_check_same_destination_version2
integer x = 69
integer y = 1356
integer width = 434
integer height = 200
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
string text = "Shipper weight excluding these requirements"
boolean border = false
end type

type st_1 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 1048
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Quantity"
boolean focusrectangle = false
end type

type st_14 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 556
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Customer"
boolean focusrectangle = false
end type

type st_13 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 156
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Part"
boolean focusrectangle = false
end type

type st_12 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 268
integer width = 338
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Quantity"
boolean focusrectangle = false
end type

type sle_rec_quantity from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 744
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_estimatedweight from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 1148
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 712
integer width = 334
integer height = 144
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Suggested Quantity"
boolean focusrectangle = false
end type

type st_6 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 652
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Std Pack"
boolean focusrectangle = false
end type

type sle_stdpack from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 648
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_customer from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 552
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 364
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Destination"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within w_check_same_destination_version2
integer x = 2002
integer y = 1624
integer width = 265
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear"
end type

on clicked;this.SetFocus()
If bEnterFootNote or bEnterPartNote then
	MessageBox("Warning", "Please save note first")
	Return
End If

SetNull(iShipper)
SetNull(szPartNote)
SetNull(szFootNote)

bFootNote	= FALSE
bPartNote	= FALSE

bNew	= TRUE

wf_setup_screen()
end on

type sle_due_date from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 456
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 460
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Due Date"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_check_same_destination_version2
integer x = 2610
integer y = 1624
integer width = 265
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_check_same_destination_version2
integer x = 2304
integer y = 1624
integer width = 265
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
boolean default = true
end type

event clicked;Dec   n_qty

//this.SetFocus()

If dw_shipper_header.AcceptText() = -1 then Return

//	Check for required AETC code.
n_shipping_expedite_trans expediteTrans
boolean isExpedite
int isExpediteValue
isExpediteValue = dw_shipper_header.object.IsExpedite[1] 
if	isExpediteValue = 1 then
	isExpedite = true
else
	string trans_mode
	trans_mode = dw_shipper_header.object.trans_mode[1]
	expediteTrans = create n_shipping_expedite_trans
	expediteTrans.IsExpediteTransMode(trans_mode, isExpedite)
	destroy expediteTrans
end if

if	isExpedite then
	//	Determine if trans mode is expedite and set the flag.
	expediteTrans = create n_shipping_expedite_trans
	
	boolean isAETCRequired
	string destination
	destination = dw_shipper_header.object.destination[1]
	
	if	expediteTrans.IsAETCRequired(destination, isAETCRequired) = expediteTrans.SUCCESS then
		if	isAETCRequired then
			string aetcNumber
			dw_shipper_header.AcceptText()
			aetcNumber = dw_shipper_header.object.aetc_number[1]
			if	IsNull(aetcNumber, "") = "" then
				destroy expediteTrans
				MsgBox ("AETC Number is required for this destination.")
				return
			end if
		end if
	end if
	destroy expediteTrans
end if

If isnumber(sle_current_qty.text) = False Then 
	MessageBox ( monsys.msg_title, "Quantity must be a number!", Exclamation!)
   sle_current_qty.Text = ""
	Return
End If

If Sign(Dec(sle_current_qty.Text)) = -1 Then 
	MessageBox ( monsys.msg_title, "Quantity cannot be negative!", Exclamation!)
   sle_current_qty.Text = ""
	Return
End If

wf_save()		//Save and Exit

end event

type gb_5 from groupbox within w_check_same_destination_version2
integer x = 1056
integer y = 1580
integer width = 869
integer height = 156
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_4 from groupbox within w_check_same_destination_version2
integer x = 27
integer y = 1280
integer width = 1001
integer height = 448
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
string text = "Estimated Weight"
end type

type gb_3 from groupbox within w_check_same_destination_version2
integer x = 27
integer y = 924
integer width = 1001
integer height = 352
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
string text = "Quantity for shipper"
end type

type sle_quantity from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 264
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_destination from singlelineedit within w_check_same_destination_version2
integer x = 517
integer y = 360
integer width = 375
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_note from commandbutton within w_check_same_destination_version2
boolean visible = false
integer x = 1088
integer y = 988
integer width = 1765
integer height = 544
integer taborder = 130
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type dw_shipper_header from datawindow within w_check_same_destination_version2
integer x = 1079
integer y = 1008
integer width = 1755
integer height = 556
integer taborder = 20
string dataobject = "dw_shipper_header_info"
boolean border = false
boolean livescroll = true
end type

on itemerror;dw_shipper_header.SetText ( "" )
end on

event itemchanged;
choose case dwo.Name
	case 'trans_mode'
	
		//	Determine if trans mode is expedite and set the flag.
		n_shipping_expedite_trans expediteTrans
		expediteTrans = create n_shipping_expedite_trans
		
		boolean isExpedite
		if	expediteTrans.IsExpediteTransMode(data, isExpedite) = expediteTrans.SUCCESS then
			if	isExpedite then
				object.IsExpedite[row] = 1
			end if
		end if
		destroy expediteTrans
	
	case "isexpedite"
		if	data = "0" then
			string nullString; setNull(nullString)
			object.ExpediteCode[row] = nullString
		end if
end choose

end event

type gb_2 from groupbox within w_check_same_destination_version2
integer x = 1056
integer y = 924
integer width = 1815
integer height = 656
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
string text = "Shipper Information"
end type

type cb_detail_exit from commandbutton within w_check_same_destination_version2
boolean visible = false
integer x = 2569
integer y = 748
integer width = 247
integer height = 108
integer taborder = 140
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;wf_show_detail(FALSE)
end on

type dw_1 from datawindow within w_check_same_destination_version2
integer x = 1056
integer y = 176
integer width = 1806
integer height = 732
integer taborder = 120
string dataobject = "dw_shippers_with_same_destination"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//	Declaration
String  szShipDock     	//dock code in current shipper
String  szShipModelYear	//model year in current shipper
String  szAllowMultDock

Integer	iRow		//to keep the current row number
Integer	iDetailRow	//to keep the detail row number in shipper detail
String	szAllowMultPO

long	shipperNumber

//	Initialization
If bEnterFootNote or bEnterPartNote then
	MessageBox("Warning", "Please save note first")
	Return
End If

iRow = dw_1.GetClickedRow()

//	Main Routine
If iRow > 0 then

	If (dw_1.GetItemString(iRow, "status") = "S") AND (dw_1.GetItemString(iRow, "printed") = "Y") then
		MessageBox("Warning", "You can not add part to a staged shipper once document has been printed.", StopSign!) 
		Return
	End If
	
	//	Check for 'Allow Multiple POs'
	select
		destination_shipping.allow_mult_po,
		destination_shipping.dock_code_flag
	into
		:szAllowMultPO,
		:szAllowMultDock
	from
		destination_shipping
	where
		destination_shipping.destination = :szdestination  ;

	//	Read order header's customer PO and terms.
	string orderCustomerPO, orderTerms
	
	select
		customer_po
	,	term
	into
		:orderCustomerPO
	,	:orderTerms
	from
		order_header
	where
		order_no = :iOrder;

	//	Get clicked shipper number
	shipperNumber = dw_1.object.id[iRow]

	//	Read shipper's customer PO(s) and terms.
	string minShipperCustomerPO, maxShipperCustomerPO, shipperTerms
	
	select
		min(customer_po)
	,	max(customer_po)
	,	(select terms from shipper where id = :shipperNumber)
	into
		:minShipperCustomerPO
	,	:maxShipperCustomerPO
	,	:shipperTerms
	from
		shipper_detail
	where
		shipper = :shipperNumber  ;
	
	if	isnull(szAllowMultPO,"Y") = "N" and &
		(	isnull(minShipperCustomerPO, "") <> isnull(maxShipperCustomerPO, "") or &
			isnull(orderCustomerPO, "") <> isnull(maxShipperCustomerPO,"") &
		) then
		
		msgbox("This destination does not allow multiple POs in the same shipper")
		return
	end if
	
	//	Check order terms against shipper terms.
	if	isnull(orderTerms, "") <> isnull(shipperTerms, "") then
		msgbox("Terms on the shipper doesn't match with terms on the order, Can't proceed")
		return
	end if

	If wf_same_part_different_order(dw_1.GetItemNumber(iRow, "id"), szPart, iOrder) then
		MessageBox("Warning", "You can not add to a shipper with different sales order for the part.", StopSign!)
		Return
	End If

	bNew						= TRUE
	iShipper					= dw_1.GetItemNumber(iRow, "id")	
	szShipDock				= dw_1.GetItemString(iRow, "shipping_dock")
	szShipModelYear		= dw_1.GetItemString(iRow, "model_year")

	If dw_shipper_header.AcceptText () = -1 Then return
	
	SELECT dock_code
	INTO   :szCurrentDock
	FROM   order_header
	WHERE  order_no = :iOrder ;

	If szAllowMultDock = 'N' Then
		If bCheckDock then
			If f_get_string_value(szShipDock) <> f_get_string_value(szCurrentDock) then
				MessageBox("Warning", "Incompatible dock codes", StopSign!)
				SetNull(iShipper)			
				Return
			End If
		End If
	End If

	If bCheckModelYear then
		If f_get_string_value(szShipModelYear) <> f_get_string_value(szCurrentModelYear) then
			MessageBox("Warning", "Incompatible model years", StopSign!)
			SetNull(iShipper)
			Return
		End If
	End If

	dw_shipper_header.Retrieve(iShipper)
	dw_shipper_detail.Retrieve(iShipper)

	If Trim(dw_1.GetItemString(iRow, "notes")) > " " then
		bFootNote	= TRUE
		szFootNote	= dw_1.GetItemString(iRow, "notes")
	Else
		bFootNote	= FALSE
	End If
	
	bPartNote		= FALSE	
	iDetailRow		= wf_shipper_detail_row(szPart)

	If iDetailRow > 0 then
		If Trim(dw_shipper_detail.GetItemString(iDetailRow, "note")) > " " then
			bPartNote	= TRUE
			szPartNote	= dw_shipper_detail.GetItemString(iDetailRow, "note")
		End If
	End If 		

	wf_setup_shipper_weight(iShipper)
	wf_set_note_bmp()

End If

end event

event doubleclicked;IF Row > 0 THEN
	wf_show_detail ( TRUE )
	dw_detail.Retrieve ( dw_1.object.id [ row ] )
END IF
end event

type st_2 from statictext within w_check_same_destination_version2
integer x = 1056
integer y = 104
integer width = 1806
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Single Click to Combine"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within w_check_same_destination_version2
integer x = 69
integer y = 1120
integer width = 434
integer height = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Estimated Wgt (All Parts)"
boolean focusrectangle = false
end type

type ddlb_parts_list from dropdownlistbox within w_check_same_destination_version2
integer x = 370
integer y = 156
integer width = 521
integer height = 720
integer taborder = 10
string dragicon = "Application!"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Int licur
// on selecting a part from the list box, update the var,objects & even in the parent window
sle_part.text=ddlb_parts_list.text
gssWindow.szpart =ddlb_parts_list.text 
szpart =ddlb_parts_list.text 
licur  = gssWindow.dw_range_weights.Find("part = '"+sle_part.text+"'",1,iilast)
// find that part in the parent datawindow (ie dw_range_weights & get the details)
if licur > 0  then 
	iorder        = gssWindow.dw_range_weights.object.sales_order[licur]
	gssWindow.isalesorder = gssWindow.dw_range_weights.object.sales_order[licur]
	sle_current_qty.text  = String(gssWindow.dw_range_weights.object.part_qty[licur])
	sle_quantity.text     = String(gssWindow.dw_range_weights.object.part_qty[licur])
	dReleaseDate			 = gssWindow.dw_range_weights.object.due_date[licur]
	dw_1.Retrieve(szDestination)
	wf_setup_screen()
	sle_current_qty.SetFocus()	
end if 	

end event

type gb_1 from groupbox within w_check_same_destination_version2
integer x = 27
integer y = 76
integer width = 1001
integer height = 840
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78682240
string text = "Shipping Requirement"
end type

type sle_part from singlelineedit within w_check_same_destination_version2
integer x = 370
integer y = 156
integer width = 521
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_detail from datawindow within w_check_same_destination_version2
boolean visible = false
integer x = 1088
integer y = 136
integer width = 1723
integer height = 584
integer taborder = 100
string dataobject = "dw_shipper_detail"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_detail from commandbutton within w_check_same_destination_version2
boolean visible = false
integer x = 1047
integer y = 96
integer width = 1815
integer height = 812
integer taborder = 150
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

