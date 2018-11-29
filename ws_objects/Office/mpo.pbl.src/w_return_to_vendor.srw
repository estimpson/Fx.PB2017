$PBExportHeader$w_return_to_vendor.srw
forward
global type w_return_to_vendor from Window
end type
type uo_for_note from uo_note within w_return_to_vendor
end type
type uo_shipper from u_shipper_header_for_return_to_vendor within w_return_to_vendor
end type
type dw_shipper_detail from datawindow within w_return_to_vendor
end type
type st_3 from statictext within w_return_to_vendor
end type
type st_2 from statictext within w_return_to_vendor
end type
type p_3 from picture within w_return_to_vendor
end type
type p_2 from picture within w_return_to_vendor
end type
type st_1 from statictext within w_return_to_vendor
end type
type p_1 from picture within w_return_to_vendor
end type
type dw_shipper_header from datawindow within w_return_to_vendor
end type
type dw_object from datawindow within w_return_to_vendor
end type
type gb_3 from groupbox within w_return_to_vendor
end type
type gb_2 from groupbox within w_return_to_vendor
end type
type gb_1 from groupbox within w_return_to_vendor
end type
end forward

global type w_return_to_vendor from Window
int X=0
int Y=8
int Width=2926
int Height=1900
boolean TitleBar=true
string Title="Return to Vendor"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event save_shipper_header pbm_custom01
event close_uo pbm_custom02
event create_shipper pbm_custom03
uo_for_note uo_for_note
uo_shipper uo_shipper
dw_shipper_detail dw_shipper_detail
st_3 st_3
st_2 st_2
p_3 p_3
p_2 p_2
st_1 st_1
p_1 p_1
dw_shipper_header dw_shipper_header
dw_object dw_object
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_return_to_vendor w_return_to_vendor

type variables
String szPart
String szVendor
String szUnit
String szVendorPart
String szDescription
String szLot
String szStatus
String szPoNumber
String szDestination

Long  lPoNumber
Long  lSerial
Long  iShipper

Dec   dQuantity
Dec   nUnitWeight
Dec   nTareWeight
Dec   nStdQty

DataWindowChild dwcDest

Boolean bValidSerial = FALSE  //Whether a valid serial# scanned
Boolean bValidDestination = FALSE
end variables

forward prototypes
public subroutine disable_entry ()
public subroutine enable_entry ()
public function boolean wf_part_exists_in_shipper (long ishipper, string szpart)
public function boolean wf_add_part_to_shipper_detail (long ishipper, string szpart, decimal nqty, string szunit)
public function boolean wf_create_shipper_detail (long ishipper, string szpart, decimal nqtypacked, string szunit, decimal ntareweight, decimal nnetweight, decimal ngrossweight)
public function boolean wf_retrieve_object_info (long iserial)
public function boolean wf_select_vendor_part (string szvendor, string szpart)
public function string wf_get_vendor_code (long ipo)
end prototypes

event save_shipper_header;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iShipper' (next Shipper number).  Also placed the rollback
						before the message boxes to release the database to avoid deadlocks.     */

//bFinish	= FALSE																										-  CHG 01-26-2000 KAZ
//OpenWithParm(w_get_parm_value, "shipper")																		-  CHG 01-26-2000 KAZ
//Do while Not bFinish																									-  CHG 01-26-2000 KAZ
//Loop																														-  CHG 01-26-2000 KAZ
//
//iShipper	= Message.DoubleParm																						-  CHG 01-26-2000 KAZ
//
//If iShipper > 0 then																									-  CHG 01-26-2000 KAZ

if sqlca.of_getnextparmvalue ( "shipper", iShipper ) then 													// ADD 01-26-2000 KAZ

	uo_shipper.dw_shipper_header.SetItem(1, "id", iShipper)

	If uo_shipper.dw_shipper_header.Update() > 0 then
		If wf_create_shipper_detail(iShipper, szPart, dQuantity, szUnit,&
											 nTareWeight, (nUnitWeight * nStdQty), &
											 nTareWeight + (nUnitWeight * nStdQty)) then
			Commit;
			dw_shipper_header.Retrieve(szVendor)
		Else
			Rollback;																										// CHG 01-26-2000 KAZ
			MessageBox("SQL Error", SQLCA.SQLErrText, StopSign!)
//			Rollback;																										-  CHG 01-26-2000 KAZ
		End If
	Else
		Rollback;
	End If

Else
	Rollback;																												// ADD 01-26-2000 KAZ
	MessageBox("Warning", "Failed to create a new shipper, please try again.", StopSign!)
End If

uo_shipper.visible	= FALSE
bValidSerial			= FALSE
bValidDestination		= FALSE

dw_object.Reset()
dw_object.InsertRow(1)
end event

on close_uo;uo_shipper.visible	= FALSE
end on

