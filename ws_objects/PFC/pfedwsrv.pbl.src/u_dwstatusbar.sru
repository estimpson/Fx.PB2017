$PBExportHeader$u_dwstatusbar.sru
forward
global type u_dwstatusbar from u_base
end type
type uo_rowselector from u_rowselector within u_dwstatusbar
end type
type p_down from picture within u_dwstatusbar
end type
type p_up from picture within u_dwstatusbar
end type
end forward

global type u_dwstatusbar from u_base
boolean visible = false
integer width = 2386
integer height = 168
long backcolor = 1073741824
uo_rowselector uo_rowselector
p_down p_down
p_up p_up
end type
global u_dwstatusbar u_dwstatusbar

type variables

public:
boolean ParentFocus
int MinimumHeight = 40, NormalHeight = 112

Private:
u_dw RequestorDW

n_cst_dwstatusbar StatusBarController

end variables

forward prototypes
public function integer setrequestor (datawindow _requestordw)
public function integer position ()
public function integer sizefull ()
public function integer sizesmall ()
public function integer show (boolean _visibleflag)
public function integer show ()
end prototypes

public function integer setrequestor (datawindow _requestordw);
if	IsValid(_requestorDW) then
	RequestorDW = _requestorDW
	uo_rowselector.SetRequestor(RequestorDW)
	return SUCCESS
end if

return FAILURE

end function

public function integer position ();
return StatusBarController.Position(RequestorDW)

end function

public function integer sizefull ();
if	not isvalid(RequestorDW) then return FAILURE

if	StatusBarController.SizeFull(RequestorDW) = SUCCESS then
	p_up.visible = false
	p_down.visible = true
else
	return FAILURE
end if

return SUCCESS

end function

public function integer sizesmall ();
if	not isvalid(RequestorDW) then return FAILURE

if	StatusBarController.SizeSmall(RequestorDW) = SUCCESS then
	p_up.visible = true
	p_down.visible = false
else
	return FAILURE
end if

return SUCCESS

end function

public function integer show (boolean _visibleflag);
if	not isvalid(RequestorDW) then return FAILURE

return	StatusBarController.Show(RequestorDW, _visibleFlag)

end function

public function integer show ();
return Show(ParentFocus)

end function

on u_dwstatusbar.create
int iCurrent
call super::create
this.uo_rowselector=create uo_rowselector
this.p_down=create p_down
this.p_up=create p_up
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_rowselector
this.Control[iCurrent+2]=this.p_down
this.Control[iCurrent+3]=this.p_up
end on

on u_dwstatusbar.destroy
call super::destroy
destroy(this.uo_rowselector)
destroy(this.p_down)
destroy(this.p_up)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(p_down.X + p_down.Width, p_down.Y + p_down.Height)
inv_Resize.of_Register(p_down, 100, 0, 0, 0)

StatusBarController = create n_cst_dwstatusbar
StatusBarController.SetRequestor(this)


end event

event destructor;call super::destructor;
if	IsValid(RequestorDW) then StatusBarController.Show(RequestorDW, false)
destroy StatusBarController

end event

type uo_rowselector from u_rowselector within u_dwstatusbar
integer x = 55
integer width = 1038
integer height = 112
integer taborder = 50
end type

on uo_rowselector.destroy
call u_rowselector::destroy
end on

type p_down from picture within u_dwstatusbar
event type integer show ( boolean _visibleflag )
integer x = 2341
integer width = 41
integer height = 40
string picturename = "Down.jpg"
boolean focusrectangle = false
end type

event type integer show(boolean _visibleflag);
return	StatusBarController.Show(RequestorDW, _visibleFlag)

end event

event clicked;
SizeSmall()

end event

event getfocus;
ParentFocus = true

end event

type p_up from picture within u_dwstatusbar
integer width = 41
integer height = 40
string picturename = "Up.jpg"
boolean focusrectangle = false
end type

event clicked;
SizeFull()

end event

event getfocus;
ParentFocus = true

end event

