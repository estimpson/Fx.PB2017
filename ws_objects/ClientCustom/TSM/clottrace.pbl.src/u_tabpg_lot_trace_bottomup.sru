$PBExportHeader$u_tabpg_lot_trace_bottomup.sru
forward
global type u_tabpg_lot_trace_bottomup from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_lot_trace_bottomup
end type
type cb_2 from commandbutton within u_tabpg_lot_trace_bottomup
end type
type tv_1 from treeview within u_tabpg_lot_trace_bottomup
end type
type st_1 from statictext within u_tabpg_lot_trace_bottomup
end type
type st_split from u_st_splitbar within u_tabpg_lot_trace_bottomup
end type
type dw_2 from u_fxdw within u_tabpg_lot_trace_bottomup
end type
type gb_2 from groupbox within u_tabpg_lot_trace_bottomup
end type
type gb_tree from groupbox within u_tabpg_lot_trace_bottomup
end type
type st_vsplit1 from u_st_splitbar within u_tabpg_lot_trace_bottomup
end type
type dw_3 from u_fxdw within u_tabpg_lot_trace_bottomup
end type
type gb_3 from groupbox within u_tabpg_lot_trace_bottomup
end type
type st_vsplit2 from u_st_splitbar within u_tabpg_lot_trace_bottomup
end type
type uo_action_remaininginventory from u_action_remaininginventory within u_tabpg_lot_trace_bottomup
end type
type cb_3 from commandbutton within u_tabpg_lot_trace_bottomup
end type
type uo_action_shipments from u_action_shipments within u_tabpg_lot_trace_bottomup
end type
end forward

global type u_tabpg_lot_trace_bottomup from u_tabpg_dw
integer width = 3525
integer height = 1656
string text = "Trace Up"
cb_1 cb_1
cb_2 cb_2
tv_1 tv_1
st_1 st_1
st_split st_split
dw_2 dw_2
gb_2 gb_2
gb_tree gb_tree
st_vsplit1 st_vsplit1
dw_3 dw_3
gb_3 gb_3
st_vsplit2 st_vsplit2
uo_action_remaininginventory uo_action_remaininginventory
cb_3 cb_3
uo_action_shipments uo_action_shipments
end type
global u_tabpg_lot_trace_bottomup u_tabpg_lot_trace_bottomup

type variables

Private:
//	Model data.
string _traceNumber
n_lot_trace_treeitem _rootTreeItem
string _selectedItemID

//	Controller reference.
n_lot_trace_controller _myController

//	Data context.
n_lot_trans _trans

end variables

forward prototypes
public function integer settracenumber (string tracenumber)
public function integer settransobject (n_lot_trans transobject)
public function integer addtreebranch (long handle, string hierarchid, ref n_lot_trace_treeitem treeitems[])
public function integer setselecteditemid (string selecteditemid)
public function integer newqualitybatch ()
public function integer refreshtrace ()
end prototypes

public function integer settracenumber (string tracenumber);
tv_1.DeleteItem(0)

if	IsValid(_rootTreeItem) then
	_rootTreeItem.Reset()
	destroy _rootTreeItem
end if

_rootTreeItem = create n_lot_trace_treeitem

if	not IsValid(_trans) then return FAILURE

_traceNumber = traceNumber
SetNull(_selectedItemID)
dw_1.Reset()
dw_2.Reset()
dw_3.Reset()

return AddTreeBranch(0, "/",_rootTreeItem._childTreeItems)

end function

public function integer settransobject (n_lot_trans transobject);
_trans = transObject
return SUCCESS

end function

public function integer addtreebranch (long handle, string hierarchid, ref n_lot_trace_treeitem treeitems[]);
if	not IsValid(_trans) then return FAILURE

if	_trans.TraceForward_GetTreeItems(_traceNumber, hierarchID, treeItems) = SUCCESS then
	
	treeviewitem tvi
	
	int i, items
	items = UpperBound(treeItems)
	for	i = 1 to items
		choose case treeItems[i].linkType
			case "D"
				tvi.Label = "Qty: " + string(treeItems[i].Quantity) + " [" + treeItems[i].Part  + "]"
			case else
				tvi.Label = string(treeItems[i].Serial) + " [" + treeItems[i].Part  + "]"
		end choose
		
		tvi.Data = treeItems[i]
		tvi.Children = treeItems[i].HasChildren
		choose case treeItems[i].linkType
			case "B"
				tvi.PictureIndex = 1
				tvi.SelectedPictureIndex = 1
			case "C"
				tvi.PictureIndex = 2
				tvi.SelectedPictureIndex = 2
			case "D"
				tvi.PictureIndex = 3
				tvi.SelectedPictureIndex = 3
			case "J"
				tvi.PictureIndex = 4
				tvi.SelectedPictureIndex = 4
			case "O"
				tvi.PictureIndex = 5
				tvi.SelectedPictureIndex = 5
			case "R"
				tvi.PictureIndex = 6
				tvi.SelectedPictureIndex = 6
			case else
				tvi.PictureIndex = 0
				tvi.SelectedPictureIndex = 0
		end choose

		tv_1.InsertItemLast(handle, tvi)
	next
