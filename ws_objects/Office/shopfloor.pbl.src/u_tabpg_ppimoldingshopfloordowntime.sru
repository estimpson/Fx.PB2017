$PBExportHeader$u_tabpg_ppimoldingshopfloordowntime.sru
forward
global type u_tabpg_ppimoldingshopfloordowntime from u_tabpg_ppimoldingshopfloorjobdetails
end type
type dw_downtimeclock from u_dw within u_tabpg_ppimoldingshopfloordowntime
end type
end forward

global type u_tabpg_ppimoldingshopfloordowntime from u_tabpg_ppimoldingshopfloorjobdetails
integer width = 2281
integer height = 1664
string text = "Down Time"
string statustypetable = "dbo.DownTimeEntries"
dw_downtimeclock dw_downtimeclock
end type
global u_tabpg_ppimoldingshopfloordowntime u_tabpg_ppimoldingshopfloordowntime

type variables

end variables

on u_tabpg_ppimoldingshopfloordowntime.create
int iCurrent
call super::create
this.dw_downtimeclock=create dw_downtimeclock
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_downtimeclock
end on

on u_tabpg_ppimoldingshopfloordowntime.destroy
call super::destroy
destroy(this.dw_downtimeclock)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(gb_1.X + gb_1.Width, dw_downtimeclock.Y + dw_downtimeclock.Height)
inv_Resize.of_Register(dw_downtimeclock, 100, 100, 0, 0)


end event

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloordowntime
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloordowntime
string dataobject = "d_ppimoldingjobdowntime"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber, WorkOrderDetailSequence)

end event

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloordowntime
end type

event dw_parent::rowchanged;call super::rowchanged;
dw_downtimeclock.event pfc_retrieve()

end event

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloordowntime
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloordowntime
end type

type dw_downtimeclock from u_dw within u_tabpg_ppimoldingshopfloordowntime
event timer pbm_timer
integer x = 247
integer y = 1468
integer width = 1509
integer height = 176
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_downtimeclock"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event timer;
SetRedraw(false)
SetRedraw(true)

end event

event pfc_retrieve;call super::pfc_retrieve;
//	Get the last begin datetime for an open downtime entry.
datetime beginDownTimeDT
setnull(beginDownTimeDT)
select
	max(BeginDownTimeDT)
into
	:beginDownTimeDT
from
	dbo.DownTimeEntries dte
where
	WorkOrderNumber = :WorkOrderNumber
	and
		WorkOrderDetailSequence = :WorkOrderDetailSequence
	and
		EndDownTimeDT is null using SQLCA  ;

if	isnull(beginDownTimeDT) then
	Timer(0)
	return Reset()
else
	Timer(.5)
	return Retrieve(beginDownTimeDT, datetime(today(),now()))
end if

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

