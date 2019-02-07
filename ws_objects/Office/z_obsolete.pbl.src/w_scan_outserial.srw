$PBExportHeader$w_scan_outserial.srw
forward
global type w_scan_outserial from Window
end type
type dw_2 from datawindow within w_scan_outserial
end type
type cb_2 from commandbutton within w_scan_outserial
end type
type cb_1 from commandbutton within w_scan_outserial
end type
type dw_1 from datawindow within w_scan_outserial
end type
end forward

global type w_scan_outserial from Window
int X=183
int Y=212
int Width=2441
int Height=1064
boolean TitleBar=true
string Title="Receive Objects Returning From Outside Processor"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_scan_outserial w_scan_outserial

type variables
Boolean			bError

n_cst_associative_array	iuo_items

dec	id_originalqty=0
end variables

on w_scan_outserial.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_scan_outserial.destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;/* 04-06-2000 KAZ Modified.  Position window vertically higher so user can choose a PO
						release if PO is line item.  */

//f_center_window ( this )								// CHG 04-06-2000 KAZ

Integer &
	li_New_X, &
	li_New_Y

integer &
	li_workspace_width,&
	li_workspace_height
f_get_workspace_size( li_workspace_width, li_workspace_height )

If li_WorkSpace_Width > 0 Then
	li_New_X = ( li_WorkSpace_Width / 2 ) - ( this.Width / 2 )
Else
	li_New_X = this.X
End If

If li_WorkSpace_Height > 0 Then
	li_New_Y = ( ( li_WorkSpace_Height / 2 ) - ( this.Height / 2 ) - 250 )
Else
	li_New_Y = this.Y
End If
this.Move( li_New_X, li_New_Y )

end event

event closequery;if iuo_items.of_upperbound ( ) <= 0 then
	iuo_items.of_setitem ( "canceled", "yes" )
	Message.PowerObjectParm = iuo_items
end if
end event

type dw_2 from datawindow within w_scan_outserial
int X=37
int Y=976
int Width=2377
int Height=392
int TabOrder=20
string DataObject="dw_line_item_release_display"
boolean TitleBar=true
string Title="Line Item Releases"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;selectRow ( This, 0, false )
selectRow ( This, row, true )

end event

event dberror;return 1
end event

event constructor;SetTransObject ( sqlca )
end event

type cb_2 from commandbutton within w_scan_outserial
int X=402
int Y=816
int Width=311
int Height=112
int TabOrder=40
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type cb_1 from commandbutton within w_scan_outserial
int X=55
int Y=816
int Width=311
int Height=112
int TabOrder=30
boolean Enabled=false
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* 04-06-2000 KAZ Modified to prompt user to select a release if PO is line item.  */
/* 04-06-2000 KAZ Added unit of measure.  Issue 13328. */

string	ls_location, &
	ls_part, &
	ls_vendor, &
	ls_qa, &
	ls_status, &
	ls_status_desc, &
	ls_operator
	
dec	ld_quantity, &
	ld_diffqty
long	ll_serial, &
	ll_shipper, &
	ll_newserial

st_generic_structure	str_Parm	

dw_1.AcceptText ( )

if dw_1.object.location [1] <= '' then
	MessageBox ( monsys.msg_title, "Please choose a location to receive to!" , Information! )
	dw_1.SetColumn ( "location" )
	dw_1.SetFocus ( )
	return
end if

