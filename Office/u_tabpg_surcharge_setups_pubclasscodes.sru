HA$PBExportHeader$u_tabpg_surcharge_setups_pubclasscodes.sru
forward
global type u_tabpg_surcharge_setups_pubclasscodes from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubclasscodes
end type
type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubclasscodes
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubclasscodes
end type
end forward

global type u_tabpg_surcharge_setups_pubclasscodes from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
dw_quickgridmenu dw_quickgridmenu
end type
global u_tabpg_surcharge_setups_pubclasscodes u_tabpg_surcharge_setups_pubclasscodes

type variables

Private:
//	Controller reference.
n_surcharge_setups_controller _myController

//	Model data.
string _publisherList

end variables
forward prototypes
public function integer setpublisherlist (string publisherlist)
public function integer savechanges ()
end prototypes

public function integer setpublisherlist (string publisherlist);
_publisherList = publisherList
return Refresh()

end function

public function integer savechanges ();
dw_1.AcceptText()

long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	choose case dw_1.GetItemStatus(row, 0, Primary!)
		case DataModified!
			int isPublished
			isPublished = dw_1.object.IsPublished[row]
			string classCode, unit
			classCode = dw_1.object.ClassCode[row]
			unit = dw_1.object.Units[row]
			if	isPublished = 2 then
				_myController.ActivatePublisherClassCode(_publisherList, classCode, unit)
			end if
			if	isPublished = 0 then
				_myController.DeactivatePublisherClassCode(_publisherList, classCode)
			end if
	end choose
next

return Refresh()

end function

on u_tabpg_surcharge_setups_pubclasscodes.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_quickgridmenu=create dw_quickgridmenu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_quickgridmenu
end on

on u_tabpg_surcharge_setups_pubclasscodes.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_quickgridmenu)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
//inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(dw_quickgridmenu, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_setups_pubclasscodes
string text = "Publisher Classification Codes"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_setups_pubclasscodes
string dataobject = "d_surcharge_publisherclasscodes"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_publisherList)

end event

event dw_1::clicked;call super::clicked;
if	row <= 0 then return NO_ACTION

choose case dwo.Name
	case lower("IsPublished")
		int isPublished
		isPublished = object.IsPublished[row]
		string nullString
		SetNull(nullString)
		if	isPublished < 2 then
			object.IsPublished[row] = 2
			object.Units[row] = nullString
		else
			object.IsPublished[row] = 0
			object.Units[row] = nullString
		end if
end choose

end event

event dw_1::itemchanged;call super::itemchanged;
if	row <= 0 then return NO_ACTION

choose case dwo.Name
	case "units"
		object.IsPublished[row] = 2
end choose

end event

type cb_1 from commandbutton within u_tabpg_surcharge_setups_pubclasscodes
boolean visible = false
integer x = 1806
integer y = 8
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
string text = "func1"
end type

type cb_2 from commandbutton within u_tabpg_surcharge_setups_pubclasscodes
boolean visible = false
integer x = 1806
integer y = 136
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "func2"
end type

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_setups_pubclasscodes
integer x = 1563
integer width = 187
integer height = 68
integer taborder = 11
boolean bringtotop = true
integer deleterowenabled = 0
integer insertrowenabled = 0
end type

event saveclicked;call super::saveclicked;
SaveChanges()

end event

event cancelclicked;call super::cancelclicked;
parent.Refresh()

end event

