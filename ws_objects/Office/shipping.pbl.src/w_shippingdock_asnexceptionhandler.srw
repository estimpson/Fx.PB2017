$PBExportHeader$w_shippingdock_asnexceptionhandler.srw
forward
global type w_shippingdock_asnexceptionhandler from w_sheet_panel_4t
end type
type st_1 from statictext within w_shippingdock_asnexceptionhandler
end type
end forward

global type w_shippingdock_asnexceptionhandler from w_sheet_panel_4t
integer x = 214
integer y = 221
string title = "ASN Exception Handler"
st_1 st_1
end type
global w_shippingdock_asnexceptionhandler w_shippingdock_asnexceptionhandler

type variables

n_shippingdock_asnexcepth_controller Controller

end variables

on w_shippingdock_asnexceptionhandler.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_shippingdock_asnexceptionhandler.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)

//	Too many false positives...
//of_SetUpdateable(true)

//	Create the controller and register self.
Controller = create n_shippingdock_asnexcepth_controller
Container.of_SetItem("Controller", Controller)
w_shippingdock_asnexceptionhandler wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.Activated()

//	Get parms.
long shipperID
shipperID = gnv_App.inv_Global.of_GetItem("ShipperID", -1)
string exceptionHandler
exceptionHandler = gnv_App.inv_Global.of_GetItem("ExceptionHandler", "")

string dwName
string pblName

select
	rl.object_name
,	rl.library_name
into
	:dwName
,	:pblName
from
	dbo.report_library rl
where
	name = :exceptionHandler  ;

if	not (pblName > "" and dwName > "") then return

Controller.SetDatawindow(pblName, dwName, shipperID)

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_shippingdock_asnexceptionhandler
end type

type st_1 from statictext within w_shippingdock_asnexceptionhandler
integer y = 828
integer width = 2121
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx ASN Exception Handler 1.0 "
alignment alignment = right!
boolean focusrectangle = false
end type

