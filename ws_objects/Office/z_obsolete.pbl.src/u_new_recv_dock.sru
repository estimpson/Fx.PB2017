$PBExportHeader$u_new_recv_dock.sru
forward
global type u_new_recv_dock from UserObject
end type
type cb_ok from commandbutton within u_new_recv_dock
end type
type cb_print from commandbutton within u_new_recv_dock
end type
type st_1 from statictext within u_new_recv_dock
end type
type p_1 from picture within u_new_recv_dock
end type
type st_2 from statictext within u_new_recv_dock
end type
type dw_main from datawindow within u_new_recv_dock
end type
type dw_releases from datawindow within u_new_recv_dock
end type
type dw_errors from datawindow within u_new_recv_dock
end type
end forward

global type u_new_recv_dock from UserObject
int Width=2341
int Height=952
long BackColor=77897888
long PictureMaskColor=553648127
long TabTextColor=33554432
long TabBackColor=79741120
event ue_receive ( )
cb_ok cb_ok
cb_print cb_print
st_1 st_1
p_1 p_1
st_2 st_2
dw_main dw_main
dw_releases dw_releases
dw_errors dw_errors
end type
global u_new_recv_dock u_new_recv_dock

type variables
BOOLEAN             i_b_line_item, &
                              i_b_error, &
                              i_b_warning

LONG                   i_l_row

STRING		i_s_requsition, &
		i_s_recv_um, &
		i_s_PartClass

datawindowchild	idwc_unit, &
		idwc_package, &
		idwc_location
end variables

forward prototypes
public subroutine uf_populate (string a_s_part)
public subroutine uf_units_for_part (string a_s_originalunit, string a_s_part)
public subroutine uf_check_over_receive (long a_l_row, string a_s_part, decimal a_n_qty)
end prototypes

event ue_receive;// Error check routine for unit of measure, location, rowid etc
/* 02-16-2000 KAZ Modified to recalculate the quantity received if the Unit of Measurement 
						is changed, and use the converted quantity to check if over-received    */
/* 04-12-2000 KAZ Modified to allow receipt of non-reoccurring items without a location
						code.  Issue # 13307.  */

LONG 		l_l_count, &
			l_l_Quantity

STRING 	l_s_message, &
			l_s_Part_Number, &
			l_s_UM

if dw_errors.visible = true then 
	dw_errors.visible = false
	cb_print.visible = false
	cb_ok.visible 	= false
	return
else
	if dw_errors.visible then dw_errors.visible = false
	if cb_print.visible then cb_print.visible = false
	i_b_error = false
	i_b_warning = false
	dw_errors.reset()
	dw_main.Accepttext ()

	for l_l_count = 1 to dw_main.Rowcount ()

		// check if the unit of measure is missing for the parts..
		if isnull ( dw_main.Object.unit[l_l_count], '' ) = '' then 
			dw_errors.insertrow ( 0 )
			dw_errors.setitem ( dw_errors.rowcount(), 1, l_l_count )
			dw_errors.setitem ( dw_errors.rowcount(), 2, 'Error' )
			dw_errors.setitem ( dw_errors.rowcount(), 3, "Unit of measure missing for row: " + STRING (l_l_count) )
			i_b_error = true
		end if

		// check if Part Class is not null - a reoccurring item											-	ADD 04-12-2000 KAZ
		if not isnull ( i_s_partclass ) Then 																	// ADD 04-12-2000 KAZ
			// check if location is null
			if isnull ( dw_main.Object.location[l_l_count], '' ) = '' then 
				dw_errors.insertrow ( 0 )
				dw_errors.setitem ( dw_errors.rowcount(), 1, l_l_count )
				dw_errors.setitem ( dw_errors.rowcount(), 2, 'Error' )
				dw_errors.setitem ( dw_errors.rowcount(), 3, "Location Code missing for row: " + STRING (l_l_count) )
				i_b_error = true
			end if
		end if																											// ADD 04-12-2000 KAZ

		// check if it is line item and if a release no has been selected
		if i_b_line_item then
			if ISNULL( dw_main.Object.row_id[l_l_count] ) then 
				dw_errors.insertrow ( 0 )
				dw_errors.setitem ( dw_errors.rowcount(), 1, l_l_count )
				dw_errors.setitem ( dw_errors.rowcount(), 2, 'Error' )
				dw_errors.setitem ( dw_errors.rowcount(), 3, "Choose a release in order to receive against row  " + string ( l_l_count ) )
				i_b_error = true
			end if
		end if
	
		if dw_main.Object.quantity[l_l_count] <= 0 then
				dw_errors.insertrow ( 0 )
				dw_errors.setitem ( dw_errors.rowcount(), 1, l_l_count )
				dw_errors.setitem ( dw_errors.rowcount(), 2, 'Error' )
				dw_errors.setitem ( dw_errors.rowcount(), 3, "Quantity must be greater than zero in row: " + string ( l_l_count ) )
				i_b_error = true
		end if

		// First recalculate quantity if unit of measurement is different than PO					-  ADD 02-16-2000 KAZ
		
		l_s_Part_Number = dw_main.Object.part_number[l_l_count]											// ADD 02-16-2000 KAZ
		
		SELECT unit_of_measure																						// ADD 02-16-2000 KAZ
		INTO :l_s_UM 																									// ADD 02-16-2000 KAZ
		FROM po_detail																									// ADD 02-16-2000 KAZ
		WHERE ( po_number = :w_visual_receiving_dock_version2.iPO ) AND								// ADD 02-16-2000 KAZ
				( part_number = :l_s_Part_Number ) AND															// ADD 02-16-2000 KAZ
				( row_id = :i_l_row );																				// ADD 02-16-2000 KAZ

		IF l_s_UM <> dw_main.Object.unit[l_l_count] THEN													// ADD 02-16-2000 KAZ
			l_l_Quantity = f_convert_units (dw_main.Object.unit[l_l_count], l_s_UM, dw_main.Object.part_number[l_l_count], dw_main.Object.quantity[l_l_count] )	// ADD 02-16-2000 KAZ
		ELSE																												// ADD 02-16-2000 KAZ
			l_l_Quantity = dw_main.Object.quantity[l_l_count]												// ADD 02-16-2000 KAZ
		END IF																											// ADD 02-16-2000 KAZ

		// check if the user is trying to over receive the quantities against po's

		uf_check_over_receive ( l_l_count, dw_main.Object.part_number[l_l_count], l_l_Quantity )	// ADD 02-16-2000 KAZ

