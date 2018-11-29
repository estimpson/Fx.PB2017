$PBExportHeader$u_fxdw_custsrv_normalorderedit.sru
forward
global type u_fxdw_custsrv_normalorderedit from u_fxdw
end type
end forward

global type u_fxdw_custsrv_normalorderedit from u_fxdw
integer width = 1783
integer height = 1044
string dataobject = "d_customerservice_normalorderedit"
end type
global u_fxdw_custsrv_normalorderedit u_fxdw_custsrv_normalorderedit

type variables

long	OrderNumber
n_ds _dsNormalOrderEdit

end variables

on u_fxdw_custsrv_normalorderedit.create
call super::create
end on

on u_fxdw_custsrv_normalorderedit.destroy
call super::destroy
end on

event resize;call super::resize;
//	Change the display based on the width:
choose case PixelsToUnits(newwidth, XPixelsToUnits!)
	case is < 3159
		if	DataObject <> "d_customerservice_normalorderedit" then
			DataObject = "d_customerservice_normalorderedit"
			_dsNormalOrderEdit.ShareData(this)
		end if
	case is < 4617
		if	DataObject <> "d_customerservice_normalordereditx2" then
			DataObject = "d_customerservice_normalordereditx2"
			_dsNormalOrderEdit.ShareData(this)
		end if
	case else
		if	DataObject <> "d_customerservice_normalordereditx3" then
			DataObject = "d_customerservice_normalordereditx3"
			_dsNormalOrderEdit.ShareData(this)
		end if
end choose

end event

event constructor;call super::constructor;
_dsNormalOrderEdit = create n_ds
_dsNormalOrderEdit.DataObject = "d_customerservice_normalorderedit"
_dsNormalOrderEdit.SetTransObject(SQLCA)
_dsNormalOrderEdit.ShareData(this)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)
of_SetUpdateable(true)

//	User-defined drop-downs:
datawindowchild dwc
int i
for	i = 1 to 5	
	if	GetChild("custom" + string(i), dwc) = success then
		dwc.SetTransObject(SQLCA)
		if	dwc.Retrieve("NO", i) <= 0 then
			dwc.InsertRow(0)
		end if
	end if
next

end event

event destructor;call super::destructor;
destroy _dsNormalOrderEdit

end event

event pfc_retrieve;call super::pfc_retrieve;
long rows
rows =_dsNormalOrderEdit.Retrieve(OrderNumber)

//	Build some custom ToolTips.
if	rows >= 1 then
	object.billtocode.Tag = isnull(object.billingaddressname[1], "") + "~r~n" + isnull(object.billingaddress1[1], "") + "~r~n" + isnull(object.billingaddress2[1], "") + "~r~n" + isnull(object.billingaddress3[1], "") + "~r~n" + isnull(object.billingaddress4[1], "") + "~r~n" + isnull(object.billingaddress5[1], "") + "~r~n" + isnull(object.billingaddress6[1], "")
end if
return rows

end event

