$PBExportHeader$w_scan_objects_rma.srw
forward
global type w_scan_objects_rma from Window
end type
type dw_rma_objects from datawindow within w_scan_objects_rma
end type
type cb_manual_scan from commandbutton within w_scan_objects_rma
end type
type cb_cancel from commandbutton within w_scan_objects_rma
end type
type cb_ok from commandbutton within w_scan_objects_rma
end type
type dw_location from datawindow within w_scan_objects_rma
end type
type dw_objects from datawindow within w_scan_objects_rma
end type
type gb_2 from groupbox within w_scan_objects_rma
end type
type gb_1 from groupbox within w_scan_objects_rma
end type
end forward

global type w_scan_objects_rma from Window
int X=96
int Y=500
int Width=2706
int Height=1216
long BackColor=78682240
WindowType WindowType=response!
event ue_scan ( long al_serial[] )
event ue_save ( )
event ue_manual_scan ( long al_serial )
dw_rma_objects dw_rma_objects
cb_manual_scan cb_manual_scan
cb_cancel cb_cancel
cb_ok cb_ok
dw_location dw_location
dw_objects dw_objects
gb_2 gb_2
gb_1 gb_1
end type
global w_scan_objects_rma w_scan_objects_rma

type variables
long     il_rma

u_rma_serial_scan   iuo_scan

datastore     ids_shipperdetail
end variables

event ue_scan;//************************************************************************************//
// Event Name :	ue_scan
//
// Description:	This event inserts rows to the scanned objects datawindow and prepares
//						for the scan event.
//
// Syntax	  :	LONG ue_scan ( Long al_serial[] )
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 05/19/1999 17:30.00 Original.
//************************************************************************************//

long 	ll_oldshipper, &
		ll_oldsuffix, &
		ll_count, &
		ll_Serial, &
		ll_rowcount, &
		ll_row[]
		
string ls_partorig

if upperbound ( al_serial ) > 0 then

	ll_rowcount = dw_rma_objects.retrieve ( al_serial )
	
	//	Include check to see if the object is valid for this shipper
	for ll_count = 1 to ll_rowcount 
		
		ll_serial		= dw_rma_objects.object.serial [ ll_count ] 
		ll_oldshipper 	= long ( dw_rma_objects.object.shipper [ ll_count ] )
		ll_oldsuffix  	= dw_rma_objects.object.suffix [ ll_count ]
		ls_partorig		= dw_rma_objects.object.part [ ll_count ]
	
		// Check if the object can be scanned to this shipper
		if ids_shipperdetail.find ( "old_shipper="+string ( ll_oldshipper ) + " and old_suffix = " + string ( ll_oldsuffix ) + " and part_original = '"+ls_partorig+"'" , 1, 99999 ) <= 0  then
			Messagebox ( monsys.msg_title, "Cannot scan object serial: " + string ( ll_serial ) , Information! )
			ll_row [ upperbound ( ll_row ) + 1 ] = ll_count 				
		end if	
		
	next	
	
	// Delete rows that were added to scanned objects list
	for ll_count = 1 to upperbound ( ll_row )
		dw_rma_objects.Deleterow ( ll_row [ ll_count ] )
	next

end if


end event

event ue_save;//************************************************************************************//
// Function Name:	ue_save
//
// Description:	This event adds an object entry for the serial numbers user is trying 
//						to receive
//
// Syntax:			LONG ue_save ( )
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 06-01-1999 10:26:00 Original.
// MB 09-25-1999 Modified.. Changed the script to create one object at a time, update 
//									 audit trail and shipper detail tables and then commit.
//									 also changed error messages to be displayed at the end
//									 Changed the update statement to update shipper tables from
//									 stored procedure
// KAZ 02-11-2000 Modified. Set remarks field in audit trail to 'RMA'. Issue # 13049.
// KAZ 02-11-2000 Modified. Set from_loc field to customer, and to_loc field to location
//									 set by operator when attaching objects to RMA.  Issue # 13048.
// KAZ 03-16-2000 Modified. Changed not to write RMA number to shipper field in 
//									 object table, write blank instead.  Issue # 13240.
// KAZ 04-05-2000 Modified. Populate 'weight' field in object.  Issue # 13313.
//************************************************************************************//

