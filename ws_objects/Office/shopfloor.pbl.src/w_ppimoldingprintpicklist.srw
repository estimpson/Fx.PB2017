$PBExportHeader$w_ppimoldingprintpicklist.srw
forward
global type w_ppimoldingprintpicklist from w_response
end type
type dw_pickqty from u_dw within w_ppimoldingprintpicklist
end type
type dw_picklist from u_dw within w_ppimoldingprintpicklist
end type
type cb_preview from commandbutton within w_ppimoldingprintpicklist
end type
type cb_cancel from commandbutton within w_ppimoldingprintpicklist
end type
type cb_print from commandbutton within w_ppimoldingprintpicklist
end type
type gb_pickqty from groupbox within w_ppimoldingprintpicklist
end type
type gb_1 from groupbox within w_ppimoldingprintpicklist
end type
end forward

global type w_ppimoldingprintpicklist from w_response
integer x = 214
integer y = 221
integer width = 2853
integer height = 2440
dw_pickqty dw_pickqty
dw_picklist dw_picklist
cb_preview cb_preview
cb_cancel cb_cancel
cb_print cb_print
gb_pickqty gb_pickqty
gb_1 gb_1
end type
global w_ppimoldingprintpicklist w_ppimoldingprintpicklist

type variables

string WorkOrderNumber
long WorkOrderDetailSequence

end variables

on w_ppimoldingprintpicklist.create
int iCurrent
call super::create
this.dw_pickqty=create dw_pickqty
this.dw_picklist=create dw_picklist
this.cb_preview=create cb_preview
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.gb_pickqty=create gb_pickqty
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pickqty
this.Control[iCurrent+2]=this.dw_picklist
this.Control[iCurrent+3]=this.cb_preview
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.gb_pickqty
this.Control[iCurrent+7]=this.gb_1
end on

on w_ppimoldingprintpicklist.destroy
call super::destroy
destroy(this.dw_pickqty)
destroy(this.dw_picklist)
destroy(this.cb_preview)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.gb_pickqty)
destroy(this.gb_1)
end on

event pfc_preopen;call super::pfc_preopen;
WorkOrderNumber = IsNull(message.inv_Parm.of_GetItem("WorkOrderNumber"), "")
WorkOrderDetailSequence = IsNull(message.inv_Parm.of_GetItem("WorkOrderDetailSequence"), -1)
dw_pickqty.event pfc_Retrieve()

end event

type dw_pickqty from u_dw within w_ppimoldingprintpicklist
integer x = 32
integer y = 116
integer width = 1362
integer height = 668
integer taborder = 10
string dataobject = "d_ppimolding_picklistqty"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve (WorkOrderNumber, WorkOrderDetailSequence)

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()
of_SetUpdateable(false)

end event

event activerowchanged;call super::activerowchanged;
if	activerow <= 0 then return

//	Build the drop down with a list of full job, mfg lot size, and std pack.
decimal fullJob
decimal mfgLotSize
decimal stdPack
string part

fullJob = object.qtyrequired.original[activerow]
part = object.partCode[activerow]

select
	coalesce
	(
		(
			select
				mfg_lot_size
			from
				dbo.part_machine pm
			where
				part = :part
				and
					machine =
					(
						select
							MachineCode
						from
							dbo.WorkOrderHeaders
						where
							WorkOrderNumber = :WorkOrderNumber
					)
		)
	,	(
			select
				mfg_lot_size
			from
				dbo.part_machine pm
			where
				part = :part
				and
					sequence = 1
		)
	)
into
	:mfgLotSize
from
	parameters using SQLCA  ;

select
	standard_pack
into
	:stdPack
from
	dbo.part_inventory pi
where
	part = :part using SQLCA  ;

clearValues("qtyrequired")
setValue("qtyrequired", 1, "Full job ("+ string(fullJob) + ")~t" + string(fullJob))
setValue("qtyrequired", 2, "Mfg. lot size ("+ string(mfgLotSize) + ")~t" + string(mfgLotSize))
setValue("qtyrequired", 3, "Std. pack ("+ string(stdPack) + ")~t" + string(stdPack))

end event

type dw_picklist from u_dw within w_ppimoldingprintpicklist
integer x = 32
integer y = 932
integer width = 2775
integer height = 1376
integer taborder = 40
string dataobject = "d_ppimolding_picklist"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WorkOrderNumber, WorkOrderDetailSequence)

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetUpdateable(false)
object.datawindow.print.preview = "YES"

end event

type cb_preview from commandbutton within w_ppimoldingprintpicklist
integer x = 1467
integer y = 672
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Preview >>"
end type

event clicked;
dw_picklist.event pfc_Retrieve()

end event

type cb_cancel from commandbutton within w_ppimoldingprintpicklist
integer x = 1467
integer y = 140
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

type cb_print from commandbutton within w_ppimoldingprintpicklist
integer x = 1467
integer y = 12
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print"
end type

type gb_pickqty from groupbox within w_ppimoldingprintpicklist
integer x = 27
integer y = 4
integer width = 1376
integer height = 788
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Pick Quantity:"
end type

type gb_1 from groupbox within w_ppimoldingprintpicklist
integer x = 27
integer y = 808
integer width = 2789
integer height = 1508
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Pick List:"
end type

