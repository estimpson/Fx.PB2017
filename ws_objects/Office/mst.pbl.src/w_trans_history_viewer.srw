$PBExportHeader$w_trans_history_viewer.srw
$PBExportComments$(mst)
forward
global type w_trans_history_viewer from Window
end type
type dw_expanded_line from datawindow within w_trans_history_viewer
end type
type cbx_expand_all from checkbox within w_trans_history_viewer
end type
type cbx_detail from checkbox within w_trans_history_viewer
end type
type uo_detail from u_mle_trans_detail within w_trans_history_viewer
end type
type dw_trans from u_dw_tree_view_for_trans_history within w_trans_history_viewer
end type
end forward

global type w_trans_history_viewer from Window
int X=1
int Y=1
int Width=2908
int Height=2001
boolean TitleBar=true
string Title="Audit Trail Viewer"
long BackColor=12632256
boolean ControlMenu=true
WindowState WindowState=maximized!
event ue_initialize pbm_custom01
event ue_change_span pbm_custom02
dw_expanded_line dw_expanded_line
cbx_expand_all cbx_expand_all
cbx_detail cbx_detail
uo_detail uo_detail
dw_trans dw_trans
end type
global w_trans_history_viewer w_trans_history_viewer

type variables
integer	ii_count = 182, &
	ii_ptr = 0
end variables

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_show_trans_detail (long al_row)
end prototypes

on ue_initialize;uf_initialize()
end on

on ue_change_span;dw_trans.ic_range	= dec( uo_detail.em_span.text )
end on

public subroutine uf_initialize ();long						ll_serial

st_generic_structure	lstr_parm

s_parm_list				lstr_component_list

choose case TRUE

	case 	isvalid( message.powerobjectparm )
		if classname( lstr_parm )	= classname( message.powerobjectparm ) then
			lstr_parm	= message.powerobjectparm
			ll_serial	= long( lstr_parm.value1 )
		else
			messagebox( 'Monitor for Windows', 'Unable to get serial#.', stopsign! )
			return
		end if

	case	not isnull( message.doubleparm )
			ll_serial	= message.doubleparm

	case  not isnull( message.stringparm )
			ll_serial	= long( message.stringparm )

	case else
			messagebox( 'Monitor for Windows', 'Unable to get serial#.', stopsign! )
			return

end choose

//if ll_serial = 0 then
//	if isvalid( winst[iCurInst] ) then
//		ll_serial	= long( winst[iCurInst].szPrimaryValue )
//	end if
//end if

timer( 0.5 )

dw_trans.ib_expand_all	= TRUE
dw_trans.insertrow( 1 )
dw_trans.setitem( 1, dw_trans.is_key_column, ll_serial )
dw_trans.setitem( 1, 'key', string( ll_serial ) )

lstr_component_list.s_parm_list[1]	= string( ll_serial )
lstr_component_list.s_parm_list[2]	= string( ll_serial )
lstr_component_list.s_parm_list[3]	= ''
lstr_component_list.s_parm_list[4]	= ''				//Enable double click
lstr_component_list.s_parm_list[5]	= ''
lstr_component_list.s_parm_list[6]	= ''
lstr_component_list.s_parm_list[7]	= ''
lstr_component_list.s_parm_list[8]	= ''
lstr_component_list.s_type				='1'
lstr_component_list.b_parm_list[1]	= FALSE

setnull( lstr_component_list.c_parm_list[1] )
setnull( lstr_component_list.dt_parm_list[1]	 )

dw_trans.uf_show_key( 1, lstr_component_list, 1, 164, TRUE, TRUE )
dw_trans.uf_expand_components( string( ll_serial ), 1, 164 )


if dw_trans.ib_out_of_limit then
	dw_trans.uf_display_message()
end if





end subroutine

public subroutine uf_show_trans_detail (long al_row);uo_detail.mle_detail.text	= 	dw_trans.getitemstring( al_row, 'key' ) + ' ' + &
							'From Loc:' + dw_trans.getitemstring( al_row, 'value2' ) +&
							' ' +&
							'Qty:' + string( dw_trans.getitemnumber( al_row, 'qty' ) )
end subroutine

event open;this.triggerevent( 'ue_initialize' )

dw_expanded_line.settransobject(sqlca)
end event

on timer;ii_count	++

if ii_count > 194 then
	ii_count	= 183
end if

if ii_ptr < dw_trans.rowcount() then
	ii_ptr ++
