$PBExportHeader$w_show_legend.srw
forward
global type w_show_legend from Window
end type
type cbx_job from checkbox within w_show_legend
end type
type cbx_bom from checkbox within w_show_legend
end type
type cbx_operator from checkbox within w_show_legend
end type
type sle_serial from singlelineedit within w_show_legend
end type
type st_3 from statictext within w_show_legend
end type
type ddlb_selection from dropdownlistbox within w_show_legend
end type
type st_2 from statictext within w_show_legend
end type
type sle_time_span from singlelineedit within w_show_legend
end type
type st_1 from statictext within w_show_legend
end type
type uo_legend from u_transaction_graph within w_show_legend
end type
type gb_1 from groupbox within w_show_legend
end type
end forward

global type w_show_legend from Window
int X=5
int Y=85
int Width=970
int Height=1137
boolean Visible=false
boolean TitleBar=true
string Title="Transaction Information"
long BackColor=12632256
WindowType WindowType=popup!
cbx_job cbx_job
cbx_bom cbx_bom
cbx_operator cbx_operator
sle_serial sle_serial
st_3 st_3
ddlb_selection ddlb_selection
st_2 st_2
sle_time_span sle_time_span
st_1 st_1
uo_legend uo_legend
gb_1 gb_1
end type
global w_show_legend w_show_legend

type variables
Window i_w_ParentWindow
end variables

forward prototypes
public subroutine wf_assign_parent_window (window l_w_parentwindow)
end prototypes

public subroutine wf_assign_parent_window (window l_w_parentwindow);i_w_ParentWindow			= l_w_ParentWindow
w_show_legend.Visible	= TRUE
i_w_ParentWindow.TriggerEvent("ue_draw_tree")

end subroutine

on w_show_legend.create
this.cbx_job=create cbx_job
this.cbx_bom=create cbx_bom
this.cbx_operator=create cbx_operator
this.sle_serial=create sle_serial
this.st_3=create st_3
this.ddlb_selection=create ddlb_selection
this.st_2=create st_2
this.sle_time_span=create sle_time_span
this.st_1=create st_1
this.uo_legend=create uo_legend
this.gb_1=create gb_1
this.Control[]={ this.cbx_job,&
this.cbx_bom,&
this.cbx_operator,&
this.sle_serial,&
this.st_3,&
this.ddlb_selection,&
this.st_2,&
this.sle_time_span,&
this.st_1,&
this.uo_legend,&
this.gb_1}
end on

on w_show_legend.destroy
destroy(this.cbx_job)
destroy(this.cbx_bom)
destroy(this.cbx_operator)
destroy(this.sle_serial)
destroy(this.st_3)
destroy(this.ddlb_selection)
destroy(this.st_2)
destroy(this.sle_time_span)
destroy(this.st_1)
destroy(this.uo_legend)
destroy(this.gb_1)
end on

type cbx_job from checkbox within w_show_legend
int X=641
int Y=929
int Width=275
int Height=73
string Text="Job #"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_ParentWindow.TriggerEvent("ue_verify_job")
end on

type cbx_bom from checkbox within w_show_legend
int X=641
int Y=865
int Width=275
int Height=73
string Text="Bill of Mat"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_ParentWindow.TriggerEvent("ue_verify_bom")
end on

type cbx_operator from checkbox within w_show_legend
int X=641
int Y=801
int Width=289
int Height=73
string Text="Operator"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_ParentWindow.TriggerEvent("ue_verify_operator")

end on

type sle_serial from singlelineedit within w_show_legend
int X=348
int Y=941
int Width=257
int Height=81
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;i_w_ParentWindow.TriggerEvent("ue_serial_scan")
end on

type st_3 from statictext within w_show_legend
int X=19
int Y=929
int Width=302
int Height=73
boolean Enabled=false
string Text="Serial #:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_selection from dropdownlistbox within w_show_legend
int X=348
int Y=833
int Width=257
int Height=217
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Part",&
"Date"}
end type

on selectionchanged;i_w_ParentWindow.TriggerEvent("ue_selection")
end on

type st_2 from statictext within w_show_legend
int X=19
int Y=833
int Width=289
int Height=73
boolean Enabled=false
string Text="Selection:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_time_span from singlelineedit within w_show_legend
int X=348
int Y=737
int Width=257
int Height=81
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;i_w_ParentWindow.TriggerEvent("ue_time_span")
end on

type st_1 from statictext within w_show_legend
int X=19
int Y=737
int Width=302
int Height=73
boolean Enabled=false
string Text="Time Span:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_legend from u_transaction_graph within w_show_legend
int X=1
int Y=1
int Width=897
int Height=721
int TabOrder=10
end type

on uo_legend.destroy
call u_transaction_graph::destroy
end on

type gb_1 from groupbox within w_show_legend
int X=622
int Y=721
int Width=330
int Height=289
int TabOrder=30
string Text="Verification"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

