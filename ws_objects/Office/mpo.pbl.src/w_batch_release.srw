$PBExportHeader$w_batch_release.srw
forward
global type w_batch_release from Window
end type
type cb_exit from commandbutton within w_batch_release
end type
type cb_1 from commandbutton within w_batch_release
end type
type dw_batch from datawindow within w_batch_release
end type
end forward

global type w_batch_release from Window
int X=814
int Y=540
int Width=1125
int Height=940
boolean TitleBar=true
string Title="Batch PO Release Entry"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_exit cb_exit
cb_1 cb_1
dw_batch dw_batch
end type
global w_batch_release w_batch_release

type variables
window   i_w_host

Boolean   i_b_changed = false

string      i_s_vendor

long        i_l_po
end variables

forward prototypes
public function decimal wf_get_price (integer a_n_qty, string a_s_part)
end prototypes

public function decimal wf_get_price (integer a_n_qty, string a_s_part);Integer l_i_totalrows
Integer l_i_Row

Decimal l_n_Price

Boolean l_b_Found

string  l_s_cunit, &
		  l_s_unit

l_b_Found		= FALSE

DATASTORE  l_dw_price_matrix

l_dw_price_matrix = CREATE DATASTORE

l_dw_price_matrix.dataobject = 'dw_smart_vendor_part_price_matrix'
l_dw_price_matrix.SetTransobject ( SQLCA )
l_dw_price_matrix.Retrieve ( i_s_vendor, a_s_part )

l_i_totalrows	= l_dw_price_matrix.RowCount()
l_i_Row			= l_i_totalrows

Do while (Not l_b_Found) AND (l_i_Row > 0)

	l_b_Found = (a_n_Qty >= l_dw_price_matrix.GetItemNumber(l_i_Row, "break_qty"))

	If Not l_b_Found then
		l_i_Row --
	End If

Loop

SELECT	currency_unit
INTO		:l_s_cunit
FROM		po_header
WHERE		po_number = :i_l_po ;

If l_i_Row = 0 then
	l_b_Found	= FALSE
End If

l_s_unit  = f_get_part_info(a_s_part, "STANDARD UNIT")

If l_b_Found then
	sqlca.of_calculate_multicurrency_price ( l_dw_price_matrix.GetItemString ( l_i_row, 5 ), l_s_cunit, &
		Truncate(l_dw_price_matrix.GetItemNumber(l_i_Row, 6) + 0.0000009, 6), l_n_Price )
Else
	sqlca.of_calculate_multicurrency_price ( '', l_s_cunit, &
		Truncate(Dec(f_get_part_info(a_s_part, "STANDARD COST")) + 0.0000009, 6), l_n_price )
	If a_n_Qty > 0 then
		l_n_Price	= f_convert_units(l_s_unit, "", a_s_part, a_n_Qty) * l_n_Price / a_n_Qty
	Else
		l_n_Price	= f_convert_units(l_s_unit, "", a_s_part, 1)
	End If
End If

DESTROY l_dw_price_matrix

Return l_n_Price

end function

on w_batch_release.create
this.cb_exit=create cb_exit
this.cb_1=create cb_1
this.dw_batch=create dw_batch
this.Control[]={this.cb_exit,&
this.cb_1,&
this.dw_batch}
end on

on w_batch_release.destroy
destroy(this.cb_exit)
destroy(this.cb_1)
destroy(this.dw_batch)
end on

event open;string l_s_part

i_w_host = message.powerobjectparm

dw_batch.insertrow ( 1 )
dw_batch.setitem ( 1, "date", today() )

CHOOSE CASE i_w_host
	CASE w_blanket_po_entry 
		l_s_part 	= w_blanket_po_entry.is_part  
		i_s_vendor 	= w_blanket_po_entry.is_vendor 
		i_l_po		= w_blanket_po_entry.il_po
		dw_batch.setitem ( 1, 1,  l_s_part)
		dw_batch.setitem ( 1, 2,  f_get_part_info(l_s_part, "NAME") )
		dw_batch.settaborder ( 1, 0 )
		dw_batch.settaborder ( 2, 0 )
	CASE w_normal_po_entry 
		i_s_vendor 	= w_normal_po_entry.is_Vendor
		i_l_po		= w_normal_po_entry.ipo
END CHOOSE


end event

event closequery;if i_b_changed  then
	
	// check for valid data	
	dw_batch.accepttext()
	
	if dw_batch.object.quantity[1] <= 0  or isnull ( dw_batch.object.quantity[1] )then
		Messagebox ( monsys.msg_title, "Quantity cannot be null!", Exclamation! )
		return 1
	end if
	
	if isnull( dw_batch.object.#1[1] ) or dw_batch.object.#1[1] = '' then
		Messagebox ( monsys.msg_title, "Part Number cannot be null!", Exclamation! )
		return 1
	end if
	
	if isnull( dw_batch.object.#3[1] ) then
		Messagebox ( monsys.msg_title, "Enter a valid due date!", Exclamation! )
		return 1
	end if
	
	i_w_host.trigger dynamic event ue_save_batch ( dw_batch )
	close ( this )
else
	return 0
	close ( this )	
end if
end event

type cb_exit from commandbutton within w_batch_release
int X=585
int Y=736
int Width=247
int Height=92
int TabOrder=30
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;i_b_changed = false
close ( parent )
end event

type cb_1 from commandbutton within w_batch_release
int X=306
int Y=736
int Width=247
int Height=92
int TabOrder=20
string Text="Save"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent )

							
end event

type dw_batch from datawindow within w_batch_release
int Y=12
int Width=1111
int Height=700
int TabOrder=10
string DataObject="d_batch_create_releases"
boolean Border=false
boolean LiveScroll=true
end type

event editchanged;i_b_changed = true
end event

event itemchanged;i_b_changed = true

String  l_s_part, &
		  l_s_vendor

Decimal l_n_Qty

datawindowchild l_dwc

if dwo.name = 'part' then
	
	this.Getchild ( 'part', l_dwc )
	this.setitem ( row, 'description', l_dwc.getitemstring ( l_dwc.getrow(), 2 ) )

	if row > 0 and data > '' then 
		this.Getchild ( 'unit', l_dwc )
		l_dwc.settransobject(sqlca)
		l_dwc.retrieve(data)
	end if 

elseif dwo.name = 'quantity' then
	
	l_s_part = this.object.part[1]
	setitem ( 1, 'price', wf_get_price ( dec ( data ), l_s_part ) )
	
	SELECT part_vendor.min_on_order  
	  INTO :l_n_Qty  
	  FROM part_vendor  
	 WHERE ( part_vendor.part = :l_s_part ) AND  
   	    ( part_vendor.vendor = :i_s_vendor )   ;

	if l_n_qty > 0 then
		if dec(data) < l_n_qty then
			MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity :" + string ( truncate ( l_n_qty, 0 ) ) + " .", StopSign!	)			
			return 2 
		end if
	end if
	

end if
end event

event constructor;datawindowchild l_dwc_part

this.getchild ( 'part', l_dwc_part )
l_dwc_part.settransobject ( sqlca )
l_dwc_part.retrieve ()

this.getchild ( 'unit', l_dwc_part )
l_dwc_part.settransobject ( sqlca )
l_dwc_part.retrieve ('')

end event

