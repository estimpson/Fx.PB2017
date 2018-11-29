$PBExportHeader$u_tabpg_customerservice_blankorderdetail.sru
forward
global type u_tabpg_customerservice_blankorderdetail from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_customerservice_blankorderdetail
end type
type cb_split from commandbutton within u_tabpg_customerservice_blankorderdetail
end type
type cb_schedship from commandbutton within u_tabpg_customerservice_blankorderdetail
end type
end forward

global type u_tabpg_customerservice_blankorderdetail from u_tabpg_dw
integer width = 2469
string text = "Releases"
cb_new cb_new
cb_split cb_split
cb_schedship cb_schedship
end type
global u_tabpg_customerservice_blankorderdetail u_tabpg_customerservice_blankorderdetail

type variables

long	OrderNumber

end variables

on u_tabpg_customerservice_blankorderdetail.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_split=create cb_split
this.cb_schedship=create cb_schedship
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_split
this.Control[iCurrent+3]=this.cb_schedship
end on

on u_tabpg_customerservice_blankorderdetail.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_split)
destroy(this.cb_schedship)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_split, 100, 0, 0, 0)
inv_Resize.of_Register(cb_schedship, 100, 0, 0, 0)

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.ordernumber"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		any newOrderNumber
		newOrderNumber = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.ordernumber")
		if	not IsNull(newOrderNumber) then
			Refreshing = (OrderNumber = newOrderNumber)
			OrderNumber = newOrderNumber
			Refresh()
		else
			dw_1.Reset()
		end if
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_blankorderdetail
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_blankorderdetail
string dataobject = "d_customerservice_blanketorderreleases"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(OrderNumber)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

type cb_new from commandbutton within u_tabpg_customerservice_blankorderdetail
integer x = 1810
integer y = 60
integer width = 489
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New"
end type

type cb_split from commandbutton within u_tabpg_customerservice_blankorderdetail
integer x = 1810
integer y = 192
integer width = 489
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Split Release..."
end type

type cb_schedship from commandbutton within u_tabpg_customerservice_blankorderdetail
integer x = 1810
integer y = 324
integer width = 489
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sched. Shipper..."
end type

