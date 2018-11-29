$PBExportHeader$w_ei_issues_2.srw
forward
global type w_ei_issues_2 from Window
end type
type rb_4 from radiobutton within w_ei_issues_2
end type
type rb_3 from radiobutton within w_ei_issues_2
end type
type rb_2 from radiobutton within w_ei_issues_2
end type
type rb_1 from radiobutton within w_ei_issues_2
end type
type cb_1 from commandbutton within w_ei_issues_2
end type
type dw_1 from datawindow within w_ei_issues_2
end type
end forward

global type w_ei_issues_2 from Window
int X=28
int Y=21
int Width=2725
int Height=1845
boolean TitleBar=true
string Title="Issues"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_issues_2 w_ei_issues_2

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

end on

on w_ei_issues_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.dw_1}
end on

on w_ei_issues_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type rb_4 from radiobutton within w_ei_issues_2
int X=46
int Y=1485
int Width=878
int Height=65
string Text="Issues by Employe"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_issues_cap_gr"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_issues_2
int X=46
int Y=1581
int Width=878
int Height=65
string Text="Issues by Catagory"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_issue_pie"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_issues_2
int X=1034
int Y=1581
int Width=988
int Height=65
string Text="Completed by Employee"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_issues_completed_employee"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_issues_2
int X=1034
int Y=1485
int Width=887
int Height=65
string Text="Issues by Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_issue_status_bar"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type cb_1 from commandbutton within w_ei_issues_2
int X=2081
int Y=1489
int Width=586
int Height=161
int TabOrder=20
string Text="Exit"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_1 from datawindow within w_ei_issues_2
int X=37
int Y=33
int Width=2579
int Height=1433
int TabOrder=10
string DataObject="dw_ei_issue_product_cat"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

