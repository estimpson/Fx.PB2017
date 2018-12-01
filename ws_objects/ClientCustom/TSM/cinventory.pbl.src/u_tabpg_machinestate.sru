$PBExportHeader$u_tabpg_machinestate.sru
forward
global type u_tabpg_machinestate from u_tabpg_dw
end type
type dw_partsearch from u_dw_search within u_tabpg_machinestate
end type
type st_machines from statictext within u_tabpg_machinestate
end type
type cbx_showall from checkbox within u_tabpg_machinestate
end type
end forward

global type u_tabpg_machinestate from u_tabpg_dw
integer width = 1977
string text = "Overview"
dw_partsearch dw_partsearch
st_machines st_machines
cbx_showall cbx_showall
end type
global u_tabpg_machinestate u_tabpg_machinestate

type variables

string HiddenMachines[]

end variables

forward prototypes
public subroutine setselectedvalue (dwobject dwo, long row)
public function integer gethiddenmachines ()
public function integer setmachinevisible (string machinecode, boolean _visible)
public subroutine showallmachines (boolean _visible)
end prototypes

public subroutine setselectedvalue (dwobject dwo, long row);
long	selectedRow = 0
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	if row <> selectedRow then dwo.primary[selectedRow] = dwo.primary[row]
	
	choose case lower (dwo.name)
		case "showmachine"
			SetMachineVisible(dw_1.object.machineCode[selectedRow], dwo.primary[row] = 1)
	end choose
loop

end subroutine

public function integer gethiddenmachines ();
string	regKey
regKey = gnv_App.of_GetUserKey() + "\" + GetParent().GetParent().ClassName() + "\" + GetParent().ClassName() + "\" + ClassName() + "\HiddenMachines"

return RegistryValues (regKey, HiddenMachines)

end function

public function integer setmachinevisible (string machinecode, boolean _visible);
string	regKey
regKey = gnv_App.of_GetUserKey() + "\" + GetParent().GetParent().ClassName() + "\" + GetParent().ClassName() + "\" + ClassName() + "\HiddenMachines"

if	_visible then
	return RegistryDelete (regKey, machineCode)
else
	return RegistrySet (regKey, machineCode, ReguLong!, 0)
end if

end function

public subroutine showallmachines (boolean _visible);
if	_visible then
	dw_1.object.showmachine.visible = 1
	dw_1.object.showmachine.x = 20
	dw_1.SetFilter ("")
	dw_1.Filter()
	dw_1.Sort()
	st_machines.Text = "Showing all (" + string (dw_1.RowCount()) + ") machines..."
else
	dw_1.object.showmachine.visible = 0
	dw_1.SetFilter ("showmachine  = 1")
	dw_1.Filter()
	dw_1.Sort()
	st_machines.Text = "Showing " + string (dw_1.RowCount()) + " machines..."
end if

end subroutine

on u_tabpg_machinestate.create
int iCurrent
call super::create
this.dw_partsearch=create dw_partsearch
this.st_machines=create st_machines
this.cbx_showall=create cbx_showall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_partsearch
this.Control[iCurrent+2]=this.st_machines
this.Control[iCurrent+3]=this.cbx_showall
end on

on u_tabpg_machinestate.destroy
call super::destroy
destroy(this.dw_partsearch)
destroy(this.st_machines)
destroy(this.cbx_showall)
end on

event constructor;call super::constructor;
inv_Resize.of_Register(dw_partsearch, 0, 0, 100, 0)
inv_Resize.of_Register(cbx_showall, 0, 100, 0, 0)
inv_Resize.of_Register(st_machines, 0, 100, 100, 0)

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_machinestate
integer x = 18
integer y = 180
integer width = 1719
integer height = 796
string dataobject = "d_machinestate"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
if	UpperBound(HiddenMachines) = 0 then
	HiddenMachines[1] = ''
end if
return Retrieve(HiddenMachines)


end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)

of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

of_SetTransObject(SQLCA)

GetHiddenMachines()
dw_1.event pfc_retrieve()
ShowAllMachines (false)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.Extended)

SetRowFocusIndicator(FocusRect!)

end event

event dw_1::itemchanged;call super::itemchanged;
post SetSelectedValue (dwo, row)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_machinestate
integer height = 1064
end type

type dw_partsearch from u_dw_search within u_tabpg_machinestate
integer x = 18
integer y = 68
integer width = 1719
integer height = 116
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_partsearch"
end type

event constructor;call super::constructor;
inv_LinkDWSearch.of_Register ( "partcode", dw_1.object.partcode, dw_1)

end event

event getfocus;call super::getfocus;
SetHasFocus(true)

end event

event losefocus;call super::losefocus;
SetHasFocus(false)

end event

type st_machines from statictext within u_tabpg_machinestate
integer x = 421
integer y = 976
integer width = 1317
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Showing x machines..."
boolean focusrectangle = false
end type

event losefocus;
SetHasFocus(false)

end event

event getfocus;
SetHasFocus(true)

end event

type cbx_showall from checkbox within u_tabpg_machinestate
integer x = 18
integer y = 976
integer width = 402
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Show All"
end type

event clicked;
ShowAllMachines (checked)

end event

event getfocus;
SetHasFocus(true)

end event

event losefocus;
SetHasFocus(false)

end event

