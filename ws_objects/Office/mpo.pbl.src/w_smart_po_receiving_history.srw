$PBExportHeader$w_smart_po_receiving_history.srw
forward
global type w_smart_po_receiving_history from Window
end type
type st_1 from statictext within w_smart_po_receiving_history
end type
type cb_1 from commandbutton within w_smart_po_receiving_history
end type
type dw_history from datawindow within w_smart_po_receiving_history
end type
end forward

global type w_smart_po_receiving_history from Window
int X=302
int Y=284
int Width=2313
int Height=1344
boolean TitleBar=true
string Title="Receiving History"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
st_1 st_1
cb_1 cb_1
dw_history dw_history
end type
global w_smart_po_receiving_history w_smart_po_receiving_history

event open;String	szPO
String	szPart

st_generic_structure stParm

dw_history.SetTransObject(sqlca)

stParm	= Message.PowerObjectParm

szPO		= stParm.value1
szPart	= stParm.value2

dw_history.Modify("quantity.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("date.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("serial.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("unit.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("shipper.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("operator.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("price.color = '0~tif(type =~~'V~~', 255, 0)'")
dw_history.Modify("cost.color = '0~tif(type =~~'V~~', 255, 0)'")

dw_history.Retrieve(szPO, szPart)

end event

on w_smart_po_receiving_history.create
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_history=create dw_history
this.Control[]={this.st_1,&
this.cb_1,&
this.dw_history}
end on

on w_smart_po_receiving_history.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_history)
end on

type st_1 from statictext within w_smart_po_receiving_history
int X=18
int Width=603
int Height=64
boolean Enabled=false
string Text="[Red]:Return to vendor"
boolean FocusRectangle=false
long TextColor=255
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_smart_po_receiving_history
int X=2011
int Y=1072
int Width=247
int Height=108
int TabOrder=20
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(w_smart_po_receiving_history)
end on

type dw_history from datawindow within w_smart_po_receiving_history
int X=18
int Y=80
int Width=2231
int Height=960
int TabOrder=10
string DataObject="dw_smart_po_receiving_history"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Long 	iRow
Long	iSerial

st_generic_structure stParm

iRow	= this.GetClickedRow()

If iRow > 0 then
	iSerial 			= this.GetItemNumber(iRow, 'serial')
	stParm.value1	= String(iSerial)
	OpenWithParm(w_audit_trail_genelogy_tree_for_class_p, stParm)
End If
end on

event clicked;STRING 	l_s_name

l_s_name = dw_history.GetObjectAtPointer ()
l_s_name = LeftA ( l_s_name, PosA ( l_s_name, "_t~t", 1 ) - 1)

dw_history.setsort ( l_s_name + ", A" )
dw_history.sort()
end event

