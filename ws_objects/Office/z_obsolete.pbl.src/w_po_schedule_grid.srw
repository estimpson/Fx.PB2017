$PBExportHeader$w_po_schedule_grid.srw
$PBExportComments$(mrs) PO schedule grid
forward
global type w_po_schedule_grid from w_schedule_grid_base
end type
type uo_vendor6 from u_vendor_display within w_po_schedule_grid
end type
type uo_vendor5 from u_vendor_display within w_po_schedule_grid
end type
type uo_vendor4 from u_vendor_display within w_po_schedule_grid
end type
type uo_vendor3 from u_vendor_display within w_po_schedule_grid
end type
type uo_vendor2 from u_vendor_display within w_po_schedule_grid
end type
type uo_vendor1 from u_vendor_display within w_po_schedule_grid
end type
type gb_vendors from groupbox within w_po_schedule_grid
end type
end forward

global type w_po_schedule_grid from w_schedule_grid_base
string title = "PO Schedule"
string menuname = "m_po_schedule_grid"
string i_s_type = "P"
event ue_dragdrop_to_vendor pbm_custom12
event ue_popup_one pbm_custom13
event ue_popup_two pbm_custom14
event ue_visual_bom ( )
event ue_savedata ( )
uo_vendor6 uo_vendor6
uo_vendor5 uo_vendor5
uo_vendor4 uo_vendor4
uo_vendor3 uo_vendor3
uo_vendor2 uo_vendor2
uo_vendor1 uo_vendor1
gb_vendors gb_vendors
end type
global w_po_schedule_grid w_po_schedule_grid

type variables
BOOLEAN	ib_830_mode

INTEGER		ii_vendor_count = 6

STRING	i_s_type = 'P'

u_vendor_display	iuo_vendor_list [ ]
u_popup                  iuo_popup
end variables

forward prototypes
public subroutine wf_schedule_job ()
public subroutine wf_display_vendors (string as_part)
public subroutine wf_initialize_vendors ()
public subroutine wf_dragdrop_to_vendor (string a_s_vendor)
public function string wf_filter_vendor (string a_s_vendor)
public subroutine wf_build_values (string a_s_type)
end prototypes

event ue_dragdrop_to_vendor;long	ll_ptr
st_generic_structure lstr_parm
			
ll_ptr	= message.longparm

IF ll_ptr >= 1 AND ll_ptr <= ii_vendor_count THEN
	IF iuo_vendor_list[ ll_ptr ].st_vendor_code.text = 'ADD VENDOR PROFILE' THEN
			setnull ( lstr_parm.value1 )
			lstr_parm.value2 = is_key
			OpenSheetWithParm (w_smart_price_matrix,  lstr_parm, gnv_App.of_GetFrame(), 0, Original!)
	ELSE	
			wf_dragdrop_to_vendor( iuo_vendor_list[ ll_ptr ].st_vendor_code.text )
	END IF
END IF
end event

event ue_popup_one;s_parm_list	lstr_parm

lstr_parm.s_key_value		= is_key
lstr_parm.s_type		= ddlb_mode.text
lstr_parm.s_parm_list[1]	= 'P'	

if isvalid ( iuo_popup ) then closeuserobject ( iuo_popup )

OpenSheetWithParm( w_po_schedule_grid_detail_info, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )






	



end event

event ue_popup_two;s_parm_list	lstr_parm

st_generic_structure  l_st_parm

date		ld_start_date, &
			ld_end_date, &
			ld_date

CHOOSE CASE is_current_col

	CASE 'past'
		ld_start_date	=	relativedate ( id_date_clicked, -7 ) 
		ld_end_date		=  id_date_clicked 

	CASE 'future'
		ld_start_date	=	id_date_clicked
		ld_end_date		=  relativedate ( id_date_clicked, 365 )

	CASE ELSE
		ld_start_date	=  id_date_clicked 
		ld_end_date		=  relativedate( id_date_clicked, ii_mode ) 

END CHOOSE

lstr_parm.s_key_value		= uo_crosstab.Getitemstring ( il_current_row, 1 )
lstr_parm.s_parm_list[1]	= 'P'	
lstr_parm.d_parm_list[1]	= ld_start_date

if isvalid ( iuo_popup ) then closeuserobject ( iuo_popup )

OpenSheetWithParm( w_po_schedule_grid_status, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )


end event

event ue_visual_bom;IF il_current_row <=0 THEN 
	gnv_App.of_GetFrame().SetMicroHelp ( "Click on the part...." )
	gnv_App.of_GetFrame().SetMicroHelp ( "Ready" ) 
	RETURN
END IF

IF	uo_crosstab.GetItemString ( il_current_row, 1) > '' THEN
//	OpenWithParm ( w_bom_viewer, uo_crosstab.GetItemString ( il_current_row , 1 ) )
	OpenWithParm ( w_pg_vbom, uo_crosstab.GetItemString ( il_current_row , 1 ) )	
