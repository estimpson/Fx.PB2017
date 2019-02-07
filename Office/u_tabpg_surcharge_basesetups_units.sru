HA$PBExportHeader$u_tabpg_surcharge_basesetups_units.sru
forward
global type u_tabpg_surcharge_basesetups_units from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_basesetups_units
end type
type cb_2 from commandbutton within u_tabpg_surcharge_basesetups_units
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_basesetups_units
end type
end forward

global type u_tabpg_surcharge_basesetups_units from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
dw_quickgridmenu dw_quickgridmenu
end type
global u_tabpg_surcharge_basesetups_units u_tabpg_surcharge_basesetups_units

type variables

Private:
//	Controller reference.
n_surcharge_basesetups_controller _myController

end variables

forward prototypes
public function integer insertrow ()
public function integer deleterows ()
public function integer savechanges ()
end prototypes

public function integer insertrow ();
return dw_1.InsertRow(0)

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

return SUCCESS

end function

public function integer savechanges ();
if	dw_1.Update(true) = 1 then
	commit using SQLCA  ;
	Refresh()
	return SUCCESS
end if

rollback using SQLCA  ;
return FAILURE

end function

on u_tabpg_surcharge_basesetups_units.create
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

on u_tabpg_surcharge_basesetups_units.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_quickgridmenu)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
//inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(dw_quickgridmenu, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_basesetups_units
string text = "Units"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_basesetups_units
string dataobject = "d_surcharge_units"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_1 from commandbutton within u_tabpg_surcharge_basesetups_units
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
boolean default = true
end type

type cb_2 from commandbutton within u_tabpg_surcharge_basesetups_units
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
boolean default = true
end type

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_basesetups_units
integer x = 1330
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event newclicked;call super::newclicked;
InsertRow()

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

