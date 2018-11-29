$PBExportHeader$w_display_objects_per_shipper.srw
forward
global type w_display_objects_per_shipper from Window
end type
type cb_1 from commandbutton within w_display_objects_per_shipper
end type
type dw_audit_trail from datawindow within w_display_objects_per_shipper
end type
type gb_1 from groupbox within w_display_objects_per_shipper
end type
end forward

global type w_display_objects_per_shipper from Window
int X=1
int Y=1
int Width=2926
int Height=1929
boolean TitleBar=true
string Title="List of objects shipped"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_audit_trail dw_audit_trail
gb_1 gb_1
end type
global w_display_objects_per_shipper w_display_objects_per_shipper

type variables
st_generic_structure stParm
end variables

on open;String szPart
String szShipper


dw_audit_trail.SetTransObject(sqlca)

stParm	= Message.PowerObjectParm

szPart	= stParm.value1
szShipper= stParm.value2

dw_audit_trail.Retrieve(szPart, szShipper)


end on

on w_display_objects_per_shipper.create
this.cb_1=create cb_1
this.dw_audit_trail=create dw_audit_trail
this.gb_1=create gb_1
this.Control[]={ this.cb_1,&
this.dw_audit_trail,&
this.gb_1}
end on

on w_display_objects_per_shipper.destroy
destroy(this.cb_1)
destroy(this.dw_audit_trail)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_display_objects_per_shipper
int X=2465
int Y=1665
int Width=247
int Height=109
int TabOrder=30
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(w_display_objects_per_shipper)

w_blanket_order.TriggerEvent ( "ue_set_dw" ) // This is to reset the window 







end on

type dw_audit_trail from datawindow within w_display_objects_per_shipper
int X=174
int Y=101
int Width=2469
int Height=1485
int TabOrder=20
string DataObject="dw_audit_trail_per_shipper"
boolean LiveScroll=true
end type

on doubleclicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	stParm.value1	= String(this.GetItemNumber(iRow, "serial"))
	OpenWithParm(w_audit_trail_genelogy_tree, stParm)
End If
	
end on

on clicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)
	stParm.value1	= String(this.GetItemNumber(iRow, "serial"))
	OpenWithParm(w_audit_trail_genelogy_tree, stParm)
End If

end on

type gb_1 from groupbox within w_display_objects_per_shipper
int X=101
int Y=21
int Width=2620
int Height=1597
int TabOrder=10
string Text="Double Click to view audit trail geneology tree"
BorderStyle BorderStyle=StyleLowered!
long TextColor=255
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

