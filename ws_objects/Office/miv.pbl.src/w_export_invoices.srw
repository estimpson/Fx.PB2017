$PBExportHeader$w_export_invoices.srw
$PBExportComments$export invoices to third party's account receivable systems
forward
global type w_export_invoices from Window
end type
type sle_directory from singlelineedit within w_export_invoices
end type
type st_10 from statictext within w_export_invoices
end type
type st_total from statictext within w_export_invoices
end type
type sle_invoice_from from singlelineedit within w_export_invoices
end type
type st_percentage from statictext within w_export_invoices
end type
type p_1 from picture within w_export_invoices
end type
type st_none from statictext within w_export_invoices
end type
type st_8 from statictext within w_export_invoices
end type
type st_processed from statictext within w_export_invoices
end type
type st_9 from statictext within w_export_invoices
end type
type sle_invoice_to from singlelineedit within w_export_invoices
end type
type sle_invoice_none from singlelineedit within w_export_invoices
end type
type em_date_to from singlelineedit within w_export_invoices
end type
type em_date_from from singlelineedit within w_export_invoices
end type
type sle_percentage from singlelineedit within w_export_invoices
end type
type st_7 from statictext within w_export_invoices
end type
type ddlb_1 from dropdownlistbox within w_export_invoices
end type
type cb_2 from commandbutton within w_export_invoices
end type
type cb_1 from commandbutton within w_export_invoices
end type
type st_6 from statictext within w_export_invoices
end type
type st_5 from statictext within w_export_invoices
end type
type st_4 from statictext within w_export_invoices
end type
type st_3 from statictext within w_export_invoices
end type
type st_2 from statictext within w_export_invoices
end type
type st_1 from statictext within w_export_invoices
end type
type sle_base from singlelineedit within w_export_invoices
end type
type gb_1 from groupbox within w_export_invoices
end type
end forward

global type w_export_invoices from Window
int X=663
int Y=413
int Width=1537
int Height=1133
boolean TitleBar=true
string Title="Monitor / Account Receivable Interface"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
sle_directory sle_directory
st_10 st_10
st_total st_total
sle_invoice_from sle_invoice_from
st_percentage st_percentage
p_1 p_1
st_none st_none
st_8 st_8
st_processed st_processed
st_9 st_9
sle_invoice_to sle_invoice_to
sle_invoice_none sle_invoice_none
em_date_to em_date_to
em_date_from em_date_from
sle_percentage sle_percentage
st_7 st_7
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_base sle_base
gb_1 gb_1
end type
global w_export_invoices w_export_invoices

on w_export_invoices.create
this.sle_directory=create sle_directory
this.st_10=create st_10
this.st_total=create st_total
this.sle_invoice_from=create sle_invoice_from
this.st_percentage=create st_percentage
this.p_1=create p_1
this.st_none=create st_none
this.st_8=create st_8
this.st_processed=create st_processed
this.st_9=create st_9
this.sle_invoice_to=create sle_invoice_to
this.sle_invoice_none=create sle_invoice_none
this.em_date_to=create em_date_to
this.em_date_from=create em_date_from
this.sle_percentage=create sle_percentage
this.st_7=create st_7
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_base=create sle_base
this.gb_1=create gb_1
this.Control[]={ this.sle_directory,&
this.st_10,&
this.st_total,&
this.sle_invoice_from,&
this.st_percentage,&
this.p_1,&
this.st_none,&
this.st_8,&
this.st_processed,&
this.st_9,&
this.sle_invoice_to,&
this.sle_invoice_none,&
this.em_date_to,&
this.em_date_from,&
this.sle_percentage,&
this.st_7,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_base,&
this.gb_1}
end on

on w_export_invoices.destroy
destroy(this.sle_directory)
destroy(this.st_10)
destroy(this.st_total)
destroy(this.sle_invoice_from)
destroy(this.st_percentage)
destroy(this.p_1)
destroy(this.st_none)
destroy(this.st_8)
destroy(this.st_processed)
destroy(this.st_9)
destroy(this.sle_invoice_to)
destroy(this.sle_invoice_none)
destroy(this.em_date_to)
destroy(this.em_date_from)
destroy(this.sle_percentage)
destroy(this.st_7)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_base)
destroy(this.gb_1)
end on

type sle_directory from singlelineedit within w_export_invoices
int X=695
int Y=433
int Width=650
int Height=81
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="f:\"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_export_invoices
int X=165
int Y=449
int Width=439
int Height=73
boolean Enabled=false
string Text="Output Directory"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
long BorderColor=8388608
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_total from statictext within w_export_invoices
int X=641
int Y=577
int Width=110
int Height=65
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_invoice_from from singlelineedit within w_export_invoices
int X=695
int Y=321
int Width=247
int Height=89
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_percentage from statictext within w_export_invoices
int X=604
int Y=737
int Width=293
int Height=37
boolean Enabled=false
string Text="0 % Done"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_export_invoices
int Width=129
int Height=97
string PictureName="logo2.bmp"
boolean FocusRectangle=false
end type

type st_none from statictext within w_export_invoices
end type

type st_8 from statictext within w_export_invoices
int X=275
int Y=577
int Width=353
int Height=73
boolean Enabled=false
string Text="Total Invoices"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_processed from statictext within w_export_invoices
int X=1189
int Y=577
int Width=110
int Height=65
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=32768
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_export_invoices
int X=860
int Y=577
int Width=298
int Height=73
boolean Enabled=false
string Text="Processed"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_invoice_to from singlelineedit within w_export_invoices
int X=1098
int Y=321
int Width=247
int Height=89
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_invoice_none from singlelineedit within w_export_invoices
end type

