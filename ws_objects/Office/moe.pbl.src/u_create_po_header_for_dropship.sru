$PBExportHeader$u_create_po_header_for_dropship.sru
forward
global type u_create_po_header_for_dropship from UserObject
end type
type st_um2 from statictext within u_create_po_header_for_dropship
end type
type st_um1 from statictext within u_create_po_header_for_dropship
end type
type dw_price_matrix from datawindow within u_create_po_header_for_dropship
end type
type sle_qty from singlelineedit within u_create_po_header_for_dropship
end type
type st_3 from statictext within u_create_po_header_for_dropship
end type
type st_2 from statictext within u_create_po_header_for_dropship
end type
type sle_price from singlelineedit within u_create_po_header_for_dropship
end type
type cb_2 from commandbutton within u_create_po_header_for_dropship
end type
type cb_1 from commandbutton within u_create_po_header_for_dropship
end type
type st_1 from statictext within u_create_po_header_for_dropship
end type
type dw_vendors from datawindow within u_create_po_header_for_dropship
end type
end forward

global type u_create_po_header_for_dropship from UserObject
int Width=1193
int Height=1228
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
st_um2 st_um2
st_um1 st_um1
dw_price_matrix dw_price_matrix
sle_qty sle_qty
st_3 st_3
st_2 st_2
sle_price sle_price
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_vendors dw_vendors
end type
global u_create_po_header_for_dropship u_create_po_header_for_dropship

type variables
Window wHostWindow

String szVendor
String szTerms
String szPart
String szVendorPartUM

Decimal nRatio
end variables

forward prototypes
public subroutine uf_setup (ref window wwin, string szcurrentpart, decimal nqty, string szum)
public function string uf_um_for_vendor_part (string szvendor, string szpart)
public function decimal uf_get_price (string as_vendor, string as_part, decimal an_qty)
end prototypes

public subroutine uf_setup (ref window wwin, string szcurrentpart, decimal nqty, string szum);dw_vendors.SetTransObject(sqlca)
dw_price_matrix.SetTransObject(sqlca)

szPart	= szCurrentPart
dw_vendors.Retrieve(szPart)

wHostWindow		= wWin

sle_qty.text	= String(Truncate(nQty, 2))
sle_price.text	= ''

SetNull(szVendor)
st_um1.text		= szUM
st_um2.text		= szUM

If dw_vendors.RowCount() = 0 then
	wHostWindow.TriggerEvent("close_uo")
	MessageBox( monsys.msg_title, "You must setup vendor/part profile first.", StopSign!)
End If
end subroutine

public function string uf_um_for_vendor_part (string szvendor, string szpart);String szUM

  SELECT part_vendor.receiving_um  
    INTO :szUM  
    FROM part_vendor  
   WHERE ( part_vendor.part = :szPart ) AND  
         ( part_vendor.vendor = :szVendor )   ;

Return szUM
end function

public function decimal uf_get_price (string as_vendor, string as_part, decimal an_qty);Integer iTotalRows
Integer iRow

Boolean bFound
 
bFound		= FALSE
iTotalRows	= dw_price_matrix.RowCount()
iRow			= iTotalRows

Do while (Not bFound) AND (iRow > 0)

	bFound = (an_Qty >= dw_price_matrix.GetItemNumber(iRow, 1))

	If Not bFound then
		iRow --
	End If

Loop


If iRow = 0 then
	bFound	= FALSE
End If

If bFound then
	Return Truncate(f_get_value(dw_price_matrix.GetItemNumber(iRow, 2)), 4)
Else
	Return Truncate(f_get_value(Dec(f_get_part_info(as_Part, "PRICE"))), 4)
End If


end function

on u_create_po_header_for_dropship.create
this.st_um2=create st_um2
this.st_um1=create st_um1
this.dw_price_matrix=create dw_price_matrix
this.sle_qty=create sle_qty
this.st_3=create st_3
this.st_2=create st_2
this.sle_price=create sle_price
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_vendors=create dw_vendors
this.Control[]={this.st_um2,&
this.st_um1,&
this.dw_price_matrix,&
this.sle_qty,&
this.st_3,&
this.st_2,&
this.sle_price,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dw_vendors}
end on

on u_create_po_header_for_dropship.destroy
destroy(this.st_um2)
destroy(this.st_um1)
destroy(this.dw_price_matrix)
destroy(this.sle_qty)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_price)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_vendors)
end on

type st_um2 from statictext within u_create_po_header_for_dropship
int X=969
int Y=880
int Width=128
int Height=64
boolean Enabled=false
string Text="(EA)"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_um1 from statictext within u_create_po_header_for_dropship
int X=402
int Y=880
int Width=128
int Height=64
boolean Enabled=false
string Text="(EA)"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_price_matrix from datawindow within u_create_po_header_for_dropship
int X=64
int Y=1152
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="dw_smart_vendor_part_price_matrix"
boolean LiveScroll=true
end type

type sle_qty from singlelineedit within u_create_po_header_for_dropship
int X=91
int Y=960
int Width=421
int Height=80
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If Not IsNull(szVendor) then
	sle_price.text	= String(nRatio * uf_get_price(szVendor, szPart, Dec(sle_qty.text) * nRatio))
End If
end on

type st_3 from statictext within u_create_po_header_for_dropship
int X=91
int Y=880
int Width=256
int Height=64
boolean Enabled=false
string Text="Quantity"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_create_po_header_for_dropship
int X=677
int Y=880
int Width=183
int Height=64
boolean Enabled=false
string Text="Price"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_price from singlelineedit within u_create_po_header_for_dropship
int X=677
int Y=960
int Width=421
int Height=80
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within u_create_po_header_for_dropship
int X=677
int Y=1056
int Width=421
int Height=96
int TabOrder=50
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wHostWindow.TriggerEvent("close_uo")
end on

type cb_1 from commandbutton within u_create_po_header_for_dropship
int X=91
int Y=1056
int Width=421
int Height=96
int TabOrder=40
string Text="Create P.O."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If IsNull(szVendor) OR szVendor = '' then
	MessageBox( monsys.msg_title, "You must select a vendor first.", StopSign! )
	Return
Else
	wHostWindow.TriggerEvent("create_po_header")
End If

end event

type st_1 from statictext within u_create_po_header_for_dropship
int X=91
int Y=48
int Width=1006
int Height=80
boolean Enabled=false
string Text="List of related vendors"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_vendors from datawindow within u_create_po_header_for_dropship
int X=91
int Y=144
int Width=1006
int Height=720
int TabOrder=10
string DataObject="d_list_of_vendors_per_part"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;If row > 0 then
	
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
	szVendor			= this.GetItemString ( row, "vendor" )
	szTerms			= this.GetItemString ( row, "terms" )
	szVendorPartUM	= uf_um_for_vendor_part ( szVendor, szPart )
	nRatio			= f_convert_units ( st_um1.text, szVendorPartUM, szPart, 1 )

	dw_price_matrix.Retrieve ( szVendor, szPart )
	sle_price.enabled	= TRUE
	sle_price.text		= ''
	SetNull ( sle_price.text )
	sle_price.text		= String(nRatio * uf_get_price(szVendor, szPart, Dec(sle_qty.text) * nRatio))

End If
end event

