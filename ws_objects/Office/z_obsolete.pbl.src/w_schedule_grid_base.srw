$PBExportHeader$w_schedule_grid_base.srw
forward
global type w_schedule_grid_base from w_sheet_4t
end type
type ddlb_type from dropdownlistbox within w_schedule_grid_base
end type
type ddlb_mode from dropdownlistbox within w_schedule_grid_base
end type
type dw_value from datawindow within w_schedule_grid_base
end type
end forward

global type w_schedule_grid_base from w_sheet_4t
int X=1074
int Y=480
int Width=3872
int Height=2128
boolean TitleBar=true
string Title="Scheduling Grids Base"
long BackColor=78748035
event ue_open pbm_custom01
event ue_view_calendar pbm_custom02
event ue_build_crosstab pbm_custom03
event ue_drag_crosstab pbm_custom04
event ue_partial_updt_crosstab ( string a_s_part,  decimal a_n_qty )
event ue_netout pbm_custom06
event ue_clicked_key_column pbm_custom07
event ue_double_clicked pbm_custom08
event ue_clicked pbm_custom09
event ue_display pbm_custom10
event ue_print pbm_custom11
ddlb_type ddlb_type
ddlb_mode ddlb_mode
dw_value dw_value
end type
global w_schedule_grid_base w_schedule_grid_base

type variables
BOOLEAN ib_allow_drag = TRUE

DATE    id_start_date, &
            id_date_clicked

DECIMAL	ic_qty_clicked

INTEGER		ii_count  = 0, &
		ii_key_col, &
		ii_mode = 7

LONG	il_current_row, &
	il_current_col

STRING	is_key, &
	is_current_col, &
	i_s_type

u_crosstab	uo_crosstab
u_popup                  iuo_popup
end variables

forward prototypes
public function decimal wf_calculate_qty ()
public subroutine wf_build_values (string a_s_type)
public function integer wf_partial_build (string a_s_part, decimal a_n_quantity)
end prototypes

on ue_open;PostEvent ( 'ue_build_crosstab' )
end on

on ue_view_calendar;STRING 	ls_date 

OPENWITHPARM ( w_view_calendar, string ( id_start_Date ) )

ls_date  = Message.StringParm

IF ls_date > '' and ISDATE ( ls_date ) THEN
	id_start_date = Date ( ls_date )
	TriggerEvent ( 'ue_build_crosstab' )
END IF
end on

event ue_build_crosstab;/* 02-24-2000 KAZ Modified to return if the 'cancel' boolean is set to true, causing the
						event to exit directly, avoiding a watchdog error message.  Issue # 13223 */

w_schedule_grid_base	l_w_sched_grid_base
l_w_sched_grid_base = this

str_statusbar  l_str_parm

bCancel = FALSE
l_str_parm.title = 'Building Crosstab'
l_str_parm.enable_cancel = TRUE
Openwithparm ( w_progress_bar , l_str_parm )

IF IsValid ( uo_crosstab ) THEN
	CloseUserObject ( uo_crosstab )
END IF
OpenUserObject ( uo_crosstab, 'u_crosstab', 19, 213 )
uo_crosstab.uf_set_parent ( l_w_sched_grid_base )

TriggerEvent ( 'resize' )

uo_crosstab.i_s_type = i_s_type
uo_crosstab.i_i_mode = ii_mode

// included this to reset the filters to Default - mb - 05/12/99 
IF ddlb_type.text <> 'All Parts' then 
	ddlb_type.text = 'All Parts'
	dw_value.visible = False
	dw_value.reset()
End if


uo_crosstab.Reset ( )
uo_crosstab.uf_display_data ( ii_mode, DateTime ( id_start_date ) )
if bcancel then 																										// ADD 02/24/2000 KAZ
	Close ( w_progress_bar )																							// ADD 02/24/2000 KAZ
	return																												// ADD 02/24/2000 KAZ
