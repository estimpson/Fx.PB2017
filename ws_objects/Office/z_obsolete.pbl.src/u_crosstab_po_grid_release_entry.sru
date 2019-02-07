$PBExportHeader$u_crosstab_po_grid_release_entry.sru
$PBExportComments$(mrs) Added the process for 862 mode.
forward
global type u_crosstab_po_grid_release_entry from UserObject
end type
type sle_price from editmask within u_crosstab_po_grid_release_entry
end type
type sle_other_charge from editmask within u_crosstab_po_grid_release_entry
end type
type st_othercharge from statictext within u_crosstab_po_grid_release_entry
end type
type sle_promise_date from editmask within u_crosstab_po_grid_release_entry
end type
type st_10 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_dragdrop_date from editmask within u_crosstab_po_grid_release_entry
end type
type dw_price_matrix from datawindow within u_crosstab_po_grid_release_entry
end type
type st_po_um from statictext within u_crosstab_po_grid_release_entry
end type
type st_std_um from statictext within u_crosstab_po_grid_release_entry
end type
type sle_std_pack from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_8 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_min_on_order from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_7 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_lead_time from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_6 from statictext within u_crosstab_po_grid_release_entry
end type
type st_5 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_release from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_4 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_po_qty from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_3 from statictext within u_crosstab_po_grid_release_entry
end type
type sle_std_qty from singlelineedit within u_crosstab_po_grid_release_entry
end type
type st_2 from statictext within u_crosstab_po_grid_release_entry
end type
type st_1 from statictext within u_crosstab_po_grid_release_entry
end type
end forward

global type u_crosstab_po_grid_release_entry from UserObject
int Width=1051
int Height=896
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
sle_price sle_price
sle_other_charge sle_other_charge
st_othercharge st_othercharge
sle_promise_date sle_promise_date
st_10 st_10
sle_dragdrop_date sle_dragdrop_date
dw_price_matrix dw_price_matrix
st_po_um st_po_um
st_std_um st_std_um
sle_std_pack sle_std_pack
st_8 st_8
sle_min_on_order sle_min_on_order
st_7 st_7
sle_lead_time sle_lead_time
st_6 st_6
st_5 st_5
sle_release sle_release
st_4 st_4
sle_po_qty sle_po_qty
st_3 st_3
sle_std_qty sle_std_qty
st_2 st_2
st_1 st_1
end type
global u_crosstab_po_grid_release_entry u_crosstab_po_grid_release_entry

type variables
Private:
String	is_Part		//Part number
String	is_Vendor	//Vendor code 

String       is_currency_unit
end variables

forward prototypes
public function decimal uf_get_price (string as_vendor, string as_part, decimal ac_qty)
public subroutine uf_reset ()
public subroutine uf_create_po_detail (long al_po, string as_part, string as_plant, boolean ab_830_mode, transaction atransaction)
public subroutine uf_setup (string as_dragdropdate, string as_stdqty, string as_poqty, string as_release, string as_price, string as_leadtime, string as_minorderqty, string as_stdpack, string as_stdum, string as_poum, string as_vendor, string as_part, string as_currency_unit)
end prototypes

public function decimal uf_get_price (string as_vendor, string as_part, decimal ac_qty);/*
Description :	This function will get the price from the price matrix 
					for specified vendor and part.
Author	   :	Jim Wu
Date		   :	12/21/95
Modification:
*/

/* Declaration */			

Integer li_TotalRows
Integer li_Row
Decimal lc_Price
Boolean lb_Found
 
/* Initialization */
lb_Found	= FALSE
li_TotalRows	= dw_price_matrix.RowCount()
li_Row		= li_TotalRows

/* Search the price matrix and get the price */
Do while (Not lb_Found) AND (li_Row > 0)
	lb_Found = (ac_Qty >= &
					dw_price_matrix.GetItemNumber(li_Row, "break_qty"))

	if Not lb_Found then
		li_Row --

	end if

Loop

If li_Row = 0 then		//If no row matches, the system will use the std cost.
	lb_Found	= FALSE
End If

