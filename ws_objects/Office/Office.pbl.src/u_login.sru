$PBExportHeader$u_login.sru
forward
global type u_login from u_dw
end type
end forward

global type u_login from u_dw
integer width = 2057
integer height = 112
string dataobject = "d_userlogin"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event ue_returnastab pbm_dwnprocessenter
event type integer ue_login ( string _user )
event ue_loggedout ( )
end type
global u_login u_login

type variables

private n_cst_fxtrans _fxTrans
public privatewrite string FullUserName

end variables

forward prototypes
private function integer validateuser ()
public function integer login4t ()
public function integer clearuser ()
public function integer setuser (string usercode, string username)
end prototypes

event ue_returnastab;
//	Tell DW to process as tab.
Send(Handle(this),256,9,Long(0,0))

//	See if both username and password have values.
if	object.username [1] > "" and object.password [1] > "" then
	validateUser()
end if

//	Enter handled.
return 1

end event

private function integer validateuser ();
//	Lookup user.
string	userCode, password, userName

userCode = object.username[1]
password = object.password[1]

if	_fxTrans.LoginUser(userCode, password, userName) = SUCCESS then
	_fxTrans.CommitTrans()
	
	//	Notify controls.
	integer	loginResult
	loginResult = event ue_login (userCode)
	if	not loginResult = PREVENT_ACTION then
		FullUserName = userName
		object.fullname[1] = FullUserName
		if	object.remember[1] = 1 then
			n_cst_registry	registryValues
			registryValues.SetDefaultUser(userCode)
		end if
		return	SUCCESS
	else
		MessageBox (gnv_App.iapp_Object.DisplayName, "You don't have access to this application.  Please contact your system administrator.")
		clearUser()
	end if
else
	_fxTrans.RollbackTrans()
	MessageBox (gnv_App.iapp_Object.DisplayName, "Invalid user name or password.  Please try again.")
	clearUser()
	return	FAILURE
end if
return	FAILURE



end function

public function integer login4t ();
object.username [1] = "4T"
object.password [1] = "4T"
return	ValidateUser()

end function

public function integer clearuser ();
//	Clear default user.
n_cst_registry	registryValues
registryValues.ClearDefaultUser()

//	Notify controls.
post event ue_loggedout()

FullUserName = ""
object.username [1] = ""
object.password [1] = ""
object.fullname [1] = ""
object.remember [1] = 0
SetColumn (Long(object.username.ID))

return SUCCESS

end function

public function integer setuser (string usercode, string username);string nullPwd; SetNull(nullPwd)
if	_fxTrans.LoginUser(userCode, nullPwd, userName) = SUCCESS then
	_fxTrans.CommitTrans()
	
	//	Notify controls.
	integer	loginResult
	loginResult = event ue_login(userCode)
	if	not loginResult = PREVENT_ACTION then
		FullUserName = userName
		object.fullname[1] = FullUserName
		if	object.remember[1] = 1 then
			n_cst_registry	registryValues
			registryValues.SetDefaultUser(userCode)
		end if
		return	SUCCESS
	else
		MessageBox (gnv_App.iapp_Object.DisplayName, "You don't have access to this application.  Please contact your system administrator.")
		clearUser()
	end if
else
	_fxTrans.RollbackTrans()
	MessageBox (gnv_App.iapp_Object.DisplayName, "Invalid user name or password.  Please try again.")
	clearUser()
	return	FAILURE
end if
return	FAILURE

end function

on u_login.create
call super::create
end on

on u_login.destroy
call super::destroy
end on

event clicked;call super::clicked;
//	If clicked item was "t_change" then clear user name and password.
if	dwo.Name = "fullname" then
	clearUser()
elseif	dwo.Name = "remember" then
	if	object.remember [1] = 0 then
		object.remember [1] = 1
	else
		object.remember [1] = 0
	end if
end if

end event

event buttonclicked;call super::buttonclicked;
AcceptText()
if	dwo.Name = "b_login" then
	validateUser()
end if

end event

event constructor;call super::constructor;
//	Not updateable.
of_SetUpdateable(false)
_fxTrans = create n_cst_fxtrans

end event

event losefocus;call super::losefocus;
//	If not logged in, can't loose focus.
if	not FullUserName > "" and Visible and Enabled then
	SetFocus(this)
end if

end event

event destructor;call super::destructor;
if	IsValid(_fxTrans) then
	destroy _fxTrans
end if

end event

