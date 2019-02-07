$PBExportHeader$u_crosstab_netout.sru
forward
global type u_crosstab_netout from UserObject
end type
type cb_1 from commandbutton within u_crosstab_netout
end type
type cb_exit from commandbutton within u_crosstab_netout
end type
type cb_print from commandbutton within u_crosstab_netout
end type
type dw_part_list from datawindow within u_crosstab_netout
end type
type dw_low_level from datawindow within u_crosstab_netout
end type
type dw_onhand from datawindow within u_crosstab_netout
end type
type dw_exception from datawindow within u_crosstab_netout
end type
end forward

global type u_crosstab_netout from UserObject
int Width=2875
int Height=1300
boolean Border=true
long BackColor=79741120
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_netout pbm_custom01
cb_1 cb_1
cb_exit cb_exit
cb_print cb_print
dw_part_list dw_part_list
dw_low_level dw_low_level
dw_onhand dw_onhand
dw_exception dw_exception
end type
global u_crosstab_netout u_crosstab_netout

type variables
u_crosstab	i_uo_crosstab
u_netout_processed	i_uo_processed
w_schedule_grid_base	i_w_parent
end variables

forward prototypes
public function integer uf_netout (string a_s_part)
public function integer uf_set_parent (ref w_schedule_grid_base a_parent)
end prototypes

event ue_netout;LONG				l_l_count
str_statusbar	l_str_parm
string			l_s_previous_filter, &
					l_s_mode
					
DATETIME 		l_d_datetime

l_str_parm.title 	= "Netout"
l_str_parm.enable_cancel	= TRUE
OpenWithParm ( w_progress_bar, l_str_parm )

w_progress_bar.wf_setstatus ( "Initializing...", 0 )
dw_low_level.retrieve( '' )

l_s_previous_filter = i_uo_crosstab.Describe ( "DataWindow.Table.Filter" )

i_uo_crosstab.Setredraw ( FALSE )

l_d_datetime	= i_uo_crosstab.Getitemdatetime ( 1, 'date1' ) // store the first date the grid is built for

IF ISNULL ( l_d_datetime ) THEN l_d_Datetime = datetime ( today() )

i_uo_crosstab.SetFilter ( "" )
i_uo_crosstab.Filter ( )
i_uo_crosstab.Reset ()

// This is to retrieve the dw to take off the effects of filter 

IF i_uo_crosstab.i_i_mode <> 1 THEN
	i_uo_crosstab.Retrieve ( l_d_datetime, 'W' )
ELSE
	i_uo_crosstab.Retrieve ( l_d_datetime, 'D' )
END IF

dw_onhand.settransobject ( sqlca )

FOR l_l_count = 1 TO dw_low_level.RowCount ( )
	Yield ( )
	IF bCancel THEN
		l_l_count = dw_low_level.RowCount ( )
	ELSE
		w_progress_bar.wf_setstatus ( "Processing: " + dw_low_level.GetItemString ( l_l_count, "part" ), l_l_count / dw_low_level.RowCount ( ) * 100  )
		// Included this condition to prevent watch dog when the object doesn't have any onhand quantities - mb 06/04/99
		IF dw_onhand.Retrieve ( dw_low_level.GetItemString ( l_l_count, "part" ) ) > 0 THEN 
			IF dw_onhand.GetItemDecimal ( 1, "total_onhand" ) > 0 THEN
				dw_part_list.retrieve ( dw_low_level.GetItemString ( l_l_count, "part" ) )
				uf_netout ( dw_low_level.GetItemString ( l_l_count, "part" ) )
			END IF
		END IF
	END IF
NEXT

i_uo_crosstab.uf_rewrite_data ( )

Close ( w_progress_bar )

i_uo_crosstab.SetFilter ( l_s_previous_filter )
i_uo_crosstab.Filter ( )

i_uo_crosstab.Setredraw ( TRUE )

IF  dw_exception.Rowcount () > 0 THEN 	
	dw_exception.SetRedraw ( TRUE )
	u_crosstab_netout.VISIBLE  = TRUE
	u_crosstab_netout.X			= 0 //i_w_parent.X 
	u_crosstab_netout.Y			= 0 //i_w_parent.Y + 170
END IF
end event

public function integer uf_netout (string a_s_part);STRING	l_s_part

LONG		l_l_onhandcount,&
			l_l_onhand_origin,&
			l_l_origin,&
			l_l_partlist_row,&
			l_l_bucket_no,&
			l_l_first_row,&
			l_l_last_row,&
			l_l_row,&
			l_l_processedrow, &
			l_l_onhand_rows, &
			l_l_processed_row, &
			l_l_exception_row, &
			l_l_part_list_rows, &
			l_l_crosstab_rows