IF lb_Found AND li_row > 0 THEN	
	sqlca.of_calculate_multicurrency_price ( dw_price_matrix.GetItemString ( li_row, 5 ), is_currency_unit, &
			Truncate(dw_price_matrix.GetItemNumber(li_Row, 6) + 0.0000009, 6), lc_Price )
ELSE
	sqlca.of_calculate_multicurrency_price ( '', is_currency_unit, &
			Truncate(Dec(f_get_part_info(as_part, "STANDARD COST")) + 0.0000009, 6), lc_price )
	
	IF ac_Qty > 0 THEN
		lc_Price	= f_convert_units ( st_po_um.text, "", as_Part, ac_Qty ) * lc_Price / ac_Qty
	ELSE
		lc_Price	= 0
	END IF

END IF

RETURN lc_Price




end function

public subroutine uf_reset ();/*
Description:Reset the screen
Author:		Jim Wu
Date:			06/12/96
Modification:
*/

/* Declaration */


/* Initialization */

sle_dragdrop_date.text	= ''
sle_std_qty.text			= ''
sle_po_qty.text			= ''
sle_release.text			= ''
sle_lead_time.text		= ''
sle_min_on_order.text	= ''
sle_std_pack.text			= ''
st_std_um.text				= 'UM'
st_po_um.text				= 'UM'
is_Vendor					= ''
is_Part						= ''
sle_price.text				= ''



end subroutine

public subroutine uf_create_po_detail (long al_po, string as_part, string as_plant, boolean ab_830_mode, transaction atransaction);/*
Description	:	To create PO detail 
Author		:	Jim Wu
Start Date	:	06/13/1996
Modification:	12/09/1999 Kevin A. Zerba Issue # 13082 - move part name from part table
																			to description field in po_detail
*/

/* Declaration */
string	ls_terms, &
			ls_vendor, &
			ls_type, &
			ls_status, &
			ls_destination, &
			ls_ship_type, &
			ls_ship_via, &
			ls_um, &
			ls_std_um, &
			ls_description, &
			ls_account, &
			ls_release_type

date		ld_due_date, ld_promise_date
datetime	ldt_due_date, ldt_promise_date

long		ll_release, &
			ll_row_id

integer	li_week_no

decimal	lc_qty, &
			lc_price, &
			lc_standard_qty, &
			lc_other_charge

window	lw_dummy

st_generic_structure	lstr_parm

/* Initialization */

ld_due_date	= date( sle_dragdrop_date.text )
ldt_due_date	= datetime(ld_due_date)
lc_qty		= dec( sle_po_qty.text )
lc_standard_qty	= dec( sle_std_qty.text )
lc_price	= dec( sle_price.text )
ls_um		= st_po_um.text
ls_std_um	= st_std_um.text
ld_promise_date = date(sle_promise_date.text)
ldt_promise_date = datetime(ld_promise_date) 
lc_other_charge  = dec( sle_other_charge.text )

IF ISNULL( dec( sle_std_qty.text )) OR DEC ( sle_std_qty.text ) = 0 THEN 
    wmainscreen.SetMicroHelp ( "Enter a valid quantity!" )
    sle_std_qty.SetFocus ()
    RETURN
END IF


IF ISNULL(dec( sle_po_qty.text )) OR DEC ( sle_po_qty.text ) = 0 THEN 
    wmainscreen.SetMicroHelp ( "Enter a valid quantity!" )
    sle_po_qty.SetFocus ()
    RETURN
END IF

IF ( DEC ( sle_std_qty.text ) < DEC ( sle_min_on_order.text ) )  OR & 
	( DEC ( sle_po_qty.text ) < DEC ( sle_min_on_order.text ) ) THEN
	
	wmainscreen.setmicrohelp ( "You cannot order qty lesser than minimum on order qty!" )
	sle_std_qty.text= ''
	sle_po_qty.text = ''
   sle_std_qty.SetFocus ()
   RETURN

END IF

// MB 01/27/04 Modified to get next seq no from po header table
ll_row_id = f_get_podet_next_seqno ( al_po )

ls_account			= f_get_part_info(as_part, "GL ACCOUNT")

