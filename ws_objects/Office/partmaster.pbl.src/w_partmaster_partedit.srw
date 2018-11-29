$PBExportHeader$w_partmaster_partedit.srw
forward
global type w_partmaster_partedit from w_sheet_panel_4t
end type
type st_1 from statictext within w_partmaster_partedit
end type
end forward

global type w_partmaster_partedit from w_sheet_panel_4t
integer x = 214
integer y = 221
string title = "Part Master Catalog"
string menuname = "m_partmaster_partedit"
event viewsales ( )
event viewpurchasing ( )
event viewflowrouter ( )
event viewnotes ( )
event viewcharacteristics ( )
event viewpackaging ( )
st_1 st_1
end type
global w_partmaster_partedit w_partmaster_partedit

type variables

n_cst_partmaster_partedit_controller Controller

end variables

event viewsales();
Controller.ShowSales()

end event

event viewpurchasing();
Controller.ShowPurchasing()

end event

event viewflowrouter();
Controller.ShowFlowRouter()

end event

event viewnotes();
Controller.ShowNotes()

end event

event viewcharacteristics();
Controller.ShowCharacteristics()

end event

event viewpackaging();
Controller.ShowPackaging()

end event

on w_partmaster_partedit.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_partmaster_partedit" then this.MenuID = create m_partmaster_partedit
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_partmaster_partedit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * st_1.X + st_1.Width, uo_1.Y + st_1.Y + st_1.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)

of_SetUpdateable(true)

//	Create the cyclecount controller and register self.
Controller = create n_cst_partmaster_partedit_controller
w_partmaster_partedit wThis
wThis = this
Controller.RegisterWindow(wThis)
Controller.ShowMain()

//	Add the controller to the window's container.
Container.of_SetItem("Controller", Controller)

end event

event pfc_refresh;call super::pfc_refresh;
Controller.Refresh()

end event

type uo_1 from w_sheet_panel_4t`uo_1 within w_partmaster_partedit
end type

type st_1 from statictext within w_partmaster_partedit
integer y = 824
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
string text = "Fx Part Master - Part Edit 1.0"
alignment alignment = right!
boolean focusrectangle = false
end type