end if																													// ADD 02/24/2000 KAZ
uo_crosstab.Sort ( )
uo_crosstab.GroupCalc ( )

//uo_crosstab.uf_map_data ( )
uo_crosstab.SetFilter ( "type='" + i_s_type + "'" )
uo_crosstab.Filter ( )
Close ( w_progress_bar )
bCancel = FALSE


gnv_App.of_GetFrame().SetMicroHelp ( "Ready" )
end event

on ue_drag_crosstab;ib_allow_drag = TRUE
end on

event ue_partial_updt_crosstab;wf_partial_build ( a_s_part, a_n_qty )
//wf_partial_build ( uo_crosstab.GetItemString ( il_current_row, "part_value" ), Dec ( String(Message.LongParm, "address") ) )


end event

event ue_netout;//w_schedule_grid_base	l_w_prod_sched_base
//
//l_w_prod_sched_base = this
//
//OpenUserObject ( u_crosstab_netout )
//u_crosstab_netout.uf_set_parent ( l_w_prod_sched_base )
//u_crosstab_netout.BringToTop = TRUE
//u_crosstab_netout.TriggerEvent ( "ue_netout" )
//
//gnv_App.of_GetFrame().SetMicroHelp ( "Ready" )

//	Declarations
string	ls_PreviousFilter

n_cst_netout	ln_cst_netout

//	Initialize.
ln_cst_netout = create n_cst_netout

//	Remove filter.
ls_PreviousFilter = uo_crosstab.object.DataWindow.Table.Filter
uo_crosstab.SetFilter ( "" )
uo_crosstab.Filter ( )
uo_crosstab.Sort ( )

//	Netout.
ln_cst_netout.of_NetOut ( uo_crosstab )

//	Retore filter.
uo_crosstab.SetFilter ( ls_PreviousFilter )
uo_crosstab.Filter ( )
uo_crosstab.Sort ( )
end event

event ue_double_clicked;STRING	l_s_value, &
			l_s_band, &
			l_s_col, &
			l_s_parameters[]

INTEGER 	l_i_value, &
			l_i_pos

LONG		l_l_row

l_s_value = uo_crosstab.GetBandAtPointer( )
l_s_band	 = uo_crosstab.GetObjectAtPointer( )

l_i_value = uo_crosstab.GetColumn ( )

IF l_s_value > '' THEN
	l_i_pos	= PosA ( l_s_value, "~t", 1 )	
	l_l_row	= Long ( RightA ( l_s_value,  LenA ( l_s_value ) - l_i_pos ) )
END IF

IF l_s_band > '' THEN
	l_i_pos	= PosA ( l_s_band, "~t", 1 )	
	l_s_col	= LeftA ( l_s_band, l_i_pos - 1 ) 
	
	IF PosA ( l_s_band, 'date' ) > 0 OR PosA ( l_s_band, 'part_h' ) > 0  OR PosA ( l_s_band, 'past_h' ) > 0 THEN
		gnv_App.of_GetFrame().SetMicroHelp ( "Right Click on the grid" )
		RETURN
	END IF

END IF

IF l_l_row > 0 AND l_s_col > '' THEN

	il_current_row = l_l_row
	is_current_col = l_s_col
	is_key 			= uo_crosstab.GetItemString ( il_current_row , 1 )

	IF l_s_col <> 'part_value' THEN
		ic_qty_clicked	= uo_crosstab.GetItemDecimal ( il_current_row , l_s_col )

		CHOOSE CASE l_s_col
			
			CASE 'past'
				id_date_clicked = RelativeDate ( id_start_date ,  - 1  )				

			CASE 'future'
				id_date_clicked = RelativeDate ( id_start_date , ( ii_mode * 14 ) - 1 )

			CASE ELSE
		      l_i_value = Integer ( MidA ( is_current_col, 6, LenA ( is_current_col ) - 5 ) )
				id_date_clicked = RelativeDate ( id_start_date , ii_mode * ( l_i_value - 1 ) )
		
		END CHOOSE

	END IF

