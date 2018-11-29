$PBExportHeader$w_account_payable_interface.srw
forward
global type w_account_payable_interface from Window
end type
type st_interface_name from statictext within w_account_payable_interface
end type
type rb_ap_shipper from radiobutton within w_account_payable_interface
end type
type rb_ap_batch from radiobutton within w_account_payable_interface
end type
type st_4 from statictext within w_account_payable_interface
end type
type st_3 from statictext within w_account_payable_interface
end type
type st_2 from statictext within w_account_payable_interface
end type
type p_1 from picture within w_account_payable_interface
end type
type cb_exit_ap from commandbutton within w_account_payable_interface
end type
type cb_save_ap from commandbutton within w_account_payable_interface
end type
type sle_post_ap from singlelineedit within w_account_payable_interface
end type
type st_post_ap from statictext within w_account_payable_interface
end type
type cb_post_ap from commandbutton within w_account_payable_interface
end type
type st_1 from statictext within w_account_payable_interface
end type
type dw_history from datawindow within w_account_payable_interface
end type
type dw_vendors from datawindow within w_account_payable_interface
end type
end forward

global type w_account_payable_interface from Window
int X=0
int Y=0
int Width=2930
int Height=1928
boolean TitleBar=true
string Title="Monitor Account Payable Interface"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event view_all pbm_custom01
event view_unmarked pbm_custom02
event view_marked pbm_custom03
event query pbm_custom05
event mark_all pbm_custom06
event invoice pbm_custom07
event ue_post pbm_custom04
st_interface_name st_interface_name
rb_ap_shipper rb_ap_shipper
rb_ap_batch rb_ap_batch
st_4 st_4
st_3 st_3
st_2 st_2
p_1 p_1
cb_exit_ap cb_exit_ap
cb_save_ap cb_save_ap
sle_post_ap sle_post_ap
st_post_ap st_post_ap
cb_post_ap cb_post_ap
st_1 st_1
dw_history dw_history
dw_vendors dw_vendors
end type
global w_account_payable_interface w_account_payable_interface

type variables
String i_s_vendor

Boolean bQuery

Long  i_l_VendorRow
end variables

forward prototypes
public subroutine wf_show_post (boolean bflag)
public subroutine wf_post_serial (long iserial, string szbatch)
public subroutine wf_set_flag ()
public function boolean wf_have_unmarked (string a_s_vendor)
end prototypes

on view_all;dw_history.SetFilter("serial > 0")
dw_history.Filter()
end on

on view_unmarked;dw_history.SetFilter("Not (invoice_number > '" + " ')")
dw_history.Filter()

end on

on view_marked;dw_history.SetFilter("invoice_number > '" + " '")
dw_history.Filter()
end on

on query;wf_show_post(true)
bQuery					= TRUE
cb_save_ap.visible	= FALSE
rb_ap_batch.visible	= TRUE
rb_ap_shipper.visible= TRUE
end on

on mark_all;Long iRow

For iRow	= 1 to dw_history.RowCount()
	If IsNull(dw_history.GetItemString(iRow, "invoice_number")) AND &
		(Not dw_history.IsSelected(iRow)) then
		dw_history.SelectRow(iRow, TRUE)
	End If
Next 
end on

on invoice;IF dw_history.RowCount ( ) > 0 THEN
	OpenSheet ( w_invoice_platinum, wMainScreen, 3, Original! )
END IF
end on

event ue_post;CHOOSE CASE st_interface_name.Text
CASE 'Platinum'
	OpenSheet ( w_post_platinum, wMainScreen, 3, Original! )
CASE 'PLATINUM'
	OpenSheet ( w_post_platinum, wMainScreen, 3, Original! )
CASE ELSE
	wf_show_post(TRUE)
END CHOOSE
end event

public subroutine wf_show_post (boolean bflag);cb_post_ap.visible	= bFlag
st_post_ap.visible	= bFlag
sle_post_ap.visible	= bFlag
cb_save_ap.visible	= bFlag
cb_exit_ap.visible	= bFlag
end subroutine

public subroutine wf_post_serial (long iserial, string szbatch);UPDATE audit_trail  
   SET invoice_number = :szBatch  
 WHERE ( serial = :iSerial ) AND  
       ( type = 'R' )   ;

end subroutine

public subroutine wf_set_flag ();str_progress stParm

Long iRow

stParm.title	= "Set up demand flags"
OpenWithParm(w_progress, stParm)

For iRow	= 1 to dw_vendors.RowCount()

	w_progress.wf_progress(iRow / dw_vendors.RowCount(), "Searching vendor:" + dw_vendors.GetItemString(iRow, "code"))

	If wf_have_unmarked(dw_vendors.GetItemString(iRow, "code")) then
		dw_vendors.SetItem(iRow, "flag", 1)
	Else
		dw_vendors.SetItem(iRow, "flag", 0)
	End If

Next

Close(w_progress)

