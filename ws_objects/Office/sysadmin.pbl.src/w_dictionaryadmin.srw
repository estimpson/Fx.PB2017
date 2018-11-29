$PBExportHeader$w_dictionaryadmin.srw
forward
global type w_dictionaryadmin from w_sheet_tab_4t
end type
type tabpage_dictionarytablecolumns from u_tabpg_dictionarytablecolumns within tab_1
end type
type tabpage_dictionarytablecolumns from u_tabpg_dictionarytablecolumns within tab_1
end type
type tabpage_1 from u_tabpg_dictionarydatatypes within tab_1
end type
type tabpage_1 from u_tabpg_dictionarydatatypes within tab_1
end type
type tabpage_2 from u_tabpg_dictionarydatatypestringvalues within tab_1
end type
type tabpage_2 from u_tabpg_dictionarydatatypestringvalues within tab_1
end type
type tabpage_3 from u_tabpg_dictionarytablecolumngroups within tab_1
end type
type tabpage_3 from u_tabpg_dictionarytablecolumngroups within tab_1
end type
type tabpage_4 from u_tabpg_dictionarytableupdatekey within tab_1
end type
type tabpage_4 from u_tabpg_dictionarytableupdatekey within tab_1
end type
end forward

global type w_dictionaryadmin from w_sheet_tab_4t
integer width = 2523
integer height = 1740
string title = "Dictionary Admin"
string menuname = "m_sheet_4t_updateable"
end type
global w_dictionaryadmin w_dictionaryadmin

on w_dictionaryadmin.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
end on

on w_dictionaryadmin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
//	Enable update service.
of_SetUpdateable(true)

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_dictionaryadmin
tabpage_dictionarytablecolumns tabpage_dictionarytablecolumns
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_dictionarytablecolumns=create tabpage_dictionarytablecolumns
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_dictionarytablecolumns
this.Control[iCurrent+2]=this.tabpage_1
this.Control[iCurrent+3]=this.tabpage_2
this.Control[iCurrent+4]=this.tabpage_3
this.Control[iCurrent+5]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_dictionarytablecolumns)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_dictionarytablecolumns from u_tabpg_dictionarytablecolumns within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_1 from u_tabpg_dictionarydatatypes within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_dictionarydatatypestringvalues within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_3 from u_tabpg_dictionarytablecolumngroups within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_4 from u_tabpg_dictionarytableupdatekey within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

