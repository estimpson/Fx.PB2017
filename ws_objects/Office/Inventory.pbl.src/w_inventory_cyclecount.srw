$PBExportHeader$w_inventory_cyclecount.srw
forward
global type w_inventory_cyclecount from w_sheet_panel_4t
end type
type st_1 from statictext within w_inventory_cyclecount
end type
end forward

global type w_inventory_cyclecount from w_sheet_panel_4t
string title = "Cycle Count"
st_1 st_1
end type
global w_inventory_cyclecount w_inventory_cyclecount

type variables

n_cst_inventory_cyclecount_controller Controller
u_tabpg_inventory_cyclecount uo_cyclecount

end variables

on w_inventory_cyclecount.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_inventory_cyclecount.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)

//	Too many false positives...
//of_SetUpdateable(true)

//	Create the cyclecount controller and register self.
Controller = create n_cst_inventory_cyclecount_controller
w_inventory_cyclecount wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.ShowHeaderDetail()

//	Add the controller to the window's container.
Container.of_SetItem("Controller", Controller)

end event

event close;call super::close;
//	Dispose of controller
destroy Controller

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_inventory_cyclecount
integer height = 1160
end type

type st_1 from statictext within w_inventory_cyclecount
integer y = 1176
integer width = 2130
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx Cycle Count 1.0  "
alignment alignment = right!
boolean focusrectangle = false
end type

