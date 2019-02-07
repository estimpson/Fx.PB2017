$PBExportHeader$w_prod_grid_job_creator.srw
$PBExportComments$(mps1 )
forward
global type w_prod_grid_job_creator from Window
end type
type cbx_timer from checkbox within w_prod_grid_job_creator
end type
type uo_workorder_graph_display from u_workorder_graph_display within w_prod_grid_job_creator
end type
type uo_part_info from u_prod_grid_workorder_part_info within w_prod_grid_job_creator
end type
end forward

global type w_prod_grid_job_creator from Window
int X=0
int Y=0
int Width=2898
int Height=1936
boolean TitleBar=true
string Title="Prodution Schedule Grid --- Work Order Generator"
long BackColor=77897888
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
event ue_refresh_graph pbm_custom01
event ue_new pbm_custom02
event ue_close pbm_custom03
event ue_save pbm_custom04
event ue_select_job pbm_custom05
event ue_partial_update_crosstab pbm_custom06
cbx_timer cbx_timer
uo_workorder_graph_display uo_workorder_graph_display
uo_part_info uo_part_info
end type
global w_prod_grid_job_creator w_prod_grid_job_creator

type variables
integer ii_count = 1

window	iw_parent = w_production_schedule_grid
end variables

forward prototypes
public subroutine wf_initialize ()
end prototypes

on ue_refresh_graph;//uo_workorder_graph_display.uf_update_graph_dw( 'NONE' )
uo_workorder_graph_display.uf_refresh_graph( uo_part_info.is_part, &
															uo_part_info.ic_demand )

ii_count ++
end on

on ue_new;uo_part_info.triggerevent( 'ue_new' )
end on

on ue_close;close( this )
end on

on ue_save;uo_part_info.triggerevent ( 'ue_save' )
end on

on ue_select_job;string	ls_work_order

ls_work_order	= string( message.longparm, 'address' )

uo_part_info.triggerevent( 'ue_select_job', 0, ls_work_order )

end on

event ue_partial_update_crosstab;IF iw_parent = w_production_schedule_grid THEN
	w_production_schedule_grid.Event ue_partial_updt_crosstab ( uo_part_info.is_part, uo_part_info.ic_demand )
END IF

end event

public subroutine wf_initialize ();s_parm_list	lstr_parm

lstr_parm	= message.powerobjectparm

uo_workorder_graph_display.uf_update_graph_dw( lstr_parm )
uo_part_info.uf_setup_screen( lstr_parm )
end subroutine

on timer;integer	li_visible

li_visible	= integer( &
	uo_workorder_graph_display.dw_workorder_graph.describe('demand.visible' ) )

if li_visible = 0 then
	li_visible	= 1
else
	li_visible	= 0
end if

uo_workorder_graph_display.dw_workorder_graph.modify(&
						"demand.visible = " + string( li_visible )  )




end on

on open;this.wf_initialize()

timer(0.5)

end on

on w_prod_grid_job_creator.create
this.cbx_timer=create cbx_timer
this.uo_workorder_graph_display=create uo_workorder_graph_display
this.uo_part_info=create uo_part_info
this.Control[]={this.cbx_timer,&
this.uo_workorder_graph_display,&
this.uo_part_info}
end on

on w_prod_grid_job_creator.destroy
destroy(this.cbx_timer)
destroy(this.uo_workorder_graph_display)
destroy(this.uo_part_info)
end on

type cbx_timer from checkbox within w_prod_grid_job_creator
int X=37
int Y=1552
int Width=471
int Height=72
string Text="Flashing demand"
boolean Checked=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then
	timer( 0.5 )
else
	timer( 0 )
	uo_workorder_graph_display.dw_workorder_graph.modify(&
						"demand.visible = 1"   )

end if
end on

type uo_workorder_graph_display from u_workorder_graph_display within w_prod_grid_job_creator
int X=18
int Y=752
int Height=1008
int TabOrder=20
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=77897888
end type

on uo_workorder_graph_display.destroy
call u_workorder_graph_display::destroy
end on

type uo_part_info from u_prod_grid_workorder_part_info within w_prod_grid_job_creator
int X=18
int Y=16
int Width=2816
int Height=768
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=77897888
end type

on uo_part_info.destroy
call u_prod_grid_workorder_part_info::destroy
end on

