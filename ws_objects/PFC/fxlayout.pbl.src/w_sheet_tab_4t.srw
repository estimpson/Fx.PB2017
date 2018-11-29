$PBExportHeader$w_sheet_tab_4t.srw
forward
global type w_sheet_tab_4t from w_sheet_4t
end type
type tab_1 from tab within w_sheet_tab_4t
end type
type tab_1 from tab within w_sheet_tab_4t
end type
end forward

global type w_sheet_tab_4t from w_sheet_4t
tab_1 tab_1
end type
global w_sheet_tab_4t w_sheet_tab_4t

on w_sheet_tab_4t.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_sheet_tab_4t.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event pfc_refresh;call super::pfc_refresh;
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

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(tab_1.X + tab_1.Width, tab_1.Y + tab_1.Height)
inv_Resize.of_Register(tab_1, 0, 0, 100, 100)

end event

event pfc_save;call super::pfc_save;
post event pfc_refresh()
return SUCCESS

end event

type tab_1 from tab within w_sheet_tab_4t
integer x = 5
integer width = 2299
integer height = 1180
integer taborder = 10
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

