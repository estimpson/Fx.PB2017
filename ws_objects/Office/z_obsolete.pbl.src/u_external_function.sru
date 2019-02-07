$PBExportHeader$u_external_function.sru
$PBExportComments$New! cross platform user object ancestor
forward
global type u_external_function from nonvisualobject
end type
end forward

global type u_external_function from nonvisualobject
end type
global u_external_function u_external_function

forward prototypes
public function integer uf_playsound (string as_filename, integer ai_options)
public function ulong uf_getsyscolor (int ai_index)
public function integer uf_getscreenwidth ()
public function integer uf_getscreenheight ()
public function string uf_getos_mode ()
public function ulong uf_getfreememory ()
public function integer uf_getmoduleusage (uint aui_inst)
public function uint uf_getdrivetype (integer ai_drive)
public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size)
public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size)
public function unsignedinteger uf_getfreesystemresources (integer parm)
public function integer uf_get_logon_name (ref string as_name)
public function ulong uf_get_logon_time ()
public function boolean uf_flash_window (long aui_handle, boolean ab_flash)
public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function long uf_getmodulehandle (string as_name)
public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function boolean uf_iswindowvisible (long aui_handle)
end prototypes

public function integer uf_playsound (string as_filename, integer ai_options);//Ancestor PlaySound function.

//Return -1 error becuase the function was not found in a descendent 
Return -1
end function

public function ulong uf_getsyscolor (int ai_index);//returns 0 becuase it was not found in the descendent nvo

return 0
end function

public function integer uf_getscreenwidth ();//returns -1 not found	r
Return -1
end function

public function integer uf_getscreenheight ();Return -1
end function

public function string uf_getos_mode ();//not valid
return ""
end function

public function ulong uf_getfreememory ();//not valid

return 0
end function

public function integer uf_getmoduleusage (uint aui_inst);//function not found	
return -1
end function

public function uint uf_getdrivetype (integer ai_drive);//drive types
return 0
end function

public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size);//function not found
return 0
end function

public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size);//directory not found
return 0
end function

public function unsignedinteger uf_getfreesystemresources (integer parm);//not valid
return 0
end function

public function integer uf_get_logon_name (ref string as_name);//func	
return -1
end function

public function ulong uf_get_logon_time ();//no func
return 0
end function

public function boolean uf_flash_window (long aui_handle, boolean ab_flash);//function not found in descendent
return false
end function

public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id);//not handled
Return False
end function

public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//not handled
return 0
end function

public function long uf_getmodulehandle (string as_name);//function not found
return 0
end function

public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
return 0
end function

public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
return 0
end function

public function boolean uf_iswindowvisible (long aui_handle);//function not found
return false
end function

on u_external_function.create
TriggerEvent( this, "constructor" )
end on

on u_external_function.destroy
TriggerEvent( this, "destructor" )
end on