on create_shipper;If Not bValidDestination then
	MessageBox("Warning", "Please select destination first.", StopSign!)
	Return 
End If

If bValidSerial then
	uo_shipper.visible				= TRUE
	uo_shipper.uf_setup(szVendor, w_return_to_vendor)
Else
	MessageBox("Warning", "Invalid serial number for return to vendor.", StopSign!)
End If
end on

public subroutine disable_entry ();dw_object.SetTabOrder ( "quantity", 0 )
dw_object.SetTabOrder ( "unit", 0 )
dw_object.SetTabOrder ( "destination", 0 )
end subroutine

public subroutine enable_entry ();dw_object.SetTabOrder ( "quantity", 20 )
dw_object.SetTabOrder ( "unit", 30 )
dw_object.SetTabOrder ( "destination", 40 )
end subroutine

public function boolean wf_part_exists_in_shipper (long ishipper, string szpart);String iCurrentShipper

Select shipper_detail.shipper  
  Into :iCurrentShipper  
  From shipper_detail  
 Where ( shipper_detail.shipper = :iShipper ) AND  
       ( shipper_detail.part = :szPart );


If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function boolean wf_add_part_to_shipper_detail (long ishipper, string szpart, decimal nqty, string szunit);Decimal	nQtyPacked
Decimal	nQtyRequired
Decimal	nStdQtyPacked
Decimal	nQtyConverted

String 	szUMPacked

Select shipper_detail.alternative_qty,   
       shipper_detail.alternative_unit,   
       shipper_detail.qty_required,   
       shipper_detail.qty_packed  
  Into :nQtyPacked,   
       :szUMPacked,   
       :nQtyRequired,   
       :nStdQtyPacked  
  From shipper_detail  
 Where ( shipper_detail.shipper = :iShipper ) And
       ( shipper_detail.part 	= :szPart )   ;

nQtyConverted	= f_convert_units(szUnit, f_get_string_value(szUMPacked), szPart, nQty) 
nQtyPacked		= f_get_value(nQtyPacked) + nQtyConverted
nQtyRequired	= f_get_value(nQtyRequired) + nQtyConverted

nQtyConverted	= f_convert_units(szUnit, "", szPart, nQty)
nStdQtyPacked	= f_get_value(nStdQtyPacked) + nQtyConverted

Update shipper_detail  
   Set qty_packed = :nStdQtyPacked,
		 qty_required = :nQtyRequired,   
       alternative_qty = :nQtyPacked  
 Where ( shipper = :iShipper ) AND  
       ( part = :szPart )   ;

If SQLCA.SQLCode = 0 then

	Update object  
  	Set shipper 				= :iShipper,
		 show_on_shipper 	= 'Y' 
   Where serial 	= :lSerial   ;

	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return FALSE
End If
end function

public function boolean wf_create_shipper_detail (long ishipper, string szpart, decimal nqtypacked, string szunit, decimal ntareweight, decimal nnetweight, decimal ngrossweight);Decimal nStdQtyPacked

nStdQtyPacked	= f_convert_units(szUnit, "", szPart, nQtyPacked) 

  Insert Into shipper_detail  
         ( shipper,   
           part,   
           qty_required,   
           qty_packed,   
           qty_original,   
           accum_shipped,   
           order_no,   
           customer_po,   
           release_no,   
           release_date,   
           type,   
           price,   
           account_code,   
           salesman,   
           tare_weight,   
           gross_weight,   
           net_weight,   
           date_shipped,   
           assigned,   
           packaging_job,   
           note,   
           operator,   
           boxes_staged,   
           pack_line_qty,   
           alternative_qty,   
           alternative_unit,   
           week_no,   
           taxable,   
           price_type,   
           cross_reference,   
           customer_part,   
           dropship_po,   
           dropship_po_row_id,   
           dropship_oe_row_id )  
  Values ( :iShipper,   
           :szPart,   
           :nQtyPacked,   
           :nStdQtyPacked,   
           :nQtyPacked,   
           null,   
           0,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :nTareWeight,   
           :nGrossWeight,   
           :nNetWeight,   
           null,   
           null,   
           null,   
           null,   
           null,   
           1,   
           null,   
           :nQtyPacked,   
           :szUnit,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

If SQLCA.SQLCode = 0 then

	Update object  
  	Set shipper 				= :iShipper,
		 show_on_shipper 	= 'Y' 
   Where serial 	= :lSerial   ;

	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE		
	End If

Else
	Return FALSE
End If

end function

public function boolean wf_retrieve_object_info (long iserial);iShipper = 0

SELECT 	object.serial,   
       	object.part,   
       	object.unit_measure,   
       	object.po_number,   
       	object.quantity,
			object.lot,
			object.status,
			object.tare_weight,
			object.weight,
			object.std_quantity, 
			object.shipper			
  INTO 	:lSerial,   
         :szPart,   
         :szUnit,   
         :szPoNumber,   
         :dQuantity,
			:szLot,
			:szStatus,
			:nTareWeight,
			:nUnitWeight,
			:nStdQty,
			:iShipper
     FROM object  
    WHERE object.serial = :lSerial   ;

If iShipper > 0 then
	MessageBox("Warning", "This object has already staged on shipper " + String(iShipper), Stopsign!)
	dw_object.Reset()
	dw_object.InsertRow(1)
	Return  FALSE
Else
	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		MessageBox ( "Error", "Unable to find~rserial number!", StopSign! )
		Return FALSE
	End If
End If
end function

public function boolean wf_select_vendor_part (string szvendor, string szpart);SELECT part_vendor.vendor_part  
  INTO :szVendorPart  
  FROM part_vendor  
 WHERE ( part_vendor.part = :szPart ) AND  
       ( part_vendor.vendor = :szVendor )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function string wf_get_vendor_code (long ipo);String szVendor

SELECT po_header.vendor_code  
  INTO :szVendor  
  FROM po_header  
 WHERE po_header.po_number = :iPO   ;

Return szVendor
end function

on open;dw_shipper_header.SetTransObject ( sqlca )
dw_shipper_detail.SetTransObject ( sqlca )


dw_object.InsertRow ( 1 )

disable_entry ( )
end on

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_return_to_vendor )
end on

