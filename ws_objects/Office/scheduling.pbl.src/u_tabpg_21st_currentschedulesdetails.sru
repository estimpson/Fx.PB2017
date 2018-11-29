$PBExportHeader$u_tabpg_21st_currentschedulesdetails.sru
forward
global type u_tabpg_21st_currentschedulesdetails from u_tabpg_headerdetail
end type
type tabpage_1 from u_tabpg_21st_currentschedules within tab_1
end type
type tabpage_1 from u_tabpg_21st_currentschedules within tab_1
end type
end forward

global type u_tabpg_21st_currentschedulesdetails from u_tabpg_headerdetail
end type
global u_tabpg_21st_currentschedulesdetails u_tabpg_21st_currentschedulesdetails

on u_tabpg_21st_currentschedulesdetails.create
int iCurrent
call super::create
end on

on u_tabpg_21st_currentschedulesdetails.destroy
call super::destroy
end on

type tab_2 from u_tabpg_headerdetail`tab_2 within u_tabpg_21st_currentschedulesdetails
end type

type st_1 from u_tabpg_headerdetail`st_1 within u_tabpg_21st_currentschedulesdetails
end type

type tab_1 from u_tabpg_headerdetail`tab_1 within u_tabpg_21st_currentschedulesdetails
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

type tabpage_1 from u_tabpg_21st_currentschedules within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1064
end type

