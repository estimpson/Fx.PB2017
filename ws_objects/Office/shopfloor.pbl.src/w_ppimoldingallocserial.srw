$PBExportHeader$w_ppimoldingallocserial.srw
forward
global type w_ppimoldingallocserial from w_popup
end type
type dw_1 from u_dw within w_ppimoldingallocserial
end type
type cb_done from commandbutton within w_ppimoldingallocserial
end type
end forward

global type w_ppimoldingallocserial from w_popup
integer x = 214
integer y = 221
integer width = 1975
integer height = 1092
string title = "Scan Serials to Allocate"
boolean center = true
dw_1 dw_1
cb_done cb_done
end type
global w_ppimoldingallocserial w_ppimoldingallocserial

type variables

long ParentWindowHandle
string WorkOrderNumber
long WorkOrderDetailSequence
long Suffix

n_cst_shopfloortrans ShopFloorTrans


end variables

on w_ppimoldingallocserial.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_done=create cb_done
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_done
end on

on w_ppimoldingallocserial.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_done)
end on

event pfc_preopen;call super::pfc_preopen;
WorkOrderNumber = IsNull(message.inv_Parm.of_GetItem("WorkOrderNumber"), "")
WorkOrderDetailSequence = IsNull(message.inv_Parm.of_GetItem("WorkOrderDetailSequence"), -1)
ParentWindowHandle = IsNull(message.inv_Parm.of_GetItem("ParentWindowHandle"), -1)
long null;setnull(null)
Suffix = IsNull(message.inv_Parm.of_GetItem("Suffix"), null)

ShopFloorTrans = create n_cst_shopfloortrans

end event

event close;call super::close;
destroy ShopFloorTrans

end event

type dw_1 from u_dw within w_ppimoldingallocserial
integer x = 37
integer y = 48
integer width = 1275
integer height = 192
integer taborder = 30
string dataobject = "d_ppimolding_allocserial"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

end event

event pfc_retrieve;call super::pfc_retrieve;
if	Retrieve (WorkOrderNumber) > 0 then
	
	datawindowchild toolList
	if	GetChild("newmold", toolList) = 1 then
		toolList.SetTransObject(SQLCA)
		if	toolList.Retrieve(object.partcode[1]) = 0 then
			toolList.InsertRow(0)
		end if
	end if

	return RowCount()
end if

return -1

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.name)
	case "serial"
		//	Extract serial number from barcode identifier.
		long serial
		serial = ShopFloorTrans.TrailingDigits(data)
		if	isnull(serial, -1) <= 0 then
			serial = ShopFloorTrans.SerialFromLot(data)
			if	isnull(serial, -1) <= 0 then
				msgbox("Unrecognized scan data. " + isnull(data, "[no data]"))
				object.serial[1] = ""
				return 2
			end if
		end if
		long breakoutSerial; setnull(breakoutSerial)
		decimal qtyBreakout; setnull(qtyBreakout)
		if	object.breakout[1] = 1 then
			qtyBreakout = isnull(object.qtybreakout[1], -1)
			if	not qtyBreakout > 0 then
				MsgBox("Enter a valid breakout quantity or deselect breakout option.")
				SetColumn("qtybreakout")
				object.serial[1] = ""
				return 2
			end if
		end if
		if	ShopFloorTrans.AllocateSerial(serial, WorkOrderNumber, WorkOrderDetailSequence, Suffix, qtyBreakout, breakoutSerial) = SUCCESS then
			n_cst_associative_array	eventParm
			if	object.breakout[1] = 1 then
				eventParm.of_SetItem(String(ParentWindowHandle) + ".SerialAllocated", breakoutSerial)
			else
				eventParm.of_SetItem(String(ParentWindowHandle) + ".SerialAllocated", serial)
			end if
			gnv_App.inv_StateMSGRouter.of_Broadcast(eventParm)
		end if
		object.serial[1] = ""
		setnull(qtyBreakout)
		object.qtybreakout[1] = qtyBreakout
		if	object.breakout[1] = 1 then
			SetColumn("qtybreakout")
		else
			SetColumn("serial")
		end if
		return 2
end choose

end event

event itemerror;call super::itemerror;
return 1

end event

event clicked;call super::clicked;
choose case lower(dwo.name)
	case "breakout"
		if	object.breakout[1] = 1 then
			object.breakout[1] = 0
			SetColumn("serial")
		else
			object.breakout[1] = 1
			SetColumn("qtybreakout")
		end if
end choose

end event

type cb_done from commandbutton within w_ppimoldingallocserial
integer x = 1513
integer y = 44
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Done"
end type

event clicked;
Close(parent)

end event