END IF
end event

event ue_savedata;SetPointer(Hourglass!)	
if uo_crosstab.SaveAs() = 1 then
	Messagebox ( Monsys.msg_title, "Saved the data successful!")
else
	Messagebox ( Monsys.msg_title, "Unable to save the data")
end if 	
SetPointer(Arrow!)
end event

public subroutine wf_schedule_job ();
end subroutine

public subroutine wf_display_vendors (string as_part);/* Declaration */
integer	li_ptr 
string	ls_vendor

/* Initialization */
FOR li_ptr = 1 TO 6
	iuo_vendor_list[li_ptr].visible	= FALSE
NEXT

/* Main Process */

//DECLARE cursor_vendor CURSOR FOR  
// SELECT vendor  
//   FROM part_vendor  
//  WHERE part = :as_part
//	AND  vendor > ''
//USING   SQLCA ;

//changed the select from a base file to a view, so that it could be customized 6/20/00

DECLARE	cursor_vendor CURSOR FOR  
SELECT	vendor  
FROM		mvw_vendorlist
WHERE		part = :as_part
USING   SQLCA ;

OPEN cursor_vendor;

FETCH cursor_vendor INTO :ls_vendor;

li_ptr = 0
gb_vendors.visible = TRUE

IF SQLCA.SQLCODE = 0 THEN
	
	DO WHILE ( li_ptr < 6 ) AND (SQLCA.SQLCode = 0)
		li_ptr ++
		iuo_vendor_list[ li_ptr ].st_vendor_code.text	= ls_vendor
		iuo_vendor_list[ li_ptr ].visible					= TRUE
		iuo_vendor_list[ li_ptr ].bringtotop				= TRUE
		FETCH cursor_vendor INTO :ls_vendor;
	LOOP

ELSEIF SQLCA.SQLCODE = 100 THEN
	
		li_ptr ++
		iuo_vendor_list[ li_ptr ].st_vendor_code.text	= 'ADD VENDOR PROFILE'
		iuo_vendor_list[ li_ptr ].visible					= TRUE
		iuo_vendor_list[ li_ptr ].bringtotop				= TRUE
	
END IF

CLOSE cursor_vendor;
end subroutine

public subroutine wf_initialize_vendors ();iuo_vendor_list[1]	=	uo_vendor1
iuo_vendor_list[2]	=	uo_vendor2
iuo_vendor_list[3]	=	uo_vendor3
iuo_vendor_list[4]	=	uo_vendor4
iuo_vendor_list[5]	=	uo_vendor5
iuo_vendor_list[6]	=	uo_vendor6
uo_vendor1.ii_ptr		= 1
uo_vendor2.ii_ptr		= 2
uo_vendor3.ii_ptr		= 3
uo_vendor4.ii_ptr		= 4
uo_vendor5.ii_ptr		= 5
uo_vendor6.ii_ptr		= 6
end subroutine

public subroutine wf_dragdrop_to_vendor (string a_s_vendor);/* Declaration */
s_parm_list	lstr_parm_list

/* Initialization */
lstr_parm_list.s_key_value		= is_key
lstr_parm_list.s_type			= ddlb_type.text
lstr_parm_list.s_parm_list[1]	= a_s_vendor
lstr_parm_list.s_parm_list[2]	= uo_crosstab.GetItemString ( il_current_row , "plant" )
lstr_parm_list.d_parm_list[1]	= id_start_date
lstr_parm_list.d_parm_list[2]	= id_date_clicked
lstr_parm_list.c_parm_list[1]	= ic_qty_clicked
lstr_parm_list.b_parm_list[1]	= ib_830_mode

/* Main Process */
OpenWithParm( w_po_schedule_grid_po_info, lstr_parm_list )
end subroutine

public function string wf_filter_vendor (string a_s_vendor);STRING 	l_s_part, &
			l_s_value

DECLARE msp_part_list CURSOR FOR
SELECT	part
FROM		part_vendor
WHERE		vendor = :a_s_vendor ;

OPEN  msp_part_list ;

FETCH msp_part_list INTO :l_s_part ;

DO WHILE (SQLCA.SQLCODE = 0)
	
	l_s_value = l_s_value + "part = '"+	l_s_part +"' OR "
	FETCH msp_part_list INTO :l_s_part ;

LOOP

CLOSE  msp_part_list ;

IF l_s_value > '' THEN 
	l_s_value = LeftA ( l_s_value, LenA ( l_s_value ) - 4 ) + "AND TYPE='P'"
ELSE
	l_s_value = "part = '' AND TYPE='P'"
END IF

RETURN l_s_value ;
end function

public subroutine wf_build_values (string a_s_type);datawindowchild l_dwc

dw_value.Reset ()

