$PBExportHeader$u_panel_headerdetail.sru
forward
global type u_panel_headerdetail from u_base
end type
type uo_2 from u_panel within u_panel_headerdetail
end type
type uo_1 from u_panel within u_panel_headerdetail
end type
type st_1 from u_st_splitbar within u_panel_headerdetail
end type
end forward

global type u_panel_headerdetail from u_base
integer width = 2295
integer height = 1780
long backcolor = 1073741824
event shown ( )
event move pbm_move
uo_2 uo_2
uo_1 uo_1
st_1 st_1
end type
global u_panel_headerdetail u_panel_headerdetail

type variables

end variables

forward prototypes
public function integer setheaderheight (long newheight)
end prototypes

event shown();
uo_1.trigger event Shown()
uo_2.trigger event Shown()

end event

event move;
uo_1.XOffset = xpos
uo_1.YOffset = ypos
uo_1.event shown()
//uo_1.event move(uo_1.x, uo_1.y)

uo_2.XOffset = xpos
uo_2.YOffset = ypos
uo_2.event shown()
//uo_2.event move(uo_2.x, uo_2.y)

end event

public function integer setheaderheight (long newheight);
st_1.SetSplitBarPosition(st_1.X, st_1.Y - (uo_1.Height - newHeight))

uo_1.trigger event Shown()
uo_2.trigger event Shown()

return SUCCESS

end function

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(2 * uo_2.X + uo_2.Width, uo_1.Y + uo_2.Y + uo_2.Height)
inv_Resize.of_Register(uo_1, 0, 0, 100, 0)
inv_Resize.of_Register(st_1, 0, 0, 100, 0)
inv_Resize.of_Register(uo_2, 0, 0, 100, 100)

st_1.post of_Register(uo_1, st_1.ABOVE)
st_1.post of_Register(uo_2, st_1.BELOW)

end event

on u_panel_headerdetail.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
end on

on u_panel_headerdetail.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_1)
end on

event resize;call super::resize;
uo_1.event shown()
uo_2.event shown()

end event

type uo_2 from u_panel within u_panel_headerdetail
integer y = 744
integer height = 720
integer taborder = 20
end type

on uo_2.destroy
call u_panel::destroy
end on

type uo_1 from u_panel within u_panel_headerdetail
integer y = 4
integer height = 720
integer taborder = 10
end type

on uo_1.destroy
call u_panel::destroy
end on

type st_1 from u_st_splitbar within u_panel_headerdetail
integer y = 724
integer width = 2121
end type

event mousemove;call super::mousemove;
if	not KeyDown(keyLeftButton!) then
	return
end if

BringToTop = true
parent.BringToTop = true
BringToTop = true

end event

event lbuttonup;call super::lbuttonup;
uo_1.trigger event Shown()
uo_2.trigger event Shown()

end event

