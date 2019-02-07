$PBExportHeader$w_create_outside_shipper_in_po_grid.srw
forward
global type w_create_outside_shipper_in_po_grid from Window
end type
type dw_part_vendor_qty from datawindow within w_create_outside_shipper_in_po_grid
end type
type dw_shipper_detail from datawindow within w_create_outside_shipper_in_po_grid
end type
type dw_bill from datawindow within w_create_outside_shipper_in_po_grid
end type
type dw_components from datawindow within w_create_outside_shipper_in_po_grid
end type
type cb_detail_exit from commandbutton within w_create_outside_shipper_in_po_grid
end type
type dw_detail from datawindow within w_create_outside_shipper_in_po_grid
end type
type cb_detail from commandbutton within w_create_outside_shipper_in_po_grid
end type
type cb_note_save from commandbutton within w_create_outside_shipper_in_po_grid
end type
type mle_note from multilineedit within w_create_outside_shipper_in_po_grid
end type
type cb_note from commandbutton within w_create_outside_shipper_in_po_grid
end type
type st_10 from statictext within w_create_outside_shipper_in_po_grid
end type
type st_7 from statictext within w_create_outside_shipper_in_po_grid
end type
type p_2 from picture within w_create_outside_shipper_in_po_grid
end type
type p_1 from picture within w_create_outside_shipper_in_po_grid
end type
type st_4 from statictext within w_create_outside_shipper_in_po_grid
end type
type sle_total_wgt from singlelineedit within w_create_outside_shipper_in_po_grid
end type
type sle_wgt_exclude from singlelineedit within w_create_outside_shipper_in_po_grid
end type
type mle_1 from multilineedit within w_create_outside_shipper_in_po_grid
end type
type st_14 from statictext within w_create_outside_shipper_in_po_grid
end type
type sle_customer from singlelineedit within w_create_outside_shipper_in_po_grid
end type
type st_3 from statictext within w_create_outside_shipper_in_po_grid
end type
type cb_clear from commandbutton within w_create_outside_shipper_in_po_grid
end type
type sle_due_date from singlelineedit within w_create_outside_shipper_in_po_grid
end type
type sle_destination from singlelineedit within w_create_outside_shipper_in_po_grid
end type
type st_5 from statictext within w_create_outside_shipper_in_po_grid
end type
type cb_cancel from commandbutton within w_create_outside_shipper_in_po_grid
end type
type st_2 from statictext within w_create_outside_shipper_in_po_grid
end type
type cb_save from commandbutton within w_create_outside_shipper_in_po_grid
end type
type dw_1 from datawindow within w_create_outside_shipper_in_po_grid
end type
type dw_shipper_header from datawindow within w_create_outside_shipper_in_po_grid
end type
type gb_3 from groupbox within w_create_outside_shipper_in_po_grid
end type
type gb_2 from groupbox within w_create_outside_shipper_in_po_grid
end type
type gb_5 from groupbox within w_create_outside_shipper_in_po_grid
end type
type gb_4 from groupbox within w_create_outside_shipper_in_po_grid
end type
type gb_1 from groupbox within w_create_outside_shipper_in_po_grid
end type
end forward

global type w_create_outside_shipper_in_po_grid from Window
int X=0
int Y=0
int Width=3890
int Height=2332
boolean TitleBar=true
string Title="Outside Process Shipper Generator"
long BackColor=78682240
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
event close_window pbm_custom01
dw_part_vendor_qty dw_part_vendor_qty
dw_shipper_detail dw_shipper_detail
dw_bill dw_bill
dw_components dw_components
cb_detail_exit cb_detail_exit
dw_detail dw_detail
cb_detail cb_detail
cb_note_save cb_note_save
mle_note mle_note
cb_note cb_note
st_10 st_10
st_7 st_7
p_2 p_2
p_1 p_1
st_4 st_4
sle_total_wgt sle_total_wgt
sle_wgt_exclude sle_wgt_exclude
mle_1 mle_1
st_14 st_14
sle_customer sle_customer
st_3 st_3
cb_clear cb_clear
sle_due_date sle_due_date
sle_destination sle_destination
st_5 st_5
cb_cancel cb_cancel
st_2 st_2
cb_save cb_save
dw_1 dw_1
dw_shipper_header dw_shipper_header
gb_3 gb_3
gb_2 gb_2
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
end type
global w_create_outside_shipper_in_po_grid w_create_outside_shipper_in_po_grid

