$PBExportHeader$w_netout_po_grid.srw
$PBExportComments$(mrs) net out graph for po grid.
forward
global type w_netout_po_grid from Window
end type
type uo_netout from u_netout_po_grid within w_netout_po_grid
end type
end forward

global type w_netout_po_grid from Window
int X=0
int Y=0
int Width=2898
int Height=1896
boolean TitleBar=true
string Title="Net Out Calculation / Graph"
long BackColor=78682240
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_initialize pbm_custom01
uo_netout uo_netout
end type
global w_netout_po_grid w_netout_po_grid

forward prototypes
public subroutine wf_initialize ()
end prototypes

on ue_initialize;this.wf_initialize()
end on

public subroutine wf_initialize ();s_parm_list	lstr_parm

lstr_parm	= message.powerobjectparm
uo_netout.uf_calculate_netout( 	lstr_parm.s_key_value, &
				lstr_parm.c_parm_list, &
				lstr_parm.s_parm_list, &
				lstr_parm.b_parm_list[1],&
				lstr_parm.s_type)

end subroutine

on w_netout_po_grid.create
this.uo_netout=create uo_netout
this.Control[]={this.uo_netout}
end on

on w_netout_po_grid.destroy
destroy(this.uo_netout)
end on

on open;this.triggerevent( 'ue_initialize' )
end on

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_menu_with_only_exit' THEN & 
	gnv_App.of_GetFrame().Changemenu ( m_menu_with_only_exit )
end event

type uo_netout from u_netout_po_grid within w_netout_po_grid
int X=73
int Y=48
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=78682240
end type

on uo_netout.destroy
call u_netout_po_grid::destroy
end on