long 	ll_count, &
	ll_serial, &
	ll_oldshipper, &
	ll_oldsuffix, &
	ll_rowcount, &
	ll_row

string	ls_part, &
	ls_objects, &
	ls_auditobjects, &
	ls_origin

datastore lds_object, &
	lds_audittrail, &
	lds_shipper
			 
datetime ldt_datestamp

st_generic_structure lstr_parm 

// Create all the object, audit trail and shipper reconcile datastores
lds_object = create datastore
lds_object.dataobject = 'd_object_info'
lds_object.settransobject ( sqlca )

lds_audittrail = create datastore
lds_audittrail.settransobject ( sqlca )
lds_audittrail.dataobject = dw_rma_objects.dataobject

lds_shipper = create datastore
lds_shipper.dataobject = 'd_msp_reconcile_rma_shipper' 
lds_shipper.settransobject ( sqlca )

// Initialize the variables
ls_objects = ''
ls_auditobjects = ''

// Create objects and audit trail entries in inventory for the scanned objects
if dw_rma_objects.Rowcount() > 0 then

	// Loop through all the objects user has selected
	for ll_count = 1 to dw_rma_objects.rowcount() 

		// Get the serial number
		ll_Serial = dw_rma_objects.object.serial [ ll_count ]
		
		ldt_datestamp = datetime ( today(), now() ) 
	
		lds_object.Insertrow ( 1 )
		lds_object.Setitem ( 1, 1, ll_serial ) 									
		lds_object.Setitem ( 1, 2, dw_rma_objects.object.#4 [ ll_count ] )
		lds_object.Setitem ( 1, 3, ldt_datestamp )
		lds_object.Setitem ( 1, 4, dw_location.object.location [1] )
		lds_object.Setitem ( 1, 5, dw_location.object.operator [1] )
		lds_object.Setitem ( 1, 6, dw_rma_objects.object.#18 [ ll_count ] )
		lds_object.Setitem ( 1, 7, dw_rma_objects.object.#22 [ ll_count ] )		
		lds_object.Setitem ( 1, 8, dw_rma_objects.object.#49 [ ll_count ] )		
		// Weight is item # 9, below...
//		lds_object.Setitem ( 1, 9, 0 )																			// CHG 04-05-2000 KAZ
		lds_object.Setitem ( 1, 9, dw_rma_objects.object.#17 [ ll_count ] )							// CHG 04-05-2000 KAZ
		// lds_object.Setitem ( 1, 10, 'value' ) is object.parent_serial
		lds_object.Setitem ( 1, 11, dw_rma_objects.object.#5 [ ll_count ] )		
//		lds_object.Setitem ( 1, 12, il_rma )																	// CHG 03-16-2000 KAZ
		lds_object.Setitem ( 1, 12, '' )																			// CHG 03-16-2000 KAZ
		lds_object.Setitem ( 1, 14, dw_rma_objects.object.#16 [ ll_count ] )		
		lds_object.Setitem ( 1, 15, dw_rma_objects.object.#36 [ ll_count ] )		
		lds_object.Setitem ( 1, 16, dw_rma_objects.object.#24 [ ll_count ] )		
		lds_object.Setitem ( 1, 17, 'Y' )		
		lds_object.Setitem ( 1, 19, dw_rma_objects.object.#57 [ ll_count ] )		
		lds_object.Setitem ( 1, 20, dw_rma_objects.object.#27 [ ll_count ] )		
		lds_object.Setitem ( 1, 21, dw_rma_objects.object.#37 [ ll_count ] )		
		lds_object.Setitem ( 1, 26, dw_rma_objects.object.#34 [ ll_count ] )		
		lds_object.Setitem ( 1, 27, ldt_datestamp )		
		lds_object.Setitem ( 1, 29, dw_rma_objects.object.#9 [ ll_count ] )		
		lds_object.Setitem ( 1, 31, dw_rma_objects.object.#11 [ ll_count ] )		
		lds_object.Setitem ( 1, 32, dw_rma_objects.object.#52 [ ll_count ] )		
		lds_object.Setitem ( 1, 33, dw_rma_objects.object.#32 [ ll_count ] )		
		lds_object.Setitem ( 1, 34, dw_rma_objects.object.#51 [ ll_count ] )		
		lds_object.Setitem ( 1, 35, dw_rma_objects.object.#55 [ ll_count ] )		
		lds_object.Setitem ( 1, 36, dw_rma_objects.object.#28 [ ll_count ] )		
		lds_object.Setitem ( 1, 37, dw_rma_objects.object.#29 [ ll_count ] )		
		lds_object.Setitem ( 1, 38, dw_rma_objects.object.#30 [ ll_count ] )		
		lds_object.Setitem ( 1, 39, dw_rma_objects.object.#31 [ ll_count ] )		
		lds_object.Setitem ( 1, 40, dw_rma_objects.object.#43 [ ll_count ] )		
		lds_object.Setitem ( 1, 41, dw_rma_objects.object.#44 [ ll_count ] )		
		lds_object.Setitem ( 1, 42, dw_rma_objects.object.#23 [ ll_count ] )				
		lds_object.Setitem ( 1, 43, dw_rma_objects.object.#45 [ ll_count ] )		
		lds_object.Setitem ( 1, 44, dw_rma_objects.object.#59 [ ll_count ] )		
		lds_object.Setitem ( 1, 45, dw_rma_objects.object.#60 [ ll_count ] )		
		lds_object.Setitem ( 1, 46, dw_rma_objects.object.#61 [ ll_count ] )		
		ls_origin = String ( dw_rma_objects.object.shipper [ ll_count ] )
		lds_object.Setitem ( 1, 'origin', ls_origin )		

		// Create the object
		if sqlca.of_creatermaobject ( lds_object ) = 0 then
		
			// Get audit trail row with the user input for the same serial.
			dw_rma_objects.Rowscopy ( ll_count, ll_count, Primary!, lds_audittrail, 1, Primary! )
		
			// Set the status, remarks, operator, date_Stamp, shipper and origin columns on the AD row.
			lds_audittrail.Setitem ( 1, 3, 'U' )
			lds_audittrail.Setitem ( 1, 6, 'RMA' )																// ADD 02-11-2000 KAZ
			lds_audittrail.Setitem ( 1, 12, dw_location.object.operator [1] )
			lds_audittrail.Setitem ( 1, 2, ldt_datestamp )
			lds_audittrail.Setitem ( 1, 19, string ( il_rma ) )
			lds_audittrail.Setitem ( 1, 'origin', ls_origin )
			
			// Set the to_loc, and from_loc																		// ADD 02-11-2000 KAZ
			
			lds_audittrail.Setitem ( 1, 13, lds_audittrail.GetItemString ( 1, 14 ) )				// ADD 02-11-2000 KAZ
			lds_audittrail.Setitem ( 1, 14, dw_location.object.location [1] )							// ADD 02-11-2000 KAZ
						
			// Print label for the new object
			lstr_parm.value1 = string ( lds_audittrail.object.#1 [ 1 ] )
			
			// Inform the user if the label was not printed
			if f_print_label ( lstr_parm ) < 0 then
				setmicrohelp ( 'Unable to print label for serial ' + lstr_parm.value1 )
			end if							
		
			// Create the audit trail entry
			if sqlca.of_CreateAuditTrail ( lds_audittrail ) = 0 then
				commit ;			
			else
				// Append the serial number to the error list
				ls_auditobjects = ls_auditobjects + string ( ll_Serial ) + ', ' 
   		  	rollback ;
			end if
			
	   else
			
  			 // Append the serial number to the error list
			  ls_objects = ls_objects + string ( ll_Serial ) + ', '
   		  rollback ;
			  
		end if

		// Reset the object and audit trail rows
		lds_object.Reset ()
		lds_audittrail.Reset ()
		
	next

	// Inform user of errors
	if LenA ( ls_objects ) > 0 then
		ls_objects = LeftA ( ls_objects, LenA ( ls_objects ) - 2 ) 
		messagebox ( monsys.msg_title, 'Unable to receive Objects: ' + ls_objects + ' back to Inventory.', Information! ) 
	elseif LenA ( ls_auditobjects ) > 0 then
		ls_auditobjects = LeftA ( ls_auditobjects, LenA ( ls_auditobjects ) - 2 ) 
	  	messagebox ( monsys.msg_title, 'Unable to create Audit Trail entries for ' + ls_auditobjects + '.', Information! ) 				  
	end if

	// Update shipper tables  
	if lds_shipper.Retrieve ( il_rma ) > 0 then
			
		if lds_shipper.object.#1 [1] = 0 then
			commit ;
		else
			messagebox ( monsys.msg_title, 'Unable to Update Shipper Table!', Information! ) 
			rollback ;
		end if
			
	end if
		
end if

destroy lds_object ;
destroy lds_audittrail ;
destroy lds_shipper ;

Setmicrohelp ( 'Ready' )

dw_objects.retrieve ( il_rma )
dw_rma_objects.reset () 



end event

event ue_manual_scan;//************************************************************************************//
// Event Name :	ue_manual_scan
//
// Description:	Evaluates the serial that was scanned by the user and informs the user 
//						if its invalid. if its valid then triggers ue_Scan event.
//
// Syntax	  :	LONG ue_manual_scan ( Long al_serial )
//
// Returns Codes:	None 
//
// Log of Changes:
// MB 06/08/1999 14:15.00 Original.
//************************************************************************************//

long 	ll_Serial[], &
		ll_row

if al_serial > 0 then
	
		ll_serial[1] = al_serial 
			
		ll_row = dw_rma_objects.find ( "serial="+string (al_serial), 1, 999999 ) 
		if ll_row > 0 then 
			return
		end if
		
		ll_row = dw_objects.find ( "serial="+string (al_serial), 1, 999999 ) 

		if ll_row > 0 then 
				
			dw_objects.selectrow ( ll_row, true )			
			trigger dynamic event ue_scan ( ll_serial )

		else
		
			Messagebox ( monsys.msg_title, "Cannot scan object Serial: " + string ( al_serial ) + " against Shipper: " + string ( il_rma ) , Information! )	

		end if

end if


end event

on w_scan_objects_rma.create
this.dw_rma_objects=create dw_rma_objects
this.cb_manual_scan=create cb_manual_scan
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_location=create dw_location
this.dw_objects=create dw_objects
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.dw_rma_objects,&
this.cb_manual_scan,&
this.cb_cancel,&
this.cb_ok,&
this.dw_location,&
this.dw_objects,&
this.gb_2,&
this.gb_1}
end on

on w_scan_objects_rma.destroy
destroy(this.dw_rma_objects)
destroy(this.cb_manual_scan)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_location)
destroy(this.dw_objects)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;il_rma = message.doubleparm 

datawindowchild ldwc_location

// retreive the list of expected objects for the rma shipper
if il_rma > 0 then
	
	// retrieve objects that were shipped out for the old shipper on the rma shipper
	dw_objects.retrieve ( il_rma )	

	// get location values
	dw_location.Getchild ( 'location', ldwc_location )
	ldwc_location.Settransobject ( sqlca )
	ldwc_location.Retrieve ()
	
	// create shipper detail datastore for the rma shipper	
	ids_shipperdetail = create datastore
	ids_shipperdetail.dataobject = 'd_shipping_dock_shipper_detail'
	ids_shipperdetail.settransobject ( sqlca )

	// to make sure that the user cannot scan for empty shipper.
	if ids_shipperdetail.retrieve ( il_rma ) <= 0 then
		destroy ids_shipperdetail ;
		close ( this )
	end if

else
	
	close ( this )
	
end if
end event

type dw_rma_objects from datawindow within w_scan_objects_rma
int X=919
int Y=56
int Width=1746
int Height=852
int TabOrder=30
string Tag="StagedObjects"
string DataObject="d_audit_trail_info_rma"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;long	ll_Serial[]	

DataWindow	ldw_DragFrom

// check if a object is valid 
if IsValid ( source ) then
	
	// make sure user is dragged object is appropriate one
	if source.Tag = "objects" then
		
		// assign the dragged control to the datawindow object
		ldw_DragFrom = source
		
		// make sure a valid row is selected in source dw
		ll_Serial = ldw_DragFrom.object.serial.Selected
		
		if UpperBound ( ll_Serial ) > 0 then
			parent.trigger dynamic event ue_scan ( ll_serial )
		end if
	end if
end if


end event

event constructor;settransobject ( sqlca )
end event

event retrievestart;if isvalid ( iuo_scan ) then return 2
end event

event clicked;if row > 0 then
	if isselected ( row ) then
		selectrow ( row, false )
	else
		selectrow ( row, true )
	end if

	drag(begin!)
end if
end event

event itemchanged;dec	ld_stdqty

string	ls_stdunit, &
			ls_part

// if quantity is changed, update std quantity column
if dwo.name = 'quantity' then
	ls_part	 = object.part[row]
	ld_StdQty = f_convert_units ( object.unit[row], f_get_part_info ( ls_part, 'STANDARD UNIT' ), ls_part, dec ( data ) )	
	setitem ( row, 'std_quantity', ld_stdqty )
end if
end event

event retrieverow;setitem ( row, 'status' , 'H' )
setitem ( row, 'user_defined_status', 'On Hold')
end event

type cb_manual_scan from commandbutton within w_scan_objects_rma
int X=1381
int Y=1080
int Width=329
int Height=92
int TabOrder=50
string Text="Manual Scan"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = 'Manual Scan' then
	this.text = 'Close Scan' 
	
	OpenUserObjectWithParm ( iuo_scan, parent, gb_1.x, gb_1.y )
	if isvalid ( iuo_scan ) then
		iuo_scan.Bringtotop = true
		iuo_scan.BorderStyle	= StyleRaised!		
		iuo_scan.width			= gb_1.width
		iuo_scan.height		= gb_1.height
	end if
	
else
	
	this.text = 'Manual Scan'
	CloseuserObject ( iuo_scan ) 
	
end if
end event

type cb_cancel from commandbutton within w_scan_objects_rma
int X=1106
int Y=1080
int Width=247
int Height=92
int TabOrder=40
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( parent )
end event

type cb_ok from commandbutton within w_scan_objects_rma
int X=841
int Y=1080
int Width=247
int Height=92
int TabOrder=60
boolean Enabled=false
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_count

if isnull ( dw_location.object.#1 [1] ) or dw_location.object.#1 [1] = '' then
	messagebox ( monsys.msg_title, 'Select a Location Code!', Information! )
	dw_location.setfocus ()
	return
end if

if isnull ( dw_location.object.#2 [1] ) or dw_location.object.#2 [1] = '' then
	messagebox ( monsys.msg_title, 'Enter a Valid Operator Password!', Information! )
	dw_location.setfocus ()
	return
end if

if dw_rma_objects.accepttext() <= 0 then return 

parent.triggerevent ( "ue_save" )

cb_manual_scan.Enabled = TRUE

end event

type dw_location from datawindow within w_scan_objects_rma
int X=462
int Y=936
int Width=1705
int Height=124
int TabOrder=70
string DataObject="d_location_operator_rma"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;if dwo.name = 'password' then
	if f_get_password ( data ) > '' then
		cb_ok.enabled = true
	else
		cb_ok.enabled = false
		setitem ( 1, 'password', '' )
		setitem ( 1, 'operator', '' )
		messagebox ( 'DataWindow Error', 'Invalid Operator Password!', Exclamation! )
		return 1
	end if
end if
end event

event itemerror;return 1
end event

type dw_objects from datawindow within w_scan_objects_rma
int X=32
int Y=60
int Width=850
int Height=852
int TabOrder=10
string DragIcon="Application!"
string Tag="objects"
string DataObject="d_expected_objects"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

event clicked;if row > 0 then
	if isselected ( row ) then
		selectrow ( row, false )
	else
		selectrow ( row, true )
	end if
	drag(begin!)
end if
end event

event dragdrop;long	ll_count

// check if a object is valid 
if IsValid ( source ) then
	
	// make sure user is dragged object is appropriate one
	if source.Tag = "StagedObjects" then
			
		for ll_count =  1 to dw_rma_objects.rowcount() 
			if dw_rma_objects.isselected ( ll_count ) then
				dw_rma_objects.deleterow ( ll_count )	
			end if
		next
		
	end if
	
end if


end event

type gb_2 from groupbox within w_scan_objects_rma
int X=905
int Y=8
int Width=1774
int Height=924
int TabOrder=20
string Text="Scanned Objects: "
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_scan_objects_rma
int X=18
int Y=8
int Width=878
int Height=924
int TabOrder=20
string Text="Objects Shipped Out:"
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

