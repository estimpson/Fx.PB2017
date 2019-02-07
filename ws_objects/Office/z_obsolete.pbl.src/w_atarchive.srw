$PBExportHeader$w_atarchive.srw
forward
global type w_atarchive from Window
end type
type dw_atarchive from datawindow within w_atarchive
end type
end forward

global type w_atarchive from Window
int X=1326
int Y=652
int Width=3205
int Height=2012
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_atarchive dw_atarchive
end type
global w_atarchive w_atarchive

on w_atarchive.create
this.dw_atarchive=create dw_atarchive
this.Control[]={this.dw_atarchive}
end on

on w_atarchive.destroy
destroy(this.dw_atarchive)
end on

event open;//date	ldt_startdt, ldt_enddt
//
//declare	Atarchive procedure for cdisp_archiveaudittrail 
//	:ldt_startdt,
//	:ldt_enddt
//using sqlca;
//
//sqlca.autocommit = true
//
//execute atarchive;
//
//close atarchive;
//sqlca.autocommit = false
//

sqlca.autocommit = true
dw_atarchive.retrieve()
sqlca.autocommit = false

end event

type dw_atarchive from datawindow within w_atarchive
int X=1093
int Y=524
int Width=686
int Height=500
int TabOrder=10
string DataObject="d_atarchive"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

