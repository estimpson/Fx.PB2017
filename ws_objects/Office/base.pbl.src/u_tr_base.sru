$PBExportHeader$u_tr_base.sru
forward
global type u_tr_base from transaction
end type
end forward

global type u_tr_base from transaction
end type
global u_tr_base u_tr_base

type variables
STRING		platform
STRING		profile

BOOLEAN	i_b_use_registry = TRUE

end variables

forward prototypes
public function datetime uf_get_server_dt ()
public function character uf_get_asn_uop ()
public function string uf_get_shipper_destination (long a_l_shipper)
public function boolean uf_connect ()
public function long uf_rollback ()
public function long uf_commit ()
public function long uo_get_operator (ref string arg_password)
public function boolean of_getnextparmvalue (string as_parmcolumn, ref long al_returnvalue)
public function boolean of_getnextparmvalue (string as_parmcolumn, string as_checktable[], string as_checkcolumn[], ref long al_returnvalue)
public function integer of_getidlecommittime ()
public function string of_getmssqlversion ()
end prototypes

public function datetime uf_get_server_dt ();DATETIME	l_dt_sys_datetime

CHOOSE CASE LeftA ( platform, 1 )
	CASE "M"
		SELECT Max ( GetDate ( ) )
		  INTO :l_dt_sys_datetime
		  FROM parameters  ;
	CASE "W"
		SELECT Max ( Now ( * ) )
		  INTO :l_dt_sys_datetime
		  FROM systables  ;
END CHOOSE

Return l_dt_sys_datetime
end function

public function character uf_get_asn_uop ();CHAR	l_c_asn_uop

SELECT set_asn_uop
  INTO :l_c_asn_uop
  FROM parameters  ;

RETURN l_c_asn_uop
end function

public function string uf_get_shipper_destination (long a_l_shipper);STRING	l_s_destination

SELECT	destination
  INTO	:l_s_destination
  FROM	shipper
 WHERE	id = :a_l_shipper  ;

Return l_s_destination
end function

public function boolean uf_connect ();STRING	l_s_section
STRING	ls_profile

BOOLEAN	l_b_prompt

ls_profile = ProfileString ( monsys.root + "\Monitor.ini", "DBMS_PROFILES", "CURRENT", "MONITOR" )
l_s_section = "Profile " + ls_profile
l_b_prompt	= ( ProfileString ( "Monitor.ini", "DBMS_PROFILES", "PROMPT", "NO" ) = "YES" )

DBMS 				= ProfileString ( "Monitor.ini", l_s_section, "DBMS", "ODBC" )
IF DBMS = "ODBC" AND l_b_prompt THEN
	Open ( w_odbc_profile_select )
	if Message.StringParm > '' then
		ls_profile = Message.StringParm
		DBParm		= "connectstring='dsn=" + Message.StringParm + "'"
	else
		Return FALSE
	end if
ELSE
	DBParm 		= ProfileString ( "Monitor.ini", l_s_section, "DBParm", "connectstring='dsn=MONITOR" )
END IF
database 		= ProfileString ( "Monitor.ini", l_s_section, "database", "MONITOR" )
UserId 			= ProfileString ( "Monitor.ini", l_s_section, "UserId", "dba" )
DBPass			= ProfileString ( "Monitor.ini", l_s_section, "DatabasePassword", "sql" )
ServerName		= ProfileString ( "Monitor.ini", l_s_section, "ServerName", "<default>" )
LogId			= ProfileString ( "Monitor.ini", l_s_section, "LogId", "" )
LogPass			= ProfileString ( "Monitor.ini", l_s_section, "LogPassword", "" )

CONNECT ;

IF sqlcode <> 0 THEN
	MessageBox ( "System Error", "Unable to connect to specified database!  Please consult your system administrator to fix this problem.", StopSign! )
	Return FALSE
END IF

