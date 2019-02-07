HA$PBExportHeader$u_tabpg_kanbancards_kanbans.sru
forward
global type u_tabpg_kanbancards_kanbans from u_tabpg_dw
end type
type cb_newmfg from commandbutton within u_tabpg_kanbancards_kanbans
end type
type cb_relabel from commandbutton within u_tabpg_kanbancards_kanbans
end type
type cb_newreplenish from commandbutton within u_tabpg_kanbancards_kanbans
end type
type p_delete from picture within u_tabpg_kanbancards_kanbans
end type
end forward

global type u_tabpg_kanbancards_kanbans from u_tabpg_dw
integer width = 2336
cb_newmfg cb_newmfg
cb_relabel cb_relabel
cb_newreplenish cb_newreplenish
p_delete p_delete
end type
global u_tabpg_kanbancards_kanbans u_tabpg_kanbancards_kanbans

type variables

private n_cst_kanbancards_controller _myController

end variables

on u_tabpg_kanbancards_kanbans.create
int iCurrent
call super::create
this.cb_newmfg=create cb_newmfg
this.cb_relabel=create cb_relabel
this.cb_newreplenish=create cb_newreplenish
this.p_delete=create p_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_newmfg
this.Control[iCurrent+2]=this.cb_relabel
this.Control[iCurrent+3]=this.cb_newreplenish
this.Control[iCurrent+4]=this.p_delete
end on

on u_tabpg_kanbancards_kanbans.destroy
call super::destroy
destroy(this.cb_newmfg)
destroy(this.cb_relabel)
destroy(this.cb_newreplenish)
destroy(this.p_delete)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_newmfg.X + (cb_newmfg.X - gb_1.X - gb_1.Width) + cb_newmfg.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_newmfg, 100, 0, 0, 0)
inv_Resize.of_Register(cb_newreplenish, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)
inv_Resize.of_Register(p_delete, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_kanbancards_kanbans
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_kanbancards_kanbans
string dataobject = "d_kanbancardlist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
of_SetTransObject(SQLCA)

datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("ReceiverObjects") = 0 then
		statusDWC.InsertRow(0)
	end if
end if

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve("") = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

datawindowchild locationDWC
if	GetChild("Location", locationDWC) = 1 then
	locationDWC.SetTransObject(SQLCA)
	if	locationDWC.Retrieve("") = 0 then
		locationDWC.InsertRow(0)
	end if
end if

datawindowchild plantDWC
if	GetChild("Plant", plantDWC) = 1 then
	plantDWC.SetTransObject(SQLCA)
	if	plantDWC.Retrieve("") = 0 then
		plantDWC.InsertRow(0)
	end if
end if

of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetDropDownNotes(true)
iuo_Notes.of_Register("note", iuo_Notes.DDLB)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activerow <= 0 then return

string kanbanNumber
kanbanNumber = Object.KanbanNumber[activerow]
_myController.SetKanbanNumber(kanbanNumber)

end event

type cb_newmfg from commandbutton within u_tabpg_kanbancards_kanbans
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
string text = "New Mfg. Kanban"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.NewMfgKanbanCards()


end event

type cb_relabel from commandbutton within u_tabpg_kanbancards_kanbans
integer x = 1810
integer y = 268
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
string text = "Relabel"
end type

event clicked;
if	not IsValid(_myController) then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		_myController.PrintKanbanLabel(dw_1.object.ObjectSerial[row], dw_1.object.Type[row])
	end if
next

_myController.Refresh()

end event

type cb_newreplenish from commandbutton within u_tabpg_kanbancards_kanbans
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
string text = "New Rpl. Kanban"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.NewRplKanbanCards()


end event

type p_delete from picture within u_tabpg_kanbancards_kanbans
string tag = "Delete Kanban Bin"
integer x = 2135
integer y = 956
integer width = 146
integer height = 128
boolean bringtotop = true
boolean originalsize = true
string picturename = "RedTrashBin-32.bmp"
boolean focusrectangle = false
end type

event clicked;
if	not IsValid(_myController) then return

if	MsgBox("Are you sure you want to delete all of the selected Kanban Bins?  All bins must be empty prior to deletion.", Question!, YesNo!, 2) = 2 then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)

string	kanbanBinList = ""
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		kanbanBinList += dw_1.Object.KanbanNumber[row] + ","
	end if
next

_myController.DeleteKanbanBins(kanbanBinList)


end event

