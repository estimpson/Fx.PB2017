$PBExportHeader$w_rma_receive_object.srw
forward
global type w_rma_receive_object from Window
end type
type dw_rma_items from datawindow within w_rma_receive_object
end type
type dw_rma_objects from datawindow within w_rma_receive_object
end type
type dw_audit_trail from datawindow within w_rma_receive_object
end type
type dw_rma_list from datawindow within w_rma_receive_object
end type
type gb_4 from groupbox within w_rma_receive_object
end type
type gb_3 from groupbox within w_rma_receive_object
end type
type gb_1 from groupbox within w_rma_receive_object
end type
end forward

global type w_rma_receive_object from Window
int X=5
int Y=4
int Width=2912
int Height=1736
boolean TitleBar=true
string Title="RMA Receiving"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_label pbm_custom01
event ue_add_rma pbm_custom02
event ue_notes pbm_custom03
event ue_print_rma pbm_custom04
event ue_scan_object pbm_custom05
event ue_close_uo_note pbm_custom06
event ue_save_note pbm_custom07
event ue_delete_object pbm_custom08
dw_rma_items dw_rma_items
dw_rma_objects dw_rma_objects
dw_audit_trail dw_audit_trail
dw_rma_list dw_rma_list
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
end type
global w_rma_receive_object w_rma_receive_object

type variables
Long	il_RMA, &
                il_oldshipper[]

string	i_s_unit

Decimal	i_n_stdqty

u_generic_note  iuo_note
end variables

event ue_label;//************************************************************************************//
// Event Name :	ue_label
//
// Description:	This event prints the label for object selected 
//
// Syntax	  :	LONG ue_label ()
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 14:17.00 Original.
//************************************************************************************//

long	ll_serial, &
		ll_row
		
st_generic_structure lstr_parm

// Get the selected row from object list		
ll_row  = dw_rma_objects.Getselectedrow (0)

if ll_row > 0 then
	
	// Get serial number for the selected object
	ll_serial = dw_rma_objects.object.#1 [ll_row]
	
	if ll_serial > 0 then

		// Set the st generic structure values
		lstr_parm.value1 = string ( ll_serial )
		setmicrohelp ( 'Printing Label' )
		if f_print_label ( lstr_parm ) < 0 then
			setmicrohelp ( 'Unable to print label for serial ' + lstr_parm.value1 )
		end if
		
	end if	
	
else
	
	messagebox ( monsys.msg_title, 'You must choose object to relabel!', information! )
	dw_rma_objects.setfocus ()
	return
	
end if
end event

event ue_notes;//************************************************************************************//
// Event Name:	ue_notes
//
// Description:	This event opens the user object to enter notes to shipper detail items.
//
// Returns Codes:	None
//
// Log of Changes:
// MB	05-19-1999 14:05.00 Original.
//************************************************************************************//

string 	ls_note, &
			ls_datatype, &
			ls_error, &
			ls_syntax

long 		ll_row

datastore  lds_shippernote

// Create Shipper Detail datastore to get the datatype for the note column
lds_shippernote = create datastore 

ls_syntax  = 'Select note from shipper_detail where shipper = ' + string ( il_rma )
ls_syntax  = SQLCA.SyntaxFromSQL ( ls_syntax, "style(type=grid)",  ls_error )

If ls_error <= '' or isnull ( ls_error ) then 
	lds_shippernote.create ( ls_syntax, ls_error ) 
	lds_shippernote.settransobject ( sqlca )
	if lds_shippernote.retrieve () > 0 then
		ls_note = lds_shippernote.object.#1 [1] 
	end if
end if

// Get the datatype of note column
ls_datatype = lds_shippernote.object.#1.coltype

destroy lds_shippernote ;

ll_row = dw_rma_items.Getselectedrow(0)

If ll_row > 0 then

	// Pass the datatype to the user object to set the limit on the column
	OpenUserObjectWithParm ( iuo_note, ls_datatype, 622,161 )
	iuo_note.bringtotop = True
	iuo_note.borderstyle = StyleRaised!

	ls_note = dw_rma_items.GetItemString ( ll_row, "shipper_detail_note" )
	iuo_note.mle_note.text = ls_note

else

   MessageBox (monsys.msg_title, "You have to choose a shipper detail row!", Information! )
   return
  
end if
end event

event ue_print_rma;//************************************************************************************//
// Event Name :	ue_print_rma
//
// Description:	This event opens report viewer window to print the rma document.
//
// Syntax	  :	LONG ue_print_rma ()
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 17:30.00 Original.
//************************************************************************************//