if dw_1.object.part[1] <> dw_1.object.parent_part[1] then 
	if w_visual_receiving_dock_version2.cbx_line_item.checked then																				// ADD 04-06-2000 KAZ
		if dw_2.GetselectedRow ( 0 ) <= 0 then											// ADD 04-06-2000 KAZ
			MESSAGEBOX ( monsys.msg_title, "You must select a release against which you would like to receive the object!" )	// ADD 04-06-2000 KAZ
			dw_2.Enabled = True
			dw_2.SetFocus()
			return																																				// ADD 04-06-2000 KAZ
		end if																																					// ADD 04-06-2000 KAZ
	end if																																						// ADD 04-06-2000 KAZ
	
	iuo_items.of_SetItem ( "serial", dw_1.GetItemNumber ( 1, "serial" ) )
	iuo_items.of_SetItem ( "part", dw_1.GetItemString ( 1, "parent_part" ) )
	iuo_items.of_SetItem ( "quantity", dw_1.GetItemDecimal ( 1, "quantity" ) )
	iuo_items.of_Setitem ( "unit_measure", dw_1.GetItemString ( 1, "unit_measure" ) )													// ADD 04-06-2000 KAZ
	iuo_items.of_SetItem ( "net_weight", dw_1.GetItemDecimal ( 1, "net_weight" ) )
	iuo_items.of_SetItem ( "package_type", dw_1.GetItemString ( 1, "package_type" ) )
	iuo_items.of_SetItem ( "tare_weight", dw_1.GetItemDecimal ( 1, "tare_weight" ) )
	iuo_items.of_SetItem ( "location", dw_1.GetItemString ( 1, "location" ) )
	iuo_items.of_SetItem ( "lot", dw_1.GetItemString ( 1, "lot" ) )
	iuo_items.of_SetItem ( "custom1", dw_1.GetItemString ( 1, "custom1" ) )
	iuo_items.of_SetItem ( "custom2", dw_1.GetItemString ( 1, "custom2" ) )
	iuo_items.of_SetItem ( "custom3", dw_1.GetItemString ( 1, "custom3" ) )
	iuo_items.of_SetItem ( "custom4", dw_1.GetItemString ( 1, "custom4" ) )
	iuo_items.of_SetItem ( "custom5", dw_1.GetItemString ( 1, "custom5" ) )
	if w_visual_receiving_dock_version2.cbx_line_item.checked then	
		iuo_items.of_SetItem ( "row_id", dw_2.GetItemDecimal ( (dw_2.GetSelectedRow ( 0 ) ), "row_id" ) )								// ADD 04-07-2000 KAZ
	end if
