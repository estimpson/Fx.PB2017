HA$PBExportHeader$u_tabpg_mes_bfhistory_jobbom.sru
forward
global type u_tabpg_mes_bfhistory_jobbom from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_mes_bfhistory_jobbom
end type
type cb_2 from commandbutton within u_tabpg_mes_bfhistory_jobbom
end type
type rb_1 from radiobutton within u_tabpg_mes_bfhistory_jobbom
end type
type rb_2 from radiobutton within u_tabpg_mes_bfhistory_jobbom
end type
type cbx_1 from checkbox within u_tabpg_mes_bfhistory_jobbom
end type
end forward

global type u_tabpg_mes_bfhistory_jobbom from u_tabpg_dw
integer width = 2414
string text = "Job BOM"
cb_1 cb_1
cb_2 cb_2
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
end type
global u_tabpg_mes_bfhistory_jobbom u_tabpg_mes_bfhistory_jobbom

type variables

Private:

//	Controller reference.
n_mes_bfhistory_controller _myController

//	Model data.
datetime _recentDate
string _workOrderNumber
int _mode = 1

end variables

forward prototypes
public function integer setrecentdate (datetime recentdate)
public function integer setworkordernumber (string workordernumber)
public function integer setmode ()
public function integer settempwip ()
public function integer cleartempwip ()
end prototypes

public function integer setrecentdate (datetime recentdate);
_recentDate = recentDate
return Refresh()

end function

public function integer setworkordernumber (string workordernumber);
_workOrderNumber = workOrderNumber
return Refresh()

end function

public function integer setmode ();
if	rb_1.Checked then
	cbx_1.Enabled = true
	if	cbx_1.Checked then
		_mode = 1
	else
		_mode = 2
	end if
else
	cbx_1.Enabled = false
	_mode = 3
end if

return Refresh()

end function

public function integer settempwip ();
if	not IsValid(_myController) then return FAILURE

long row, rows
rows = dw_1.RowCount()

for	row = 1 to rows
	string childPart
	
	if	dw_1.Object.IsSelected[row] = 1 then
		if	dw_1.object.TempWIP[row] = 0 then
			childPart = dw_1.object.ChildPart[row]
			_myController.SetTempWIP(childPart)
		end if
	end if
next

return Refresh()

end function

public function integer cleartempwip ();
if	not IsValid(_myController) then return FAILURE

long row, rows
rows = dw_1.RowCount()

for	row = 1 to rows
	string childPart
	
	if	dw_1.Object.IsSelected[row] = 1 then
		if	dw_1.object.TempWIP[row] = 1 then
			childPart = dw_1.object.ChildPart[row]
			_myController.ClearTempWIP(childPart)
		end if
	end if
next

return Refresh()

end function

on u_tabpg_mes_bfhistory_jobbom.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.cbx_1
end on

on u_tabpg_mes_bfhistory_jobbom.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mes_bfhistory_jobbom
integer y = 164
integer height = 952
end type

event gb_1::constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mes_bfhistory_jobbom
integer y = 252
integer height = 856
string dataobject = "d_mes_bfhistory_partbom_forjob"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

return Retrieve(_workOrderNumber, _mode)

end event

type cb_1 from commandbutton within u_tabpg_mes_bfhistory_jobbom
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Temp WIP"
end type

event clicked;
if	MsgBox("Are you sure you want to mark all the selected WIP parts as Temporary WIP?  All jobs using selected components will have their BOMs reset!", Question!, YesNo!, 2) = 2 then
	return
end if

SetTempWIP()

end event

type cb_2 from commandbutton within u_tabpg_mes_bfhistory_jobbom
integer x = 1806
integer y = 136
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "WIP"
end type

event clicked;
if	MsgBox("Are you sure you want to mark all the selected WIP parts as WIP?  All jobs using selected components will have their BOMs reset!", Question!, YesNo!, 2) = 2 then
	return
end if

ClearTempWIP()

end event

type rb_1 from radiobutton within u_tabpg_mes_bfhistory_jobbom
integer x = 59
integer y = 8
integer width = 663
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Current Part Structure"
boolean checked = true
end type

event clicked;
post SetMode()

end event

type rb_2 from radiobutton within u_tabpg_mes_bfhistory_jobbom
integer x = 782
integer y = 8
integer width = 663
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Current Running BOM"
end type

event clicked;
post SetMode()

end event

type cbx_1 from checkbox within u_tabpg_mes_bfhistory_jobbom
integer x = 224
integer y = 80
integer width = 425
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Full structure"
boolean checked = true
end type

event clicked;
post SetMode()

end event