type variables
String szDestination            	//To keep the destination
String szSCAC                   	//SCAC
String szTransMode              //Trans Mode
String szDockCode            	//Dock code
String szPlant                     	//Plant code
String szPartNote                 //Part note
String szFootNote                //Foot note
String szPart                        //Current part number
String szCurrentDock              //Whether check dock #
String szCurrentModelYear      //Whether check model year
String szFOB                         //To keep the FOB
String szPO		//To keep the po number			

Decimal nStdPack                 //Std pack for the part
Decimal nQtyRequired            //The current quantity
Decimal nWeightAdded            //Weights for parts

Long iShipper                          //To keep the shipper
Long iSalesOrder                     //To keep the sales order 
Long iComponentRow               //Row number in component

Boolean bEnterFootNote          //Enter the foot note
Boolean bEnterPartNote           //Enter the part note
Boolean bFootNote                 //Whether have foot note
Boolean bPartNote                  //Whether have part note
Boolean bNew                        //Whether this is new shipper
Boolean bCheckDock              //Whether check dock 
Boolean bCheckModelYear       //Whether check model yr

st_generic_structure stParm     //Generic structure


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
public subroutine wf_create_shipper_detail (string szpart, decimal nqty)
public subroutine wf_setup_bill_datawindow ()
public function decimal wf_qty_at_vendor (string szpart, string szvendor)
public subroutine wf_build_part_vendor_qty ()
end prototypes

on close_window;close(this)
end on

public function string wf_get_customer (string szdestination);String szCustomer

Select destination.customer  
Into :szCustomer  
From destination  
Where destination.destination = :szDestination   ;

Return szCustomer

end function

public subroutine wf_save ();Long 		iRow

String	szPart
Decimal	nQty

If bNew then
	dw_shipper_header.SetItem(1, "id", iShipper)
End If
	
dw_shipper_header.SetItem(1, "status", "O")
dw_shipper_header.SetItem(1, "destination", szDestination)
dw_shipper_header.SetItem(1, "notes", szFootNote)
dw_shipper_header.SetItem(1, "model_year", szCurrentModelYear)
dw_shipper_header.SetItem(1, "invoiced", "N")
dw_shipper_header.SetItem(1, "type", "O")			//Set Outside Shipper flag

If dw_shipper_header.Update() > 0 then
	Commit;

	For iRow = 1 to dw_components.RowCount()
		szPart		= dw_components.GetItemString(iRow, "part")
		nQty			= dw_components.GetItemNumber(iRow, "qty")
		szPartNote	= dw_components.GetItemString(iRow, "note")
		wf_create_shipper_detail(szPart, nQty)
	Next

	//w_global_purchasing_scheduler.TriggerEvent("refresh_grid")
	//wParentWindow.wf_update_qty_assigned(szPart, wParentWindow.dEndDate, "O" + String(iShipper))
	//wParentWindow.wf_recalc_crosstab_row(szPart, wParentWindow.dDate7)

	Close(w_create_outside_shipper_in_po_grid)

Else
	Rollback;
End If


end subroutine

public subroutine wf_setup_screen ();//************************************************************************
//* Declaration
//************************************************************************
String szScac, szPlant, szTransmode, szDockCode, szUnit

//************************************************************************
//* Initialization
//************************************************************************
sle_destination.text	= szDestination
sle_due_date.text		= String(today())
sle_customer.text    = wf_get_customer(szDestination)