//		uf_check_over_receive ( l_l_count, dw_main.Object.part_number[l_l_count], dw_main.Object.quantity[l_l_count] )	-  CHG 02-16-2000 KAZ

	next

	if i_b_error then	
		messagebox ( monsys.msg_title, "There are errors in the input values!" )
		dw_errors.visible = true
		dw_errors.bringtotop = true
		cb_print.visible = true
		cb_ok.visible 	= true
	elseif i_b_warning then
		if messagebox ( monsys.msg_title, "Would you like to view the warnings?", Information!, YesNo!, 2 ) = 1 then
			dw_errors.visible = true
			dw_errors.bringtotop = true
			cb_print.visible = true
			cb_ok.visible 	= true
		else
			i_b_error = false
			i_b_warning = false
			w_visual_receiving_dock_version2.Event ue_receive ( )			
		end if
	else
		i_b_error = false
		i_b_warning = false
		w_visual_receiving_dock_version2.Trigger Event ue_receive ( )

	end if
end if

end event

public subroutine uf_populate (string a_s_part);STRING	l_s_name

SELECT description,
       receiving_um
INTO	 :l_s_name,
		 :i_s_recv_um
FROM   po_detail, part_vendor
WHERE  po_number = :w_visual_receiving_dock_version2.iPO  AND 
       part_vendor.part = po_detail.part_number AND
       part_vendor.vendor = po_detail.vendor_code AND
       part_number = :a_s_part ; 

dw_main.object.#2 [1] = l_s_name

// populate the dddw with units of measure for that part

uf_units_for_part ( "", a_s_part )
end subroutine

public subroutine uf_units_for_part (string a_s_originalunit, string a_s_part);STRING	l_s_unit, &
			l_s_temp

IF a_s_originalunit = "" THEN

	SELECT part_inventory.standard_unit  
     INTO :a_s_originalunit  
     FROM part_inventory  
    WHERE part_inventory.part = :a_s_part   ;

END IF

l_s_temp	 = a_s_originalunit + '~t' + a_s_originalunit + '/'

 DECLARE unit_list CURSOR FOR  
  SELECT unit_conversion.unit2  
    FROM part_unit_conversion,   
         unit_conversion  
   WHERE ( part_unit_conversion.code = unit_conversion.code ) and  
         ( ( part_unit_conversion.part = :a_s_part ) AND  
         ( unit_conversion.unit1 = :a_s_originalunit ) )   
ORDER BY unit_conversion.unit2 ASC  ;

OPEN	unit_list ;

