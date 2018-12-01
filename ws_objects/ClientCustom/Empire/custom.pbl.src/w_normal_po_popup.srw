$PBExportHeader$w_normal_po_popup.srw
$PBExportComments$normal po detail popup  screen
forward
global type w_normal_po_popup from Window
end type
type cb_ok from commandbutton within w_normal_po_popup
end type
type cb_cancel from commandbutton within w_normal_po_popup
end type
type cb_new from commandbutton within w_normal_po_popup
end type
type cb_apply from commandbutton within w_normal_po_popup
end type
type dw_info_popup from datawindow within w_normal_po_popup
end type
type dw_detail_popup from datawindow within w_normal_po_popup
end type
end forward

global type w_normal_po_popup from Window
int X=96
int Y=212
int Width=2743
int Height=1620
boolean TitleBar=true
string Title="PO detail information"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
event ue_new pbm_custom01
event ue_save pbm_custom02
event ue_history pbm_custom03
event ue_objects pbm_custom04
cb_ok cb_ok
cb_cancel cb_cancel
cb_new cb_new
cb_apply cb_apply
dw_info_popup dw_info_popup
dw_detail_popup dw_detail_popup
end type
global w_normal_po_popup w_normal_po_popup

type variables
s_normal_po 	s_po_parm

Long 		il_PO
Long		il_row_id

String		is_part, &
		is_new, &
		is_vendor, &
		is_plant, &
		is_StdUm,&
		is_po_currency

Date		id_po_date

Boolean		bcheckminonorder, &
		berrormin, &
		bitemchanged = false

DataWindowChild 	idw_child

Dec		in_minonorder, &
		in_mps_covered, &
		in_mps_uncovered

st_dda_parmlist 	st_prmlst



end variables

forward prototypes
public function string wf_get_vendor_code (long al_po)
public subroutine wf_set_values ()
public function decimal wf_minonorder (string as_part, string as_vendor)
public function decimal wf_get_overreceived (string as_part, string as_vendor)
public subroutine wf_initialize ()
public function decimal wf_get_min_on_hand (string as_part, string as_plant)
public function decimal wf_get_lead_time (string as_part, string as_vendor)
public subroutine wf_display_mps_covered (string as_part, string as_plant)
public function boolean wf_update_vendor_part (string as_part, string as_vendor)
public function decimal wf_get_price (decimal a_n_qty)
public function boolean wf_accum ()
public function boolean wf_get_unit_of_measurement_part (string a_s_part)
end prototypes

event ue_new;if wf_get_unit_of_measurement_part ( ' ' ) then
end if
dw_info_popup.insertrow (1)
dw_detail_popup.Reset()
dw_detail_popup.insertrow(1)
dw_detail_popup.modify ("part_number.showlist=yes")
dw_detail_popup.object.part_number.protect = 0
dw_detail_popup.setfocus()

wf_set_values()

end event

event ue_save;/* 01-14-2000 KAZ Modified rollback to release database before message box */
/* 03-08-2000 KAZ Modified to calculate the week number everytime a detail record is saved.
						Issue # 13214 */
/* 03-17-2000 KAZ Modified to re-calculate the PO detail and quantity over-received only if
						release control is accum.  Issue # 13229 */
/* 01-27-2004 MB  Included code to update po header with next sequence number */
						
st_generic_structure   l_st_parm
Date l_d_DateDue																				// ADD 03-08-2000 KAZ
String ReleaseControl
String l_s_SQLErrorText	
Integer li_seqno

// ADD 04-04-2000 KAZ

// check for validity of the data
dw_detail_popup.SetItem (1, "po_number", il_PO)
dw_detail_popup.accepttext()

IF isnull ( dw_detail_popup.object.part_number[1] ) OR  dw_detail_popup.object.part_number[1] = '' THEN
	messagebox ( monsys.msg_title, 'Invalid part number!', Exclamation! )
	RETURN
END IF

IF isnull ( dw_detail_popup.object.date_due[1] ) THEN
	messagebox ( monsys.msg_title, 'Enter a valid Date due!', Exclamation! )
	RETURN
