$PBExportHeader$u_list_of_objects.sru
$PBExportComments$List of objects per part
forward
global type u_list_of_objects from UserObject
end type
type dw_objects from datawindow within u_list_of_objects
end type
end forward

global type u_list_of_objects from UserObject
int Width=1806
int Height=888
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
dw_objects dw_objects
end type
global u_list_of_objects u_list_of_objects

on u_list_of_objects.create
this.dw_objects=create dw_objects
this.Control[]={this.dw_objects}
end on

on u_list_of_objects.destroy
destroy(this.dw_objects)
end on

type dw_objects from datawindow within u_list_of_objects
int X=91
int Y=48
int Width=1371
int Height=688
int TabOrder=1
string DataObject="d_list_of_objects_for_mrs"
boolean LiveScroll=true
end type

