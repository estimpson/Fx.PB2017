$PBExportHeader$w_part_inquiry_ct.srw
forward
global type w_part_inquiry_ct from w_inquiry_ancestor
end type
end forward

global type w_part_inquiry_ct from w_inquiry_ancestor
string title = "Part Inquiry"
string menuname = "m_part_inquiry_ct"
long backcolor = 79741120
end type
global w_part_inquiry_ct w_part_inquiry_ct

on w_part_inquiry_ct.create
call super::create
if this.MenuName = "m_part_inquiry_ct" then this.MenuID = create m_part_inquiry_ct
end on

on w_part_inquiry_ct.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Close ( w_cost_main )

end event

type st_1 from w_inquiry_ancestor`st_1 within w_part_inquiry_ct
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_part_inquiry_ct
integer x = 14
string dataobject = "d_part_inquiry_ct"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;String l_s_part

dw_inquiry.DBcancel()

if row < 1 then return

l_s_part = GetItemString ( row, "part" )

OpenSheetWithParm ( w_cost, l_s_part, wMainScreen, 3, Original! )
end event

