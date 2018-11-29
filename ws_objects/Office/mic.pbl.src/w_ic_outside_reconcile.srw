$PBExportHeader$w_ic_outside_reconcile.srw
forward
global type w_ic_outside_reconcile from w_sheet_4t
end type
type dw_shipped_quantity from datawindow within w_ic_outside_reconcile
end type
type dw_object_drop_ship from datawindow within w_ic_outside_reconcile
end type
type gb_1 from groupbox within w_ic_outside_reconcile
end type
type st_cum_shipped from statictext within w_ic_outside_reconcile
end type
type dw_po_header from datawindow within w_ic_outside_reconcile
end type
type dw_reconcile from datawindow within w_ic_outside_reconcile
end type
type dw_objects from datawindow within w_ic_outside_reconcile
end type
type dw_audit_trail from datawindow within w_ic_outside_reconcile
end type
type dw_quantity from datawindow within w_ic_outside_reconcile
end type
type gb_2 from groupbox within w_ic_outside_reconcile
end type
type gb_3 from groupbox within w_ic_outside_reconcile
end type
type gb_4 from groupbox within w_ic_outside_reconcile
end type
end forward

global type w_ic_outside_reconcile from w_sheet_4t
integer height = 1560
string title = "Outside Reconcile"
string menuname = "m_ic_outside_reconcile"
event reconcile pbm_custom01
event scrap pbm_custom02
event adjust_cum pbm_custom03
event save_change pbm_custom04
event ue_exit pbm_custom05
dw_shipped_quantity dw_shipped_quantity
dw_object_drop_ship dw_object_drop_ship
gb_1 gb_1
st_cum_shipped st_cum_shipped
dw_po_header dw_po_header
dw_reconcile dw_reconcile
dw_objects dw_objects
dw_audit_trail dw_audit_trail
dw_quantity dw_quantity
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_ic_outside_reconcile w_ic_outside_reconcile

type variables
STRING	is_PartRecieved
String szVendor            //Vendor code
boolean	ib_scrap
end variables

forward prototypes
public subroutine wf_material_issue (long iserial)
public subroutine wf_update_cum (decimal an_cumshipped, integer ai_flag)
public subroutine wf_reconcile (decimal an_qty, string as_part)
end prototypes

event reconcile;Long 		ll_row			
Long		ll_rowcount

Decimal 	ln_Qty	
Decimal	ln_TotalQty	

ln_TotalQty	= 0

ll_rowcount = dw_audit_trail.RowCount()

For ll_row	= 1 to ll_rowcount
	
	If dw_audit_trail.IsSelected(ll_row) then
		
		ln_Qty		= dw_audit_trail.Object.audit_trail_std_quantity [ ll_row ]
		ln_TotalQty	= ln_TotalQty + ln_Qty
		wf_reconcile ( ln_Qty, '' )
		dw_audit_trail.SetItem(ll_row, "audit_trail_status", "C")
		
		if IsNull ( dw_audit_trail.GetItemString ( ll_row, "drop_ship_part" ), 'N' ) = 'Y' then
			dw_object_drop_ship.Retrieve ( dw_audit_trail.GetItemNumber ( ll_row, "serial" ) )
			dw_object_drop_ship.SetItem ( dw_object_drop_ship.RowCount ( ), "location", dw_audit_trail.GetItemString ( ll_row, "next_vendor" ) )
			dw_object_drop_ship.SetItem ( dw_object_drop_ship.RowCount ( ), "status", 'P' )
		end if
		
	End If
	
Next

If dw_audit_trail.Update() > 0 then
	
	ll_rowcount = dw_object_drop_ship.RowCount ( )
	if ll_rowcount > 0 then
		if dw_object_drop_ship.Update ( ) = 1 then
			commit ;
		else
			rollback;
		end if
	else	
		Commit;
	end if
	
	// Set the accum received for the part received
	wf_update_cum ( dw_quantity.object.cum_received [ 1 ] + ln_TotalQty , 2 ) 


	
Else
	
	Rollback;
	
End If

dw_audit_trail.Retrieve ( is_PartRecieved, szVendor ) 
dw_objects.Retrieve ( is_PartRecieved, szVendor )
// Get the computed quantites after changing audit trail
dw_quantity.Retrieve ( is_partrecieved, szvendor )
dw_shipped_quantity.Retrieve ( is_partrecieved, szvendor )



end event