wf_get_trans_mode()			//Get trans mode/plant/scac information
wf_get_dock_model_year(iSalesOrder)	

SetNull(iShipper)

dw_shipper_header.Reset()
dw_shipper_header.InsertRow(1)

wf_setup_shipper_datawindow(iShipper)		//Set datawindow screen
wf_setup_shipper_weight(iShipper)
wf_set_note_bmp()
end subroutine

public subroutine wf_get_std_pack (long iorder);  SELECT order_header.standard_pack, Dock_Code , plant, notes
    INTO :nStdPack ,
			:szDockCode ,
			:szPlant ,
			:szPartNote
    FROM order_header  
   WHERE order_header.order_no = :iOrder   ;

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

public subroutine wf_setup_shipper_datawindow (long ishipper);dw_shipper_header.SetItem(1, "id", iShipper)
dw_shipper_header.SetItem(1, "ship_via", szScac)
dw_shipper_header.SetItem(1, "plant", szPlant)
dw_shipper_header.SetItem(1, "date_stamp", Today())
dw_shipper_header.SetTabOrder("id", 0)
dw_shipper_header.SetItem(1, "shipping_dock", szDockCode)
dw_shipper_header.SetItem(1, "trans_mode", szTransMode)
dw_shipper_header.SetItem(1, "location", szFob)
dw_shipper_header.SetItem(1, "customer", wf_get_customer(szDestination))

end subroutine

public subroutine wf_setup_shipper_weight (long ishipper);Decimal nPartWgt		= 0
Decimal nWgtExclude 	= 0
Decimal nTotalWgt		= 0

nWgtExclude				= wf_calc_shipper_weight(iShipper) 
sle_wgt_exclude.text	= String(Truncate(nWgtExclude, 2))

nTotalWgt				= nWgtExclude + nWeightAdded
sle_total_wgt.text	= String(Truncate(nTotalWgt, 2))
		

end subroutine

public function decimal wf_calc_shipper_weight (long ishipper);String szPart

Long iRow

Decimal nQty
Decimal nTotalWgt = 0

dw_shipper_detail.Retrieve(iShipper)

For iRow = 1 to dw_shipper_detail.RowCount()
	szPart		= dw_shipper_detail.GetItemString(iRow, "part")
	nQty			= dw_shipper_detail.GetItemNumber(iRow, "qty_required")
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
	p_1.pictureName	= "noteno.bmp"
	p_2.pictureName	= "noteno.bmp"
Else
	If bFootNote then
		p_1.PictureName	= "noteyes.bmp"
	Else
		p_1.PictureName	= "noteno.bmp"
	End If

	If bPartNote then
		p_2.PictureName	= "noteyes.bmp"
	Else
		p_2.PictureName	= "noteno.bmp"
	End If
End If


	
end subroutine

public subroutine wf_get_dock_model_year (long isalesorder);  SELECT order_header.model_year,   
         order_header.dock_code ,
			order_header.notes  
    INTO :szCurrentModelYear,   
         :szCurrentDock,  
			:szPartNote
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

If Trim(szPartNote) > " " then
	bPartNote	= TRUE
End If

end subroutine

public subroutine wf_show_detail (boolean bFlag);cb_detail.visible			= bFlag
cb_detail_exit.visible	= bFlag
dw_detail.visible			= bFlag
end subroutine

public subroutine wf_enable_buttons (boolean bFlag);cb_clear.enabled	= bFlag
cb_save.enabled	= bFlag
cb_cancel.enabled	= bFlag
end subroutine

public subroutine wf_create_shipper_detail (string szpart, decimal nqty);//************************************************************************
//* Declaration
//************************************************************************
Integer iRow

Decimal nQtyRequired

Boolean bFound		//Add a new part

//************************************************************************
//* Initialization
//************************************************************************

dw_shipper_detail.Retrieve(iShipper)

iRow   = 1
bFound = FALSE

