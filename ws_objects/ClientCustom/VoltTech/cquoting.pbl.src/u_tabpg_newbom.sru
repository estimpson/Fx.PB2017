$PBExportHeader$u_tabpg_newbom.sru
forward
global type u_tabpg_newbom from u_base
end type
type st_2 from u_st_splitbar within u_tabpg_newbom
end type
type st_1 from u_st_splitbar within u_tabpg_newbom
end type
type _existingpartpanel from u_panel within u_tabpg_newbom
end type
type _newbompanel from u_panel within u_tabpg_newbom
end type
type rb_newpart from radiobutton within u_tabpg_newbom
end type
type rb_existingpart from radiobutton within u_tabpg_newbom
end type
type gb_1 from groupbox within u_tabpg_newbom
end type
type _newpartpanel from u_panel within u_tabpg_newbom
end type
type gb_2 from groupbox within u_tabpg_newbom
end type
end forward

global type u_tabpg_newbom from u_base
integer width = 3909
integer height = 2276
long backcolor = 1073741824
event move pbm_move
event shown ( )
st_2 st_2
st_1 st_1
_existingpartpanel _existingpartpanel
_newbompanel _newbompanel
rb_newpart rb_newpart
rb_existingpart rb_existingpart
gb_1 gb_1
_newpartpanel _newpartpanel
gb_2 gb_2
end type
global u_tabpg_newbom u_tabpg_newbom

event move;
_existingPartPanel.XOffset = xpos
_existingPartPanel.YOffset = ypos
_existingPartPanel.event move(_existingPartPanel.x, _existingPartPanel.y)

_newPartPanel.XOffset = xpos
_newPartPanel.YOffset = ypos
_newPartPanel.event move(_newPartPanel.x, _newPartPanel.y)

_newBOMPanel.XOffset = xpos
_newBOMPanel.YOffset = ypos
_newBOMPanel.event move(_newBOMPanel.x, _newBOMPanel.y)

end event

event shown();
_existingPartPanel.trigger event Shown()
_newPartPanel.trigger event Shown()
_newBOMPanel.trigger event Shown()

end event

on u_tabpg_newbom.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this._existingpartpanel=create _existingpartpanel
this._newbompanel=create _newbompanel
this.rb_newpart=create rb_newpart
this.rb_existingpart=create rb_existingpart
this.gb_1=create gb_1
this._newpartpanel=create _newpartpanel
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this._existingpartpanel
this.Control[iCurrent+4]=this._newbompanel
this.Control[iCurrent+5]=this.rb_newpart
this.Control[iCurrent+6]=this.rb_existingpart
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this._newpartpanel
this.Control[iCurrent+9]=this.gb_2
end on

on u_tabpg_newbom.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this._existingpartpanel)
destroy(this._newbompanel)
destroy(this.rb_newpart)
destroy(this.rb_existingpart)
destroy(this.gb_1)
destroy(this._newpartpanel)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_1.X + _newbompanel.X + _newbompanel.Width, _newbompanel.Y + _newbompanel.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(_existingPartPanel, 0, 0, 100, 100)
inv_Resize.of_Register(st_1, 0, 100, 100, 0)
inv_Resize.of_Register(gb_2, 0, 100, 100, 0)
inv_Resize.of_Register(_newPartPanel, 0, 100, 100, 0)
inv_Resize.of_Register(st_2, 100, 0, 0, 100)
inv_Resize.of_Register(_newBOMPanel, 100, 0, 0, 100)

st_1.post of_Register(gb_1, st_1.ABOVE)
st_1.post of_Register(_existingPartPanel, st_1.ABOVE)
st_1.post of_Register(gb_2, st_1.BELOW)
st_1.post of_Register(_newPartPanel, st_1.BELOW)

st_2.post of_Register(gb_1, st_2.LEFT)
st_2.post of_Register(_existingPartPanel, st_2.LEFT)
st_2.post of_Register(st_1, st_2.LEFT)
st_2.post of_Register(gb_2, st_2.LEFT)
st_2.post of_Register(_newPartPanel, st_2.LEFT)
st_2.post of_Register(_newBOMPanel, st_2.RIGHT)

end event

type st_2 from u_st_splitbar within u_tabpg_newbom
integer x = 2427
integer y = 32
integer width = 18
integer height = 2216
end type

event lbuttonup;call super::lbuttonup;
_existingPartPanel.trigger event Shown()
_newPartPanel.trigger event Shown()
_newBOMPanel.trigger event Shown()

end event

event mousemove;call super::mousemove;
if	not KeyDown(keyLeftButton!) then
	return
end if

BringToTop = true
parent.BringToTop = true
BringToTop = true

end event

type st_1 from u_st_splitbar within u_tabpg_newbom
integer x = 27
integer y = 820
integer width = 2402
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
_existingPartPanel.trigger event Shown()
_newPartPanel.trigger event Shown()
_newBOMPanel.trigger event Shown()

end event

type _existingpartpanel from u_panel within u_tabpg_newbom
string tag = "ExistingPartPanel"
integer x = 32
integer y = 76
integer width = 2386
integer height = 732
integer taborder = 50
end type

on _existingpartpanel.destroy
call u_panel::destroy
end on

type _newbompanel from u_panel within u_tabpg_newbom
string tag = "NewBOMPanel"
integer x = 2452
integer y = 32
integer width = 1431
integer height = 2216
integer taborder = 50
end type

on _newbompanel.destroy
call u_panel::destroy
end on

type rb_newpart from radiobutton within u_tabpg_newbom
integer x = 73
integer y = 832
integer width = 352
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "New Part"
end type

type rb_existingpart from radiobutton within u_tabpg_newbom
integer x = 73
integer width = 640
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Choose Existing Part"
end type

type gb_1 from groupbox within u_tabpg_newbom
integer x = 27
integer width = 2402
integer height = 816
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

type _newpartpanel from u_panel within u_tabpg_newbom
string tag = "NewPartPanel"
integer x = 32
integer y = 916
integer width = 2386
integer height = 1328
integer taborder = 40
end type

on _newpartpanel.destroy
call u_panel::destroy
end on

type gb_2 from groupbox within u_tabpg_newbom
event move pbm_move
integer x = 27
integer y = 832
integer width = 2402
integer height = 1420
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

event move;
rb_newpart.Move(rb_newpart.X, ypos)

end event

