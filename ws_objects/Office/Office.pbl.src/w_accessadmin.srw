$PBExportHeader$w_accessadmin.srw
forward
global type w_accessadmin from w_response
end type
type cb_apply from commandbutton within w_accessadmin
end type
type cb_show from commandbutton within w_accessadmin
end type
type dw_chooseuser from u_dw_chooseitem within w_accessadmin
end type
type cb_cancel from commandbutton within w_accessadmin
end type
type cb_ok from commandbutton within w_accessadmin
end type
type tv_menu from u_tv within w_accessadmin
end type
end forward

global type w_accessadmin from w_response
integer width = 1655
integer height = 2048
boolean controlmenu = false
boolean clientedge = true
cb_apply cb_apply
cb_show cb_show
dw_chooseuser dw_chooseuser
cb_cancel cb_cancel
cb_ok cb_ok
tv_menu tv_menu
end type
global w_accessadmin w_accessadmin

type variables

n_srv_menuuseraccess UserAccess

end variables

event pfc_postopen;call super::pfc_postopen;
of_SetPreference(true)

//	Setup resize.
of_SetResize(true)
inv_Resize.of_Register(tv_menu, 0, 0, 100, 100)
inv_Resize.of_Register(cb_ok, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)

//	Build access menu.
string user
user = message.StringParm
dw_chooseuser.object.selectedvalue[1] = user
UserAccess.BuildUserMenu ('ALL', user, tv_menu, true)

end event

on w_accessadmin.create
int iCurrent
call super::create
this.cb_apply=create cb_apply
this.cb_show=create cb_show
this.dw_chooseuser=create dw_chooseuser
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tv_menu=create tv_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apply
this.Control[iCurrent+2]=this.cb_show
this.Control[iCurrent+3]=this.dw_chooseuser
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.tv_menu
end on

on w_accessadmin.destroy
call super::destroy
destroy(this.cb_apply)
destroy(this.cb_show)
destroy(this.dw_chooseuser)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tv_menu)
end on

event pfc_preopen;call super::pfc_preopen;
//	Make window resizable.
n_cst_user32 user32
ulong styles
n_cst_numerical num
styles = user32.GetWindowLong(handle(this), -16)
if	styles <> 0 then
	styles += user32.WS_THICKFRAME + user32.WS_SYSMENU
	user32.SetWindowLong(handle(this), -16, styles)
end if

end event

type cb_apply from commandbutton within w_accessadmin
integer x = 1216
integer y = 296
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Apply"
boolean default = true
end type

event clicked;
//	Save access data.
UserAccess.SaveUserAccess2(tv_menu)

end event

type cb_show from commandbutton within w_accessadmin
integer x = 1115
integer y = 36
integer width = 251
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show"
end type

event clicked;
//	Reset the menu.
do while tv_menu.FindItem(RootTreeItem!, 0) > 0
	tv_menu.DeleteItem(tv_menu.FindItem(RootTreeItem!, 0))
loop

//	Show selected user.
string user
user = dw_chooseuser.object.selectedvalue[1]
UserAccess.BuildUserMenu ('ALL', user, tv_menu, true)

end event

type dw_chooseuser from u_dw_chooseitem within w_accessadmin
integer x = 23
integer y = 36
integer width = 1070
integer height = 88
integer taborder = 10
end type

type cb_cancel from commandbutton within w_accessadmin
integer x = 1216
integer y = 404
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
//	Do nothing but close.
Close(parent)

end event

type cb_ok from commandbutton within w_accessadmin
integer x = 1216
integer y = 188
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
end type

event clicked;
//	Save access data.
UserAccess.SaveUserAccess2(tv_menu)
Close(parent)

end event

type tv_menu from u_tv within w_accessadmin
integer x = 14
integer y = 188
integer width = 1157
integer height = 1636
integer taborder = 10
boolean checkboxes = true
end type