Do While iRow <= dw_shipper_detail.RowCount() AND (Not bFound)
	If dw_shipper_detail.GetItemString(iRow, "part") = szPart then
		bFound = TRUE
	Else
		iRow = iRow + 1
	End If
Loop

If Not bFound then
	dw_shipper_detail.InsertRow(1)
	iRow				= 1
	nQtyRequired	= 0
Else
	nQtyRequired	= dw_shipper_detail.GetItemNumber(iRow, 'qty_required')
End If

nQty	= nQty + f_get_value(nQtyRequired)
	
dw_shipper_detail.SetItem(iRow, "part", szPart)
dw_shipper_detail.SetItem(iRow, "qty_required", nQty)
dw_shipper_detail.SetItem(iRow, "order_no", 0)
dw_shipper_detail.SetItem(iRow, "qty_original", nQty) 
dw_shipper_detail.SetItem(iRow, "shipper", iShipper)
dw_shipper_detail.SetItem(iRow, "customer_po", szPO)
//dw_shipper_detail.SetItem(iRow, "price", nPrice)
//dw_shipper_detail.SetItem(iRow, "account_code", wf_get_account_code(szPart))
//dw_shipper_detail.SetItem(iRow, "salesman", szSalesman)
dw_shipper_detail.SetItem(iRow, "pack_line_qty", 0)

If Trim(szPartNote) > " " then
	dw_shipper_detail.SetItem(1, "note", szPartNote)
End If

If dw_shipper_detail.Update() > 0 then
	commit;
Else
	rollback;
End If	







end subroutine

public subroutine wf_setup_bill_datawindow ();Long 		iRow			//To keep the row number

String	szPart		//To keep the part number

Decimal	nQty			//To keep the qty required
Decimal	nWeight		//To keep the weight for current part

dw_components.Reset()

nWeightAdded	= 0

For iRow = 1 to dw_bill.RowCount()
	szPart	= dw_bill.GetItemString(iRow, "part")
	nQty		= nQtyRequired * f_get_value(dw_bill.GetItemNumber(iRow, "quantity"))
	nWeight	= f_calc_part_weight(szPart, nQty)
	dw_components.InsertRow(iRow)
	dw_components.SetItem(iRow, "part", szPart)
	dw_components.SetItem(iRow, "qty", nQty)
	dw_components.SetItem(iRow, "weight", nWeight)
	nWeightAdded	= nWeightAdded + nWeight
	sle_total_wgt.text	= String(Truncate(nWeightAdded, 0))
Next
end subroutine

public function decimal wf_qty_at_vendor (string szpart, string szvendor);// Get total qty of part at vendor location

Decimal nQty

SELECT sum(object.std_quantity )  
  INTO :nQty  
  FROM object  
 WHERE object.destination = :szVendor   ;

Return nQty
end function

public subroutine wf_build_part_vendor_qty ();String	szPart
String	szVendor

Integer 	iRow

Decimal	nQty


szVendor	= sle_destination.text
dw_part_vendor_qty.Reset()

For iRow = 1 to dw_components.RowCount()
	dw_part_vendor_qty.InsertRow(1)
	szPart	=	dw_components.GetItemString(iRow, "part")
	dw_part_vendor_qty.SetItem(1, "part", szPart)
	dw_part_vendor_qty.SetItem(1, "qty", wf_qty_at_vendor(szPart, szVendor))
	dw_part_vendor_qty.SetItem(1, "vendor", szVendor)
Next
end subroutine

on open;//************************************************************************
//* Declaration
//************************************************************************


//***********************************************************************
//* Initialization
//***********************************************************************

dw_1.SetTransObject(sqlca)
dw_shipper_header.SetTransObject(sqlca)
dw_shipper_detail.SetTransObject(sqlca)
dw_detail.SetTransObject(sqlca)
dw_bill.SetTransObject(sqlca)					//List of components

bNew	= TRUE
Timer(0.5)

//***********************************************************************
//* Main Routine
//***********************************************************************

