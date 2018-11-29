$PBExportHeader$u_tabpg_purchasing_poinquiry_polist.sru
forward
global type u_tabpg_purchasing_poinquiry_polist from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_2 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_3 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_4 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_5 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_7 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
type cb_6 from commandbutton within u_tabpg_purchasing_poinquiry_polist
end type
end forward

global type u_tabpg_purchasing_poinquiry_polist from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_7 cb_7
cb_6 cb_6
end type
global u_tabpg_purchasing_poinquiry_polist u_tabpg_purchasing_poinquiry_polist

type variables

Private:
//	Controller reference.
n_purchasing_poinquiry_controller _myController

end variables

forward prototypes
public function integer newblanketpurchaseorder ()
public function integer newnormalpurchaseorder ()
public function integer cleanpolist ()
public function integer closepolist ()
public function integer deletepolist ()
public function integer editpo ()
end prototypes

public function integer newblanketpurchaseorder ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
_myController.NewBlanketPurchaseOrder()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer newnormalpurchaseorder ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
_myController.NewNormalPurchaseOrder()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer cleanpolist ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
long poArray[]
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	poNumber
		poNumber = dw_1.Object.InternalPONumber[i]
		poArray[UpperBound(poArray)+1] = poNumber
	end if
next

if	UpperBound(poArray) > 0 then
	return _myController.CleanPOList(poArray)
end if

MsgBox("Select one or more POs and try again.")

return NO_ACTION
end function

public function integer closepolist ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
long poArray[]
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	poNumber
		poNumber = dw_1.Object.InternalPONumber[i]
		poArray[UpperBound(poArray)+1] = poNumber
	end if
next

if	UpperBound(poArray) > 0 then
	return _myController.ClosePOList(poArray)
end if

MsgBox("Select one or more POs and try again.")

return NO_ACTION
end function

public function integer deletepolist ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
long poArray[]
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	poNumber
		poNumber = dw_1.Object.InternalPONumber[i]
		poArray[UpperBound(poArray)+1] = poNumber
	end if
next

if	UpperBound(poArray) > 0 then
	return _myController.DeletePOList(poArray)
end if

MsgBox("Select one or more POs and try again.")

return NO_ACTION
end function

public function integer editpo ();
if	not IsValid(_myController) then return FAILURE

long row
row = dw_1.GetRow()
if	row <= 0 then
	MsgBox("Select a PO and try again.")
	return NO_ACTION
end if

long	poNumber
poNumber = dw_1.Object.InternalPONumber[row]

SetPointer(HourGlass!)
_myController.EditPO(poNumber)
SetPointer(Arrow!)

return SUCCESS

end function

on u_tabpg_purchasing_poinquiry_polist.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_7
this.Control[iCurrent+7]=this.cb_6
end on

on u_tabpg_purchasing_poinquiry_polist.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_6)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)
inv_Resize.of_Register(cb_4, 100, 0, 0, 0)
inv_Resize.of_Register(cb_5, 100, 100, 0, 0)
inv_Resize.of_Register(cb_6, 100, 100, 0, 0)
inv_Resize.of_Register(cb_7, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_purchasing_poinquiry_polist
string text = "PO Headers"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_purchasing_poinquiry_polist
string dataobject = "d_purchasing_purchaseorderlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::doubleclicked;call super::doubleclicked;
EditPO()

end event

type cb_1 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 8
integer width = 466
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New Blanket PO"
end type

event clicked;
NewBlanketPurchaseOrder()

end event

type cb_2 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 136
integer width = 466
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New Normal PO"
end type

event clicked;
NewNormalPurchaseOrder()

end event

type cb_3 from commandbutton within u_tabpg_purchasing_poinquiry_polist
boolean visible = false
integer x = 1806
integer y = 264
integer width = 466
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print PO"
end type

type cb_4 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 392
integer width = 466
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Edit PO"
end type

event clicked;
EditPO()

end event

type cb_5 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 712
integer width = 466
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clean POs"
end type

event clicked;
CleanPOList()

end event

type cb_7 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 968
integer width = 466
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete POs"
end type

event clicked;
DeletePOList()

end event

type cb_6 from commandbutton within u_tabpg_purchasing_poinquiry_polist
integer x = 1806
integer y = 840
integer width = 466
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close POs"
end type

event clicked;
ClosePOList()

end event

