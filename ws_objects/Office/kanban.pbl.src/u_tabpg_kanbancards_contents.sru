$PBExportHeader$u_tabpg_kanbancards_contents.sru
forward
global type u_tabpg_kanbancards_contents from u_tabpg_dw
end type
type cb_movecontents from commandbutton within u_tabpg_kanbancards_contents
end type
type cb_scrapcontents from commandbutton within u_tabpg_kanbancards_contents
end type
end forward

global type u_tabpg_kanbancards_contents from u_tabpg_dw
integer width = 2336
string text = "Kanban Contents"
cb_movecontents cb_movecontents
cb_scrapcontents cb_scrapcontents
end type
global u_tabpg_kanbancards_contents u_tabpg_kanbancards_contents

type variables

private:

//	Model data:
string _kanbanNumber

//	Controller reference:
n_cst_kanbancards_controller _myController

end variables

forward prototypes
public function integer setkanbannumber (string kanbannumber)
end prototypes

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return Refresh()

end function

on u_tabpg_kanbancards_contents.create
int iCurrent
call super::create
this.cb_movecontents=create cb_movecontents
this.cb_scrapcontents=create cb_scrapcontents
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_movecontents
this.Control[iCurrent+2]=this.cb_scrapcontents
end on

on u_tabpg_kanbancards_contents.destroy
call super::destroy
destroy(this.cb_movecontents)
destroy(this.cb_scrapcontents)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_movecontents.X + (cb_movecontents.X - gb_1.X - gb_1.Width) + cb_movecontents.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_movecontents, 100, 0, 0, 0)
inv_Resize.of_Register(cb_scrapcontents, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_kanbancards_contents
string text = "Kanban Contents"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_kanbancards_contents
string dataobject = "d_kanban_contents"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_kanbanNumber)

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
of_SetTransObject(SQLCA)


end event

type cb_movecontents from commandbutton within u_tabpg_kanbancards_contents
integer x = 1810
integer y = 12
integer width = 471
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Move"
end type

event clicked;
if	not IsValid(_myController) then return

if	MsgBox("Are you sure you want to move all of the selected objects to another Kanban Bin?  Note that all selected objects must have the same part number.", Question!, YesNo!, 2) = 2 then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)

string	objectList = ""
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		objectList += String(dw_1.Object.ContentSerial[row]) + ","
	end if
next

_myController.ShowMoveKanbanContents(objectList)

end event

type cb_scrapcontents from commandbutton within u_tabpg_kanbancards_contents
integer x = 1810
integer y = 140
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Scrap"
end type

event clicked;
if	not IsValid(_myController) then return

if	MsgBox("Are you sure you want to scrap all of the selected objects from this Kanban Bin?", Question!, YesNo!, 2) = 2 then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)

string	objectList = ""
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		objectList += String(dw_1.Object.ContentSerial[row]) + ","
	end if
next

_myController.ScrapKanbanContents(objectList)

end event

