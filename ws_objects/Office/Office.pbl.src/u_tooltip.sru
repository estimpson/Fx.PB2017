$PBExportHeader$u_tooltip.sru
forward
global type u_tooltip from u_base
end type
type st_1 from u_st within u_tooltip
end type
end forward

global type u_tooltip from u_base
boolean visible = false
integer width = 338
integer height = 88
boolean enabled = false
boolean border = true
long backcolor = 134217752
borderstyle borderstyle = styleshadowbox!
st_1 st_1
end type
global u_tooltip u_tooltip

type variables

window RequestorWindow
n_tmg_tooltip ToolTipTimer

end variables

on u_tooltip.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on u_tooltip.destroy
call super::destroy
destroy(this.st_1)
end on

event constructor;call super::constructor;
n_cst_associative_array toolTipParm
toolTipParm = message.PowerObjectParm
this.RequestorWindow = toolTipParm.of_GetItem("RequestorWindow")
st_1.text = toolTipParm.of_GetItem("ToolTipText")
st_1.FaceName = "MS Sans Serif"

this.width = st_1.Resize()
st_1.FaceName = "Tahoma"
st_1.TextSize = -10
ToolTipTimer = create n_tmg_tooltip
ToolTipTimer.ToolTip = this
ToolTipTimer.Start(.05)

end event

event destructor;call super::destructor;
ToolTipTimer.Stop()
destroy ToolTipTimer

end event

type st_1 from u_st within u_tooltip
integer height = 72
long textcolor = 134217751
long backcolor = 134217752
string text = ""
borderstyle borderstyle = StyleShadowBox!
end type