END IF

IF l_s_col = 'part_value' THEN
	Triggerevent( 'ue_clicked_key_column' )
ELSE
	openuserobject ( iuo_popup, PointerX() + 30, PointerY() + 30 ) // included this to popup the menu
	IF isvalid ( iuo_popup ) THEN iuo_popup.bringtotop = TRUE
END IF

end event

event ue_clicked;STRING	l_s_value, &
			l_s_band, &
			l_s_col

INTEGER 	l_i_value, &
			l_i_pos

LONG		l_l_row

l_s_value = uo_crosstab.GetBandAtPointer( )
l_s_band	 = uo_crosstab.GetObjectAtPointer( )

l_i_value = uo_crosstab.GetColumn ( )

// included this statement to close the user object if user object is still open - mb
IF isvalid ( iuo_popup ) THEN CLOSEUSEROBJECT ( iuo_popup )

IF l_s_value > '' THEN
	l_i_pos	= PosA ( l_s_value, "~t", 1 )	
	l_l_row	= Long ( RightA ( l_s_value,  LenA ( l_s_value ) - l_i_pos ) )
END IF

IF l_s_band > '' THEN
	l_i_pos	= PosA ( l_s_band, "~t", 1 )	
	l_s_col	= LeftA ( l_s_band, l_i_pos - 1 ) 

	// included this to check if the user clicked on header
	IF PosA ( l_s_band, 'date' ) > 0 OR PosA ( l_s_band, 'part_h' ) > 0 OR PosA ( l_s_band, 'past_h' ) > 0 THEN
		gnv_App.of_GetFrame().SetMicroHelp ( "Click on the grid value.." )
		RETURN
	END IF

END IF

IF l_l_row > 0 AND l_s_col > '' THEN
    
   IF il_current_row > 0 then uo_crosstab.SetItem ( il_current_row , 'curn_row','0' )		
		
	il_current_row = l_l_row
	is_current_col = l_s_col
	is_key 			= uo_crosstab.GetItemString ( il_current_row , 1 )
   uo_crosstab.SetItem ( il_current_row , 'curn_row', '1' )

	IF l_s_col <> 'part_value' THEN 
		
		ic_qty_clicked	= uo_crosstab.GetItemDecimal ( il_current_row , l_s_col )
		
		CHOOSE CASE l_s_col
			
			CASE 'past'
				id_date_clicked = RelativeDate ( id_start_date ,  - 1  )				

			CASE 'future'
				id_date_clicked = RelativeDate ( id_start_date , ( ii_mode * 14 ) - 1 )

			CASE ELSE
		      l_i_value = Integer ( MidA ( is_current_col, 6, LenA ( is_current_col ) - 5 ) )
				id_date_clicked = RelativeDate ( id_start_date , ii_mode * ( l_i_value - 1 ) )
				il_current_col	 = l_i_value
		
		END CHOOSE

	END IF

ELSE

	gnv_App.of_GetFrame().SetMicroHelp ( "Click on the grid value.." )

END IF

IF l_s_col <> 'part_value' and l_l_row > 0 THEN
	TriggerEvent ( 'ue_display' )

	IF ib_allow_drag THEN
		uo_crosstab.dragicon = 'MONITOR.ICO'
		uo_crosstab.drag( begin! )
		TriggerEvent( 'ue_drag_crosstab' )
	ELSE
		ic_qty_clicked	= 0
	END IF
END IF
end event

event ue_print;IF ISVALID ( iuo_popup ) THEN CLOSEUSEROBJECT ( iuo_popup )

IF ISVALID ( uo_crosstab ) THEN 
	uo_crosstab.object.datawindow.print.orientation = 1
	uo_crosstab.object.datawindow.print.DocumentName = 'Printing Grid'
	uo_crosstab.print()
END IF
end event

public function decimal wf_calculate_qty ();INTEGER  l_i_col

DECIMAL 	l_n_quantity = 0, &
			l_n_past_qty, &
			l_n_future_qty, &
			l_n_check