else
	ii_ptr	= 1
end if

dw_trans.modify( "icon.text='" + CharA( mod( ii_count, 256 ) ) + "'" )
dw_trans.modify( "icon2.text='" + CharA( mod( ii_count, 256 ) ) + "'" )




end on

event activate;gnv_App.of_GetFrame().changemenu(m_menu_with_only_exit)





end event

on close;close( this )


end on

on w_trans_history_viewer.create
this.dw_expanded_line=create dw_expanded_line
this.cbx_expand_all=create cbx_expand_all
this.cbx_detail=create cbx_detail
this.uo_detail=create uo_detail
this.dw_trans=create dw_trans
this.Control[]={ this.dw_expanded_line,&
this.cbx_expand_all,&
this.cbx_detail,&
this.uo_detail,&
this.dw_trans}
end on

on w_trans_history_viewer.destroy
destroy(this.dw_expanded_line)
destroy(this.cbx_expand_all)
destroy(this.cbx_detail)
destroy(this.uo_detail)
destroy(this.dw_trans)
end on

type dw_expanded_line from datawindow within w_trans_history_viewer
event ue_change_span pbm_custom01
int X=1719
int Y=17
int Width=1061
int Height=785
int TabOrder=30
boolean Visible=false
string DataObject="d_expanded_line_info"
boolean TitleBar=true
string Title="Audit Trial Detailed Information"
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean LiveScroll=true
end type

on ue_change_span;// parent.triggerevent('ue_change_span')

end on

on constructor;//dw_expanded_line.bringtotop = true
end on

type cbx_expand_all from checkbox within w_trans_history_viewer
int X=641
int Y=17
int Width=458
int Height=65
string Text="Expand All"
boolean Checked=true
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_detail from checkbox within w_trans_history_viewer
int X=129
int Y=17
int Width=458
int Height=65
string Text="Display Detail Info"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_detail.visible		= this.checked
uo_detail.bringtotop	= this.checked

dw_expanded_line.visible = this.checked
dw_expanded_line.bringtotop = this.checked


end on

on constructor;this.bringtotop	= TRUE
end on

type uo_detail from u_mle_trans_detail within w_trans_history_viewer
int X=92
int Y=81
int Width=1134
int Height=81
int TabOrder=20
boolean Visible=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on constructor;call u_mle_trans_detail::constructor;this.bringtotop	= TRUE
end on

on uo_detail.destroy
call u_mle_trans_detail::destroy
end on

type dw_trans from u_dw_tree_view_for_trans_history within w_trans_history_viewer
int X=1
int Y=1
int Width=2890
int Height=1377
int TabOrder=10
BorderStyle BorderStyle=StyleBox!
boolean Resizable=true
end type

on clicked;call u_dw_tree_view_for_trans_history::clicked;long		ll_row
int   	i_serial,i_pos,i_pos1,i_diff
string 	s_serial,s_type,s_date,s_time
date     d_date
time     t_time
datetime dt_date 

ll_row	= this.getclickedrow()

if ll_row > 0 then
// The below 8 lines inc by gph on 3/25 at 3.32
// passing serial no,trans type & date of transaction for the datawindow
// for retrieval

   s_serial = dw_trans.getitemstring(ll_row,'serial')
   i_serial = integer(s_serial)
	s_type   = dw_trans.getitemstring(ll_row,'remark')
	s_date   = dw_trans.getitemstring(ll_row,'key')       
   i_pos    = PosA(s_date,' ')
   i_pos1   = PosA(s_date,' ',(i_pos+1)) 
   i_diff   = (i_pos1 - 1) - (i_pos+1)
   s_time   = MidA(s_date,(i_pos + 1),i_diff)
   s_date   = LeftA(s_date,(i_pos - 1))

   d_date   = date(s_date)
   t_time   = time(s_time) 
   
   dt_date   = datetime(d_date,t_time)

   dw_expanded_line.retrieve(i_serial,s_type)

	uf_show_trans_detail( ll_row )
end if
end on

on rbuttondown;this.vscrollbar		= TRUE
this.ib_expand_all	= cbx_expand_all.checked
call super::rbuttondown

end on

on doubleclicked;this.vscrollbar		= TRUE
this.ib_expand_all	= cbx_expand_all.checked
call super::doubleclicked

end on

on resize;call u_dw_tree_view_for_trans_history::resize;this.bringtotop	= FALSE
end on