stParm			= Message.PowerObjectParm
szDestination 	= stParm.Value1
nQtyRequired	= Dec(stParm.Value2)
szPart			= stParm.Value3
szPO				= stParm.Value4

dw_1.Retrieve(szDestination)
dw_bill.Retrieve(szPart) 

wf_setup_bill_datawindow()			//Create the components datawindow
wf_setup_screen()
wf_build_part_vendor_qty()


end on

on timer;If bFootNote then
	If p_1.picturename="noteno.bmp" then
		p_1.picturename="noteyes.bmp" 
	Else
		p_1.picturename="noteno.bmp" 
	End If
End If

If bPartNote then
	If p_2.picturename="noteno.bmp" then
		p_2.picturename="noteyes.bmp" 
	Else
		p_2.picturename="noteno.bmp" 
	End If
End If




end on

on deactivate;//Close(this)
end on

on w_create_outside_shipper_in_po_grid.create
this.dw_part_vendor_qty=create dw_part_vendor_qty
this.dw_shipper_detail=create dw_shipper_detail
this.dw_bill=create dw_bill
this.dw_components=create dw_components
this.cb_detail_exit=create cb_detail_exit
this.dw_detail=create dw_detail
this.cb_detail=create cb_detail
this.cb_note_save=create cb_note_save
this.mle_note=create mle_note
this.cb_note=create cb_note
this.st_10=create st_10
this.st_7=create st_7
this.p_2=create p_2
this.p_1=create p_1
this.st_4=create st_4
this.sle_total_wgt=create sle_total_wgt
this.sle_wgt_exclude=create sle_wgt_exclude
this.mle_1=create mle_1
this.st_14=create st_14
this.sle_customer=create sle_customer
this.st_3=create st_3
this.cb_clear=create cb_clear
this.sle_due_date=create sle_due_date
this.sle_destination=create sle_destination
this.st_5=create st_5
this.cb_cancel=create cb_cancel
this.st_2=create st_2
this.cb_save=create cb_save
this.dw_1=create dw_1
this.dw_shipper_header=create dw_shipper_header
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.Control[]={this.dw_part_vendor_qty,&
this.dw_shipper_detail,&
this.dw_bill,&
this.dw_components,&
this.cb_detail_exit,&
this.dw_detail,&
this.cb_detail,&
this.cb_note_save,&
this.mle_note,&
this.cb_note,&
this.st_10,&
this.st_7,&
this.p_2,&
this.p_1,&
this.st_4,&
this.sle_total_wgt,&
this.sle_wgt_exclude,&
this.mle_1,&
this.st_14,&
this.sle_customer,&
this.st_3,&
this.cb_clear,&
this.sle_due_date,&
this.sle_destination,&
this.st_5,&
this.cb_cancel,&
this.st_2,&
this.cb_save,&
this.dw_1,&
this.dw_shipper_header,&
this.gb_3,&
this.gb_2,&
this.gb_5,&
this.gb_4,&
this.gb_1}
end on

on w_create_outside_shipper_in_po_grid.destroy
destroy(this.dw_part_vendor_qty)
destroy(this.dw_shipper_detail)
destroy(this.dw_bill)
destroy(this.dw_components)
destroy(this.cb_detail_exit)
destroy(this.dw_detail)
destroy(this.cb_detail)
destroy(this.cb_note_save)
destroy(this.mle_note)
destroy(this.cb_note)
destroy(this.st_10)
destroy(this.st_7)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_4)
destroy(this.sle_total_wgt)
destroy(this.sle_wgt_exclude)
destroy(this.mle_1)
destroy(this.st_14)
destroy(this.sle_customer)
destroy(this.st_3)
destroy(this.cb_clear)
destroy(this.sle_due_date)
destroy(this.sle_destination)
destroy(this.st_5)
destroy(this.cb_cancel)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.dw_shipper_header)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
end on

on activate;//gnv_App.of_GetFrame().Changemenu(m_check_same_destination)
end on