/* set the dddw name and columns */

CHOOSE CASE a_s_type

	CASE 'Commodity'
		dw_value.modify("data.dddw.name='d_dddw_commodity'")
		dw_value.modify("data.dddw.displaycolumn='id'")
		dw_value.modify("data.dddw.datacolumn='id'")

	CASE 'Vendor'
		dw_value.modify("data.dddw.name='d_dddw_vendors'")
		dw_value.modify("data.dddw.displaycolumn='code'")
		dw_value.modify("data.dddw.datacolumn='code'")

	CASE 'Plant'
		dw_value.modify("data.dddw.name='d_dddw_plants'")
		dw_value.modify("data.dddw.displaycolumn='destination'")
		dw_value.modify("data.dddw.datacolumn='destination'")

END CHOOSE

/* insert a row will 'all' options in it */
dw_value.insertrow(1)
dw_value.getchild ( "data" , l_dwc )

l_dwc.settransobject (sqlca)
l_dwc.retrieve ()

l_dwc.InsertRow ( 1 )
l_dwc.SetItem  ( 1, 1, 'All' )
l_dwc.SetItem  ( 1, 2, 'All' )

l_dwc.selectrow ( 0, false )



end subroutine

event ue_clicked_key_column;DECIMAL	lc_demand[]

INTEGER	li_col, &
			li_ptr

STRING	ls_date_list[], &
			ls_Check

s_parm_list lstr_parm

DATE	  ld_date

li_ptr	= 1

IF il_current_row > 0 THEN

	FOR li_ptr = 1 to 14
		ls_check = "total_qty_req_"+string ( li_ptr )
		lc_demand[li_ptr] = uo_crosstab.Getitemdecimal( il_current_row, ls_check ) //( uo_crosstab.demand_offset + li_ptr ) - 1 ) 
	NEXT

	ld_date = id_start_date

	FOR li_ptr = 1 to 7
		ls_date_list[ li_ptr ]	= string ( ld_date )
		ld_date = relativedate ( ld_date , ii_mode )
	NEXT

	lstr_parm.s_type		= ddlb_mode.text
	lstr_parm.s_key_value	=	is_key
	lstr_parm.s_parm_list	= 	ls_date_list
	lstr_parm.c_parm_list	= 	lc_demand
	lstr_parm.b_parm_list[1]	=	ib_830_mode

	OpenSheetWithParm( w_netout_po_grid, lstr_parm, gnv_App.of_GetFrame(), 0, Original! ) 

END IF
end event

on ue_display;call w_schedule_grid_base::ue_display;wf_display_vendors ( is_key )
end on

on ue_open;call w_schedule_grid_base::ue_open;wf_initialize_vendors ( )
end on

on ue_netout;call w_schedule_grid_base::ue_netout;m_po_schedule_grid.m_file.m_netout.Enabled = False
end on

event ue_build_crosstab;call super::ue_build_crosstab;/* 02-24-2000 KAZ Modified to return if the 'cancel' boolean is set to true, causing the
						event to exit directly, avoiding a watchdog error message.  Issue # 13223 */

if bcancel then return																								// ADD 02/24/2000 KAZ

if uo_crosstab.rowcount() > 0 then
	m_po_schedule_grid.m_file.m_netout.Enabled = TRUE
else
	m_po_schedule_grid.m_file.m_netout.Enabled = FALSE
end if 	
end event

on w_po_schedule_grid.create
int iCurrent
call super::create
if this.MenuName = "m_po_schedule_grid" then this.MenuID = create m_po_schedule_grid
this.uo_vendor6=create uo_vendor6
this.uo_vendor5=create uo_vendor5
this.uo_vendor4=create uo_vendor4
this.uo_vendor3=create uo_vendor3
this.uo_vendor2=create uo_vendor2
this.uo_vendor1=create uo_vendor1
this.gb_vendors=create gb_vendors
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_vendor6
this.Control[iCurrent+2]=this.uo_vendor5
this.Control[iCurrent+3]=this.uo_vendor4
this.Control[iCurrent+4]=this.uo_vendor3
this.Control[iCurrent+5]=this.uo_vendor2
this.Control[iCurrent+6]=this.uo_vendor1
this.Control[iCurrent+7]=this.gb_vendors
end on

on w_po_schedule_grid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_vendor6)
destroy(this.uo_vendor5)
destroy(this.uo_vendor4)
destroy(this.uo_vendor3)
destroy(this.uo_vendor2)
destroy(this.uo_vendor1)
destroy(this.gb_vendors)
end on