event scrap;if dw_shipped_quantity.Rowcount ( ) > 0 and NOT ib_scrap then
	if dw_shipped_quantity.object.vendor_loss_qty [ Long ( dw_shipped_quantity.Object.Datawindow.FirstRowOnPage ) ] > 0 then
		string	ls_unit
		string	ls_part
	
		ls_part = dw_shipped_quantity.GetItemString ( Long ( dw_shipped_quantity.Object.Datawindow.FirstRowOnPage ), "part" )
		
		select	standard_unit
		into		:ls_unit
		from		part_inventory
		where		part = :ls_Part;
		
		If MessageBox( monsys.msg_title, "Scrapping a quantity will deduct from the objects shipped to the vendor and will be irreversible.  To cancel, simply exit the screen.  To finish press the save button.  Are you sure you want to continue?", Question!,  YesNo!) = 2 then
			Return
		End If
		
		dw_reconcile.InsertRow(1)
		dw_reconcile.SetItem(1, "part", ls_part )
		dw_reconcile.SetItem(1, "vendor", szVendor)
		dw_reconcile.SetItem(1, "date_stamp", DateTime(Today(), Now()))
		dw_reconcile.SetItem(1, "quantity", dw_shipped_quantity.object.vendor_loss_qty [ Long ( dw_shipped_quantity.Object.Datawindow.FirstRowOnPage ) ])
		dw_reconcile.SetItem(1, "std_quantity", dw_shipped_quantity.object.vendor_loss_qty [ Long ( dw_shipped_quantity.Object.Datawindow.FirstRowOnPage ) ])
		dw_reconcile.SetItem(1, "type", "D")
		dw_reconcile.SetItem(1, "unit", ls_unit )
		dw_reconcile.SetItem(1, "notes", "Scrap lost qty in outside process")
		dw_reconcile.SetItem(1, "serial", 0)
		dw_reconcile.SetItem(1, "status", "C")
		dw_reconcile.SetItem(1, "operator", "NONE")
	
		dw_reconcile.SetItem(1, "remarks", "OP-Scrap" )
		
		ib_Scrap = TRUE
	else
		MessageBox ( monsys.msg_title, "Vendor loss quantity must be greater than 0 to scrap!", Information! )
	end if
end if

end event

event adjust_cum;//allow cum shipped column to edit
dw_shipped_quantity.object.cum_shipped.tabsequence = 10
dw_shipped_quantity.object.cum_shipped.background.color = f_get_color_value('WHITE')
dw_shipped_quantity.VScrollBar = FALSE
dw_shipped_quantity.setfocus()


end event

event save_change;decimal ln_cum_shipped
long		ll_row
long		ll_rowcount

dw_shipped_quantity.accepttext()

ln_cum_shipped = dw_shipped_quantity.object.cum_shipped [ Long ( dw_shipped_quantity.Object.Datawindow.FirstRowOnPage ) ]

// check if cum shipped changed and update cum shipped and cum recieved

If dw_shipped_quantity.object.cum_shipped.primary.original[Long(dw_shipped_quantity.Object.Datawindow.FirstRowOnPage)] <> dw_shipped_quantity.object.cum_shipped.primary.current[Long(dw_shipped_quantity.Object.Datawindow.FirstRowOnPage)] then
	
	wf_update_cum( ln_cum_shipped , 1)	
//	wf_update_cum( ln_cum_shipped , 2)	
	
End If

dw_shipped_quantity.object.cum_shipped.tabsequence = 0
dw_shipped_quantity.object.cum_shipped.background.color = f_get_color_value('ButtonFace')
dw_shipped_quantity.VScrollBar = TRUE

if ib_scrap then
	dw_reconcile.AcceptText ( )
	dw_reconcile.SetItem ( 1, "std_quantity", dw_reconcile.GetItemDecimal ( 1, "quantity" ) )
	
	wf_reconcile ( dw_reconcile.GetItemDecimal ( 1, "quantity" ), dw_shipped_quantity.GetItemString ( Long(dw_shipped_quantity.Object.Datawindow.FirstRowOnPage), "part" ) )
	
	If dw_reconcile.Update() > 0 then
		Commit;
		dw_shipped_quantity.retrieve( is_partrecieved, szVendor )
	Else
		RollBack;
	End If
	ib_scrap = FALSE
end if
end event

event ue_exit;if isvalid ( w_ic_outside_part_list ) then
	w_ic_outside_part_list.trigger dynamic event ue_assign (	0, 0 ) 		
end if

close ( this )


end event

public subroutine wf_material_issue (long iserial);DateTime dDateStamp

Decimal  nCost
Decimal  nWeight
Decimal  nQuantity
Decimal  nStd_quantity

String   szPart
String   szVendor
String   szUM
String   szOperator

SELECT   object.part,   
         object.unit_measure,   
         object.operator,   
         object.cost,   
         object.weight,   
         object.quantity,   
         object.std_quantity  
    INTO :szPart,   
         :szUM,   
         :szOperator,   
         :nCost,   
         :nWeight,   
         :nQuantity,   
         :nStd_quantity  
    FROM object  
   WHERE object.serial = :iSerial   ;


dDateStamp	= DateTime(Today(), Now())

