$PBExportHeader$w_smart_po_objects.srw
$PBExportComments$List of objects for the smart po releases
forward
global type w_smart_po_objects from Window
end type
type cb_1 from commandbutton within w_smart_po_objects
end type
type st_3 from statictext within w_smart_po_objects
end type
type st_2 from statictext within w_smart_po_objects
end type
type st_1 from statictext within w_smart_po_objects
end type
type sle_min_onhand from singlelineedit within w_smart_po_objects
end type
type sle_onhand from singlelineedit within w_smart_po_objects
end type
type ddlb_plant from dropdownlistbox within w_smart_po_objects
end type
type dw_objects from datawindow within w_smart_po_objects
end type
end forward

global type w_smart_po_objects from Window
int X=361
int Y=292
int Width=2199
int Height=1336
boolean TitleBar=true
string Title="List of Objects"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_min_onhand sle_min_onhand
sle_onhand sle_onhand
ddlb_plant ddlb_plant
dw_objects dw_objects
end type
global w_smart_po_objects w_smart_po_objects

type variables
String szPart
String szPlant
end variables

forward prototypes
public function decimal wf_get_onhand_for_plant (string szplant, string szpart)
public subroutine wf_get_plants ()
public function decimal wf_get_min_on_hand (string szplant, string szpart)
end prototypes

public function decimal wf_get_onhand_for_plant (string szplant, string szpart);Decimal nOnHand

nOnHand	= 0

If szPlant	= "All" then
	SELECT sum(object.std_quantity )  
	  INTO :nOnHand  
	  FROM object  
	 WHERE (object.status 	= 'A')  
		AND (object.part		= :szPart);
Else
	SELECT sum(object.std_quantity )  
	  INTO :nOnHand  
	  FROM object  
	 WHERE (object.plant 	= :szPlant) 
		AND (object.status 	= 'A')  
		AND (object.part		= :szPart);
End If

Return f_get_value(nOnHand)


end function

public subroutine wf_get_plants ();String szCurrentPlant

ddlb_Plant.Reset()

Declare plantCur Cursor for Select Distinct Plant From Location Where Plant > ' ';

Open PlantCur;

Fetch PlantCur into :szCurrentplant;

Do while sqlca.sqlcode = 0
	ddlb_plant.AddItem(szCurrentplant)
	Fetch plantCur into :szCurrentplant;
Loop

Close plantCur;

ddlb_plant.AddItem("All")	






end subroutine

public function decimal wf_get_min_on_hand (string szplant, string szpart);Decimal nMinOnHand

SELECT plant_part.min_onhand  
  INTO :nMinOnHand  
  FROM plant_part  
 WHERE ( plant_part.plant = :szPlant ) AND  
       ( plant_part.part = :szPart )   ;

Return Truncate(nMinOnHand, 0)
end function

on open;dw_objects.SetTransObject(sqlca)

szPart	= Message.StringParm

dw_objects.Retrieve(szPart)

ddlb_plant.text		= "All"

wf_get_plants()
sle_onhand.text		= String(Truncate(wf_get_onhand_for_plant("All", szPart), 0))
sle_min_onhand.text	= String(Truncate(wf_get_min_on_hand("All", szPart), 0))
end on

on deactivate;Close(w_smart_po_objects)
end on

on w_smart_po_objects.create
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_min_onhand=create sle_min_onhand
this.sle_onhand=create sle_onhand
this.ddlb_plant=create ddlb_plant
this.dw_objects=create dw_objects
this.Control[]={this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_min_onhand,&
this.sle_onhand,&
this.ddlb_plant,&
this.dw_objects}
end on

on w_smart_po_objects.destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_min_onhand)
destroy(this.sle_onhand)
destroy(this.ddlb_plant)
destroy(this.dw_objects)
end on

type cb_1 from commandbutton within w_smart_po_objects
int X=1847
int Y=1072
int Width=247
int Height=108
int TabOrder=50
string Text="E&xit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(w_smart_po_objects)
end on

type st_3 from statictext within w_smart_po_objects
int X=1481
int Y=64
int Width=325
int Height=64
boolean Enabled=false
string Text="Min OnHand"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_smart_po_objects
int X=859
int Y=64
int Width=233
int Height=64
boolean Enabled=false
string Text="On Hand"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_smart_po_objects
int X=73
int Y=64
int Width=165
int Height=64
boolean Enabled=false
string Text="Plant"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_min_onhand from singlelineedit within w_smart_po_objects
int X=1829
int Y=48
int Width=247
int Height=88
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_onhand from singlelineedit within w_smart_po_objects
int X=1115
int Y=48
int Width=247
int Height=88
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_plant from dropdownlistbox within w_smart_po_objects
int X=256
int Y=48
int Width=475
int Height=480
int TabOrder=10
string Text="All"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All"}
end type

on selectionchanged;If this.text	= "All" then
	dw_objects.DataObject	= "dw_smart_objects_query"
	dw_objects.SetTransObject(sqlca)
	dw_objects.BringToTop	= TRUE
	dw_objects.Retrieve(szPart)
Else
	dw_objects.DataObject	= "dw_smart_objects_query_per_plant"
	dw_objects.SetTransObject(sqlca)
	dw_objects.BringToTop	= TRUE
	dw_objects.Retrieve(szPart, this.text)
End If

sle_onhand.text		= String(Truncate(wf_get_onhand_for_plant(this.text, szPart), 0))

sle_min_onhand.text	= String(Truncate(wf_get_min_on_hand(this.text, szPart), 0))
end on

type dw_objects from datawindow within w_smart_po_objects
int X=73
int Y=160
int Width=2011
int Height=864
int TabOrder=40
string DataObject="dw_smart_objects_query"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

