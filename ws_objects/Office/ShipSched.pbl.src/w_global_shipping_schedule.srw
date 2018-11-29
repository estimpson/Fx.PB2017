$PBExportHeader$w_global_shipping_schedule.srw
forward
global type w_global_shipping_schedule from w_sheet_4t
end type
type p_calendar from picture within w_global_shipping_schedule
end type
type st_1 from statictext within w_global_shipping_schedule
end type
type gb_shipperlineitem from u_gb within w_global_shipping_schedule
end type
type gb_shipschedule from u_gb within w_global_shipping_schedule
end type
type gb_releaseschedule from u_gb within w_global_shipping_schedule
end type
type gb_shipto from u_gb within w_global_shipping_schedule
end type
type st_hsplit1 from u_st_splitbar within w_global_shipping_schedule
end type
type st_hsplit2 from u_st_splitbar within w_global_shipping_schedule
end type
type st_vsplit1 from u_st_splitbar within w_global_shipping_schedule
end type
type dw_shipto from u_dw_shipto within w_global_shipping_schedule
end type
type dw_shipschedule from u_dw_shipschedule within w_global_shipping_schedule
end type
type dw_shipperlineitem from u_dw_shipperlineitem within w_global_shipping_schedule
end type
type em_date from u_em within w_global_shipping_schedule
end type
type dw_releaseschedule from u_dw_releaseschedule within w_global_shipping_schedule
end type
type st_d_shipper_detail_new from structure within w_global_shipping_schedule
end type
end forward

type st_d_shipper_detail_new from structure
	string		part
	datetime		due_datetime
	double		suggested
	string		um
	double		quantity
	double		standard_pack
	long		order_no
	string		customer_part
	long		suffix
	long		shipper
	string		note
end type

global type w_global_shipping_schedule from w_sheet_4t
integer width = 3813
integer height = 1364
string menuname = "m_global_shipping_schedule"
event type integer pfc_selectall ( )
event type integer pfc_clear ( )
event pfc_openshipper ( )
event pfc_normalshiptype ( )
event pfc_transfershiptype ( )
event pfc_outsideshiptype ( )
p_calendar p_calendar
st_1 st_1
gb_shipperlineitem gb_shipperlineitem
gb_shipschedule gb_shipschedule
gb_releaseschedule gb_releaseschedule
gb_shipto gb_shipto
st_hsplit1 st_hsplit1
st_hsplit2 st_hsplit2
st_vsplit1 st_vsplit1
dw_shipto dw_shipto
dw_shipschedule dw_shipschedule
dw_shipperlineitem dw_shipperlineitem
em_date em_date
dw_releaseschedule dw_releaseschedule
end type
global w_global_shipping_schedule w_global_shipping_schedule

type variables

Private:
constant char	NORMAL = 'N'
constant char	TRANSFER = 'T'
constant char	OUTSIDE = 'O'

char	ic_Mode = NORMAL

long	il_Shipper

string	is_Destination
string	is_Plant

end variables

forward prototypes
public function integer wf_showdestination ()
public function integer wf_showshipper ()
public function integer wf_scheduleshipper ()
public function integer wf_editshipper ()
public function integer wf_refresh ()
public function integer wf_setdate ()
end prototypes

event pfc_selectall;
//	Select all releases.
return dw_releaseschedule.of_SelectAll ( )
end event

event pfc_clear;
//	Select all releases.
return dw_releaseschedule.of_Clear ( )

end event

event pfc_openshipper;
//	Open shipper for editing.
wf_EditShipper ( )
end event

event pfc_normalshiptype;
//	Set mode.
ic_Mode = NORMAL

//	When ship type is changed, reset destination list so that selection goes back
//	to the top.  Otherwise, position is remember during refresh.
dw_shipto.Reset ( )

//	Call refresh window function.
wf_Refresh ( )

end event

event pfc_transfershiptype;
//	Set mode.
ic_Mode = TRANSFER