end subroutine

public function boolean wf_have_unmarked (string a_s_vendor);Long iTotal

iTotal	= 0

SELECT count(audit_trail.serial )  
  INTO :iTotal  
  FROM audit_trail  
 WHERE ( audit_trail.vendor = :a_s_Vendor ) AND  
       ( audit_trail.invoice_number is NULL)  AND
		 ( audit_trail.type = 'R') ;

If iTotal > 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

on open;dw_vendors.SetTransObject(sqlca)
dw_vendors.Retrieve()
//wf_set_flag()

  SELECT accounting_type
    INTO	:st_interface_name.text
    FROM	parameters  ;

CHOOSE CASE st_interface_name.text
CASE 'Platinum'
	dw_history.DataObject = 'dw_uninvoiced_receipts_platinum'
	dw_history.Modify("po_number.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
CASE 'PLATINUM'
	dw_history.DataObject = 'dw_uninvoiced_receipts_platinum'
	dw_history.Modify("po_number.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
CASE ELSE
	dw_history.Modify("shipper.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
END CHOOSE

dw_history.Modify("serial.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("quantity.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("date.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("unit.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("operator.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("part.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("to.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("std_quantity.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("plant.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")
dw_history.Modify("weight.color = '0~tif(invoice_number > ~~' ~~', 255, 0)'")

dw_history.SetTransObject(sqlca)
end on

event activate;CHOOSE CASE st_interface_name.Text
CASE 'Platinum'
	gnv_App.of_GetFrame().ChangeMenu ( m_account_payable_platinum )
CASE 'PLATINUM'
	gnv_App.of_GetFrame().ChangeMenu ( m_account_payable_platinum )
CASE ELSE
	gnv_App.of_GetFrame().ChangeMenu(m_account_payable)
END CHOOSE

i_l_VendorRow	= dw_vendors.GetSelectedRow ( 0 )

If i_l_VendorRow > 0 then
	i_s_Vendor	= dw_vendors.GetItemString(i_l_VendorRow, "code")
	dw_vendors.SelectRow(0, FALSE)
	dw_vendors.SelectRow(i_l_VendorRow, TRUE)
	dw_history.Retrieve(i_s_Vendor)
	CHOOSE CASE st_interface_name.Text
	CASE 'Platinum'
	CASE ELSE
		dw_history.SetFilter("Not (invoice_number > '" + " ')")
		dw_history.Filter()
	END CHOOSE
End If
end event

event resize;//This.Resize ( 2943, 1548 )
end event

on w_account_payable_interface.create
this.st_interface_name=create st_interface_name
this.rb_ap_shipper=create rb_ap_shipper
this.rb_ap_batch=create rb_ap_batch
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.cb_exit_ap=create cb_exit_ap
this.cb_save_ap=create cb_save_ap
this.sle_post_ap=create sle_post_ap
this.st_post_ap=create st_post_ap
this.cb_post_ap=create cb_post_ap
this.st_1=create st_1
this.dw_history=create dw_history
this.dw_vendors=create dw_vendors
this.Control[]={this.st_interface_name,&
this.rb_ap_shipper,&
this.rb_ap_batch,&
this.st_4,&
this.st_3,&
this.st_2,&
this.p_1,&
this.cb_exit_ap,&
this.cb_save_ap,&
this.sle_post_ap,&
this.st_post_ap,&
this.cb_post_ap,&
this.st_1,&
this.dw_history,&
this.dw_vendors}
end on

on w_account_payable_interface.destroy
destroy(this.st_interface_name)
destroy(this.rb_ap_shipper)
destroy(this.rb_ap_batch)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.cb_exit_ap)
destroy(this.cb_save_ap)
destroy(this.sle_post_ap)
destroy(this.st_post_ap)
destroy(this.cb_post_ap)
destroy(this.st_1)
destroy(this.dw_history)
destroy(this.dw_vendors)
end on

type st_interface_name from statictext within w_account_payable_interface
int X=1138
int Y=16
int Width=590
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_ap_shipper from radiobutton within w_account_payable_interface
int X=2011
int Y=544
int Width=311
int Height=64
boolean Visible=false
string Text="Shipper"
long TextColor=128
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;rb_ap_batch.checked		= Not this.checked

If Not this.checked	then
	st_post_ap.text	= "Batch # / Invoice #"
Else
	st_post_ap.text	= "Shipper"
End If	
end on

type rb_ap_batch from radiobutton within w_account_payable_interface
int X=1390
int Y=544
int Width=494
int Height=64
boolean Visible=false
string Text="Batch# / Invoice#"
boolean Checked=true
long TextColor=128
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;rb_ap_shipper.checked	= Not this.checked

If this.checked	then
	st_post_ap.text	= "Batch # / Invoice #"
Else
	st_post_ap.text	= "Shipper"
End If	
end on

type st_4 from statictext within w_account_payable_interface
int X=1833
int Y=16
int Width=891
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Double Click to Mark for Invoice"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_account_payable_interface
int X=585
int Y=16
int Width=539
int Height=72
boolean Enabled=false
string Text="Current A/P Software"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_account_payable_interface
int X=347
int Y=28
int Width=224
int Height=48
boolean Enabled=false
string Text="Uninvoiced"
boolean FocusRectangle=false
long TextColor=255
long BackColor=16777215
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_account_payable_interface
int X=293
int Y=28
int Width=59
int Height=48
string PictureName="logo2.bmp"
boolean FocusRectangle=false
end type

type cb_exit_ap from commandbutton within w_account_payable_interface
int X=1911
int Y=856
int Width=247
int Height=108
int TabOrder=60
boolean Visible=false
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_show_post(FALSE)
bQuery					= FALSE
rb_Ap_batch.visible	= FALSE
rb_Ap_shipper.visible= FALSE
end on

type cb_save_ap from commandbutton within w_account_payable_interface
int X=1577
int Y=856
int Width=247
int Height=108
int TabOrder=50
boolean Visible=false
string Text="Save"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long iRow
Long iSerial

For iRow	= 1 to dw_history.RowCount()
	If dw_history.IsSelected(iRow) then
		iSerial	= dw_history.GetItemNumber(iRow, "serial")
		wf_post_serial(iSerial, sle_post_ap.text)
		dw_history.SetItem(iRow, "invoice_number", sle_post_ap.text)
		dw_history.SelectRow(iRow, false)
	End If
Next		

If SQLCA.SQLCode = 0 then
	Commit;
	If dw_history.RowCount() <= 0 then
		dw_vendors.SetItem(i_l_VendorRow, 'flag', 0)
	End If	
Else
	Rollback;
End If

wf_show_post(FALSE)
bQuery	= FALSE
end event

type sle_post_ap from singlelineedit within w_account_payable_interface
int X=1577
int Y=716
int Width=585
int Height=88
int TabOrder=40
boolean Visible=false
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If bQuery then

	dw_history.SetFilter("serial > 0")
	dw_history.Filter()

	If rb_ap_batch.checked then
		dw_history.SetFilter("invoice_number = '" + this.Text + "'")
	Else
		dw_history.SetFilter("shipper = '" + this.text + "'")
	End If

	dw_history.Filter()

	wf_show_post(FALSE)
	rb_ap_batch.visible	= FALSE
	rb_ap_shipper.visible= FALSE

End If 
end on

type st_post_ap from statictext within w_account_payable_interface
int X=1627
int Y=624
int Width=462
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Batch# / Invoice#"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_post_ap from commandbutton within w_account_payable_interface
int X=1234
int Y=492
int Width=1189
int Height=584
int TabOrder=30
boolean Visible=false
boolean Enabled=false
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_account_payable_interface
int X=18
int Y=16
int Width=549
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="   Vendors"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_history from datawindow within w_account_payable_interface
int X=585
int Y=104
int Width=2139
int Height=1292
int TabOrder=20
string DataObject="dw_smart_po_receiving_history_per_vendor"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Boolean 	bSelected
Long		iHistoryRow

iHistoryRow	= this.GetClickedRow()

If iHistoryRow > 0 then
	CHOOSE CASE st_interface_name.Text
	CASE 'Platinum'
		IF NOT IsNull ( This.GetItemString ( iHistoryRow, 'invoice_number' ) ) THEN
			MessageBox ( 'Warning', 'Unable to carry out request./nThis receipt has already been invoiced' )
		ELSE
			bSelected = IsSelected ( iHistoryRow )
			SelectRow ( iHistoryRow, NOT bSelected )
		END IF
	CASE ELSE
		If this.GetItemString(iHistoryRow, "invoice_number") > ' ' then
			sle_post_ap.text	= this.GetItemString(iHistoryRow, "invoice_number")
			wf_show_post(TRUE)
			cb_save_ap.visible	= FALSE
		Else
			bSelected	= this.IsSelected(iHistoryRow)
			this.SelectRow(iHistoryRow, Not bSelected)
		End If
	END CHOOSE
End If
end on

type dw_vendors from datawindow within w_account_payable_interface
int X=18
int Y=104
int Width=549
int Height=1292
int TabOrder=10
string DataObject="dw_list_of_vendors_with_receipts"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;i_l_VendorRow	= row

If i_l_VendorRow > 0 then
	i_s_Vendor	= this.GetItemString(i_l_VendorRow, "code")
	this.SelectRow(0, FALSE)
	this.SelectRow(i_l_VendorRow, TRUE)
	dw_history.Retrieve(i_s_Vendor)
	CHOOSE CASE st_interface_name.Text
	CASE 'Platinum'
	CASE ELSE
		dw_history.SetFilter("Not (invoice_number > '" + " ')")
		dw_history.Filter()
	END CHOOSE
End If
end event

