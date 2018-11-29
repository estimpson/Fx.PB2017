$PBExportHeader$u_tabpg_customerservice_normalorder_adm.sru
forward
global type u_tabpg_customerservice_normalorder_adm from u_tabpg_headerdetail
end type
type tabpage_2 from u_tabpg_customerservice_blankorderdetail within tab_2
end type
type tabpage_2 from u_tabpg_customerservice_blankorderdetail within tab_2
end type
type tabpage_1 from u_tabpg_customerservice_normalorders within tab_1
end type
type tabpage_1 from u_tabpg_customerservice_normalorders within tab_1
end type
end forward

global type u_tabpg_customerservice_normalorder_adm from u_tabpg_headerdetail
string text = "Normal Orders"
end type
global u_tabpg_customerservice_normalorder_adm u_tabpg_customerservice_normalorder_adm

on u_tabpg_customerservice_normalorder_adm.create
int iCurrent
call super::create
end on

on u_tabpg_customerservice_normalorder_adm.destroy
call super::destroy
end on

type tab_2 from u_tabpg_headerdetail`tab_2 within u_tabpg_customerservice_normalorder_adm
boolean showpicture = false
tabposition tabposition = tabsonbottom!
tabpage_2 tabpage_2
end type

on tab_2.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type st_1 from u_tabpg_headerdetail`st_1 within u_tabpg_customerservice_normalorder_adm
end type

type tab_1 from u_tabpg_headerdetail`tab_1 within u_tabpg_customerservice_normalorder_adm
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_2 from u_tabpg_customerservice_blankorderdetail within tab_2
integer x = 18
integer y = 16
integer width = 2263
integer height = 608
end type

type tabpage_1 from u_tabpg_customerservice_normalorders within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1064
end type

