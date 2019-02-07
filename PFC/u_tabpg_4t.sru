HA$PBExportHeader$u_tabpg_4t.sru
forward
global type u_tabpg_4t from u_tabpg
end type
type gb_1 from groupbox within u_tabpg_4t
end type
end forward

global type u_tabpg_4t from u_tabpg
long backcolor = 1073741824
long tabbackcolor = 1073741824
gb_1 gb_1
end type
global u_tabpg_4t u_tabpg_4t

type variables

//	Window handle
public:
long WindowHandle = 0

//	Control refresh behavior
boolean Refreshing

//	Controller (m-v-c)
n_cst_virtual_controller Controller

end variables

forward prototypes
public function integer refreshnotify ()
public function integer refresh ()
public subroutine sethasfocus (boolean _focus)
end prototypes

public function integer refreshnotify ();
n_cst_associative_array	eventParm
eventParm.of_SetItem("pfc_refresh", 1)
return gnv_App.inv_StateMSGRouter.of_Broadcast(eventParm)

end function

public function integer refresh ();
return -1

end function

public subroutine sethasfocus (boolean _focus);
if	_focus then
	gb_1.textcolor = 134217742
	gb_1.backcolor = 134217741
else
	gb_1.textcolor = 33554432
	gb_1.backcolor = 1073741824
end if

end subroutine

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_1.X + gb_1.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)

//	Setup notifications.
windowHandle = Handle(GetParent().GetParent())

end event

on u_tabpg_4t.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on u_tabpg_4t.destroy
call super::destroy
destroy(this.gb_1)
end on

type gb_1 from groupbox within u_tabpg_4t
integer width = 1751
integer height = 1084
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

