$PBExportHeader$u_tabpg_blanketorderreleases.sru
forward
global type u_tabpg_blanketorderreleases from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_blanketorderreleases
end type
type cb_2 from commandbutton within u_tabpg_blanketorderreleases
end type
type cb_recalc from commandbutton within u_tabpg_blanketorderreleases
end type
type dw_2 from u_fxdw within u_tabpg_blanketorderreleases
end type
type cb_save from commandbutton within u_tabpg_blanketorderreleases
end type
type gb_2 from groupbox within u_tabpg_blanketorderreleases
end type
end forward

global type u_tabpg_blanketorderreleases from u_tabpg_dw
integer width = 4594
string text = "Releases"
cb_1 cb_1
cb_2 cb_2
cb_recalc cb_recalc
dw_2 dw_2
cb_save cb_save
gb_2 gb_2
end type
global u_tabpg_blanketorderreleases u_tabpg_blanketorderreleases

type variables

int	SalesOrderNo
n_cst_sales Sales
datawindow editDW
end variables

on u_tabpg_blanketorderreleases.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_recalc=create cb_recalc
this.dw_2=create dw_2
this.cb_save=create cb_save
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_recalc
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.gb_2
end on

on u_tabpg_blanketorderreleases.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_recalc)
destroy(this.dw_2)
destroy(this.cb_save)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_2.X + gb_2.Width, gb_2.Y + gb_2.Height)
inv_Resize.of_Register(dw_1, 0, 0, 50, 100)
inv_Resize.of_Register(gb_1, 0, 0, 50, 100)
inv_Resize.of_Register(cb_1, 50, 0, 0, 0)
inv_Resize.of_Register(cb_2, 50, 0, 0, 0)
inv_Resize.of_Register(cb_recalc, 50, 0, 0, 0)
inv_Resize.of_Register(cb_save, 50, 100, 0, 0)
inv_Resize.of_Register(dw_2, 50, 0, 50, 100)
inv_Resize.of_Register(gb_2, 50, 0, 50, 100)

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.salesorderno"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

//	Create Sales object.
Sales = create n_cst_sales

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (SalesOrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.salesorderno"), -1))
		SalesOrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.salesorderno"), -1)
		Refresh()
end choose

end event

event destructor;call super::destructor;
//	Destroy Sales object.
destroy Sales

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_blanketorderreleases
integer y = 4
string text = "Releases"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_blanketorderreleases
string dataobject = "d_blanketorderreleases"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
long result
Sales.GetBlanketOrderReleases(SalesOrderNo, result)
if	result = 0 then
	Sales.GetBlanketOrderDistributedReleases(result)
	if	result = 0 then
		dw_2.Retrieve()
	else
		dw_2.Reset()
	end if
	return Retrieve(SalesOrderNo)
else
	dw_2.Reset()
	return result
end if

end event

event dw_1::getfocus;call super::getfocus;
editDW = this
cb_1.enabled = true
cb_2.enabled = true
cb_1.text = "<< Delete"
cb_2.text = "<< Insert"
end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	object.spid.Initial = String (object.spid[1])
	object.activeorderno.Initial = String (object.activeorderno[1])
end if

end event

type cb_1 from commandbutton within u_tabpg_blanketorderreleases
integer x = 1806
integer y = 156
integer width = 453
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Delete"
end type

event clicked;
editDW.DeleteRow(editDW.GetRow())

end event

type cb_2 from commandbutton within u_tabpg_blanketorderreleases
integer x = 1806
integer y = 288
integer width = 453
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Insert"
end type

event clicked;
editDW.InsertRow(editDW.GetRow())

end event

type cb_recalc from commandbutton within u_tabpg_blanketorderreleases
integer x = 1806
integer y = 424
integer width = 453
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Recalculate >>"
end type

event clicked;
long	result
dw_1.AcceptText()
dw_1.Update()
commit  ;
Sales.GetBlanketOrderDistributedReleases(result)
if	result = 0 then
	dw_2.Retrieve()
else
	dw_2.Reset()
end if

end event

type dw_2 from u_fxdw within u_tabpg_blanketorderreleases
integer x = 2318
integer y = 80
integer width = 1733
integer height = 996
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_blanketorderdistributedreleases"
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event getfocus;call super::getfocus;
editDW = this
cb_1.enabled = true
cb_2.enabled = true
cb_1.text = "Delete >>"
cb_2.text = "Insert >>"
end event

event retrieveend;call super::retrieveend;
if	rowcount > 0 then
	object.spid.Initial = String (object.spid[1])
	object.activeorderno.Initial = String (object.activeorderno[1])
	object.orderno.Initial = String (object.activeorderno[1])
end if

end event

type cb_save from commandbutton within u_tabpg_blanketorderreleases
integer x = 1806
integer y = 972
integer width = 453
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save >>"
end type

event clicked;
long	result
dw_2.AcceptText()
dw_2.Update()
commit  ;
Sales.SaveBlanketOrderDistributedReleases(result)
if	result = 0 then
	Refresh()
end if

end event

type gb_2 from groupbox within u_tabpg_blanketorderreleases
integer x = 2309
integer y = 4
integer width = 1751
integer height = 1084
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Distributed Releases"
end type

