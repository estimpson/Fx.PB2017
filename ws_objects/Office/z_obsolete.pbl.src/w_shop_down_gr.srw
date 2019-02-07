$PBExportHeader$w_shop_down_gr.srw
forward
global type w_shop_down_gr from Window
end type
type cb_1 from commandbutton within w_shop_down_gr
end type
type dw_downtime_graph from datawindow within w_shop_down_gr
end type
type cb_exit from commandbutton within w_shop_down_gr
end type
end forward

global type w_shop_down_gr from Window
int X=0
int Y=32
int Width=2999
int Height=1856
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_1 cb_1
dw_downtime_graph dw_downtime_graph
cb_exit cb_exit
end type
global w_shop_down_gr w_shop_down_gr

type variables
n_cst_associative_array incst_aa
end variables

event open;/////////////////////////////////////////////////////////////////////
//
//    get the downtime records.. use arg machine and today's date
// 
Date 		todays_date
DateTime	today_begin,&
		today_end
string	ls_machine		
incst_aa = message.powerobjectparm
ls_machine = incst_aa.of_getitem("machine")


todays_date = today ()
today_begin = DateTime ( todays_date, Time ( "00:00" ) )
today_end   = DateTime ( todays_date, Time ( "23:59" ) )

dw_downtime_graph.settransobject ( sqlca )
dw_downtime_graph.retrieve (ls_machine, today_begin, today_end )
end event

on w_shop_down_gr.create
this.cb_1=create cb_1
this.dw_downtime_graph=create dw_downtime_graph
this.cb_exit=create cb_exit
this.Control[]={this.cb_1,&
this.dw_downtime_graph,&
this.cb_exit}
end on

on w_shop_down_gr.destroy
destroy(this.cb_1)
destroy(this.dw_downtime_graph)
destroy(this.cb_exit)
end on

type cb_1 from commandbutton within w_shop_down_gr
int X=1390
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

event clicked;
openwithparm (w_shop_defects_gr_tot, incst_aa)
end event

type dw_downtime_graph from datawindow within w_shop_down_gr
int X=73
int Y=64
int Width=2743
int Height=1280
int TabOrder=10
string DataObject="dw_down_graph"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_exit from commandbutton within w_shop_down_gr
int X=2341
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

on clicked;close (w_shop_down_gr)
end on