Insert into audit_trail  
	  		    ( serial,   
              	date_stamp,   
               type,   
  		         part,   
               quantity,   
			     	remarks,   
		         price,   
	            salesman,   
	            customer,   
	            vendor,   
	            po_number,   
	            operator,   
	            from_loc,   
	  	         to_loc,   
	            on_hand,   
	            lot,   
	            weight,   
	            status,   
	            shipper,   
	            flag,   
	            activity,
				   unit )  
	   	Values ( :iSerial,   
           			:dDateStamp,   
		            'M',   
						:szPart,   
                  :nQuantity,     //Issued Qty
                  'MAT ISSUE',   
                  :nCost,   
                  null,   
                  null,   
                  null,   
	               null,   
	               null,   
	               :szVendor,   
	               :szVendor,   
	               null,   
	               null,
	               :nWeight,   
	               null,  
	               null,   
	               null,   
	               null,
						:szUM )  ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit;
End If
end subroutine

public subroutine wf_update_cum (decimal an_cumshipped, integer ai_flag);string	ls_part

If ai_flag = 1 then

	ls_part = dw_shipped_quantity.GetItemString ( Long ( dw_shipped_quantity.Object.datawindow.FirstRowOnPage ), "part" )
	
  UPDATE	part_vendor
     SET	accum_shipped = :an_CumShipped
	WHERE	part = :ls_part and vendor = :szVendor  ;
	 
Else

//  UPDATE part_vendor
//     SET	accum_received = :an_CumShipped
//   WHERE	part = :is_partrecieved and vendor = :szVendor  ;


End If

if sqlca.sqlcode = 0 then
   commit  ;
else
	rollback;
end if
end subroutine

public subroutine wf_reconcile (decimal an_qty, string as_part);Long		ll_rowcount
long		ll_start = 0
Decimal  ln_ObjectQty		
decimal	ldec_Quantity
string	ls_currentpart

if ib_scrap then
	dw_objects.SetSort ( "part, object_last_date, object_last_time" )
	dw_objects.Sort ( )
end if

if dw_objects.RowCount ( ) > 0 then
	if as_part > '' then
		ll_start = dw_objects.Find ( "part = '" + as_part + "'", ll_start, dw_objects.RowCount ( ) )
		if ll_start > 0 then
			if dw_objects.GetItemString ( ll_start, "part" ) <> as_part then
				return
			end if
		else
			return
		end if
	else
		ll_start = 1
	end if
else
	return
end if

Do
	ldec_Quantity = an_Qty
	ls_currentpart = dw_objects.GetItemString ( ll_start, "part" )
	Do while ( ldec_Quantity > 0 ) AND ( dw_objects.Rowcount() > 0 )
		if ll_start <= dw_objects.RowCount ( ) then
			if ls_currentpart = dw_objects.GetItemString ( ll_start, "part" ) then
				ln_ObjectQty		= dw_objects.Object.object_std_quantity [ ll_start ]
				If ln_ObjectQty	<= ldec_Quantity then
					ldec_Quantity	= ldec_Quantity - ln_ObjectQty
					dw_objects.DeleteRow(ll_start)
				Else
					ln_ObjectQty	= ln_ObjectQty - ldec_Quantity
					ldec_Quantity			= 0
					dw_objects.SetItem(ll_start, "object_std_quantity", ln_ObjectQty)	
					dw_objects.SetItem(ll_start, "object_quantity", f_convert_units ( "", dw_objects.GetItemString ( ll_start, "object_unit_measure" ), dw_objects.GetItemString ( ll_start, "part" ), ln_ObjectQty ) )
				End If
			else
				exit
			end if
		else
			exit
		end if
	Loop
	if as_part = '' then
		ll_start = dw_objects.Find ( "part > '" + ls_currentpart + "'", ll_start, dw_objects.RowCount ( ) )
		if ll_start < 0 then
			ll_start = 0
		end if
	else
		ll_start = 0
	end if
Loop While ( ll_start > 0 )

If dw_objects.Update() > 0 then
	Commit;
Else
	Rollback;
End If

if ib_scrap then
	dw_objects.SetSort ( "part, object_last_date D, object_last_time D" )
	dw_objects.Sort ( )
end if
end subroutine

event open;call super::open;string	ls_partshipped

//Included associative array to get values 
n_cst_associative_array l_ncst

l_ncst = Message.PowerObjectParm

// Initialization

is_PartRecieved			= l_ncst.of_getitem('parent_part')
szVendor						= l_ncst.of_getitem('vendor')
ls_PartShipped				= l_ncst.of_getitem('part')

this.title					= this.title + " for part:" + is_PartRecieved					

gb_4.Text = 'Part ' + is_PartRecieved + ' ' + gb_4.Text

// Main Routine