DECIMAL	l_n_onhand,&
			l_n_grid_qty,&
			l_n_bom_qty, &
			l_n_grid_onhand, &
			l_n_grid_assigned,&
			l_n_net,&
			l_n_extended

DATETIME	l_dt_due

// 	Get first and last row in grid for current part
l_s_part = a_s_part

l_l_crosstab_rows = i_uo_crosstab.i_l_rows
l_l_first_row = i_uo_crosstab.Find ( "part='"+l_s_part+"'", 1, l_l_crosstab_rows )
l_l_last_row = i_uo_crosstab.FindGroupChange ( l_l_first_row + 1, 1 )  - 1
IF l_l_last_row = -1 THEN l_l_last_row = l_l_crosstab_rows
IF l_l_first_row = 0 THEN l_l_last_row = -1

//dw_processed.Reset ( )
IF IsValid ( i_uo_processed ) THEN
	DESTROY i_uo_processed
END IF
i_uo_processed = CREATE u_netout_processed

//		Process onhand by origin
l_l_onhand_rows = dw_onhand.RowCount ( )

FOR l_l_onhandcount = 1 TO l_l_onhand_rows

	l_l_onhand_origin = IsNull ( dw_onhand.object.origin [ l_l_onhandcount ], 0 )
	l_n_onhand = IsNull ( dw_onhand.object.onhand [ l_l_onhandcount ], 0 )

	//		Eliminate net requirements by bucket
	FOR l_l_row = l_l_first_row to l_l_last_row

		l_l_bucket_no 		= i_uo_crosstab.bucket [ l_l_row ] + 4
		l_n_grid_qty 		= i_uo_crosstab.demand [ l_l_row ]
		l_n_grid_assigned = i_uo_crosstab.assigned [ l_l_row ]
		l_n_grid_onhand 	= i_uo_crosstab.onhand [ l_l_row ]
		l_l_origin			= i_uo_crosstab.origin [ l_l_row ]
		l_n_net				= ( l_n_grid_qty - ( l_n_grid_assigned + l_n_grid_onhand ) )
				
		IF l_n_net > 0 THEN
			IF l_n_net < l_n_onhand AND ( l_l_origin = l_l_onhand_origin OR l_l_onhand_origin = 0 ) THEN
				i_uo_crosstab.onhand [ l_l_row ] = l_n_net + l_n_grid_onhand
				l_n_onhand = l_n_onhand - l_n_net
				i_uo_processed.rows++
				i_uo_processed.part [ i_uo_processed.rows ] = l_s_part
				i_uo_processed.origin [ i_uo_processed.rows ] = 0 // l_l_origin
				i_uo_processed.quantity [ i_uo_processed.rows ] = l_n_net
			ELSEIF l_l_origin = l_l_onhand_origin OR l_l_onhand_origin = 0 THEN
				i_uo_crosstab.onhand [ l_l_row ] = l_n_onhand + l_n_grid_onhand
				i_uo_processed.rows++
				i_uo_processed.part [ i_uo_processed.rows ] = l_s_part
				i_uo_processed.origin [ i_uo_processed.rows ] = 0 // l_l_origin
				i_uo_processed.quantity [ i_uo_processed.rows ] = l_n_onhand
				l_n_onhand = 0
			END IF
		END IF
	NEXT		

	// 	Eliminate assigned by bucket
	IF l_n_onhand > 0 THEN
		FOR l_l_row = l_l_first_row to l_l_last_row

			l_l_bucket_no 		= i_uo_crosstab.bucket [ l_l_row ] + 4
			l_n_grid_assigned = i_uo_crosstab.assigned [ l_l_row ]
			l_n_grid_onhand 	= i_uo_crosstab.onhand [ l_l_row ]
			l_l_origin			= i_uo_crosstab.origin [ l_l_row ]
			l_dt_due				= i_uo_crosstab.due [ l_l_row ]

			IF l_n_grid_assigned > 0 THEN
				IF l_n_grid_assigned < l_n_onhand AND ( l_l_origin = l_l_onhand_origin OR l_l_onhand_origin = 0 ) THEN
					i_uo_crosstab.assigned [ l_l_row ] = 0
					i_uo_crosstab.onhand [ l_l_row ] = l_n_grid_onhand + l_n_grid_assigned
					i_uo_processed.rows++
					i_uo_processed.part [ i_uo_processed.rows ] = l_s_part
					i_uo_processed.origin [ i_uo_processed.rows ] = 0 // l_l_origin
					i_uo_processed.quantity [ i_uo_processed.rows ] = l_n_grid_assigned
					l_l_exception_row = dw_exception.Insertrow ( 0 )
					dw_exception.object.part [ l_l_exception_row ] = l_s_part
					dw_exception.object.origin [ l_l_exception_row ] = l_l_origin
					dw_exception.object.quantity [ l_l_exception_row ] = l_n_grid_assigned
					dw_exception.object.due [ l_l_exception_row ] = l_dt_due
					dw_exception.object.status [ l_l_exception_row ] = 'Over Scheduled'
					l_n_onhand = l_n_onhand - l_n_grid_assigned
				ELSEIF l_l_origin = l_l_onhand_origin OR l_l_onhand_origin = 0 THEN
					i_uo_crosstab.assigned [ l_l_row ] = l_n_grid_assigned - l_n_onhand
					i_uo_crosstab.onhand [ l_l_row ] = l_n_grid_onhand + l_n_onhand
					i_uo_processed.rows++
					i_uo_processed.part [ i_uo_processed.rows ] = l_s_part
					i_uo_processed.origin [ i_uo_processed.rows ] = 0 // l_l_origin
					i_uo_processed.quantity [ i_uo_processed.rows ] = l_n_onhand
					l_l_exception_row = dw_exception.Insertrow ( 0 )
					dw_exception.object.part [ l_l_exception_row ] = l_s_part
					dw_exception.object.origin [ l_l_exception_row ] = l_l_origin
					dw_exception.object.quantity [ l_l_exception_row ] = l_n_onhand
					dw_exception.object.due [ l_l_exception_row ] = l_dt_due
					dw_exception.object.status [ l_l_exception_row ] = 'Over Scheduled'
					l_n_onhand = 0
				END IF
			END IF
		NEXT
		IF l_n_onhand > 0 THEN
			l_l_exception_row = dw_exception.Insertrow ( 0 )
			dw_exception.object.part [ l_l_exception_row ] = l_s_part
			dw_exception.object.origin [ l_l_exception_row ] = l_l_origin
			dw_exception.object.quantity [ l_l_exception_row ] = l_n_onhand
			dw_exception.object.status [ l_l_exception_row ] = 'Excess Inventory'
		END IF
	END IF

