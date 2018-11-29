$PBExportHeader$u_dw_collaspable_bom.sru
$PBExportComments$(mst) Datawindow user object to keep the collaspable BOM tree structure.
forward
global type u_dw_collaspable_bom from u_dw_expandable_tree_view_object
end type
end forward

global type u_dw_collaspable_bom from u_dw_expandable_tree_view_object
end type
global u_dw_collaspable_bom u_dw_collaspable_bom

forward prototypes
public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component)
public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[])
public subroutine uf_expand_all (string as_part)
end prototypes

public subroutine uf_show_key (integer ai_row, s_parm_list astr_component_list, integer ai_key_ptr, long al_pos, boolean ab_top_key, boolean ab_last_component);string	ls_key


ls_key	= astr_component_list.s_parm_list[ ai_key_ptr ]
this.setitem( ai_row, 'link_qty', &
			truncate( astr_component_list.c_parm_list[ ai_key_ptr ] , 1 ) )
this.setitem( ai_row, 'value1', &
		string( dec( f_get_part_info( ls_key, 'ON HAND' ) ) ) )
this.setitem( ai_row, 'value2', f_get_part_info( ls_key, 'STANDARD UNIT' ) )

super::uf_show_key( ai_row, astr_component_list, ai_key_ptr, al_pos, ab_top_key, ab_last_component )
end subroutine

public subroutine uf_get_components (string as_key, ref s_parm_list astr_component_list[]);integer	li_count = 0

decimal	lc_qty

string	ls_component

DECLARE 	cursor_part CURSOR FOR  
SELECT 	bill_of_material.part , 
			bill_of_material.quantity
FROM 		bill_of_material  
WHERE 	bill_of_material.parent_part = :as_key   ;

OPEN 		cursor_part;
FETCH 	cursor_part INTO :ls_component, :lc_qty;

do while SQLCA.SQLCode = 0
	li_count ++
	astr_component_list[ li_count ].s_parm_list[ 1 ] 	= ls_component
	astr_component_list[ li_count ].c_parm_list[ 1 ]	= lc_qty

	FETCH	cursor_part INTO :ls_component, :lc_qty;
loop

CLOSE cursor_part;
end subroutine

public subroutine uf_expand_all (string as_part);
end subroutine

