$PBExportHeader$u_fxdw_custsrv_shiptoedit.sru
forward
global type u_fxdw_custsrv_shiptoedit from u_fxdw
end type
end forward

global type u_fxdw_custsrv_shiptoedit from u_fxdw
integer width = 1783
integer height = 1044
string dataobject = "d_customerservice_shiptoedit"
end type
global u_fxdw_custsrv_shiptoedit u_fxdw_custsrv_shiptoedit

type variables

n_cst_custsrv_custmaint_controller Controller

string ShipToCode
n_ds _dsShipToEdit

end variables

on u_fxdw_custsrv_shiptoedit.create
call super::create
end on

on u_fxdw_custsrv_shiptoedit.destroy
call super::destroy
end on

event resize;call super::resize;
//	Change the display based on the width:
choose case PixelsToUnits(newwidth, XPixelsToUnits!)
	case is < 3159
		if	DataObject <> "d_customerservice_shiptoedit" then
			DataObject = "d_customerservice_shiptoedit"
			_dsShipToEdit.ShareData(this)
		end if
	case is < 4617
		if	DataObject <> "d_customerservice_shiptoeditx2" then
			DataObject = "d_customerservice_shiptoeditx2"
			_dsShipToEdit.ShareData(this)
		end if
	case else
		if	DataObject <> "d_customerservice_shiptoeditx3" then
			DataObject = "d_customerservice_shiptoeditx3"
			_dsShipToEdit.ShareData(this)
		end if
end choose

end event

event constructor;call super::constructor;
_dsShipToEdit = create n_ds
_dsShipToEdit.DataObject = "d_customerservice_shiptoedit"
_dsShipToEdit.SetTransObject(SQLCA)
_dsShipToEdit.ShareData(this)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)
of_SetUpdateable(true)

//	User-defined drop-downs:
datawindowchild dwc
int i
for	i = 1 to 10
	if	GetChild("custom" + string(i), dwc) = success then
		dwc.SetTransObject(SQLCA)
		if	dwc.Retrieve("DEST", i) <= 0 then
			dwc.InsertRow(0)
		end if
	end if
next

of_SetDropDownNotes(true)
iuo_Notes.of_Register("shippernote", iuo_Notes.DDLB)
iuo_Notes.of_Register("billofladingnote", iuo_Notes.DDLB)

end event

event destructor;call super::destructor;
destroy _dsShipToEdit

end event

event pfc_retrieve;call super::pfc_retrieve;
return _dsShipToEdit.Retrieve(ShipToCode)

end event

event updateend;call super::updateend;
sqlca.post of_Commit()

end event

event clicked;call super::clicked;
choose case lower(dwo.name)
	case "b_shippernote"
		SetColumn("shippernote")
		event pfc_ddnotes()
	case "b_billofladingnote"
		SetColumn("billofladingnote")
		event pfc_ddnotes()
end choose

end event

