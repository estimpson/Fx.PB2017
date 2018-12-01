$PBExportHeader$u_tabpg_whassembly_kanbanlocations.sru
forward
global type u_tabpg_whassembly_kanbanlocations from u_tabpg_dw
end type
type cbx_showall from checkbox within u_tabpg_whassembly_kanbanlocations
end type
type cb_save from commandbutton within u_tabpg_whassembly_kanbanlocations
end type
type cb_label from commandbutton within u_tabpg_whassembly_kanbanlocations
end type
end forward

global type u_tabpg_whassembly_kanbanlocations from u_tabpg_dw
integer width = 2418
cbx_showall cbx_showall
cb_save cb_save
cb_label cb_label
end type
global u_tabpg_whassembly_kanbanlocations u_tabpg_whassembly_kanbanlocations

type variables

Private:
n_whassembly_kanbanracks_controller _myController

string _parentLocation, _aisle


end variables

forward prototypes
public function integer setparentlocationaisle (string parentlocation, string aisle)
public function integer reset ()
end prototypes

public function integer setparentlocationaisle (string parentlocation, string aisle);
_parentLocation = parentLocation
_aisle = aisle
return Refresh()

end function

public function integer reset ();
return dw_1.Reset()

end function

on u_tabpg_whassembly_kanbanlocations.create
int iCurrent
call super::create
this.cbx_showall=create cbx_showall
this.cb_save=create cb_save
this.cb_label=create cb_label
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_showall
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_label
end on

on u_tabpg_whassembly_kanbanlocations.destroy
call super::destroy
destroy(this.cbx_showall)
destroy(this.cb_save)
destroy(this.cb_label)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_label, 100, 0, 0, 0)
inv_Resize.of_Register(cbx_showall, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_whassembly_kanbanlocations
string text = "Kanban Locations"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_whassembly_kanbanlocations
string dataobject = "d_custom_mes_assemblykanbanlocations"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

if	cbx_showall.Checked then
	string nullString
	SetNull(nullString)
	return Retrieve(nullString, nullString)
end if

return Retrieve(_parentLocation, _aisle)

end event

type cbx_showall from checkbox within u_tabpg_whassembly_kanbanlocations
integer x = 1381
integer width = 352
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "&Show All"
boolean lefttext = true
end type

event clicked;
post Refresh()

end event

type cb_save from commandbutton within u_tabpg_whassembly_kanbanlocations
integer x = 1810
integer y = 12
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
string text = "Save"
end type

event clicked;
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
return _myController.SaveKanbanLocations()

end event

type cb_label from commandbutton within u_tabpg_whassembly_kanbanlocations
integer x = 1810
integer y = 140
integer width = 471
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Label"
end type

event clicked;
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	locationID
		locationID = dw_1.Object.SerialNumber[i]
		
		string	labelFormat = "ASSYKANBAN"
		n_cst_associative_array	printerParm
		
		printerParm.of_SetItem ( "Arg1", locationID)
		printerParm.of_SetItem ( "Report", "Kanban Location Label" )
		printerParm.of_SetItem ( "Name", labelFormat )
		Print(printerParm)

	end if
next

end event