//	Included on 2/6/02 to automatically change the connectionstring in the ini file based
//	on whatever odbc profile they select
SetProfileString("Monitor.ini", "Database", "DBParm", DBParm)

platform = SQLReturnData

IF platform = 'Microsoft SQL Server' THEN
	if of_getmssqlversion ( ) = "Microsoft SQL Server 7.0" and monsys.dbplatform <> "Mssql7" then
		HALT CLOSE
	end if
	SQLCA.autocommit = True
	EXECUTE IMMEDIATE 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED';
	SQLCA.autocommit = False
END IF

profile = "  [" + ls_profile + "]"

Return TRUE
end function

public function long uf_rollback ();RollBack  ;
Return SQLCA.SQLCode
end function

public function long uf_commit ();Commit  ;
Return SQLCA.SQLCode
end function

public function long uo_get_operator (ref string arg_password);string ls_password
ls_password=arg_password
SELECT operator_code
  INTO :arg_password
  FROM employee
 WHERE (password = :ls_password) ;
if (SQLCA.SQLcode<>0) then arg_password='' 
Return (SQLCA.SQLcode)
end function

public function boolean of_getnextparmvalue (string as_parmcolumn, ref long al_returnvalue);//************************************************************************************//
// Function Name:	of_getnextparmvalue
//
// Description:	This function calls the overloaded function with the proper values.
//
// Syntax:			BOOL of_getnextparmvalue (	STRING	as_parmcolumn,
//															STRING	REF al_returnvalue )
//
// Where:			as_parmcolumn		The column in parameters table to get the next value for.
//						al_returnvalue		The next available value returned
//
// Returns Codes:	TRUE		Found a valid value
//						FALSE		Unable to find a valid value
//
//
//	Special Notes:
//		DO NOT turn auto commit on before calling this function
//
//************************************************************************************//
// Log of Changes:
// 01-25-2000 12:00:00		CBR		Original.
// 01-26-2000 11:00:00		GPH		Modified.
//	02-02-2000 11:30:00		CBR		Added ability to handle multiple check tables and
//												added next_issue argument.
//************************************************************************************//
//	Flow:
// 1.	declarations
// 2.	initializations
// 3.	return results of function call
//************************************************************************************//

// 1.	declarations
string	ls_table[]
string	ls_column[]

// 2.	initializations
choose case as_parmcolumn
	Case 	"next_serial"
		ls_table[1] = "object"
		ls_column[1] = "serial"
		ls_table[2] = "audit_trail"
		ls_column[2] = "serial"

	Case  "shipper"
		ls_table[1] = "shipper"
		ls_column[1] = "id"

	Case	"sales_order"
		ls_table[1] = "order_header"
		ls_column[1] = "order_no"

	Case "purchase_order"
		ls_table[1] = "po_header"
		ls_column[1] = "po_number"

	Case "next_invoice"
		ls_table[1] = "shipper"
		ls_column[1] = "invoice_number"

	Case "bol_number"
		ls_table[1] = "bill_of_lading"
		ls_column[1] = "bol_number"

	Case 	"next_workorder"
		ls_table[1] = "work_order"
		ls_column[1] = "convert(integer,work_order)"

	Case "next_issue"
		ls_table[1] = "issues"
		ls_column[1] = "issue_number"
		
end choose

// 3.	return results of function call
return of_getnextparmvalue ( as_parmcolumn, ls_table, ls_column, al_returnvalue )

end function

