$PBExportHeader$w_rma_shipper_detail_entry.srw
forward
global type w_rma_shipper_detail_entry from Window
end type
type cb_cancel from commandbutton within w_rma_shipper_detail_entry
end type
type cb_ok from commandbutton within w_rma_shipper_detail_entry
end type
type dw_operator from datawindow within w_rma_shipper_detail_entry
end type
type dw_shipper_detail from datawindow within w_rma_shipper_detail_entry
end type
end forward

global type w_rma_shipper_detail_entry from Window
int X=123
int Y=236
int Width=2629
int Height=1396
boolean TitleBar=true
string Title="RMA Shipper Detail Entry"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
dw_operator dw_operator
dw_shipper_detail dw_shipper_detail
end type
global w_rma_shipper_detail_entry w_rma_shipper_detail_entry

type variables
datastore  idw_shiphistory

boolean   ib_saved = false

long         il_shipper
end variables

on w_rma_shipper_detail_entry.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_operator=create dw_operator
this.dw_shipper_detail=create dw_shipper_detail
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_operator,&
this.dw_shipper_detail}
end on

on w_rma_shipper_detail_entry.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_operator)
destroy(this.dw_shipper_detail)
end on

event open;idw_shiphistory = message.powerobjectparm

if idw_shiphistory.rowcount () > 0 then
	
	idw_shiphistory.rowscopy ( 1, 99999, Primary!, dw_shipper_detail, 1, primary! )
	
	if dw_shipper_detail.rowcount() > 0 then
	
		il_shipper = dw_shipper_detail.object.#1 [1]
			
	else

		closewithreturn ( this, 1 )
	
	end if
	
else
	
	closewithreturn ( this, 1 )
	
end if
end event

type cb_cancel from commandbutton within w_rma_shipper_detail_entry
int X=1390
int Y=1168
int Width=325
int Height=96
int TabOrder=40
string Text="&Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if not ib_saved then
	closewithreturn  ( parent, 1 ) 
else
	closewithreturn  ( parent, 0 ) 
end if
end event

type cb_ok from commandbutton within w_rma_shipper_detail_entry
int X=1024
int Y=1168
int Width=325
int Height=96
int TabOrder=30
boolean Enabled=false
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long		ll_rowcount, &
			ll_count, &
			ll_firstrow, &
			ll_lastrow, & 
			ll_sequence, &
			ll_shipperrow
			
string 	ls_part, &
			ls_operator

datetime  ldt_dateshipped

datastore lds_shipperdetail

////////////////////////////////////////////////////////////////////////////////////////
//	This event assigns proper suffixes if there are more than one rows for the part on 
//	shipper detail table for a particular RMA shipper. It also inserts the shipper detail
//	rows to the RMA shipper.
//	MB: 07/16/1999 
////////////////////////////////////////////////////////////////////////////////////////

// create datastore for shipper detail
lds_shipperdetail = create datastore
lds_shipperdetail.dataobject = 'd_shipping_dock_shipper_detail'
lds_shipperdetail.settransobject ( sqlca )

setnull ( ldt_dateshipped )

// get the number of rows in shipper detail datawindow
ll_rowcount  = dw_shipper_detail.rowcount()

if ll_rowcount > 0 then 
	
	// get operator code
	ls_operator = dw_operator.object.operator_code [1]
	
	// retreive the existing shipper detail rows for that rma from the database
	lds_shipperdetail.retrieve ( il_shipper )

	// sort by part original and suffix order
	lds_shipperdetail.setsort ( "#25 A, #18 D" ) 
	lds_shipperdetail.sort ()

	// loop through all the rows to assign suffixes if need be
	for ll_count = 1 to ll_rowcount 
	
			// initialize sequence number and part original variables from the current datawindow
			ll_sequence = 1 
			ls_part		= dw_shipper_detail.object.part_original [ll_count]
			
			// find the first row and last row for that part original group  on the datawindow
			ll_firstrow =  dw_shipper_detail.Find ( "part_original='"+ls_part+"'", 1, ll_rowcount )
			ll_lastrow	=  dw_shipper_detail.Findgroupchange ( ll_firstrow + 1, 1 ) - 1 
			IF ll_lastrow = -1 THEN ll_lastrow = ll_rowcount 
			IF ll_firstrow = 0 THEN ll_lastrow = -1

			// find the first row and last row for that part original group  on the datastore ( original shipperdetail)			
			ll_shipperrow = lds_shipperdetail.Find ( "part_original='"+ls_part+"'", 1, lds_shipperdetail.RowCount ( ) ) 

			// increment sequence if the shipper detail exists for that part to update suffix column
			If ll_shipperrow > 0 THEN
				ll_sequence = isnull ( lds_shipperdetail.object.shipper_detail_suffix [ll_shipperrow], 0 ) + 1 
			END IF

			// loop through the group of part to assign operator, boxes_staged, date shipped
			for ll_count = ll_firstrow to ll_lastrow 

				dw_shipper_detail.setitem ( ll_count, "operator", ls_operator )
				dw_shipper_detail.setitem ( ll_count, "boxes_staged", 0 )
				dw_shipper_detail.setitem ( ll_count, "date_shipped", ldt_dateshipped )	
				
				// assign sequence to suffix column if there are more than one rows for that part original
				if ll_firstrow <> ll_lastrow  then		
					dw_shipper_detail.setitem ( ll_count, "suffix", ll_sequence ) 
					dw_shipper_detail.setitem ( ll_count, "part", dw_shipper_detail.object.part_original [ll_count]  + '-' + string( ll_sequence ) ) 

				// assign the sequence to suffix if there is only one row
				elseif ( ll_firstrow = ll_lastrow and ll_firstrow = 1 and ll_sequence > 0 ) then
					dw_shipper_detail.setitem ( 1, "suffix", ll_sequence ) 
					dw_shipper_detail.setitem ( 1, "part", dw_shipper_detail.object.part_original [ll_count]  + '-' + string( ll_sequence ) ) 
				end if
				
				ll_sequence++
			
			next
		
	next

	// destroy the original shipper	
	destroy lds_shipperdetail ;

	// update the shipper detail
	if dw_shipper_detail.update() > 0 then
		
		commit ;
		closewithreturn ( parent, 0 )

	end if
	
else

	closewithreturn ( parent, 1 )
	
end if






		

end event

type dw_operator from datawindow within w_rma_shipper_detail_entry
int X=891
int Y=1004
int Width=846
int Height=136
int TabOrder=20
string DataObject="d_std_password"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;if f_get_password ( data ) > '' then
	cb_ok.enabled = true
else
	cb_ok.enabled = false
	setitem ( 1, 'operator', '' )
	setitem ( 1, 'operator_code', '' )
	messagebox ( 'DataWindow Error', 'Invalid Operator Password!', Exclamation! )
	return 1
end if
end event

event constructor;insertrow ( 1 )
end event

event itemerror;return 1
end event

type dw_shipper_detail from datawindow within w_rma_shipper_detail_entry
int X=14
int Y=8
int Width=2587
int Height=972
int TabOrder=10
string DataObject="d_rma_shipper_detail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