//	When ship type is changed, reset destination list so that selection goes back
//	to the top.  Otherwise, position is remember during refresh.
dw_shipto.Reset ( )

//	Call refresh window function.
wf_Refresh ( )

end event

event pfc_outsideshiptype;
//	Set mode.
ic_Mode = OUTSIDE

//	When ship type is changed, reset destination list so that selection goes back
//	to the top.  Otherwise, position is remember during refresh.
dw_shipto.Reset ( )

//	Call refresh window function.
wf_Refresh ( )

end event

public function integer wf_showdestination ();
//	At least one ship to...
if dw_shipto.GetRow ( ) > 0 then
//	Check to see if shipper was changed.  If so, reset ship schedule.
	if is_Destination <> dw_shipto.object.#1 [ dw_shipto.GetRow ( ) ] then
		dw_shipschedule.Reset ( )
	end if

//	Retrieve release schedule and ship schedule for destination.
	is_Destination = dw_shipto.object.#1 [ dw_shipto.GetRow ( ) ]
	dw_releaseschedule.Retrieve ( DateTime ( Date ( em_date.text ) ), is_Destination, is_plant, ic_Mode )
	if dw_shipschedule.Retrieve ( ic_Mode, is_Destination ,is_plant) = 0 then
		dw_shipperlineitem.Reset ( )
	end if
else
//	...Otherwise clear screen.
	dw_releaseschedule.Reset ( )
	dw_shipschedule.Reset ( )
	dw_shipperlineitem.Reset ( )
end if

return 0

end function

public function integer wf_showshipper ();
if dw_shipschedule.GetRow ( ) > 0 then
//	Retrieve release schedule and ship schedule for destination.
	il_Shipper = dw_shipschedule.object.shipper_id [ dw_shipschedule.GetRow ( ) ]
	dw_shipperlineitem.Reset ( )
	dw_shipperlineitem.Retrieve ( il_Shipper )
end if	

return 0
end function

public function integer wf_scheduleshipper ();
//	Declarations.
double	ldbl_Quantity [ ]

integer	li_ReturnRows
integer	li_Row

long	ll_OrderNo [ ]
long	ll_Sequence [ ]
long	ll_Suffix [ ]

string	ls_PartNumber [ ]

DataStore	lds_st_parm

st_d_shipper_detail_new	lst_shipper_detail_new_data

n_cst_associative_array	ln_cst_Parm

n_cst_tr_gss	ln_cst_TrGSS

if dw_shipschedule.GetRow ( ) > 0 then
	//	Initialization.
	lds_st_parm = CREATE DataStore
	lds_st_parm.DataObject = 'd_line_item_new'
	
	//	Get range from release schedule.
	dw_releaseschedule.of_GetRange ( ll_OrderNo, ll_Sequence, ldbl_Quantity, ls_PartNumber, ll_Suffix )
	
	//	Loop through all selected releaes.
	li_ReturnRows = UpperBound ( ll_OrderNo )
	for li_Row = 1 to li_ReturnRows
	
		//	Write transfer data from detail data structure to new data structure.
		ln_cst_TrGSS.of_GetOrderInfo ( ll_OrderNo [ li_Row ],&
			ll_Sequence [ li_Row ],&
			ls_PartNumber [ li_Row ],&
			ll_Suffix [ li_Row ],&
			lst_shipper_detail_new_data.due_datetime,&
			lst_shipper_detail_new_data.um,&
			lst_shipper_detail_new_data.standard_pack,&
			lst_shipper_detail_new_data.customer_part,&
			lst_shipper_detail_new_data.note )
		lst_shipper_detail_new_data.order_no = ll_OrderNo [ li_Row ]
		lst_shipper_detail_new_data.part = ls_PartNumber [ li_Row ]
		lst_shipper_detail_new_data.suffix = ll_Suffix [ li_Row ]
		lst_shipper_detail_new_data.shipper = -1
		lst_shipper_detail_new_data.suggested = ldbl_Quantity [ li_Row ]
		lst_shipper_detail_new_data.quantity = ldbl_Quantity [ li_Row ]
	
		//	Add row to those to be passed.
		lds_st_parm.InsertRow ( 0 )
		lds_st_parm.object.data [ li_Row ] = lst_shipper_detail_new_data
	next
	
	//	Generate parameters.
	ln_cst_Parm.of_SetItem ( "shipper detail", lds_st_parm )
	ln_cst_Parm.of_SetItem ( "shipper note", IsNull ( ( dw_shipschedule.object.shipper_notes [ 1 ] ), "" ) )
	ln_cst_Parm.of_SetItem ( "shipper id", il_Shipper )
	ln_cst_Parm.of_SetItem ( "shiptype", ic_Mode )
	ln_cst_Parm.of_SetItem ( "shipto", is_Destination )
	OpenWithParm ( w_shipper_manifest_new, ln_cst_Parm )
	
	//	Refresh screen.
	wf_ShowDestination ( )
