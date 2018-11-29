$PBExportHeader$u_tabpg_headerdetail.sru
forward
global type u_tabpg_headerdetail from u_base
end type
type tab_2 from tab within u_tabpg_headerdetail
end type
type tab_2 from tab within u_tabpg_headerdetail
end type
type st_1 from u_st_splitbar within u_tabpg_headerdetail
end type
type tab_1 from tab within u_tabpg_headerdetail
end type
type tab_1 from tab within u_tabpg_headerdetail
end type
end forward

global type u_tabpg_headerdetail from u_base
integer width = 2711
integer height = 2184
long backcolor = 1073741824
event pfc_refresh ( )
tab_2 tab_2
st_1 st_1
tab_1 tab_1
end type
global u_tabpg_headerdetail u_tabpg_headerdetail

event pfc_refresh();
//	Refresh all tab pages that inherit from u_tabpg_dw unless they inherit from u_tabpg_dwchild.
int i
for	i = 1 to UpperBound(tab_1.control)
	ClassDefinition tabPageClassDefinition
	tabPageClassDefinition = tab_1.control[1].ClassDefinition
	boolean dwTabPage; dwTabPage = false
	ClassDefinition parentDef
	parentDef = tabPageClassDefinition
	do while IsValid(parentDef) and not dwTabPage
		choose case parentDef.Name
			case "u_tabpg_dwchild"
				dwTabPage = true
			case "u_tabpg_dw"
				dwTabPage = true
				u_tabpg_dw headerTabPg
				headerTabPg = tab_1.control[i]
				headerTabPg.Refreshing = true
				headerTabPg.Refresh()
			case "u_tabpg_headerdetail"
				dwTabPage = true
				u_tabpg_headerdetail headerDetailTabPg
				headerDetailTabPg = tab_1.control[i]
				headerDetailTabPg.event pfc_refresh ()
		end choose
		parentDef = parentDef.Ancestor
	loop
next

end event

on u_tabpg_headerdetail.create
int iCurrent
call super::create
this.tab_2=create tab_2
this.st_1=create st_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.tab_1
end on

on u_tabpg_headerdetail.destroy
call super::destroy
destroy(this.tab_2)
destroy(this.st_1)
destroy(this.tab_1)
end on

event constructor;call super::constructor;
of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(tab_2.X + tab_2.Width, tab_2.Y + tab_2.Height)
inv_Resize.of_Register(tab_1, 0, 0, 100, 0)
inv_Resize.of_Register(st_1, 0, 0, 100, 0)
inv_Resize.of_Register(tab_2, 0, 0, 100, 100)
st_1.post of_Register(tab_1, st_1.ABOVE)
st_1.post of_Register(tab_2, st_1.BELOW)

end event

type tab_2 from tab within u_tabpg_headerdetail
integer x = 5
integer y = 1208
integer width = 2299
integer height = 724
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
end type

type st_1 from u_st_splitbar within u_tabpg_headerdetail
integer x = 5
integer y = 1188
integer width = 2299
boolean bringtotop = true
end type

type tab_1 from tab within u_tabpg_headerdetail
integer x = 5
integer y = 20
integer width = 2299
integer height = 1180
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
end type