type dw_part_vendor_qty from datawindow within w_create_outside_shipper_in_po_grid
int X=55
int Y=896
int Width=933
int Height=464
int TabOrder=180
string DataObject="dw_external_part_vendor_qty"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	stParm.value1	= this.GetItemString(iRow, "part")
	stParm.value2	= this.GetItemString(iRow, "vendor")

	OpenWithParm(w_view_objects_onhand_and_at_vendor, stParm)
End If
end on

type dw_shipper_detail from datawindow within w_create_outside_shipper_in_po_grid
int X=549
int Y=2144
int Width=494
int Height=360
int TabOrder=250
boolean Visible=false
string DataObject="dw_add_part_to_shipper_detail"
boolean LiveScroll=true
end type

type dw_bill from datawindow within w_create_outside_shipper_in_po_grid
int X=37
int Y=2144
int Width=494
int Height=360
int TabOrder=240
boolean Visible=false
string DataObject="dw_bill_of_material_qty_available"
boolean LiveScroll=true
end type

type dw_components from datawindow within w_create_outside_shipper_in_po_grid
int X=37
int Y=128
int Width=969
int Height=368
int TabOrder=30
string DataObject="dw_external_parts_in_outside_shipper"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;iComponentRow	= this.GetClickedRow()

If iComponentRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iComponentRow, TRUE)
	szPartNote			= this.GetItemString(iComponentRow, "note")
	p_2.PictureName	= "noteno.bmp"
	bPartNote			= (szPartNote > " ")
End If
end on

type cb_detail_exit from commandbutton within w_create_outside_shipper_in_po_grid
int X=2514
int Y=748
int Width=247
int Height=108
int TabOrder=110
boolean Visible=false
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_show_detail(FALSE)
end on

type dw_detail from datawindow within w_create_outside_shipper_in_po_grid
int X=1166
int Y=168
int Width=1591
int Height=548
int TabOrder=40
boolean Visible=false
string DataObject="dw_shipper_detail"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_detail from commandbutton within w_create_outside_shipper_in_po_grid
int X=1061
int Y=96
int Width=1815
int Height=808
int TabOrder=130
boolean Visible=false
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_note_save from commandbutton within w_create_outside_shipper_in_po_grid
int X=2574
int Y=1328
int Width=247
int Height=108
int TabOrder=90
boolean Visible=false
string Text="Save"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If bEnterFootNote then
	szFootNote	= mle_note.text
	p_1.invert	= FALSE
	bFootNote	= (Trim(szFootNote) > " ")
Else
	szPartNote	= mle_note.text
	p_2.invert	= FALSE
	bPartNote	= (Trim(szPartNote) > " ")
	If iComponentRow > 0 then
		dw_components.SetItem(iComponentRow, "note", szPartNote)
	End If
End If

bEnterFootNote	= FALSE
bEnterPartNote	= FALSE

cb_note.visible		= FALSE
cb_note_save.visible	= FALSE
mle_note.visible		= FALSE

wf_enable_buttons(TRUE)
end on

type mle_note from multilineedit within w_create_outside_shipper_in_po_grid
int X=1115
int Y=960
int Width=1710
int Height=356
int TabOrder=200
boolean Visible=false
long TextColor=33554432
long BackColor=16776960
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_note from commandbutton within w_create_outside_shipper_in_po_grid
int X=1056
int Y=924
int Width=1810
int Height=544
int TabOrder=100
boolean Visible=false
boolean Enabled=false
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_create_outside_shipper_in_po_grid
int X=1554
int Y=1632
int Width=210
int Height=52
boolean Enabled=false
string Text="Part Note"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_create_outside_shipper_in_po_grid
int X=1207
int Y=1632
int Width=210
int Height=52
boolean Enabled=false
string Text="Foot Note"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_2 from picture within w_create_outside_shipper_in_po_grid
int X=1445
int Y=1632
int Width=110
int Height=88
string PictureName="noteno.bmp"
boolean FocusRectangle=false
end type

