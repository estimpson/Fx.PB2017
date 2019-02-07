$PBExportHeader$w_utilities_main.srw
forward
global type w_utilities_main from window
end type
type mdi_1 from mdiclient within w_utilities_main
end type
type mle_1 from multilineedit within w_utilities_main
end type
end forward

global type w_utilities_main from window
integer width = 3657
integer height = 2400
boolean titlebar = true
string title = "Monitor Utilities"
string menuname = "m_utility_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 78682240
event ue_syncpartdesc ( )
event ue_chgpartinfr ( )
mdi_1 mdi_1
mle_1 mle_1
end type
global w_utilities_main w_utilities_main

type variables
Integer iCount = 1
end variables

event ue_syncpartdesc;open ( w_chgpartdesc ) 
end event

event ue_chgpartinfr;open ( w_chgcomponentpart ) 
end event

event open;This.title = monsys.title + sqlca.is_Profile
end event

on w_utilities_main.create
if this.MenuName = "m_utility_menu" then this.MenuID = create m_utility_menu
this.mdi_1=create mdi_1
this.mle_1=create mle_1
this.Control[]={this.mdi_1,&
this.mle_1}
end on

on w_utilities_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mle_1)
end on

type mdi_1 from mdiclient within w_utilities_main
long BackColor=276856960
end type

type mle_1 from multilineedit within w_utilities_main
integer x = 681
integer y = 516
integer width = 1993
integer height = 740
integer textsize = -45
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78682240
string text = "Monitor Utility Applications"
boolean border = false
alignment alignment = center!
boolean displayonly = true
end type

