$PBExportHeader$w_leaktester.srw
forward
global type w_leaktester from w_sheet_panel_4t
end type
type st_1 from statictext within w_leaktester
end type
end forward

global type w_leaktester from w_sheet_panel_4t
string title = "Post-Potting Leak Tester"
string menuname = "m_sheet_leaktester"
event ue_rework ( )
st_1 st_1
end type
global w_leaktester w_leaktester

type variables

private:
n_leaktester_controller Controller

end variables

event ue_rework();
Controller.Rework()

end event

on w_leaktester.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_leaktester" then this.MenuID = create m_sheet_leaktester
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_leaktester.destroy
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
Controller = create n_leaktester_controller
Container.of_SetItem("Controller", Controller)
w_leaktester wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.Activated()

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

event activate;call super::activate;
Controller.Activated()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_leaktester
end type

type st_1 from statictext within w_leaktester
integer y = 820
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
string text = "Fx Post-Potting Leak Tester 1.0"
alignment alignment = right!
boolean focusrectangle = false
end type