end if

//	Return.
return 0

end function

public function integer wf_editshipper ();
//	Open response window for header info if shipper is valid.
if il_Shipper > 0 then
	OpenWithParm ( w_shipper_manifest, il_shipper, gnv_app.of_GetFrame ( ) )
	
	//	Refresh screen.
	wf_ShowDestination ( )
end if

//	Return.
return 0
end function

public function integer wf_refresh ();
//	Set the title of the destination list to indicate the shipper type.
choose case ic_Mode
	case NORMAL
		gb_shipto.Text = "Normal Shipper -- Ship To"
		Title = "Normal Shipper Mode"
	case TRANSFER
		gb_shipto.Text = "Transfer Shipper -- Ship To"
		Title = "Transfer Shipper Mode"
	case OUTSIDE
		gb_shipto.Text = "Outside Process Shipper -- Ship To"
		Title = "Outside Process Shipper Mode"
end choose

//	Retrieve Ship To datawindow.
dw_shipto.Retrieve (ic_Mode, DateTime(Date(em_date.text)), is_plant)

//	Return.
return 0

end function

public function integer wf_setdate ();
//	Retrieve Ship To datawindow.
wf_Refresh ( )

//	Return.
return 0

end function

event pfc_refresh;call super::pfc_refresh;
//	Call refresh window function.
wf_Refresh ( )

end event

on w_global_shipping_schedule.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_global_shipping_schedule" then this.MenuID = create m_global_shipping_schedule
this.p_calendar=create p_calendar
this.st_1=create st_1
this.gb_shipperlineitem=create gb_shipperlineitem
this.gb_shipschedule=create gb_shipschedule
this.gb_releaseschedule=create gb_releaseschedule
this.gb_shipto=create gb_shipto
this.st_hsplit1=create st_hsplit1
this.st_hsplit2=create st_hsplit2
this.st_vsplit1=create st_vsplit1
this.dw_shipto=create dw_shipto
this.dw_shipschedule=create dw_shipschedule
this.dw_shipperlineitem=create dw_shipperlineitem
this.em_date=create em_date
this.dw_releaseschedule=create dw_releaseschedule
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_calendar
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_shipperlineitem
this.Control[iCurrent+4]=this.gb_shipschedule
this.Control[iCurrent+5]=this.gb_releaseschedule
this.Control[iCurrent+6]=this.gb_shipto
this.Control[iCurrent+7]=this.st_hsplit1
this.Control[iCurrent+8]=this.st_hsplit2
this.Control[iCurrent+9]=this.st_vsplit1
this.Control[iCurrent+10]=this.dw_shipto
this.Control[iCurrent+11]=this.dw_shipschedule
this.Control[iCurrent+12]=this.dw_shipperlineitem
this.Control[iCurrent+13]=this.em_date
this.Control[iCurrent+14]=this.dw_releaseschedule
end on

