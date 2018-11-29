$PBExportHeader$w_shipper_manifest.srw
$PBExportComments$gss
forward
global type w_shipper_manifest from w_shipper_header_info
end type
type cb_autoadjust from commandbutton within w_shipper_manifest
end type
type cb_reconcile from commandbutton within w_shipper_manifest
end type
type cb_reschedule from commandbutton within w_shipper_manifest
end type
type dw_shipper_detail from u_dw within w_shipper_manifest
end type
type gb_1 from groupbox within w_shipper_manifest
end type
type st_d_shipper_detail from structure within w_shipper_manifest
end type
type st_d_shipper_detail_new from structure within w_shipper_manifest
end type
end forward

type st_d_shipper_detail from structure
	decimal {6}	qty_required
	decimal {6}	qty_packed
	string		note
	long		boxes_staged
	decimal {6}	alternative_qty
	string		alternative_unit
	string		customer_part
	long		suffix
	string		part_original
	character		stage_using_weights
	decimal {6}	gross_weight
	decimal {6}	orig_required
	long		shipper
	string		part
	long		order_no
	decimal {6}	standard_pack
	datetime		due_date
end type

type st_d_shipper_detail_new from structure
	string		part
	datetime		due_datetime
	decimal {6}	suggested
	string		um
	decimal {6}	quantity
	decimal {6}	standard_pack
	long		order_no
	string		customer_part
	long		suffix
	long		shipper
	string		note
end type

global type w_shipper_manifest from w_shipper_header_info
integer y = 4
integer width = 4096
integer height = 2376
cb_autoadjust cb_autoadjust
cb_reconcile cb_reconcile
cb_reschedule cb_reschedule
dw_shipper_detail dw_shipper_detail
gb_1 gb_1
end type
global w_shipper_manifest w_shipper_manifest

type variables

end variables

forward prototypes
public function integer wf_update()
public function integer wf_modifiedcount()
end prototypes

public function integer wf_update();
//	Declarations.
integer	li_ReturnValue
long ll_row, ll_button

bll_GSS GSS

DataStore lds_shipping_containers_check
lds_shipping_containers_check  = Create DataStore
lds_shipping_containers_check.DataObject = 'd_shipping_containers_check'
lds_shipping_containers_check.SetTranSobject(SQLCA)

ll_row = lds_shipping_containers_check.retrieve(il_shipper)
if ll_row > 1 then
	ll_button = &
	Messagebox('Information', 'All information for shipping containers for this shipper will be deleted. Do you wish to continue?',Exclamation!, OKCancel!, 1)
	if ll_button = 1 then
		do while ll_row > 0
			lds_shipping_containers_check.deleterow(1)
			ll_row = lds_shipping_containers_check.rowcount()
		loop
		lds_shipping_containers_check.update()
		commit;
	else
		return FAILURE
	end if
end if
		

//	Update the shipper detail.
dw_shipper_detail.AcceptText()
if dw_shipper_detail.Update() = SUCCESS then

	//	Call super which updates header and commits.
	li_ReturnValue = super::wf_Update()
	
	//	Call reconcile shipper.
	choose case GSS.ReconcileShipper(il_shipper)
		case 0
			SQLCA.of_Commit()
			dw_shipper_detail.Retrieve(il_shipper)
		case -1
			SQLCA.of_Rollback()
			MessageBox(monsys.msg_title, "Shipper not found!")
		case -2
			SQLCA.of_Rollback()
			MessageBox(monsys.msg_title, "Shipper was already closed!")
		case -3
			SQLCA.of_Rollback()
			MessageBox(monsys.msg_title, "Invalid part was staged to this shipper!")
		case else
			SQLCA.of_Rollback()
			MessageBox(monsys.msg_title, "Error calling stored procedure, or undefined error code!  " + SQLCA.SQLErrText)
	end choose
else
	
	//	Update failed, rollback.
	SQLCA.of_Rollback()
	li_ReturnValue = FAILURE
end if

