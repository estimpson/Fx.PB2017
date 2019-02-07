HA$PBExportHeader$w_response_4t.srw
forward
global type w_response_4t from w_response
end type
type uo_1 from u_panel within w_response_4t
end type
end forward

global type w_response_4t from w_response
integer x = 214
integer y = 221
boolean controlmenu = false
uo_1 uo_1
end type
global w_response_4t w_response_4t

on w_response_4t.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_response_4t.destroy
call super::destroy
destroy(this.uo_1)
end on

event pfc_preopen;call super::pfc_preopen;
n_cst_user32 user32
n_cst_numerical numService
unsignedlong windowHandle, styles
windowHandle = handle(this)
styles = user32.GetWindowLong(windowHandle, -16)

if	styles <> 0 then
	styles = numService.of_BitWiseOr(styles, user32.WS_THICKFRAME)
	styles = numService.of_BitWiseOr(styles, user32.WS_CAPTION)
	styles = numService.of_BitWiseOr(styles, user32.WS_DLGFRAME)
	styles = numService.of_BitWiseOr(styles, user32.WS_SYSMENU)
	styles = numService.of_BitWiseOr(styles, user32.WS_SIZEBOX)
	
	user32.SetWindowLong(windowHandle, -16, styles)
end if

of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * uo_1.X + uo_1.Width, 2 * uo_1.Y + uo_1.Height)
inv_Resize.of_Register (uo_1, 0, 0, 100, 100)

of_SetPreference(true)
inv_Preference.of_SetWindow(true)

end event

type uo_1 from u_panel within w_response_4t
integer x = 9
integer y = 8
integer taborder = 10
end type

on uo_1.destroy
call u_panel::destroy
end on

