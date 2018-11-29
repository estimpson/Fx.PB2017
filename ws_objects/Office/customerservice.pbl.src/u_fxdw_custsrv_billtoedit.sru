$PBExportHeader$u_fxdw_custsrv_billtoedit.sru
forward
global type u_fxdw_custsrv_billtoedit from u_fxdw
end type
end forward

global type u_fxdw_custsrv_billtoedit from u_fxdw
integer width = 1783
integer height = 1044
string dataobject = "d_customerservice_billtoedit"
end type
global u_fxdw_custsrv_billtoedit u_fxdw_custsrv_billtoedit

type variables

n_cst_custsrv_custmaint_controller Controller

string BillToCode
n_ds _dsBillToEdit

end variables

on u_fxdw_custsrv_billtoedit.create
call super::create
end on

on u_fxdw_custsrv_billtoedit.destroy
call super::destroy
end on

event resize;call super::resize;
//	Change the display based on the width:
choose case PixelsToUnits(newwidth, XPixelsToUnits!)
	case is < 3159
		if	DataObject <> "d_customerservice_billtoedit" then
			DataObject = "d_customerservice_billtoedit"
			event DataObjectChanged()
		end if
	case is < 4617
		if	DataObject <> "d_customerservice_billtoeditx2" then
			DataObject = "d_customerservice_billtoeditx2"
			event DataObjectChanged()
		end if
	case else
		if	DataObject <> "d_customerservice_billtoeditx3" then
			DataObject = "d_customerservice_billtoeditx3"
			event DataObjectChanged()
		end if
end choose

end event

event constructor;call super::constructor;
_dsBillToEdit = create n_ds
_dsBillToEdit.DataObject = "d_customerservice_billtoedit"
_dsBillToEdit.SetTransObject(SQLCA)
_dsBillToEdit.ShareData(this)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)
of_SetUpdateable(true)

//	User-defined drop-downs:
datawindowchild dwc
int i
for	i = 1 to 5	
	if	GetChild("custom" + string(i), dwc) = success then
		dwc.SetTransObject(SQLCA)
		if	dwc.Retrieve("DEST", i) <= 0 then
			dwc.InsertRow(0)
		end if
	end if
next

of_SetDropDownNotes(true)
iuo_Notes.of_Register("phonenumber", iuo_Notes.DDLB_WITHARROW)

end event

event destructor;call super::destructor;
destroy _dsBillToEdit

end event

event pfc_retrieve;call super::pfc_retrieve;
return _dsBillToEdit.Retrieve(BillToCode)

end event

event dataobjectchanged;call super::dataobjectchanged;
//	Reshare the data with the edit control.
_dsBillToEdit.ShareData(this)

//	Recalibrate custom dropdowns.
//	Custom drop-downs:
SetCustomDropDown(false)
SetCustomDropDown(true)
int	registrationReturn
registrationReturn = CustomDropDown.Register("u_addressdropdown", CustomDropDown.COLTYPE_STRING, "CustomerContactName", CustomDropDown.DDSTYLE_DDLB, true)

end event