on w_return_to_vendor.create
this.uo_for_note=create uo_for_note
this.uo_shipper=create uo_shipper
this.dw_shipper_detail=create dw_shipper_detail
this.st_3=create st_3
this.st_2=create st_2
this.p_3=create p_3
this.p_2=create p_2
this.st_1=create st_1
this.p_1=create p_1
this.dw_shipper_header=create dw_shipper_header
this.dw_object=create dw_object
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_for_note,&
this.uo_shipper,&
this.dw_shipper_detail,&
this.st_3,&
this.st_2,&
this.p_3,&
this.p_2,&
this.st_1,&
this.p_1,&
this.dw_shipper_header,&
this.dw_object,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_return_to_vendor.destroy
destroy(this.uo_for_note)
destroy(this.uo_shipper)
destroy(this.dw_shipper_detail)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_shipper_header)
destroy(this.dw_object)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type uo_for_note from uo_note within w_return_to_vendor
int X=823
int Y=336
boolean Visible=false
long BackColor=78682240
end type

on uo_for_note.destroy
call uo_note::destroy
end on

type uo_shipper from u_shipper_header_for_return_to_vendor within w_return_to_vendor
int X=549
int Y=224
boolean Visible=false
end type

on uo_shipper.destroy
call u_shipper_header_for_return_to_vendor::destroy
end on

type dw_shipper_detail from datawindow within w_return_to_vendor
int X=1829
int Y=640
int Width=987
int Height=736
int TabOrder=20
string DataObject="dw_shipper_detail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_3 from statictext within w_return_to_vendor
int X=1518
int Y=576
int Width=219
int Height=64
boolean Enabled=false
string Text="Printed"
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

type st_2 from statictext within w_return_to_vendor
int X=1152
int Y=576
int Width=238
int Height=64
boolean Enabled=false
string Text="Staged"
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

type p_3 from picture within w_return_to_vendor
int X=1426
int Y=576
int Width=73
int Height=64
string PictureName="printer.bmp"
boolean FocusRectangle=false
end type

type p_2 from picture within w_return_to_vendor
int X=1061
int Y=576
int Width=73
int Height=64
string PictureName="logo2.bmp"
boolean FocusRectangle=false
end type

type st_1 from statictext within w_return_to_vendor
int X=731
int Y=576
int Width=311
int Height=64
boolean Enabled=false
string Text=" Foot Note"
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

type p_1 from picture within w_return_to_vendor
int X=658
int Y=576
int Width=73
int Height=64
string PictureName="noteyes.bmp"
boolean FocusRectangle=false
end type

type dw_shipper_header from datawindow within w_return_to_vendor
int X=73
int Y=640
int Width=1682
int Height=736
int TabOrder=40
string DataObject="dw_list_of_shippers"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on doubleclicked;/*
Declare Variables
*/

Long iRow
Long iShipper

/*
Initialize Variables
*/

If Not bValidSerial then
	MessageBox("Warning", "Please scan a valid serial number first.", StopSign!)
	Return
End If

If Not bValidDestination then
	MessageBox("Warning", "Please select destination first.", StopSign!)
	Return 
End If

iRow = dw_shipper_header.GetClickedRow ( )

