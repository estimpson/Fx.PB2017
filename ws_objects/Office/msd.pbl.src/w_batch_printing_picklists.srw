$PBExportHeader$w_batch_printing_picklists.srw
$PBExportComments$Print multiple picklists in batch mode
forward
global type w_batch_printing_picklists from Window
end type
type dw_shipper from datawindow within w_batch_printing_picklists
end type
type cb_exit from commandbutton within w_batch_printing_picklists
end type
type cb_1 from commandbutton within w_batch_printing_picklists
end type
type st_9 from statictext within w_batch_printing_picklists
end type
type sle_ship_via1 from singlelineedit within w_batch_printing_picklists
end type
type sle_ship_via2 from singlelineedit within w_batch_printing_picklists
end type
type st_8 from statictext within w_batch_printing_picklists
end type
type st_7 from statictext within w_batch_printing_picklists
end type
type st_6 from statictext within w_batch_printing_picklists
end type
type st_5 from statictext within w_batch_printing_picklists
end type
type st_4 from statictext within w_batch_printing_picklists
end type
type sle_customer2 from singlelineedit within w_batch_printing_picklists
end type
type sle_customer1 from singlelineedit within w_batch_printing_picklists
end type
type st_3 from statictext within w_batch_printing_picklists
end type
type sle_date2 from singlelineedit within w_batch_printing_picklists
end type
type st_2 from statictext within w_batch_printing_picklists
end type
type sle_date1 from singlelineedit within w_batch_printing_picklists
end type
type st_1 from statictext within w_batch_printing_picklists
end type
end forward

global type w_batch_printing_picklists from Window
int X=462
int Y=496
int Width=1966
int Height=916
boolean TitleBar=true
string Title="Batch Printing Picklist"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
dw_shipper dw_shipper
cb_exit cb_exit
cb_1 cb_1
st_9 st_9
sle_ship_via1 sle_ship_via1
sle_ship_via2 sle_ship_via2
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
sle_customer2 sle_customer2
sle_customer1 sle_customer1
st_3 st_3
sle_date2 sle_date2
st_2 st_2
sle_date1 sle_date1
st_1 st_1
end type
global w_batch_printing_picklists w_batch_printing_picklists

type variables
str_progress stProgress
st_generic_structure stParm
end variables

on open;Long 		iRow
Long 		iTotalRows
Long		iShipper

Boolean	bQuickPrint	= FALSE

DataWindow dw_shippers_selected

dw_shippers_selected	= w_list_of_active_shippers.dw_shipping_dock

iTotalRows				= dw_shippers_selected.RowCount()
iRow						= 1

Do while (Not bQuickPrint) AND (iRow <= iTotalRows)
	bQuickPrint	= dw_shippers_selected.IsSelected(iRow)
	iRow ++
Loop

If Not bQuickPrint then		//Need to popup the condition selector
	dw_shipper.SetTransObject(sqlca)
	dw_shipper.Retrieve()
Else

	stProgress.title	= "Batch Printing Picklists"
	OpenWithParm(w_progress, stProgress)
	
	For iRow = 1 to iTotalRows
		If dw_shippers_selected.IsSelected(iRow) then
			iShipper	= dw_shippers_selected.GetItemNumber(iRow, "id")
			w_progress.wf_progress(iRow / iTotalRows, "Printing Picklist for Shipper " + String(iShipper))
			stParm.value1	= String(iShipper)
			stParm.value2	= "PRINT"
			OpenWithParm(w_preview_picklist, stParm)
			dw_shippers_selected.SelectRow ( iRow, FALSE )
		Else
			w_progress.wf_progress(iRow / iTotalRows, "Searching for next picklist")
		End If
	Next

	Close(w_progress)
	Close(this)

End If
end on

on w_batch_printing_picklists.create
this.dw_shipper=create dw_shipper
this.cb_exit=create cb_exit
this.cb_1=create cb_1
this.st_9=create st_9
this.sle_ship_via1=create sle_ship_via1
this.sle_ship_via2=create sle_ship_via2
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.sle_customer2=create sle_customer2
this.sle_customer1=create sle_customer1
this.st_3=create st_3
this.sle_date2=create sle_date2
this.st_2=create st_2
this.sle_date1=create sle_date1
this.st_1=create st_1
this.Control[]={this.dw_shipper,&
this.cb_exit,&
this.cb_1,&
this.st_9,&
this.sle_ship_via1,&
this.sle_ship_via2,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.sle_customer2,&
this.sle_customer1,&
this.st_3,&
this.sle_date2,&
this.st_2,&
this.sle_date1,&
this.st_1}
end on

on w_batch_printing_picklists.destroy
destroy(this.dw_shipper)
destroy(this.cb_exit)
destroy(this.cb_1)
destroy(this.st_9)
destroy(this.sle_ship_via1)
destroy(this.sle_ship_via2)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_customer2)
destroy(this.sle_customer1)
destroy(this.st_3)
destroy(this.sle_date2)
destroy(this.st_2)
destroy(this.sle_date1)
destroy(this.st_1)
end on

