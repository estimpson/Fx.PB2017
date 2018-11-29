$PBExportHeader$w_bom_viewer.srw
$PBExportComments$(mst)
forward
global type w_bom_viewer from Window
end type
type cb_1 from commandbutton within w_bom_viewer
end type
type cbx_expand_all from checkbox within w_bom_viewer
end type
type uo_bom_loop from uo_check_bom_loop within w_bom_viewer
end type
type dw_bom from u_dw_collaspable_bom within w_bom_viewer
end type
end forward

global type w_bom_viewer from Window
int X=0
int Y=0
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="Indented Bill of Material Viewer"
long BackColor=79741120
boolean ControlMenu=true
boolean Resizable=true
WindowType WindowType=popup!
event ue_initialize pbm_custom01
event ue_inifinite_loop pbm_custom02
cb_1 cb_1
cbx_expand_all cbx_expand_all
uo_bom_loop uo_bom_loop
dw_bom dw_bom
end type
global w_bom_viewer w_bom_viewer

type variables
integer	ii_count = 182, &
	ii_ptr = 0
end variables

forward prototypes
public subroutine uf_initialize ()
end prototypes

event ue_initialize;uf_initialize()
end event

on ue_inifinite_loop;close( this )
end on

public subroutine uf_initialize ();string	ls_part
s_parm_list	lstr_component_list


ls_part	= message.stringparm

if uo_bom_loop.wf_check_loop_in_bom( ls_part ) then	//there is inifinite loop
	uo_bom_loop.visible		= TRUE
	uo_bom_loop.bringtotop	= TRUE
else
	timer( 0.5 )

	dw_bom.ib_expand_all	= TRUE
	dw_bom.insertrow( 1 )
	dw_bom.setitem( 1, 'key', ls_part )
	lstr_component_list.s_parm_list[1]	= ls_part
	lstr_component_list.c_parm_list[1]	= 1
	dw_bom.ib_out_of_limit	= FALSE

	dw_bom.uf_show_key( 1, lstr_component_list, 1, 164, TRUE, TRUE )
	dw_bom.uf_expand_components( ls_part, 1, 164 )

	if dw_bom.ib_out_of_limit then
		dw_bom.uf_display_message()
	end if


end if


end subroutine

on resize;dw_bom.height = w_bom_viewer.height - 180
dw_bom.width  = w_bom_viewer.width - 130
end on

event timer;string	ls_part, &
			ls_onhand, &
			ls_new_onhand

ii_count	++

if ii_count > 194 then
	ii_count	= 183
end if

if ii_ptr < dw_bom.rowcount() then
	ii_ptr ++
else
	ii_ptr	= 1
end if

ls_part			= dw_bom.getitemstring( ii_ptr, 'key' )
ls_onhand		= dw_bom.getitemstring( ii_ptr, 'value1' )
ls_new_onhand	= string( dec( f_get_part_info( ls_part, 'ON HAND' ) ) )

dw_bom.setitem( ii_ptr, 'value1', ls_new_onhand )
if ls_new_onhand	<> ls_onhand then
	dw_bom.setitem( ii_ptr, 'value_changed', 1 )
end if

//dw_bom.modify( "icon.text='" + char( mod( ii_count, 256 ) ) + "'" )


end event

on open;this.triggerevent( 'ue_initialize' )

end on

on w_bom_viewer.create
this.cb_1=create cb_1
this.cbx_expand_all=create cbx_expand_all
this.uo_bom_loop=create uo_bom_loop
this.dw_bom=create dw_bom
this.Control[]={this.cb_1,&
this.cbx_expand_all,&
this.uo_bom_loop,&
this.dw_bom}
end on

on w_bom_viewer.destroy
destroy(this.cb_1)
destroy(this.cbx_expand_all)
destroy(this.uo_bom_loop)
destroy(this.dw_bom)
end on

on deactivate;close( this )
end on

type cb_1 from commandbutton within w_bom_viewer
int X=32
int Y=8
int Width=448
int Height=76
int TabOrder=10
string Text="Print Visual BOM"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_bom.print()
end event

type cbx_expand_all from checkbox within w_bom_viewer
int X=681
int Y=20
int Width=347
int Height=72
string Text="Expand All"
boolean Checked=true
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_bom_loop from uo_check_bom_loop within w_bom_viewer
int X=731
int Y=240
int TabOrder=30
boolean Visible=false
end type

on uo_bom_loop.destroy
call uo_check_bom_loop::destroy
end on

type dw_bom from u_dw_collaspable_bom within w_bom_viewer
int X=27
int Y=12
int Width=2839
int Height=1748
int TabOrder=20
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean LiveScroll=false
end type

on doubleclicked;//this.vscrollbar		= TRUE
this.ib_expand_all	= cbx_expand_all.checked
call super::doubleclicked
end on

