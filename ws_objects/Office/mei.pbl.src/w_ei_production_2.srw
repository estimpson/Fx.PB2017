$PBExportHeader$w_ei_production_2.srw
forward
global type w_ei_production_2 from Window
end type
type rb_1 from radiobutton within w_ei_production_2
end type
type rb_5 from radiobutton within w_ei_production_2
end type
type rb_4 from radiobutton within w_ei_production_2
end type
type rb_3 from radiobutton within w_ei_production_2
end type
type rb_2 from radiobutton within w_ei_production_2
end type
type cb_1 from commandbutton within w_ei_production_2
end type
type dw_1 from datawindow within w_ei_production_2
end type
end forward

global type w_ei_production_2 from Window
int X=19
int Y=21
int Width=2844
int Height=1829
boolean TitleBar=true
string Title="Production Today"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_1 rb_1
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_production_2 w_ei_production_2

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )


end on

on w_ei_production_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_1=create rb_1
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.rb_1,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.cb_1,&
this.dw_1}
end on

on w_ei_production_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_1)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type rb_1 from radiobutton within w_ei_production_2
int X=33
int Y=1321
int Width=951
int Height=97
string Text="Production by Machine"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_production_day_machine"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_5 from radiobutton within w_ei_production_2
int X=33
int Y=1417
int Width=951
int Height=97
string Text="Production by Activity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_production_day_activity"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_4 from radiobutton within w_ei_production_2
int X=1148
int Y=1481
int Width=860
int Height=97
string Text="Production by Tool"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_production_day_tool"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_production_2
int X=33
int Y=1513
int Width=951
int Height=97
string Text="Production by Group"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_production_day_part_group"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_production_2
int X=1148
int Y=1385
int Width=860
int Height=97
string Text="Production by Part"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_production_part_01"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type cb_1 from commandbutton within w_ei_production_2
int X=2135
int Y=1457
int Width=490
int Height=137
int TabOrder=20
string Text="&Exit"
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_1 from datawindow within w_ei_production_2
int X=37
int Y=33
int Width=2753
int Height=1277
int TabOrder=10
string DataObject="dw_ei_production_day_part"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

