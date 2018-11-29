$PBExportHeader$u_tabpg_customerservice_billtosetups.sru
forward
global type u_tabpg_customerservice_billtosetups from u_tabpg_headerdetail
end type
type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
end type
type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
end type
type tabpage_3 from u_tabpg_customerservice_plants within tab_2
end type
type tabpage_3 from u_tabpg_customerservice_plants within tab_2
end type
type tabpage_4 from u_tabpg_customerservice_poolpoints within tab_2
end type
type tabpage_4 from u_tabpg_customerservice_poolpoints within tab_2
end type
type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
end type
type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
end type
end forward

global type u_tabpg_customerservice_billtosetups from u_tabpg_headerdetail
string text = "Customer Setups"
end type
global u_tabpg_customerservice_billtosetups u_tabpg_customerservice_billtosetups

on u_tabpg_customerservice_billtosetups.create
int iCurrent
call super::create
end on

on u_tabpg_customerservice_billtosetups.destroy
call super::destroy
end on

type tab_2 from u_tabpg_headerdetail`tab_2 within u_tabpg_customerservice_billtosetups
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_2.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type st_1 from u_tabpg_headerdetail`st_1 within u_tabpg_customerservice_billtosetups
end type

type tab_1 from u_tabpg_headerdetail`tab_1 within u_tabpg_customerservice_billtosetups
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

type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
integer x = 18
integer y = 100
integer width = 2263
integer height = 608
end type

type tabpage_3 from u_tabpg_customerservice_plants within tab_2
integer x = 18
integer y = 100
integer width = 2263
integer height = 608
end type

type tabpage_4 from u_tabpg_customerservice_poolpoints within tab_2
integer x = 18
integer y = 100
integer width = 2263
integer height = 608
end type

type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1064
end type

