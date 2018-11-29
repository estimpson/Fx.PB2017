$PBExportHeader$u_tabpg_purchmst_poedit_bolist.sru
forward
global type u_tabpg_purchmst_poedit_bolist from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_2 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_3 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_4 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_5 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_6 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
type cb_7 from commandbutton within u_tabpg_purchmst_poedit_bolist
end type
end forward

global type u_tabpg_purchmst_poedit_bolist from u_tabpg_dw
integer width = 2363
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
end type
global u_tabpg_purchmst_poedit_bolist u_tabpg_purchmst_poedit_bolist

type variables

Private:
//	Controller reference.
n_purchmst_poedit_controller _myController

end variables

forward prototypes
public function integer setasdefault ()
public function integer sendpoemails ()
end prototypes

public function integer setasdefault ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)

//	Build a list of orders to set as default
string orderList = ""
long row, rows
int selectedArray[]
int ordersArray[]
selectedArray = dw_1.object.isselected.primary
ordersArray = dw_1.object.ordernumber.primary

rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	selectedArray[row] = 1 then
		if	Len(orderList + String(ordersArray[row])) > 8000 then
			if	_myController.SetOrderListAsDefault(orderList) <> SUCCESS then
				SetPointer(Arrow!)
				return FAILURE
			end if
			orderList = ""
		end if
		orderList += String(ordersArray[row]) + ","
	end if
next

if	_myController.SetOrderListAsDefault(orderList) <> SUCCESS then
	SetPointer(Arrow!)
	return FAILURE
end if

SetPointer(Arrow!)
return Refresh()

end function

public function integer sendpoemails ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)

//	Build a list of orders to set as default
long row, rows
int selectedArray[]
int ordersArray[]
selectedArray = dw_1.object.isselected.primary
ordersArray = dw_1.object.ordernumber.primary

rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	selectedArray[row] = 1 then
		_myController.SendPOEmail(ordersArray[row])
	end if
next

SetPointer(Arrow!)
return Refresh()

end function

on u_tabpg_purchmst_poedit_bolist.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_6
this.Control[iCurrent+7]=this.cb_7
end on

on u_tabpg_purchmst_poedit_bolist.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)
inv_Resize.of_Register(cb_4, 100, 0, 0, 0)
inv_Resize.of_Register(cb_5, 100, 0, 0, 0)
inv_Resize.of_Register(cb_6, 100, 0, 0, 0)
inv_Resize.of_Register(cb_7, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_purchmst_poedit_bolist
string text = "Blanket Orders"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_purchmst_poedit_bolist
string dataobject = "d_purchmst_blanketorderlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_1 from commandbutton within u_tabpg_purchmst_poedit_bolist
integer x = 1806
integer y = 8
integer width = 526
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Set Default"
end type

event clicked;SetAsDefault()

end event

type cb_2 from commandbutton within u_tabpg_purchmst_poedit_bolist
boolean visible = false
integer x = 1806
integer y = 136
integer width = 526
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Change Plant..."
end type

type cb_3 from commandbutton within u_tabpg_purchmst_poedit_bolist
boolean visible = false
integer x = 1806
integer y = 264
integer width = 526
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Change Ship To..."
end type

type cb_4 from commandbutton within u_tabpg_purchmst_poedit_bolist
boolean visible = false
integer x = 1806
integer y = 392
integer width = 526
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Change Bill To..."
end type

type cb_5 from commandbutton within u_tabpg_purchmst_poedit_bolist
boolean visible = false
integer x = 1806
integer y = 520
integer width = 526
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Mark Closed"
end type

type cb_6 from commandbutton within u_tabpg_purchmst_poedit_bolist
boolean visible = false
integer x = 1806
integer y = 648
integer width = 526
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete PO"
end type

type cb_7 from commandbutton within u_tabpg_purchmst_poedit_bolist
integer x = 1806
integer y = 776
integer width = 526
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Send EMail"
end type

event clicked;SendPOEmails()

end event