END IF

IF isnull ( dw_detail_popup.object.quantity[1] ) OR dw_detail_popup.object.quantity[1] < 0 THEN
	messagebox ( monsys.msg_title, 'Quantity must be greater than zero!', Exclamation! )
	RETURN
END IF

IF berrormin THEN
	MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity!", Exclamation!	)
	dw_detail_popup.setcolumn("quantity")
	bitemchanged = true
	Return
END IF

// Calculate the week number..															// ADD 03-08-2000 KAZ
l_d_DateDue = date ( dw_detail_popup.GetItemDateTime ( 1, "date_due" ) )	// ADD 03-08-2000 KAZ
dw_detail_popup.SetItem ( 1, "week_no", f_get_week_no ( l_d_DateDue ) )		// ADD 03-08-2000 KAZ

// update the po detail table and then mps tables..
IF dw_detail_popup.update() = 1 THEN
	is_part = dw_detail_popup.Getitemstring(1, "part_number")

	// MB 01/27/04 update po_header with next seq no 
	li_seqno = 1 + dw_detail_popup.GetItemNumber (1, "row_id" )

	Update po_header
	Set next_seqno = :li_seqno 
	Where po_number = :il_po ;
		
	IF sqlca.sqlcode <> 0 THEN
		rollback ;
		messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
	END IF

	IF wf_update_vendor_part ( is_part, is_vendor )	THEN
		commit ; 
		bitemchanged = false
		// If release control is Accum, then recalculate the PO detail and quantity over-received..	   ADD 03-17-2000 KAZ
		If wf_Accum() Then																									// ADD 03-17-2000 KAZ
			SetMicroHelp ( 'Recalculating PO detail for part : ' + is_part )
			f_recalc_po_detail_per_part ( il_PO, is_Part, this )													
		End If																													// ADD 03-17-2000 KAZ
		SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + is_part )
		f_update_qty_asgnd_part ( is_part ) 
		IF ISVALID ( w_normal_po_entry ) THEN &
			w_normal_po_entry.dw_detail.retrieve(il_po) 
		dw_detail_popup.setcolumn ( "part_number")
		dw_detail_popup.setfocus()
	ELSE
		l_s_SQLErrorText = SQLCA.SQLErrText																				// ADD 04/04/2000 KAZ
		Rollback ;
		MessageBox(monsys.msg_title, l_s_SQLErrorText, Information!)											// ADD 04/04/2000 KAZ
	END IF
ELSE
	l_s_SQLErrorText = SQLCA.SQLErrText																						// ADD 04/04/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, Information!)													// ADD 04/04/2000 KAZ
END IF

Setmicrohelp ( 'Ready' )

 
end event

on ue_history;st_generic_structure stParm

stParm.value1	= String(il_PO)
stParm.value2	= dw_detail_popup.Getitemstring(1, "part_number")

OpenWithParm(w_smart_po_receiving_history, stParm)
end on

on ue_objects;OpenWithParm(w_smart_po_objects, is_Part)
end on

public function string wf_get_vendor_code (long al_po);String szVendorCode

SELECT po_header.vendor_code  
  INTO :szVendorCode  
  FROM po_header  
 WHERE po_header.po_number = :al_po   ;

Return szVendorCode
end function

public subroutine wf_set_values ();string ls_shipto, &
       ls_terms, &
       ls_plant, &
       ls_ship_type, &
       ls_shipvia, &
       ls_release_control

Long   ll_count
 
Dec    ln_release

select ship_to_Destination,   
       terms,
       plant,
       ship_type,
       release_no,
       ship_via,
		 currency_unit
into   :ls_shipto, 
       :ls_terms, 
       :ls_plant, 
       :ls_ship_type, 
       :ln_release, 
       :ls_shipvia,
		 :is_po_currency
from 	po_header
where po_number = :il_po ;

