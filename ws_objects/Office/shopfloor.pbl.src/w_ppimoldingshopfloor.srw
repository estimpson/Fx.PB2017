$PBExportHeader$w_ppimoldingshopfloor.srw
forward
global type w_ppimoldingshopfloor from w_sheet_headerdetail_4t
end type
end forward

global type w_ppimoldingshopfloor from w_sheet_headerdetail_4t
integer x = 214
integer y = 221
string title = "Shop Floor"
string menuname = "m_sheet_4t_updateable"
end type
global w_ppimoldingshopfloor w_ppimoldingshopfloor

on w_ppimoldingshopfloor.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
end on

on w_ppimoldingshopfloor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_ppimoldingshopfloor
end type

event tab_1::constructor;call super::constructor;
OpenTab(u_tabpg_ppimoldingshopfloormachines,0)

end event

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_ppimoldingshopfloor
end type

event tab_2::constructor;call super::constructor;
OpenTab(u_tabpg_ppimoldingshopfloorjobs,0)
OpenTab(u_tabpg_ppimoldingshopfloorjobinst,0)
OpenTab(u_tabpg_ppimoldingshopfloorjobtooling,0)
OpenTab(u_tabpg_ppimoldingshopfloorjobbom,0)
OpenTab(u_tabpg_ppimoldingshopfloormaterialalloc,0)
OpenTab(u_tabpg_ppimoldingshopfloorjobcomplete,0)
OpenTab(u_tabpg_ppimoldingshopfloordefects,0)
OpenTab(u_tabpg_ppimoldingshopfloormaterialcnsm,0)
OpenTab(u_tabpg_ppimoldingshopfloordowntime,0)
OpenTab(u_tabpg_ppimoldingshopfloorjobreconcile,0)

end event

type st_1 from w_sheet_headerdetail_4t`st_1 within w_ppimoldingshopfloor
end type

