$PBExportHeader$w_fastcopy_order.srw
$PBExportComments$Fast copy the blanket order to destination
forward
global type w_fastcopy_order from Window
end type
type ddlb_1 from dropdownlistbox within w_fastcopy_order
end type
type dw_new_order from datawindow within w_fastcopy_order
end type
type st_copy from statictext within w_fastcopy_order
end type
type st_select from statictext within w_fastcopy_order
end type
type st_1 from statictext within w_fastcopy_order
end type
type cb_2 from commandbutton within w_fastcopy_order
end type
type cb_1 from commandbutton within w_fastcopy_order
end type
type dw_destination from datawindow within w_fastcopy_order
end type
type dw_original from datawindow within w_fastcopy_order
end type
type gb_2 from groupbox within w_fastcopy_order
end type
type gb_1 from groupbox within w_fastcopy_order
end type
end forward

global type w_fastcopy_order from Window
int X=0
int Y=0
int Width=3250
int Height=2208
boolean TitleBar=true
string Title="Blanket Order Fast Copy"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ddlb_1 ddlb_1
dw_new_order dw_new_order
st_copy st_copy
st_select st_select
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_destination dw_destination
dw_original dw_original
gb_2 gb_2
gb_1 gb_1
end type
global w_fastcopy_order w_fastcopy_order

type variables
Integer iSelected = 0
Integer iCopied    = 0


end variables

forward prototypes
public function boolean wf_copy (string szdestination)
end prototypes

public function boolean wf_copy (string szdestination);/* 01-27-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate '' (next Sales Order number).  */

String  szPart			//Part number
String  szColName		//Column name
String  szCustomer	//Customer 
String  ls_CustomerPO
String  szPackagetype
String  szUM
String  szBoxlabel
String  szDockCode
String  szShipType

Integer iOrder
Integer iRow
Integer iStdPack
Long 	  iSalesOrder																														// ADD 01-27-2000 KAZ

Date    dPo_ex_date

Boolean bProcess

//OpenWithParm(w_get_parm_value, "sales_order")																					-  CHG 01-27-2000 KAZ

if not sqlca.of_getnextparmvalue ( "sales_order", iSalesOrder ) then    // Failed to get current value 	-  ADD 01-27-2000 KAZ
	Rollback;																															// ADD 01-27-2000 KAZ
	MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )			// ADD 01-27-2000 KAZ
	Return False																														// ADD 01-27-2000 KAZ
end if																																	// ADD 01-27-2000 KAZ

szPart			= dw_original.GetItemString ( 1, "blanket_part")
ls_CustomerPO  = dw_original.GetItemString ( 1, "customer_po" )
dPo_ex_date  	= dw_original.GetItemdate 	 ( 1, "po_expiry_date" )
szPackagetype	= dw_original.GetItemString ( 1, "package_type" )	
szUM				= dw_original.GetItemString ( 1, "shipping_unit" )
szBoxlabel		= dw_original.GetItemString ( 1, "box_label" )
szDockCode  	= dw_original.GetItemString ( 1, "dock_code" )
iStdPack			= dw_original.GetItemNumber ( 1, "standard_pack" )
szShipType     = dw_original.GetItemString ( 1, "ship_type" )

Select order_header.order_no  
Into   :iOrder  
From   order_header  
Where ( order_header.blanket_part 	= :szPart ) And
      ( order_header.destination 	= :szDestination )   ;

SELECT destination.customer  
  INTO :szCustomer  
  FROM destination  
 WHERE destination.destination = :szDestination   ;

bProcess	= TRUE
If iOrder > 0 then
	bProcess = (MessageBox("Warning", "Order for same part and destination:" + szDestination + " exists!~rCreate new order", StopSign!, YesNo!) = 1)
End If

If bProcess then
	dw_new_order.InsertRow(1)
	For iRow = 1 to 21
		If iRow <> 3 then
			If iRow = 1 or iRow = 9 or iRow = 10 or iRow = 13 then
				dw_new_order.SetItem(1, iRow, &
											dw_original.GetItemNumber(1, iRow))
			Else
				dw_new_order.SetItem(1, iRow, &
											dw_original.GetItemString(1, iRow ))
			End If
		End If
	Next
	
	dw_new_order.SetItem(1, "destination", szDestination)
//	dw_new_order.SetItem(1, "order_no", 	message.DoubleParm)																-  CHG 01-27-2000 KAZ
	dw_new_order.SetItem(1, "order_no", 	iSalesOrder)																		// CHG 01-27-2000 KAZ
	dw_new_order.SetItem(1, "customer", 	szCustomer)
	dw_new_order.SetItem(1, "our_cum", 0)
	dw_new_order.SetItem(1, "customer_po", ls_CustomerPO )
	dw_new_order.SetItem(1, "po_expiry_date", dPo_ex_date )
	dw_new_order.SetItem(1, "package_type", szPackagetype	)
	dw_new_order.SetItem(1, "standard_pack", iStdPack )
	dw_new_order.SetItem(1, "box_label", szBoxlabel	)
	dw_new_order.SetItem(1, "shipping_unit", szUM )
   dw_new_order.SetItem(1, "order_date", today() )
   dw_new_order.SetItem(1, "ship_type", szShiptype )
   dw_new_order.SetItem(1, "dock_code", szDockcode )

	If dw_new_order.Update() > 0 then
		Commit;
		Return True
	Else
		RollBack;
		Return False
	End If

