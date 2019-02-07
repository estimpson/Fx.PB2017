$PBExportHeader$u_crosstab.sru
$PBExportComments$(mst) Added 'mode' to handle display beyond 'daily' and 'weekly'.
forward
global type u_crosstab from datawindow
end type
end forward

global type u_crosstab from datawindow
int Width=3954
int Height=920
int TabOrder=1
string DragIcon="Application!"
string DataObject="d_external_crosstab_plus"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
string Icon="Monitor.ico"
event ue_constructor pbm_custom01
event ue_rightclicked pbm_rbuttondown
end type
global u_crosstab u_crosstab

type variables
STRING             	i_s_type, &
		i_s_last_part, &
		part [ ]

INTEGER           	i_i_mode, &
		bucket_offset = 12, &
		demand_offset = 14, &
		assigned_offset = 0, &
		onhand_offset = 0, & 
		bucket [ ]

LONG	i_l_rows, &
	i_l_row, &
	origin [ ]

DOUBLE		demand [ ], demand2 [ ], &
		assigned [ ], assigned2 [ ], &
		onhand [ ], onhand2 [ ]

DATETIME	due [ ]

Window	i_w_parent
end variables

forward prototypes
public subroutine uf_display_date (date a_i_date, integer a_i_mode)
public subroutine uf_display_data (integer a_i_mode, datetime a_dt_start_date)
public function integer uf_map_data ()
public function integer uf_rewrite_data ()
Public function integer uf_set_parent (ref w_schedule_grid_base a_parent)
end prototypes

event ue_constructor;str_statusbar  l_str_parm

uf_display_date ( today(), 7 )

bCancel = FALSE
l_str_parm.title = 'Building Grid'
l_str_parm.enable_cancel = TRUE
Openwithparm ( w_progress_bar , l_str_parm )
uf_display_data ( i_i_mode, DateTime ( Today ( ) ) )
//Sort ( )
GroupCalc ( )
Close ( w_progress_bar )
bCancel = FALSE
end event

event ue_rightclicked;i_w_parent.PostEvent ( 'ue_double_clicked' )
end event

public subroutine uf_display_date (date a_i_date, integer a_i_mode);INTEGER 	l_i_count

STRING	l_s_string, &
			l_s_error

DATE		l_d_date

Return





end subroutine

public subroutine uf_display_data (integer a_i_mode, datetime a_dt_start_date);Pointer		l_ptr_old

l_ptr_old = SetPointer ( HourGlass! )
IF a_i_mode = 1 THEN
	Retrieve ( a_dt_start_date, 'D' )
ELSE
	Retrieve ( a_dt_start_date, 'W' )
END IF

RETURN
end subroutine

public function integer uf_map_data ();//LONG	l_l_row
//
//IF UpperBound ( part ) > 1 THEN
//	Return -1
//END IF
//i_l_rows = RowCount ( )
//w_progress_bar.cb_1.enabled = FALSE
//FOR l_l_row = 1 TO i_l_rows
//	part [ l_l_row ]		= object.part [ l_l_row ]
//	due [ l_l_row ]		= object.due_date [ l_l_row ]
//	assigned [ l_l_row ]	= object.qty_assigned [ l_l_row ]
//	demand [ l_l_row ]	= object.qnty [ l_l_row ]
//	origin [ l_l_row ]	= object.origin [ l_l_row ]
//	onhand [ l_l_row ]	= object.onhand [ l_l_row ]
//	bucket [ l_l_row ]	= object.bucket_no [ l_l_row ]
//	assigned2 [ l_l_row ]= assigned [ l_l_row ]
//	demand2 [ l_l_row ]	= demand [ l_l_row ]
//	onhand2 [ l_l_row ]	= onhand [ l_l_row ]
//	IF Int ( Mod ( 100 * l_l_row / i_l_rows, 10 ) ) = 1 THEN w_progress_bar.wf_setstatus ( "Finishing up...", 101 * l_l_row / i_l_rows )
//NEXT
Return 0
end function

public function integer uf_rewrite_data ();LONG	l_l_row

SetRedraw ( FALSE )
w_progress_bar.cb_1.enabled = FALSE
FOR l_l_row = 1 TO i_l_rows
	IF assigned2 [ l_l_row ] <> assigned [ l_l_row ] THEN
		INTEGER l_l_assigned_offset
		l_l_assigned_offset = bucket [ l_l_row ] + assigned_offset
		object.data [ l_l_row, bucket [ l_l_row ] + assigned_offset ] = assigned [ l_l_row ]
		object.qty_assigned [ l_l_row ] = assigned [ l_l_row ]
	END IF
	IF onhand2 [ l_l_row ] <> onhand [ l_l_row ] THEN
		INTEGER l_l_onhand_offset
		l_l_onhand_offset = bucket [ l_l_row ] + onhand_offset
		object.data [ l_l_row, bucket [ l_l_row ] + onhand_offset ] = onhand [ l_l_row ]
		object.onhand [ l_l_row ] = onhand [ l_l_row ]
	END IF
	IF Int ( Mod ( 100 * l_l_row / i_l_rows, 10 ) ) = 1 THEN w_progress_bar.wf_setstatus ( "Finishing up...", 101 * l_l_row / i_l_rows )
NEXT
SetRedraw ( TRUE )
Return 0
end function

Public function integer uf_set_parent (ref w_schedule_grid_base a_parent);i_w_parent = a_parent
IF IsValid ( i_w_parent ) THEN
	Return 0
ELSE
	Return -1
END IF
end function

event clicked;i_w_parent.PostEvent ( 'ue_clicked' )
end event

event retrieverow;STRING l_s_part

w_progress_bar.cb_1.enabled = TRUE
i_l_row ++

l_s_part = object.part [ i_l_row ]
IF i_s_last_part <> l_s_part THEN
	IF i_l_rows > 0 THEN
		w_progress_bar.wf_setstatus ( "Part: " + l_s_part, 101 * i_l_row / i_l_rows )
	END IF
END IF
i_s_last_part = l_s_part
IF bCancel THEN
	Return 1
END IF
end event

on constructor;SetTransObject ( SQLCA )
//PostEvent ( 'ue_constructor' )
end on

event retrievestart;w_progress_bar.wf_setstatus ( "Initializing...", 0 )
w_progress_bar.cb_1.enabled = FALSE

i_l_row = 0
Return SQLCA.uf_get_prod_grid_rows ( i_l_rows )
end event

