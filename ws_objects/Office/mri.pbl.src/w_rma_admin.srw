$PBExportHeader$w_rma_admin.srw
forward
global type w_rma_admin from Window
end type
type cb_2 from commandbutton within w_rma_admin
end type
type cb_1 from commandbutton within w_rma_admin
end type
type dw_rma from datawindow within w_rma_admin
end type
type dw_rma_list from datawindow within w_rma_admin
end type
end forward

global type w_rma_admin from Window
int X=672
int Y=260
int Width=2935
int Height=1536
boolean TitleBar=true
string Title="List of RMA#'s"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event add_rma pbm_custom01
event delete_rma pbm_custom02
event credit_memo pbm_custom03
cb_2 cb_2
cb_1 cb_1
dw_rma dw_rma
dw_rma_list dw_rma_list
end type
global w_rma_admin w_rma_admin

type variables
Boolean bitemchanged = False
string		is_columnname,&
		is_message
end variables

on add_rma;dw_rma.Reset()
dw_rma.InsertRow ( 1 )
dw_rma.SetItem ( 1, "part", "RMA" )
dw_rma.SetItem ( 1, "status", " " )
dw_rma.SetItem ( 1, "type", "R" )
dw_rma.SetItem ( 1, "location", " " )
dw_rma.SetItem ( 1, "unit_measure", "A" )

dw_rma.Show ()
cb_1.Show ()
cb_2.Show ()

//OpenWithParm ( w_rma_admin_entry,  0)

end on

on delete_rma;Long		ll_Row
Long		ll_RMA

ll_Row = dw_rma_list.GetSelectedRow ( 0 )

If ll_Row < 1 Then 

	w_rma_admin.SetMicroHelp ( "Select a row to delete..." )
	Return

End If

ll_RMA = dw_rma_list.GetItemNumber ( ll_Row, "serial" )

If MessageBox ( "Delete RMA", "Are you sure about deleting RMA # " + String ( ll_RMA ) + "?", Question!, YesNo!, 2 ) = 1 Then
	dw_rma_list.DeleteRow ( ll_Row )
	If dw_rma_list.Update ( ) = -1 Then
		RollBack ;
	Else
		Commit ;
	End if
End if
end on

event credit_memo;/* 01-28-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'll_Invoice' (next Invoice number) and 'll_Shipper' 
						(next SHipper number).  */

//  Declare Variables
Long		ll_Invoice
Long		ll_Shipper
Long		ll_Row
Long		ll_Serial
Long		ll_RMA
Long		l_Shipper
Long     l_ordno
String	ls_Destination
String	ls_Customer
String	ls_Plant
String	ls_Terms
String	ls_Part
String	ls_PoNumber
String	ls_Note
String	ls_AccountCode
String	ls_OrderNo
String	ls_Operator
String	ls_Taxable
String	ls_Unit
String	ls_Name
String	ls_CustomerPart
Date		ld_Today
DateTime	ldt_Today
Dec		ld_TaxRate
Dec		ld_Quantity
Dec		ld_Price
Boolean	lb_Failed

l_ordno = 0 

//  Initialize Variables
ll_Row 	= dw_rma_list.GetSelectedRow (0)

//  Check to see if row is highlighted
If ll_Row < 1 Then 
	MessageBox ( "Error", "You must select an RMA to credit!", StopSign! )
	Return
End if

//  Create credit header
ll_RMA = dw_rma_list.GetItemNumber ( ll_Row, "serial" )

ld_Today	= Today ( )
ldt_Today = DateTime(Today(),Now())

//OpenWithParm ( w_get_parm_value, "next_invoice" )																		-  CHG 01-28-2000 KAZ
//Do																																		-  CHG 01-28-2000 KAZ
//Loop While Not bFinish																											-  CHG 01-28-2000 KAZ
//ll_Invoice = Message.DoubleParm																								-  CHG 01-28-2000 KAZ