If iRow > 0 then
	iShipper = f_get_value ( dw_shipper_header.GetItemNumber ( iRow, "id" ) )
	If wf_part_exists_in_shipper(iShipper, szPart) then
		If wf_add_part_to_shipper_detail(iShipper, szPart, dQuantity, szUnit) then
			Commit;
			f_beep(1)
			dw_shipper_detail.Retrieve(iShipper)
			dw_object.Reset()
			dw_object.InsertRow(1)
			bValidSerial	= FALSE
			MessageBox("System Message", "Shipper detail has been created successfully.", Information!)			
		Else
			f_beep(3)
			MessageBox("SQL Error", SQLCA.SQLErrText, StopSign!)
			Rollback;
		End If
	Else
		If wf_create_shipper_detail(iShipper, szPart, dQuantity, szUnit,&
											 nTareWeight, (nUnitWeight * nStdQty), &
											 nTareWeight + (nUnitWeight * nStdQty)) then
			Commit;
			dw_shipper_detail.Retrieve(iShipper)
			MessageBox("System Message", "A new shipper detail item has been created successfully.", Information!)			
		Else
			MessageBox("SQL Error", SQLCA.SQLErrText, StopSign!)
			Rollback;
		End If
	End If
End If

dw_object.Reset()
dw_object.InsertRow(1)

bValidSerial		= FALSE
bValidDestination	= FALSE
end on

on clicked;/*
Declare Variables
*/

Long lRow


/*
Initialize Variables
*/

lRow = dw_shipper_header.GetClickedRow ( )

If lRow < 1 Then Return

SelectRow ( dw_shipper_header, 0, False )
SelectRow ( dw_shipper_header, lRow, True )

dw_shipper_detail.SetTransObject ( sqlca )
dw_shipper_detail.Retrieve ( f_get_value ( dw_shipper_header.GetItemNumber ( lRow, "id" ) ) )
end on

type dw_object from datawindow within w_return_to_vendor
int X=256
int Y=64
int Width=2377
int Height=480
int TabOrder=10
string DataObject="d_rtv_object_info"
boolean Border=false
end type

on itemchanged;Long 		lColumn

lColumn = dw_object.GetColumn ( )

If lColumn = 1 Then

	bValidSerial	= FALSE
	lSerial 			= f_get_value ( Long ( dw_object.GetText ( ) ) )

	If lSerial = 0 then 
		bValidSerial	= FALSE
		Return
	End If

	If wf_retrieve_object_info(lSerial) then 	
		szPart     		= f_get_string_value ( szPart )
		szUnit     		= f_get_string_value ( szUnit )
		szPoNumber 		= f_get_string_value ( szPoNumber )
		dQuantity  		= f_get_value ( dQuantity )
		szLot      		= f_get_string_value ( szLot )
		szStatus   		= f_get_string_value ( szStatus )
		szDescription 	= f_get_part_info(szPart, "NAME")
	
		lPoNumber = f_get_value ( Long ( szPoNumber ) )

		SELECT po_header.vendor_code,
		  INTO :szVendor  
        FROM po_header  
       WHERE po_header.po_number = :lPoNumber   ;

		If SQLCA.SQLCode = 0 Then

			bValidSerial	= TRUE
			szVendor 		= f_get_string_value ( szVendor )

			dw_shipper_header.Retrieve ( szVendor )

			dw_object.dwGetChild ( "destination", dwcDest )
			dwcDest.SetTransObject ( sqlca )
			dwcDest.Retrieve ( szVendor )

			wf_select_vendor_part(szVendor, szPart)
	
		Else

			bValidSerial	= FALSE
			MessageBox ( "Error", "Unable to find~rPurchase Order!", StopSign! )
			
		End if

		dw_object.SetItem ( 1, "quantity", dQuantity )
		dw_object.SetItem ( 1, "unit", szUnit )
		dw_object.SetItem ( 1, "part", szPart )
		dw_object.SetItem ( 1, "description", szDescription )
		dw_object.SetItem ( 1, "status", szStatus )
		dw_object.SetItem ( 1, "po_number", lPoNumber )
		dw_object.SetItem ( 1, "vendor_part", szVendorPart )
		dw_object.SetItem ( 1, "vendor", szVendor )

	End if

Enable_entry ( )

Elseif lColumn = 11 Then

	bValidDestination		= FALSE
	
	szDestination 			= dw_object.GetText ( )

	bValidDestination 	= (szDestination > " ")
	If bValidDestination	then
		dw_shipper_header.SetTransObject ( sqlca )
		dw_shipper_header.Retrieve ( szDestination )
	End If

End if


end on

type gb_3 from groupbox within w_return_to_vendor
int X=1792
int Y=576
int Width=1061
int Height=832
string Text="Shipper Detail:"
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

type gb_2 from groupbox within w_return_to_vendor
int X=37
int Y=576
int Width=1755
int Height=832
string Text="Shipper Headers:"
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

type gb_1 from groupbox within w_return_to_vendor
int X=37
int Width=2816
int Height=576
string Text="Object Information:"
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

