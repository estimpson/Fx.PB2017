$PBExportHeader$n_cst_registry.sru
forward
global type n_cst_registry from nonvisualobject
end type
end forward

global type n_cst_registry from nonvisualobject autoinstantiate
end type

type variables
constant string	ODBCProfile = "HKEY_CURRENT_USER\Software\ODBC\ODBC.INI"
constant string	SystemODBCProfile = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI"
constant string	UserRoot = "HKEY_CURRENT_USER\Software\Fore-Thought"
constant string	DatabaseRoot = "HKEY_LOCAL_MACHINE\Software\Fore-Thought\DatabaseProfiles\"
constant string	SQLServerProfiles = "\SQLServer"
constant string	CUP = "HKEY_CURRENT_USER\Software\"
constant string	LMP = "HKEY_LOCAL_MACHINE\Software\"
constant string	ROOT = "Fore-Thought\"
constant string	CurrentUserJob = CUP + ROOT + "Job"
constant string	LocalMachineJob = LMP + ROOT + "Job"
constant string	DBProfile = CUP + ROOT + "Profiles"
constant string	OldIncomingMapping = LMP + ROOT + "TMFMS\EDI\Incoming\Mapping"
constant string	OldIncomingEDI = LMP + ROOT + "TMFMS\EDI\Incoming\File List"
constant string	OldEDIIncomingFileList = LMP + ROOT + "TMFMS\EDI\Incoming\File List"
constant string	OldEDIOutgoingFileList = LMP + ROOT + "TMFMS\EDI\Outgoing\File List"
constant string	OldEDIOutgoingDWList = LMP + ROOT + "TMFMS\EDI\Outgoing\DW List"
constant string	CurrentUserQueue = CUP + ROOT + "Job Queue"
constant string	LocalMachineQueue = LMP + ROOT + "Job Queue"
constant string	CurrentUserTask = CUP + ROOT + "Task"
constant string	LocalMachineTask = LMP + ROOT + "Task"

end variables

forward prototypes
public subroutine of_getsqlserverprofiles (string as_appprofile, ref string as_profiles[])
public subroutine of_getodbcprofiles (ref string as_profiles[])
public subroutine of_getsystemodbcprofiles (ref string as_profiles[])
public subroutine of_getdefaultprofile (string as_appprofile, ref string as_profile, ref string as_dbms)
public subroutine of_setdefaultprofile (string as_appprofile, string as_profile, string as_dbms)
public function boolean of_getdbprompt (string as_appprofile)
public subroutine of_setdbprompt (string as_appprofile, boolean ab_prompt)
public subroutine of_deletesqlserverprofile (string as_appprofile, string as_Profile)
public subroutine of_setsqlserverprofilesettings (string as_appprofile, string as_originalprofile, string as_profile, ref string as_servername, ref string as_database, ref string as_logid, ref string as_logpassword, ref unsignedlong alul_integratedsecurity, ref unsignedlong alul_autocommit)
public subroutine of_checkdbregsettings (string as_appprofile)
public function boolean of_displaysystemodbc (string as_appprofile)
public function boolean of_displayodbc (string as_appprofile)
public subroutine of_setdisplaydbms (string as_appprofile, unsignedlong alul_sqlserver, ulong alul_odbc, unsignedlong alul_systemodbc)
public subroutine of_getdisplaydbms (string as_appprofile, ref unsignedlong alul_sqlserver, ref unsignedlong alul_odbc, ref unsignedlong alul_systemodbc)
public subroutine of_getprofiledbms (ref string as_profile, ref string as_dbms)
public function boolean of_displaysqlserver (string as_appprofile)
public subroutine getdefaultuser (ref string _defaultuser)
public subroutine setdefaultuser (string _defaultuser)
public subroutine cleardefaultuser ()
public subroutine of_getsqlserverprofilesettings (string as_appprofile, string as_profile, ref string as_provider, ref string as_servername, ref string as_database, ref string as_logid, ref string as_logpassword, ref unsignedlong alul_integratedsecurity, ref unsignedlong alul_autocommit)
end prototypes

public subroutine of_getsqlserverprofiles (string as_appprofile, ref string as_profiles[]);
//	Read the profiles from the registry and populate the list
RegistryKeys ( DatabaseRoot + as_AppProfile + SQLServerProfiles, as_Profiles )

end subroutine

public subroutine of_getodbcprofiles (ref string as_profiles[]);
//	Return the ODBC profiles setup for the current user
RegistryKeys ( ODBCProfile, as_Profiles )

end subroutine

public subroutine of_getsystemodbcprofiles (ref string as_profiles[]);
//	Return the ODBC profiles setup for the current user
RegistryKeys ( SystemODBCProfile, as_Profiles )

end subroutine

public subroutine of_getdefaultprofile (string as_appprofile, ref string as_profile, ref string as_dbms);
//	Get the profile from the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "DefaultProfile", RegString!, as_Profile )
RegistryGet ( DatabaseRoot + as_AppProfile, "DefaultDBMS", RegString!, as_DBMS )

