$PBExportHeader$w_resize_base.srw
forward
global type w_resize_base from w_base
end type
end forward

type st_window_objects from structure
	windowobject		object
	integer		anchor_x1
	integer		anchor_y1
	integer		anchor_x2
	integer		anchor_y2
	integer		anchor_width
	integer		anchor_height
	real		var_x1
	real		var_y1
	real		var_x2
	real		var_y2
	real		var_width
	real		var_height
	integer		min_x1
	integer		min_y1
	integer		min_x2
	integer		min_y2
	integer		min_width
	integer		min_height
	integer		max_x1
	integer		max_y1
	integer		max_x2
	integer		max_y2
	integer		max_width
	integer		max_height
end type

global type w_resize_base from w_base
event ue_resize ( integer newwidth,  integer newheight )
end type
global w_resize_base w_resize_base

type variables
Protected:
st_window_objects	i_st_wo_item [ ]
end variables

forward prototypes
public subroutine wf_init_object_array ()
end prototypes

event ue_resize;LONG	l_l_counter

INTEGER	l_i_coord1, &
			l_i_coord2, &
			l_i_coord3, &
			l_i_coord4, &
			l_i_width, &
			l_i_height

BOOLEAN	l_b_var_begin_x, &
			l_b_var_end_x, &
			l_b_var_size_x, &
			l_b_var_begin_y, &
			l_b_var_end_y, &
			l_b_var_size_y

DragObject	l_do_test

Any	l_any_test

l_l_counter = LowerBound ( i_st_wo_item )

DO WHILE l_l_counter <= UpperBound ( i_st_wo_item )

	IF IsValid ( i_st_wo_item [ l_l_counter ].object ) THEN
		CHOOSE CASE i_st_wo_item [ l_l_counter ].object.TypeOf ( )
			CASE Line!
			CASE Oval!
			CASE Rectangle!
			CASE RoundRectangle!
			CASE ELSE
				l_do_test = i_st_wo_item [ l_l_counter ].object
				IF i_st_wo_item [ l_l_counter ].object.TypeOf ( ) <> Userobject! THEN &
						l_do_test.SetRedraw ( FALSE )
		END CHOOSE
	END IF

	l_b_var_begin_x 	= IsNull ( i_st_wo_item [ l_l_counter ].anchor_x1 )
	l_b_var_end_x 		= IsNull ( i_st_wo_item [ l_l_counter ].anchor_x2 )
	l_b_var_size_x 	= IsNull ( i_st_wo_item [ l_l_counter ].anchor_width )
	l_b_var_begin_y 	= IsNull ( i_st_wo_item [ l_l_counter ].anchor_y1 )
	l_b_var_end_y 		= IsNull ( i_st_wo_item [ l_l_counter ].anchor_y2 )
	l_b_var_size_y 	= IsNull ( i_st_wo_item [ l_l_counter ].anchor_height )
	
	IF l_b_var_begin_x THEN
		l_i_coord1 = i_st_wo_item [ l_l_counter ].var_x1 *  newwidth
		IF l_i_coord1 > i_st_wo_item [ l_l_counter ].max_x1 THEN &
			l_i_coord1 = i_st_wo_item [ l_l_counter ].max_x1
		IF l_i_coord1 < i_st_wo_item [ l_l_counter ].min_x1 THEN
			l_i_coord1 = i_st_wo_item [ l_l_counter ].min_x1
		END IF
	ELSE
		l_i_coord1 = i_st_wo_item [ l_l_counter ].anchor_x1
	END IF

	IF l_b_var_begin_y THEN
		l_i_coord2 = i_st_wo_item [ l_l_counter ].var_y1 *  newheight
		IF l_i_coord2 > i_st_wo_item [ l_l_counter ].max_y1 THEN &
			l_i_coord2 = i_st_wo_item [ l_l_counter ].max_y1
		IF l_i_coord2 < i_st_wo_item [ l_l_counter ].min_y1 THEN
			l_i_coord2 = i_st_wo_item [ l_l_counter ].min_y1
		END IF
	ELSE
		l_i_coord2 = i_st_wo_item [ l_l_counter ].anchor_y1
	END IF

	IF l_b_var_size_x THEN
		l_i_width = i_st_wo_item [ l_l_counter ].var_width *  newwidth
		IF l_i_width > i_st_wo_item [ l_l_counter ].max_width THEN &
			l_i_width = i_st_wo_item [ l_l_counter ].max_width
		IF l_i_width < i_st_wo_item [ l_l_counter ].min_width THEN
			l_i_width = i_st_wo_item [ l_l_counter ].min_width
		END IF
	ELSE
		l_i_width = i_st_wo_item [ l_l_counter ].anchor_width
	END IF
	
	IF l_b_var_size_y THEN
		l_i_height = i_st_wo_item [ l_l_counter ].var_height *  newheight
		IF l_i_height > i_st_wo_item [ l_l_counter ].max_height THEN &
			l_i_height = i_st_wo_item [ l_l_counter ].max_height
		IF l_i_height < i_st_wo_item [ l_l_counter ].min_height THEN
			l_i_height = i_st_wo_item [ l_l_counter ].min_height
		END IF
	ELSE
		l_i_height = i_st_wo_item [ l_l_counter ].anchor_height
	END IF
	
	IF l_b_var_end_x THEN
		l_i_coord3 = i_st_wo_item [ l_l_counter ].var_x2 * newwidth
		IF l_i_coord3 > i_st_wo_item [ l_l_counter ].max_x2 THEN &
			l_i_coord3 = i_st_wo_item [ l_l_counter ].max_x2
		IF l_i_coord3 < i_st_wo_item [ l_l_counter ].min_x2 THEN &
			l_i_coord3 = i_st_wo_item [ l_l_counter ].min_x2
	ELSE
		l_i_coord3 =  i_st_wo_item [ l_l_counter ].anchor_x2
	END IF
	
	IF l_b_var_end_y THEN
		l_i_coord4 = i_st_wo_item [ l_l_counter ].var_y2 * newheight
		IF l_i_coord4 > i_st_wo_item [ l_l_counter ].max_y2 THEN &
			l_i_coord4 = i_st_wo_item [ l_l_counter ].max_y2
		IF l_i_coord4 < i_st_wo_item [ l_l_counter ].min_y2 THEN &
			l_i_coord4 = i_st_wo_item [ l_l_counter ].min_y2
	ELSE
		l_i_coord4 =  i_st_wo_item [ l_l_counter ].anchor_y2
	END IF
	
	IF IsNull ( l_i_width ) THEN
		l_i_width =  newwidth - l_i_coord3 - l_i_coord1
	END IF
	
	IF IsNull ( l_i_height ) THEN
		l_i_height =  newheight - l_i_coord4 - l_i_coord2
	END IF

	IF IsValid ( i_st_wo_item [ l_l_counter ].object ) THEN
		IF i_st_wo_item [ l_l_counter].object.TypeOf ( ) <> Line! THEN
			i_st_wo_item [ l_l_counter ].object.Resize ( l_i_width, l_i_height )
		END IF
	END IF
	
	IF IsNull ( l_i_coord1 ) THEN
		l_i_coord1 = newwidth - l_i_coord3 - l_i_width
	END IF

	IF IsNull ( l_i_coord2 ) THEN
		l_i_coord2 = newheight - l_i_coord4 - l_i_height
	END IF
	
	IF IsValid ( i_st_wo_item [ l_l_counter ].object ) THEN
		i_st_wo_item [ l_l_counter ].object.Move ( l_i_coord1, l_i_coord2 )
		IF i_st_wo_item [ l_l_counter].object.TypeOf ( ) = Line! THEN
			i_st_wo_item [ l_l_counter ].object.Resize ( l_i_coord1 + l_i_width, l_i_coord2 + l_i_height )
		END IF
	END IF
   setnull(l_i_coord1)
	setnull(l_i_coord2)
	setnull(l_i_coord3)
	setnull(l_i_coord4)
	setnull(l_i_width)
	setnull(l_i_height)

	IF IsValid ( i_st_wo_item [ l_l_counter ].object ) THEN
		CHOOSE CASE i_st_wo_item [ l_l_counter ].object.TypeOf ( )
			CASE Line!
			CASE Oval!
			CASE Rectangle!
			CASE RoundRectangle!
			CASE ELSE
				l_do_test = i_st_wo_item [ l_l_counter ].object
				IF i_st_wo_item [ l_l_counter ].object.TypeOf ( ) <> Userobject! THEN &
					l_do_test.SetRedraw ( TRUE )
		END CHOOSE
	END IF
	l_l_counter ++

