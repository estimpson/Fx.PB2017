$PBExportHeader$u_tabpg_21st_currentschedules.sru
forward
global type u_tabpg_21st_currentschedules from u_tabpg_dw
end type
type cb_printnewlabels from commandbutton within u_tabpg_21st_currentschedules
end type
end forward

global type u_tabpg_21st_currentschedules from u_tabpg_dw
integer width = 2341
string text = "Current Schedules"
cb_printnewlabels cb_printnewlabels
end type
global u_tabpg_21st_currentschedules u_tabpg_21st_currentschedules

type variables

n_cst_scheduling Scheduling

end variables

on u_tabpg_21st_currentschedules.create
int iCurrent
call super::create
this.cb_printnewlabels=create cb_printnewlabels
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_printnewlabels
end on

on u_tabpg_21st_currentschedules.destroy
call super::destroy
destroy(this.cb_printnewlabels)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_printnewlabels.X + (cb_printnewlabels.X - gb_1.X - gb_1.Width) + cb_printnewlabels.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_printnewlabels, 100, 0, 0, 0)

Scheduling = create n_cst_scheduling

end event

event destructor;call super::destructor;
destroy Scheduling

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_21st_currentschedules
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_21st_currentschedules
string dataobject = "d_21st_currentschedules"
end type

event dw_1::constructor;call super::constructor;
SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_printnewlabels from commandbutton within u_tabpg_21st_currentschedules
integer x = 1806
integer y = 8
integer width = 439
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print New Labels"
end type

event clicked;//
//long procResult
//long selectedRow = 0
//n_cst_associative_array	printerParm
//long WODID
//dw_1.AcceptText()
//
//int	i
//for	i = 1 to dw_1.RowCount()
//	if	dw_1.object.IsSelected[i] = 1 then
//		selectedRow = i
//		machineCode = dw_1.object.PrimaryMachineCode[selectedRow]
//		SetNull(toolCode)
//		SetNull(processCode)
//		partCode = dw_1.object.BuildPartCode[selectedRow]
//		nextBuildQty = dw_1.object.QtyNextBuild[selectedRow]
//		dueDT = dw_1.object.DueDT[selectedRow]
//		topPartCode = dw_1.object.TopPartCode[selectedRow]
//		orderNo = dw_1.object.OrderNo[selectedRow]
//		shipToCode = dw_1.object.ShipToCode[selectedRow]
//		billToCode = dw_1.object.BillToCode[selectedRow]
//		
//		if	nextBuildQty > 0 then
//			if	Scheduling.ScheduleNextBuild &
//				(	workOrderNumber &
//				,	'mon' &
//				,	machineCode &
//				,	toolCode &
//				,	processCode &
//				,	partCode &
//				,	nextBuildQty &
//				,	dueDT &
//				,	topPartCode &
//				,	orderNo &
//				,	shipToCode &
//				,	billToCode &
//				,	procResult &
//				,	true &
//				) = SUCCESS then
//				//	Show progress.
//				gnv_App.of_GetFrame().SetMicroHelp("Work order (" + workOrderNumber + ") created.")
//			end if
//		end if
//	end if
//next
//
//RefreshNotify()
//
end event

