$PBExportHeader$w_customreport_inventorybylocation.srw
forward
global type w_customreport_inventorybylocation from w_customreport_date
end type
type ddlb_1 from dropdownlistbox within w_customreport_inventorybylocation
end type
end forward

global type w_customreport_inventorybylocation from w_customreport_date
string title = "Inv Location"
ddlb_1 ddlb_1
end type
global w_customreport_inventorybylocation w_customreport_inventorybylocation

on w_customreport_inventorybylocation.create
int iCurrent
call super::create
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_1
end on

on w_customreport_inventorybylocation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_1)
end on

type dw_report from w_customreport_date`dw_report within w_customreport_inventorybylocation
string dataobject = "customreport_inventory_by_location"
end type

event dw_report::pfc_retrieve;
return Retrieve(DateTime(Date(em_date1.text)), ddlb_1.Text)

end event

type st_1 from w_customreport_date`st_1 within w_customreport_inventorybylocation
end type

type em_date1 from w_customreport_date`em_date1 within w_customreport_inventorybylocation
end type

type p_calendar from w_customreport_date`p_calendar within w_customreport_inventorybylocation
end type

type cb_retrieve from w_customreport_date`cb_retrieve within w_customreport_inventorybylocation
integer x = 1253
end type

event cb_retrieve::clicked;call super::clicked;
dw_report.event pfc_Retrieve()

end event

type ddlb_1 from dropdownlistbox within w_customreport_inventorybylocation
integer x = 731
integer width = 466
integer height = 324
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string item[] = {"MF","MW","PR"}
borderstyle borderstyle = stylelowered!
end type

