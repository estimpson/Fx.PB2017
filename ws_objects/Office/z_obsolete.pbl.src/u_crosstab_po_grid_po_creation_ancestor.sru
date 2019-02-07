$PBExportHeader$u_crosstab_po_grid_po_creation_ancestor.sru
$PBExportComments$(mrs) ancestor user object for creating POs.
forward
global type u_crosstab_po_grid_po_creation_ancestor from UserObject
end type
type uo_release from u_crosstab_po_grid_release_entry within u_crosstab_po_grid_po_creation_ancestor
end type
type dw_selection from u_jw_dw_super within u_crosstab_po_grid_po_creation_ancestor
end type
type st_1 from statictext within u_crosstab_po_grid_po_creation_ancestor
end type
end forward

global type u_crosstab_po_grid_po_creation_ancestor from UserObject
int Width=2574
int Height=972
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
event ue_initialize pbm_custom01
event ue_close_parent pbm_custom02
event ue_save pbm_custom03
uo_release uo_release
dw_selection dw_selection
st_1 st_1
end type
global u_crosstab_po_grid_po_creation_ancestor u_crosstab_po_grid_po_creation_ancestor

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_save ()
end prototypes

on ue_initialize;this.uf_initialize()
end on

on ue_close_parent;parent.triggerevent( 'ue_close' )
end on

on ue_save;this.uf_save()
end on

public subroutine uf_initialize ();
end subroutine

public subroutine uf_save ();
end subroutine

on constructor;this.triggerevent( 'ue_initialize' )
end on

on u_crosstab_po_grid_po_creation_ancestor.create
this.uo_release=create uo_release
this.dw_selection=create dw_selection
this.st_1=create st_1
this.Control[]={this.uo_release,&
this.dw_selection,&
this.st_1}
end on

on u_crosstab_po_grid_po_creation_ancestor.destroy
destroy(this.uo_release)
destroy(this.dw_selection)
destroy(this.st_1)
end on

type uo_release from u_crosstab_po_grid_release_entry within u_crosstab_po_grid_po_creation_ancestor
int X=1463
int Y=64
int Width=1024
int Height=844
int TabOrder=20
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=78682240
end type

on uo_release.destroy
call u_crosstab_po_grid_release_entry::destroy
end on

type dw_selection from u_jw_dw_super within u_crosstab_po_grid_po_creation_ancestor
int X=37
int Y=32
int Width=1353
int Height=896
int TabOrder=10
string DataObject="dw_list_of_dropship_orders"
BorderStyle BorderStyle=StyleLowered!
end type

type st_1 from statictext within u_crosstab_po_grid_po_creation_ancestor
int X=1408
int Y=32
int Width=1115
int Height=896
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

