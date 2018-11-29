$PBExportHeader$u_netout.sru
$PBExportComments$(mps1) Added a instance to keep the key value.
forward
global type u_netout from UserObject
end type
type st_1 from statictext within u_netout
end type
type dw_netout_graph from u_jw_dw_super within u_netout
end type
type dw_netout from datawindow within u_netout
end type
type ln_1 from line within u_netout
end type
type ln_2 from line within u_netout
end type
end forward

global type u_netout from UserObject
int Width=2761
int Height=412
boolean Border=true
long BackColor=77897888
long PictureMaskColor=25166016
long TabBackColor=67108864
event ue_item_changed pbm_custom01
event ue_double_clicked_graph pbm_custom02
st_1 st_1
dw_netout_graph dw_netout_graph
dw_netout dw_netout
ln_1 ln_1
ln_2 ln_2
end type
global u_netout u_netout

type variables
string	is_key
end variables

forward prototypes
public subroutine uf_item_changed ()
end prototypes

on ue_item_changed;this.uf_item_changed()
end on

on ue_double_clicked_graph;parent.triggerevent( 'ue_double_clicked_netout' )
end on

public subroutine uf_item_changed ();/*
Description	:	To refresh the graph after the data being changed
Author		:	Jim Wu
Start Date	:	03/09/96
Modification:
*/


/* Declaration */
integer	li_grid_row, &
			li_grid_col, &
			li_grid_total

/* Initialization */
li_grid_total	= dw_netout.rowcount()

/* Main Process */
dw_netout_graph.setredraw( FALSE )

for li_grid_row = 1 to li_grid_total
	li_grid_row = dw_netout.GetNextModified(li_grid_row, Primary!)
	if li_grid_row > 0 then
		for li_grid_col = 2 to 7 
			dw_netout_graph.setitem( (( li_grid_col - 1) * 4) + 1, 3, &
				dw_netout.getitemnumber( li_grid_row, li_grid_col ) )
		next		
	end if
next

dw_netout_graph.setredraw( TRUE )

end subroutine

on u_netout.create
this.st_1=create st_1
this.dw_netout_graph=create dw_netout_graph
this.dw_netout=create dw_netout
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.st_1,&
this.dw_netout_graph,&
this.dw_netout,&
this.ln_1,&
this.ln_2}
end on

on u_netout.destroy
destroy(this.st_1)
destroy(this.dw_netout_graph)
destroy(this.dw_netout)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type st_1 from statictext within u_netout
int X=18
int Y=304
int Width=677
int Height=48
boolean Enabled=false
string Text="Double Click Graph for Detail"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_netout_graph from u_jw_dw_super within u_netout
int X=18
int Y=16
int Width=677
int Height=288
int TabOrder=20
string DataObject="d_external_netout_graph"
boolean VScrollBar=true
end type

on doubleclicked;call u_jw_dw_super::doubleclicked;parent.triggerevent( 'ue_double_clicked_graph' )
end on

type dw_netout from datawindow within u_netout
int X=713
int Y=16
int Width=2030
int Height=352
int TabOrder=10
string DataObject="d_external_netout"
boolean LiveScroll=true
end type

on itemchanged;parent.triggerevent( 'ue_item_changed' )
end on

on constructor;this.modify( "value1.color = '0~tif(value1 < 0, 255, 0 )'")
this.modify( "value2.color = '0~tif(value2 < 0, 255, 0 )'")
this.modify( "value3.color = '0~tif(value3 < 0, 255, 0 )'")
this.modify( "value4.color = '0~tif(value4 < 0, 255, 0 )'")
this.modify( "value5.color = '0~tif(value5 < 0, 255, 0 )'")
this.modify( "value6.color = '0~tif(value6 < 0, 255, 0 )'")
this.modify( "value7.color = '0~tif(value7 < 0, 255, 0 )'")

end on

type ln_1 from line within u_netout
boolean Enabled=false
int BeginX=18
int BeginY=368
int EndX=2706
int EndY=368
int LineThickness=4
long LineColor=16777215
end type

type ln_2 from line within u_netout
boolean Enabled=false
int BeginX=23
int BeginY=364
int EndX=2711
int EndY=364
int LineThickness=4
long LineColor=8421504
end type