else
	ll_serial = dw_1.object.serial[1]

	select	location,
		part,
		shipper,
		operator
	into	:ls_vendor,
		:ls_part,
		:ll_shipper,
		:ls_operator
	from 	object
	where	serial = :ll_serial ;

	select	quality_alert
	into	:ls_qa
	from	part
	where	part = :ls_part;
	
	if ls_qa = 'Y' then
		ls_status	= 'H'
		ls_status_desc	= "On Hold"
	else
		ls_status	= 'A'
		ls_status_desc	= "Approved"
	end if

	if isnull(ll_shipper, 0) <> 0 then 
		ld_quantity = dw_1.object.quantity[1]
		ls_location = dw_1.object.location[1]
	
		//	if the quantity is different, do the following
		//	Perform a break out on the original serial with the new qty
		
		ld_diffqty = id_originalqty - ld_quantity
		
		if ld_quantity = id_originalqty then 
			update	object
			set	location = :ls_location,
				destination = null,
				shipper = null,
				show_on_shipper = null,
				status = :ls_status,
				user_defined_status = :ls_status_desc,
				operator = :ls_operator
			where	serial = :ll_serial;
			
			if sqlca.sqlcode >= 0 then 
				if f_create_audit_trail(ll_serial, "L",	'', ls_Vendor, '', '', ls_Part, string(ld_quantity),'', ls_Location, '', 'No Commit') then
					
					update	part_vendor
					set	accum_shipped = accum_shipped - :ld_quantity
					where	vendor = :ls_vendor and
						part = :ls_part ;
					if sqlca.sqlcode >= 0 then 
						commit;
						Messagebox ( Monsys.msg_title, "Successfully received part "+ls_part+" sent to outside process")
					else
						rollback;
					end if 	
				else
					rollback;
				end if 	
			end if 	
		else
			//	Perform a break out on the original qty 
			if SQLCA.of_getnextparmvalue ( 'next_serial', ll_newserial) then 
			
				INSERT INTO object  
					( serial,   
					part,   
					location,   
					last_date,   
					unit_measure,   
					operator,   
					status,   
					destination,   
					station,   
					origin,   
					cost,   
					parent_serial,   
					note,   
					quantity,   
					last_time,   
					date_due,   
					customer,   
					sequence,   
					shipper,   
					lot,   
					type,   
					po_number,   
					name,   
					plant,   
					start_date,
					std_quantity,
					package_type,
					suffix,
					dimension_qty_string,
					varying_dimension_code,
					user_defined_status,
					custom1,
					custom2,
					custom3,
					custom4,
					custom5,
					std_cost,
					workorder,
					field1,
					field2,
					engineering_level)  
				select	:ll_newserial,   
					part,   
					:ls_location,   
					today(),   
					unit_measure,   
					operator,   
					:ls_status,   
					destination,   
					station,   
					origin,   
					cost,   
					parent_serial,   
					note,   
					:ld_quantity,   
					now(),   
					date_due,   
					customer,   
					sequence,   
					NULL,   
					lot,   
					type,   
					po_number,   
					name,   
					plant,   
					start_date,
					:ld_quantity,
					package_type,
					suffix,
					dimension_qty_string,
					varying_dimension_code,
					:ls_status_desc,
					custom1,
					custom2,
					custom3,
					custom4,
					custom5,
					std_cost,
					workorder,
					field1,
					field2,
					engineering_level
				from	object
				where	serial = :ll_serial;

				If SQLCA.SQLCode = -1 Then
					RollBack ;
				Else
					If Not f_create_audit_trail ( ll_newserial, "B", String ( ll_Serial ), ls_vendor, string(ll_shipper), "", "", "", "", "", "", "No Commit" ) Then
						RollBack ;
					Else
			
						UPDATE object  
						SET	quantity     = :ld_diffqty,
							std_quantity = :ld_diffqty
						WHERE	serial = :ll_serial;
			
						If SQLCA.SQLCode = -1 Then
							RollBack ;
						Else
							// no label will be printed on the original serial 
							If Not f_create_audit_trail ( ll_Serial, "B", "", ls_vendor, string(ll_shipper), "Original", string(ld_diffqty), "", "", "", "", "No Commit" ) Then
								RollBack ;
							Else
								if f_create_audit_trail(ll_serial, "L", '', ls_Vendor,'','', ls_Part, string(ld_quantity),'', ls_Location,'','No Commit') then
									
									update	part_vendor
									set	accum_shipped = accum_shipped - :ld_quantity
									where	vendor = :ls_vendor and
										part = :ls_part ;
										
									if sqlca.sqlcode >= 0 then 
										commit;
										Messagebox ( Monsys.msg_title, "Successfully received part "+ls_part+" sent to outside process")
									else
										rollback;
									end if 	
								end if
							End if
						End if
					End if
				end if 
			end if 				
		end if 	
		
	else
		Messagebox ( Monsys.msg_title, "Serial "+string(ll_serial) + " is not at outside process")
	end if 	
end if 

CloseWithReturn ( Parent, iuo_items )
end event

type dw_1 from datawindow within w_scan_outserial
int X=37
int Y=16
int Width=2377
int Height=800
int TabOrder=10
string DataObject="d_scan_outserial"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;/* 04-06-2000 KAZ Modified to populate unit of measure DDDW in dw_1 when parent part
						is selected.  Issue # 13328 */
/* 04-06-2000 KAZ Modified to populate dw_release_display data window in 
						w_visual_receiving_dock_version2 if PO is line item receiving. */
/* 04-07-2000 KAZ Modified to redraw datawindow and set focus to serial field when 
						invalid serial is entered.  */

datawindowchild	ldwc_dddw
datawindowchild	ldw_child