//	Return failure.
return li_ReturnValue

end function

public function integer wf_modifiedcount();
//	Return the sum of modified detail and shipper rows.
Return dw_shipper_detail.ModifiedCount() + dw_shipper.ModifiedCount()
end function

on w_shipper_manifest.create
int iCurrent
call super::create
this.cb_autoadjust=create cb_autoadjust
this.cb_reconcile=create cb_reconcile
this.cb_reschedule=create cb_reschedule
this.dw_shipper_detail=create dw_shipper_detail
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_autoadjust
this.Control[iCurrent+2]=this.cb_reconcile
this.Control[iCurrent+3]=this.cb_reschedule
this.Control[iCurrent+4]=this.dw_shipper_detail
this.Control[iCurrent+5]=this.gb_1
end on

on w_shipper_manifest.destroy
call super::destroy
destroy(this.cb_autoadjust)
destroy(this.cb_reconcile)
destroy(this.cb_reschedule)
destroy(this.dw_shipper_detail)
destroy(this.gb_1)
end on

event open;call super::open;IF il_shipper > 0 THEN
	dw_shipper.Retrieve(il_shipper)
	dw_shipper_detail.Retrieve(il_shipper)
END IF
end event

type cb_cancel from w_shipper_header_info`cb_cancel within w_shipper_manifest
integer x = 3552
integer y = 140
integer taborder = 40
end type

type cb_ok from w_shipper_header_info`cb_ok within w_shipper_manifest
integer x = 3552
integer y = 40
integer taborder = 30
end type

type cb_1 from w_shipper_header_info`cb_1 within w_shipper_manifest
integer x = 3552
integer y = 268
integer taborder = 50
end type

event cb_1::clicked;//////////////////////////////////////////////////////////////////////////////
//	Call the dock scheduler interface to delete the load
//string	ls_Return
//n_cst_docksched icst_DockSched
//ls_Return = icst_DockSched.of_DeleteLoad ( dw_shipper.GetItemNumber ( 1, "id" ) )
//if ls_Return > '' then
//	MessageBox ( "Dock Scheduler Error", ls_Return )
//	return FAILURE
//end if
//////////////////////////////////////////////////////////////////////////////
bll_GSS GSS

long shipperID
shipperID = dw_shipper.GetItemNumber(1, "id")
delete
	shipper_detail
where
	shipper = :shipperID  ;

commit  ;
close (parent)
end event

type dw_shipper from w_shipper_header_info`dw_shipper within w_shipper_manifest
integer x = 14
integer y = 12
integer height = 1068
end type

event dw_shipper::itemchanged;call super::itemchanged;string lst_name
long ll_row, ll_freight,ll_freight_region 

DataStore lds_default_freight
lds_default_freight  = Create DataStore
lds_default_freight.DataObject = 'd_get_default_freight_charge'
lds_default_freight.SetTranSobject(SQLCA)

DataStore lds_order_freight
lds_order_freight  = Create DataStore
lds_order_freight.DataObject = 'd_order_freight'
lds_order_freight.SetTranSobject(SQLCA)

DataStore lds_freight_region
lds_freight_region  = Create DataStore
lds_freight_region.DataObject = 'd_get_freight_region'
lds_freight_region.SetTranSobject(SQLCA)

ll_row = lds_freight_region.retrieve(dw_shipper.object.destination[1])
if ll_row > 0 then
	ll_freight_region = lds_freight_region.object.freightRegion[1]
end if




lst_name = dwo.name 

if lst_name = 'ship_via' then
	if dw_shipper_detail.rowcount() > 0 then
		ll_row = lds_order_freight.retrieve(dw_shipper_detail.object.order_no[1])
		if ll_row > 0 then
			ll_freight = lds_order_freight.object.freight[ll_row]
		else
			ll_freight = 0
		end if
	else
		ll_freight = 0
	end if
	if isnull(ll_freight) or ll_freight = 0 then
		ll_row = lds_default_freight.retrieve(data,this.object.trans_mode[row],ll_freight_region) 
		if ll_row > 0 then
			ll_freight = lds_default_freight.object.DefaultFreightCharge[ll_row]
			this.setItem(1, "freight", ll_freight)
		else
			ll_freight = 0
			this.setItem(1, "freight", ll_freight)
		end if
	end if
