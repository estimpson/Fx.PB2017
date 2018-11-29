$PBExportHeader$n_cst_appmanager_scheduling.sru
forward
global type n_cst_appmanager_scheduling from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_scheduling from n_cst_appmanager
string is_appkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
string is_userkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
end type
global n_cst_appmanager_scheduling n_cst_appmanager_scheduling

on n_cst_appmanager_scheduling.create
call super::create
end on

on n_cst_appmanager_scheduling.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Enable application preferences.
of_SetAppPreference(true)
inv_AppPref.of_SetRestoreApp(true)

end event

event pfc_presplash;call super::pfc_presplash;
//	Open frame.
open (w_frame_scheduling)

end event