dw_objects.Retrieve(is_PartRecieved, szVendor)
dw_audit_trail.Retrieve(is_PartRecieved,szVendor)
dw_reconcile.Retrieve(ls_PartShipped, szVendor)
dw_quantity.retrieve( is_partrecieved, szVendor )
dw_shipped_quantity.retrieve( is_partrecieved, szVendor )

end event

on w_ic_outside_reconcile.create
int iCurrent
call super::create
if this.MenuName = "m_ic_outside_reconcile" then this.MenuID = create m_ic_outside_reconcile
this.dw_shipped_quantity=create dw_shipped_quantity
this.dw_object_drop_ship=create dw_object_drop_ship
this.gb_1=create gb_1
this.st_cum_shipped=create st_cum_shipped
this.dw_po_header=create dw_po_header
this.dw_reconcile=create dw_reconcile
this.dw_objects=create dw_objects
this.dw_audit_trail=create dw_audit_trail
this.dw_quantity=create dw_quantity
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipped_quantity
this.Control[iCurrent+2]=this.dw_object_drop_ship
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.st_cum_shipped
this.Control[iCurrent+5]=this.dw_po_header
this.Control[iCurrent+6]=this.dw_reconcile
this.Control[iCurrent+7]=this.dw_objects
this.Control[iCurrent+8]=this.dw_audit_trail
this.Control[iCurrent+9]=this.dw_quantity
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
end on

on w_ic_outside_reconcile.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_shipped_quantity)
destroy(this.dw_object_drop_ship)
destroy(this.gb_1)
destroy(this.st_cum_shipped)
destroy(this.dw_po_header)
destroy(this.dw_reconcile)
destroy(this.dw_objects)
destroy(this.dw_audit_trail)
destroy(this.dw_quantity)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

type dw_shipped_quantity from datawindow within w_ic_outside_reconcile
integer x = 55
integer y = 752
integer width = 2670
integer height = 224
integer taborder = 60
string dataobject = "d_outside_process_shipped"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( sqlca )
end event

event scrollvertical;dw_reconcile.Retrieve ( GetItemString ( Long ( Object.Datawindow.FirstRowOnPage ), "part" ), szVendor )

end event

type dw_object_drop_ship from datawindow within w_ic_outside_reconcile
boolean visible = false
integer x = 37
integer y = 1424
integer width = 293
integer height = 208
integer taborder = 110
string dataobject = "d_object_drop_ship"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrievestart;return 2
end event

event constructor;SetTransObject ( sqlca )
end event

type gb_1 from groupbox within w_ic_outside_reconcile
integer x = 37
integer y = 592
integer width = 2706
integer height = 400
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
end type

type st_cum_shipped from statictext within w_ic_outside_reconcile
boolean visible = false
integer x = 1152
integer y = 768
integer width = 238
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_po_header from datawindow within w_ic_outside_reconcile
boolean visible = false
integer x = 457
integer y = 1456
integer width = 494
integer height = 360
integer taborder = 100
string dataobject = "dw_get_po_header"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_reconcile from datawindow within w_ic_outside_reconcile
integer x = 64
integer y = 1036
integer width = 2633
integer height = 352
integer taborder = 90
string dataobject = "dw_audit_trail_for_reconcile"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_objects from datawindow within w_ic_outside_reconcile
integer x = 73
integer y = 64
integer width = 1326
integer height = 512
integer taborder = 40
string dataobject = "dw_objects_in_location"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_audit_trail from datawindow within w_ic_outside_reconcile
integer x = 1463
integer y = 64
integer width = 1248
integer height = 512
integer taborder = 10
string dataobject = "dw_audit_trail_for_po"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;DataWindowChild	ldwc_child
GetChild ( "next_vendor", ldwc_child )
ldwc_child.SetTransObject ( sqlca )
ldwc_child.InsertRow ( 1 )
settransobject(sqlca)
end event

event clicked;If row > 0 then
	SelectRow(row, (Not IsSelected(row)))
	DataWindowChild	ldwc_child
	GetChild ( "next_vendor", ldwc_child )
	if ldwc_child.Retrieve ( GetItemString ( row, "part" ) ) <= 0 then
		ldwc_child.InsertRow ( 1 )
	end if
End If
end event

type dw_quantity from datawindow within w_ic_outside_reconcile
integer x = 494
integer y = 640
integer width = 2213
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_outside_process_received"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type gb_2 from groupbox within w_ic_outside_reconcile
integer x = 37
integer y = 984
integer width = 2702
integer height = 416
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "Scrapped Audit Trail"
end type

type gb_3 from groupbox within w_ic_outside_reconcile
integer x = 37
integer width = 1381
integer height = 588
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "Parts Currently at Vendor~'s Location"
end type

type gb_4 from groupbox within w_ic_outside_reconcile
integer x = 1426
integer width = 1307
integer height = 588
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "Received but not yet reconciled"
end type