IF ab_830_mode THEN
	ls_release_type	= '2'
ELSE
	ls_release_type	= '1'
END IF

li_week_no	= f_get_week_no( ld_due_date )

SELECT 	po_header.vendor_code,   
       	po_header.terms,   
       	po_header.ship_via,   
       	po_header.ship_to_destination,   
       	po_header.status,   
       	po_header.type,   
       	po_header.ship_type,   
       	po_header.release_no,
	po_header.plant  
INTO 	:ls_vendor,   
        :ls_terms,   
        :ls_ship_via,   
        :ls_destination,   
       	:ls_status,   
        :ls_type,   
        :ls_ship_type,   
        :ll_release,
	:as_plant 
FROM 	po_header  
WHERE 	po_number = :al_po
USING	atransaction;

/* 12/09/1999 KAZ Changed to include Part Name in description */

SELECT name 
INTO  :ls_description
FROM part
WHERE part = :as_part
USING	atransaction;

/* Main Process */

INSERT INTO po_detail  
         ( 	po_number,   
         	vendor_code,   
         	part_number,   
         	description,   
         	unit_of_measure,   
         	date_due,   
         	requisition_number,   
         	status,   
         	type,   
         	last_recvd_date,   
         	last_recvd_amount,   
         	cross_reference_part,   
         	account_code,   
         	notes,   
         	quantity,   
         	received,   
         	balance,   
         	active_release_cum,   
         	received_cum,   
         	alternate_price,   
         	row_id,   
         	invoice_status,   
         	invoice_date,   
         	invoice_qty,   
         	invoice_unit_price,   
         	release_no,   
         	ship_to_destination,   
         	terms,   
         	week_no,   
         	plant,   
         	invoice_number,   
         	standard_qty,   
         	sales_order,   
         	dropship_oe_row_id,   
         	ship_type,   
         	dropship_shipper,   
         	price_unit,   
         	printed,   
         	selected_for_print,   
         	deleted,   
         	ship_via, 
		release_type,
		promise_date,
		other_charge )  
  VALUES ( 	:al_po,   
           	:ls_vendor,   
           	:as_part,   
           	:ls_description,   
           	:ls_um,   
           	:ldt_due_date,   
           	null,   
           	'A',   
           	:ls_type,   
           	null,   
           	0,   
           	null,   
           	:ls_account,   
           	null,   
           	:lc_qty,   
           	0,   
           	:lc_qty,   
           	0,   
           	0,   
           	:lc_price,   
           	:ll_row_id,   
           	null,   
           	null,   
           	null,   
           	null,   
           	:ll_release,   
           	:ls_destination,   
           	:ls_terms,   
           	:li_week_no,   
           	:as_plant,   
           	null,   
           	:lc_standard_qty,   
           	null,   
           	null,   
           	null,   
           	null,   
           	null,   
           	'N',   
           	null,   
           	null,   
           	:ls_ship_via,
		:ls_release_type,
		:ldt_promise_date,
		:lc_other_charge) 
USING	 atransaction ;

if atransaction.SQLCode = 0 then

	// MB 01/27/04 update po_header with next seq no 
	ll_row_id++
	
	Update po_header
	Set  next_seqno = :ll_row_id 
	Where po_number = :al_po ;
			
	IF sqlca.sqlcode <> 0 THEN
			rollback ;
			messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
	END IF

	COMMIT USING atransaction;	

	if not ab_830_mode then	//need to reset for 862 mode
		f_reset_po_for_862_mode( 	al_po, &
											as_part, &
											lc_qty, &
											ld_due_date, &
											atransaction 	)
	end if

	f_recalc_po_detail_per_part(al_po, as_part, lw_dummy)
	f_update_qty_asgnd_part ( as_part ) 
	
	if f_get_activity(as_part) = "OUTSIDE" then
		lstr_parm.value1	= ls_vendor
		lstr_parm.value2	= string(lc_qty)
		lstr_parm.value3	= as_part
		lstr_parm.value4	= string(al_PO)
		
		openwithparm(w_create_outside_shipper_in_po_grid, lstr_parm)
	end if

	w_po_schedule_grid.event  ue_partial_updt_crosstab ( as_part, lc_standard_qty )
	messagebox( monsys.msg_title, 'PO detail has been created successfully.', &
					information! )