Else

	Return False

End If  						

end function

on open;//**************************************************************************
//* Author				: Jim Wu
//* Start Date			: 2/24/95
//* Customer   		: All
//* Monitor Ver		: 3.0
//* Development Tool	: PowerBuilder 3.0 / Watcom SQL
//* Description      : Fastcopy blanket order 
//************************************************************************
//* Declaration
//************************************************************************

Long iShipper

dw_destination.SetTransObject(sqlca)
dw_original.SetTransObject(sqlca)
dw_new_order.SetTransObject(sqlca)

//************************************************************************
//* Initialization
//************************************************************************

iShipper	= Message.DoubleParm

//************************************************************************
//* Main Routine
//************************************************************************

If dw_original.Retrieve(iShipper) > 0 Then &
	ddlb_1.AddItem(dw_original.GetItemString(1, "customer"))

dw_destination.Retrieve()

ddlb_1.Text	= "All"
end on

on w_fastcopy_order.create
this.ddlb_1=create ddlb_1
this.dw_new_order=create dw_new_order
this.st_copy=create st_copy
this.st_select=create st_select
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_destination=create dw_destination
this.dw_original=create dw_original
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.ddlb_1,&
this.dw_new_order,&
this.st_copy,&
this.st_select,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_destination,&
this.dw_original,&
this.gb_2,&
this.gb_1}
end on

on w_fastcopy_order.destroy
destroy(this.ddlb_1)
destroy(this.dw_new_order)
destroy(this.st_copy)
destroy(this.st_select)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_destination)
destroy(this.dw_original)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type ddlb_1 from dropdownlistbox within w_fastcopy_order
int X=27
int Y=884
int Width=617
int Height=360
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All"}
end type

on selectionchanged;If this.text 	= "All" then
	dw_destination.SetFilter("destination > ' '")
Else
	dw_destination.SetFilter("customer = '" + dw_original.GetItemString(1, "customer") + "'")
End If

dw_destination.Filter()
end on

type dw_new_order from datawindow within w_fastcopy_order
int X=14
int Y=1904
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="dw_blanket_order_header"
boolean LiveScroll=true
end type

type st_copy from statictext within w_fastcopy_order
int X=1765
int Y=1676
int Width=398
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Copied:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_select from statictext within w_fastcopy_order
int X=786
int Y=1664
int Width=398
int Height=72
boolean Enabled=false
string Text="Selected:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fastcopy_order
int X=23
int Y=800
int Width=663
int Height=72
boolean Enabled=false
string Text="Destination for Customer"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_fastcopy_order
int X=2377
int Y=1112
int Width=247
int Height=108
int TabOrder=50
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)

m_blanket_order.wf_reset_screen()
end on

type cb_1 from commandbutton within w_fastcopy_order
int X=2377
int Y=988
int Width=247
int Height=108
int TabOrder=70
string Text="Copy"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer iRow

If iSelected = 0 then
	MessageBox("Warning", "No destination selected for copy", StopSign!)
Else
	st_copy.visible	= TRUE
	For iRow	= 1 to dw_destination.RowCount() 
		If dw_destination.IsSelected(iRow) then
			If wf_copy(dw_destination.GetItemString(iRow, "destination")) Then
				dw_destination.SelectRow(iRow, FALSE)				
				iCopied ++
				st_copy.text	= "Copied:" + String(iCopied)
			End if
		End If
	Next
End If		
end event

type dw_destination from datawindow within w_fastcopy_order
int X=786
int Y=992
int Width=1376
int Height=644
int TabOrder=40
string DataObject="dw_destination_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Integer iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	This.SelectRow(iRow, Not this.IsSelected(iRow))
End If

If This.IsSelected(iRow) then
	iSelected ++
Else
	iSelected --
End If

st_select.text	= "Selected:" + String(iSelected)
end on

type dw_original from datawindow within w_fastcopy_order
int X=59
int Y=108
int Width=2770
int Height=624
int TabOrder=10
boolean Enabled=false
string DataObject="dw_blanket_order_header"
boolean Border=false
boolean LiveScroll=true
end type

type gb_2 from groupbox within w_fastcopy_order
int X=722
int Y=896
int Width=1513
int Height=876
int TabOrder=20
string Text="Double Click to Select/DeSelect Destination"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_fastcopy_order
int X=23
int Y=32
int Width=2811
int Height=736
int TabOrder=80
string Text="Original Blanket Sales Order"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