public function boolean of_getnextparmvalue (string as_parmcolumn, string as_checktable[], string as_checkcolumn[], ref long al_returnvalue);//************************************************************************************//
// Function Name:	of_getnextparmvalue
//
// Description:	This function gets the next value from parameters table and returns
//						it to the calling object after verifying that it's not in use.
//
// Syntax:			BOOL of_getnextparmvalue (	STRING	as_parmcolumn,
//															STRING	as_checktable[],
//															STRING	as_checkcolumn[],
//															STRING	REF al_returnvalue )
//
// Where:			as_parmcolumn		The column in parameters table to get the next value for.
//						as_checktable[]	The tables to check if the value is being used.
//						as_checkcolumn[]	The columns to check if the value is being used.
//						al_returnvalue		The next available value returned
//
// Returns Codes:	TRUE		Found a valid value
//						FALSE		Unable to find a valid value
//
//
//	Special Notes:
//		DO NOT turn auto commit on before calling this function
//
//************************************************************************************//
// Log of Changes:
// 01-25-2000 12:00:00		CBR		Original.
// 01-26-2000 11:00:00		GPH		Modified.
//	02-02-2000 11:30:00		CBR		Got rid of modifications from GPH by standardizing and
//												added the ability to handle multiple check tables.
//************************************************************************************//
//	Flow:
//	1.	declarations
// 2.	initializations
// 3.	construct update statement to lock parm row and execute
// 4.	check for errors in update and if so let calling object know
// 5.	get next available value
// 6.	check for errors in update and if so let calling object know
// 7.	loop until an unused value is found
// 8.	construct statement to see if value exists and execute
// 9.	construct update statement to return next value to parameters table and execute
// 10.	check for errors in update and if so let calling object know
// 11.	return success to calling object
//************************************************************************************//

//	1.	declarations
string	ls_statement
boolean	lb_sqlerror
integer	li_validvalue
integer	li_index

declare value dynamic cursor for sqlsa ;

// 2.	initializations
lb_sqlerror = FALSE

// 3.	construct update statement to lock parm row and execute
ls_statement = "update parameters set " + as_parmcolumn + " = " + as_parmcolumn + " + 1"
execute immediate :ls_statement ;

// 4.	check for errors in update and if so let calling object know
if sqlca.sqlcode <> 0 then
	return false
end if

// 5.	get next available value
ls_statement = "select " + as_parmcolumn + " - 1 from parameters"
prepare sqlsa from :ls_statement ;
open dynamic value ;
fetch value into :al_returnvalue ;
lb_sqlerror = NOT ( sqlca.sqlcode = 0 )
close value ;

// 6.	check for errors in update and if so let calling object know
if lb_sqlerror then
	return false
end if

// 7.	loop until an unused value is found
do while NOT lb_sqlerror
// 8.	construct statement to see if value exists and execute
	for li_index = 1 to UpperBound ( as_checktable )
		if NOT lb_sqlerror then
			ls_statement = "select 1 from " + as_checktable[li_index] + " where " + as_checkcolumn[li_index] + " = " + String ( al_returnvalue )
			prepare sqlsa from :ls_statement ;
			open dynamic value ;
			fetch value into :li_validvalue ;
			lb_sqlerror = NOT ( sqlca.sqlcode = 0 )
			close value ;
		end if
	next
	if NOT lb_sqlerror then
		al_returnvalue++
	end if
loop

// 9.	construct update statement to return next value to parameters table and execute
ls_statement = "update parameters set " + as_parmcolumn + " = " + String ( al_returnvalue ) + " + 1"
execute immediate :ls_statement ;

// 10.	check for errors in update and if so let calling object know
if sqlca.sqlcode <> 0 then
	return false
end if

// 11.	return success to calling object
return true

end function

public function integer of_getidlecommittime ();Return isnull(ProfileInt ( "monitor.ini", "IdleCommit", "Minutes", 0 ), 0 )
end function

public function string of_getmssqlversion ();string Stringvar, Sqlstatement
integer Intvar
Sqlstatement = "SELECT @@version from parameters"
PREPARE SQLSA FROM :Sqlstatement ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC my_cursor USING DESCRIPTOR SQLDA ;
FETCH my_cursor USING DESCRIPTOR SQLDA ;
Stringvar = GetDynamicString(SQLDA, 1)
CLOSE my_cursor ;

return LeftA ( Stringvar, 25 )
end function

on u_tr_base.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on u_tr_base.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

event destructor;//DISCONNECT  ;
end event