NEXT

//		Process onhand by origin

l_l_processed_row = i_uo_processed.rows

FOR l_l_processedrow = 1 TO l_l_processed_row

	l_l_onhand_origin = i_uo_processed.origin [ l_l_processedrow ]
	l_n_onhand = i_uo_processed.quantity [ l_l_processedrow ]

	l_l_part_list_rows = dw_part_list.RowCount ( )
	FOR l_l_partlist_row = 2 to l_l_part_list_rows
	
		l_s_part = dw_part_list.object.part [ l_l_partlist_row ]
		l_n_bom_qty = dw_part_list.object.quantity [ l_l_partlist_row ]
		l_n_extended		= l_n_bom_qty * l_n_onhand

		// 	Get first and last row in grid for current part
		l_l_first_row = i_uo_crosstab.Find ( "part='"+l_s_part+"'", 1, l_l_crosstab_rows )
		l_l_last_row = i_uo_crosstab.FindGroupChange ( l_l_first_row + 1, 1 ) - 1
		IF l_l_last_row = -1 THEN l_l_last_row = l_l_crosstab_rows
		IF l_l_first_row = 0 THEN l_l_last_row = -1

		//		Eliminate net requirements by bucket
		FOR l_l_row = l_l_first_row to l_l_last_row
	
			l_l_bucket_no 		= i_uo_crosstab.bucket [ l_l_row ] + 4
			l_n_grid_qty 		= i_uo_crosstab.demand [ l_l_row ]
			l_n_grid_assigned = i_uo_crosstab.assigned [ l_l_row ]
			l_n_grid_onhand 	= i_uo_crosstab.onhand [ l_l_row ]
			l_l_origin			= i_uo_crosstab.origin [ l_l_row ]
			l_n_net				= ( l_n_grid_qty - ( l_n_grid_assigned + l_n_grid_onhand ) )
					
			IF l_n_net > 0 AND l_n_extended > 0 THEN
				IF l_n_net < l_n_extended AND ( l_l_origin = l_l_onhand_origin OR l_l_onhand_origin = 0 ) THEN
					i_uo_crosstab.onhand [ l_l_row ] = l_n_net + l_n_grid_onhand
					l_n_extended = l_n_extended - l_n_net
				ELSEIF ( l_l_origin = l_l_onhand_origin  OR l_l_onhand_origin = 0 )  THEN
					i_uo_crosstab.onhand [ l_l_row ] = l_n_extended + l_n_grid_onhand
					l_n_extended = 0
				END IF
			END IF
		NEXT		
	
		// 	Eliminate assigned by bucket
		IF l_n_extended > 0 THEN
			FOR l_l_row = l_l_first_row to l_l_last_row
	
				l_l_bucket_no 		= i_uo_crosstab.bucket [ l_l_row ] + 4
				l_n_grid_assigned = i_uo_crosstab.assigned [ l_l_row ]
				l_n_grid_onhand 	= i_uo_crosstab.onhand [ l_l_row ]
				l_l_origin			= i_uo_crosstab.origin [ l_l_row ]
				l_dt_due				= i_uo_crosstab.due [ l_l_row ]
	
				IF l_n_grid_assigned > 0 THEN
					IF l_n_grid_assigned < l_n_extended AND l_l_origin = l_l_onhand_origin THEN 
						i_uo_crosstab.assigned [ l_l_row ] = 0
						i_uo_crosstab.onhand [ l_l_row ] = l_n_grid_onhand + l_n_grid_assigned
						l_l_exception_row = dw_exception.Insertrow ( 0 )
						dw_exception.object.part [ l_l_exception_row ] = l_s_part
						dw_exception.object.origin [ l_l_exception_row ] = l_l_origin
						dw_exception.object.quantity [ l_l_exception_row ] = l_n_grid_assigned
						dw_exception.object.due [ l_l_exception_row ] = l_dt_due
						dw_exception.object.status [ l_l_exception_row ] = 'Over Scheduled'
						l_n_extended = l_n_extended - l_n_grid_assigned
					ELSEIF l_l_origin = l_l_onhand_origin THEN
						i_uo_crosstab.assigned [ l_l_row ] = l_n_grid_assigned - l_n_extended
						i_uo_crosstab.onhand [ l_l_row ] = l_n_grid_onhand + l_n_extended
						l_l_exception_row = dw_exception.Insertrow ( 0 )
						dw_exception.object.part [ l_l_exception_row ] = l_s_part
						dw_exception.object.origin [ l_l_exception_row ] = l_l_origin
						dw_exception.object.quantity [ l_l_exception_row ] = l_n_extended
						dw_exception.object.due [ l_l_exception_row ] = l_dt_due
						dw_exception.object.status [ l_l_exception_row ] = 'Over Scheduled'
						l_n_extended = 0
					END IF
				END IF
			NEXT
		END IF
	NEXT