//  Get the next invoice number																									-  ADD 01-28-2000 KAZ
if not sqlca.of_getnextparmvalue ( "next_invoice", ll_Invoice ) then    // Failed to get current value 	-  ADD 01-28-2000 KAZ
	Rollback;																															// ADD 01-28-2000 KAZ
	MessageBox(monsys.msg_title, "Failed to get a new Invoice number, Please try again", Exclamation! )	// ADD 01-28-2000 KAZ
	Return																																// ADD 01-28-2000 KAZ
end if																																	// ADD 01-28-2000 KAZ

//OpenWithParm ( w_get_parm_value, "shipper" )																				-  CHG 01-28-2000 KAZ
//Do																																		-  CHG 01-28-2000 KAZ
//Loop While Not bFinish																											-  CHG 01-28-2000 KAZ
//ll_Shipper 		= Message.DoubleParm																							-  CHG 01-28-2000 KAZ

//  Get the next shipper number																									-  ADD 01-28-2000 KAZ
if not sqlca.of_getnextparmvalue ( "shipper", ll_Shipper ) then    // Failed to get current value 	 		-  ADD 01-28-2000 KAZ
	Rollback;																															// ADD 01-28-2000 KAZ
	MessageBox(monsys.msg_title, "Failed to get a new Shipper number, Please try again", Exclamation! )	// ADD 01-28-2000 KAZ
	Return																																// ADD 01-28-2000 KAZ
end if																																	// ADD 01-28-2000 KAZ

ls_Destination = dw_rma_list.GetItemString ( ll_Row, "destination" )
ls_Customer		= dw_rma_list.GetItemString ( ll_Row, "customer" )

SELECT destination.plant,
		 destination.salestax_rate
  INTO :ls_Plant,
		 :ld_TaxRate
  FROM destination  
 WHERE (destination.destination = :ls_Destination);

Select customer.terms
  Into :ls_Terms
  From customer
 Where customer.customer = :ls_Customer ;

INSERT INTO shipper  
          ( id,   
            destination,   
            date_stamp,   
            shipping_dock,   
            ship_via,   
            status,   
            date_shipped,   
            aetc_number,   
            freight_type,   
            printed,   
            bill_of_lading_number,   
            model_year_desc,   
            model_year,   
            customer,   
            location,   
            staged_objs,   
            plant,   
            type,   
            invoiced,   
            invoice_number,   
            freight,   
            tax_percentage,   
            total_amount,   
            gross_weight,   
            net_weight,   
            tare_weight,   
            responsibility_code,   
            trans_mode,   
            pro_number,   
            notes,   
            time_shipped,   
            truck_number,   
            invoice_printed,   
            seal_number,   
            terms,   
            tax_rate,   
            staged_pallets,   
            container_message,   
            picklist_printed,   
            dropship_reconciled )  
   VALUES ( :ll_Shipper,   
            :ls_Destination,   
            :ldt_today,   
            null,   
            null,   
            'C' ,   
            :ldt_today,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            :ls_Customer,   
            null,   
            null,   
            :ls_Plant ,   
            'M' ,   
            null,   
            :ll_Invoice,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            null,   
            'N',   
            null,   
            :ls_Terms,   
            :ld_TaxRate,   
            null,   
            null,   
            null,   
            null )  ;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	MessageBox ( "Error", "Save of credit memo failed!~r1)" + SQLCA.SQLErrText, StopSign! )
	Return
End if

//  Create credit detail
 DECLARE objects_in_rma CURSOR FOR  
  SELECT object.serial,   
         object.part,   
         object.note,   
         object.quantity,   
         object.po_number,
			object.unit_measure,
			object.operator
    FROM object  
   WHERE object.parent_serial = :ll_RMA   
ORDER BY object.serial ASC  ;

Open objects_in_rma ;

