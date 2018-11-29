$PBExportHeader$u_workorder_graph.sru
$PBExportComments$Graphic object for work order in the plant monitor
forward
global type u_workorder_graph from statictext
end type
end forward

global type u_workorder_graph from statictext
int Width=247
int Height=65
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long BackColor=16776960
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_workorder_graph u_workorder_graph

type variables
Long	i_i_Ptr

String	i_s_Machine
end variables

on doubleclicked;szReturnedString	= String(i_i_Ptr)
szReturnedPart		= i_s_Machine

Parent.TriggerEvent("ue_double_clicked_job")
end on

on clicked;szReturnedString	= String(i_i_Ptr)
szReturnedPart		= i_s_Machine

Parent.TriggerEvent("ue_select_job")
end on

