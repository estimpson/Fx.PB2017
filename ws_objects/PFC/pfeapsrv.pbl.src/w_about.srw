$PBExportHeader$w_about.srw
$PBExportComments$Extension About window
forward
global type w_about from pfc_w_about
end type
type dw_1 from u_dw within w_about
end type
end forward

global type w_about from pfc_w_about
integer width = 3141
integer height = 2092
long backcolor = 1073741824
dw_1 dw_1
end type
global w_about w_about

on w_about.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_about.destroy
call super::destroy
destroy(this.dw_1)
end on

type p_about from pfc_w_about`p_about within w_about
boolean visible = false
integer x = 0
integer y = 4
integer width = 1047
integer height = 184
boolean originalsize = false
string picturename = "Bulb.Fore-Thought.bmp"
end type

type st_application from pfc_w_about`st_application within w_about
integer x = 411
integer y = 204
long backcolor = 1073741824
end type

type st_version from pfc_w_about`st_version within w_about
integer x = 411
integer y = 276
long backcolor = 1073741824
end type

type cb_ok from pfc_w_about`cb_ok within w_about
integer x = 1678
integer y = 8
end type

type st_copyright from pfc_w_about`st_copyright within w_about
integer x = 411
integer y = 348
long backcolor = 1073741824
end type

type dw_1 from u_dw within w_about
integer x = 23
integer y = 648
integer width = 2505
integer height = 1232
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_aboutserver"
end type

event constructor;call super::constructor;of_SetTransObject(SQLCA)
Retrieve()

end event

