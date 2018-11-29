$PBExportHeader$w_preview_picklist.srw
forward
global type w_preview_picklist from Window
end type
type st_form from statictext within w_preview_picklist
end type
type cb_2 from commandbutton within w_preview_picklist
end type
type cb_1 from commandbutton within w_preview_picklist
end type
type dw_picklist from datawindow within w_preview_picklist
end type
end forward

global type w_preview_picklist from Window
int X=0
int Y=0
int Width=2926
int Height=1960
boolean TitleBar=true
string Title="Preview of Pick List"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_form st_form
cb_2 cb_2
cb_1 cb_1
dw_picklist dw_picklist
end type
global w_preview_picklist w_preview_picklist

event open;DataWindow ldw1

Long 		iShipper
Long		iSelectedRow

String	szFormName
String   szDataWindowName
String	szMode

st_generic_structure stParm

dw_picklist.SetTransObject(sqlca)

stParm	= Message.PowerObjectParm
iShipper	= Long(stParm.Value1)
szMode	= stParm.Value2

szFormName	= "Pick List"		
	
SELECT   object_name  
  INTO 	:szDataWindowName  
  FROM 	report_library  
  WHERE  name = :szFormname   ;

	If Trim(szDataWindowName) <= " " then
		If MessageBox(	"Warning", "No form assigned for picking list,~r" + &
							"Do you want use standard form", Question!, OkCancel!) = 2 then
			close(this)
			Return
		End If

	Else
		dw_picklist.DataObject	= szDataWindowName
		dw_picklist.SetTransObject(sqlca)
	End If

	dw_picklist.Modify("DataWindow.Print.Preview = yes")
	dw_picklist.Modify("DataWindow.Print.Preview.Zoom = 65")

	dw_picklist.Retrieve(stparm.value1)

	st_form.text	= "Form Name:(" + dw_picklist.DataObject + ")"

	If szMode = "PRINT" then
		dw_picklist.Print()
		ldw1	= w_list_of_active_shippers.dw_shipping_dock

		iSelectedRow = ldw1.Find("id = " + String(iShipper), 1, 99999)

		If iSelectedRow > 0 then
			w_list_of_active_shippers.iShipper		= ldw1.GetItemNumber(iSelectedRow, "id")
			w_list_of_active_shippers.iSelectedRow	= iSelectedRow
			w_list_of_active_shippers.wf_picklist_print_status()		//Set print flag
		End If

		Close(this)

	End If


end event

on w_preview_picklist.create
this.st_form=create st_form
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_picklist=create dw_picklist
this.Control[]={this.st_form,&
this.cb_2,&
this.cb_1,&
this.dw_picklist}
end on

on w_preview_picklist.destroy
destroy(this.st_form)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_picklist)
end on

type st_form from statictext within w_preview_picklist
int X=1760
int Y=24
int Width=928
int Height=72
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_preview_picklist
int X=2441
int Y=1664
int Width=256
int Height=108
int TabOrder=30
string Text="Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_preview_picklist
int X=2002
int Y=1664
int Width=247
int Height=108
int TabOrder=20
string Text="Print"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Integer iJob

//iJob	= PrintOpen()
//PrintDataWindow(iJob, dw_picklist)
//PrintClose(iJob)

dw_picklist.Print()

MessageBox("System Message", "pick list has been printed")
w_list_of_active_shippers.wf_picklist_print_status()		//Set print flag
Close(parent)
end on

type dw_picklist from datawindow within w_preview_picklist
int X=137
int Y=128
int Width=2551
int Height=1504
int TabOrder=10
string DataObject="d_default_picklist"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

