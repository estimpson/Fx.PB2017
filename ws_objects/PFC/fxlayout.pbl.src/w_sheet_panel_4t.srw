$PBExportHeader$w_sheet_panel_4t.srw
forward
global type w_sheet_panel_4t from w_sheet_4t
end type
type uo_1 from u_panel within w_sheet_panel_4t
end type
end forward

global type w_sheet_panel_4t from w_sheet_4t
integer x = 214
integer y = 221
integer width = 2606
uo_1 uo_1
end type
global w_sheet_panel_4t w_sheet_panel_4t

on w_sheet_panel_4t.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_sheet_panel_4t.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * uo_1.X + uo_1.Width, 2 * uo_1.Y + uo_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)

end event

type uo_1 from u_panel within w_sheet_panel_4t
integer height = 808
integer taborder = 10
end type

on uo_1.destroy
call u_panel::destroy
end on

