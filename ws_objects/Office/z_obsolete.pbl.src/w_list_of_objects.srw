$PBExportHeader$w_list_of_objects.srw
forward
global type w_list_of_objects from Window
end type
type cb_save from commandbutton within w_list_of_objects
end type
type dw_objects from datawindow within w_list_of_objects
end type
end forward

global type w_list_of_objects from Window
int X=379
int Y=376
int Width=2153
int Height=1160
boolean TitleBar=true
string Title="List of Objects"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
cb_save cb_save
dw_objects dw_objects
end type
global w_list_of_objects w_list_of_objects

type variables
Private:

Window	i_w_HostWindow		//Host window
end variables

on deactivate;close(this)
end on

on open;/*
Description		:This window will display all the objects 
Author			:Jim Wu
Date				:12/22/95
Modification	:
*/

/* Declaration */
String	l_s_Part
String	l_s_Plant

st_generic_structure l_str_Parameters

dw_objects.SetTransObject(SQLCA)

/* Initialization */
l_str_Parameters	= Message.PowerObjectParm

l_s_Part				= l_str_Parameters.Value1
l_s_Plant			= l_str_Parameters.Value2

/* Retrieve the data */
dw_objects.Retrieve(l_s_Part)

If Not IsNull(l_s_Plant) then
	dw_objects.SetFilter("plant = '" + Trim(l_s_Plant) + "'")
	dw_objects.Filter() 
End If
end on

on w_list_of_objects.create
this.cb_save=create cb_save
this.dw_objects=create dw_objects
this.Control[]={this.cb_save,&
this.dw_objects}
end on

on w_list_of_objects.destroy
destroy(this.cb_save)
destroy(this.dw_objects)
end on

type cb_save from commandbutton within w_list_of_objects
int X=1774
int Y=896
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

type dw_objects from datawindow within w_list_of_objects
int X=37
int Y=32
int Width=1993
int Height=832
int TabOrder=10
string DataObject="d_list_of_objects_for_mrs"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