Do
	Fetch objects_in_rma Into :ll_Serial,:ls_Part,:ls_Note,:ld_Quantity,:ls_PoNumber,:ls_Unit,:ls_Operator ;
	If SQLCA.SQLCode = 0 Then

		Select	shipper
		Into		:l_Shipper
		From		audit_trail
		Where		serial = :ll_Serial And
					type = 'S' ;

		If SQLCA.SQLCode <> 0 Then
			Select	price
			Into		:ld_Price
			From		part_standard
			Where		part = :ls_Part ;
	
			Select 	taxable, 
						customer_part
	    	Into 		:ls_Taxable, 
						:ls_CustomerPart  
	    	From 		part_customer
	   	Where 	( part = :ls_Part ) AND  
	         		( customer = :ls_Customer )   ;
		Else
			Select	customer_part, 
						price
			Into		:ls_CustomerPart, 
						:ld_Price
			From		shipper_detail
			Where		( shipper = :l_Shipper ) AND
						( part = :ls_Part ) ;

			Select 	taxable 
	    	Into 		:ls_Taxable 
	    	From 		part_customer
	   	Where 	part = :ls_Part AND customer = :ls_Customer   ;
		End if
		
		Select	name
		Into		:ls_Name
		From		part
		Where		part.part = :ls_Part ;

		Select 	gl_account_code
		Into 		:ls_AccountCode
		From 		part_mfg
		Where		part = :ls_Part ;


		INSERT INTO shipper_detail
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
           			dropship_oe_row_id,   
           			suffix,   
           			part_name,   
           			part_original,   
           			total_cost,   
           			group_no,
						alternate_price )  
		   VALUES ( :ll_Shipper,   
           			:ls_Part,   
           			:ld_Quantity,   
           			:ld_Quantity,   
           			:ld_Quantity,   
           			null,   
           			:l_OrdNo,   
           			null,   
           			null,   
           			null,   
           			'I',   
           			null,   
           			:ls_AccountCode,   
           			null,   
           			null,   
           			null,   
           			null,   
           			:ldt_Today,   
           			null,   
           			null,   
           			:ls_Note,   
           			:ls_Operator,   
           			null,   
           			null,   
           			:ld_Quantity,   
           			:ls_Unit,   
           			null,   
           			:ls_Taxable,   
           			'P',   
           			null,   
           			:ls_CustomerPart,   
           			null,   
           			null,   
           			null,   
           			null,   
           			:ls_Name,   
           			:ls_Part,   
           			null,   
           			null,
						:ld_price)  ;

		If SQLCA.SQLCode <> 0 Then lb_Failed = True

	End if

Loop While SQLCA.SQLCode = 0

Close objects_in_rma ;

If Not lb_Failed Then
	UPDATE	object  
	SET 		unit_measure = 'C'  
   WHERE 	serial = :ll_RMA   ;

	If SQLCA.SQLCode <> 0 Then
		RollBack ;
		MessageBox ( "Error", "Save of credit memo failed!", StopSign! )
		MessageBox ( "Error", SQLCA.SQLErrText )
	Else		
		Commit ;
		MessageBox ( "Success", "Save of credit memo #" + String ( ll_Invoice ) + " was a success!  You may now enter the Invoice Screen and edit the invoice that was created and credit your customer.", Exclamation! )
		dw_rma_list.Retrieve ( )
	End if
Else
	RollBack ;
	MessageBox ( "Error", "Save of credit memo failed!", StopSign! )
End if
end event

on closequery;Int iRtnCode

If bitemchanged = True Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			cb_1.TriggerEvent ( clicked! )

         If bitemchanged = True AND iRtnCode = 1 Then
				  Message.Returnvalue = 1   
	      End If

	  Case 2 

        Close ( w_rma_admin )
  
     Case 3

		  Message.Returnvalue = 1       

     End Choose

Else

      Close ( w_rma_admin )
    
End If
	




end on

on activate;If gnv_App.of_GetFrame().MenuName <> "m_rma_admin" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_rma_admin )


end on

on open;dw_rma_list.SetTransObject ( sqlca )
dw_rma.SetTransObject ( SQLCA )
dw_rma_list.Retrieve ( )
end on

