$PBExportHeader$u_tabpg_inventoryinquiry.sru
forward
global type u_tabpg_inventoryinquiry from u_tabpg_dw
end type
type cb_open from commandbutton within u_tabpg_inventoryinquiry
end type
type cb_new from commandbutton within u_tabpg_inventoryinquiry
end type
type cb_delete from commandbutton within u_tabpg_inventoryinquiry
end type
type cb_label from commandbutton within u_tabpg_inventoryinquiry
end type
end forward

global type u_tabpg_inventoryinquiry from u_tabpg_dw
integer width = 2523
string text = "Inventory"
event retrievestart pbm_constructor
event retrieveend pbm_constructor
event retrievecancel pbm_constructor
cb_open cb_open
cb_new cb_new
cb_delete cb_delete
cb_label cb_label
end type
global u_tabpg_inventoryinquiry u_tabpg_inventoryinquiry

type variables

private boolean filterFirstRetrieval = true
private boolean cancelRetrieval = false
private datastore inventoryDS

protected string inquiryFilterScreen
protected string primaryColumn
end variables

forward prototypes
public function integer openlocation ()
end prototypes

event retrievecancel;
dw_1.event pfc_cancelretrieval()

end event

public function integer openlocation ();
if	dw_1.GetRow() <= 0 then
	return NO_ACTION
end if

string selectedLocation
selectedLocation = dw_1.object.code[dw_1.GetRow()]
OpenSheetWithParm(w_location_form, selectedLocation, gnv_App.of_GetFrame(), 3, Original!)

return SUCCESS

end function

on u_tabpg_inventoryinquiry.create
int iCurrent
call super::create
this.cb_open=create cb_open
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.cb_label=create cb_label
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_open
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_label
end on

on u_tabpg_inventoryinquiry.destroy
call super::destroy
destroy(this.cb_open)
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.cb_label)
end on

event constructor;call super::constructor;
string showAll

select
	ifs.PrimaryColumn
,	ifs.ShowAll
into
	:primaryColumn
,	:showAll
from
	dbo.InquiryFilterScreens ifs
where
	ifs.InquiryFilterScreen = :inquiryFilterScreen  ;

if	showAll = 'Y' then
	filterFirstRetrieval = false
else
	filterFirstRetrieval = true
end if

inv_Resize.of_SetOrigSize(cb_open.X + (cb_open.X - gb_1.X - gb_1.Width) + cb_open.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_open, 100, 0, 0, 0)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)
inv_Resize.of_Register(cb_label, 100, 0, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventoryinquiry
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventoryinquiry
event type integer pfc_searchgrid ( )
event pfc_cancelretrieval ( )
string dataobject = "d_dbo_object-all"
end type

event type integer dw_1::pfc_searchgrid();//
//if	object.DataWindow.QueryMode = "no" then
//	SetRedraw(false)
//	object.DataWindow.QueryMode = "yes"
//	
//	//	Tab enable all columns.
//	
//	SetRedraw(true)
//else
//	AcceptText()
//	object.DataWindow.QueryMode = "no"
//	event pfc_Retrieve()
//end if
return inv_QueryMode.of_SetEnabled(not inv_QueryMode.of_GetEnabled())

return SUCCESS

end event

event dw_1::pfc_cancelretrieval();
cancelRetrieval = true

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetUpdateable(false)
of_SetQueryMode(true)
inv_QueryMode.of_SetResetCriteria(false)
inv_QueryMode.SetQueryCols()

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
if	filterFirstRetrieval then
	filterFirstRetrieval = false
	return event pfc_searchgrid()
end if
return Retrieve()

end event

event dw_1::selectionchanged;call super::selectionchanged;//
//long IsSelected[]
//
//IsSelected = dw_1.object.IsSelected.primary
//
//int i, selectCount = 0
//for	i = 1 to UpperBound(IsSelected)
//	if	IsSelected[i] = 1 then
//		selectCount++
//	end if
//	if	selectCount > 1 then
//		exit
//	end if
//next
//
//cb_open.enabled = (selectCount = 1)
//
end event

event dw_1::retrievestart;call super::retrievestart;SetRedraw(false)
parent.event retrievestart()
cancelRetrieval = false

end event

event dw_1::retrieveend;call super::retrieveend;
parent.event retrieveend()
post SetRedraw(true)
gb_1.SetRedraw(false)
gb_1.Text = "Records (" + string(rowcount) + ")"
gb_1.SetRedraw(true)

end event

event dw_1::retrieverow;call super::retrieverow;
if	cancelRetrieval then
	return 1
end if
if	mod(row, 100) = 0 then
	gb_1.SetRedraw(false)
	gb_1.Text = "Records (" + string(row) + ")"
	gb_1.SetRedraw(true)
end if

end event

type cb_open from commandbutton within u_tabpg_inventoryinquiry
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

event clicked;if	dw_1.dataobject = "d_dbo_object-all" then
	dw_1.dataobject = "d_dbo_objects-simple"
else
	dw_1.dataobject = "d_dbo_object-all"
end if
dw_1.of_SetTransObject(SQLCA)
dw_1.post event pfc_retrieve()

end event

type cb_new from commandbutton within u_tabpg_inventoryinquiry
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
dw_1.Reset()
if	IsValid(inventoryDS) then
	destroy inventoryDS
end if
inventoryDS = create datastore
inventoryDS.dataobject = dw_1.dataobject
inventoryDS.SetTransObject(SQLCA)
inventoryDS.Retrieve()
//inventoryDS.ShareData(dw_1)

end event

type cb_delete from commandbutton within u_tabpg_inventoryinquiry
integer x = 1806
integer y = 268
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

type cb_label from commandbutton within u_tabpg_inventoryinquiry
integer x = 1806
integer y = 400
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
		string locationCode
		locationCode = dw_1.object.Code[i]
		
		long label
		character cESC = "~h1B"
		
		//  Start Printing
		label = PrintOpen ( )
		PrintSend (label, cEsc + "A" + cEsc + "R")
		PrintSend (label, cEsc + "AR")
		
		PrintSend (label, cEsc + "V100" + cEsc + "H400" + cEsc + "B103295" + "*" + "L" + locationCode + "*")
		PrintSend (label, cEsc + "V500" + cEsc + "H400" + cEsc + "$A,300,300,0" + cEsc + "$=" + locationCode)
		
		PrintSend (label, cEsc + "Z")
		PrintClose (label)
	end if
next

end event

