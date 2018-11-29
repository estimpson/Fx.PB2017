$PBExportHeader$u_tabpg_customerservice_shiptos1.sru
forward
global type u_tabpg_customerservice_shiptos1 from u_tabpg_dw
end type
type st_1 from u_st_splitbar within u_tabpg_customerservice_shiptos1
end type
type dw_2 from u_fxdw_custsrv_shiptoedit within u_tabpg_customerservice_shiptos1
end type
end forward

global type u_tabpg_customerservice_shiptos1 from u_tabpg_dw
integer width = 3826
string text = "Destinations"
st_1 st_1
dw_2 dw_2
end type
global u_tabpg_customerservice_shiptos1 u_tabpg_customerservice_shiptos1

type variables

string	BillToCode

end variables

on u_tabpg_customerservice_shiptos1.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_2
end on

on u_tabpg_customerservice_shiptos1.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_2)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(dw_2.X + dw_2.Width, dw_1.Y + dw_1.Height)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_2, 100, 0, 0, 100)
inv_Resize.of_Register(st_1, 100, 0, 0, 100)
st_1.post of_Register(gb_1, st_1.LEFT)
st_1.post of_Register(dw_1, st_1.LEFT)
st_1.post of_Register(dw_2, st_1.RIGHT)

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.billtocode"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		any newBillToCode
		newBillToCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.billtocode")
		if	not IsNull(newBillToCode) then
			Refreshing = (BillToCode = newBillToCode)
			BillToCode = newBillToCode
			Refresh()
		else
			dw_1.Reset()
		end if
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_shiptos1
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_shiptos1
string dataobject = "d_customerservice_shiptos"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(BillToCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	RowCount() < activeRow or activeRow < 1 then
	dw_2.Reset()
	return
end if

dw_2.ShipToCode = object.shiptocode[activeRow]
dw_2.event pfc_Retrieve()

end event

type st_1 from u_st_splitbar within u_tabpg_customerservice_shiptos1
integer x = 1755
integer y = 8
integer width = 18
integer height = 1084
boolean bringtotop = true
end type

type dw_2 from u_fxdw_custsrv_shiptoedit within u_tabpg_customerservice_shiptos1
integer x = 1769
integer taborder = 11
boolean bringtotop = true
end type

