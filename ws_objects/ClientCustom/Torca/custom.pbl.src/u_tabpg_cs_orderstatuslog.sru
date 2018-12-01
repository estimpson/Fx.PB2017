$PBExportHeader$u_tabpg_cs_orderstatuslog.sru
forward
global type u_tabpg_cs_orderstatuslog from u_tabpg_dw
end type
end forward

global type u_tabpg_cs_orderstatuslog from u_tabpg_dw
integer width = 2450
string text = "Status Log"
end type
global u_tabpg_cs_orderstatuslog u_tabpg_cs_orderstatuslog

type variables

end variables

on u_tabpg_cs_orderstatuslog.create
call super::create
end on

on u_tabpg_cs_orderstatuslog.destroy
call super::destroy
end on

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_cs_orderstatuslog
string dataobject = "d_dbo_cs_orderstatuslog"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::clicked;call super::clicked;
if	row > 0 then
	SetRow(row)
end if

end event

event dw_1::itemchanged;call super::itemchanged;
int i, selectedRows[]

choose case lower(dwo.name)
	case lower("OrderStatus")
		selectedRows = dw_1.object.isselected.primary
		for i = 1 to UpperBound(selectedRows)
			if	selectedRows[i] = 1 then
				dw_1.object.OrderStatus[i] = data
			end if
		next
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_cs_orderstatuslog
string text = "Orders Status Log"
end type

