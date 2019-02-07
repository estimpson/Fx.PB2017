$PBExportHeader$w_view_objects_onhand_and_at_vendor.srw
forward
global type w_view_objects_onhand_and_at_vendor from Window
end type
type cb_1 from commandbutton within w_view_objects_onhand_and_at_vendor
end type
type dw_objects_at_vendor from datawindow within w_view_objects_onhand_and_at_vendor
end type
type dw_objects_onhand from datawindow within w_view_objects_onhand_and_at_vendor
end type
type sle_qty_vendor from singlelineedit within w_view_objects_onhand_and_at_vendor
end type
type st_4 from statictext within w_view_objects_onhand_and_at_vendor
end type
type sle_qty from singlelineedit within w_view_objects_onhand_and_at_vendor
end type
type st_3 from statictext within w_view_objects_onhand_and_at_vendor
end type
type st_2 from statictext within w_view_objects_onhand_and_at_vendor
end type
type sle_vendor from singlelineedit within w_view_objects_onhand_and_at_vendor
end type
type sle_part from singlelineedit within w_view_objects_onhand_and_at_vendor
end type
type st_1 from statictext within w_view_objects_onhand_and_at_vendor
end type
type gb_3 from groupbox within w_view_objects_onhand_and_at_vendor
end type
type gb_2 from groupbox within w_view_objects_onhand_and_at_vendor
end type
type gb_1 from groupbox within w_view_objects_onhand_and_at_vendor
end type
end forward

global type w_view_objects_onhand_and_at_vendor from Window
int X=0
int Y=0
int Width=2926
int Height=1888
boolean TitleBar=true
string Title="Part Information"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_objects_at_vendor dw_objects_at_vendor
dw_objects_onhand dw_objects_onhand
sle_qty_vendor sle_qty_vendor
st_4 st_4
sle_qty sle_qty
st_3 st_3
st_2 st_2
sle_vendor sle_vendor
sle_part sle_part
st_1 st_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_view_objects_onhand_and_at_vendor w_view_objects_onhand_and_at_vendor

type variables
st_generic_structure stParm

String szPart                    //Part number
String szVendor               //Vendor code
end variables

forward prototypes
public function decimal wf_get_qty_at_vendor (string szpart, string szvendor)
public function decimal wf_get_qty_available (string szpart)
end prototypes

public function decimal wf_get_qty_at_vendor (string szpart, string szvendor);Decimal nQty

  SELECT sum(object.std_quantity )  
    INTO :nQty  
    FROM object  
   WHERE ( object.part = :szPart ) AND  
         ( object.destination = :szVendor )   ;

Return f_get_value(nQty)

end function

public function decimal wf_get_qty_available (string szpart);Decimal nQty
Decimal nOnHand
 
SELECT sum(object.std_quantity )  
  INTO :nQty  
  FROM object  
 WHERE ( object.part = :szPart ) AND  
       ( object.destination > ' ' )   ;

nOnHand	= f_get_value(Dec(f_get_part_info(szPart, "ON HAND")))

Return  nOnHand - f_get_value(nQty)



end function

on open;//************************************************************************
//* Declaration
//************************************************************************
String szModString		//String in dwModify
String szOriginalSelect	//Original select in datawindow
String szWhereClause		//The where clause in SQL Select
String szRetString		//The return string for dwModify

dw_objects_onhand.SetTransObject(sqlca)
dw_objects_at_vendor.SetTransObject(sqlca)

//************************************************************************
//* Initialization
//************************************************************************
stParm	= Message.PowerObjectParm

szPart	= stParm.Value1
szVendor	= stParm.Value2

//************************************************************************
//* Main Routine
//************************************************************************

//szOriginalSelect	= dw_objects_onhand.dwDescribe("DataWindow.Table.Select")
//szWhereClause		= " WHERE part = :szPart"
//
//szModString			= "DataWindow.Table.Select = " + szOriginalSelect + szWhereClause
//
//szRetString			= dw_objects_onhand.dwModify(szModString)
//
//If szRetString = "" then
//	dw_objects_onhand.Retrieve(szPart)
//Else
//	MessageBox("Status", "dwModify Failed" + szRetString)
//End If
//  