end if

return SUCCESS

end function

public function integer setselecteditemid (string selecteditemid);
_selectedItemID = selectedItemID
dw_1.Refresh()
dw_2.Refresh()
dw_3.Refresh()
return SUCCESS

end function

public function integer newqualitybatch ();
//	Build a list of serials that need to have the new status.
string serialList = ""
long row, rows
long SelectedArray []
long SerialArray []

if	dw_3.RowCount() <= 0 then return NO_ACTION

SelectedArray = dw_3.Object.IsSelected.Primary
SerialArray = dw_3.Object.Serial.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	Len(serialList + String(SerialArray[row])) > 8000 then
			MsgBox("Maximum number of serial numbers exceeded.  Select fewer objects and try again", StopSign!)
			return FAILURE
		end if
		serialList += String(SerialArray[row]) + ","
	end if
next

return _myController.NewQualityBatch(serialList)

end function

public function integer refreshtrace ();
return _myController.RefreshTraceUp()

end function

on u_tabpg_lot_trace_bottomup.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.tv_1=create tv_1
this.st_1=create st_1
this.st_split=create st_split
this.dw_2=create dw_2
this.gb_2=create gb_2
this.gb_tree=create gb_tree
this.st_vsplit1=create st_vsplit1
this.dw_3=create dw_3
this.gb_3=create gb_3
this.st_vsplit2=create st_vsplit2
this.uo_action_remaininginventory=create uo_action_remaininginventory
this.cb_3=create cb_3
this.uo_action_shipments=create uo_action_shipments
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.tv_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_split
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_tree
this.Control[iCurrent+9]=this.st_vsplit1
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.st_vsplit2
this.Control[iCurrent+13]=this.uo_action_remaininginventory
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.uo_action_shipments
end on

on u_tabpg_lot_trace_bottomup.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.tv_1)
destroy(this.st_1)
destroy(this.st_split)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.gb_tree)
destroy(this.st_vsplit1)
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.st_vsplit2)
destroy(this.uo_action_remaininginventory)
destroy(this.cb_3)
destroy(this.uo_action_shipments)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(uo_action_remaininginventory.X + (uo_action_remaininginventory.X - gb_1.X - gb_1.Width) + uo_action_remaininginventory.Width, gb_tree.Y * 2 + gb_tree.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)
inv_Resize.of_Register(gb_tree, 0, 0, 0, 100)
inv_Resize.of_Register(tv_1, 0, 0, 0, 100)
inv_Resize.of_Register(st_split, 0, 0, 0, 100)
inv_Resize.of_Register(st_vsplit1, 0, 100, 100, 0)
inv_Resize.of_Register(gb_2, 0, 100, 100, 0)
inv_Resize.of_Register(dw_2, 0, 100, 100, 0)
inv_Resize.of_Register(uo_action_shipments, 100, 100, 0, 0)
inv_Resize.of_Register(st_vsplit2, 0, 100, 100, 0)
inv_Resize.of_Register(gb_3, 0, 100, 100, 0)
inv_Resize.of_Register(dw_3, 0, 100, 100, 0)
inv_Resize.of_Register(uo_action_remaininginventory, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

event destructor;call super::destructor;
if	IsValid(_rootTreeItem) then
	_rootTreeItem.Reset()
	destroy _rootTreeItem
end if

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_lot_trace_bottomup
integer x = 1129
integer height = 452
string text = "History"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_lot_trace_bottomup
integer x = 1138
integer height = 364
string dataobject = "d_lot_trace_bu_sourcedetails"
boolean showcolumncomments = false
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_traceNumber, _selectedItemID)

end event

type cb_1 from commandbutton within u_tabpg_lot_trace_bottomup
integer x = 2907
integer y = 4
integer width = 581
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Refresh Trace"
end type

event clicked;
RefreshTrace()

end event

type cb_2 from commandbutton within u_tabpg_lot_trace_bottomup
integer x = 2907
integer y = 136
integer width = 581
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print"
end type

event clicked;
dw_1.Print()

end event

type tv_1 from treeview within u_tabpg_lot_trace_bottomup
integer x = 23
integer y = 128
integer width = 1042
integer height = 1268
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"alphab.bmp","alphac.bmp","alphad.bmp","alphaj.bmp","alphao.bmp","alphar.bmp"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 16777215
end type

