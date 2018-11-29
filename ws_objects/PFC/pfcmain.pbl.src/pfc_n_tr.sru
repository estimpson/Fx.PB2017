$PBExportHeader$pfc_n_tr.sru
$PBExportComments$PFC Transaction class
forward
global type pfc_n_tr from transaction
end type
end forward

global type pfc_n_tr from transaction
end type
global pfc_n_tr pfc_n_tr

type variables
Protected:
boolean	ib_autorollback
boolean 	ib_trace
string	is_name


end variables

forward prototypes
public function boolean of_isconnected ()
public function long of_commit ()
public function long of_rollback ()
public function long of_connect ()
public function long of_disconnect ()
public function string of_getsqlstate ()
public function boolean of_gettrace ()
public function long of_execute (string as_sqlstatement)
public function boolean of_getautorollback ()
public function integer of_settrace (boolean ab_trace)
public function integer of_copyto (n_tr atr_target)
public function integer of_setname (string as_name)
public function string of_getname ()
public function integer of_init (string as_inifile, string as_inisection)
public function integer of_init (string as_registrykey)
public subroutine of_setuser (string as_userid, string as_password)
public function long of_distinctvalues (string as_table, string as_column, ref string as_values[])
public function long of_begin ()
public function long of_end ()
public function integer of_setautorollback (boolean ab_autorollback)
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
end prototypes

public function boolean of_isconnected ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IsConnected
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  boolean
//	true = connected
//	false = not connected
//
//	Description:
//	Determines if a connection has been established to the database
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.01   Fixed bug where negative handles were not being considered as connected
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if this.DBHandle() = 0 then
	return false
else
	return true
end if

end function

public function long of_commit ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Commit
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//	The SQLCode return value from the commit statement.
//	-10 if there is no connection to the database.
//
//	Description:  Issues a commit transaction
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc = -10
string	ls_name

if of_IsConnected() then
	
	// If SQLSpy service is on, add to the history
	if IsValid (gnv_app) then
		if IsValid (gnv_app.inv_debug) then
			if IsValid (gnv_app.inv_debug.inv_sqlspy) then
				ls_name = this.is_name
				if Len (ls_name) = 0 then
					ls_name = this.ClassName()
				end if
				gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax ("Commit using " + ls_name)
			end if 
		end if
	end if
	
	commit using this;
	ll_rc = this.SQLCode
end if

return ll_rc
end function

public function long of_rollback ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Rollback
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//	The SQLCode return value from the rollback statement.
//	-10 if there is no connection to the database.
//
//	Description:  Issues a rollback
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc = -10
string	ls_name

if of_IsConnected() then
	
	// If SQLSpy is available, add to the history
	if IsValid (gnv_app) then
		if IsValid (gnv_app.inv_debug) then
			ls_name = this.is_name
			if Len (ls_name) = 0 then
				ls_name = this.ClassName()
			end if
			if IsValid (gnv_app.inv_debug.inv_sqlspy) then
				gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax ("Rollback using " + ls_name)
			end if 
		end if
		rollback using this;
		ll_rc = this.SQLCode
	end if
	
end if

return ll_rc

end function

public function long of_connect ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Connect
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//	The SQLCode return value after the connect is issued
//
//	Description:  Issues a connect
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc
string	ls_name

// If SQLSpy is available, add to the history
if IsValid (gnv_app) then
	if IsValid (gnv_app.inv_debug) then
		ls_name = this.is_name
		if Len (ls_name) = 0 then
			ls_name = this.ClassName()
		end if
		if IsValid (gnv_app.inv_debug.inv_sqlspy) then
			gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax ("Connect using " + ls_name)
		end if 
	end if
end if

connect using this;
ll_rc = this.SQLCode

return ll_rc
end function

public function long of_disconnect ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Disconnect
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//	The SQLCode return value after the disconnect is issued
//
//	Description:  Issues a disconnect
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc
string	ls_name