type em_date_to from singlelineedit within w_export_invoices
int X=1098
int Y=209
int Width=247
int Height=89
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_date_from from singlelineedit within w_export_invoices
int X=695
int Y=209
int Width=247
int Height=89
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_percentage from singlelineedit within w_export_invoices
int X=170
int Y=677
int Width=74
int Height=41
int TabOrder=90
boolean Enabled=false
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_export_invoices
int X=165
int Y=113
int Width=513
int Height=65
boolean Enabled=false
string Text="Accounting System"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_export_invoices
int X=695
int Y=97
int Width=659
int Height=401
int TabOrder=10
string Text="Intellisoft"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Intellisoft",&
"Peach Tree",&
"Quicken",&
"Solomon"}
end type

type cb_2 from commandbutton within w_export_invoices
int X=1043
int Y=833
int Width=293
int Height=109
int TabOrder=110
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(w_export_invoices)
end on

type cb_1 from commandbutton within w_export_invoices
int X=165
int Y=833
int Width=293
int Height=109
int TabOrder=100
string Text="Generate"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;st_generic_structure stParm

Date 		dDate1
Date		dDate2

Long 		iInvoice1
Long		iInvoice2
Long		iInvoice
Long		iCount
Long		iTotalInvoices
Long		iInvCount

Decimal 	nAmount

If ddlb_1.text <> "Intellisoft" then
	MessageBox("Warning", "Interface for this accounting system has not been installed, please contact Monitor Systems Inc. for detail.", StopSign!)
	Return
End If


If LenA(trim(em_date_from.text)) = 0 then
	dDate1		= Date('01/01/1963')
Else
	dDate1		= Date(em_date_from.text)
End If

If LenA(trim(em_date_to.text)) = 0 then
	dDate2		= Date('12/31/2050')
Else
	dDate2		= Date(em_date_to.text)
End If

If LenA(trim(sle_invoice_from.text)) = 0 then
	iInvoice1	= 0
Else
	iInvoice1	= Long(sle_invoice_from.text)
End If

If LenA(trim(sle_invoice_to.text)) = 0 then
	iInvoice2	= 99999999
Else
	iInvoice2	= Long(sle_invoice_to.text)
End If
	
 SELECT Count(shipper.invoice_number)
	INTO :iTotalInvoices
   FROM shipper  
  WHERE (shipper.status = 'C' OR  
        	shipper.status = 'Z') AND  
        	shipper.date_shipped 	>= :dDate1 AND  
        	shipper.date_shipped 	<= :dDate2 AND  
        	shipper.invoice_number 	>= :iInvoice1 AND  
        	shipper.invoice_number 	<= :iInvoice2   ;

st_total.text	= String(iTotalInvoices)

If iTotalInvoices = 0 then
	Return
End If


DECLARE curInvoice CURSOR FOR  
 SELECT shipper.invoice_number,
		  shipper.total_amount  
   FROM shipper  
  WHERE (shipper.status = 'C' OR  
        	shipper.status = 'Z') AND  
        	shipper.date_shipped 	>= :dDate1 AND  
        	shipper.date_shipped 	<= :dDate2 AND  
        	shipper.invoice_number 	>= :iInvoice1 AND  
        	shipper.invoice_number 	<= :iInvoice2   ;


sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_percentage.visible	= TRUE
iInvCount					= 0

Open curInvoice;

Fetch curInvoice into: iInvoice, :nAmount;

Do while SQLCA.SQLCode = 0 

	iInvCount ++
	sle_percentage.width	= sle_base.width * (iInvCount / iTotalInvoices)
	st_percentage.text	= String(Truncate(100 * iInvCount / iTotalInvoices, 0)) + "% Done"
	

	stParm.value1	= String(iInvoice)
	stParm.value2	= String(nAmount)		
	stParm.value3	= sle_directory.text
	If iInvCount = 1 then
		stParm.value4	= "Replace"
	Else
		stParm.value4	= "Append"
	End If

	OpenWithParm(w_monitor_intellisoft_account_receivable, stParm)
	Fetch curInvoice into: iInvoice, :nAmount;

	iCount	= Long(st_processed.text)
	iCount ++
	st_processed.text	= String(iInvCount)

Loop

Close curInvoice;
end on

type st_6 from statictext within w_export_invoices
int X=165
int Y=337
int Width=238
int Height=65
boolean Enabled=false
string Text="Invoice"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_export_invoices
int X=476
int Y=337
int Width=183
int Height=65
boolean Enabled=false
string Text="From"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_export_invoices
int X=970
int Y=337
int Width=92
int Height=65
boolean Enabled=false
string Text="To"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_export_invoices
int X=970
int Y=225
int Width=92
int Height=65
boolean Enabled=false
string Text="To"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_export_invoices
int X=476
int Y=225
int Width=183
int Height=65
boolean Enabled=false
string Text="From"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_export_invoices
int X=165
int Y=225
int Width=238
int Height=65
boolean Enabled=false
string Text="Date"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_base from singlelineedit within w_export_invoices
int X=165
int Y=673
int Width=1185
int Height=49
int TabOrder=80
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16776960
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_export_invoices
int X=165
int Y=529
int Width=1189
int Height=145
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