on w_global_shipping_schedule.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_calendar)
destroy(this.st_1)
destroy(this.gb_shipperlineitem)
destroy(this.gb_shipschedule)
destroy(this.gb_releaseschedule)
destroy(this.gb_shipto)
destroy(this.st_hsplit1)
destroy(this.st_hsplit2)
destroy(this.st_vsplit1)
destroy(this.dw_shipto)
destroy(this.dw_shipschedule)
destroy(this.dw_shipperlineitem)
destroy(this.em_date)
destroy(this.dw_releaseschedule)
end on

event pfc_preopen;call super::pfc_preopen;
//	Check for plant in message.
is_plant = Message.StringParm
if mid ( is_plant, 1, 2) = 'w_' then
	SetNull ( is_Plant )
end if
if is_Plant = '' then
	SetNull(is_Plant)
end if


//	Setup resize.
of_SetResize ( true )
inv_resize.of_Register ( gb_shipto, 0, 0, 0, 100 )
inv_resize.of_Register ( dw_shipto, 0, 0, 0, 100 )
inv_resize.of_Register ( st_vsplit1, 0, 0, 0, 100 )
inv_resize.of_Register ( gb_releaseschedule, 0, 0, 100, 33 )
inv_resize.of_Register ( dw_releaseschedule, 0, 0, 100, 33 )
inv_resize.of_Register ( st_hsplit1, 0, 33, 100, 0 )
inv_resize.of_Register ( gb_shipschedule, 0, 33, 100, 33 )
inv_resize.of_Register ( dw_shipschedule, 0, 33, 100, 33 )
inv_resize.of_Register ( st_hsplit2, 0, 66, 100, 0 )
inv_resize.of_Register ( gb_shipperlineitem, 0, 66, 100, 34 )
inv_resize.of_Register ( dw_shipperlineitem, 0, 66, 100, 34 )

