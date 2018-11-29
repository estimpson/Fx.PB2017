$PBExportHeader$w_ei_purchasing.srw
$PBExportComments$updated on 5/20
forward
global type w_ei_purchasing from Window
end type
type mdi_1 from mdiclient within w_ei_purchasing
end type
type st_3 from statictext within w_ei_purchasing
end type
type ddlb_1 from dropdownlistbox within w_ei_purchasing
end type
type st_2 from statictext within w_ei_purchasing
end type
type st_1 from statictext within w_ei_purchasing
end type
type rb_4 from radiobutton within w_ei_purchasing
end type
type rb_3 from radiobutton within w_ei_purchasing
end type
type cb_2 from commandbutton within w_ei_purchasing
end type
type rb_2 from radiobutton within w_ei_purchasing
end type
type rb_1 from radiobutton within w_ei_purchasing
end type
type cb_1 from commandbutton within w_ei_purchasing
end type
type p_1 from picture within w_ei_purchasing
end type
type dw_1 from datawindow within w_ei_purchasing
end type
type dw_2 from datawindow within w_ei_purchasing
end type
end forward

global type w_ei_purchasing from Window
int X=37
int Y=37
int Width=2867
int Height=1845
boolean TitleBar=true
string Title="Purchasing"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdi!
mdi_1 mdi_1
st_3 st_3
ddlb_1 ddlb_1
st_2 st_2
st_1 st_1
rb_4 rb_4
rb_3 rb_3
cb_2 cb_2
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
p_1 p_1
dw_1 dw_1
dw_2 dw_2
end type
global w_ei_purchasing w_ei_purchasing

event open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
//p_1.settransobject ( sqlca )
//p_1.Retrieve ( )
//dw_2.settransobject ( sqlca )
//dw_2.Retrieve ( )
//dw_3.settransobject ( sqlca )
//dw_3.Retrieve ( )
end event

on w_ei_purchasing.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_4=create rb_4
this.rb_3=create rb_3
this.cb_2=create cb_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={ this.mdi_1,&
this.st_3,&
this.ddlb_1,&
this.st_2,&
this.st_1,&
this.rb_4,&
this.rb_3,&
this.cb_2,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.p_1,&
this.dw_1,&
this.dw_2}
end on

on w_ei_purchasing.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.cb_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type mdi_1 from mdiclient within w_ei_purchasing
long BackColor=16711680
end type

type st_3 from statictext within w_ei_purchasing
int X=846
int Y=1401
int Width=545
int Height=77
boolean Enabled=false
string Text=" For Specific Month..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_ei_purchasing
int X=1395
int Y=1377
int Width=188
int Height=285
int TabOrder=40
boolean Sorted=false
boolean VScrollBar=true
int Accelerator=49
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"1",&
"2",&
"3",&
"4",&
"5",&
"6",&
"7",&
"8",&
"9",&
"10",&
"11",&
"12"}
end type

event selectionchanged;int i_mon

i_mon = integer(ddlb_1.text(index))

dw_1.dataObject	= "dw_ei_po_cash_req_month_1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(i_mon)
p_1.visible = false

end event

type st_2 from statictext within w_ei_purchasing
int X=1587
int Y=1393
int Width=705
int Height=73
boolean Enabled=false
string Text="Cash required by Week"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ei_purchasing
int X=106
int Y=1397
int Width=705
int Height=73
boolean Enabled=false
string Text="Cash required by Month"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_ei_purchasing
int X=1637
int Y=1541
int Width=691
int Height=73
string Text="Solid column chart"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_po_cash_req_line1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false

end event

type rb_3 from radiobutton within w_ei_purchasing
int X=142
int Y=1553
int Width=563
int Height=73
string Text="Area chart"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_po_cash_req_month1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false

end event

type cb_2 from commandbutton within w_ei_purchasing
int X=2378
int Y=1393
int Width=334
int Height=109
int TabOrder=30
string Text="&More..."
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_ei_purchasing_1)
end event

type rb_2 from radiobutton within w_ei_purchasing
int X=1637
int Y=1469
int Width=650
int Height=65
string Text="Area chart"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_po_cash_req_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false

end event

type rb_1 from radiobutton within w_ei_purchasing
int X=147
int Y=1481
int Width=572
int Height=65
string Text="Bar chart "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_po_cash_req_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false

end event

type cb_1 from commandbutton within w_ei_purchasing
int X=2378
int Y=1517
int Width=343
int Height=117
int TabOrder=20
string Text="&Exit"
boolean Cancel=true
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_ei_purchasing
int X=92
int Y=45
int Width=2675
int Height=1325
string PictureName="po.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_purchasing
int X=83
int Y=41
int Width=2689
int Height=1337
int TabOrder=10
boolean DragAuto=true
string DataObject="dw_ei_po_cash_req_line"
boolean TitleBar=true
string Title="Purchasing"
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MaxBox=true
end type

type dw_2 from datawindow within w_ei_purchasing
int X=92
int Y=49
int Width=2675
int Height=1321
int TabOrder=11
string DataObject="dw_ei_po_cash_req_month_1"
boolean LiveScroll=true
end type