end if
	
if lst_name = 'trans_mode' then
	if dw_shipper_detail.rowcount() > 0 then
		ll_row = lds_order_freight.retrieve(dw_shipper_detail.object.order_no[1])
		if ll_row > 0 then
			ll_freight = lds_order_freight.object.freight[ll_row]
		else
			ll_freight = 0
		end if
	else
		ll_freight = 0
	end if
	if isnull(ll_freight) or ll_freight = 0 then
		ll_row = lds_default_freight.retrieve(this.object.ship_via[row],data,ll_freight_region) 
		if ll_row > 0 then
			ll_freight = lds_default_freight.object.DefaultFreightCharge[ll_row]
			this.setItem(1, "freight", ll_freight)
		else
			ll_freight = 0
			this.setItem(1, "freight", ll_freight)
		end if
	end if
end if	
end event

type cb_autoadjust from commandbutton within w_shipper_manifest
boolean visible = false
integer x = 1705
integer y = 1452
integer width = 361
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Auto Adjust"
end type

event clicked;
//	Declarations.
string	ls_SelectedParts [ ]

LONG	ll_linecount
LONG	ll_linecounter

DataStore	lds_st_parm

ll_linecount = dw_shipper_detail.RowCount()
for ll_linecounter = 1 TO ll_linecount
	dw_shipper_detail.object.qty_required [ ll_linecounter ] = IsNull(dw_shipper_detail.object.alternative_qty [ ll_linecounter ], 0)
	dw_shipper_detail.SelectRow(ll_linecounter, dw_shipper_detail.object.orig_required [ ll_linecounter ] > dw_shipper_detail.object.qty_required [ ll_linecounter ])
next

//	Check for selection.
ls_SelectedParts = dw_shipper_detail.object.part_original.selected

//	Enable or disable reschedule button depending on rows selected.
cb_reschedule.Enabled = UpperBound(ls_SelectedParts) > 0
end event

type cb_reconcile from commandbutton within w_shipper_manifest
boolean visible = false
integer x = 1705
integer y = 1348
integer width = 361
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reconcile"
end type

event clicked;
//	Call reconcile shipper.
choose case SQLCA.dynamic of_ReconcileShipper(il_shipper)
	case 0
		SQLCA.dynamic of_Commit()
		dw_shipper_detail.Retrieve(il_shipper)
	case -1
		SQLCA.dynamic of_Rollback()
		MessageBox(monsys.msg_title, "Shipper not found!")
	case -2
		SQLCA.dynamic of_Rollback()
		MessageBox(monsys.msg_title, "Shipper was already closed!")
	case -3
		SQLCA.dynamic of_Rollback()
		MessageBox(monsys.msg_title, "Invalid part was staged to this shipper!")
	case else
		SQLCA.dynamic of_Rollback()
		MessageBox(monsys.msg_title, "Error calling stored procedure, or undefined error code!  " + SQLCA.SQLErrText)
end choose
end event

type cb_reschedule from commandbutton within w_shipper_manifest
boolean visible = false
integer x = 3552
integer y = 392
integer width = 361
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reschedule..."
end type

event clicked;
//	Declarations.
long	ll_LineCount
long	ll_LineCounter

long	ll_RowCount

DataStore	lds_st_parm

st_d_shipper_detail	lst_shipper_detail_data [ ]
st_d_shipper_detail_new	lst_shipper_detail_new_data

n_cst_associative_array	ln_cst_Parm

//	Initialization.
lds_st_parm	= CREATE DataStore
lds_st_parm.DataObject = 'd_line_item_new'

//	Accept all keyboard entries.
dw_shipper.AcceptText()
dw_shipper_detail.AcceptText()

