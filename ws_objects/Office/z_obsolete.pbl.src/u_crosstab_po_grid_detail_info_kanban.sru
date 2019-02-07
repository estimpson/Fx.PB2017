$PBExportHeader$u_crosstab_po_grid_detail_info_kanban.sru
$PBExportComments$(mrs) User object to show the Kanban detail info for PO schedule grid.
forward
global type u_crosstab_po_grid_detail_info_kanban from UserObject
end type
type st_bubble_help from statictext within u_crosstab_po_grid_detail_info_kanban
end type
type dw_graph from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
end type
type dw_po from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
end type
type dw_raw_material from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
end type
type gb_1 from groupbox within u_crosstab_po_grid_detail_info_kanban
end type
end forward

global type u_crosstab_po_grid_detail_info_kanban from UserObject
int Width=2697
int Height=1316
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
event we_nchittest pbm_nchittest
st_bubble_help st_bubble_help
dw_graph dw_graph
dw_po dw_po
dw_raw_material dw_raw_material
gb_1 gb_1
end type
global u_crosstab_po_grid_detail_info_kanban u_crosstab_po_grid_detail_info_kanban

type variables
s_parm_list	istr_parm
boolean		ib_bubble_help = TRUE
end variables

forward prototypes
public subroutine uf_bubble_help (string as_help, integer ai_x, integer ai_y)
end prototypes

on we_nchittest;st_bubble_help.visible	= FALSE
end on

public subroutine uf_bubble_help (string as_help, integer ai_x, integer ai_y);if ib_bubble_help then
	st_bubble_help.visible	= TRUE
	st_bubble_help.move(x, y)
	st_bubble_help.text		= as_help
else
	st_bubble_help.visible	= FALSE
end if
end subroutine

on constructor;istr_parm	= message.powerobjectparm


end on

on u_crosstab_po_grid_detail_info_kanban.create
this.st_bubble_help=create st_bubble_help
this.dw_graph=create dw_graph
this.dw_po=create dw_po
this.dw_raw_material=create dw_raw_material
this.gb_1=create gb_1
this.Control[]={this.st_bubble_help,&
this.dw_graph,&
this.dw_po,&
this.dw_raw_material,&
this.gb_1}
end on

on u_crosstab_po_grid_detail_info_kanban.destroy
destroy(this.st_bubble_help)
destroy(this.dw_graph)
destroy(this.dw_po)
destroy(this.dw_raw_material)
destroy(this.gb_1)
end on

type st_bubble_help from statictext within u_crosstab_po_grid_detail_info_kanban
int X=18
int Y=32
int Width=823
int Height=80
boolean Visible=false
boolean Enabled=false
boolean Border=true
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_graph from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
int X=1426
int Y=64
int Width=1225
int Height=1184
int TabOrder=30
string DataObject="d_demand_raw_material_kanban_graph"
end type

on constructor;call u_jw_dw_super::constructor;string	ls_part

ls_part	= istr_parm.s_key_value

if isvalid(istr_parm.dw_parm_list[1]) then
	istr_parm.dw_parm_list[1].sharedata( this )
	this.setfilter( "part='" + ls_part + "'")
	this.filter()
end if


end on

type dw_po from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
int X=18
int Y=688
int Width=1371
int Height=592
int TabOrder=40
string DataObject="d_available_qty_from_po"
boolean TitleBar=true
string Title="Available quantity from purchase order"
boolean HScrollBar=true
boolean VScrollBar=true
end type

on constructor;call u_jw_dw_super::constructor;string	ls_part
date		ld_date

ls_part	= istr_parm.s_key_value
ld_date	= istr_parm.d_parm_list[1]
this.retrieve( ls_part, ld_date )
end on

type dw_raw_material from u_jw_dw_super within u_crosstab_po_grid_detail_info_kanban
event we_nchittest pbm_nchittest
int X=18
int Y=32
int Width=1371
int Height=640
int TabOrder=10
string DataObject="d_demand_raw_material_kanban"
boolean TitleBar=true
string Title="Raw material demand derived from hard queue"
boolean HScrollBar=true
boolean VScrollBar=true
end type

on we_nchittest;call u_jw_dw_super::we_nchittest;uf_bubble_help( 'Double clicke to view job info', this.x, this.y - 100 )
end on

event doubleclicked;long		ll_row

string	ls_work_order

ll_row	= this.getclickedrow()

if ll_row > 0 then
	ls_work_order		= this.getitemstring( ll_row, 'work_order_work_order' )
	OpenWithParm(w_job_information, ls_work_order)
End If
end event

on constructor;call u_jw_dw_super::constructor;string	ls_part

ls_part	= istr_parm.s_key_value

if isvalid(istr_parm.dw_parm_list[1]) then
	istr_parm.dw_parm_list[1].sharedata( this )
	this.setfilter( "part='" + ls_part + "'")
	this.filter()
end if


end on

type gb_1 from groupbox within u_crosstab_po_grid_detail_info_kanban
int X=1408
int Width=1262
int Height=1280
int TabOrder=20
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

