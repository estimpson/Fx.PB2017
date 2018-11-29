$PBExportHeader$w_sheet_headerdetail_editpanel_4t.srw
forward
global type w_sheet_headerdetail_editpanel_4t from w_sheet_tab_4t
end type
type tab_2 from tab within w_sheet_headerdetail_editpanel_4t
end type
type tab_2 from tab within w_sheet_headerdetail_editpanel_4t
end type
type st_1 from u_st_splitbar within w_sheet_headerdetail_editpanel_4t
end type
type st_2 from u_st_splitbar within w_sheet_headerdetail_editpanel_4t
end type
type uo_editpanel from u_panel within w_sheet_headerdetail_editpanel_4t
end type
end forward

global type w_sheet_headerdetail_editpanel_4t from w_sheet_tab_4t
integer x = 214
integer y = 221
integer width = 3625
integer height = 2176
tab_2 tab_2
st_1 st_1
st_2 st_2
uo_editpanel uo_editpanel
end type
global w_sheet_headerdetail_editpanel_4t w_sheet_headerdetail_editpanel_4t

on w_sheet_headerdetail_editpanel_4t.create
int iCurrent
call super::create
this.tab_2=create tab_2
this.st_1=create st_1
this.st_2=create st_2
this.uo_editpanel=create uo_editpanel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.uo_editpanel
end on

on w_sheet_headerdetail_editpanel_4t.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.uo_editpanel)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(uo_editpanel.X + uo_editpanel.Width, uo_editpanel.Y + uo_editpanel.Height)
inv_Resize.of_Register(tab_1, 0, 0, 100, 0)
inv_Resize.of_Register(st_1, 0, 0, 100, 0)
inv_Resize.of_Register(tab_2, 0, 0, 100, 100)
inv_Resize.of_Register(st_2, 100, 0, 0, 100)
inv_Resize.of_Register(uo_editpanel, 100, 0, 0, 100)
st_1.of_Register(tab_1, st_1.ABOVE)
st_1.of_Register(tab_2, st_1.BELOW)
st_2.of_Register(tab_1, st_2.LEFT)
st_2.of_Register(st_1, st_2.LEFT)
st_2.of_Register(tab_2, st_2.LEFT)
st_2.of_Register(uo_editpanel, st_2.RIGHT)


end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_sheet_headerdetail_editpanel_4t
integer y = 20
end type

type tab_2 from tab within w_sheet_headerdetail_editpanel_4t
integer x = 5
integer y = 1208
integer width = 2299
integer height = 752
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
end type

type st_1 from u_st_splitbar within w_sheet_headerdetail_editpanel_4t
integer x = 5
integer y = 1188
integer width = 2299
end type

type st_2 from u_st_splitbar within w_sheet_headerdetail_editpanel_4t
integer x = 2299
integer width = 18
integer height = 1960
boolean bringtotop = true
end type

type uo_editpanel from u_panel within w_sheet_headerdetail_editpanel_4t
integer x = 2318
integer width = 1230
integer height = 1960
integer taborder = 20
boolean bringtotop = true
end type

on uo_editpanel.destroy
call u_panel::destroy
end on