string 	l_s_check

l_n_past_qty	= uo_crosstab.GetItemDecimal ( il_current_row, 'past' )
l_n_future_qty	= uo_crosstab.GetItemDecimal ( il_current_row, 'future' )

CHOOSE CASE is_current_col

	CASE 'past'
		l_n_quantity	=	l_n_past_qty

	CASE 'future'
		FOR l_i_col = 1 to 14
			l_s_check	= "value"+string(l_i_col)
			l_n_quantity = l_n_quantity + uo_crosstab.GetItemDecimal ( il_current_row, l_s_check )
		NEXT
		l_n_quantity = l_n_quantity + l_n_future_qty + l_n_past_qty		
	
	CASE ELSE
		FOR l_i_col = 1 to il_current_col 
			l_s_check	= "value"+string(l_i_col)
			l_n_quantity = l_n_quantity + uo_crosstab.GetItemDecimal ( il_current_row, l_s_check )
		NEXT	
		l_n_quantity = l_n_quantity + l_n_past_qty

END CHOOSE
RETURN l_n_quantity
end function

public subroutine wf_build_values (string a_s_type);
end subroutine

public function integer wf_partial_build (string a_s_part, decimal a_n_quantity);str_statusbar  l_str_parm
long				l_l_row = 0,&
					l_l_first_row,&
					l_l_last_row,&
					l_l_bucket_no, &
					l_l_crosstab_rows
dec				l_n_qty_left,&
					l_n_grid_qty,&
					l_n_grid_assigned,&
					l_n_grid_onhand,&
					l_n_net, &
					ld_bucketdata

l_n_qty_left = a_n_quantity

bCancel = FALSE
l_str_parm.title = 'Building Crosstab'
l_str_parm.enable_cancel = TRUE
Openwithparm ( w_progress_bar , l_str_parm )
SetRedraw ( FALSE)

l_l_crosstab_rows = uo_crosstab.i_l_rows
l_l_first_row = uo_crosstab.Find ( "part='"+a_s_part+"'", 1, l_l_crosstab_rows )
l_l_last_row = uo_crosstab.FindGroupChange ( l_l_first_row + 1, 1 ) - 1

yield()
//system is unable to find the last row, assign first row to last row. 5/9/01

IF (l_l_last_row = -1 or l_l_last_row = 0) THEN l_l_last_row = l_l_crosstab_rows
IF l_l_first_row = 0 THEN l_l_last_row = -1

// 	Eliminate assigned by bucket
FOR l_l_row = l_l_first_row to l_l_last_row

	w_progress_bar.wf_setstatus ( "Part: " + a_s_part, ( l_l_row / l_l_last_row ) * 100 )

	IF l_n_qty_left > 0 THEN

		l_l_bucket_no 		= uo_crosstab.object.bucket_no [ l_l_row ]
		l_n_grid_qty 		= IsNull ( uo_crosstab.object.qnty [ l_l_row ], 0 )
		l_n_grid_assigned = IsNull ( uo_crosstab.object.qty_assigned [ l_l_row ], 0 )
		l_n_grid_onhand 	= IsNull ( uo_crosstab.object.onhand [ l_l_row ], 0 )
		l_n_net				= ( l_n_grid_qty - ( l_n_grid_assigned + l_n_grid_onhand ) )
					
		IF l_n_net > 0 THEN
			IF l_n_net < l_n_qty_left THEN
//				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.assigned_offset ] = l_n_grid_assigned + l_n_net
//				uo_crosstab.SetItem ( l_l_row, l_l_bucket_no + 16, l_n_grid_assigned + l_n_net )
//				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.assigned_offset ] = l_n_grid_assigned + l_n_net
				ld_bucketdata = uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.demand_offset ]
				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.demand_offset ] = ld_bucketdata - l_n_net				
