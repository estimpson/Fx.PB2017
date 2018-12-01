$PBExportHeader$u_tabpg_whassembly_aisledefinitions.sru
forward
global type u_tabpg_whassembly_aisledefinitions from u_tabpg_dw
end type
type cbx_showall from checkbox within u_tabpg_whassembly_aisledefinitions
end type
type cb_new from commandbutton within u_tabpg_whassembly_aisledefinitions
end type
type cb_save from commandbutton within u_tabpg_whassembly_aisledefinitions
end type
end forward

global type u_tabpg_whassembly_aisledefinitions from u_tabpg_dw
integer width = 2336
cbx_showall cbx_showall
cb_new cb_new
cb_save cb_save
end type
global u_tabpg_whassembly_aisledefinitions u_tabpg_whassembly_aisledefinitions

type variables

Private:
n_whassembly_kanbanracks_controller _myController

string _parentLocation

end variables

forward prototypes
public function integer setparentlocation (string parentlocation)
end prototypes

public function integer setparentlocation (string parentlocation);
_parentLocation = parentLocation
return Refresh()

end function

on u_tabpg_whassembly_aisledefinitions.create
int iCurrent
call super::create
this.cbx_showall=create cbx_showall
this.cb_new=create cb_new
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_showall
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.cb_save
end on

on u_tabpg_whassembly_aisledefinitions.destroy
call super::destroy
destroy(this.cbx_showall)
destroy(this.cb_new)
destroy(this.cb_save)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cbx_showall, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_whassembly_aisledefinitions
string text = "Aisle Definitions"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_whassembly_aisledefinitions
string dataobject = "d_custom_mes_assemblykanbanlocdefs"
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
	return Retrieve(nullString)
end if

return Retrieve(_parentLocation)


end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow < 1 or activerow > RowCount() or not IsValid(_myController) then
	return
end if

string aisle
aisle = object.Aisle[activerow]
_myController.post SetAisle(aisle)

end event

type cbx_showall from checkbox within u_tabpg_whassembly_aisledefinitions
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

type cb_new from commandbutton within u_tabpg_whassembly_aisledefinitions
integer x = 1810
integer y = 12
integer width = 471
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New Aisle"
end type

event clicked;
long newRow
newRow = dw_1.InsertRow(0)
dw_1.Object.ParentLocation[newRow] = _parentLocation

end event

type cb_save from commandbutton within u_tabpg_whassembly_aisledefinitions
integer x = 1810
integer y = 140
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
string text = "Save"
end type

event clicked;
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
return _myController.SaveAisleDefinitions()

end event