on w_rma_admin.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_rma=create dw_rma
this.dw_rma_list=create dw_rma_list
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_rma,&
this.dw_rma_list}
end on

on w_rma_admin.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_rma)
destroy(this.dw_rma_list)
end on

type cb_2 from commandbutton within w_rma_admin
int X=1522
int Y=968
int Width=274
int Height=108
int TabOrder=40
boolean Visible=false
string Text="&Cancel"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;bitemchanged = False

dw_rma.Hide ()
cb_1.Hide ()
cb_2.Hide ()


end on

type cb_1 from commandbutton within w_rma_admin
int X=1216
int Y=968
int Width=242
int Height=108
int TabOrder=30
boolean Visible=false
string Text="&Ok"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* 01-28-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'll_Serial' (next serial number).  */

String	ls_Destination
String	ls_Status
String	ls_Operator
String   ls_password

Long		ll_Serial

Int 		i_Rtn

If f_get_value ( dw_rma.GetItemNumber ( 1, "serial" ) ) = 0 Then
	
//	OpenWithParm ( w_get_parm_value, "next_serial" )																		-  CHG 01-28-2000 KAZ
//	ll_Serial = Message.DoubleParm																								-  CHG 01-28-2000 KAZ
	
	if not sqlca.of_getnextparmvalue ( "next_serial", ll_Serial ) then    // Failed to get current value 	-  ADD 01-28-2000 KAZ
		Rollback;																														// ADD 01-28-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Serial number, Please try again", Exclamation! )	// ADD 01-28-2000 KAZ
		Return																															// ADD 01-28-2000 KAZ
	end if																																// ADD 01-28-2000 KAZ

	dw_rma.SetItem ( 1, "serial", ll_Serial )
End if

If dw_rma.AcceptText () = -1 Then Return

ls_Password = dw_rma.GetItemString ( 1, "operator_password" )

If ls_Password = "" OR IsNull ( ls_Password ) Then

		MessageBox("DataWindow Error", "Operator Password cannot be null!", StopSign! )
      dw_rma.SetFocus ( )
		dw_rma.SetColumn ( "operator_password" )
      Return

Else

		SELECT 	employee.operator_code  
		INTO 		:ls_Operator  
		FROM 		employee  
		WHERE 	employee.password = :ls_Password   ;

		If SQLCA.SQLCode = 0 Then
	
				dw_rma.SetItem ( 1, "operator", ls_Operator )

		Else

				MessageBox("DataWindow Error", "Invalid Operator Password!", StopSign! )
      		dw_rma.SetItem ( 1, "operator_password" , "" )
				dw_rma.SetItem ( 1, "operator", "" )
				dw_rma.SetFocus ( )
				dw_rma.SetColumn ( "operator_password" )
   		   Return
	
		End if

End If

i_Rtn = dw_rma.Update ()

CHOOSE CASE i_Rtn

  CASE 1
		Commit ;
   	bitemchanged = False
		dw_rma_list.Retrieve()
		dw_rma.visible = False
		cb_1.visible = False
		cb_2.visible = False

	CASE ELSE

      bitemchanged = True
	   Rollback ;

END CHOOSE   


	

end event

type dw_rma from datawindow within w_rma_admin
event error_message pbm_custom01
int X=384
int Y=288
int Width=2144
int Height=824
int TabOrder=20
boolean Visible=false
string DataObject="d_rma_admin_entry"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on itemchanged;String	ls_Destination
String	ls_Customer
String	ls_Password
String	ls_Operator
String	ls_Status
int      i_chknumber

is_ColumnName = This.GetColumnName ( )

If is_ColumnName = "destination" Then

  	ls_Destination = f_get_string_value ( This.GetText ( ) )

  	SELECT 	destination.customer  
   INTO 		:ls_Customer  
   FROM 		destination  
   WHERE 	destination.destination = :ls_Destination   ;

	If SQLCA.SQLCode = 0 Then
		This.SetItem ( 1, "customer", ls_Customer )
	Else
		is_Message = "Invalid destination!  Please enter a valid one."
      messagebox("System Error",is_message)      