else
	ROLLBACK USING atransaction;
	messagebox( monsys.msg_title, 'Failed to create PO detail.', information! )
end if

wmainscreen.SetMicroHelp ( "Ready" )
end subroutine

public subroutine uf_setup (string as_dragdropdate, string as_stdqty, string as_poqty, string as_release, string as_price, string as_leadtime, string as_minorderqty, string as_stdpack, string as_stdum, string as_poum, string as_vendor, string as_part, string as_currency_unit);/*
Description:This object is used for entering release data after dragdrop
				from PO MPS scheduler to vendor. This is the function which
				sets up the screen.
Author:		Jim Wu
Date:			12/21/95
Modification:
*/

/* Declaration */

/* Initialization */

sle_dragdrop_date.text	= as_DragDropDate
sle_std_qty.text			= as_StdQty
sle_po_qty.text			= as_POQty
sle_release.text			= as_Release
sle_lead_time.text		= as_LeadTime
sle_min_on_order.text	= as_MinOrderQty
sle_std_pack.text			= as_StdPack
st_std_um.text				= as_StdUM
st_po_um.text				= as_POUM
is_Vendor					= as_Vendor
is_Part						= as_Part
is_currency_unit			= as_currency_unit

dw_price_matrix.SetTransObject(SQLCA)
dw_price_matrix.Retrieve ( as_Vendor, as_Part )

sle_price.text	= String ( uf_get_price(is_Vendor, is_Part, Dec(sle_po_qty.text)) )



end subroutine

on u_crosstab_po_grid_release_entry.create
this.sle_price=create sle_price
this.sle_other_charge=create sle_other_charge
this.st_othercharge=create st_othercharge
this.sle_promise_date=create sle_promise_date
this.st_10=create st_10
this.sle_dragdrop_date=create sle_dragdrop_date
this.dw_price_matrix=create dw_price_matrix
this.st_po_um=create st_po_um
this.st_std_um=create st_std_um
this.sle_std_pack=create sle_std_pack
this.st_8=create st_8
this.sle_min_on_order=create sle_min_on_order
this.st_7=create st_7
this.sle_lead_time=create sle_lead_time
this.st_6=create st_6
this.st_5=create st_5
this.sle_release=create sle_release
this.st_4=create st_4
this.sle_po_qty=create sle_po_qty
this.st_3=create st_3
this.sle_std_qty=create sle_std_qty
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.sle_price,&
this.sle_other_charge,&
this.st_othercharge,&
this.sle_promise_date,&
this.st_10,&
this.sle_dragdrop_date,&
this.dw_price_matrix,&
this.st_po_um,&
this.st_std_um,&
this.sle_std_pack,&
this.st_8,&
this.sle_min_on_order,&
this.st_7,&
this.sle_lead_time,&
this.st_6,&
this.st_5,&
this.sle_release,&
this.st_4,&
this.sle_po_qty,&
this.st_3,&
this.sle_std_qty,&
this.st_2,&
this.st_1}
end on

on u_crosstab_po_grid_release_entry.destroy
destroy(this.sle_price)
destroy(this.sle_other_charge)
destroy(this.st_othercharge)
destroy(this.sle_promise_date)
destroy(this.st_10)
destroy(this.sle_dragdrop_date)
destroy(this.dw_price_matrix)
destroy(this.st_po_um)
destroy(this.st_std_um)
destroy(this.sle_std_pack)
destroy(this.st_8)
destroy(this.sle_min_on_order)
destroy(this.st_7)
destroy(this.sle_lead_time)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_release)
destroy(this.st_4)
destroy(this.sle_po_qty)
destroy(this.st_3)
destroy(this.sle_std_qty)
destroy(this.st_2)
destroy(this.st_1)
end on

