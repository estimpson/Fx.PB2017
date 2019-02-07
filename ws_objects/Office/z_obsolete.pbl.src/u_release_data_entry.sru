$PBExportHeader$u_release_data_entry.sru
$PBExportComments$Used when user dragdrops the MPS to create PO releases.
forward
global type u_release_data_entry from UserObject
end type
type sle_dragdrop_date from editmask within u_release_data_entry
end type
type dw_price_matrix from datawindow within u_release_data_entry
end type
type st_po_um from statictext within u_release_data_entry
end type
type st_std_um from statictext within u_release_data_entry
end type
type cb_exit from commandbutton within u_release_data_entry
end type
type cb_save from commandbutton within u_release_data_entry
end type
type sle_std_pack from singlelineedit within u_release_data_entry
end type
type st_8 from statictext within u_release_data_entry
end type
type sle_min_on_order from singlelineedit within u_release_data_entry
end type
type st_7 from statictext within u_release_data_entry
end type
type sle_lead_time from singlelineedit within u_release_data_entry
end type
type st_6 from statictext within u_release_data_entry
end type
type sle_price from singlelineedit within u_release_data_entry
end type
type st_5 from statictext within u_release_data_entry
end type
type sle_release from singlelineedit within u_release_data_entry
end type
type st_4 from statictext within u_release_data_entry
end type
type sle_po_qty from singlelineedit within u_release_data_entry
end type
type st_3 from statictext within u_release_data_entry
end type
type sle_std_qty from singlelineedit within u_release_data_entry
end type
type st_2 from statictext within u_release_data_entry
end type
type st_1 from statictext within u_release_data_entry
end type
end forward

global type u_release_data_entry from UserObject
int Width=1371
int Height=1076
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
sle_dragdrop_date sle_dragdrop_date
dw_price_matrix dw_price_matrix
st_po_um st_po_um
st_std_um st_std_um
cb_exit cb_exit
cb_save cb_save
sle_std_pack sle_std_pack
st_8 st_8
sle_min_on_order sle_min_on_order
st_7 st_7
sle_lead_time sle_lead_time
st_6 st_6
sle_price sle_price
st_5 st_5
sle_release sle_release
st_4 st_4
sle_po_qty sle_po_qty
st_3 st_3
sle_std_qty sle_std_qty
st_2 st_2
st_1 st_1
end type
global u_release_data_entry u_release_data_entry

type variables
Private:

Window	i_w_HostWin	//Name of host window
String	i_s_Part		//Part number
String	i_s_Vendor	//Vendor code 
end variables

forward prototypes
public function decimal uf_get_price (string l_s_vendor, string l_s_part, decimal l_d_qty)
public subroutine uf_setup (ref window l_w_hostwin, string l_s_dragdropdate, string l_s_stdqty, string l_s_poqty, string l_s_release, string l_s_price, string l_s_leadtime, string l_s_minorderqty, string l_s_stdpack, string l_s_stdum, string l_s_poum, string l_s_vendor, string l_s_part)
end prototypes

public function decimal uf_get_price (string l_s_vendor, string l_s_part, decimal l_d_qty);/*
Description :	This function will get the price from the price matrix 
					for specified vendor and part.
Author	   :	Jim Wu
Date		   :	12/21/95
Modification:
*/

/* Declaration */			

Integer l_i_TotalRows
Integer l_i_Row
Decimal l_d_Price
Boolean l_b_Found
 
/* Initialization */
l_b_Found		= FALSE
l_i_TotalRows	= dw_price_matrix.RowCount()
l_i_Row			= l_i_TotalRows

/* Search the price matrix and get the price */
Do while (Not l_b_Found) AND (l_i_Row > 0)
	l_b_Found = (l_d_Qty >= dw_price_matrix.GetItemNumber(l_i_Row, "break_qty"))

	If Not l_b_Found then
		l_i_Row --
	End If

Loop


If l_i_Row = 0 then		//If no row matches, the system will use the std cost.
	l_b_Found	= FALSE
End If

If l_b_Found then
	l_d_Price	= Truncate(dw_price_matrix.GetItemNumber(l_i_Row, "price") + 0.0000009, 4)
Else
	If l_d_Qty > 0 then
		l_d_Price	= Truncate(Dec(f_get_part_info(l_s_Part, "STANDARD COST")) + 0.0000009, 4)
		l_d_Price	= f_convert_units(st_po_um.text, "", l_s_Part, l_d_Qty) * l_d_Price / l_d_Qty
	Else
		l_d_Price	= 0
	End If
End If

Return l_d_Price




end function

public subroutine uf_setup (ref window l_w_hostwin, string l_s_dragdropdate, string l_s_stdqty, string l_s_poqty, string l_s_release, string l_s_price, string l_s_leadtime, string l_s_minorderqty, string l_s_stdpack, string l_s_stdum, string l_s_poum, string l_s_vendor, string l_s_part);/*
Description:This object is used for entering release data after dragdrop
				from PO MPS scheduler to vendor. This is the function which
				sets up the screen.
Author:		Jim Wu
Date:			12/21/95
Modification:
*/

/* Declaration */



/* Initialization */
i_w_HostWin	= l_w_HostWin

sle_dragdrop_date.text	= l_s_DragDropDate
sle_std_qty.text			= l_s_StdQty
sle_po_qty.text			= l_s_POQty
sle_release.text			= l_s_Release
sle_lead_time.text		= l_s_LeadTime
sle_min_on_order.text	= l_s_MinOrderQty
sle_std_pack.text			= l_s_StdPack
st_std_um.text				= l_s_StdUM
st_po_um.text				= l_s_POUM
i_s_Vendor					= l_s_Vendor
i_s_Part						= l_s_Part
sle_price.text	= String(uf_get_price(i_s_Vendor, i_s_Part, Dec(sle_po_qty.text)))