if sqlca.sqlcode = 0 then
      
  		dw_detail_popup.setitem(1, "ship_to_destination", ls_shipto )
  		dw_detail_popup.setitem(1, "terms",  ls_terms)
  		dw_detail_popup.setitem(1, "plant", ls_plant)
  		dw_detail_popup.setitem(1, "release_no",  ln_release)
  		dw_detail_popup.setitem(1, "ship_via",  ls_shipvia)

end if

dw_detail_popup.SetItem (1, "status", "A")
dw_detail_popup.SetItem (1, "vendor_code", wf_get_vendor_code(il_PO))
dw_detail_popup.SetItem (1, "received", 0)
dw_detail_popup.SetItem (1, "printed", "N")
dw_detail_popup.SetItem (1, "scheduled_time", s_po_parm.scheduled_time )
dw_detail_popup.SetItem (1, "date_due", datetime ( today(), time ( '00:00:00' ) ) ) 

// MB 01/27/04 modified row_id to next sequential no from po_header
dw_detail_popup.SetItem (1, "row_id", f_get_podet_next_seqno ( il_po ) ) 




end subroutine

public function decimal wf_minonorder (string as_part, string as_vendor);Decimal nQty

SELECT part_vendor.min_on_order  
  INTO :nQty  
  FROM part_vendor  
 WHERE ( part_vendor.part = :as_part ) AND  
       ( part_vendor.vendor = :as_vendor )   ;

Return isnull ( nQty, 0 )
end function

public function decimal wf_get_overreceived (string as_part, string as_vendor);Decimal nQtyOverReceived

SELECT part_vendor.qty_over_received  
  INTO :nQtyOverReceived  
  FROM part_vendor  
 WHERE ( part_vendor.part = :as_Part ) AND  
       ( part_vendor.vendor = :as_Vendor )   ;

return nQtyOverReceived
end function

public subroutine wf_initialize ();string ls_type

select ship_type,
       plant,
       vendor_code
into   :ls_type,
       :is_plant,
       :is_vendor
from   po_header
where  po_number = :il_po ;

bCheckMinOnOrder	= (ls_type = "Normal")

dw_info_popup.insertrow(1)

If bCheckMinOnOrder then
 	in_MinOnOrder	= wf_minonorder(is_Part, is_Vendor)
 	If Isnull ( in_minonorder ) then in_minonorder = 0 
   dw_info_popup.setitem (1, "min_on_order", Truncate(in_MinOnOrder, 2)) 
End If

dw_info_popup.setitem(1, "min_on_hand", Truncate(wf_get_min_on_hand(is_Part, is_Plant),2))
dw_info_popup.setitem(1, "lead_time", Truncate(wf_get_lead_time(is_Part, is_Vendor), 2))

wf_display_mps_covered(is_part, is_plant)
end subroutine

public function decimal wf_get_min_on_hand (string as_part, string as_plant);Decimal nQty

SELECT plant_part.min_onhand  
  INTO :nQty  
  FROM plant_part  
 WHERE ( plant_part.plant = :as_Plant ) AND  
       ( plant_part.part = :as_Part )   ;

Return f_get_value(nQty)
end function

public function decimal wf_get_lead_time (string as_part, string as_vendor);Decimal nLeadTime

  SELECT part_vendor.lead_time  
    INTO :nLeadTime  
    FROM part_vendor  
   WHERE ( part_vendor.part = :as_Part ) AND  
         ( part_vendor.vendor = :as_Vendor )   ;

Return f_get_value(nLeadTime)
end function

public subroutine wf_display_mps_covered (string as_part, string as_plant);Long iTotal
Long iCovered

If as_Plant > ' ' then
	Select sum(master_prod_sched.qnty ),   
   	    sum(master_prod_sched.qty_assigned )  
	  Into :iTotal,   
	       :iCovered  
	  From master_prod_sched  
	  Where master_prod_sched.part 	=: as_Part AND 
			  master_prod_sched.plant	=: as_Plant;