//	Copy data from detail to structures.
lst_shipper_detail_data = dw_shipper_detail.object.data

//	Loop through all detail lines.
ll_LineCount = UpperBound(lst_shipper_detail_data)
for ll_LineCounter = 1 to ll_LineCount
	
	//	Write transfer data from detail data structure to new data structure.
	lst_shipper_detail_new_data.part = lst_shipper_detail_data [ ll_LineCounter ].part_original
	lst_shipper_detail_new_data.due_datetime = lst_shipper_detail_data [ ll_LineCounter ].due_date
	lst_shipper_detail_new_data.um = lst_shipper_detail_data [ ll_LineCounter ].alternative_unit
	lst_shipper_detail_new_data.standard_pack = lst_shipper_detail_data [ ll_LineCounter ].standard_pack
	lst_shipper_detail_new_data.order_no = lst_shipper_detail_data [ ll_LineCounter ].order_no
	lst_shipper_detail_new_data.customer_part = lst_shipper_detail_data [ ll_LineCounter ].customer_part
	lst_shipper_detail_new_data.suffix = lst_shipper_detail_data [ ll_LineCounter ].suffix
	lst_shipper_detail_new_data.shipper = lst_shipper_detail_data [ ll_LineCounter ].shipper
	lst_shipper_detail_new_data.note = lst_shipper_detail_data [ ll_LineCounter ].note
	
	//	Supply remaining new data structure values from computed columns.
	lst_shipper_detail_new_data.suggested = dw_shipper_detail.object.adj_quantity [ ll_LineCounter ]
	lst_shipper_detail_new_data.quantity = dw_shipper_detail.object.adj_quantity [ ll_LineCounter ]

	//	If new quantity is more than zero, add row to those to be passed.
	if lst_shipper_detail_new_data.quantity > 0 then
		ll_RowCount = lds_st_parm.InsertRow(0)
		lds_st_parm.object.data [ ll_RowCount ] = lst_shipper_detail_new_data
	end if
next

//	Generate parameters.
ln_cst_Parm.of_SetItem("shipper detail", lds_st_parm)
ln_cst_Parm.of_SetItem("shipper note", IsNull((dw_shipper.object.notes [ 1 ]), ""))
OpenWithParm(w_shipper_manifest_new, ln_cst_Parm)
end event

type dw_shipper_detail from u_dw within w_shipper_manifest
integer x = 50
integer y = 1168
integer width = 4005
integer height = 1032
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_line_item_edit"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//	Turn the popup menu off
ib_rmbmenu = FALSE

//	Turn the row selection service on
of_SetRowSelect(TRUE)

this.settransobject(SQLCA)

//	Turn the row manager service on
of_SetRowManager(TRUE)


//	Turn the sort service on
this.of_SetSort(true)
this.inv_sort.of_SetColumnNameSource(this.inv_sort.HEADER)
this.inv_sort.of_SetUseDisplay(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
//this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)

end event

event editchanged;call super::editchanged;
//	Declarations.
string	ls_SelectedParts [ ]

//	Highlight row if there is a quantity to reschedule.
SelectRow(row, object.orig_required [ row ] > Double(data))

//	Check for selection.
ls_SelectedParts = object.part_original.selected

//	Enable or disable reschedule button depending on rows selected.
cb_reschedule.Enabled = UpperBound(ls_SelectedParts) > 0
end event

event itemchanged;call super::itemchanged;
choose case dwo.name
	case 'qty_required'
	/*	If the quantity required has been edited below quantity packed,
		give an error and reject change.*/
		if object.alternative_qty [ row ] > Dec(data) then
			MessageBox(monsys.msg_title, "A quantity of " +&
			String(object.alternative_qty [ row ]) +&
			" has been packed to this line item.  You can not adjust the required quantity below that value!", StopSign!)
			return 2
		end if
end choose

end event

type gb_1 from groupbox within w_shipper_manifest
integer x = 41
integer y = 1104
integer width = 4023
integer height = 1096
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Line Items"
end type

