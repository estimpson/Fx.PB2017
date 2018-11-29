$PBExportHeader$w_smart_po_recalc_window.srw
forward
global type w_smart_po_recalc_window from Window
end type
type dw_1 from datawindow within w_smart_po_recalc_window
end type
end forward

global type w_smart_po_recalc_window from Window
int X=673
int Y=265
int Width=2017
int Height=1061
boolean Visible=false
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_smart_po_recalc_window w_smart_po_recalc_window

on open;st_generic_structure stParm

Long iPO

String szPart

stParm	= Message.PowerObjectParm
iPo		= Long (stParm.value1)
szPart	= stParm.value2

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( iPo, szPart )
end on

on w_smart_po_recalc_window.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_smart_po_recalc_window.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_smart_po_recalc_window
int Width=1975
int Height=865
int TabOrder=1
string DataObject="d_smart_po_recalc_dw"
boolean VScrollBar=true
boolean LiveScroll=true
end type