DO

	FETCH unit_list INTO :l_s_unit ;

	IF SQLCA.SQLCode = 0 THEN
			l_s_temp = l_s_temp + l_s_unit + '~t' + l_s_unit + '/' 
	END IF

LOOP WHILE SQLCA.SQLCode = 0

CLOSE unit_list ;

IF l_s_unit  = "" OR ISNULL ( l_s_unit ) THEN
	IF a_s_originalunit = "" OR ISNULL ( a_s_originalunit ) THEN a_s_originalunit = 'EA'
	l_s_unit	 = a_s_originalunit
	l_s_temp	 = a_s_originalunit + '~t' + a_s_originalunit + '/'
END IF

l_s_temp	 = l_s_temp + '~t' + i_s_recv_um + '/'

l_s_temp = "unit.values='"+l_s_temp+"'"

dw_main.MODIFY ( l_s_temp )

IF ISNULL ( i_s_recv_um ) OR i_s_recv_um = '' THEN  i_s_recv_um = 'EA' 

dw_main.object.#3[1] = i_s_recv_um // changed this to display receiving unit of measure 


end subroutine

public subroutine uf_check_over_receive (long a_l_row, string a_s_part, decimal a_n_qty);DECIMAL	l_n_qty

STRING	l_s_message

SELECT sum(balance)
INTO	 :l_n_qty
FROM  po_detail
WHERE po_number = :w_visual_receiving_dock_version2.iPO AND
	   part_number = :a_s_part ;
		
ISNULL ( l_n_qty , 0 )

IF a_n_qty > 0 AND l_n_qty < a_n_qty THEN
	dw_errors.insertrow ( 0 )
	dw_errors.setitem ( dw_errors.rowcount(), 1, a_l_row )
	IF i_b_line_item THEN
		l_s_message = "You are trying to over receive against part number : " + a_s_part +  " , row: " + string ( a_l_row) + " . ~n" + &
						  "You are trying to receive " + string ( a_n_qty ) + " against release quantity " + string ( l_n_qty ) + ". ~n" + &
						  "The system will receive " + string ( truncate ( (a_n_qty - l_n_qty), 0 ) ) + " excess quantity against the PO! " 
	ELSE
		l_s_message = "You are trying to over receive against part number : " + a_s_part +  " , row: " + string ( a_l_row ) + ". ~n" + &
						  "You are trying to receive " + string ( a_n_qty ) + " against release quantity " + string ( l_n_qty ) + " .~n" + &
						  "The system will store " + string ( truncate ( (a_n_qty - l_n_qty), 0 ) ) + " excess quantity as over received. ~n" + &
						  "This quantity will be used when a new release is inserted against the same part number and same vendor!" 
	END IF
	dw_errors.setitem ( dw_errors.rowcount(), 2, 'Warning' )	
	dw_errors.setitem ( dw_errors.rowcount(), 3, l_s_message )	
	i_b_warning = True
END IF
end subroutine

on u_new_recv_dock.create
this.cb_ok=create cb_ok
this.cb_print=create cb_print
this.st_1=create st_1
this.p_1=create p_1
this.st_2=create st_2
this.dw_main=create dw_main
this.dw_releases=create dw_releases
this.dw_errors=create dw_errors
this.Control[]={this.cb_ok,&
this.cb_print,&
this.st_1,&
this.p_1,&
this.st_2,&
this.dw_main,&
this.dw_releases,&
this.dw_errors}
end on

on u_new_recv_dock.destroy
destroy(this.cb_ok)
destroy(this.cb_print)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.dw_main)
destroy(this.dw_releases)
destroy(this.dw_errors)
end on

event constructor;// check release control type
i_b_line_item	= w_visual_receiving_dock_version2.cbx_line_item.checked
end event

type cb_ok from commandbutton within u_new_recv_dock
int X=1559
int Y=816
int Width=261
int Height=84
int TabOrder=30
boolean Visible=false
string Text="Ok"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;this.visible = false
cb_print.visible = false
dw_errors.visible = false

end event

type cb_print from commandbutton within u_new_recv_dock
int X=1266
int Y=812
int Width=261
int Height=84
int TabOrder=30
boolean Visible=false
string Text="Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_errors.print() 
this.visible = false
cb_ok.visible = false
dw_errors.visible = false

end event

type st_1 from statictext within u_new_recv_dock
int X=18
int Y=444
int Width=549
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Line Item Releases :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within u_new_recv_dock
int X=1787
int Y=448
int Width=69
int Height=52
boolean Visible=false
boolean BringToTop=true
string PictureName="pstart.bmp"
boolean FocusRectangle=false
end type