end subroutine

public subroutine of_setdefaultprofile (string as_appprofile, string as_profile, string as_dbms);
//	Write the default profile to the registry
RegistrySet ( DatabaseRoot + as_AppProfile, "DefaultProfile", RegString!, as_Profile )
RegistrySet ( DatabaseRoot + as_AppProfile, "DefaultDBMS", RegString!, as_DBMS )

end subroutine

public function boolean of_getdbprompt (string as_appprofile);
//	Declarations
ulong	lul_Prompt

//	Get the prompt setting from the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "Prompt", RegULong!, lul_Prompt )

//	Return the setting
return ( lul_Prompt = 1 )

end function

public subroutine of_setdbprompt (string as_appprofile, boolean ab_prompt);
//	Declarations
ulong	lul_Prompt

//	Set the value
if ab_Prompt then
	lul_Prompt = 1
else
	lul_Prompt = 0
end if

//	Write the setting to the registry
RegistrySet ( DatabaseRoot + as_AppProfile, "Prompt", RegULong!, lul_Prompt )

end subroutine

public subroutine of_deletesqlserverprofile (string as_appprofile, string as_Profile);
//	Delete the registry key for the profile arg
RegistryDelete ( DatabaseRoot + as_AppProfile + SQLServerProfiles + "\" + as_Profile, "" )

end subroutine

public subroutine of_setsqlserverprofilesettings (string as_appprofile, string as_originalprofile, string as_profile, ref string as_servername, ref string as_database, ref string as_logid, ref string as_logpassword, ref unsignedlong alul_integratedsecurity, ref unsignedlong alul_autocommit);

//	Declarations
string	ls_Reg

//	If the original profile has a value and it and the new profile are different, delete the original first
if IsNull ( as_OriginalProfile, '' ) > '' then
	if as_OriginalProfile <> as_Profile then
		RegistryDelete ( DatabaseRoot + as_AppProfile + SQLServerProfiles + "\" + as_OriginalProfile, "" )
	end if
end if

//	Build the registry string
ls_Reg = DatabaseRoot + as_AppProfile + SQLServerProfiles + "\" + as_Profile

//	Set the settings for the profile
RegistrySet ( ls_Reg, "ServerName", RegString!, as_ServerName )
RegistrySet ( ls_Reg, "Database", RegString!, as_Database )
RegistrySet ( ls_Reg, "LogID", RegString!, as_LogID )
RegistrySet ( ls_Reg, "LogPassword", RegString!, as_LogPassword )
RegistrySet ( ls_Reg, "IntegratedSecurity", RegULong!, alul_IntegratedSecurity )
RegistrySet ( ls_Reg, "AutoCommit", RegULong!, alul_AutoCommit )

end subroutine

public subroutine of_checkdbregsettings (string as_appprofile);
//	Check to see if the database settings are there, if not, read from ini
//	file and put them into the registry
string	ls_Value
string	ls_IniFile
string	ls_DefaultDBMS
string	ls_DefaultProfile
integer	li_Pos
integer	li_EndPos
ulong	lul_Value

if RegistryGet ( DatabaseRoot + as_AppProfile, "Prompt", RegULong!, lul_Value ) = -1 then
	ls_IniFile = gnv_app.of_GetAppIniFile()
	ls_Value = ProfileString ( ls_IniFile, "DBMS_PROFILES", "PROMPT", "YES" )
	of_SetDBPrompt ( as_AppProfile, ( Upper ( ls_Value ) = "YES" ) )
	ls_DefaultDBMS = ProfileString ( ls_IniFile, "Database", "DBMS", "" )
	ls_Value = ProfileString ( ls_IniFile, "Database", "DBParm", "" )
	li_Pos = Pos ( ls_Value, "DSN=" )
	if li_Pos > 0 then
		li_EndPos = Pos ( ls_Value, ";", li_Pos )
		if li_EndPos < 1 then
			li_EndPos = Pos ( ls_Value, "'", li_Pos )
			if li_EndPos < 1 then
				li_EndPos = Len ( ls_Value )
			end if
		end if
		ls_DefaultProfile = Mid ( ls_Value, li_Pos + 4, li_EndPos - ( li_Pos + 4 ) )
	end if
	if ls_DefaultProfile > '' then
		of_GetProfileDBMS ( ls_DefaultProfile, ls_DefaultDBMS )
		of_SetDefaultProfile ( as_AppProfile, ls_DefaultProfile, ls_DefaultDBMS )
	end if
	if ls_DefaultDBMS = 'SysODBC' then
		of_SetDisplayDBMS ( as_AppProfile, 0, 1, 1 )
	else
		of_SetDisplayDBMS ( as_AppProfile, 0, 1, 0 )
	end if
end if

end subroutine

public function boolean of_displaysystemodbc (string as_appprofile);
//	Declarations
ulong	lul_Display = 0

//	Get the setting from the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplaySystemODBC", RegULong!, lul_Display )

//	Return whether to display sql server in profiles
return ( lul_Display = 1 )

end function

public function boolean of_displayodbc (string as_appprofile);
//	Declarations
ulong	lul_Display = 0

//	Get the setting from the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplayODBC", RegULong!, lul_Display )

//	Return whether to display sql server in profiles
return ( lul_Display = 1 )

end function

public subroutine of_setdisplaydbms (string as_appprofile, unsignedlong alul_sqlserver, ulong alul_odbc, unsignedlong alul_systemodbc);
//	Write the settings to the registry
RegistrySet ( DatabaseRoot + as_AppProfile, "DisplaySQLServer", RegULong!, alul_SQLServer )
RegistrySet ( DatabaseRoot + as_AppProfile, "DisplayODBC", RegULong!, alul_ODBC )
RegistrySet ( DatabaseRoot + as_AppProfile, "DisplaySystemODBC", RegULong!, alul_SystemODBC )

end subroutine

public subroutine of_getdisplaydbms (string as_appprofile, ref unsignedlong alul_sqlserver, ref unsignedlong alul_odbc, ref unsignedlong alul_systemodbc);
//	Write the settings to the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplaySQLServer", RegULong!, alul_SQLServer )
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplayODBC", RegULong!, alul_ODBC )
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplaySystemODBC", RegULong!, alul_SystemODBC )

end subroutine

public subroutine of_getprofiledbms (ref string as_profile, ref string as_dbms);
//	Declarations
string	ls_Profiles[]
integer	li_Index

as_DBMS = ''

//	Get the user profiles and see if it exists in them
RegistryKeys ( ODBCProfile, ls_Profiles )

for li_Index = 1 to UpperBound ( ls_Profiles )
	if Lower ( ls_Profiles[li_Index] ) = Lower ( as_Profile ) then
		as_Profile = ls_Profiles[li_Index]
		as_DBMS = 'ODBC'
		exit
	end if
next

//	Get the system profiles and see if it exists in them
if as_DBMS = '' then
	RegistryKeys ( SystemODBCProfile, ls_Profiles )
	
	for li_Index = 1 to UpperBound ( ls_Profiles )
		if Lower ( ls_Profiles[li_Index] ) = Lower ( as_Profile ) then
			as_Profile = ls_Profiles[li_Index]
			as_DBMS = 'SysODBC'
			exit
		end if
	next
end if

end subroutine

public function boolean of_displaysqlserver (string as_appprofile);
//	Declarations
ulong	lul_Display = 0

//	Get the setting from the registry
RegistryGet ( DatabaseRoot + as_AppProfile, "DisplaySQLServer", RegULong!, lul_Display )

//	Return whether to display sql server in profiles
return ( lul_Display = 1 )

end function

public subroutine getdefaultuser (ref string _defaultuser);
//	Get the default user.
RegistryGet (UserRoot, "DefaultUser", RegString!, _defaultUser)

end subroutine

public subroutine setdefaultuser (string _defaultuser);
//	Get the default user.
RegistrySet (UserRoot, "DefaultUser", RegString!, _defaultUser)

end subroutine

public subroutine cleardefaultuser ();
SetDefaultUser ("")

end subroutine

public subroutine of_getsqlserverprofilesettings (string as_appprofile, string as_profile, ref string as_provider, ref string as_servername, ref string as_database, ref string as_logid, ref string as_logpassword, ref unsignedlong alul_integratedsecurity, ref unsignedlong alul_autocommit);
//	Declarations
ulong	lul_Value
string	ls_Reg

ls_Reg = DatabaseRoot + as_AppProfile + SQLServerProfiles + "\" + as_Profile

//	Get the settings for the profile
if RegistryGet(DatabaseRoot + as_AppProfile + SQLServerProfiles, "Provider", RegString!, as_Provider) = -1 then
	as_Provider = 'SQLCLI'
end if

if RegistryGet ( ls_Reg, "ServerName", RegString!, as_ServerName ) = -1 then
	as_ServerName = ""
end if
if RegistryGet ( ls_Reg, "Database", RegString!, as_Database ) = -1 then
	as_Database = ""
end if
if RegistryGet ( ls_Reg, "LogID", RegString!, as_LogID ) = -1 then
	as_LogID = ""
end if
if RegistryGet ( ls_Reg, "LogPassword", RegString!, as_LogPassword ) = -1 then
	as_LogPassword = ""
end if
if RegistryGet ( ls_Reg, "IntegratedSecurity", RegULong!, alul_IntegratedSecurity ) = -1 then
	alul_IntegratedSecurity = 0
end if
if RegistryGet ( ls_Reg, "AutoCommit", RegULong!, alul_AutoCommit ) = -1 then
	alul_AutoCommit = 0
end if

end subroutine

on n_cst_registry.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_registry.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

