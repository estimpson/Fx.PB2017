$PBExportHeader$u_tabpg_ppimoldingshopfloorjobdetails.sru
forward
global type u_tabpg_ppimoldingshopfloorjobdetails from u_tabpg_dwchild
end type
type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloorjobdetails
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobdetails from u_tabpg_dwchild
integer height = 1568
string text = "!Ancestor"
uo_rowcontrol uo_rowcontrol
end type
global u_tabpg_ppimoldingshopfloorjobdetails u_tabpg_ppimoldingshopfloorjobdetails

type variables

string WorkOrderNumber
long WorkOrderDetailSequence
long WorkOrderDetailLine
string StatusTypeTable

end variables

on u_tabpg_ppimoldingshopfloorjobdetails.create
int iCurrent
call super::create
this.uo_rowcontrol=create uo_rowcontrol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_rowcontrol
end on

on u_tabpg_ppimoldingshopfloorjobdetails.destroy
call super::destroy
destroy(this.uo_rowcontrol)
end on

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_ppimoldingshopfloorjobdetails
integer y = 380
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_ppimoldingshopfloorjobdetails
integer y = 460
integer height = 884
boolean hsplitscroll = true
end type

event dw_1::activerowchanged;call super::activerowchanged;
uo_RowControl.CurrentRow(activerow)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get status codes.
datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve(StatusTypeTable) <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

//	Get type codes.
datawindowchild typeDWC
if	GetChild("Type", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve(StatusTypeTable) <= 0 then
		typeDWC.InsertRow(0)
	end if
end if

end event

event dw_1::resize;call super::resize;
uo_rowcontrol.Y = Y + Height

end event

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_ppimoldingshopfloorjobdetails
integer height = 272
boolean enabled = true
string dataobject = "d_ppimoldingjobschedule"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_parent::constructor;call super::constructor;
//	Get status codes.
datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("dbo.WorkOrderHeaders") <= 0 then
		statusDWC.InsertRow(0)
	end if
end if

end event

event dw_parent::rowchanged;call super::rowchanged;
if	RowCount() < 1 then return

WorkOrderNumber = object.workordernumber[1]
WorkOrderDetailLine = object.line[1]
WorkOrderDetailSequence = object.workorderdetailsequence[1]
dw_1.event pfc_retrieve()

end event

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_ppimoldingshopfloorjobdetails
integer height = 348
string text = "Job Details"
end type

type uo_rowcontrol from u_rowselector within u_tabpg_ppimoldingshopfloorjobdetails
integer x = 5
integer y = 1344
integer height = 112
integer taborder = 90
boolean bringtotop = true
end type

event constructor;call super::constructor;
SetRequestor(dw_1)

end event

on uo_rowcontrol.destroy
call u_rowselector::destroy
end on

