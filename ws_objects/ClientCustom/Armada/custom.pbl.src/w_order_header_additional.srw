$PBExportHeader$w_order_header_additional.srw
forward
global type w_order_header_additional from w_sheet_4t
end type
type dw_1 from datawindow within w_order_header_additional
end type
end forward

global type w_order_header_additional from w_sheet_4t
integer x = 1723
integer y = 672
integer width = 3602
integer height = 3028
string title = "Additional Fields"
string menuname = "m_order_header_additional"
event ue_exit ( )
event ue_save ( )
dw_1 dw_1
end type
global w_order_header_additional w_order_header_additional

event ue_exit;
Close(this)

end event

event ue_save;dw_1.AcceptText()
dw_1.Update()
commit;

end event

on w_order_header_additional.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_order_header_additional" then this.MenuID = create m_order_header_additional
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_order_header_additional.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event resize;dw_1.resize(width - 60, height - 140)

end event

type dw_1 from datawindow within w_order_header_additional
integer width = 3493
integer height = 2588
integer taborder = 10
string dataobject = "d_order_header_additional3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;
SetTransObject(SQLCA)
Retrieve(w_blanket_order.iOrder)

end event

