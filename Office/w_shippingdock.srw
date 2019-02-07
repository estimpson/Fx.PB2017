HA$PBExportHeader$w_shippingdock.srw
forward
global type w_shippingdock from w_sheet_panel_4t
end type
type hpb_refreshurgency from hprogressbar within w_shippingdock
end type
type st_1 from statictext within w_shippingdock
end type
end forward

global type w_shippingdock from w_sheet_panel_4t
integer x = 214
integer y = 221
string title = "Shipping Dock"
hpb_refreshurgency hpb_refreshurgency
st_1 st_1
end type
global w_shippingdock w_shippingdock

type variables

n_cst_shipping_controller Controller

end variables

forward prototypes
public function integer showrefreshurgency (decimal refreshurgency)
end prototypes

public function integer showrefreshurgency (decimal refreshurgency);
hpb_refreshurgency.Position = refreshUrgency*100
return SUCCESS

end function

on w_shippingdock.create
int iCurrent
call super::create
this.hpb_refreshurgency=create hpb_refreshurgency
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_refreshurgency
this.Control[iCurrent+2]=this.st_1
end on

on w_shippingdock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.hpb_refreshurgency)
destroy(this.st_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)

//	Too many false positives...
//of_SetUpdateable(true)

//	Create the cyclecount controller and register self.
Controller = create n_cst_shipping_controller
w_shippingdock wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.ShowHeaderDetail()

//	Add the controller to the window's container.
Container.of_SetItem("Controller", Controller)

//	Start timer.
Timer(1)

end event

event close;call super::close;
//	Dispose of controller
destroy Controller

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

event resize;call super::resize;hpb_refreshurgency.Y = st_1.Y
hpb_refreshurgency.BringToTop = true

end event

event timer;call super::timer;
//	Tell controller that timer event has occurred.
Timer(0)
Controller.WindowTimerTicked()
Timer(1)

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_shippingdock
integer height = 1160
end type

type hpb_refreshurgency from hprogressbar within w_shippingdock
integer x = 14
integer y = 1184
integer width = 187
integer height = 30
boolean bringtotop = true
string pointer = "HourGlass!"
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type st_1 from statictext within w_shippingdock
integer y = 1176
integer width = 2121
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217741
string text = "Fx Shipping Dock 1.0  "
alignment alignment = right!
boolean focusrectangle = false
end type

