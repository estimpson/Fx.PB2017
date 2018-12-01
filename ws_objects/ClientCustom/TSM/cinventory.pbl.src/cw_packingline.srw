$PBExportHeader$cw_packingline.srw
forward
global type cw_packingline from w_packingline
end type
end forward

global type cw_packingline from w_packingline
end type
global cw_packingline cw_packingline

on cw_packingline.create
int iCurrent
call super::create
end on

on cw_packingline.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_packingline`tab_1 within cw_packingline
end type

type tabpage_1 from w_packingline`tabpage_1 within tab_1
end type

type tab_2 from w_packingline`tab_2 within cw_packingline
end type

type tabpage_2 from w_packingline`tabpage_2 within tab_2
end type

type tabpage_3 from w_packingline`tabpage_3 within tab_2
end type

type tabpage_4 from w_packingline`tabpage_4 within tab_2
end type

type st_1 from w_packingline`st_1 within cw_packingline
end type