type st_2 from statictext within u_new_recv_dock
int X=1897
int Y=444
int Width=325
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Release Flag"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_main from datawindow within u_new_recv_dock
int X=5
int Y=4
int Width=2322
int Height=544
int TabOrder=10
string DataObject="d_receiving_dock_popup"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;// Resize the datawindow if the other one is visible...
if NOT i_b_line_item then
	dw_main.height	=	790
else
	dw_main.height	=	544
	p_1.visible= true
	st_1.visible= true
	st_2.visible= true
	dw_main.bringtotop = true
	dw_releases.bringtotop = true
end if

// Initialize the child datawindows and Populate the location
Getchild( 'unit', idwc_unit )
Getchild( 'package_type', idwc_package )
Getchild ( 'location', idwc_location )

idwc_unit.Settransobject ( sqlca )
idwc_package.Settransobject ( sqlca )	
idwc_location.Settransobject ( sqlca )

// Insert a default row to prevent the parameter popup for part
idwc_unit.Insertrow ( 0 )
idwc_package.Insertrow ( 0 )
if idwc_location.retrieve ( ) <= 0 then &
	idwc_location.Insertrow ( 0 )

Settransobject ( sqlca )

// Retrieve the datawindow for the select po and parts
Retrieve ( w_visual_receiving_dock_version2.iPO, w_visual_receiving_dock_version2.dw_range_weights.object.part.primary)

// Reset the quantities to the user defined ones.
object.quantity.primary = w_visual_receiving_dock_version2.dw_range_weights.object.part_qty.primary


end event

event clicked;/* 04-12-2000 KAZ Modified to determine the part class of the selected part to allow receipt 
						of non-reoccurring items without a location code.  Issue # 13307.  */

// Retreive the PO releases for the po and the part number 
IF row > 0 THEN
	i_l_row	=	row
	dw_releases.Retrieve( w_visual_receiving_dock_version2.iPO, object.part_number[row] )
	// Populate PartClass with part info															-  ADD 04-12-2000 KAZ
	i_s_partclass = f_get_part_info ( object.part_number[row], "CLASS" )					// ADD 04-12-2000 KAZ
END IF	
end event

event rowfocuschanged;/* 04-12-2000 KAZ Modified to determine the part class of the selected part to allow receipt 
						of non-reoccurring items without a location code.  Issue # 13307.  */

// retrieve the child datawindows
if currentrow > 0 then
	idwc_unit.retrieve ( object.part_number [currentrow] )
	idwc_package.retrieve ( object.part_number [currentrow] )
	// Populate PartClass with part info															-  ADD 04-12-2000 KAZ
	i_s_PartClass = f_get_part_info ( object.part_number[currentrow], "CLASS" )		// ADD 04-12-2000 KAZ
end if


end event

type dw_releases from datawindow within u_new_recv_dock
int X=5
int Y=552
int Width=2322
int Height=372
string DataObject="dw_line_item_release_display"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;Settransobject ( SQLCA )

if i_b_line_item then
	dw_releases.object.price.visible = false
	this.visible = true
else
	this.visible = false
end if


end event

event clicked;LONG  l_l_po, &
		l_l_rowid, &
		l_l_req
		
STRING l_s_operator, &
		 l_s_req

IF row > 0  THEN
	
	selectrow(0,false)	
	selectrow(row,true)
	
	l_l_rowid = THIS.object.row_id [ row ]
	l_l_po	 = THIS.object.po_number [ row ]
	
	dw_main.Object.row_id [ i_l_row ] = l_l_rowid

//	MessageBox(monsys.msg_title, "Row ID: "+string(dw_main.Object.row_id [ i_l_row ]), Information!)  - ZZ
	
	l_s_req = f_get_parameter_value ()
	
	IF l_s_req = 'Y' THEN
	
		l_l_req	 = THIS.object.requisition_id [ row ] 
	
		IF l_l_Req > 0 THEN

			SELECT employee.name
			INTO   :l_s_operator
			FROM	 requisition_Detail
 		   JOIN employee  ON  requisition_Detail.deliver_to_operator = employee.operator_code 
			WHERE  po_number = :l_l_po
			AND	 po_rowid  = :l_l_rowid 
			AND    requisition_number = :l_l_req ;
		
			IF l_s_operator > '' THEN &
				dw_main.object.deliver_to_operator [ i_l_row ] = l_s_operator 

			ROLLBACK;
			
		END IF
	END IF
	
END IF
end event

type dw_errors from datawindow within u_new_recv_dock
int X=9
int Y=8
int Width=2309
int Height=776
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="d_errors_new_recv_dock"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

