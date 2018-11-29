$PBExportHeader$w_shipper_header_info.srw
forward
global type w_shipper_header_info from w_response
end type
type cb_cancel from commandbutton within w_shipper_header_info
end type
type cb_ok from commandbutton within w_shipper_header_info
end type
type cb_1 from commandbutton within w_shipper_header_info
end type
type dw_shipper from u_dw within w_shipper_header_info
end type
end forward

global type w_shipper_header_info from w_response
integer x = 361
integer y = 144
integer width = 3927
integer height = 1204
string title = "Shipper Header Information"
cb_cancel cb_cancel
cb_ok cb_ok
cb_1 cb_1
dw_shipper dw_shipper
end type
global w_shipper_header_info w_shipper_header_info

type variables
Protected:

constant integer	NOCLOSE = 0
constant integer	ALLOWCLOSE = 1

constant string	SAVEMESSAGE = "Do you want to save changes?"
constant string	ERRORMESSAGE = "Unable to save changes.  Changes will be lost."

long	il_Shipper

end variables

forward prototypes
public function integer wf_modifiedcount ()
public function integer wf_update ()
end prototypes

public function integer wf_modifiedcount ();return dw_shipper.ModifiedCount ( )
end function

public function integer wf_update ();
//	declare local variables
integer	li_ReturnValue

//////////////////////////////////////////////////////////////////////////////
//	Call the dock scheduler interface to make sure the sched date is valid
//string		ls_Return
//datetime	ldt_Suggested
//n_cst_docksched icst_DockSched
//ldt_Suggested = dw_shipper.GetItemDatetime ( 1, "date_stamp" )
//ls_Return = icst_DockSched.of_GetLoadInfo ( dw_shipper.GetItemNumber ( 1, "id" ), ldt_Suggested )
//if ls_Return > '' then
//	MessageBox ( "Dock Scheduler Error", ls_Return )
//	sqlca.of_Rollback ( )
//	return FAILURE
//end if
//if Not IsNull ( ldt_Suggested ) then
//	dw_shipper.SetItem ( 1, "date_stamp", ldt_Suggested )
//end if
//////////////////////////////////////////////////////////////////////////////

//	Check for required AETC code.
n_shipping_expedite_trans expediteTrans
boolean isExpedite
int isExpediteValue
isExpediteValue = dw_shipper.object.IsExpedite[1] 
if	isExpediteValue = 1 then
	isExpedite = true
else
	string trans_mode
	trans_mode = dw_shipper.object.trans_mode[1]
	expediteTrans = create n_shipping_expedite_trans
	expediteTrans.IsExpediteTransMode(trans_mode, isExpedite)
	destroy expediteTrans
end if

if	isExpedite then
	//	Determine if trans mode is expedite and set the flag.
	expediteTrans = create n_shipping_expedite_trans
	
	boolean isAETCRequired
	string destination
	destination = dw_shipper.object.destination[1]
	
	if	expediteTrans.IsAETCRequired(destination, isAETCRequired) = expediteTrans.SUCCESS then
		if	isAETCRequired then
			string aetcNumber
			dw_shipper.AcceptText()
			aetcNumber = dw_shipper.object.aetc_number[1]
			if	IsNull(aetcNumber, "") = "" then
				destroy expediteTrans
				MsgBox ("AETC Number is required for this destination.")
				return FAILURE
			end if
		end if
	end if
	destroy expediteTrans
end if


if dw_shipper.Update() = SUCCESS then
	sqlca.of_Commit ( )
	li_ReturnValue = SUCCESS
else
	sqlca.of_Rollback ( )
	li_ReturnValue = FAILURE
end if
return li_ReturnValue

end function

on w_shipper_header_info.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.dw_shipper=create dw_shipper
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_shipper
end on

on w_shipper_header_info.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.dw_shipper)
end on

event pfc_preclose;call super::pfc_preclose;
//	declare local variables
integer	li_returnvalue
integer	li_returncode

//	get CloseWithReturn ( ) return value
li_returnvalue = message.doubleparm
//	check for modified rows in updateable datawindows
if wf_modifiedcount ( ) > 0 then
	//	if return value indicates cancel action (or clicked on close button)
	//	prompt to save changes
	if li_returnvalue <> SUCCESS then
		li_returncode = MessageBox ( monsys.msg_title, SAVEMESSAGE, Exclamation!, YesNoCancel!, 3 )
		if li_returncode = 1 then
			cb_ok.post event clicked ( )
			return NOCLOSE
		elseif li_returncode = 2 THEN
			return ALLOWCLOSE
		else
			return NOCLOSE
		end if
	else
		//	user had clicked on ok but unable to save changes
		//	prompt to cancel changes
		li_returncode = MessageBox ( monsys.msg_title, ERRORMESSAGE, StopSign!, OkCancel!, 1 )
		if li_returncode = 1 then
			//	set error return code
			message.doubleparm = -1
			return ALLOWCLOSE
		else
			return NOCLOSE
		end if
	end if
end if

//	Nothing modified.  Allow close.
return ALLOWCLOSE

end event

event pfc_preopen;call super::pfc_preopen;
//	get the shipper number and retrieve data
il_shipper = Message.DoubleParm
dw_shipper.Retrieve ( il_shipper )

//	turn off updateable service
of_SetUpdateable ( false )


