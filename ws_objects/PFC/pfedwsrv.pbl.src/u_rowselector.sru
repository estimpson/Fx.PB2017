$PBExportHeader$u_rowselector.sru
forward
global type u_rowselector from u_base
end type
type dw_currentrow from u_dw within u_rowselector
end type
type cb_last from commandbutton within u_rowselector
end type
type cb_next from commandbutton within u_rowselector
end type
type cb_go from commandbutton within u_rowselector
end type
type cb_prior from commandbutton within u_rowselector
end type
type cb_first from commandbutton within u_rowselector
end type
end forward

global type u_rowselector from u_base
integer width = 1125
integer height = 364
long backcolor = 1073741824
dw_currentrow dw_currentrow
cb_last cb_last
cb_next cb_next
cb_go cb_go
cb_prior cb_prior
cb_first cb_first
end type
global u_rowselector u_rowselector

type variables

datawindow RequestorDW
long CurrentRow

end variables

forward prototypes
public function integer setrequestor (ref datawindow _requestordw)
private function integer setrow (long _row)
public function integer currentrow (long _currentrow)
end prototypes

public function integer setrequestor (ref datawindow _requestordw);
if	IsValid(_requestorDW) then
	RequestorDW = _requestorDW
	return SUCCESS
end if

return FAILURE

end function

private function integer setrow (long _row);
if	not IsValid(RequestorDW) then
	return FAILURE
end if

if	_row > RequestorDW.RowCount() then
	_row = RequestorDW.RowCount()
end if

if	_row < 1 then
	_row = 1
end if

RequestorDW.SetRow(_row)
RequestorDW.ScrollToRow(_row)
CurrentRow(RequestorDW.GetRow())
return SUCCESS

end function

public function integer currentrow (long _currentrow);
if	not Isvalid(RequestorDW) then
	return FAILURE
end if

CurrentRow = _currentRow
dw_currentrow.object.currentRow[1] = CurrentRow
return SUCCESS

end function

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_last.X + cb_last.Width, cb_last.Y + cb_last.Height)
inv_Resize.of_Register(dw_currentrow, 0, 0, 100, 0)
inv_Resize.of_Register(cb_go, 100, 0, 0, 0)
inv_Resize.of_Register(cb_next, 100, 0, 0, 0)
inv_Resize.of_Register(cb_last, 100, 0, 0, 0)

dw_currentrow.of_SetResize(true)
dw_currentrow.inv_Resize.of_Register("currentrow", 0, 0, 100, 0)

end event

on u_rowselector.create
int iCurrent
call super::create
this.dw_currentrow=create dw_currentrow
this.cb_last=create cb_last
this.cb_next=create cb_next
this.cb_go=create cb_go
this.cb_prior=create cb_prior
this.cb_first=create cb_first
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_currentrow
this.Control[iCurrent+2]=this.cb_last
this.Control[iCurrent+3]=this.cb_next
this.Control[iCurrent+4]=this.cb_go
this.Control[iCurrent+5]=this.cb_prior
this.Control[iCurrent+6]=this.cb_first
end on

on u_rowselector.destroy
call super::destroy
destroy(this.dw_currentrow)
destroy(this.cb_last)
destroy(this.cb_next)
destroy(this.cb_go)
destroy(this.cb_prior)
destroy(this.cb_first)
end on

type dw_currentrow from u_dw within u_rowselector
integer x = 325
integer y = 12
integer width = 233
integer height = 96
integer taborder = 40
string dataobject = "d_currentrow"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event getfocus;call super::getfocus;
SelectText(1, 100)
cb_go.default = true

end event

event losefocus;call super::losefocus;
cb_go.default = false

end event

type cb_last from commandbutton within u_rowselector
integer x = 878
integer width = 160
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "> |"
end type

event clicked;
SetRow(RequestorDW.RowCount())

end event

type cb_next from commandbutton within u_rowselector
integer x = 718
integer width = 160
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = ">"
end type

event clicked;
SetRow(CurrentRow + 1)

end event

type cb_go from commandbutton within u_rowselector
integer x = 558
integer width = 160
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "go"
end type

event clicked;
dw_currentrow.AcceptText()
SetRow(dw_currentrow.object.currentRow[1])

end event

type cb_prior from commandbutton within u_rowselector
integer x = 160
integer width = 160
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<"
end type

event clicked;
SetRow(CurrentRow - 1)

end event

type cb_first from commandbutton within u_rowselector
integer width = 160
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "| <"
end type

event clicked;
SetRow(1)

end event

