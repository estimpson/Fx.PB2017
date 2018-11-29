$PBExportHeader$w_detail_info_for_prod_grid.srw
$PBExportComments$(mps1) detail info for prod grid
forward
global type w_detail_info_for_prod_grid from Window
end type
type dw_graph from u_jw_dw_super within w_detail_info_for_prod_grid
end type
type dw_prod_grid_detail from u_jw_dw_super within w_detail_info_for_prod_grid
end type
type gb_1 from groupbox within w_detail_info_for_prod_grid
end type
end forward

global type w_detail_info_for_prod_grid from Window
int X=0
int Y=0
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="Detail info for prod grid"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_initialize pbm_custom01
dw_graph dw_graph
dw_prod_grid_detail dw_prod_grid_detail
gb_1 gb_1
end type
global w_detail_info_for_prod_grid w_detail_info_for_prod_grid

type variables
string	is_part
date	id_date1, &
	id_date2
end variables

forward prototypes
public subroutine wf_initialize ()
end prototypes

on ue_initialize;this.wf_initialize()
end on

public subroutine wf_initialize ();/* 
Description	:	To initialize the variables
Author		:	Jim Wu
Start Date	:	04/04/1996
Modification:
*/

/* Declaration */
st_generic_structure	lstr_parm

/* Initialization */
lstr_parm	= message.powerobjectparm

is_part		= lstr_parm.value1
id_date1		= date( lstr_parm.value2 )
id_date2		= date( lstr_parm.value3 )

/* Main Process */


dw_prod_grid_detail.retrieve( is_part, id_date1, id_date2 )
end subroutine

on w_detail_info_for_prod_grid.create
this.dw_graph=create dw_graph
this.dw_prod_grid_detail=create dw_prod_grid_detail
this.gb_1=create gb_1
this.Control[]={this.dw_graph,&
this.dw_prod_grid_detail,&
this.gb_1}
end on

on w_detail_info_for_prod_grid.destroy
destroy(this.dw_graph)
destroy(this.dw_prod_grid_detail)
destroy(this.gb_1)
end on

on open;this.triggerevent( 'ue_initialize' )
end on

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_menu_with_only_exit' THEN & 
	gnv_App.of_GetFrame().Changemenu ( m_menu_with_only_exit )
end event

type dw_graph from u_jw_dw_super within w_detail_info_for_prod_grid
int X=73
int Y=688
int Width=2615
int Height=964
int TabOrder=20
boolean Enabled=false
string DataObject="d_detail_for_prod_grid_demand_graph"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean LiveScroll=false
end type

type dw_prod_grid_detail from u_jw_dw_super within w_detail_info_for_prod_grid
int X=18
int Y=80
int Width=2706
int Height=544
int TabOrder=10
string DataObject="d_detail_for_prod_grid_demand"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

on constructor;call u_jw_dw_super::constructor;this.sharedata( dw_graph )
end on

type gb_1 from groupbox within w_detail_info_for_prod_grid
int X=18
int Y=624
int Width=2706
int Height=1040
int TabOrder=30
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

