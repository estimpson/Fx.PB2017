$PBExportHeader$w_part_type.srw
forward
global type w_part_type from Window
end type
type st_1 from statictext within w_part_type
end type
type cb_3 from commandbutton within w_part_type
end type
type ddlb_1 from dropdownlistbox within w_part_type
end type
type cb_2 from commandbutton within w_part_type
end type
type cb_1 from commandbutton within w_part_type
end type
type dw_1 from datawindow within w_part_type
end type
end forward

global type w_part_type from Window
int X=539
int Y=788
int Width=1147
int Height=544
boolean TitleBar=true
string Title="Search"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
cb_3 cb_3
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_part_type w_part_type

on w_part_type.create
this.st_1=create st_1
this.cb_3=create cb_3
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_3,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_part_type.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.retrieve()
dw_1.insertrow(0)

end event

event activate;//window created for filtering parts based on type -sm 5/23/00 original
f_center_window(w_part_type)
end event

type st_1 from statictext within w_part_type
int X=169
int Y=32
int Width=402
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Part Type:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_part_type
int X=549
int Y=344
int Width=265
int Height=88
int TabOrder=40
string Text="Display All"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent, 'all')
end event

type ddlb_1 from dropdownlistbox within w_part_type
int X=69
int Y=8
int Width=471
int Height=228
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"F",&
"R",&
"W"}
end type

type cb_2 from commandbutton within w_part_type
int X=841
int Y=344
int Width=265
int Height=88
int TabOrder=50
string Text="Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_part_type
int X=261
int Y=344
int Width=265
int Height=88
int TabOrder=20
string Text="Search"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_type

closewithreturn(parent,dw_1.gettext())
end event

type dw_1 from datawindow within w_part_type
int X=571
int Y=32
int Width=544
int Height=88
int TabOrder=30
boolean BringToTop=true
string DataObject="d_part_type"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;dw_1.settransobject(sqlca)
end event

