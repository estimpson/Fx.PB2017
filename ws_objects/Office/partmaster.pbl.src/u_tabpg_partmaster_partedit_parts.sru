$PBExportHeader$u_tabpg_partmaster_partedit_parts.sru
forward
global type u_tabpg_partmaster_partedit_parts from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_partmaster_partedit_parts
end type
type cb_relabel from commandbutton within u_tabpg_partmaster_partedit_parts
end type
type cb_showhide from commandbutton within u_tabpg_partmaster_partedit_parts
end type
end forward

global type u_tabpg_partmaster_partedit_parts from u_tabpg_dw
integer width = 2313
cb_new cb_new
cb_relabel cb_relabel
cb_showhide cb_showhide
end type
global u_tabpg_partmaster_partedit_parts u_tabpg_partmaster_partedit_parts

type variables

string PartCode

end variables

forward prototypes
public function integer setpart (string _partcode)
end prototypes

public function integer setpart (string _partcode);
long partRow
partRow = dw_1.Find("PartCode = ~"" + _partCode + "~"", 0, dw_1.RowCount())
if	partRow <= 1 then return FAILURE

dw_1.SetRow(partRow)
dw_1.ScrollToRow(partRow)
return SUCCESS
end function

on u_tabpg_partmaster_partedit_parts.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_relabel=create cb_relabel
this.cb_showhide=create cb_showhide
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_relabel
this.Control[iCurrent+3]=this.cb_showhide
end on

on u_tabpg_partmaster_partedit_parts.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_relabel)
destroy(this.cb_showhide)
end on

event constructor;call super::constructor;
cb_new.Visible = false
cb_relabel.Visible = false
inv_Resize.of_SetOrigSize(cb_showhide.X + (cb_showhide.X - gb_1.X - gb_1.Width) + cb_showhide.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_showhide, 100, 0, 0, 0)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_partedit_parts
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_partedit_parts
string dataobject = "d_custom_partmaster_setuplist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

if	activeRow <= 0 or activeRow > RowCount() then
	PartCode = ""
	myController.SetPartCode(PartCode)
	return
end if
PartCode = Object.PartCode[activeRow]
myController.SetPartCode(PartCode)

end event

event dw_1::updateend;call super::updateend;
//	Commit changes.
commit using sqlca  ;

end event

type cb_new from commandbutton within u_tabpg_partmaster_partedit_parts
boolean visible = false
integer x = 1810
integer y = 156
integer width = 471
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New"
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.NewPart()

end event

type cb_relabel from commandbutton within u_tabpg_partmaster_partedit_parts
boolean visible = false
integer x = 1810
integer y = 288
integer width = 471
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Part Label"
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		myController.PrintComponentLabel(dw_1.object.RowID[row])
	end if
next

myController.Refresh()

end event

type cb_showhide from commandbutton within u_tabpg_partmaster_partedit_parts
integer x = 1810
integer y = 24
integer width = 101
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">>"
end type

event clicked;
if	cb_showhide.Text = ">>" then
	cb_new.Visible = true
	cb_relabel.Visible = true
	inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
	event Resize(0, width, height)
	cb_showhide.Text = "<<"
elseif	cb_showhide.Text = "<<" then
	cb_new.Visible = false
	cb_relabel.Visible = false
	inv_Resize.of_SetOrigSize(cb_showhide.X + (cb_showhide.X - gb_1.X - gb_1.Width) + cb_showhide.Width, gb_1.Y + gb_1.Height)
	event Resize(0, width, height)
	cb_showhide.Text = ">>"
end if

end event