// turn on calender service
dw_shipper.of_SetDropDownCalendar(True)
dw_shipper.iuo_calendar.of_register("ex_dt",dw_shipper.iuo_calendar.DDLB_WITHARROW)
dw_shipper.iuo_calendar.of_register("ac_dt",dw_shipper.iuo_calendar.DDLB_WITHARROW)




end event

type cb_cancel from commandbutton within w_shipper_header_info
integer x = 3493
integer y = 124
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( parent, NO_ACTION )
end event

type cb_ok from commandbutton within w_shipper_header_info
integer x = 3493
integer y = 16
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;wf_Update ( )
CloseWithReturn ( parent, SUCCESS )
end event

type cb_1 from commandbutton within w_shipper_header_info
integer x = 3493
integer y = 232
integer width = 361
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel Shipper"
boolean cancel = true
end type

event clicked;long ll_return

if MessageBox ( "Cancel Shipper", "Are you sure you want to cancel this shipper?", Question!, YesNo!, 2 ) = 2 then
	return
end if

//////////////////////////////////////////////////////////////////////////////
//	Call the dock scheduler interface to delete the load
//string	ls_Return
//n_cst_docksched icst_DockSched
//ls_Return = icst_DockSched.of_DeleteLoad ( dw_shipper.GetItemNumber ( 1, "id" ) )
//if ls_Return > '' then
//	MessageBox ( "Dock Scheduler Error", ls_Return )
//	return FAILURE
//end if
//////////////////////////////////////////////////////////////////////////////

//	Delete the shipper by calling the stored procedure
	if sqlca.dynamic of_CancelShipper ( dw_shipper.GetItemNumber ( 1, "id" ) ) = 0 then
		sqlca.of_Commit ( )
		Close ( Parent )
	else
		sqlca.of_RollBack ( )
	end if


end event

type dw_shipper from u_dw within w_shipper_header_info
integer x = 23
integer y = 16
integer width = 3410
integer height = 1072
integer taborder = 10
string dataobject = "d_shipper_header_info"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;SetTransObject ( SQLCA )


end event

event itemchanged;call super::itemchanged;datetime old_date, new_date
string new_time
string lst_name
long ll_row, ll_freight,ll_freight_region
long il_orderno[1]

DataStore lds_default_freight
lds_default_freight  = Create DataStore
lds_default_freight.DataObject = 'd_get_default_freight_charge'
lds_default_freight.SetTranSobject(sqlca)

DataStore lds_order_freight
lds_order_freight  = Create DataStore
lds_order_freight.DataObject = 'd_order_freight'
lds_order_freight.SetTranSobject(sqlca)

DataStore lds_freight_region
lds_freight_region  = Create DataStore
lds_freight_region.DataObject = 'd_get_freight_region'
lds_freight_region.SetTranSobject(sqlca)

ll_row = lds_freight_region.retrieve(dw_shipper.object.destination[1])
if ll_row > 0 then
	ll_freight_region = lds_freight_region.object.freightRegion[1]
end if

Choose Case dwo.name
	Case "ex_hr" 
		old_date = dw_shipper.getitemdatetime(1,"expected_del_date")
		new_date = datetime(date(old_date),time(trim(mid(data,11,99))))
		this.setitem(1, "expected_del_date", new_date) 
	Case "ex_dt" 
		new_time = string (dw_shipper.getitemdatetime(1,"ex_dt"))
		IF isNull(new_time) THEN
			new_time = "00:00:000"
		END IF	
		new_date = datetime(date(data),time(new_time))
		this.setitem(1, "expected_del_date", new_date) 
		this.settext(string(new_date))
	Case "ac_hr"
		old_date = dw_shipper.getitemdatetime(1,"actual_arrival_date")
		new_date = datetime(date(old_date),time(trim(mid(data,11,99))))
		this.setitem(1, "actual_arrival_date", new_date) 
	Case "ac_dt" 
		new_time = string(dw_shipper.getitemdatetime(1,"ac_dt"))
		IF isNull(new_time) THEN
			new_time = "00:00:000"
			
		END IF	
		new_date = datetime(date(data),time(new_time))
		this.setitem(1, "actual_arrival_date", new_date) 
		this.settext(string(new_date))
	Case 	'ship_via'
		ll_row = lds_order_freight.retrieve(il_orderno[1])
		if ll_row > 0 then
			ll_freight = lds_order_freight.object.freight[ll_row]
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
		
	Case 'trans_mode'
		ll_row = lds_order_freight.retrieve(il_orderno[1])
		if ll_row > 0 then
			ll_freight = lds_order_freight.object.freight[ll_row]
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
		
		//	Determine if trans mode is expedite and set the flag.
		n_shipping_expedite_trans expediteTrans
		expediteTrans = create n_shipping_expedite_trans
		
		boolean isExpedite
		if	expediteTrans.IsExpediteTransMode(data, isExpedite) = SUCCESS then
			if	isExpedite then
				object.IsExpedite[row] = 1
			end if
		end if
		destroy expediteTrans
	
	case "isexpedite"
		if	data = "0" then
			string nullString; setNull(nullString)
			object.ExpediteCode[row] = nullString
		end if
	
	Case Else
		// do nothing
End Choose

end event

event rbuttondown;//
end event

event rbuttonup;//
end event

