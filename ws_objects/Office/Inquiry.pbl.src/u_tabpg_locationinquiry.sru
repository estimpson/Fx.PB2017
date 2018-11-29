$PBExportHeader$u_tabpg_locationinquiry.sru
forward
global type u_tabpg_locationinquiry from u_tabpg_dw
end type
type cb_open from commandbutton within u_tabpg_locationinquiry
end type
type cb_new from commandbutton within u_tabpg_locationinquiry
end type
type cb_delete from commandbutton within u_tabpg_locationinquiry
end type
type cb_label from commandbutton within u_tabpg_locationinquiry
end type
type dw_labelformat from u_fxdw within u_tabpg_locationinquiry
end type
end forward

global type u_tabpg_locationinquiry from u_tabpg_dw
integer width = 2510
string text = "Locations"
cb_open cb_open
cb_new cb_new
cb_delete cb_delete
cb_label cb_label
dw_labelformat dw_labelformat
end type
global u_tabpg_locationinquiry u_tabpg_locationinquiry

forward prototypes
public function integer openlocation ()
end prototypes

public function integer openlocation ();
if	dw_1.GetRow() <= 0 then
	return NO_ACTION
end if

string selectedLocation
selectedLocation = dw_1.object.code[dw_1.GetRow()]
OpenSheetWithParm(w_location_form, selectedLocation, gnv_App.of_GetFrame(), 3, Original!)

return SUCCESS

end function

on u_tabpg_locationinquiry.create
int iCurrent
call super::create
this.cb_open=create cb_open
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.cb_label=create cb_label
this.dw_labelformat=create dw_labelformat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_open
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_label
this.Control[iCurrent+5]=this.dw_labelformat
end on

on u_tabpg_locationinquiry.destroy
call super::destroy
destroy(this.cb_open)
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.cb_label)
destroy(this.dw_labelformat)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_open.X + (cb_open.X - gb_1.X - gb_1.Width) + cb_open.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_open, 100, 0, 0, 0)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)
inv_Resize.of_Register(dw_labelformat, 100, 0, 0, 0)
inv_Resize.of_Register(cb_label, 100, 0, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_locationinquiry
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_locationinquiry
string dataobject = "d_dbo_location-all"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::selectionchanged;call super::selectionchanged;
long IsSelected[]

IsSelected = dw_1.object.IsSelected.primary

int i, selectCount = 0
for	i = 1 to UpperBound(IsSelected)
	if	IsSelected[i] = 1 then
		selectCount++
	end if
	if	selectCount > 1 then
		exit
	end if
next

cb_open.enabled = (selectCount = 1)

end event

event dw_1::doubleclicked;call super::doubleclicked;
if	row > 0 then
	OpenLocation()
else
	Object.DataWindow.Selected = ""
end if

end event

type cb_open from commandbutton within u_tabpg_locationinquiry
integer x = 1806
integer y = 8
integer width = 462
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Open location..."
boolean default = true
end type

event clicked;
OpenLocation()

end event

type cb_new from commandbutton within u_tabpg_locationinquiry
integer x = 1806
integer y = 136
integer width = 462
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New locaiton..."
end type

event clicked;
dw_1.SetRow(dw_1.InsertRow(0))
OpenLocation()


end event

type cb_delete from commandbutton within u_tabpg_locationinquiry
integer x = 1806
integer y = 264
integer width = 462
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete locaiton(s)..."
end type

event clicked;
// Refactor...
long dwRow
dwRow = dw_1.GetRow()
if	dwRow < 1 then return
if	not dw_1.object.IsSelected[dwRow] = 1 then return

string locationCode, locationType
locationCode = dw_1.object.code[dwRow]
locationType = dw_1.object.type[dwRow]

long objectCount
select
	count(*)
into
	:objectCount
from
	dbo.object o
where
	o.location = :locationCode   ;
	
if	objectCount > 0 then
	MessageBox("Error", "You can not delete locations that have objects in them!", StopSign!)
	return
end if

if MessageBox( "Delete", "Are you sure you want to delete " + locationCode + "?", Question!, OkCancel!, 2) = 1 then
	
	gnv_App.of_GetFrame().SetMicroHelp( "Deleting Records...")
	
	if	locationType = 'MC' then

		delete
			m
		from
			dbo.machine m
		where
			m.machine_no = :locationCode   ;

		if	SQLCA.SQLCode = -1 then
			rollback ;
			MessageBox("Error", SQLCA.SQLErrText, StopSign!)
			return
		end if

		delete
			mp
		from
			dbo.machine_policy mp
		where
			mp.machine = :locationCode   ;

		if	SQLCA.SQLCode = -1 then
			rollback ;
			MessageBox("Error", SQLCA.SQLErrText, StopSign!)
			return
		end if
			
		delete
			mp
		from
			dbo.machine_process mp
		where
			mp.machine = :locationCode   ;

		if	SQLCA.SQLCode = -1 then
			rollback ;
			MessageBox("Error", SQLCA.SQLErrText, StopSign!)
			return
		end if

	end if
	
	delete
		l
	from
		dbo.location l
	where
		l.code = :locationCode  ;

	if	SQLCA.SQLCode = -1 then
		rollback ;
		MessageBox("Error", SQLCA.SQLErrText, StopSign!)
		return
	end if
	commit  ;

	gnv_App.of_GetFrame().SetMicroHelp( "Delete Successful!")
end if

Refreshing = true
Refresh()

end event

type cb_label from commandbutton within u_tabpg_locationinquiry
integer x = 1806
integer y = 392
integer width = 462
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Label"
end type

event clicked;
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	locationID
		locationID = dw_1.Object.RowID[i]
		
		string	labelFormat
		dw_labelformat.AcceptText()
		labelFormat = dw_labelformat.Object.LocationLabelFormat[1]
		
		n_cst_associative_array	printerParm
		
		printerParm.of_SetItem ( "Arg1", locationID)
		printerParm.of_SetItem ( "Report", "Location Label" )
		printerParm.of_SetItem ( "Name", labelFormat )
		Print(printerParm)

	end if
next

end event

type dw_labelformat from u_fxdw within u_tabpg_locationinquiry
integer x = 1806
integer y = 520
integer width = 462
integer height = 180
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_chooselocationlabelformat"
boolean vscrollbar = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetUpdateable(false)
Refresh()

end event

event pfc_retrieve;call super::pfc_retrieve;
Return Retrieve()

end event

