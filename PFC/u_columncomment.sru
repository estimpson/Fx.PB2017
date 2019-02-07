HA$PBExportHeader$u_columncomment.sru
forward
global type u_columncomment from u_base
end type
type cb_1 from commandbutton within u_columncomment
end type
type mle_1 from multilineedit within u_columncomment
end type
type dw_comments from u_fxdw within u_columncomment
end type
type dw_buttons from u_dw within u_columncomment
end type
type p_resizer from picture within u_columncomment
end type
type r_2 from rectangle within u_columncomment
end type
type ln_1 from line within u_columncomment
end type
end forward

global type u_columncomment from u_base
integer width = 1285
integer height = 1440
cb_1 cb_1
mle_1 mle_1
dw_comments dw_comments
dw_buttons dw_buttons
p_resizer p_resizer
r_2 r_2
ln_1 ln_1
end type
global u_columncomment u_columncomment

type variables

private:

//	Contants.
constant integer MIN_WIDTH = 1079
constant integer MIN_HEIGHT = 1400
constant integer RESIZER_X_OFFSET = 0
constant integer RESIZER_Y_OFFSET = 0

//	Model data.
boolean _newComment = true
long _columnRowID
public privatewrite string DataRowGUID
public privatewrite string ColumnName

//	Controller reference.
n_cst_columncomments _parentController

//	Requestor references.
datawindow _requestor
window _requestorWindow

end variables

forward prototypes
public function integer setdatarowguidandcolumn (string drg, string colname)
public function integer doresize (integer pointerx, integer pointery)
public function integer showcomment (integer colid)
public function integer setrequestor (datawindow requestordw, window requestorwindow, n_cst_columncomments parentcontroller)
end prototypes

public function integer setdatarowguidandcolumn (string drg, string colname);
DataRowGuid = drg
ColumnName = colName

return dw_comments.Refresh()

end function

public function integer doresize (integer pointerx, integer pointery);
if	not IsValid(_requestorWindow) then
	return FAILURE
end if

_requestorWindow.SetRedraw(false)
SetRedraw(false)

p_resizer.SetPosition(ToTop!)

int maxWidth, maxHeight
maxWidth = _requestorWindow.WorkSpaceWidth()
maxHeight = _requestorWindow.WorkSpaceHeight()

int	minX, minY
minX = this.X + MIN_WIDTH
minY = this.Y + MIN_HEIGHT

int newWidth, newHeight
if	pointerX >= minX and pointerX <= maxWidth then
	newWidth = pointerX - this.X
elseif pointerX > maxWidth then
	newWidth = maxWidth - this.X
else
	newWidth = MIN_WIDTH
end if
if	pointerY >= minY and pointerY <= maxHeight then
	newHeight = pointerY - this.Y
elseif pointerY > maxHeight then
	newHeight = maxHeight - this.Y
else
	newHeight = MIN_HEIGHT
end if

if	newWidth <> this.Width or newHeight <> this.Height then
	this.Resize(newWidth, newHeight)
end if

return SUCCESS

end function

public function integer showcomment (integer colid);
int pointerX, pointerY
pointerX = _requestorWindow.PointerX()
pointerY = _requestorWindow.PointerY()

//	Loop getting the parent of the object until it is of type window!, accumulating x and y values along the way.
powerobject parentPO
parentPO = _requestor.GetParent()
integer dwOffsetX, dwOffsetY, windowWidth, windowHeight
dwOffsetX = _requestor.X
dwOffsetY = _requestor.Y
do while IsValid (parentPO) 
	if parentPO.TypeOf() <> window! then
		dragobject parentDO
		parentDO = parentPO
		dwOffsetX += parentDO.X
		dwOffsetY += parentDO.Y
		parentPO = parentPO.GetParent()
	else
		window parentWO
		parentWO = parentPO
		windowWidth = parentWO.Width
		windowHeight = parentWO.Height
		exit
	end if
loop

//	Adjust for datawindow zoom.
dec {1} zoomOffset
zoomOffset = long(_requestor.object.datawindow.zoom) / 100.0

//	Get the horizontal scroll position.
integer scrollOffsetX
scrollOffsetX = integer(_requestor.Object.DataWindow.HorizontalScrollPosition) * zoomOffset / _parentController._unitXFactor

//	Get the location of the column.
long columnX, columnWidth, columnHeight
columnX = long(_requestor.Describe("#" + String(colID) + ".x")) * zoomOffset / _parentController._unitXFactor
columnWidth = long(_requestor.Describe("#" + String(colID) + ".width")) * zoomOffset / _parentController._unitXFactor
columnHeight = long(_requestor.Describe("#" + String(colID) + ".height")) * zoomOffset / _parentController._unitXFactor

