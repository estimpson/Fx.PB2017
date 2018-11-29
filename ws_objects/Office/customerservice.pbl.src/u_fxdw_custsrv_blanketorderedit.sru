$PBExportHeader$u_fxdw_custsrv_blanketorderedit.sru
forward
global type u_fxdw_custsrv_blanketorderedit from u_fxdw
end type
end forward

global type u_fxdw_custsrv_blanketorderedit from u_fxdw
integer width = 1783
integer height = 1044
string dataobject = "d_customerservice_blanketorderedit"
end type
global u_fxdw_custsrv_blanketorderedit u_fxdw_custsrv_blanketorderedit

type variables

long	OrderNumber
n_ds _dsBillToEdit

end variables

on u_fxdw_custsrv_blanketorderedit.create
call super::create
end on

on u_fxdw_custsrv_blanketorderedit.destroy
call super::destroy
end on

event resize;call super::resize;
//	Change the display based on the width:
choose case PixelsToUnits(newwidth, XPixelsToUnits!)
	case is < 3159
		if	DataObject <> "d_customerservice_blanketorderedit" then
			DataObject = "d_customerservice_blanketorderedit"
			_dsBillToEdit.ShareData(this)
		end if
	case is < 4617
		if	DataObject <> "d_customerservice_blanketordereditx2" then
			DataObject = "d_customerservice_blanketordereditx2"
			_dsBillToEdit.ShareData(this)
		end if
	case else
		if	DataObject <> "d_customerservice_blanketordereditx3" then
			DataObject = "d_customerservice_blanketordereditx3"
			_dsBillToEdit.ShareData(this)
		end if
end choose

end event

event constructor;call super::constructor;
_dsBillToEdit = create n_ds
_dsBillToEdit.DataObject = "d_customerservice_blanketorderedit"
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
		if	dwc.Retrieve("BO", i) <= 0 then
			dwc.InsertRow(0)
		end if
	end if
next

end event

event destructor;call super::destructor;
destroy _dsBillToEdit

end event

event pfc_retrieve;call super::pfc_retrieve;
long rows
rows =_dsBillToEdit.Retrieve(OrderNumber)

//	Build some custom ToolTips.
if	rows >= 1 then
	object.billtocode.Tag = isnull(object.billingaddressname[1], "") + "~r~n" + isnull(object.billingaddress1[1], "") + "~r~n" + isnull(object.billingaddress2[1], "") + "~r~n" + isnull(object.billingaddress3[1], "") + "~r~n" + isnull(object.billingaddress4[1], "") + "~r~n" + isnull(object.billingaddress5[1], "") + "~r~n" + isnull(object.billingaddress6[1], "")
end if
return rows

end event