dw_price_matrix.SetTransObject(SQLCA)

dw_price_matrix.Retrieve(l_s_Vendor, l_s_Part)


end subroutine

on u_release_data_entry.create
this.sle_dragdrop_date=create sle_dragdrop_date
this.dw_price_matrix=create dw_price_matrix
this.st_po_um=create st_po_um
this.st_std_um=create st_std_um
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.sle_std_pack=create sle_std_pack
this.st_8=create st_8
this.sle_min_on_order=create sle_min_on_order
this.st_7=create st_7
this.sle_lead_time=create sle_lead_time
this.st_6=create st_6
this.sle_price=create sle_price
this.st_5=create st_5
this.sle_release=create sle_release
this.st_4=create st_4
this.sle_po_qty=create sle_po_qty
this.st_3=create st_3
this.sle_std_qty=create sle_std_qty
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.sle_dragdrop_date,&
this.dw_price_matrix,&
this.st_po_um,&
this.st_std_um,&
this.cb_exit,&
this.cb_save,&
this.sle_std_pack,&
this.st_8,&
this.sle_min_on_order,&
this.st_7,&
this.sle_lead_time,&
this.st_6,&
this.sle_price,&
this.st_5,&
this.sle_release,&
this.st_4,&
this.sle_po_qty,&
this.st_3,&
this.sle_std_qty,&
this.st_2,&
this.st_1}
end on

on u_release_data_entry.destroy
destroy(this.sle_dragdrop_date)
destroy(this.dw_price_matrix)
destroy(this.st_po_um)
destroy(this.st_std_um)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.sle_std_pack)
destroy(this.st_8)
destroy(this.sle_min_on_order)
destroy(this.st_7)
destroy(this.sle_lead_time)
destroy(this.st_6)
destroy(this.sle_price)
destroy(this.st_5)
destroy(this.sle_release)
destroy(this.st_4)
destroy(this.sle_po_qty)
destroy(this.st_3)
destroy(this.sle_std_qty)
destroy(this.st_2)
destroy(this.st_1)
end on

type sle_dragdrop_date from editmask within u_release_data_entry
int X=731
int Y=64
int Width=384
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_price_matrix from datawindow within u_release_data_entry
int X=274
int Y=1040
int Width=494
int Height=360
int TabOrder=70
boolean Visible=false
string DataObject="dw_smart_vendor_part_price_matrix"
boolean LiveScroll=true
end type

type st_po_um from statictext within u_release_data_entry
int X=1134
int Y=256
int Width=146
int Height=64
boolean Enabled=false
string Text="UM"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_std_um from statictext within u_release_data_entry
int X=1134
int Y=160
int Width=146
int Height=64
boolean Enabled=false
string Text="UM"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within u_release_data_entry
int X=878
int Y=864
int Width=247
int Height=108
int TabOrder=60
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_HostWin.TriggerEvent("ue_close_release_entry_uo")
end on

type cb_save from commandbutton within u_release_data_entry
int X=256
int Y=864
int Width=247
int Height=108
int TabOrder=50
string Text="Save"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_HostWin.TriggerEvent("ue_dragdrop_save")
end on

type sle_std_pack from singlelineedit within u_release_data_entry
int X=731
int Y=736
int Width=384
int Height=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within u_release_data_entry
int X=256
int Y=736
int Width=448
int Height=72
boolean Enabled=false
string Text="Vendor Std Pack"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_min_on_order from singlelineedit within u_release_data_entry
int X=731
int Y=640
int Width=384
int Height=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within u_release_data_entry
int X=256
int Y=640
int Width=370
int Height=72
boolean Enabled=false
string Text="Min Order Qty"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_lead_time from singlelineedit within u_release_data_entry
int X=731
int Y=544
int Width=384
int Height=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within u_release_data_entry
int X=256
int Y=544
int Width=283
int Height=72
boolean Enabled=false
string Text="Lead Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_price from singlelineedit within u_release_data_entry
int X=731
int Y=448
int Width=384
int Height=80
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within u_release_data_entry
int X=256
int Y=448
int Width=247
int Height=72
boolean Enabled=false
string Text="Price"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_release from singlelineedit within u_release_data_entry
int X=731
int Y=352
int Width=384
int Height=80
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_release_data_entry
int X=256
int Y=352
int Width=247
int Height=72
boolean Enabled=false
string Text="Release"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_po_qty from singlelineedit within u_release_data_entry
int X=731
int Y=256
int Width=384
int Height=80
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;sle_std_qty.text	= String(Truncate(f_convert_units(st_std_um.text, "",  i_s_Part, Dec(this.text)), 4))
sle_price.text	= String(uf_get_price(i_s_Vendor, i_s_Part, Dec(sle_po_qty.text)))
end on

type st_3 from statictext within u_release_data_entry
int X=256
int Y=256
int Width=279
int Height=72
boolean Enabled=false
string Text="Qty for PO"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_std_qty from singlelineedit within u_release_data_entry
int X=731
int Y=160
int Width=384
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;sle_po_qty.text	= String(Truncate(f_convert_units("", st_po_um.text, i_s_Part, Dec(this.text)), 4))
sle_price.text		= String(uf_get_price(i_s_Vendor, i_s_Part, Dec(sle_po_qty.text)))
end on

type st_2 from statictext within u_release_data_entry
int X=256
int Y=160
int Width=247
int Height=72
boolean Enabled=false
string Text="Std Qty"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_release_data_entry
int X=256
int Y=64
int Width=247
int Height=72
boolean Enabled=false
string Text="Date"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

