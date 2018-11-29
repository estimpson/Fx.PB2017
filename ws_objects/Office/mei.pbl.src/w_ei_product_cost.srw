$PBExportHeader$w_ei_product_cost.srw
forward
global type w_ei_product_cost from Window
end type
type p_2 from picture within w_ei_product_cost
end type
type st_1 from statictext within w_ei_product_cost
end type
type cb_1 from commandbutton within w_ei_product_cost
end type
type p_1 from picture within w_ei_product_cost
end type
type dw_2 from datawindow within w_ei_product_cost
end type
type dw_3 from datawindow within w_ei_product_cost
end type
type dw_1 from datawindow within w_ei_product_cost
end type
end forward

global type w_ei_product_cost from Window
int X=18
int Y=20
int Width=2843
int Height=1876
boolean TitleBar=true
string Title="Part Analysis"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
p_2 p_2
st_1 st_1
cb_1 cb_1
p_1 p_1
dw_2 dw_2
dw_3 dw_3
dw_1 dw_1
end type
global w_ei_product_cost w_ei_product_cost

type variables
String szWorkorder
end variables

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

end on

on w_ei_product_cost.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.p_2=create p_2
this.st_1=create st_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.Control[]={this.p_2,&
this.st_1,&
this.cb_1,&
this.p_1,&
this.dw_2,&
this.dw_3,&
this.dw_1}
end on

on w_ei_product_cost.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_1)
end on

type p_2 from picture within w_ei_product_cost
int X=334
int Y=1580
int Width=73
int Height=60
string PictureName="logobtn.bmp"
boolean FocusRectangle=false
end type

type st_1 from statictext within w_ei_product_cost
int X=425
int Y=1580
int Width=1134
int Height=76
boolean Enabled=false
string Text="Click any row to get the detail......."
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_ei_product_cost
int X=2309
int Y=1552
int Width=475
int Height=136
int TabOrder=40
string Text="&Exit"
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_ei_product_cost
int X=46
int Y=36
int Width=2720
int Height=1504
string PictureName="job.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event clicked;p_1.visible = false
end event

type dw_2 from datawindow within w_ei_product_cost
int X=37
int Y=32
int Width=1426
int Height=720
int TabOrder=20
string DataObject="dw_ei_job_cost_material"
boolean TitleBar=true
string Title="Details...."
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(SQLCA)
end event

type dw_3 from datawindow within w_ei_product_cost
int X=1463
int Y=32
int Width=1312
int Height=720
int TabOrder=30
string DataObject="dw_ei_job_cost_labor"
boolean TitleBar=true
string Title="Labor details...."
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(SQLCA)
end event

type dw_1 from datawindow within w_ei_product_cost
int X=41
int Y=752
int Width=2734
int Height=780
int TabOrder=10
string DataObject="dw_ei_job_cost_select"
boolean TitleBar=true
string Title="Job Cost....."
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event clicked;
/////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If ( row = 0 ) Then Return

Selectrow (dw_1 , 0 , false)
SelectRow (dw_1 , row , true)

szWorkorder = dw_1.GetItemString (Row, "work_order")

//dw_2.settransobject ( sqlca )
dw_2.Retrieve ( szWorkorder)

//dw_3.settransobject ( sqlca )
dw_3.Retrieve ( szWorkorder)
//
//dw_4.settransobject ( sqlca )
//dw_4.Retrieve ( szPart)
end event

