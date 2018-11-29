$PBExportHeader$n_cst_fxtrans.sru
forward
global type n_cst_fxtrans from n_cst_trans
end type
end forward

shared variables

end variables

global type n_cst_fxtrans from n_cst_trans
end type
global n_cst_fxtrans n_cst_fxtrans

type variables

protected string User

end variables

forward prototypes
public function long statusvalue (string _tablename, string _statusname)
public function long typevalue (string _tablename, string _typename)
public function string statusname (string _tablename, long _statusvalue)
public function string typename (string _tablename, long _typevalue)
public function long trailingdigits (string _value)
public function integer committrans ()
public function integer rollbacktrans ()
public function integer enablecmdline ()
public function integer disablecmdline ()
public function integer enableansiwarnings ()
public function integer disableansiwarnings ()
public function integer loginuser (string usercode, string password, ref string username)
end prototypes

public function long statusvalue (string _tablename, string _statusname);
int statusValue
SetNull(statusValue)

select
	dbo.udf_StatusValue(:_TableName, :_statusName)
into
	:statusValue
from
	parameters using TransObject  ;

if	sqlca.sqlcode = 0 then
	return statusValue
end if

select
	dbo.udf_StatusValue(:_TableName, 'Status', :_statusName)
into
	:statusValue
from
	parameters using TransObject  ;

return statusValue

end function

public function long typevalue (string _tablename, string _typename);
int typeValue
SetNull(typeValue)

select
	dbo.udf_TypeValue(:_TableName, :_typeName)
into
	:typeValue
from
	parameters using TransObject  ;

if	sqlca.sqlcode = 0 then
	return typeValue
end if

select
	dbo.udf_TypeValue(:_TableName, 'Type', :_typeName)
into
	:typeValue
from
	parameters using TransObject  ;

return typeValue

end function

public function string statusname (string _tablename, long _statusvalue);
string statusName
SetNull(statusName)

select
	dbo.udf_StatusName(:_TableName, :_statusValue)
into
	:statusName
from
	parameters using TransObject  ;

if	sqlca.sqlcode = 0 then
	return statusName
end if

select
	dbo.udf_StatusName(:_TableName, 'Status', :_statusValue)
into
	:statusName
from
	parameters using TransObject  ;

return statusName

end function

public function string typename (string _tablename, long _typevalue);
string typeName
SetNull(typeName)

select
	dbo.udf_TypeName(:_TableName, :_typeValue)
into
	:typeName
from
	parameters using TransObject  ;

if	sqlca.sqlcode = 0 then
	return typeName
end if

select
	dbo.udf_TypeName(:_TableName, 'Type', :_typeValue)
into
	:typeName
from
	parameters using TransObject  ;

return typeName

end function

public function long trailingdigits (string _value);
long digits
SetNull(digits)

select
	convert(int, dbo.udf_GetTrailingDigits(:_value))
into
	:digits
from
	parameters using TransObject  ;

return digits

end function

public function integer committrans ();
commit using TransObject  ;
return SUCCESS

end function

public function integer rollbacktrans ();
rollback using TransObject  ;
return SUCCESS

end function

public function integer enablecmdline ();
execute immediate "execute sp_configure 'show advanced options', 1" using TransObject  ;
execute immediate "reconfigure" using TransObject  ;
execute immediate "execute sp_configure 'xp_cmdshell', 1" using TransObject  ;
execute immediate "reconfigure" using TransObject  ;

return SUCCESS

end function

public function integer disablecmdline ();
execute immediate "execute sp_configure 'xp_cmdshell', 0" using TransObject  ;
execute immediate "reconfigure" using TransObject  ;
execute immediate "execute sp_configure 'show advanced options', 0" using TransObject  ;
execute immediate "reconfigure" using TransObject  ;

return SUCCESS

end function

public function integer enableansiwarnings ();
execute immediate "set ansi_warnings on" using TransObject  ;

return SUCCESS

end function

public function integer disableansiwarnings ();
execute immediate "set ansi_warnings off" using TransObject  ;

return SUCCESS

end function

public function integer loginuser (string usercode, string password, ref string username);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError, procMessage

//	Attempt to login user.
declare LoginUser procedure for dbo.usp_Admin_LoginUser
	@UserCode = :userCode
,	@Password = :password
,	@UserName = :userName output
,	@TranDT = :tranDT output
,	@Result =:procResult output
,	@Message = :procMessage output using TransObject  ;

execute LoginUser  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to login user:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	LoginUser
into
	:userName
,	:tranDT
,	:procResult
,	:procMessage  ;

if	procResult > 0 and procResult < 999999 then
	MsgBox("License has expired:  " + procMessage + "  To avoid loss of service, contact Fore-Thought immediately.")
elseif	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to login user:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close LoginUser   ;

//	Return.
return SUCCESS

end function

on n_cst_fxtrans.create
call super::create
end on

on n_cst_fxtrans.destroy
call super::destroy
end on

event constructor;call super::constructor;
SetTransObject(SQLCA)
gnv_App.inv_StateMSGRouter.Register("User", this, true)
User = IsNull(gnv_App.inv_Global.of_GetItem("User"), "")


end event

event pfd_event;call super::pfd_event;
choose case EventName
	case "User"
		try
			any getUser
			getUser = eventmessage.of_GetItem("User")
			User = IsNull(getUser, "")
		catch (Exception ex)
			User = ""
		end try
end choose

end event

