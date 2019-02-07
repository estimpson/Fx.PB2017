HA$PBExportHeader$u_tabpg_surcharge_setups_pubr8headers.sru
forward
global type u_tabpg_surcharge_setups_pubr8headers from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubr8headers
end type
type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubr8headers
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8headers
end type
end forward

global type u_tabpg_surcharge_setups_pubr8headers from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
dw_quickgridmenu dw_quickgridmenu
end type
global u_tabpg_surcharge_setups_pubr8headers u_tabpg_surcharge_setups_pubr8headers

type variables

Private:
//	Controller reference.
n_surcharge_setups_controller _myController

//	Model data.
string _publisherList

end variables

forward prototypes
public function integer setpublisherlist (string publisherlist)
end prototypes

public function integer setpublisherlist (string publisherlist);
Refreshing = (_publisherList = publisherList)
_publisherList = publisherList
return Refresh()

end function

on u_tabpg_surcharge_setups_pubr8headers.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_quickgridmenu=create dw_quickgridmenu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_quickgridmenu
end on

on u_tabpg_surcharge_setups_pubr8headers.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_quickgridmenu)
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_setups_pubr8headers
string text = "Publisher Rate Headers"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_setups_pubr8headers
string dataobject = "d_surcharge_publisherrateheaders"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_publisherList)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	_myController.NewRateHeader()
	return
end if

long rateHeaderID
rateHeaderID = dw_1.object.RateHeaderID[activerow]
_myController.EditRateHeader(rateHeaderID)

end event

type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubr8headers
boolean visible = false
integer x = 1806
integer y = 8
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

type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubr8headers
boolean visible = false
integer x = 1806
integer y = 136
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

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubr8headers
integer x = 1573
integer width = 178
integer height = 68
integer taborder = 11
boolean bringtotop = true
integer deleterowenabled = 0
integer saveenabled = 0
end type

event cancelclicked;call super::cancelclicked;
parent.Refresh()

end event

event newclicked;call super::newclicked;
_myController.NewRateHeader()

end event

