$PBExportHeader$w_shop_defects_gr.srw
$PBExportComments$Defect Graph
forward
global type w_shop_defects_gr from Window
end type
type cb_1 from commandbutton within w_shop_defects_gr
end type
type dw_defects_graph from datawindow within w_shop_defects_gr
end type
type cb_exit from commandbutton within w_shop_defects_gr
end type
end forward

global type w_shop_defects_gr from Window
int X=635
int Y=320
int Width=2999
int Height=1856
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_1 cb_1
dw_defects_graph dw_defects_graph
cb_exit cb_exit
end type
global w_shop_defects_gr w_shop_defects_gr

type variables
n_cst_associative_array incst_aa
end variables

event open;/////////////////////////////////////////////////////////////////////
//
//  dispaly the first defect graph.. grab todays date 
//  and the current machine no. for the retrieve arg 
//
Date		todays_date
DateTime	today_begin,&
		today_end
string	ls_machine
string	ls_part		
incst_aa = Message.powerobjectparm
ls_machine = incst_aa.of_getitem("machine")
ls_part = incst_aa.of_getitem("part")

todays_date = today ()

today_begin = DateTime ( todays_date, Time ( "00:00" ) )
today_end   = DateTime ( todays_date, Time ( "23:59" ) )

dw_defects_graph.settransobject ( sqlca )
dw_defects_graph.retrieve (ls_machine, ls_part, today_begin, today_end )
end event

on w_shop_defects_gr.create
this.cb_1=create cb_1
this.dw_defects_graph=create dw_defects_graph
this.cb_exit=create cb_exit
this.Control[]={this.cb_1,&
this.dw_defects_graph,&
this.cb_exit}
end on

on w_shop_defects_gr.destroy
destroy(this.cb_1)
destroy(this.dw_defects_graph)
destroy(this.cb_exit)
end on

type cb_1 from commandbutton within w_shop_defects_gr
int X=1463
int Y=1408
int Width=667
int Height=224
int TabOrder=30
string Text="Historical Trends"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//open (w_shop_defects_gr_all)
openwithparm(w_shop_defects_gr_all, incst_aa)


end event

type dw_defects_graph from datawindow within w_shop_defects_gr
int X=73
int Y=64
int Width=2743
int Height=1280
int TabOrder=10
string DataObject="dw_defects_graph"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_exit from commandbutton within w_shop_defects_gr
int X=2414
int Y=1408
int Width=475
int Height=224
int TabOrder=20
string Text="Exit"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (w_shop_defects_gr)
end on