//	Setup splitter panes.
st_vsplit1.of_Register ( gb_shipto, st_vsplit1.LEFT )
st_vsplit1.of_Register ( dw_shipto, st_vsplit1.LEFT )
st_vsplit1.of_Register ( gb_releaseschedule, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( dw_releaseschedule, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( st_hsplit1, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( gb_shipschedule, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( dw_shipschedule, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( st_hsplit2, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( gb_shipperlineitem, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( dw_shipperlineitem, st_vsplit1.RIGHT )
st_hsplit1.of_Register ( gb_releaseschedule, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( dw_releaseschedule, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( gb_shipschedule, st_hsplit1.BELOW )
st_hsplit1.of_Register ( dw_shipschedule, st_hsplit1.BELOW )
st_hsplit2.of_Register ( gb_shipschedule, st_hsplit2.ABOVE )
st_hsplit2.of_Register ( dw_shipschedule, st_hsplit2.ABOVE )
st_hsplit2.of_Register ( gb_shipperlineitem, st_hsplit2.BELOW )
st_hsplit2.of_Register ( dw_shipperlineitem, st_hsplit2.BELOW )

//	Disable autosave prompting.
of_SetUpdateable ( false )

end event

event pfc_new;call super::pfc_new;
//	Schedule new shipper.
wf_ScheduleShipper ( )
end event

event pfc_postopen;call super::pfc_postopen;
//	Set focus to date control.
em_date.SetFocus ( )

end event

type p_calendar from picture within w_global_shipping_schedule
integer x = 631
integer y = 64
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "calendar.bmp"
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;
em_date.event pfc_DDCalendar()

end event

type st_1 from statictext within w_global_shipping_schedule
integer x = 27
integer y = 72
integer width = 238
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Start Date:"
boolean focusrectangle = false
end type

type gb_shipperlineitem from u_gb within w_global_shipping_schedule
integer x = 1934
integer y = 780
integer width = 1819
integer height = 380
integer taborder = 0
long backcolor = 1073741824
string text = "Shipper Line Item"
end type

type gb_shipschedule from u_gb within w_global_shipping_schedule
integer x = 1934
integer y = 396
integer width = 1819
integer height = 380
integer taborder = 0
long backcolor = 1073741824
string text = "Ship Schedule"
end type

type gb_releaseschedule from u_gb within w_global_shipping_schedule
integer x = 1934
integer y = 4
integer width = 1819
integer height = 380
integer taborder = 0
long backcolor = 1073741824
string text = "Release Schedule"
end type

type gb_shipto from u_gb within w_global_shipping_schedule
integer x = 14
integer y = 4
integer width = 1893
integer height = 1156
integer taborder = 0
long backcolor = 1073741824
string text = "Ship To"
end type

type st_hsplit1 from u_st_splitbar within w_global_shipping_schedule
integer x = 1934
integer y = 380
integer width = 1819
boolean bringtotop = true
end type

type st_hsplit2 from u_st_splitbar within w_global_shipping_schedule
integer x = 1934
integer y = 768
integer width = 1819
boolean bringtotop = true
end type

type st_vsplit1 from u_st_splitbar within w_global_shipping_schedule
integer x = 1911
integer width = 18
integer height = 1152
boolean bringtotop = true
end type

type dw_shipto from u_dw_shipto within w_global_shipping_schedule
integer x = 18
integer y = 148
integer width = 1883
integer height = 1004
integer taborder = 30
boolean bringtotop = true
end type

event ue_rowchanged;call super::ue_rowchanged;
//	Select shipto as current and setup screen.
post function wf_ShowDestination ( )

end event

type dw_shipschedule from u_dw_shipschedule within w_global_shipping_schedule
integer x = 1947
integer y = 460
integer width = 1792
integer height = 300
integer taborder = 40
boolean bringtotop = true
end type

event retrieveend;call super::retrieveend;
//	Select shipto as current and setup screen.
if GetRow ( ) > 0 then
	post function wf_ShowShipper ( )
end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//	Enable open shipper button if not on first row.
m_global_shipping_schedule.m_file.m_open.enabled = currentrow > 1

end event

event dragdrop;call super::dragdrop;
//	Check type of drag object and take appropriate action.
choose case source.tag
	case "releaseschedule"
		wf_ScheduleShipper ( )
end choose

end event

event doubleclicked;call super::doubleclicked;
//	Open shipper for editing.
wf_EditShipper ( )
end event

event ue_rowchanged;call super::ue_rowchanged;
//	Select shipto as current and setup screen.
if currentrow > 0 then
	post function wf_ShowShipper ( )
end if
end event

type dw_shipperlineitem from u_dw_shipperlineitem within w_global_shipping_schedule
integer x = 1947
integer y = 848
integer width = 1792
integer height = 300
integer taborder = 0
boolean bringtotop = true
end type

type em_date from u_em within w_global_shipping_schedule
integer x = 283
integer y = 60
integer width = 315
integer height = 76
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long textcolor = 33554432
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

event modified;
//	Call Set Date window function.
wf_SetDate ( )

end event

event constructor;
text = String(Today())

//	Call Set Date window function.
wf_SetDate ( )

//	Enable calendar control.
this.of_SetDropDownCalendar(true)
this.iuo_Calendar.of_SetDropDown(true)

end event

type dw_releaseschedule from u_dw_releaseschedule within w_global_shipping_schedule
string tag = "releaseschedule"
integer x = 1947
integer y = 76
integer width = 1792
integer height = 292
integer taborder = 20
string dragicon = "AppRectangle!"
boolean bringtotop = true
end type

event ue_rangecleared;call super::ue_rangecleared;
//	Disable new shipper.
if m_global_shipping_schedule.m_file.m_new.enabled then m_global_shipping_schedule.m_file.m_new.enabled = false
end event

event ue_rangeselected;call super::ue_rangeselected;
//	Enable new shipper.
if not m_global_shipping_schedule.m_file.m_new.enabled then m_global_shipping_schedule.m_file.m_new.enabled = true
end event