//				uo_crosstab.SetItem ( l_l_row, l_l_bucket_no + uo_crosstab.c_i_assigned_offset, l_n_grid_assigned + l_n_net )
				uo_crosstab.object.qty_assigned [ l_l_row ] = l_n_grid_assigned + l_n_net
//				uo_crosstab.SetItem ( l_l_row, "qty_assigned", l_n_grid_assigned + l_n_net )
				l_n_qty_left -= l_n_net
			ELSE
//				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + 16 ] = l_n_grid_assigned + l_n_qty_left
//				uo_crosstab.SetItem ( l_l_row, l_l_bucket_no + 16, l_n_grid_assigned + l_n_qty_left )
//				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.assigned_offset ] = l_n_grid_assigned + l_n_qty_left
				ld_bucketdata = uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.demand_offset ]
				uo_crosstab.object.data [ l_l_row, l_l_bucket_no + uo_crosstab.demand_offset ] = ld_bucketdata - l_n_qty_left				
//				uo_crosstab.SetItem ( l_l_row, l_l_bucket_no + uo_crosstab.c_i_assigned_offset, l_n_grid_assigned + l_n_qty_left )
				uo_crosstab.object.qty_assigned [ l_l_row ] = l_n_grid_assigned + l_n_qty_left
//				uo_crosstab.SetItem ( l_l_row, "qty_assigned", l_n_grid_assigned + l_n_qty_left )
				l_n_qty_left = 0
			END IF
		END IF
	END IF
NEXT

//uo_crosstab.InsertRow ( 1 )
//uo_crosstab.DeleteRow ( 1 )
//
//uo_crosstab.Sort ( )
//IF il_current_row = 1 THEN uo_crosstab.DeleteRow ( 1 )

SetRedraw ( TRUE )
Close ( w_progress_bar )
bCancel = FALSE

//m_production_grid.m_file.m_netout.Enabled = TRUE
gnv_App.of_GetFrame().SetMicroHelp ( "Ready" )
return 1
end function

event close;CloseUserObject ( u_crosstab_netout )
CloseUserObject ( u_crosstab )
end event

on w_schedule_grid_base.create
this.ddlb_type=create ddlb_type
this.ddlb_mode=create ddlb_mode
this.dw_value=create dw_value
this.Control[]={this.ddlb_type,&
this.ddlb_mode,&
this.dw_value}
end on

on w_schedule_grid_base.destroy
destroy(this.ddlb_type)
destroy(this.ddlb_mode)
destroy(this.dw_value)
end on

on resize;IF IsValid ( uo_crosstab ) THEN
	uo_crosstab.height	= this.height - 2.5 * uo_crosstab.y
	uo_crosstab.width		= this.width - 25

	uo_crosstab.triggerevent( 	'ue_resize', 0, string( this.width ) + &
									',' + string ( this.height ) )
END IF
end on

event open; id_start_date = Today ()
 PostEvent ( 'ue_open' )
end event

type ddlb_type from dropdownlistbox within w_schedule_grid_base
int X=18
int Y=12
int Width=517
int Height=460
int TabOrder=10
string Text="All Parts"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_mode from dropdownlistbox within w_schedule_grid_base
int X=544
int Y=12
int Width=530
int Height=460
int TabOrder=20
string Text="Weekly"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Weekly",&
"Daily"}
end type

on selectionchanged;gnv_App.of_GetFrame().SetMicroHelp ( "You must rebuild the crosstab..." )

IF ddlb_mode.text = 'Daily' THEN
	ii_mode = 1
ELSE 
	ii_mode = 7
END IF


end on

type dw_value from datawindow within w_schedule_grid_base
int X=18
int Y=112
int Width=1056
int Height=92
int TabOrder=30
boolean Visible=false
string DataObject="d_external_drop_down_dw"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;datawindowchild l_dwc

this.getchild ( "data", l_dwc )

IF l_dwc.getrow() > 0 THEN
	l_dwc.selectrow ( 0 , false )
	l_dwc.selectrow ( l_dwc.getrow(), true ) 
END IF
end event

