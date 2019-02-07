HA$PBExportHeader$w_receivingdockv2.srw
forward
global type w_receivingdockv2 from w_sheet_panel_4t
end type
type st_1 from statictext within w_receivingdockv2
end type
type st_activeputawaylocation from statictext within w_receivingdockv2
end type
end forward

global type w_receivingdockv2 from w_sheet_panel_4t
integer x = 214
integer y = 221
integer width = 3694
string title = "Receiving Dock"
string menuname = "m_sheet_4t_updateable"
st_1 st_1
st_activeputawaylocation st_activeputawaylocation
end type
global w_receivingdockv2 w_receivingdockv2

type variables

private n_cst_receivingdock_controller Controller

end variables

forward prototypes
public function integer showputawaylocation (string location)
public function integer hideputawaylocation ()
end prototypes

public function integer showputawaylocation (string location);
st_activeputawaylocation.Visible = true
st_activeputawaylocation.Text = "Put-Away Location: " + location
return SUCCESS

end function

public function integer hideputawaylocation ();
st_activeputawaylocation.Visible = false
return SUCCESS

end function

on w_receivingdockv2.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
this.st_1=create st_1
this.st_activeputawaylocation=create st_activeputawaylocation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_activeputawaylocation
end on

on w_receivingdockv2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_activeputawaylocation)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)
inv_Resize.of_Register(st_activeputawaylocation, 0, 100, 0, 0)

//	Too many false positives...
//of_SetUpdateable(true)

//	Create the cyclecount controller and register self.
Controller = create n_cst_receivingdock_controller
Container.of_SetItem("Controller", Controller)
w_receivingdockv2 wThis
wThis = this
Controller.RegisterWindow(wThis)

end event

event close;call super::close;
//	Dispose of controller
destroy Controller

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

event pfc_new;call super::pfc_new;
Controller.NewReceiver()

end event

event activate;call super::activate;
Controller.Activated()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_receivingdockv2
integer height = 1156
end type

type st_1 from statictext within w_receivingdockv2
integer y = 1176
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
string text = "Fx Receiving Dock 2.0  "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_activeputawaylocation from statictext within w_receivingdockv2
boolean visible = false
integer x = 9
integer y = 1176
integer width = 1262
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 32768
string text = "Current Location:"
boolean focusrectangle = false
end type