on clicked;If bEnterFootNote then
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

this.invert		= TRUE

cb_note.visible		= TRUE
cb_note_save.visible	= TRUE
mle_note.visible		= TRUE
mle_note.Text			= szPartNote

wf_enable_buttons(FALSE)
end on

type p_1 from picture within w_create_outside_shipper_in_po_grid
int X=1097
int Y=1632
int Width=110
int Height=88
string PictureName="noteno.bmp"
boolean FocusRectangle=false
end type

on clicked;If bEnterPartNote then
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

this.invert		= TRUE

cb_note.visible		= TRUE
cb_note_save.visible	= TRUE
mle_note.visible		= TRUE
mle_note.Text			= szFootNote

wf_enable_buttons(FALSE)


end on

type st_4 from statictext within w_create_outside_shipper_in_po_grid
int X=73
int Y=1632
int Width=366
int Height=68
boolean Enabled=false
string Text="Total Est Wgt"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_total_wgt from singlelineedit within w_create_outside_shipper_in_po_grid
int X=530
int Y=1616
int Width=434
int Height=88
int TabOrder=60
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_wgt_exclude from singlelineedit within w_create_outside_shipper_in_po_grid
int X=530
int Y=1472
int Width=434
int Height=88
int TabOrder=50
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_create_outside_shipper_in_po_grid
int X=73
int Y=1440
int Width=402
int Height=184
int TabOrder=70
boolean Enabled=false
boolean Border=false
string Text="Shipper weight excluding this requirement"
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_create_outside_shipper_in_po_grid
int X=128
int Y=720
int Width=338
int Height=72
boolean Enabled=false
string Text="Customer"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_customer from singlelineedit within w_create_outside_shipper_in_po_grid
int X=512
int Y=704
int Width=416
int Height=88
int TabOrder=140
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_create_outside_shipper_in_po_grid
int X=128
int Y=528
int Width=338
int Height=72
boolean Enabled=false
string Text="Destination"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clear from commandbutton within w_create_outside_shipper_in_po_grid
int X=2011
int Y=1620
int Width=265
int Height=108
int TabOrder=220
string Text="Clear"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If bEnterFootNote or bEnterPartNote then
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

type sle_due_date from singlelineedit within w_create_outside_shipper_in_po_grid
int X=512
int Y=608
int Width=416
int Height=88
int TabOrder=150
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_destination from singlelineedit within w_create_outside_shipper_in_po_grid
int X=512
int Y=512
int Width=416
int Height=88
int TabOrder=120
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_create_outside_shipper_in_po_grid
int X=128
int Y=624
int Width=279
int Height=72
boolean Enabled=false
string Text="Due Date"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_create_outside_shipper_in_po_grid
int X=2597
int Y=1620
int Width=265
int Height=108
int TabOrder=210
string Text="Cancel"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
close(parent)
end on

type st_2 from statictext within w_create_outside_shipper_in_po_grid
int X=1061
int Y=100
int Width=1806
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Single Click to Combine"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
long BorderColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_save from commandbutton within w_create_outside_shipper_in_po_grid
int X=2304
int Y=1620
int Width=265
int Height=108
int TabOrder=160
string Text="Save"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iShipper' (next Shipper number).  */

If bEnterFootNote or bEnterPartNote then
	MessageBox("Warning", "Please save note first")
	Return
End If

If IsNull(iShipper) then
	
	if not sqlca.of_getnextparmvalue ( "shipper", iShipper ) then    // Failed to get current value 	 		-  ADD 01-26-2000 KAZ
		Rollback;																															// ADD 01-26-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Shipper number, Please try again", Exclamation! )	// ADD 01-26-2000 KAZ
		return																																// ADD 01-26-2000 KAZ
	else																																		// ADD 01-26-2000 KAZ
		commit;																																// ADD 01-26-2000 KAZ
		wf_save()	//  Save and Exit																									-  ADD 01-26-2000 KAZ
	end if																																	// ADD 01-26-2000 KAZ

