$PBExportHeader$u_tabpg_surcharge_partvendbpm_bsurch.sru
forward
global type u_tabpg_surcharge_partvendbpm_bsurch from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_partvendbpm_bsurch
end type
type cb_2 from commandbutton within u_tabpg_surcharge_partvendbpm_bsurch
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_partvendbpm_bsurch
end type
end forward

global type u_tabpg_surcharge_partvendbpm_bsurch from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
dw_quickgridmenu dw_quickgridmenu
end type
global u_tabpg_surcharge_partvendbpm_bsurch u_tabpg_surcharge_partvendbpm_bsurch

type variables

Private:
//	Model data.
string	_partCode
string	_vendorCode

//	Controller reference.
n_surcharge_partvendbpm_controller _myController

end variables

forward prototypes
public function integer setpartvendor (string partcode, string vendorcode)
public function integer getpublisherclasscode (string publisher)
public function integer deleterows ()
public function integer savechanges ()
end prototypes

public function integer setpartvendor (string partcode, string vendorcode);
Refreshing = ((_partCode = partCode) and (_vendorCode = vendorCode))
_partCode = partCode
_vendorCode = vendorCode
return Refresh()

end function

public function integer getpublisherclasscode (string publisher);
datawindowchild dwcClasses

if	dw_1.GetChild("SurchargeClassCode", dwcClasses) <> 1 then
	return FAILURE
end if

dwcClasses.SetTransObject(SQLCA)
dwcClasses.Retrieve(publisher)

return SUCCESS

end function

public function integer deleterows ();
//	Loop through and delete selected rows.
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = UpperBound(selectedRows) to 1 step -1
	if	selectedRows[i] = 1 then
		dw_1.DeleteRow(i)
	end if
next

return SaveChanges()

end function

public function integer savechanges ();
dw_1.AcceptText()
return _myController.SaveSurcharges()

end function

on u_tabpg_surcharge_partvendbpm_bsurch.create
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

on u_tabpg_surcharge_partvendbpm_bsurch.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_quickgridmenu)
end on

event constructor;call super::constructor;
inv_Resize.of_Register(dw_quickgridmenu, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_partvendbpm_bsurch
string text = "Surcharges"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_partvendbpm_bsurch
string dataobject = "d_surcharge_partvendbpm_bsurch"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode, _vendorCode)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activeRow <= 0 then return

string publisher
publisher = dw_1.object.Publisher[activerow]
GetPublisherClassCode(publisher)

end event

event dw_1::itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case lower("Publisher")
		string publisher
		publisher = data
		GetPublisherClassCode(publisher)
end choose


end event

type cb_1 from commandbutton within u_tabpg_surcharge_partvendbpm_bsurch
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

type cb_2 from commandbutton within u_tabpg_surcharge_partvendbpm_bsurch
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

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_partvendbpm_bsurch
integer x = 1330
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event newclicked;call super::newclicked;
SaveChanges()

end event

event deleteclicked;call super::deleteclicked;
DeleteRows()

end event

event saveclicked;call super::saveclicked;
SaveChanges()

end event

event cancelclicked;call super::cancelclicked;
parent.Refresh()

end event

