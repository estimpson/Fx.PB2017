$PBExportHeader$u_tabpg_quotelog_setup.sru
forward
global type u_tabpg_quotelog_setup from u_tabpg_dw
end type
type cb_newquote from commandbutton within u_tabpg_quotelog_setup
end type
type cb_newecn from commandbutton within u_tabpg_quotelog_setup
end type
type cb_newrevision from commandbutton within u_tabpg_quotelog_setup
end type
type cb_expandcollapse from statichyperlink within u_tabpg_quotelog_setup
end type
end forward

global type u_tabpg_quotelog_setup from u_tabpg_dw
integer width = 2427
cb_newquote cb_newquote
cb_newecn cb_newecn
cb_newrevision cb_newrevision
cb_expandcollapse cb_expandcollapse
end type
global u_tabpg_quotelog_setup u_tabpg_quotelog_setup

type variables

private:

n_quoting_controller _myController
long _collapseHeight, _restoreHeight
end variables

forward prototypes
public function integer showallhotspots (boolean flag)
public function integer showcolumncomment ()
public function integer setexpandedview ()
public function integer setcollapsedview ()
public function long getcollapseheight ()
end prototypes

public function integer showallhotspots (boolean flag);
if	not IsValid(dw_1.ColumnComments) then return FAILURE

return dw_1.ColumnComments.ShowAllHotspots(flag)

end function

public function integer showcolumncomment ();
if	not IsValid(dw_1.ColumnComments) then return FAILURE

return dw_1.ColumnComments.ShowComment()

end function

public function integer setexpandedview ();cb_newquote.Visible = true
cb_newecn.Visible = true
cb_newrevision.Visible = true
cb_expandcollapse.Text = "Collapse"
dw_1.VScrollBar = true
return SUCCESS

end function

public function integer setcollapsedview ();cb_newquote.Visible = false
cb_newecn.Visible = false
cb_newrevision.Visible = false
cb_expandcollapse.Text = "Expand"
dw_1.VScrollBar = false
dw_1.ScrollToRow(dw_1.GetRow())
return SUCCESS

end function

public function long getcollapseheight ();
return _collapseHeight

end function

on u_tabpg_quotelog_setup.create
int iCurrent
call super::create
this.cb_newquote=create cb_newquote
this.cb_newecn=create cb_newecn
this.cb_newrevision=create cb_newrevision
this.cb_expandcollapse=create cb_expandcollapse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_newquote
this.Control[iCurrent+2]=this.cb_newecn
this.Control[iCurrent+3]=this.cb_newrevision
this.Control[iCurrent+4]=this.cb_expandcollapse
end on

on u_tabpg_quotelog_setup.destroy
call super::destroy
destroy(this.cb_newquote)
destroy(this.cb_newecn)
destroy(this.cb_newrevision)
destroy(this.cb_expandcollapse)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_newquote.X + (cb_newquote.X - gb_1.X - gb_1.Width) + cb_newquote.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_newquote, 100, 0, 0, 0)
inv_Resize.of_Register(cb_newecn, 100, 0, 0, 0)
inv_Resize.of_Register(cb_newrevision, 100, 0, 0, 0)
inv_Resize.of_Register(cb_expandcollapse, 100, 100, 0, 0)

n_cst_user32 user32
dw_1.MeasureDW()
_collapseHeight = gb_1.Y + gb_1.Height - (dw_1.Height - dw_1.GetSingleRowHeight()) + PixelsToUnits(user32.GetSystemMetrics(user32.SM_CYHSCROLL), YPixelsToUnits!)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_quotelog_setup
string text = "Quote Log"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_quotelog_setup
string dataobject = "d_qt_quotelog_setup"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow < 1 or activerow > RowCount() or not IsValid(_myController) then
	return
end if

string quoteNumber
quoteNumber = object.QuoteNumber[activerow]
_myController.post SetQuoteNumber(quoteNumber)

end event

type cb_newquote from commandbutton within u_tabpg_quotelog_setup
integer x = 1810
integer y = 4
integer width = 471
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New Quote..."
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowNewQuoteHeader()

end event

type cb_newecn from commandbutton within u_tabpg_quotelog_setup
integer x = 1806
integer y = 144
integer width = 471
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New ECN..."
end type

event clicked;
if	not IsValid(_myController) then return
if	dw_1.RowCount () < 1 or dw_1.GetRow() > dw_1.RowCount() then return

_myController.ShowNewECNQuoteHeader(dw_1.object.QuoteHeaderRowID[dw_1.GetRow()])

end event

type cb_newrevision from commandbutton within u_tabpg_quotelog_setup
integer x = 1806
integer y = 284
integer width = 471
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New Rev..."
end type

event clicked;
if	not IsValid(_myController) then return
if	dw_1.RowCount () < 1 or dw_1.GetRow() > dw_1.RowCount() then return

_myController.ShowNewRevQuoteHeader(dw_1.object.QuoteHeaderRowID[dw_1.GetRow()])

end event

type cb_expandcollapse from statichyperlink within u_tabpg_quotelog_setup
integer x = 1806
integer y = 1016
integer width = 471
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
string text = "Collapse"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;
if	not IsValid(_myController) then return

choose case true
	case Text = "Expand"
		_myController.ExpandQuoteLog()
	case Text = "Collapse"
		_myController.CollapseQuoteLog()
end choose

end event

