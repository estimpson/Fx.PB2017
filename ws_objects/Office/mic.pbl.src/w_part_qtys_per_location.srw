$PBExportHeader$w_part_qtys_per_location.srw
forward
global type w_part_qtys_per_location from w_sheet_4t
end type
type st_1 from u_st_splitbar within w_part_qtys_per_location
end type
type tab_2 from tab within w_part_qtys_per_location
end type
type tabpage_1 from u_tabpg_partinventory_inlocation within tab_2
end type
type tabpage_1 from u_tabpg_partinventory_inlocation within tab_2
end type
type tab_2 from tab within w_part_qtys_per_location
tabpage_1 tabpage_1
end type
type uo_1 from u_tabpg_partinventory_bylocation within w_part_qtys_per_location
end type
end forward

global type w_part_qtys_per_location from w_sheet_4t
integer x = 214
integer y = 221
integer height = 2512
string title = "Part: "
st_1 st_1
tab_2 tab_2
uo_1 uo_1
end type
global w_part_qtys_per_location w_part_qtys_per_location

type variables

string Part

end variables

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(tab_2.X + tab_2.Width, tab_2.Y + tab_2.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 0, 100, 0)
inv_Resize.of_Register(tab_2, 0, 0, 100, 100)
st_1.of_Register(uo_1, st_1.ABOVE)
st_1.of_Register(tab_2, st_1.BELOW)

Part = isnull(message.inv_Parm.of_GetItem("part"), "N/S")
w_part_qtys_per_location.Title = w_part_qtys_per_location.Title + Part

end event

on w_part_qtys_per_location.create
int iCurrent
call super::create
this.st_1=create st_1
this.tab_2=create tab_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.tab_2
this.Control[iCurrent+3]=this.uo_1
end on

on w_part_qtys_per_location.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.tab_2)
destroy(this.uo_1)
end on

event pfc_postopen;call super::pfc_postopen;
uo_1.Part = Part
uo_1.post Refresh()

end event

type st_1 from u_st_splitbar within w_part_qtys_per_location
integer x = 5
integer y = 1188
integer width = 2299
end type

type tab_2 from tab within w_part_qtys_per_location
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
tabpage_1 tabpage_1
end type

on tab_2.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_2.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from u_tabpg_partinventory_inlocation within tab_2
integer x = 18
integer y = 48
integer width = 2263
integer height = 688
end type

type uo_1 from u_tabpg_partinventory_bylocation within w_part_qtys_per_location
integer x = 23
integer y = 8
integer width = 2281
integer height = 1188
integer taborder = 20
end type

on uo_1.destroy
call u_tabpg_partinventory_bylocation::destroy
end on