on resize;call w_schedule_grid_base::resize;IF IsValid ( uo_crosstab ) THEN
	gb_vendors.X		= uo_crosstab.X
	gb_vendors.y		= uo_crosstab.height + 230

	uo_vendor1.Y = gb_vendors.Y + 75
	uo_vendor2.Y = uo_vendor1.Y
	uo_vendor3.Y = uo_vendor2.Y
	uo_vendor4.Y = uo_vendor3.Y
	uo_vendor5.Y = uo_vendor4.Y
	uo_vendor6.Y = uo_vendor5.Y

	uo_vendor1.X = gb_vendors.X + 30
	uo_vendor2.X = uo_vendor1.X + 400
	uo_vendor3.X = uo_vendor2.X + 400
	uo_vendor4.X = uo_vendor3.X + 400
	uo_vendor5.X = uo_vendor4.X + 400
	uo_vendor6.X = uo_vendor5.X + 400
END IF
end on

type ddlb_type from w_schedule_grid_base`ddlb_type within w_po_schedule_grid
integer y = 16
long backcolor = 1090519039
string item[] = {"All parts","Commodity","Vendor","Plant"}
end type

event ddlb_type::selectionchanged;/* modified the script to make dw_value visible or otherwise */

STRING l_s_type

l_s_type = ddlb_type.Text

CHOOSE CASE l_s_type

	CASE 'All parts'
		dw_value.Visible = FALSE
		uo_crosstab.SetFilter ( "TYPE='P'" )
		uo_crosstab.Filter ( )

	CASE ELSE
		dw_value.Visible = TRUE
		wf_build_values ( text )

END CHOOSE


end event

type ddlb_mode from w_schedule_grid_base`ddlb_mode within w_po_schedule_grid
integer y = 16
long backcolor = 1090519039
end type

event ddlb_mode::selectionchanged;call super::selectionchanged;w_po_schedule_grid.Triggerevent ( 'ue_build_crosstab' )
end event

type dw_value from w_schedule_grid_base`dw_value within w_po_schedule_grid
boolean bringtotop = true
end type

event dw_value::itemchanged;STRING	l_s_type, &
			l_s_value

l_s_type = ddlb_type.Text

IF data = 'All' or data = '' THEN
	uo_crosstab.SetFilter ( "TYPE='P'" )
	uo_crosstab.Filter ( ) 
ELSE	
	
	CHOOSE CASE l_s_type
		CASE 'Commodity'
			uo_crosstab.SetFilter ( "commodity='"+data+"' AND TYPE='P'")
			uo_crosstab.Filter ( ) 
		CASE 'Vendor'
     		l_s_value = wf_filter_vendor ( data )
			uo_crosstab.SetFilter ( l_s_value )
			uo_crosstab.Filter ( ) 
		CASE 'Plant'
			uo_crosstab.SetFilter ( "plant='"+data+"' AND TYPE='P'" )
			uo_crosstab.Filter ( ) 
	END CHOOSE
	
END IF

uo_crosstab.groupcalc()
end event

type uo_vendor6 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 2569
integer y = 980
integer height = 84
integer taborder = 60
boolean border = false
end type

on constructor;call u_vendor_display::constructor;uo_vendor6.X = uo_vendor5.X + 430
end on

on uo_vendor6.destroy
call u_vendor_display::destroy
end on

type uo_vendor5 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 2066
integer y = 980
integer height = 84
integer taborder = 110
boolean border = false
end type

on dragdrop;call u_vendor_display::dragdrop;uo_vendor5.X = uo_vendor4.X + 430
end on

on uo_vendor5.destroy
call u_vendor_display::destroy
end on

type uo_vendor4 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 1499
integer y = 980
integer height = 80
integer taborder = 100
boolean border = false
end type

on constructor;call u_vendor_display::constructor;uo_vendor4.X = uo_vendor3.X + 430
end on

on uo_vendor4.destroy
call u_vendor_display::destroy
end on

type uo_vendor3 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 997
integer y = 980
integer height = 84
integer taborder = 90
boolean border = false
end type

on constructor;call u_vendor_display::constructor;uo_vendor3.X = uo_vendor2.X + 430
end on

on uo_vendor3.destroy
call u_vendor_display::destroy
end on

type uo_vendor2 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 521
integer y = 980
integer height = 84
integer taborder = 80
boolean border = false
end type

on constructor;call u_vendor_display::constructor;uo_vendor2.X = uo_vendor1.X + 430
end on

on uo_vendor2.destroy
call u_vendor_display::destroy
end on

type uo_vendor1 from u_vendor_display within w_po_schedule_grid
boolean visible = false
integer x = 55
integer y = 980
integer height = 80
integer taborder = 70
boolean border = false
end type

on constructor;call u_vendor_display::constructor;uo_vendor1.X = gb_vendors.X + 50
end on

on uo_vendor1.destroy
call u_vendor_display::destroy
end on

type gb_vendors from groupbox within w_po_schedule_grid
boolean visible = false
integer x = 18
integer y = 908
integer width = 2866
integer height = 180
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
string text = "Available Vendors"
end type