st_generic_structure lst_parm
		
lst_parm.value1 = string ( il_rma )
lst_parm.value11 = "RMA"
		
OpenSheetWithParm ( w_report_view, lst_parm, gnv_App.of_GetFrame(), 2, layered! )

		

end event

event ue_scan_object;//************************************************************************************//
// Event Name :	ue_scan_object
//
// Description:	This event opens scan objects window to enable user to scan objects.
//
// Syntax	  :	LONG ue_scan_object ()
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 17:30.00 Original.
//************************************************************************************//
long ll_row

if il_rma > 0 then

	OpenWithParm ( w_scan_objects_rma, il_rma )
		
	// refresh all datawindows.	
	ll_row = dw_rma_list.getselectedrow (0) 
	dw_rma_list.retrieve ()
	dw_rma_list.selectrow ( ll_row, true )
	dw_rma_items.retrieve ( il_rma )
	dw_rma_objects.retrieve ( String ( il_rma ) )
	
else
	
	messagebox ( monsys.msg_title, 'You must choose an RMA to scan objects!', Information! )
	dw_rma_list.setfocus ()
	return

end if
end event

event ue_close_uo_note;if isvalid ( iuo_note ) then
	
	  closeuserobject(iuo_note)
	  dw_rma_items.Retrieve(il_rma)
	  
end if
end event

event ue_save_note;//************************************************************************************//
// Event Name :	ue_save_note
//
// Description:	This event saves the note to the respective shipper detail row.
//
// Syntax	  :	LONG ue_save_note ()
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 17:32.00 Original.
//************************************************************************************//

string ls_note, &
		 ls_part

Long	 ll_row

ls_note = iuo_note.mle_note.text

ll_row = dw_rma_items.GetSelectedRow ( 0 )

if ll_row > 0 then
	
	ls_part = dw_rma_items.object.part [ ll_row ]
		
	Update Shipper_Detail
	set	 note = :ls_note
	where	 shipper = :il_rma and
			 part	   = :ls_part ;

	if sqlca.sqlcode = 0  then
		commit ;
		dw_rma_items.retrieve ( il_rma )
		dw_rma_items.selectrow ( ll_row, true )
		closeuserobject(iuo_note)
	else
		messagebox ( monsys.msg_title, "Unable to save the note!" + sqlca.sqlerrtext, Information!  )
  		rollback ;
	end if

end if


end event

event ue_delete_object;//************************************************************************************//
// Event Name :	ue_delete_object
//
// Description:	This function deletes the object that was received and will delete the 
//						audit trail entry also for the type = 'U' and serial =  serial
//
// Syntax:			LONG ue_delete_object	()
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 14:12.00 Original.
//************************************************************************************//

integer  li_rtncode, &
			li_return

LONG	   ll_serial, &
		   ll_row, &
			ll_suffix

datastore lds_reverse_object

lds_reverse_object = CREATE datastore
lds_reverse_object.dataobject = 'd_msp_reverse_rma_object'
lds_reverse_object.settransobject ( sqlca )

// Get the Selected Row  from objects list
ll_row = dw_rma_objects.GetSelectedRow (0)

if ll_row > 0 and dw_rma_objects.rowcount () > 0 then

	// Get the serial and suffix from the object
	ll_serial = dw_rma_objects.object.#1 [ll_row]
	ll_suffix = dw_rma_objects.object.suffix [ll_row]
	
	// Check if the user is sure of deleting the object
	li_rtncode = Messagebox ( monsys.msg_title, "Are you sure you want to delete serial # " + string( ll_serial ), Question!, YesNo!, 2 ) 

	if li_rtncode = 1 then
	
		// Delete the Object from object and audit trail tables
		if lds_reverse_object.retrieve ( ll_serial, il_rma )  > 0 then
			
			li_return = lds_reverse_object.object.#1 [1] 
	
			choose case li_return  
				case 0
					commit ;
					// refresh the other datawindows if the deletion was succesful
					dw_rma_items.Retrieve ( il_rma )
					dw_rma_objects.Retrieve ( String ( il_rma ) )
					SetMicroHelp ( 'The transaction has been reversed!' )
				case -1
					rollback ;
					SetMicroHelp ( 'Unable to reverse the transaction. Audit Trail entry does not exist!' )
			end choose
			
		end if

	end if	

else
	
	messagebox ( monsys.msg_title, 'You must choose an object to delete!' , Information! )
	dw_rma_objects.setfocus ()
	return