NEXT

IF IsValid ( i_uo_processed ) THEN
	DESTROY i_uo_processed
END IF

Return 1
end function

public function integer uf_set_parent (ref w_schedule_grid_base a_parent);i_w_parent = a_parent
i_uo_crosstab = i_w_parent.uo_crosstab
Return 0
end function

event constructor;dw_exception.SetRedraw ( FALSE )
visible = FALSE
end event

on u_crosstab_netout.create
this.cb_1=create cb_1
this.cb_exit=create cb_exit
this.cb_print=create cb_print
this.dw_part_list=create dw_part_list
this.dw_low_level=create dw_low_level
this.dw_onhand=create dw_onhand
this.dw_exception=create dw_exception
this.Control[]={this.cb_1,&
this.cb_exit,&
this.cb_print,&
this.dw_part_list,&
this.dw_low_level,&
this.dw_onhand,&
this.dw_exception}
end on

on u_crosstab_netout.destroy
destroy(this.cb_1)
destroy(this.cb_exit)
destroy(this.cb_print)
destroy(this.dw_part_list)
destroy(this.dw_low_level)
destroy(this.dw_onhand)
destroy(this.dw_exception)
end on

type cb_1 from commandbutton within u_crosstab_netout
int X=1458
int Y=1128
int Width=439
int Height=104
int TabOrder=40
string Text="Save Rows As"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_exception.SaveAs ( )
end on

type cb_exit from commandbutton within u_crosstab_netout
int X=2331
int Y=1128
int Width=247
int Height=104
int TabOrder=30
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_w_parent.CloseUserObject ( u_crosstab_netout )
end on

type cb_print from commandbutton within u_crosstab_netout
int X=1993
int Y=1128
int Width=247
int Height=104
int TabOrder=20
string Text="Print"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_exception.Print ( )
i_w_parent.CloseUserObject ( u_crosstab_netout )
end on

type dw_part_list from datawindow within u_crosstab_netout
int X=539
int Y=16
int Width=494
int Height=360
int TabOrder=50
boolean Visible=false
string DataObject="d_grid_netout"
boolean LiveScroll=true
end type

on constructor;SetTransObject ( sqlca )
end on

type dw_low_level from datawindow within u_crosstab_netout
int X=18
int Y=16
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
string DataObject="d_grid_netout"
boolean LiveScroll=true
end type

on constructor;SetTransObject ( sqlca )
end on

type dw_onhand from datawindow within u_crosstab_netout
int X=1083
int Y=20
int Width=631
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="d_netout_onhand"
end type

on constructor;SetTransObject ( SQLCA )
end on

type dw_exception from datawindow within u_crosstab_netout
int X=9
int Y=12
int Width=2789
int Height=1092
string DataObject="d_crosstab_exception"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="MONITOR.ICO"
end type