type sle_price from editmask within u_crosstab_po_grid_release_entry
int X=530
int Y=352
int Width=384
int Height=80
int TabOrder=50
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.0000"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_other_charge from editmask within u_crosstab_po_grid_release_entry
int X=530
int Y=436
int Width=384
int Height=80
int TabOrder=60
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.0000"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_othercharge from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=428
int Width=297
int Height=76
boolean Enabled=false
string Text="Other Charge"
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

type sle_promise_date from editmask within u_crosstab_po_grid_release_entry
int X=530
int Y=752
int Width=384
int Height=80
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;if isnull(text) then text = sle_dragdrop_date.text
end event

type st_10 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=752
int Width=389
int Height=72
boolean Enabled=false
string Text="Promise Date"
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

type sle_dragdrop_date from editmask within u_crosstab_po_grid_release_entry
int X=530
int Y=36
int Width=384
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_price_matrix from datawindow within u_crosstab_po_grid_release_entry
int X=32
int Y=920
int Width=873
int Height=648
int TabOrder=80
boolean Visible=false
string DataObject="dw_smart_vendor_part_price_matrix"
boolean LiveScroll=true
end type

type st_po_um from statictext within u_crosstab_po_grid_release_entry
int X=933
int Y=196
int Width=146
int Height=64
boolean Enabled=false
string Text="UM"
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

type st_std_um from statictext within u_crosstab_po_grid_release_entry
int X=933
int Y=112
int Width=146
int Height=64
boolean Enabled=false
string Text="UM"
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

type sle_std_pack from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=672
int Width=384
int Height=80
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

type st_8 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=672
int Width=389
int Height=72
boolean Enabled=false
string Text="Vendor Std Pack"
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

type sle_min_on_order from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=592
int Width=384
int Height=80
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

type st_7 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=592
int Width=370
int Height=72
boolean Enabled=false
string Text="Min Order Qty"
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

type sle_lead_time from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=512
int Width=384
int Height=80
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

type st_6 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=512
int Width=283
int Height=72
boolean Enabled=false
string Text="Lead Time"
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

type st_5 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=352
int Width=247
int Height=72
boolean Enabled=false
string Text="Price"
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

type sle_release from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=272
int Width=384
int Height=80
int TabOrder=40
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

type st_4 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=272
int Width=247
int Height=72
boolean Enabled=false
string Text="Release"
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

type sle_po_qty from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=192
int Width=384
int Height=80
int TabOrder=30
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

event modified;IF DEC ( this.text ) < DEC ( sle_min_on_order.text ) THEN
	wmainscreen.setmicrohelp ( "You cannot order qty lesser than minimum on order qty!" )
	sle_std_qty.text= ''
	sle_po_qty.text = ''
ELSE

	sle_std_qty.text	= String(Truncate(f_convert_units(st_po_um.text, "",  is_Part, Dec(this.text)), 4))
	sle_price.text		= String(uf_get_price(is_Vendor, is_Part, Dec(sle_po_qty.text)))

END IF


end event

type st_3 from statictext within u_crosstab_po_grid_release_entry
int X=59
int Y=192
int Width=279
int Height=72
boolean Enabled=false
string Text="Qty for PO"
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

type sle_std_qty from singlelineedit within u_crosstab_po_grid_release_entry
int X=530
int Y=112
int Width=384
int Height=80
int TabOrder=20
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

event modified;IF DEC ( this.text ) < DEC ( sle_min_on_order.text ) THEN
	
	wmainscreen.setmicrohelp ( "You cannot order qty lesser than minimum on order qty!" )
	sle_std_qty.text= ''
	sle_po_qty.text = ''

ELSE
	sle_po_qty.text	= String(Truncate(f_convert_units("", st_po_um.text, is_Part, Dec(this.text)), 4))
	sle_price.text		= String(uf_get_price(is_Vendor, is_Part, Dec(sle_po_qty.text)))

END IF



end event

type st_2 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=112
int Width=247
int Height=72
boolean Enabled=false
string Text="Std Qty"
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

type st_1 from statictext within u_crosstab_po_grid_release_entry
int X=55
int Y=32
int Width=247
int Height=72
boolean Enabled=false
string Text="Date"
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