// If SQLSpy is available, add to the history
if IsValid (gnv_app) then
	if IsValid (gnv_app.inv_debug) then
		ls_name = this.is_name
		if Len (ls_name) = 0 then
			ls_name = this.ClassName()
		end if
		if IsValid (gnv_app.inv_debug.inv_sqlspy) then
			gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax ("Disconnect using " + ls_name)
		end if 
	end if
end if

disconnect using this;
ll_rc = this.SQLCode

return ll_rc
end function

public function string of_getsqlstate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSQLState
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  string
//	SQL state generated by the dbms
//
//	Description:  Return the SQL state generated by the dbms
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_pos1
integer	li_pos2
string		ls_temp

if sqlerrtext <> "" then
	li_pos1 = Pos (this.sqlerrtext, "=") +2
	li_pos2 = (Pos (this.sqlerrtext, "[") -2) - li_pos1
	ls_temp = Mid (this.sqlerrtext, li_pos1,  li_pos2)
end if

return ls_temp
end function

public function boolean of_gettrace ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTrace
//
//	Access:  public
//
//	Arguments:	none
//
//	Returns: 	boolean
//	The trace property value.
//
//	Description:
//	Gets the value of the trace property
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return ib_trace
end function

public function long of_execute (string as_sqlstatement);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Execute
//
//	Access:  public
//
//	Arguments:	
//	as_sqlstatement:  the SQL statement to execute
//
//	Returns:  long
//	the SQLCode value after the SQL is executed
//	-10	if there is no connection to the database.
//
//	Description:  Executes specified SQL
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc = -10
string	ls_name

if of_IsConnected() then
	
	// If SQLSpy is available, add to the history
	if IsValid (gnv_app) then
		if IsValid (gnv_app.inv_debug) then
			if IsValid (gnv_app.inv_debug.inv_sqlspy) then
				ls_name = this.is_name
				if Len (ls_name) = 0 then
					ls_name = this.ClassName()
				end if
				// Note:  as_sqlstatement is passed by reference
				gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax &
					("Dynamic SQL using " + ls_name, as_SQLStatement, true)
			end if 
		end if
	end if
	
	execute immediate :as_SQLStatement using this;
	ll_rc = this.SQLCode
end if

return ll_rc
end function

public function boolean of_getautorollback ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetAutoRollback
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns: 	boolean
//	The autorollback property value.
//
//	Description:
//	Gets the autorollback property value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return ib_autorollback
end function

public function integer of_settrace (boolean ab_trace);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetTrace
//
//	Access:  public
//
//	Arguments:
//	ab_trace   the desired trace property value.
//
//	Returns:  integer
//	 1 = success
//	 0 = trace property was already the desired value
//	-1 = error
//
//	Description:
//	Sets the trace property
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant string KEYWORD = 'trace '
integer	li_keywordpos
string	 	ls_dbms

// Check arguments
if IsNull (ab_trace) then
	return -1
end if

// Check if an action is required
if ib_trace = ab_trace then 
	return 0
end if

// Set trace property
ib_trace = ab_trace
ls_dbms =  Lower (this.dbms)
li_keywordpos = Pos (ls_dbms, KEYWORD)

if ib_trace then
	if li_keywordpos > 0 then 
		// Keyword 'trace ' is already found.
		return -1
	end if
	this.dbms = KEYWORD + this.dbms
else
	// The word 'trace ' should be found and removed
	if li_keywordpos = 0 then 
		// Keyword 'Trace' is not found.
		return -1
	end if	
	this.dbms = Mid (this.dbms, li_keywordpos + Len (KEYWORD), Len (this.dbms))
end if

if of_IsConnected() then
	// For the change to take effect a reconnection is required.
	of_Disconnect()
	of_Connect()
end if

return 1

end function