//		w_rma_admin_entry.PostEvent ( "error_message" )
	End if

ElseIf is_ColumnName = "operator_password" Then

	ls_Password = f_get_string_value ( This.GetText ( ) )

  	SELECT 	employee.operator_code  
   INTO 		:ls_Operator  
   FROM 		employee  
   WHERE 	employee.password = :ls_Password   ;

	If SQLCA.SQLCode = 0 Then
		This.SetItem ( 1, "operator", ls_Operator )
	Else
		is_Message = "Invalid Operator Password!  Please enter a valid one."
      messagebox("System Error",is_message)      
//		w_rma_admin_entry.PostEvent ( "error_message" )
	End if

ElseIf is_ColumnName = "status" Then

	ls_Status = f_get_string_value ( This.GetText ( ) )

	If ls_Status = "" Then
		is_Message = "Invalid Status!  Please choose a valid one."
      messagebox("System Error",is_message)      
//		w_rma_admin_entry.PostEvent ( "error_message" )
	End if

End if

bitemchanged = True



//String ls_Password
//
//If dw_rma.GetColumnname() = 'operator_password' Then
//
//	ls_Password = dw_rma.GetItemString ( 1, "operator_password" )
//
//	dw_rma.SetItem ( 1, "operator", ls_password )
//
//End If
//
//bitemchanged = True
end on

on itemfocuschanged;String	ls_Destination
String	ls_Customer
String	ls_Password
String	ls_Operator
String	ls_Status

is_ColumnName = This.GetColumnName ( )

If keyDown ( keyTab! ) Then
	If is_ColumnName = "unit_measure" And f_get_string_value ( This.GetItemString ( 1, "destination" ) ) = "" Then
		is_Message = "Invalid destination!  Please enter a valid one."
		is_ColumnName = "destination"
		w_rma_admin_entry.PostEvent ( "error_message" )
	Elseif is_ColumnName = "note" And f_get_string_value ( This.GetItemString ( 1, "operator_password" ) ) = "" Then
		is_Message = "Invalid Operator Password!  Please enter a valid one."
		is_ColumnName = "operator_password"
		w_rma_admin_entry.PostEvent ( "error_message" )
	Elseif is_ColumnName = "operator_password" And f_get_string_value ( This.GetItemString ( 1, "status" ) ) = "" Then
		is_Message = "Invalid Status!  Please choose a valid one."
		is_ColumnName = "status"
		w_rma_admin_entry.PostEvent ( "error_message" )
	End if
End if


//String ls_Password
//
//If keyDown ( keyTab! ) Then
//
//	If dw_rma.GetColumnName() = "note" Then
//
//		ls_Password = dw_rma.GetItemString ( 1, "operator_password" )
//		dw_rma.SetItem ( 1, "operator", ls_password )
//
//	End If
//
//End If
//
//
//
end on

event dberror;dw_rma.SetText ("")

return ( 2 )
end event

on editchanged;bitemchanged = True
end on

type dw_rma_list from datawindow within w_rma_admin
int X=14
int Y=20
int Width=2848
int Height=1392
int TabOrder=10
string DataObject="d_rma_list_admin"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Long		ll_Row
Long		ll_RMA

ll_Row = This.GetClickedRow ( )

If ll_Row < 1 Then Return

SelectRow ( This, 0, False )
SelectRow ( This, ll_Row, True )

ll_RMA = This.GetItemNumber ( ll_Row, "serial" )

dw_rma.Reset ( )

dw_rma.Show ()
cb_1.Show ()
cb_2.Show ()

dw_rma.Retrieve ( ll_Rma )
dw_rma.SetColumn ( "destination" )
dw_rma.SetItem ( 1, "operator", "" )
dw_rma.SetFocus ( )
end on

on clicked;Long		ll_Row

ll_Row = This.GetClickedRow ( )

If ll_Row < 1 Then Return

SelectRow ( This, 0, False )
SelectRow ( This, ll_Row, True )



end on

