$PBExportHeader$w_surcharge_setups.srw
forward
global type w_surcharge_setups from w_sheet_panel_4t
end type
type st_1 from statictext within w_surcharge_setups
end type
end forward

global type w_surcharge_setups from w_sheet_panel_4t
integer x = 214
integer y = 221
string title = "Surcharge Setups"
st_1 st_1
end type
global w_surcharge_setups w_surcharge_setups

type variables

n_surcharge_setups_controller Controller

end variables

on w_surcharge_setups.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_surcharge_setups.destroy
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

//	Create the controller and register self.
Controller = create n_surcharge_setups_controller
Container.of_SetItem("Controller", Controller)
w_surcharge_setups wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.Activated()

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_surcharge_setups
end type

type st_1 from statictext within w_surcharge_setups
integer y = 828
integer width = 2121
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx Surcharge Setups 1.0 "
alignment alignment = right!
boolean focusrectangle = false
end type

