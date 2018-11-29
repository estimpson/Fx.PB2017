$PBExportHeader$n_cst_appmanager_scheduler.sru
forward
global type n_cst_appmanager_scheduler from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_scheduler from n_cst_appmanager
string is_appkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
string is_userkey = "HKEY_CURRENT_USER\Software\Fore-Thought\Office"
end type
global n_cst_appmanager_scheduler n_cst_appmanager_scheduler

on n_cst_appmanager_scheduler.create
call super::create
end on

on n_cst_appmanager_scheduler.destroy
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

