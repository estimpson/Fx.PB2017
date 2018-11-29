$PBExportHeader$u_fxdw_custsrv_entityedit.sru
forward
global type u_fxdw_custsrv_entityedit from u_fxdw
end type
end forward

global type u_fxdw_custsrv_entityedit from u_fxdw
integer width = 1783
integer height = 1044
end type
global u_fxdw_custsrv_entityedit u_fxdw_custsrv_entityedit

type variables

protected n_ds _dsEntityEdit
public string CustomColumnPrefix

end variables

on u_fxdw_custsrv_entityedit.create
call super::create
end on

on u_fxdw_custsrv_entityedit.destroy
call super::destroy
end on

event resize;call super::resize;
//	Change the display based on the width:
choose case PixelsToUnits(newwidth, XPixelsToUnits!)
	case is < 3159
		if	DataObject <> _dsEntityEdit.DataObject then
			DataObject = _dsEntityEdit.DataObject
			_dsEntityEdit.ShareData(this)
		end if
	case is < 4617
		if	DataObject <> _dsEntityEdit.DataObject + "x2" then
			DataObject = _dsEntityEdit.DataObject + "x2"
			_dsEntityEdit.ShareData(this)
		end if
	case else
		if	DataObject <> _dsEntityEdit.DataObject + "x3" then
			DataObject = _dsEntityEdit.DataObject + "x3"
			_dsEntityEdit.ShareData(this)
		end if
end choose

end event

event constructor;call super::constructor;
_dsEntityEdit = create n_ds
_dsEntityEdit.DataObject = DataObject
_dsEntityEdit.SetTransObject(SQLCA)
_dsEntityEdit.ShareData(this)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)
of_SetUpdateable(true)

//	User-defined drop-downs:
datawindowchild dwc
int i
for	i = 1 to 10
	if	GetChild("custom" + string(i), dwc) = success then
		dwc.SetTransObject(SQLCA)
		if	dwc.Retrieve(CustomColumnPrefix, i) <= 0 then
			dwc.InsertRow(0)
		end if
	end if
next

end event

event destructor;call super::destructor;
destroy _dsEntityEdit

end event

event pfc_retrieve;call super::pfc_retrieve;
//	Descendent:
//return _dsEntityEdit.Retrieve(arg)
return 0

end event

event updateend;call super::updateend;
sqlca.post of_Commit()

end event

