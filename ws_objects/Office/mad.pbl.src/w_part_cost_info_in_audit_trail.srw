$PBExportHeader$w_part_cost_info_in_audit_trail.srw
$PBExportComments$Retrieve cost info for raw material received for specified period of time~r~n(mad)
forward
global type w_part_cost_info_in_audit_trail from Window
end type
type cb_2 from commandbutton within w_part_cost_info_in_audit_trail
end type
type cb_1 from commandbutton within w_part_cost_info_in_audit_trail
end type
type st_3 from statictext within w_part_cost_info_in_audit_trail
end type
type sle_average_cost from singlelineedit within w_part_cost_info_in_audit_trail
end type
type sle_date2 from singlelineedit within w_part_cost_info_in_audit_trail
end type
type st_2 from statictext within w_part_cost_info_in_audit_trail
end type
type st_1 from statictext within w_part_cost_info_in_audit_trail
end type
type sle_date1 from singlelineedit within w_part_cost_info_in_audit_trail
end type
type dw_cost from datawindow within w_part_cost_info_in_audit_trail
end type
type gb_2 from groupbox within w_part_cost_info_in_audit_trail
end type
type gb_1 from groupbox within w_part_cost_info_in_audit_trail
end type
end forward

global type w_part_cost_info_in_audit_trail from Window
int X=352
int Y=368
int Width=2277
int Height=1352
boolean TitleBar=true
string Title="Cost Information in Audit Trail"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
cb_2 cb_2
cb_1 cb_1
st_3 st_3
sle_average_cost sle_average_cost
sle_date2 sle_date2
st_2 st_2
st_1 st_1
sle_date1 sle_date1
dw_cost dw_cost
gb_2 gb_2
gb_1 gb_1
end type
global w_part_cost_info_in_audit_trail w_part_cost_info_in_audit_trail

type variables
String szPart
end variables

on open;dw_cost.SetTransObject(sqlca)

szPart	= Message.StringParm
end on

on w_part_cost_info_in_audit_trail.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_average_cost=create sle_average_cost
this.sle_date2=create sle_date2
this.st_2=create st_2
this.st_1=create st_1
this.sle_date1=create sle_date1
this.dw_cost=create dw_cost
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_3,&
this.sle_average_cost,&
this.sle_date2,&
this.st_2,&
this.st_1,&
this.sle_date1,&
this.dw_cost,&
this.gb_2,&
this.gb_1}
end on

on w_part_cost_info_in_audit_trail.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_average_cost)
destroy(this.sle_date2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_date1)
destroy(this.dw_cost)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_part_cost_info_in_audit_trail
int X=1609
int Y=1104
int Width=247
int Height=108
int TabOrder=70
string Text="Save"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_part_cost_info_in_audit_trail
int X=1902
int Y=1104
int Width=247
int Height=108
int TabOrder=60
string Text="Exit"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type st_3 from statictext within w_part_cost_info_in_audit_trail
int X=1426
int Y=960
int Width=361
int Height=72
boolean Enabled=false
string Text="Average Cost"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_average_cost from singlelineedit within w_part_cost_info_in_audit_trail
int X=1810
int Y=960
int Width=311
int Height=88
int TabOrder=50
boolean AutoHScroll=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date2 from singlelineedit within w_part_cost_info_in_audit_trail
int X=768
int Y=960
int Width=247
int Height=88
int TabOrder=30
boolean AutoHScroll=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If sle_date2.text > " " AND sle_date1.text > " " then
	dw_cost.Retrieve(szPart, Date(sle_date1.text), Date(sle_date2.text))
	If dw_cost.RowCount() > 0 then
		If dw_cost.GetItemNumber(1, "total_std_qty") > 0 then
			sle_average_cost.text	= String(dw_cost.GetItemNumber(1, "total_cost") / dw_cost.GetItemNumber(1, "total_std_qty"))
		End If
	End If
End If
end on

type st_2 from statictext within w_part_cost_info_in_audit_trail
int X=658
int Y=960
int Width=91
int Height=64
boolean Enabled=false
string Text="To"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_part_cost_info_in_audit_trail
int X=110
int Y=960
int Width=274
int Height=64
boolean Enabled=false
string Text="Date From"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date1 from singlelineedit within w_part_cost_info_in_audit_trail
int X=384
int Y=960
int Width=247
int Height=88
int TabOrder=20
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If sle_date2.text > " " AND sle_date1.text > " " then
	dw_cost.Retrieve(szPart, Date(sle_date1.text), Date(sle_date2.text))
	If dw_cost.RowCount() > 0 then
		If dw_cost.GetItemNumber(1, "total_std_qty") > 0 then
			sle_average_cost.text	= String(dw_cost.GetItemNumber(1, "total_cost") / dw_cost.GetItemNumber(1, "total_std_qty"))
		End If
	End If
End If
end on

type dw_cost from datawindow within w_part_cost_info_in_audit_trail
int X=91
int Y=48
int Width=2066
int Height=896
int TabOrder=10
string DataObject="dw_cost_audit_trail_for_raw_material"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_2 from groupbox within w_part_cost_info_in_audit_trail
int X=91
int Y=912
int Width=951
int Height=160
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_part_cost_info_in_audit_trail
int X=1408
int Y=912
int Width=750
int Height=160
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