sle_part.text			= szPart
sle_vendor.text		= szVendor
sle_qty_vendor.text	= String(Truncate(wf_get_qty_at_vendor(szPart, szVendor), 2))
sle_qty.text			= String(Truncate(wf_get_qty_available(szPart), 2))

dw_objects_onhand.Retrieve(szPart)
dw_objects_at_vendor.Retrieve(szPart, szVendor)
end on

on w_view_objects_onhand_and_at_vendor.create
this.cb_1=create cb_1
this.dw_objects_at_vendor=create dw_objects_at_vendor
this.dw_objects_onhand=create dw_objects_onhand
this.sle_qty_vendor=create sle_qty_vendor
this.st_4=create st_4
this.sle_qty=create sle_qty
this.st_3=create st_3
this.st_2=create st_2
this.sle_vendor=create sle_vendor
this.sle_part=create sle_part
this.st_1=create st_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.dw_objects_at_vendor,&
this.dw_objects_onhand,&
this.sle_qty_vendor,&
this.st_4,&
this.sle_qty,&
this.st_3,&
this.st_2,&
this.sle_vendor,&
this.sle_part,&
this.st_1,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_view_objects_onhand_and_at_vendor.destroy
destroy(this.cb_1)
destroy(this.dw_objects_at_vendor)
destroy(this.dw_objects_onhand)
destroy(this.sle_qty_vendor)
destroy(this.st_4)
destroy(this.sle_qty)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_vendor)
destroy(this.sle_part)
destroy(this.st_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_view_objects_onhand_and_at_vendor
int X=2560
int Y=1632
int Width=247
int Height=108
int TabOrder=100
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type dw_objects_at_vendor from datawindow within w_view_objects_onhand_and_at_vendor
int X=1445
int Y=496
int Width=1353
int Height=1072
int TabOrder=90
string DataObject="dw_objects_at_vendor"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_objects_onhand from datawindow within w_view_objects_onhand_and_at_vendor
int X=55
int Y=496
int Width=1353
int Height=1072
int TabOrder=70
string DataObject="dw_objects_in_warehouse"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type sle_qty_vendor from singlelineedit within w_view_objects_onhand_and_at_vendor
int X=1975
int Y=240
int Width=494
int Height=80
int TabOrder=50
boolean Enabled=false
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

type st_4 from statictext within w_view_objects_onhand_and_at_vendor
int X=1591
int Y=240
int Width=379
int Height=64
boolean Enabled=false
string Text="Qty at Vendor:"
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

type sle_qty from singlelineedit within w_view_objects_onhand_and_at_vendor
int X=1975
int Y=144
int Width=494
int Height=80
int TabOrder=30
boolean Enabled=false
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

type st_3 from statictext within w_view_objects_onhand_and_at_vendor
int X=1591
int Y=144
int Width=366
int Height=64
boolean Enabled=false
string Text="Available Qty:"
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

type st_2 from statictext within w_view_objects_onhand_and_at_vendor
int X=384
int Y=240
int Width=219
int Height=64
boolean Enabled=false
string Text="Vendor:"
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

type sle_vendor from singlelineedit within w_view_objects_onhand_and_at_vendor
int X=677
int Y=240
int Width=494
int Height=80
int TabOrder=40
boolean Enabled=false
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

type sle_part from singlelineedit within w_view_objects_onhand_and_at_vendor
int X=677
int Y=144
int Width=494
int Height=80
int TabOrder=20
boolean Enabled=false
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

type st_1 from statictext within w_view_objects_onhand_and_at_vendor
int X=384
int Y=144
int Width=146
int Height=64
boolean Enabled=false
string Text="Part:"
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

type gb_3 from groupbox within w_view_objects_onhand_and_at_vendor
int X=1426
int Y=416
int Width=1390
int Height=1184
int TabOrder=80
string Text="Objects at Vendor"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_view_objects_onhand_and_at_vendor
int X=37
int Y=416
int Width=1390
int Height=1184
int TabOrder=60
string Text="Objects"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_view_objects_onhand_and_at_vendor
int X=37
int Y=48
int Width=2779
int Height=352
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