Else
	Select sum(master_prod_sched.qnty ),   
   	    sum(master_prod_sched.qty_assigned )  
	  Into :iTotal,   
	       :iCovered  
	  From master_prod_sched  
	  Where master_prod_sched.part =: as_Part;
End If

in_MPS_Covered		= f_get_value(iCovered)
in_MPS_UnCovered	= f_get_value(iTotal) - in_MPS_Covered

dw_info_popup.setitem(1, "mps_covered", in_MPS_Covered)
dw_info_popup.setitem(1, "mps_uncovered", in_MPS_UnCovered)

end subroutine

public function boolean wf_update_vendor_part (string as_part, string as_vendor);string ls_part

select part
into   :ls_part
from	 part_vendor
where  part = :as_part and 
       vendor = :as_vendor ;
		 
if sqlca.sqlcode = 0 then
	
    return true
 
else

   insert into part_vendor
	(part,
	 vendor,
	 receiving_um)
	values
	(:as_part,
	 :as_vendor,
	 :is_StdUm) ;
	 
	 if sqlca.sqlcode = 0 then
		 commit ;
       return true
    else
	    rollback ;
		 return false
	 end if

end if
end function

public function decimal wf_get_price (decimal a_n_qty);Integer l_i_totalrows
Integer l_i_Row

Decimal l_n_Price

Boolean l_b_Found

l_b_Found		= FALSE

DATASTORE  l_dw_price_matrix

l_dw_price_matrix = CREATE DATASTORE

l_dw_price_matrix.dataobject = 'dw_smart_vendor_part_price_matrix'
l_dw_price_matrix.SetTransobject ( SQLCA )
l_dw_price_matrix.Retrieve ( is_vendor, is_part )

l_i_totalrows	= l_dw_price_matrix.RowCount()
l_i_Row			= l_i_totalrows

Do while (Not l_b_Found) AND (l_i_Row > 0)

	l_b_Found = (a_n_Qty >= l_dw_price_matrix.GetItemNumber(l_i_Row, "break_qty"))

	If Not l_b_Found then
		l_i_Row --
	End If

Loop

If l_i_Row = 0 then
	l_b_Found	= FALSE
End If

If l_b_Found then
	sqlca.of_calculate_multicurrency_price ( l_dw_price_matrix.GetItemString ( l_i_row, 5 ), is_po_currency, &
		Truncate(l_dw_price_matrix.GetItemNumber(l_i_Row, 6) + 0.0000009, 6), l_n_Price )
Else
	sqlca.of_calculate_multicurrency_price ( '', is_po_currency, &
		Truncate(Dec(f_get_part_info(is_part, "STANDARD COST")) + 0.0000009, 6), l_n_price )
	If a_n_Qty > 0 then
		l_n_Price	= f_convert_units(is_stdum, "", is_part, a_n_Qty) * l_n_Price / a_n_Qty
	Else
		l_n_Price	= f_convert_units(is_stdum, "", is_part, 1)
	End If
End If

DESTROY l_dw_price_matrix

Return l_n_Price

end function

public function boolean wf_accum ();/* 03-17-2000 KAZ Created to identify the appropriate release control type. */

String	ReleaseControl

Select 	release_control
Into		:ReleaseControl
From		po_header
Where		po_number = :il_po;

If ReleaseControl = 'A' then
	Return True
Else
	Return False
End If

end function

public function boolean wf_get_unit_of_measurement_part (string a_s_part);

	dw_detail_popup.SetTransObject (sqlca)							// ZZ
	dw_detail_popup.GetChild ("unit_of_measure", idw_child)	// ZZ
	idw_child.SetTransObject (sqlca)									// ZZ
	idw_child.retrieve ( a_s_part )									// ZZ	
	
	If sqlca.sqlcode <> 0 Then 
		Return False
	else
		return True
	end if
end function

event open;s_po_parm = message.powerobjectparm

il_po 		= s_po_parm.po_no
is_part		= s_po_parm.part
id_po_date 	= s_po_parm.due
il_row_id	= s_po_parm.row_id
is_new		= s_po_parm.new