event itemexpanding;
treeviewitem expandedTreeItem
GetItem(handle, expandedTreeItem)
if	IsValid(expandedTreeItem) then
	if	not expandedTreeItem.ExpandedOnce then
		n_lot_trace_treeitem expandedItem
		expandedItem = expandedTreeItem.Data
		
		AddTreeBranch(handle, expandedItem.TreeItemID, expandedItem._childTreeItems)
	end if
end if

end event

event selectionchanged;
treeviewitem selectedTreeItem
GetItem(newhandle, selectedTreeItem)
if	IsValid(selectedTreeItem) then
	n_lot_trace_treeitem selectedItem
	selectedItem = selectedTreeItem.Data
	
	SetSelectedItemID(selectedItem.TreeItemID)
end if

end event

type st_1 from statictext within u_tabpg_lot_trace_bottomup
integer x = 23
integer y = 52
integer width = 1033
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Usage Trace"
boolean focusrectangle = false
end type

type st_split from u_st_splitbar within u_tabpg_lot_trace_bottomup
integer x = 1093
integer width = 32
integer height = 1420
boolean bringtotop = true
end type

event constructor;call super::constructor;
of_Register(gb_tree, LEFT)
of_Register(st_1, LEFT)
of_Register(tv_1, LEFT)
of_Register(gb_1, RIGHT)
of_Register(dw_1, RIGHT)
of_Register(st_vsplit1, RIGHT)
of_Register(gb_2, RIGHT)
of_Register(dw_2, RIGHT)
of_Register(st_vsplit2, RIGHT)
of_Register(gb_3, RIGHT)
of_Register(dw_3, RIGHT)

end event

type dw_2 from u_fxdw within u_tabpg_lot_trace_bottomup
integer x = 1138
integer y = 564
integer width = 1733
integer height = 364
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_lot_trace_bu_shipmentdetails"
boolean showcolumncomments = false
end type

event constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_traceNumber, _selectedItemID)

end event

type gb_2 from groupbox within u_tabpg_lot_trace_bottomup
integer x = 1129
integer y = 484
integer width = 1751
integer height = 452
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Shipments"
end type

type gb_tree from groupbox within u_tabpg_lot_trace_bottomup
integer width = 1093
integer height = 1420
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type st_vsplit1 from u_st_splitbar within u_tabpg_lot_trace_bottomup
integer x = 1129
integer y = 452
integer width = 1751
integer height = 32
end type

event constructor;call super::constructor;
of_Register(gb_1, ABOVE)
of_Register(dw_1, ABOVE)
of_Register(gb_2, BELOW)
of_Register(dw_2, BELOW)
of_Register(uo_action_shipments, BELOW)

end event

type dw_3 from u_fxdw within u_tabpg_lot_trace_bottomup
integer x = 1138
integer y = 1048
integer width = 1733
integer height = 364
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_lot_trace_bu_remaininginventory"
boolean showcolumncomments = false
end type

event constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_traceNumber, _selectedItemID)

end event

type gb_3 from groupbox within u_tabpg_lot_trace_bottomup
integer x = 1129
integer y = 968
integer width = 1751
integer height = 452
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Remaining Inventory"
end type

type st_vsplit2 from u_st_splitbar within u_tabpg_lot_trace_bottomup
integer x = 1129
integer y = 936
integer width = 1751
integer height = 32
end type

event constructor;call super::constructor;
of_Register(gb_2, ABOVE)
of_Register(dw_2, ABOVE)
of_Register(uo_action_shipments, ABOVE)
of_Register(gb_3, BELOW)
of_Register(dw_3, BELOW)
of_Register(uo_action_remaininginventory, BELOW)

end event

type uo_action_remaininginventory from u_action_remaininginventory within u_tabpg_lot_trace_bottomup
integer x = 2898
integer y = 968
integer height = 452
integer taborder = 30
boolean bringtotop = true
end type

on uo_action_remaininginventory.destroy
call u_action_remaininginventory::destroy
end on

event newqualitybatch;call super::newqualitybatch;
NewQualityBatch()

end event

event print;call super::print;
dw_3.Print()

end event

event clipboard;call super::clipboard;
dw_3.SaveAs( '', ClipBoard!, true)

end event

type cb_3 from commandbutton within u_tabpg_lot_trace_bottomup
integer x = 2907
integer y = 264
integer width = 581
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clipboard"
end type

event clicked;
dw_1.SaveAs( '', ClipBoard!, true)

end event

type uo_action_shipments from u_action_shipments within u_tabpg_lot_trace_bottomup
integer x = 2903
integer y = 472
integer height = 460
integer taborder = 20
boolean bringtotop = true
end type

event clipboard;call super::clipboard;
dw_2.SaveAs( '', ClipBoard!, true)

end event

event print;call super::print;
dw_2.Print()

end event

on uo_action_shipments.destroy
call u_action_shipments::destroy
end on

