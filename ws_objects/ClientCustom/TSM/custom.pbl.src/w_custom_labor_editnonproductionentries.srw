$PBExportHeader$w_custom_labor_editnonproductionentries.srw
forward
global type w_custom_labor_editnonproductionentries from w_sheet_4t
end type
type cb_cancel from commandbutton within w_custom_labor_editnonproductionentries
end type
type cb_save from commandbutton within w_custom_labor_editnonproductionentries
end type
type cb_retrieve from commandbutton within w_custom_labor_editnonproductionentries
end type
type dw_selectshift from u_fxdw within w_custom_labor_editnonproductionentries
end type
type dw_nonproductionentries from u_fxdw within w_custom_labor_editnonproductionentries
end type
type gb_1 from groupbox within w_custom_labor_editnonproductionentries
end type
type gb_2 from groupbox within w_custom_labor_editnonproductionentries
end type
end forward

global type w_custom_labor_editnonproductionentries from w_sheet_4t
integer width = 2491
string title = "Non-Production Time Entries"
cb_cancel cb_cancel
cb_save cb_save
cb_retrieve cb_retrieve
dw_selectshift dw_selectshift
dw_nonproductionentries dw_nonproductionentries
gb_1 gb_1
gb_2 gb_2
end type
global w_custom_labor_editnonproductionentries w_custom_labor_editnonproductionentries

on w_custom_labor_editnonproductionentries.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.cb_retrieve=create cb_retrieve
this.dw_selectshift=create dw_selectshift
this.dw_nonproductionentries=create dw_nonproductionentries
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.dw_selectshift
this.Control[iCurrent+5]=this.dw_nonproductionentries
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_custom_labor_editnonproductionentries.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.cb_retrieve)
destroy(this.dw_selectshift)
destroy(this.dw_nonproductionentries)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_save.X + cb_save.Width + (cb_save.X - (gb_2.x + gb_2.Width)), gb_2.Y + gb_2.Height)
inv_Resize.of_Register(dw_selectshift, 0, 0, 100, 0)
inv_Resize.of_Register(gb_1, 0, 0, 100, 0)
inv_Resize.of_Register(dw_nonproductionentries, 0, 0, 100, 100)
inv_Resize.of_Register(gb_2, 0, 0, 100, 100)
inv_Resize.of_Register(cb_retrieve, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)

end event

event pfc_refresh;call super::pfc_refresh;
//	Refresh non-production entries.
dw_nonproductionentries.of_Refresh(true)
dw_nonproductionentries.event pfc_retrieve()
end event

type cb_cancel from commandbutton within w_custom_labor_editnonproductionentries
integer x = 1966
integer y = 536
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

event clicked;
if	MessageBox(gnv_app.iapp_Object.displayName, "Changes will be lost.  Are you sure?", Question!, YesNo!, 2) = 1 then
	dw_nonproductionentries.event pfc_Retrieve()
end if


end event

type cb_save from commandbutton within w_custom_labor_editnonproductionentries
integer x = 1966
integer y = 404
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;
dw_nonproductionentries.AcceptText()
if	dw_nonproductionentries.Update() = 1 then
	dw_nonproductionentries.of_Refresh(true)
	dw_nonproductionentries.event pfc_Retrieve()
end if

end event

type cb_retrieve from commandbutton within w_custom_labor_editnonproductionentries
integer x = 1435
integer y = 60
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retrieve"
end type

event clicked;
dw_selectshift.AcceptText()
dw_nonproductionentries.event pfc_retrieve()

end event

type dw_selectshift from u_fxdw within w_custom_labor_editnonproductionentries
integer x = 87
integer y = 72
integer width = 1339
integer height = 224
integer taborder = 10
string dataobject = "d_custom_labor_selectshift"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;
object.Shift[1] = 1
object.ShiftDate[1] = Date(Today())

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

//	Turn off row selection service.
of_SetRowSelect(false)

end event

type dw_nonproductionentries from u_fxdw within w_custom_labor_editnonproductionentries
integer x = 27
integer y = 472
integer width = 1833
integer height = 860
integer taborder = 10
string dataobject = "d_custom_labor_getnonproductionentries"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Set row selection.
of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.SINGLE)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

//	Turn on drop down search.
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

//	Turn on the PowerFilter service.
SetPowerFilter (true)
PowerFilter.of_SetDW (this)
PowerFilter.post Show()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(dw_selectshift.object.Shift[1], DateTime(dw_selectshift.object.ShiftDate[1]))

end event

event updateend;call super::updateend;
commit using SQLCA  ;

end event

event dwlbuttonup;call super::dwlbuttonup;
PowerFilter.event post ue_buttonclicked(dwo.Type, dwo.Name)

end event

type gb_1 from groupbox within w_custom_labor_editnonproductionentries
integer x = 23
integer width = 1851
integer height = 344
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Select shift . . ."
end type

type gb_2 from groupbox within w_custom_labor_editnonproductionentries
integer x = 23
integer y = 364
integer width = 1847
integer height = 976
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Non-production entries . . ."
end type