//	bFinish	= FALSE																														-  CHG 01-26-2000 KAZ
//	OpenWithParm(w_get_parm_value, "shipper")																						-  CHG 01-26-2000 KAZ
//	Do While (Not bFinish)		//Wait for close																					-  CHG 01-26-2000 KAZ
//	Loop																																		-  CHG 01-26-2000 KAZ
//	iShipper	= Message.DoubleParm 																									-  CHG 01-26-2000 KAZ

Else
	wf_save()		//Save and Exit
End If
end event

type dw_1 from datawindow within w_create_outside_shipper_in_po_grid
int X=1065
int Y=176
int Width=1806
int Height=728
int TabOrder=20
string DataObject="dw_shippers_with_same_destination"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;//***********************************************************************
//* Declaration
//***********************************************************************
String  szShipDock     	//dock code in current shipper
String  szShipModelYear	//model year in current shipper

Integer iRow				//to keep the current row number
Integer iDetailRow		//to keep the detail row number in shipper detail

//***********************************************************************
//* Initialization
//***********************************************************************
If bEnterFootNote or bEnterPartNote then
	MessageBox("Warning", "Please save note first")
	Return
End If

iRow = dw_1.GetClickedRow()

//***********************************************************************
//* Main Routine
//***********************************************************************

If iRow > 0 then

	If (dw_1.GetItemString(iRow, "status") = "S") AND (dw_1.GetItemString(iRow, "printed") = "Y") then
		MessageBox("Warning", "You can not add part to a staged shipper once document has been printed", StopSign!) 
		Return
	End If

	bNew						= TRUE
	iShipper					= dw_1.GetItemNumber(iRow, "id")	
	szShipDock				= dw_1.GetItemString(iRow, "shipping_dock")
	szShipModelYear		= dw_1.GetItemString(iRow, "model_year")

//	If bCheckDock then
//		If f_get_string_value(szShipDock) <> f_get_string_value(szCurrentDock) then
//			MessageBox("Warning", "Incompatible dock codes", StopSign!)
//			SetNull(iShipper)			
//			Return
//		End If
//	End If
//
//	If bCheckModelYear then
//		If f_get_string_value(szShipModelYear) <> f_get_string_value(szCurrentModelYear) then
//			MessageBox("Warning", "Incompatible model years", StopSign!)
//			SetNull(iShipper)
//			Return
//		End If
//	End If

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
	wf_set_note_bmp()			//Set the note bit map 

End If

end on

on doubleclicked;Integer iRow

iRow = dw_1.GetClickedRow()

If iRow > 0 then
	wf_show_detail(TRUE)
	dw_detail.Retrieve(dw_1.GetItemNumber(iRow, "id"))
End If
end on

type dw_shipper_header from datawindow within w_create_outside_shipper_in_po_grid
int X=1093
int Y=1020
int Width=1760
int Height=504
int TabOrder=170
string DataObject="dw_shipper_header_info"
boolean Border=false
boolean LiveScroll=true
end type

type gb_3 from groupbox within w_create_outside_shipper_in_po_grid
int X=18
int Y=832
int Width=1006
int Height=544
int TabOrder=190
string Text="Total Objects at Vendor Locations"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_create_outside_shipper_in_po_grid
int X=1061
int Y=928
int Width=1815
int Height=676
int TabOrder=260
string Text="Shipper Information"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_create_outside_shipper_in_po_grid
int X=1061
int Y=1536
int Width=859
int Height=192
int TabOrder=230
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_create_outside_shipper_in_po_grid
int X=18
int Y=1376
int Width=1006
int Height=352
int TabOrder=80
string Text="Estimated Weight"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_create_outside_shipper_in_po_grid
int X=18
int Y=64
int Width=1006
int Height=752
int TabOrder=10
string Text="Shipping Requirement"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