If is_new = 'Y' then
	triggerevent ( "ue_new" )
else
	wf_initialize()
	if wf_get_unit_of_measurement_part ( is_part )	then // ZZ
	end if
	dw_detail_popup.Retrieve( il_po, is_part, il_row_id )
end if

end event

on w_normal_po_popup.create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_new=create cb_new
this.cb_apply=create cb_apply
this.dw_info_popup=create dw_info_popup
this.dw_detail_popup=create dw_detail_popup
this.Control[]={this.cb_ok,&
this.cb_cancel,&
this.cb_new,&
this.cb_apply,&
this.dw_info_popup,&
this.dw_detail_popup}
end on

on w_normal_po_popup.destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_new)
destroy(this.cb_apply)
destroy(this.dw_info_popup)
destroy(this.dw_detail_popup)
end on

event closequery;Int iRtnCode
If bitemchanged Then
	iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
		Exclamation!, YesNoCancel! , 3 )
	CHOOSE Case iRtnCode 
		Case 1
			This.TriggerEvent( 'ue_save' )
			If bitemchanged = True AND iRtnCode = 1 Then
				Message.Returnvalue = 1   
			Else
				This.TriggerEvent( 'ue_save' )
			End If
		Case 2 
			close ( this )
		Case 3
			Message.Returnvalue = 1       
	End Choose
Else
      close ( this )
End If

end event

type cb_ok from commandbutton within w_normal_po_popup
int X=1687
int Y=1388
int Width=297
int Height=104
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.triggerevent ( "ue_save" )

close ( parent )
end event

type cb_cancel from commandbutton within w_normal_po_popup
int X=2016
int Y=1388
int Width=297
int Height=104
int TabOrder=30
string Text="Cancel"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( parent )
end event

type cb_new from commandbutton within w_normal_po_popup
int X=1358
int Y=1388
int Width=297
int Height=104
int TabOrder=40
string Text="New"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_part = ''
parent.triggerevent ( "ue_new" )
end event

type cb_apply from commandbutton within w_normal_po_popup
int X=2345
int Y=1388
int Width=297
int Height=104
int TabOrder=20
boolean Enabled=false
string Text="Apply"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.triggerevent ( "ue_save" )
end event

type dw_info_popup from datawindow within w_normal_po_popup
int X=14
int Y=8
int Width=2706
int Height=172
string DataObject="d_external_po_header_popup"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_detail_popup from datawindow within w_normal_po_popup
event ue_keypress pbm_dwnkey
event ue_move pbm_nchittest
int X=14
int Y=192
int Width=2706
int Height=1172
int TabOrder=10
string DataObject="dw_normal_po_detail_popup"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_keypress;int li_current_row,i_current_column
if (dw_detail_popup.getcolumnname()='quantity') then
if (keydown(keyTab!) OR keydown(keyEnter!)) then 
   li_current_row = dw_detail_popup.getrow()
   dw_detail_popup.accepttext()
	st_prmlst.s_arg_part   = dw_detail_popup.getitemstring(li_current_row,'part_number')
	st_prmlst.s_arg_module = dw_detail_popup.getitemstring(li_current_row,'unit_of_measure')
	st_prmlst.s_rtn_qtystr = dw_detail_popup.getitemstring(li_current_row,'dimension_qty_string')
	st_prmlst.s_rtn_qty    = dw_detail_popup.getitemnumber(li_current_row,'quantity') 
	Openwithparm(w_dda,st_prmlst)
	st_prmlst = Message.PowerObjectparm
	dw_detail_popup.setitem(li_current_row,'quantity',st_prmlst.s_rtn_qty)
	dw_detail_popup.setitem(li_current_row,'dimension_qty_string',st_prmlst.s_rtn_qtystr)
	Triggerevent('itemchanged')
End if 
End if 
end event

event ue_move;RETURN 1
end event

event editchanged;bitemchanged = true

cb_apply.enabled = true

end event

event itemchanged;/* 03-15-2000 KAZ Modified to properly populate the unit of measurement field. 
Note: This is a quick fix, I must add a drop down list box.  */

