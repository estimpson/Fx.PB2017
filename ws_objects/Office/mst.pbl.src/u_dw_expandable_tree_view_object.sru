$PBExportHeader$u_dw_expandable_tree_view_object.sru
$PBExportComments$(mst)
forward
global type u_dw_expandable_tree_view_object from datawindow
end type
end forward

global type u_dw_expandable_tree_view_object from datawindow
int Width=2629
int Height=1017
int TabOrder=1
string DataObject="d_expandable_tree_view"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
event ue_initialize pbm_custom01
end type
global u_dw_expandable_tree_view_object u_dw_expandable_tree_view_object

type variables
integer		ii_line_width = 164, &
		ii_line_count = 10, &
		ii_row_added = 0, &
		ii_starting_row = 1, &
                            ii_ending_row

string		is_key_column = 'key'

boolean		ib_expand_all = false, &
		ib_out_of_limit = FALSE



end variables

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_has_component (integer ai_row, boolean ab_has_component)
public subroutine uf_hide_components (string as_key, integer ai_row, long al_key_pos)
public subroutine uf_expand_components (string as_key, integer ai_row, long al_pos)
public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component)
public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_post_expand_component (string as_key, s_parm_list astr_component)
public subroutine uf_display_message ()
public subroutine uf_save_parent_row (long al_parent_row, long al_current_row)
end prototypes

on ue_initialize;this.uf_initialize()
end on

public subroutine uf_initialize ();
end subroutine

public subroutine uf_has_component (integer ai_row, boolean ab_has_component);if ab_has_component then
	this.setitem( ai_row, 'has_component', 1 )
else
	this.setitem( ai_row, 'has_component', 0 )
end if
end subroutine

public subroutine uf_hide_components (string as_key, integer ai_row, long al_key_pos);integer	li_count, &
			li_row, &
			li_ptr

boolean	lb_last_component	= FALSE

li_count	= this.rowcount()

li_row = ai_row + 1

this.setitem( ai_row, 'expanded', 0 )

do while (li_row <= li_count ) and (not lb_last_component )
	lb_last_component = (this.getitemnumber( li_row, 'key_pos' ) &
			<= al_key_pos )
	if not lb_last_component then
		li_row ++
	end if
loop

if not lb_last_component then
	li_row	= li_count + 1
end if

if li_row > 1 then
	for li_ptr = li_row - 1 to ai_row + 1 step -1 
		this.deleterow( li_ptr )
	next
end if

this.uf_has_component( ai_row, FALSE )

if this.rowcount() > 0 then
	this.setitem( this.rowcount(), 'ultimate_last_component', 1 )
end if

end subroutine

public subroutine uf_expand_components (string as_key, integer ai_row, long al_pos);s_parm_list	lstr_component_list[]

integer	li_count, &
			li_ptr, &
			li_row, &
			li_level, &
			li_line_ptr, &
			li_current_row


string	ls_line_col

long		ll_component_pos

ll_component_pos	= al_pos + ii_line_width
li_row				= ai_row
li_level				= this.getitemnumber( ai_row, 'level' ) + 1

if li_level > ii_line_count then
	ib_out_of_limit	= TRUE
	return
end if

uf_get_components( as_key, lstr_component_list[] )

li_count	= upperbound( lstr_component_list )

if li_count	> 0 then
	this.setitem( ai_row, 'has_component', 1 )
	this.setitem( ai_row, 'ultimate_last_component', 0 )
end if

this.setitem( ai_row, 'expanded', 1 )

for li_ptr = 1 to li_count
	ii_row_added ++
	if ib_expand_all then
		li_current_row	= ii_row_added + ii_starting_row
	else
		li_current_row	= ai_row + li_ptr
	end if

	this.insertrow( li_current_row )
	this.setitem( li_current_row, 'level', li_level )

	uf_show_key( 	li_current_row , &
						lstr_component_list[ li_ptr ], &
		 				1, &
						ll_component_pos, FALSE, (li_ptr = li_count) )

	uf_save_parent_row( ai_row, li_current_row )

	for li_line_ptr = 1 to ii_line_count
		ls_line_col	= 'line' + string( li_line_ptr ) + '_visible'
		this.setitem( 	li_current_row, ls_line_col, &
							this.getitemnumber( ai_row, ls_line_col ) )
	next

	if li_ptr = li_count then
		this.setitem( li_current_row, 'ultimate_last_component', 1 )
		this.setitem( li_current_row, 'line' + string( li_level ) + '_visible', 0 )
	end if

	if ib_expand_all then
		uf_expand_components( this.getitemstring( li_current_row, is_key_column ), &
									 li_current_row, &
									 this.getitemnumber( li_current_row, 'key_pos' ) )
	end if
next


end subroutine

public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component);string	ls_key 

ls_key	= astr_component_list.s_parm_list[ ai_key_ptr ]

this.setitem( ai_row, 'key', ls_key )
this.setitem( ai_row, 'key_pos', al_pos )

if ab_top_key then
	this.setitem( ai_row, 'component_key', 0 )
else 
	this.setitem( ai_row, 'component_key', 1 )
end if

if ab_last_component then
	this.setitem( ai_row, 'last_component_key', 1 )
else
	this.setitem( ai_row, 'last_component_key', 0 )
end if
end subroutine

public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[]);
end subroutine

public subroutine uf_post_expand_component (string as_key, s_parm_list astr_component);
end subroutine

public subroutine uf_display_message ();			messagebox( 'Monitor for Windows', 'The indented level is out of ' + &
							'system limit. It could be caused by infinite loop. Please call your tech support.', stopsign! )
end subroutine

public subroutine uf_save_parent_row (long al_parent_row, long al_current_row);
end subroutine

on constructor;this.triggerevent( 'ue_initialize' )


end on

on doubleclicked;string	ls_key

integer	li_expanded

long		ll_row, &
			ll_count, &
			ll_key_pos

ii_row_added	= 0	
ll_row			= this.getclickedrow()
ll_count			= this.rowcount()

if ll_row > 0 then
	ii_starting_row	= 	ll_row
	ls_key				=	this.getitemstring( ll_row, is_key_column )
	li_expanded			=	this.getitemnumber( ll_row, 'expanded' )
	ll_key_pos			=  this.getitemnumber( ll_row, 'key_pos' )

	if li_expanded = 1 then
		uf_hide_components( ls_key, ll_row, ll_key_pos )
	else
		ib_out_of_limit	= FALSE
		uf_expand_components( ls_key, ll_row, ll_key_pos )
		if ib_out_of_limit then
			uf_display_message()
		end if
	end if		
end if


end on

