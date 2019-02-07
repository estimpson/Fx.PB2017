$PBExportHeader$w_list_of_order_details.srw
$PBExportComments$List of order details
forward
global type w_list_of_order_details from Window
end type
type cb_save from commandbutton within w_list_of_order_details
end type
type dw_order_details from datawindow within w_list_of_order_details
end type
end forward

global type w_list_of_order_details from Window
int X=379
int Y=376
int Width=2126
int Height=1136
boolean TitleBar=true
string Title="List of Order Details"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=popup!
cb_save cb_save
dw_order_details dw_order_details
end type
global w_list_of_order_details w_list_of_order_details

type variables
Private:

Window	i_w_HostWindow		//Host window
end variables

on open;/*
Description		:This window will display all the objects 
Author			:Jim Wu
Date				:12/22/95
Modification	:
*/

/* Declaration */
Long		l_i_Order
Long		l_i_RowId

st_generic_structure l_str_Parameters

dw_order_details.SetTransObject(SQLCA)

/* Initialization */
l_str_Parameters	= Message.PowerObjectParm

l_i_Order			= Long(l_str_Parameters.Value1)
l_i_RowId			= Long(l_str_Parameters.Value2)

/* Retrieve the data */
dw_order_details.Retrieve(l_i_Order, l_i_RowId)


end on

on deactivate;close(this)
end on

on w_list_of_order_details.create
this.cb_save=create cb_save
this.dw_order_details=create dw_order_details
this.Control[]={this.cb_save,&
this.dw_order_details}
end on

on w_list_of_order_details.destroy
destroy(this.cb_save)
destroy(this.dw_order_details)
end on

type cb_save from commandbutton within w_list_of_order_details
int X=1829
int Y=912
int Width=247
int Height=108
int TabOrder=20
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type dw_order_details from datawindow within w_list_of_order_details
int X=37
int Y=32
int Width=2048
int Height=832
int TabOrder=10
string DataObject="d_list_order_details_for_mrs"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

