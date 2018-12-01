$PBExportHeader$cu_tabpg_jobdetails.sru
forward
global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
end forward

global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
global cu_tabpg_jobdetails cu_tabpg_jobdetails

on cu_tabpg_jobdetails.create
call super::create
end on

on cu_tabpg_jobdetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_jobdetails`gb_1 within cu_tabpg_jobdetails
end type

type dw_1 from u_tabpg_jobdetails`dw_1 within cu_tabpg_jobdetails
end type

event dw_1::clicked;call super::clicked;
/*	If the clicked column is qty required, it is editable so set the tab. */
choose case lower(dwo.Name)
	case lower("QtyRequired")
		object.QtyRequired.TabSequence = 10
	case lower("MattecJobNumber")
		object.MattecJobNumber.TabSequence = 10
end choose

end event

event dw_1::itemchanged;call super::itemchanged;
/*	Handle quantity required changes for enterring Mattec quantity. */
if	row <= 0 then return

long WODID
boolean saveChange
n_cst_custom_mes_inventorytrans customMESInventoryTrans

choose case lower(dwo.Name)
	case lower("QtyRequired")
		saveChange = (MessageBox(gnv_App.iapp_Object.DisplayName, "You have changed the quantity required for this job to " + data + ".  Save changes?", Question!, OkCancel!, 2) = 1)
		if	saveChange then
			customMESInventoryTrans = create n_cst_custom_mes_inventorytrans
			
			WODID = object.WODID [row]
			decimal newQtyRequired
			newQtyRequired = dec(data)
			
			customMESInventoryTrans.SetJobQtyRequired(wodid, newQtyRequired)
			destroy customMESInventoryTrans
		end if
		object.QtyRequired.TabSequence = 0
		refresh()
	case lower("MattecJobNumber")
		saveChange = (MessageBox(gnv_App.iapp_Object.DisplayName, "You have changed the Mattec job number for this job to " + data + ".  Save changes?", Question!, OkCancel!, 2) = 1)
		if	saveChange then
			customMESInventoryTrans = create n_cst_custom_mes_inventorytrans
			
			WODID = object.WODID [row]
			string newJobNumber
			newJobNumber = data
			
			customMESInventoryTrans.SetJobMattecJobNumber(wodid, newJobNumber)
			destroy customMESInventoryTrans
		end if
		object.MattecJobNumber.TabSequence = 0
		refresh()
end choose

end event

type cb_generate from u_tabpg_jobdetails`cb_generate within cu_tabpg_jobdetails
end type

type cbx_print from u_tabpg_jobdetails`cbx_print within cu_tabpg_jobdetails
end type

type cb_manualjob from u_tabpg_jobdetails`cb_manualjob within cu_tabpg_jobdetails
end type

type cb_closejob from u_tabpg_jobdetails`cb_closejob within cu_tabpg_jobdetails
end type