//	Get the location of the comment hotspot.
long hotspotX
integer hotspotWidth
hotspotX = long(_requestor.Describe("b_hotspot"+String(colID) + ".x")) * zoomOffset / _parentController._unitXFactor
hotspotWidth = integer(_requestor.Describe("b_hotspot"+String(colID) + ".width")) * zoomOffset / _parentController._unitXFactor

//	Final position for comments.
int commentsXR
commentsXR = hotSpotX - scrollOffsetX + hotSpotWidth + dwOffsetX + 200

int commentsXL
commentsXL = columnX - scrollOffsetX - Width + dwOffsetX - 200

int commentsYA
commentsYA = pointerY - Height - 200

int commentsYB
commentsYB = pointerY + columnHeight + 200

int	commentsX, commentsY
if	commentsXR + Width > windowWidth then
	if	commentsXL < 0 then
		commentsX = columnX + columnWidth / 2 - Width / 2
		if	commentsYA < 0 then
			commentsY = commentsYB
		else
			commentsY = commentsYA
		end if
	else
		commentsX = commentsXL
		if	pointerY + Height * .75 > windowHeight - 100 then
			commentsY = windowHeight - Height - 100
		elseif	pointerY - Height * .25 < 0 then
			commentsY = 0
		else
			commentsY = pointerY - Height * .25
		end if
	end if
else
	commentsX = commentsXR
	if	pointerY + Height * .75 > windowHeight - 100 then
		commentsY = windowHeight - Height - 100
	elseif	pointerY - Height * .25 < 0 then
		commentsY = 0
	else
		commentsY = pointerY - Height * .25
	end if
end if

move(commentsX, commentsY)

bringToTop = true
visible = true

return NO_ACTION

end function

public function integer setrequestor (datawindow requestordw, window requestorwindow, n_cst_columncomments parentcontroller);
//	Ensure references are valid.
if	not IsValid(requestorDW) or not IsValid(requestorWindow) or not IsValid(parentController) then return FAILURE

//	Store a pointer.
_requestor = requestorDW
_requestorWindow = requestorWindow
_parentController = parentController

return SUCCESS

end function

on u_columncomment.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.mle_1=create mle_1
this.dw_comments=create dw_comments
this.dw_buttons=create dw_buttons
this.p_resizer=create p_resizer
this.r_2=create r_2
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.dw_comments
this.Control[iCurrent+4]=this.dw_buttons
this.Control[iCurrent+5]=this.p_resizer
this.Control[iCurrent+6]=this.r_2
this.Control[iCurrent+7]=this.ln_1
end on

on u_columncomment.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.dw_comments)
destroy(this.dw_buttons)
destroy(this.p_resizer)
destroy(this.r_2)
destroy(this.ln_1)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(r_2.X + r_2.Width, r_2.Y + r_2.Height)
inv_Resize.of_Register(cb_1, 100, 100, 0, 0)
inv_Resize.of_Register(mle_1, 0, 100, 100, 0)
inv_Resize.of_Register(dw_comments, 0, 0, 100, 100)
inv_Resize.of_Register(dw_buttons, 0, 0, 100, 0)
inv_Resize.of_Register(p_resizer, 100, 100, 0, 0)
inv_Resize.of_Register(r_2, 0, 0, 100, 100)
inv_Resize.of_Register(ln_1, 0, 0, 0, 100)
post event Resize(0, width, height)
end event

type cb_1 from commandbutton within u_columncomment
integer x = 960
integer y = 1124
integer width = 78
integer height = 228
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "^"
boolean default = true
end type

event clicked;
if	_newComment then
	if	_parentController.NewComment(mle_1.Text) = SUCCESS then
		mle_1.Text = ""
		dw_comments.Refresh()
		return SUCCESS
	end if
	return FAILURE
end if
if	_parentController.EditComment(_columnRowID, mle_1.Text) = SUCCESS then
	mle_1.Text = ""
	dw_comments.Refresh()
	return SUCCESS
end if
return FAILURE

end event

type mle_1 from multilineedit within u_columncomment
integer x = 151
integer y = 1124
integer width = 800
integer height = 228
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
end type

type dw_comments from u_fxdw within u_columncomment
integer x = 151
integer y = 228
integer width = 887
integer height = 880
integer taborder = 20
string dataobject = "d_columncomments"
boolean border = true
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