end if

destroy lds_reverse_object ;
end event

event activate;If gnv_App.of_GetFrame().MenuName <> "m_rma_shop_level" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_rma_shop_level )


end event

on w_rma_receive_object.create
this.dw_rma_items=create dw_rma_items
this.dw_rma_objects=create dw_rma_objects
this.dw_audit_trail=create dw_audit_trail
this.dw_rma_list=create dw_rma_list
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.Control[]={this.dw_rma_items,&
this.dw_rma_objects,&
this.dw_audit_trail,&
this.dw_rma_list,&
this.gb_4,&
this.gb_3,&
this.gb_1}
end on

on w_rma_receive_object.destroy
destroy(this.dw_rma_items)
destroy(this.dw_rma_objects)
destroy(this.dw_audit_trail)
destroy(this.dw_rma_list)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;dw_rma_list.retrieve ( )
end event

type dw_rma_items from datawindow within w_rma_receive_object
int X=41
int Y=568
int Width=2789
int Height=432
int TabOrder=30
string DataObject="d_shipping_dock_shipper_detail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

event clicked;if row > 0 then
	selectrow ( 0, false )
	selectrow ( row, true )
end if
end event

type dw_rma_objects from datawindow within w_rma_receive_object
int X=41
int Y=1080
int Width=2789
int Height=508
int TabOrder=50
string DragIcon="MONITOR.ICO"
string DataObject="d_object_list_per_rma"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;SelectRow ( This, 0, False )

If row < 1 Then Return

SelectRow ( This, Row, True )
SetRow ( Row )

This.Drag ( Begin! )
end event

event constructor;this.settransobject ( sqlca )
end event

type dw_audit_trail from datawindow within w_rma_receive_object
int X=23
int Y=1432
int Width=1810
int Height=352
int TabOrder=60
boolean Visible=false
string DataObject="d_last_transaction"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

type dw_rma_list from datawindow within w_rma_receive_object
int X=41
int Y=52
int Width=2789
int Height=436
int TabOrder=10
string DataObject="d_rma_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;//String	ls_ObjectAtPointer
//Long		ll_Pos
//Long		ll_Row
//Long		ll_RMA
//Long		ll_Serial
//Int		iRtnCode
//
//b_dragged = false
//ls_ObjectAtPointer = This.GetObjectAtPointer ( )
//
//If ls_ObjectAtPointer = "" Then Return
//
//ll_Pos = Pos ( ls_ObjectAtPointer, '~t' )
//ll_Row = Long ( Right ( ls_ObjectAtPointer, Len ( ls_ObjectAtPointer ) - ll_Pos ) )
//ll_RMA = This.GetItemNumber ( ll_Row, "serial" )
//ll_Serial	= dw_rma_objects.GetItemNumber ( dw_rma_objects.GetRow ( ), "serial" )
//
//iRtnCode = MessageBox ( monsys.msg_title, "Are you sure you want to move serial # " + String ( ll_Serial ) + " to RMA # " + String ( ll_RMA ) + "?", Question!, YesNo!, 2 )
//
//If iRtnCode = 1 Then
//
//	UPDATE	object  
//	SET 		parent_serial = :ll_RMA  
//	WHERE		serial = :ll_Serial   ;
//   
//	If SQLCA.SQLCode = 0 Then
//		Commit ;
//		dw_rma_objects.Retrieve ( This.GetItemNumber ( This.GetRow ( ), "serial" ) )
//      b_dragged = true
//	Else
//		RollBack ;
//	End if
//
//End if
end event

event constructor;this.settransobject ( sqlca )
end event

event clicked;if row > 0 then
	selectrow ( 0, false )
	selectrow ( row, true )
	
	il_RMA = object.#1 [ row ]
	if il_RMA > 0 then 
		if dw_rma_items.retrieve ( il_RMA ) > 0 then
			il_oldshipper = dw_rma_items.object.old_shipper.primary
			
			dw_rma_objects.retrieve ( string ( il_rma ) )
		end if
	end if
end if
end event

type gb_4 from groupbox within w_rma_receive_object
int X=18
int Y=1024
int Width=2839
int Height=588
int TabOrder=40
string Text="Object's Attached to RMA #:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_rma_receive_object
int X=18
int Y=512
int Width=2839
int Height=508
int TabOrder=20
string Text="Line Items :"
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_rma_receive_object
int X=18
int Width=2839
int Height=512
string Text="Available RMA's"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

