$PBExportHeader$w_mps_1.srw
forward
global type w_mps_1 from Window
end type
type st_1 from statictext within w_mps_1
end type
type rb_9 from radiobutton within w_mps_1
end type
type rb_8 from radiobutton within w_mps_1
end type
type rb_7 from radiobutton within w_mps_1
end type
type rb_6 from radiobutton within w_mps_1
end type
type rb_5 from radiobutton within w_mps_1
end type
type rb_4 from radiobutton within w_mps_1
end type
type rb_3 from radiobutton within w_mps_1
end type
type rb_2 from radiobutton within w_mps_1
end type
type rb_1 from radiobutton within w_mps_1
end type
type cb_1 from commandbutton within w_mps_1
end type
type p_1 from picture within w_mps_1
end type
type dw_2 from datawindow within w_mps_1
end type
end forward

global type w_mps_1 from Window
int X=28
int Y=21
int Width=2853
int Height=1857
boolean TitleBar=true
string Title="Monitor Capacity"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
st_1 st_1
rb_9 rb_9
rb_8 rb_8
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
p_1 p_1
dw_2 dw_2
end type
global w_mps_1 w_mps_1

forward prototypes
public subroutine wf_dw_retrieve (string arg_dw_name)
end prototypes

public subroutine wf_dw_retrieve (string arg_dw_name);	dw_2.dataObject	= arg_dw_name
	dw_2.SetTransObject(sqlca)
	dw_2.Retrieve()
	If sqlca.sqlcode = -1 then 
		Messagebox("System Error","Database Error")
		Return
	End if 	
	p_1.visible = false



end subroutine

event open;//dw_2.settransobject ( sqlca )
//dw_2.Retrieve ( )
end event

on w_mps_1.create
this.st_1=create st_1
this.rb_9=create rb_9
this.rb_8=create rb_8
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_2=create dw_2
this.Control[]={ this.st_1,&
this.rb_9,&
this.rb_8,&
this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.p_1,&
this.dw_2}
end on

on w_mps_1.destroy
destroy(this.st_1)
destroy(this.rb_9)
destroy(this.rb_8)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_2)
end on

type st_1 from statictext within w_mps_1
int X=51
int Y=1673
int Width=1413
int Height=57
boolean Enabled=false
string Text="Please allow 2 to 3 minutes to get the information....."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=15793151
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_9 from radiobutton within w_mps_1
int X=46
int Y=1457
int Width=769
int Height=65
int TabOrder=20
string Text="Setup Hours by Activity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_ei_mps_setup_activity"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_ei_mps_setup_activity")
end event

type rb_8 from radiobutton within w_mps_1
int X=887
int Y=1529
int Width=714
int Height=73
int TabOrder=60
string Text="Hours by Product Line"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_mps_product_line"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_mps_product_line")
end event

type rb_7 from radiobutton within w_mps_1
int X=1729
int Y=1601
int Width=714
int Height=73
int TabOrder=100
string Text="Hours by Activity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_mps_hours_activity"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_mps_hours_activity")

end event

type rb_6 from radiobutton within w_mps_1
int X=46
int Y=1601
int Width=769
int Height=65
int TabOrder=40
string Text="Setup Hours by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_ei_mps_setup_time_month"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_ei_mps_setup_time_month")
end event

type rb_5 from radiobutton within w_mps_1
int X=887
int Y=1457
int Width=769
int Height=65
int TabOrder=50
string Text="Machine Hours by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_ei_mps_machine_load_month"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_ei_mps_machine_load_month")
end event

type rb_4 from radiobutton within w_mps_1
int X=1729
int Y=1529
int Width=714
int Height=73
int TabOrder=90
string Text="Machine Load by Group"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_mps_group_gr_1"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_mps_group_gr_1")
end event

type rb_3 from radiobutton within w_mps_1
int X=46
int Y=1529
int Width=769
int Height=65
int TabOrder=30
string Text="Setup Time"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	dw_2.dataObject	= "dw_ei_mps_setup_gr_1"
//	dw_2.SetTransObject(sqlca)
//	dw_2.Retrieve()
//	p_1.visible = false
	
	wf_dw_retrieve("dw_ei_mps_setup_gr_1")
end event

type rb_2 from radiobutton within w_mps_1
int X=1729
int Y=1461
int Width=709
int Height=73
int TabOrder=80
string Text="Machine Load by Hours"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_mps_gr_1"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_mps_gr_1")
end event

type rb_1 from radiobutton within w_mps_1
int X=887
int Y=1609
int Width=769
int Height=65
int TabOrder=70
string Text="Machine Hours by Week"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.dataObject	= "dw_mps_daily_load_gr"
//dw_2.SetTransObject(sqlca)
//dw_2.Retrieve()
//p_1.visible = false

wf_dw_retrieve("dw_mps_daily_load_gr")
end event

type cb_1 from commandbutton within w_mps_1
int X=2478
int Y=1493
int Width=325
int Height=137
int TabOrder=10
string Text="&Exit"
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_mps_1
int X=42
int Y=41
int Width=2707
int Height=1385
string PictureName="cap.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_2 from datawindow within w_mps_1
int X=37
int Y=37
int Width=2721
int Height=1393
string DataObject="dw_mps_gr_1"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