this.of_SetResize(true)
this.inv_Resize.of_SetOrigSize(width, height)
this.inv_Resize.of_Register("comment", 0, 0, 100, 0)
this.inv_Resize.of_Register("line_1", 0, 0, 100, 0)
this.inv_Resize.of_Register("b_new", 100, 0, 0, 0)
this.inv_Resize.of_Register("b_delete", 100, 0, 0, 0)
this.inv_Resize.of_Register("b_edit", 100, 0, 0, 0)

end event

event pfc_retrieve;call super::pfc_retrieve;
long rowCount
rowCount = Retrieve(DataRowGUID, ColumnName)

//	If there are no rows, notify parent controller to remove hotspot.
if	rowCount = 1 then
	_parentController.ColumnHasNoComments()
end if

return rowCount


end event

event clicked;call super::clicked;
if	row <= 0 then return NO_ACTION

choose case upper(dwo.Name)
	case upper("b_edit")
		mle_1.Text = object.Comment[row]
		_columnRowID = object.RowID[row]
		_newComment = false
		return SUCCESS
	case upper("b_delete")
		if	msgBox("Are you sure you want to delete this column?", Question!, YesNo!, 2) = 1 then
			if	_parentController.DeleteComment(object.RowID[row]) = SUCCESS then
				dw_comments.Refresh()
				return SUCCESS
			end if
			return FAILURE
		end if
		return NO_ACTION
	case upper("b_new")
		mle_1.Text = ""
		SetNull(_columnRowID)
		_newComment = true
		return SUCCESS
end choose

return NO_ACTION

end event

type dw_buttons from u_dw within u_columncomment
event ue_mousemove pbm_dwnmousemove
event ue_dwnkey pbm_dwnkey
integer x = 5
integer y = 4
integer width = 1056
integer height = 180
integer taborder = 10
string title = "none"
string dataobject = "d_columncomments_ddbuttons"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event ue_mousemove;
if	KeyDown(KeyLeftArrow!) or KeyDown(KeyRightArrow!) or KeyDown(KeyUpArrow!) or KeyDown(KeyDownArrow!) or KeyDown(KeyTab!) then return NO_ACTION

Setrow(row)

end event

event clicked;
//	Valid row.
if	row <= 0 then return NO_ACTION

//	Valid action.
if	object.Active[row] <> 1 then
	return NO_ACTION
end if

choose case Upper(object.ButtonName[row])
	case Upper("Sort Ascending")
		dw_comments.SetSort("CommentCreateDT asc")
		dw_comments.Sort()
	case Upper("Sort Descending")
		dw_comments.SetSort("CommentCreateDT desc")
		dw_comments.Sort()
end choose

end event

event scrollhorizontal;
//	Force back to beginning of dw, don't allow horizontal scroll after resize.
object.DataWindow.HorizontalScrollPosition=1

end event

event constructor;call super::constructor;
this.of_SetResize(true)
this.inv_Resize.of_SetOrigSize(width, height)
this.inv_Resize.of_Register("rr_1", 0, 0, 100, 0)
this.inv_Resize.of_Register("l_1", 0, 0, 100, 0)
this.inv_Resize.of_Register("buttonname", 0, 0, 100, 0)
end event

type p_resizer from picture within u_columncomment
event ue_mousemove pbm_mousemove
event ue_checkfocus ( )
string tag = "//MULTILANG PowerTipText"
integer x = 1029
integer y = 1360
integer width = 32
integer height = 28
string pointer = "SizeNWSE!"
boolean originalsize = true
string picturename = "PF_resize_PF.bmp"
boolean focusrectangle = false
string powertiptext = "Click and drag to change size of dropdown"
end type

event ue_mousemove;
if	not KeyDown(keyLeftButton!) then
	return NO_ACTION
end if

// Get the new position.
int pointerX, pointerY

pointerX = _requestorWindow.PointerX()
pointerY = _requestorWindow.PointerY()	
parent.DoResize(pointerX,pointerY)

return SUCCESS

end event

event constructor;
//	Ensure on top.
SetPosition(ToTop!)


end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
//parent.EVENT POST ue_checkfocus()

end event

type r_2 from rectangle within u_columncomment
long linecolor = 134217744
integer linethickness = 12
long fillcolor = 1073741824
integer x = -9
integer width = 1083
integer height = 1400
end type

type ln_1 from line within u_columncomment
long linecolor = 134217744
integer linethickness = 4
integer beginx = 123
integer beginy = 184
integer endx = 123
integer endy = 1384
end type