string	ls_part, &
	ls_descrip, &
	ls_Name, &
	ls_Vendor, &
	ls_GLAccount, &
	ls_UM, &
	ls_note, &
	ls_nonorder_status
	
Dec	ln_price, &
	ln_balance, &
	ln_qty
Datetime ld_datetime

bitemchanged = true
cb_apply.enabled = true

IF dw_detail_popup.GetColumnname()  = 'quantity' THEN
	IF Dec(dw_detail_popup.gettext()) >= in_minonorder THEN
		ln_balance =  Dec(dw_detail_popup.gettext()) - dw_detail_popup.getitemnumber(1, "received")
		dw_detail_popup.setitem(1, "balance", ln_balance)
		ln_price		= wf_get_price ( Dec(dw_detail_popup.gettext()) )
		dw_detail_popup.setitem ( 1, "price", ln_price )
		berrormin = false
	else
		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity!", StopSign!	)
		berrormin = true
		dw_detail_popup.SetText("")
		Return
	end if
elseIF dwo.name = 'balance' THEN
	ln_qty = Dec ( data ) + object.received [ row ] 
	IF ln_qty >= in_minonorder THEN
		setitem(row, "quantity", ln_qty)
		ln_price = wf_get_price ( Dec( data ) )
		dw_detail_popup.setitem ( 1, "price", ln_price )
		berrormin = false
	else
		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity!", StopSign!	)
		berrormin = true
		dw_detail_popup.SetText("")
		Return
	end if
elseif dw_detail_popup.GetColumnname() = 'part_number' then
	if f_get_part_info ( data , "NAME" ) > '' then
		ls_part = dw_detail_popup.Gettext()
		if not wf_get_unit_of_measurement_part ( ls_part ) then
		end if
		
		/* 02-12-2004 MB  Modified to check non order status for part and add release accordingly */
		ls_note = f_get_part_no_status ( data )
		ls_nonorder_status = Left ( ls_note, 1 )
		
		if isnull(ls_nonorder_status,'N') = 'Y' then 
			ls_note = Mid ( ls_note, 3,  len ( ls_note ) - 2 )
			messagebox ( monsys.msg_title, 'Unable to add release for this part. ' + ls_note )
			dw_detail_popup.SetItem ( 1, "description", '' )
			return 1
		end if
		
		//is_StdUm= f_get_part_info(ls_Part, "STANDARD UNIT")				// CHG 03-15-2000 KAZ
		ls_Name		= f_get_part_info(ls_Part, "NAME")
		ls_Vendor	= wf_get_vendor_code(il_PO)
		ls_GLAccount= f_get_part_info(ls_Part, "GL ACCOUNT")
		is_part		= ls_part
		wf_initialize()
		ls_UM	= f_get_part_info(ls_Part, "STANDARD UNIT")						// ADD 03-15-2000 KAZ
		Select	receiving_um
		Into	:is_StdUM
		From	part_vendor
		Where	part = :ls_part
		And	vendor = :ls_vendor;
		is_StdUM = IsNull ( is_StdUM, IsNull ( ls_UM, 'EA' ) )
		dw_detail_popup.SetItem ( 1, "description", ls_name )
		dw_detail_popup.SetItem ( 1, "vendor_code", ls_vendor )
		dw_detail_popup.SetItem ( 1, "account_code", ls_glaccount )
		dw_detail_popup.SetItem ( 1, "unit_of_measure", is_stdum )
	else
		messagebox ( monsys.msg_title, "Invalid Part Number!", Exclamation! )
		return 1
	end if
ELSEIF dw_detail_popup.GetColumnname() = 'date_due' THEN
	ld_datetime = datetime ( date ( Left ( data, 10 ) ) ) // just get the date..
	dw_detail_popup.SetItem (1, "week_no", f_get_week_no(date(ld_datetime)) )
END IF


end event

on constructor;settransobject( sqlca)
end on

event itemerror;RETURN 1
end event

