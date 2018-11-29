$PBExportHeader$u_resizeablepanel.sru
forward
global type u_resizeablepanel from u_panel
end type
end forward

global type u_resizeablepanel from u_panel
end type
global u_resizeablepanel u_resizeablepanel

on u_resizeablepanel.create
call super::create
end on

on u_resizeablepanel.destroy
call super::destroy
end on

event constructor;call super::constructor;
n_cst_user32 user32
n_cst_numerical numService
unsignedlong windowHandle, styles
windowHandle = handle(this)
styles = user32.GetWindowLong(windowHandle, -16)

if	styles <> 0 then
	styles = numService.of_BitWiseOr(styles, user32.WS_THICKFRAME)
	styles = numService.of_BitWiseOr(styles, user32.WS_DLGFRAME)
	styles = numService.of_BitWiseOr(styles, user32.WS_SIZEBOX)
	
	user32.SetWindowLong(windowHandle, -16, styles)
end if

end event

type st_1 from u_panel`st_1 within u_resizeablepanel
end type

