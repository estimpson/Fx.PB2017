$PBExportHeader$w_whassembly_kanbanracks.srw
forward
global type w_whassembly_kanbanracks from w_sheet_panel_4t
end type
type st_1 from statictext within w_whassembly_kanbanracks
end type
end forward

global type w_whassembly_kanbanracks from w_sheet_panel_4t
string title = "WH Assy Kanban Racks"
string menuname = "m_sheet_4t_updateable"
st_1 st_1
end type
global w_whassembly_kanbanracks w_whassembly_kanbanracks

type variables

Private:
n_whassembly_kanbanracks_controller Controller
end variables

on w_whassembly_kanbanracks.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_whassembly_kanbanracks.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * uo_1.X + uo_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 100, 100, 0, 0)

//	Create the cyclecount controller and register self.
Controller = create n_whassembly_kanbanracks_controller
Container.of_SetItem("Controller", Controller)
w_whassembly_kanbanracks wThis
wThis = this
Controller.RegisterWindow(wThis)

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_whassembly_kanbanracks
end type

type st_1 from statictext within w_whassembly_kanbanracks
integer x = 1033
integer y = 820
integer width = 1088
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx Wire Harness Assembly Kanban Racks"
alignment alignment = right!
boolean focusrectangle = false
end type