type dw_shipper from datawindow within w_batch_printing_picklists
int X=37
int Y=528
int Width=768
int Height=800
int TabOrder=70
boolean Visible=false
string DataObject="dw_shipping_dock"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_exit from commandbutton within w_batch_printing_picklists
int X=1554
int Y=624
int Width=247
int Height=108
int TabOrder=90
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(w_batch_printing_picklists)
end on

type cb_1 from commandbutton within w_batch_printing_picklists
int X=896
int Y=624
int Width=617
int Height=108
int TabOrder=80
string Text="Batch Print PickList"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Date dDate

String szCondition 
String szSelectDate

Long	iRow
Long	iTotalRows
Long	iShipper
Long	iSelectedRow

szCondition = ""

If sle_date1.text > " " then
	dDate				= Date(sle_date1.text)
//	szSelectDate	= "date ('" + String(dDate, "yyyy/mm/dd") + "')"
	szSelectDate	= "datetime (date('" + String(dDate) + "'),time('00:00:00'))"	
	szCondition		= szCondition + "date_stamp >= " + szSelectDate
End If

If sle_date2.text > " " then
	dDate				= Date(sle_date2.text)
	szSelectDate	= "datetime (date('" + String(dDate) + "'),time('23:59:59'))"
	If szCondition > " " then
		szCondition = szCondition + " and "
	End If
	szCondition		= szCondition + "date_stamp <= " + szSelectDate
End If

If sle_customer1.text > " " then
	If szCondition > " " then
		szCondition = szCondition + " AND "
	End If
	szCondition	= szCondition + " destination >= '" + sle_customer1.text + "'"
End If

If sle_customer2.text > " " then
	If szCondition > " " then
		szCondition = szCondition + " and "
	End If
	szCondition	= szCondition + " destination <= '" + sle_customer2.text + "'"
End If

If sle_ship_via1.text > " " then
	If szCondition > " " then
		szCondition = szCondition + " AND "
	End If
	szCondition	= szCondition + " ship_via >= '" + sle_ship_via1.text + "'"
End If

If sle_ship_via2.text > " " then
	If szCondition > " " then
		szCondition = szCondition + " AND "
	End If
	szCondition	= szCondition + " ship_via <= '" + sle_ship_via2.text + "'"
End If

dw_shipper.SetFilter(szCondition)

dw_shipper.Filter()

iTotalRows = dw_shipper.RowCount()

If iTotalRows > 0 then

	stProgress.title	= "Batch Printing Picklists"
	OpenWithParm(w_progress, stProgress)
	
	For iRow = 1 to iTotalRows
		iShipper	= dw_shipper.GetItemNumber(iRow, "id")
		w_progress.wf_progress(iRow / iTotalRows, "Printing Picklist for Shipper " + String(iShipper))
		stParm.value1	= String(iShipper)
		stParm.value2	= "PRINT"
		OpenWithParm(w_preview_picklist, stParm)
	Next

	Close(w_progress)
Else
	MessageBox("Warning", "No picklist is found for the search condition.", StopSign!)
End If




end event

type st_9 from statictext within w_batch_printing_picklists
int X=110
int Y=432
int Width=288
int Height=72
boolean Enabled=false
string Text="Ship Via"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_ship_via1 from singlelineedit within w_batch_printing_picklists
int X=713
int Y=432
int Width=475
int Height=80
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

type sle_ship_via2 from singlelineedit within w_batch_printing_picklists
int X=1335
int Y=432
int Width=475
int Height=80
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_batch_printing_picklists
int X=494
int Y=432
int Width=165
int Height=64
boolean Enabled=false
string Text="From"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_batch_printing_picklists
int X=1225
int Y=432
int Width=91
int Height=64
boolean Enabled=false
string Text="To"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_batch_printing_picklists
int X=1225
int Y=304
int Width=91
int Height=64
boolean Enabled=false
string Text="To"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_batch_printing_picklists
int X=494
int Y=304
int Width=165
int Height=64
boolean Enabled=false
string Text="From"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_batch_printing_picklists
int X=494
int Y=176
int Width=165
int Height=64
boolean Enabled=false
string Text="From"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_customer2 from singlelineedit within w_batch_printing_picklists
int X=1335
int Y=304
int Width=475
int Height=80
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

type sle_customer1 from singlelineedit within w_batch_printing_picklists
int X=713
int Y=304
int Width=475
int Height=80
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

type st_3 from statictext within w_batch_printing_picklists
int X=110
int Y=304
int Width=338
int Height=72
boolean Enabled=false
string Text="Destination"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date2 from singlelineedit within w_batch_printing_picklists
int X=1335
int Y=176
int Width=475
int Height=80
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

type st_2 from statictext within w_batch_printing_picklists
int X=1225
int Y=176
int Width=91
int Height=64
boolean Enabled=false
string Text="To"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date1 from singlelineedit within w_batch_printing_picklists
int X=713
int Y=176
int Width=475
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_batch_printing_picklists
int X=110
int Y=176
int Width=146
int Height=64
boolean Enabled=false
string Text="Date"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

