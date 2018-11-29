$PBExportHeader$n_cst_appmanager_office.sru
forward
global type n_cst_appmanager_office from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_office from n_cst_appmanager
string is_appkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
string is_userkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
end type
global n_cst_appmanager_office n_cst_appmanager_office

on n_cst_appmanager_office.create
call super::create
end on

on n_cst_appmanager_office.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Enable application preferences.
of_SetAppPreference(true)
inv_AppPref.of_SetRestoreApp(true)

end event

event pfc_presplash;call super::pfc_presplash;
//	Open frame.
open (w_frame_office)

end event

event pfc_commandline;call super::pfc_commandline;
string applicationProfile
if	argument.of_GetIndexOrKey("A") > 0 then
	applicationProfile = IsNull(argument.of_GetItem("A"), "")
	gnv_app.inv_Global.of_SetItem("ApplicationProfile", applicationProfile)
end if

return SUCCESS

end event

event pfc_open;call super::pfc_open;//
//TraceUser(100, "pfc_open")
//
end event

