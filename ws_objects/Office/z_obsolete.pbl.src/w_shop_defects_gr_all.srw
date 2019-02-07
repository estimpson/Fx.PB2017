$PBExportHeader$w_shop_defects_gr_all.srw
forward
global type w_shop_defects_gr_all from Window
end type
type dw_defects_graph_1 from datawindow within w_shop_defects_gr_all
end type
type dw_defects_graph_2 from datawindow within w_shop_defects_gr_all
end type
type cb_exit from commandbutton within w_shop_defects_gr_all
end type
end forward

global type w_shop_defects_gr_all from Window
int X=635
int Y=320
int Width=2999
int Height=1856
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
dw_defects_graph_1 dw_defects_graph_1
dw_defects_graph_2 dw_defects_graph_2
cb_exit cb_exit
end type
global w_shop_defects_gr_all w_shop_defects_gr_all

event open;/////////////////////////////////////////////////////////////////////
//
//  dispaly the first defect graph.. grab todays date 
//  and the current machine no. for the retrieve arg 
//

Date todays_date
string	ls_machine
n_cst_associative_array lncst_aa

lncst_aa = message.powerobjectparm

ls_machine = lncst_aa.of_getitem("machine")

todays_date = today ()

dw_defects_graph_1.settransobject ( sqlca )
dw_defects_graph_1.retrieve (ls_machine)

dw_defects_graph_2.settransobject ( sqlca )
dw_defects_graph_2.retrieve (ls_machine) 



end event

on w_shop_defects_gr_all.create
this.dw_defects_graph_1=create dw_defects_graph_1
this.dw_defects_graph_2=create dw_defects_graph_2
this.cb_exit=create cb_exit
this.Control[]={this.dw_defects_graph_1,&
this.dw_defects_graph_2,&
this.cb_exit}
end on

on w_shop_defects_gr_all.destroy
destroy(this.dw_defects_graph_1)
destroy(this.dw_defects_graph_2)
destroy(this.cb_exit)
end on

type dw_defects_graph_1 from datawindow within w_shop_defects_gr_all
int X=1536
int Y=64
int Width=1353
int Height=960
int TabOrder=20
string DataObject="dw_defects_graph_1"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_defects_graph_2 from datawindow within w_shop_defects_gr_all
int X=73
int Y=64
int Width=1353
int Height=960
int TabOrder=10
string DataObject="dw_defects_graph_2"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_exit from commandbutton within w_shop_defects_gr_all
int X=2304
int Y=1408
int Width=475
int Height=224
int TabOrder=30
string Text="Exit"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (w_shop_defects_gr_all)
end on

