$PBExportHeader$w_scdatavalidation.srw
forward
global type w_scdatavalidation from Window
end type
type mdi_1 from mdiclient within w_scdatavalidation
end type
type dw_scdatavalidation from datawindow within w_scdatavalidation
end type
end forward

global type w_scdatavalidation from Window
int X=5
int Y=4
int Width=4681
int Height=3072
boolean TitleBar=true
string Title="SuperCop Data Validation"
string MenuName="m_scdv"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_print ( )
event ue_validate ( )
mdi_1 mdi_1
dw_scdatavalidation dw_scdatavalidation
end type
global w_scdatavalidation w_scdatavalidation

event ue_print;
dw_scdatavalidation.print ( )
end event

event ue_validate;string ls_part
setnull(ls_part ) 
//sqlca.autocommit = true
dw_scdatavalidation.retrieve ( ls_part )
//sqlca.autocommit = false
end event

on w_scdatavalidation.create
if this.MenuName = "m_scdv" then this.MenuID = create m_scdv
this.mdi_1=create mdi_1
this.dw_scdatavalidation=create dw_scdatavalidation
this.Control[]={this.mdi_1,&
this.dw_scdatavalidation}
end on

on w_scdatavalidation.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.dw_scdatavalidation)
end on

type mdi_1 from mdiclient within w_scdatavalidation
long BackColor=276856960
end type

type dw_scdatavalidation from datawindow within w_scdatavalidation
int X=27
int Y=160
int Width=3566
int Height=1980
int TabOrder=10
string DataObject="d_msp_scdatavalidation"
boolean TitleBar=true
string Title="SuperCop Data Validation Results"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
end type

event constructor;settransobject(sqlca)
end event