LOOP
end event

public subroutine wf_init_object_array ();INTEGER	l_i_count

l_i_count = 1
DO WHILE l_i_count <= UpperBound ( Control )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_x1 )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_x2 )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_y1 )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_y2 )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_width )
	SetNull ( i_st_wo_item [ l_i_count ].anchor_height )
	SetNull ( i_st_wo_item [ l_i_count ].var_x1 )
	SetNull ( i_st_wo_item [ l_i_count ].var_x2 )
	SetNull ( i_st_wo_item [ l_i_count ].var_y1 )
	SetNull ( i_st_wo_item [ l_i_count ].var_y2 )
	SetNull ( i_st_wo_item [ l_i_count ].var_width )
	SetNull ( i_st_wo_item [ l_i_count ].var_height )
	SetNull ( i_st_wo_item [ l_i_count ].min_x1 )
	SetNull ( i_st_wo_item [ l_i_count ].min_x2 )
	SetNull ( i_st_wo_item [ l_i_count ].min_y1 )
	SetNull ( i_st_wo_item [ l_i_count ].min_y2 )
	SetNull ( i_st_wo_item [ l_i_count ].min_width )
	SetNull ( i_st_wo_item [ l_i_count ].min_height )
	SetNull ( i_st_wo_item [ l_i_count ].max_x1 )
	SetNull ( i_st_wo_item [ l_i_count ].max_x2 )
	SetNull ( i_st_wo_item [ l_i_count ].max_y1 )
	SetNull ( i_st_wo_item [ l_i_count ].max_y2 )
	SetNull ( i_st_wo_item [ l_i_count ].max_width )
	SetNull ( i_st_wo_item [ l_i_count ].max_height )
	l_i_count ++
LOOP
end subroutine

on w_resize_base.create
call super::create
end on

on w_resize_base.destroy
call super::destroy
end on

event resize;call super::resize;POST EVENT ue_resize ( newwidth, newheight )
end event

event open;call super::open;wf_init_object_array ( )
end event

