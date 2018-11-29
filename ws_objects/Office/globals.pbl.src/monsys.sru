$PBExportHeader$monsys.sru
forward
global type monsys from nonvisualobject
end type
end forward

global type monsys from nonvisualobject
event ue_constructor ( )
end type
global monsys monsys

type variables
STRING	oemtitle, &
	company, &
	serial, &
	root, &
	title, &
	msg_title
STRING	version
string	dbplatform
end variables

forward prototypes
private function string uf_get_mon_root ()
public subroutine of_getidinfo ()
end prototypes

event ue_constructor;//version = "Version 4.0.20000410"
version = "Version 4.7 Build 20061231"
root = uf_get_mon_root ( )
end event

private function string uf_get_mon_root ();w_nonvisible_base	l_w_1
listbox	l_lb_1
statictext	l_st_1

STRING	l_s_path

Open ( l_w_1 )
l_w_1.OpenUserObject ( l_lb_1 )
l_w_1.OpenUserObject ( l_st_1 )
l_lb_1.DirList ( "*.*", 0, l_st_1 )
l_s_path = l_st_1.text
l_w_1.CloseUserObject ( l_lb_1 )
l_w_1.CloseUserObject ( l_st_1 )
Close ( l_w_1 )

Return l_s_path
end function

public subroutine of_getidinfo ();integer		li_handle
string		ls_contents
w_encrypt	lw_encrypt

li_handle = FileOpen ( "id.pbd" )
if li_handle > 0 then
	FileRead ( li_handle, ls_contents )
	FileClose ( li_handle )
	Open ( w_encrypt )
	ls_contents = w_encrypt.decrypt ( ls_contents, "Lamont Sanford" )
	Close ( w_encrypt )
	serial = gf_parse ( ls_contents, "serial=", ";", "" )
	if serial = '' then
		MessageBox ( "Company Information", "Invalid serial number!  Please contact your system administrator.", StopSign! )
		HALT CLOSE
	end if
	oemtitle = gf_parse ( ls_contents, "oemtitle=", ";", "" )
	company = gf_parse ( ls_contents, "name=", ";", "" )
	dbplatform = gf_parse ( ls_contents, "dbplatform=", ";", "" )
	if gf_parse ( ls_contents, title + "=", ";", 'N' ) = 'N' then
		MessageBox ( title, "You do not have proper authorization to run this application!", StopSign! )
		HALT CLOSE
	end if
else
	MessageBox ( "Company Information", "Unable to retrieve information from identification file!  Please make sure this file is available and try again.", StopSign! )
	HALT CLOSE
end if

end subroutine

on monsys.create
TriggerEvent( this, "constructor" )
end on

on monsys.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;TRIGGER EVENT ue_constructor ( )
end event

