$PBExportHeader$w_pottingroom.srw
forward
global type w_pottingroom from w_sheet_panel_4t
end type
type st_1 from statictext within w_pottingroom
end type
type st_timezone from statictext within w_pottingroom
end type
end forward

global type w_pottingroom from w_sheet_panel_4t
string title = "Potting Room"
string menuname = "m_sheet_pottingroom"
event ue_rework ( )
st_1 st_1
st_timezone st_timezone
end type
global w_pottingroom w_pottingroom

type variables

private:
n_pottingroom_controller Controller

end variables

event ue_rework();
Controller.Rework()

end event

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * uo_1.X + uo_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 100, 100, 0, 0)
inv_Resize.of_Register(st_timezone, 0, 100, 100, 0)

//	Too many false positives...
//of_SetUpdateable(true)

//	Create the cyclecount controller and register self.
Controller = create n_pottingroom_controller
Container.of_SetItem("Controller", Controller)
w_pottingroom wThis
wThis = this
Controller.RegisterWindow(wThis)

end event

on w_pottingroom.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_pottingroom" then this.MenuID = create m_sheet_pottingroom
this.st_1=create st_1
this.st_timezone=create st_timezone
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_timezone
end on

on w_pottingroom.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_timezone)
end on

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

event activate;call super::activate;
Controller.Activated()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_pottingroom
end type

type st_1 from statictext within w_pottingroom
integer x = 1582
integer y = 820
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx Potting Room 1.0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_timezone from statictext within w_pottingroom
integer x = 9
integer y = 820
integer width = 1577
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "tz"
alignment alignment = center!
boolean focusrectangle = false
end type

