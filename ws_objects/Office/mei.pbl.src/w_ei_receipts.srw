$PBExportHeader$w_ei_receipts.srw
$PBExportComments$updated on 5/20
forward
global type w_ei_receipts from Window
end type
type rb_3 from radiobutton within w_ei_receipts
end type
type st_1 from statictext within w_ei_receipts
end type
type rb_2 from radiobutton within w_ei_receipts
end type
type rb_1 from radiobutton within w_ei_receipts
end type
type cb_1 from commandbutton within w_ei_receipts
end type
type part_cost from datawindow within w_ei_receipts
end type
type p_1 from picture within w_ei_receipts
end type
type dw_1 from datawindow within w_ei_receipts
end type
end forward

global type w_ei_receipts from Window
int X=19
int Y=29
int Width=2839
int Height=1825
boolean TitleBar=true
string Title="Receipts"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_3 rb_3
st_1 st_1
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
part_cost part_cost
p_1 p_1
dw_1 dw_1
end type
global w_ei_receipts w_ei_receipts

event open;String szType
szType = "R"

dw_1.settransobject ( sqlca )
dw_1.Retrieve (szType)

part_cost.settransobject ( sqlca )
part_cost.Retrieve ()
end event

on w_ei_receipts.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_3=create rb_3
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.part_cost=create part_cost
this.p_1=create p_1
this.dw_1=create dw_1
this.Control[]={ this.rb_3,&
this.st_1,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.part_cost,&
this.p_1,&
this.dw_1}
end on

on w_ei_receipts.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_3)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.part_cost)
destroy(this.p_1)
destroy(this.dw_1)
end on

type rb_3 from radiobutton within w_ei_receipts
int X=2295
int Y=1385
int Width=476
int Height=73
string Text="Area chart"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;String szType
szType = "R"

dw_1.dataObject	= "dw_ei_receipts_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(szType)
p_1.visible = false
end event

type st_1 from statictext within w_ei_receipts
int X=2295
int Y=1097
int Width=453
int Height=105
boolean Enabled=false
string Text="Select Type ....."
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial Narrow"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_ei_receipts
int X=2295
int Y=1301
int Width=439
int Height=73
string Text="Pie chart"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;String szType
szType = "R"

dw_1.dataObject	= "dw_ei_receipts_line2"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(szType)
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_receipts
int X=2295
int Y=1217
int Width=467
int Height=73
string Text="Bar chart"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;String szType
szType = "R"

dw_1.dataObject	= "dw_ei_receipts_line1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(szType)
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_receipts
int X=2337
int Y=1485
int Width=444
int Height=113
int TabOrder=30
string Text="&Exit"
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type part_cost from datawindow within w_ei_receipts
int X=42
int Y=1065
int Width=2213
int Height=569
int TabOrder=20
string DataObject="dw_ei_po_part_receive_$"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type p_1 from picture within w_ei_receipts
int X=46
int Y=33
int Width=2716
int Height=1021
string PictureName="rec.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_receipts
int X=37
int Y=29
int Width=2721
int Height=1033
int TabOrder=10
string DataObject="dw_ei_receipts_line"
boolean TitleBar=true
string Title="Receipt Record"
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

