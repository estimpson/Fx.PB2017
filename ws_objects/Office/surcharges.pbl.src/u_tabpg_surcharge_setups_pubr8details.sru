$PBExportHeader$u_tabpg_surcharge_setups_pubr8details.sru
forward
global type u_tabpg_surcharge_setups_pubr8details from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubr8details
end type
type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubr8details
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8details
end type
type dw_header from u_fxdw within u_tabpg_surcharge_setups_pubr8details
end type
type dw_2 from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8details
end type
end forward

global type u_tabpg_surcharge_setups_pubr8details from u_tabpg_dw
integer width = 2382
integer height = 2404
cb_1 cb_1
cb_2 cb_2
dw_quickgridmenu dw_quickgridmenu
dw_header dw_header
dw_2 dw_2
end type
global u_tabpg_surcharge_setups_pubr8details u_tabpg_surcharge_setups_pubr8details

type variables

Private:
//	Controller reference.
n_surcharge_setups_controller _myController

//	Model data.
//	Rate header:
CONSTANT STRING EFFECTIVITY_TYPE_MONTHLY = 'M', EFFECTIVITY_TYPE_PERPETUAL = 'P', EFFECTIVITY_TYPE_CUSTOM = 'C'
long	_rateHeaderID = -1
string _effectivityType = EFFECTIVITY_TYPE_MONTHLY
int _month = 0, _year = 0

//	Rate details:
string _publisherList

end variables

forward prototypes
public function integer setpublisherlist (string publisherlist)
public function integer refresh ()
public function integer setrateheader (long rateheaderid)
public function integer saveratedetails ()
public function integer saverateheader ()
end prototypes

public function integer setpublisherlist (string publisherlist);
_publisherList = publisherList
return Refresh()

end function

public function integer refresh ();
dw_header.event pfc_retrieve()
return super::refresh()

end function

public function integer setrateheader (long rateheaderid);
Refreshing = ((_rateHeaderID = rateHeaderID) and _rateHeaderID > 0)
_rateHeaderID = rateHeaderID
return Refresh()

end function

public function integer saveratedetails ();
dw_1.AcceptText()
return _myController.SaveRateDetails()

end function

public function integer saverateheader ();
dw_2.AcceptText()
return _myController.SaveRateHeader()

end function

on u_tabpg_surcharge_setups_pubr8details.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_quickgridmenu=create dw_quickgridmenu
this.dw_header=create dw_header
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_quickgridmenu
this.Control[iCurrent+4]=this.dw_header
this.Control[iCurrent+5]=this.dw_2
end on

on u_tabpg_surcharge_setups_pubr8details.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_quickgridmenu)
destroy(this.dw_header)
destroy(this.dw_2)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
//inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(dw_quickgridmenu, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_setups_pubr8details
integer y = 704
string text = "Publisher Rate Details"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_setups_pubr8details
integer y = 784
string dataobject = "d_surcharge_publisherratedetails"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_rateHeaderID)

end event

event dw_1::clicked;call super::clicked;
if	row <= 0 then return NO_ACTION

choose case dwo.Name
	case lower("IsPublished")
		int isPublished
		isPublished = object.IsPublished[row]
		string nullString
		SetNull(nullString)
		if	isPublished < 2 then
			object.IsPublished[row] = 2
			object.Units[row] = nullString
		else
			object.IsPublished[row] = 0
			object.Units[row] = nullString
		end if
end choose

end event

event dw_1::itemchanged;call super::itemchanged;
if	row <= 0 then return NO_ACTION

choose case dwo.Name
	case "units"
		object.IsPublished[row] = 2
end choose

end event

type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubr8details
boolean visible = false
integer x = 1806
integer y = 732
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "func1"
end type

type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubr8details
boolean visible = false
integer x = 1806
integer y = 860
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "func2"
end type

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8details
integer x = 1573
integer y = 704
integer width = 178
integer height = 68
integer taborder = 11
boolean bringtotop = true
integer deleterowenabled = 0
integer insertrowenabled = 0
end type

event cancelclicked;call super::cancelclicked;
parent.Refresh()

end event

event saveclicked;call super::saveclicked;
SaveRateDetails()

end event

type dw_header from u_fxdw within u_tabpg_surcharge_setups_pubr8details
integer y = 4
integer width = 2016
integer height = 688
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_edit_rateheader"
boolean vscrollbar = false
boolean showpowerfilter = false
end type

event constructor;call super::constructor;
//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetTransObject (SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_rateHeaderID, _effectivityType, _month, _year)

end event

type dw_2 from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8details
integer x = 1669
integer y = 4
integer width = 320
integer height = 68
integer taborder = 10
boolean bringtotop = true
integer deleterowenabled = 0
end type

event saveclicked;call super::saveclicked;
SaveRateHeader()

end event

event cancelclicked;call super::cancelclicked;
//CancelHeader()
dw_header.event pfc_retrieve()

end event

event newclicked;call super::newclicked;
_myController.NewRateHeader()

end event