choose case dwo.name
	case "serial"
		If isvalid ( dw_2 ) then dw_2.ReSet()					// ZZ
		w_scan_outserial.Resize ( 2450, 1060 )					// ZZ
		if data > '' then
			if Upper ( LeftA ( data, 1 ) ) = 'S' then
				data = RightA ( data, LenA ( data ) - 1 )
			end if
			if Retrieve ( Long ( data ) ) > 0 then
				GetChild ( "parent_part", ldwc_dddw )
				if ldwc_dddw.Retrieve ( GetItemString ( 1, "part" ) ) < 1 then
					ldwc_dddw.InsertRow ( 1 )
				end if
				id_originalqty = object.quantity[1]
				cb_1.Enabled = TRUE
				w_visual_receiving_dock_version2.i_s_Destination = GetItemString ( 1, "destination" )
			else
				MessageBox ( monsys.msg_title, "Serial number " + data + " not found!", StopSign! )
				cb_1.Enabled = FALSE
				dw_1.InsertRow(1) 																	// ADD 04-07-2000 KAZ
				berror = True																			// ADD 04-07-2000 KAZ
				return
			end if
		end if
	case "parent_part"
		dw_1.accepttext()																				// ADD 04-06-2000 KAZ
		SetItem ( 1, "location", sqlca.of_getprimarylocation ( data ) )
//		dw_1.SetTransObject (sqlca)																// ADD 04-06-2000 KAZ
		dw_1.GetChild ("unit_measure", ldw_child)												// ADD 04-06-2000 KAZ
		ldw_child.SetTransObject (sqlca)															// ADD 04-06-2000 KAZ
		ldw_child.retrieve ( GetItemString ( 1, "parent_part" ) )						// ADD 04-06-2000 KAZ
//		GetChild ( "unit", ldwc_dddw )															// CHG 04-06-2000 KAZ
//		if ldwc_dddw.Retrieve ( GetItemString ( 1, "part" ) ) < 1 then
//			ldwc_dddw.InsertRow ( 1 )
//		end if																							// END 04-06-2000 KAZ
		GetChild ( "package_type", ldwc_dddw )
		if ldwc_dddw.Retrieve ( GetItemString ( 1, "Parent_part" ) ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if

		if object.part[1] <> data then // as long as part and parent_parts are not same
			if w_visual_receiving_dock_version2.cbx_line_item.checked then					// ADD 04-06-2000 KAZ
				dw_2.SetTransObject (sqlca)															// ADD 04-06-2000 KAZ
				dw_2.retrieve ( w_visual_receiving_dock_version2.ipo, ( GetItemString ( 1, "parent_part" ) ) ) // ADD 04-06-2000 KAZ
				w_scan_outserial.Resize ( 2450, 1500 )												// ADD 04-06-2000 KAZ
				dw_2.SetTabOrder(1,160)																	// ADD 04-06-2000 KAZ
				if	not dw_2.Visible then dw_2.Visible = true										// ADD 04-06-2000 KAZ
				dw_2.Enabled = True																		// ADD 04-06-2000 KAZ
			end if // ADD 04-06-2000 KAZ
		end if 
end choose
end event

event constructor;/* 04-07-2000 KAZ Modified to set focus to serial field when invalid serial is entered.  */
/* 04-10-2000 KAZ Modified to populate unit of measure with conversion unit of measure.
						Issue # 13328.  */

datawindowchild	ldwc_dddw

berror = False												// ADD 04-07-2000 KAZ

GetChild ( "parent_part", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

//GetChild ( "unit", ldwc_dddw )						// CHG 04-10-2000 KAZ
GetChild ( "unit_measure", ldwc_dddw )				// CHG 04-10-2000 KAZ
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

GetChild ( "package_type", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

SetTransObject ( sqlca )
InsertRow ( 1 )
end event

event dberror;return 1
end event

event itemfocuschanged;/* 04-07-2000 KAZ Created to set focus to the serial field when invalid serial is entered. */

choose case dwo.name
	case "part"
		If berror Then	
			berror = False
			dw_1.setcolumn ( 1 ) 
		End If
end choose	

end event