public function integer of_copyto (n_tr atr_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CopyTo
//
//	Access:  public
//
//	Arguments:		
//	atr_target  target transaction object passed by reference.
//
//	Returns:  Integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Copy the contents of this object to the transaction object passed in.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull(atr_target) Or not IsValid (atr_target) then
	return -1
end if

// Copy the system transaction values
atr_target.DBMS = this.DBMS
atr_target.Database = this.Database
atr_target.LogID = this.LogID
atr_target.LogPass = this.LogPass
atr_target.ServerName = this.ServerName
atr_target.UserID = this.UserID
atr_target.DBPass = this.DBPass
atr_target.Lock = this.Lock
atr_target.DbParm = this.DbParm
atr_target.Autocommit = this.Autocommit
atr_target.sqlcode = this.sqlcode
atr_target.sqldbcode = this.sqldbcode
atr_target.sqlnrows = this.sqlnrows
atr_target.sqlerrtext = this.sqlerrtext
atr_target.sqlreturndata = this.sqlreturndata

// Copy the pfc transaction properties
atr_target.of_SetAutoRollback (ib_autorollback)
atr_target.of_SetTrace (ib_trace)
atr_target.of_SetName (is_name)

return 1
end function

public function integer of_setname (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetName
//
//	Access:  public
//
//	Arguments:
//	as_name	   the name of this transaction object
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the name of this transaction object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (as_name) then
	return -1
end if

is_name = as_name
return 1
end function

public function string of_getname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetName
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns: 	string
//	The name of this transaction object
//
//	Description:
//	Gets the name of this transaction object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return is_name
end function

public function integer of_init (string as_inifile, string as_inisection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Init
//
//	Access:  public
//
//	Arguments:
//	as_inifile   .INI file to read values from.
//	as_inisection   Section within .INI file where transaction object values are.
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Initializes transaction object's properties with 	values from 
//	an .INI file.  Values that are not found will be defaulted to an empty string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_conversion lnv_conversion

// Check arguments
if IsNull (as_inifile) or IsNull (as_inisection) or &
	Len (Trim (as_inifile))=0 or Len (Trim (as_inisection))=0 or &
	(not FileExists (as_inifile)) then
	return -1
end if

this.DBMS= ProfileString (as_inifile, as_inisection, 'DBMS', '')
this.Database = ProfileString (as_inifile, as_inisection, 'Database', '')
this.LogID = ProfileString (as_inifile, as_inisection, 'LogID', '')
this.LogPass = ProfileString (as_inifile, as_inisection, 'LogPassword', '')
this.ServerName = ProfileString (as_inifile, as_inisection, 'ServerName', '')
this.UserID = ProfileString (as_inifile, as_inisection, 'UserID', '')
this.DBPass =ProfileString (as_inifile, as_inisection, 'DatabasePassword', '')
this.Lock =ProfileString (as_inifile, as_inisection, 'Lock', '')
this.DBParm =ProfileString (as_inifile, as_inisection, 'DBParm', '')
this.AutoCommit = lnv_conversion.of_Boolean &
 		(ProfileString (as_inifile, as_inisection, 'AutoCommit', 'false'))
if IsNull (this.AutoCommit) then this.AutoCommit = false

return 1
end function

public function integer of_init (string as_registrykey);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Init
//
//	Access:  public
//
//	Arguments:
//	as_registrykey   the registry key to read values from
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Initializes transaction object's properties with 	values from 
//	the registry.  Values that are not found will be defaulted to an empty string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
string		ls_dbms
string		ls_database
string		ls_logid
string		ls_logpass
string		ls_servername
string		ls_userid
string		ls_dbpass
string		ls_lock
string		ls_dbparm
string		ls_autocommit
n_cst_conversion lnv_conversion

// Check arguments
if IsNull (as_registrykey) or Len (Trim (as_registrykey)) =0 then
	return -1
end if

// If available, get each individual value.
li_rc = RegistryGet (as_registrykey, 'DBMS', ls_dbms)
li_rc = RegistryGet (as_registrykey, 'Database', ls_database)
li_rc = RegistryGet (as_registrykey, 'LogID', ls_logid)
li_rc = RegistryGet (as_registrykey, 'LogPassword', ls_logpass)
li_rc = RegistryGet (as_registrykey, 'ServerName', ls_servername)
li_rc = RegistryGet (as_registrykey, 'UserID', ls_userid)
li_rc = RegistryGet (as_registrykey, 'DatabasePassword', ls_dbpass)
li_rc = RegistryGet (as_registrykey, 'Lock', ls_lock)
li_rc = RegistryGet (as_registrykey, 'DBParm', ls_dbparm)
li_rc = RegistryGet (as_registrykey, 'AutoCommit', ls_autocommit)

// Initialize this object
this.DBMS = ls_dbms
this.Database = ls_database
this.LogID = ls_logid
this.LogPass = ls_logpass
this.ServerName = ls_servername
this.UserID = ls_userid
this.DBPass = ls_dbpass
this.Lock 	= ls_lock
this.DbParm = ls_dbparm
this.Autocommit = lnv_conversion.of_Boolean (ls_autocommit)
if IsNull (this.Autocommit) then this.Autocommit = false

return 1
end function

public subroutine of_setuser (string as_userid, string as_password);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetUser
//
//	Access:  public
//
//	Arguments:
//	as_userid:  User ID
//	as_password:  User's password
//
//	Returns:  none
//
//	Description:  Sets the property values of the transaction
//	object for user id and password specified.
//
//	Note:
//	Override this function in descendant transaction objects if dbms-specific
//	functionality is desired.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Changed default behavior of function to modify the ConnectString
//		UID and PWD parameters in the dbparm property of the trans object.
//		Prior to the change, the function set the UserID and DBPass properties.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_connectstring
string	ls_userid
string	ls_password
n_cst_string	lnv_string

// Get connect string value
ls_connectstring = lnv_string.of_getKeyValue (this.dbparm, "connectstring", ",")

if len (ls_connectstring) <= 0 then
	// No connectstring defined
	if len (this.dbparm) > 0 then
		ls_connectstring = ","
	end if
	ls_connectstring = ls_connectstring + "ConnectString='UID=" + as_userid + ";PWD=" + as_password + "'"
	this.dbparm = this.dbparm + ls_connectstring
else
	// Temporarily remove single quotes from connectstring
	ls_connectstring = lnv_string.of_globalReplace (ls_connectstring, "'", "")

	// Set User ID
	ls_userid = lnv_string.of_getKeyValue (ls_connectstring, "UID", ";")
	if len (ls_userid) > 0 then
		lnv_string.of_setKeyValue (ls_connectstring, "UID", as_userid, ";")
	else
		ls_connectstring = ls_connectstring + ";UID=" + as_userid
	end if
	
	// Set password
	ls_password = lnv_string.of_getKeyValue (ls_connectstring, "PWD", ";")
	if len (ls_password) > 0 then
		lnv_string.of_setKeyValue (ls_connectstring, "PWD", as_password, ";")
	else
		ls_connectstring = ls_connectstring + ";PWD=" + as_password
	end if
	
	// Restore single quotes
	ls_connectstring = "'" + ls_connectstring + "'"
	lnv_string.of_SetKeyValue (this.dbparm, "ConnectString", ls_connectstring, ",")
end if
end subroutine

public function long of_distinctvalues (string as_table, string as_column, ref string as_values[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DistinctValues
//
//	Access:  Public
//
//	Arguments:
//	as_table:  a SQL table name
//	as_column:  a database column name in passed SQL table
//	as_values:  string array, passed by reference to hold the returned values
//
//	Returns:  long
//	the SQLCode based on the SQL fetch
//
//	Description:  Get the distinct values from the database
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_rc
string	ls_sqlstatement
string	ls_value
string	ls_name

// Build the SQL Select statement
ls_sqlstatement = "SELECT DISTINCT " + as_column + " FROM " + as_table

// If SQLSpy service is on, add to the history
if IsValid (gnv_app) then
	if IsValid(gnv_app.inv_debug) then
		if IsValid (gnv_app.inv_debug.inv_sqlspy) then
			ls_name = this.is_name
			if Len (ls_name) = 0 then
				ls_name = this.ClassName()
			end if
			gnv_app.inv_debug.inv_sqlspy.of_SQLSyntax &
				("Dynamic SQL using " + ls_name, ls_sqlstatement)
		end if 
	end if
end if

// Execute the SQL
prepare sqlsa from :ls_sqlstatement using this;
describe sqlsa into sqlda;
declare c_values_cursor	dynamic cursor for sqlsa;
open dynamic c_values_cursor using descriptor sqlda;
fetch c_values_cursor using descriptor sqlda;
ll_rc = this.SQLCode

// Retrieve the distinct values and add them to the array
do while this.SQLCode = 0 
	choose case sqlda.OutParmType[1]
		case TypeString!
			ls_value = GetDynamicString (sqlda, 1)
		case TypeDate!
			ls_value = String (GetDynamicDate (sqlda, 1))
		case TypeTime!
			ls_value = String (GetDynamicTime (sqlda, 1))
		case TypeDateTime!
			ls_value = String (GetDynamicDateTime (sqlda, 1))
		case else
			ls_value = String (GetDynamicNumber (sqlda, 1))
	end choose

	as_values[UpperBound(as_values)+1] =  ls_value
	fetch c_values_cursor using descriptor sqlda;
	ll_rc = this.SQLCode
loop

close c_values_cursor;

return ll_rc
end function

public function long of_begin ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Begin
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//
//	Description:  Begin a transaction
//
//	Note:  This function should be implemented in
//	descendant DBMS transaction objects
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return -1
end function

public function long of_end ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_End
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  long
//
//	Description:  End a transaction
//
//	Note:  This function should be implemented in
//	descendant DBMS transaction objects
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return -1
end function

public function integer of_setautorollback (boolean ab_autorollback);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetAutoRollback
//
//	Access:  public
//
//	Arguments:
//	ab_trace   the desired autorollback property value.
//
//	Returns:  Integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the autorollback property
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Check argument
if IsNull (ab_autorollback) then
	return -1
end if

ib_autorollback = ab_autorollback
return 1

end function

protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_MessageBox
//
//	Access:  			protected
//
//	Arguments:
//	as_id			An ID for the Message.
//	as_title  	Text for title bar
//	as_text		Text for the actual message.
//	ae_icon 		The icon you want to display on the MessageBox.
//	ae_button	Set of CommandButtons you want to display on the MessageBox.
//	ai_default  The default button.
//
//	Returns:  integer
//	Return value of the MessageBox.
//
//	Description:
//	Display a PowerScript MessageBox.  
//	Allow PFC MessageBoxes to be manipulated prior to their actual display.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return MessageBox(as_title, as_text, ae_icon, ae_button, ai_default)
end function

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  destructor
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Removed conditional checking for sqlca before unregistering
//	   with the transaction registration service.  Check was not needed and 
//	   caused regeneration problems when other subclassed transaction objects
//	   (from transaction, not n_tr) were in the library search path.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// If still connected, determine whether to commit or rollback.
if of_IsConnected() then
	if ib_autorollback then
		of_Rollback()
	else
		of_Commit()
	end if
	of_Disconnect()
end if

// If transaction object is registered with the Transaction 
// Registration service, then unregister it
if IsValid (gnv_app) then
	if IsValid (gnv_app.inv_trregistration) then
		if gnv_app.inv_trregistration.of_IsRegistered (this) then
			gnv_app.inv_trregistration.of_Unregister (this)
		end if
	end if
end if


end event

on pfc_n_tr.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on pfc_n_tr.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

