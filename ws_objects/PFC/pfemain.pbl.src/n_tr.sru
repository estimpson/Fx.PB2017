$PBExportHeader$n_tr.sru
$PBExportComments$Extension Transaction class
forward
global type n_tr from pfc_n_tr
end type
end forward

global type n_tr from pfc_n_tr
event type integer pfc_connect ( string connectionname )
end type
global n_tr n_tr

type variables

constant integer	FAILURE = -1, SUCCESS = 1, DBSUCCESS = 0

string	platform
string	is_Profile

boolean	ib_UseRegistry = True

n_cst_registry	inv_Reg

//	Public.
Public:

boolean	PPrompt = false
boolean	TPrompt = false

constant integer	USEUNDEFINED = 0
constant integer	USEINI = 1
constant integer	USEUSERREG = 2
constant integer	USEAPPREG = 3
constant integer	SQLSUCCESS = 0
constant integer	SQLNOROWS = 100

constant integer	ODBCSQLCONNECTOR = 1
constant integer	OLESQLCONNECTOR = 2
constant integer	ADOSQLCONNECTOR = 3

integer	ii_Connect = USEUNDEFINED
integer	ii_SQLConnector

string	is_INISection = "Database"

string	MONErrText

end variables

forward prototypes
public function datetime uf_get_server_dt ()
public function character uf_get_asn_uop ()
public function string uf_get_shipper_destination (long a_l_shipper)
public function long uf_rollback ()
public function long uf_commit ()
public function long uo_get_operator (ref string arg_password)
public function boolean of_getnextparmvalue (string as_parmcolumn, ref long al_returnvalue)
public function boolean of_getnextparmvalue (string as_parmcolumn, string as_checktable[], string as_checkcolumn[], ref long al_returnvalue)
public function integer of_getidlecommittime ()
public function string of_getmssqlversion ()
public function integer of_oldconnect (string connectionname)
public function integer of_reconnect ()
public function integer updateprinted (string _name, long _identifier)
public function integer uf_modify_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_remove_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_add_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level)
public function integer uf_get_prod_grid_rows (ref long a_l_rows)
public function integer of_get_product_line_for_part (string as_part, ref string as_product_line)
public function integer of_get_next_issue_number (ref long al_issue_number)
public function integer of_get_defaults_for_issue (ref string as_category, ref string as_sub_category, ref string as_status)
public function integer of_calculate_multicurrency_price (string as_from, string as_to, decimal adec_price, ref decimal adec_calc_price)
public function integer of_get_currency_display_symbol (string as_currency, ref string as_symbol)
public function integer of_get_currency_unit (string as_customer, string as_vendor, string as_destination, long al_order, long al_po, long al_invoice, ref string as_units[], ref integer ai_show_euro[])
public function integer of_creatermaobject (datastore ads_objectinfo)
public function integer of_createaudittrail (ref datastore ads_audittrailinfo)
public function integer of_delete_rma (long al_shipper, string as_part)
public function integer of_createcreditmemo (long al_rma, string as_operator, ref long al_invoice)
public function boolean of_deletestagedshipper (long al_shipper)
public function boolean of_customerpoexists (string as_customerpo, string as_destination)
public function string of_getprimarylocation (string as_part)
public function decimal of_customerstandardpack (string as_customer, string as_part, string as_unit)
public function integer of_get_ship_dest_pool_and_type (long al_shipper, ref string as_destination, ref string as_type, ref string as_pool_code)
public function integer of_get_bol_dest_pool_and_type (long al_bol_number, ref string as_destination, ref string as_type, ref string as_pool_code)
public function long of_checkshipper (long al_shipper)
public function long of_updatekanbaninfo (long al_shipper)
public function long of_setbolprintedstatus (long al_shipper, string as_status)
public function long of_shipout (long al_shipper, string as_pronumber, string as_trucknumber, string as_operator, ref long al_invoice, datetime adt_dateshipped)
end prototypes

event type integer pfc_connect(string connectionname);
//	Get the default profile.
n_ds dsDefaultProfile
dsDefaultProfile = create n_ds
dsDefaultProfile.DataObject = "d_conn_defaultprofile"
dsDefaultProfile.ImportFile("ConnDefaultProfile.txt")
if	dsDefaultProfile.RowCount() < 1 then
	dsDefaultProfile.InsertRow(0)
	dsDefaultProfile.object.DBMS[1] = "MSS"
	dsDefaultProfile.object.Provider[1] = "SQLNCLI10"
end if
string	profileName
profileName = dsDefaultProfile.object.DefaultProfile[1]
dbms = dsDefaultProfile.object.DBMS[1]

//	Find the specified profile.
n_ds dsProfiles
dsProfiles = create n_ds
dsProfiles.DataObject = "d_conn_profiles"
dsProfiles.ImportFile("ConnProfiles.txt")
dsProfiles.SetFilter("profilename=~"" + profileName + "~"")
dsProfiles.Filter()

//	If the default profile is not valid, prompt the user.
if IsNull(profileName, "") = "" or dsProfiles.RowCount() < 1 or dsDefaultProfile.object.Prompt[1] = 1 or KeyDown(KeyBackQuote!) then
	//	Make sure the splash screen isn't showing.
	do while IsValid(w_splash)
		Yield()
	loop
	OpenWithParm(w_databaseprofiles, ConnectionName)
	if not IsValid(Message.PowerObjectParm) then
		return FAILURE
	end if
	n_cst_associative_array	args
	args = Message.PowerObjectParm
	dbms = args.of_GetItem("dbms")
	profileName = args.of_GetItem("profile")
	dsProfiles.DataObject = "d_conn_profiles"
	dsProfiles.ImportFile("ConnProfiles.txt")
	dsProfiles.SetFilter("profilename=~"" + profileName + "~"")
	dsProfiles.Filter()
	if	dsProfiles.RowCount() < 1 then
		MessageBox("Database", "Unable to connect to " + profileName + " database!  Profile not found.")
	end if
end if

//	Get details for connection with the designated profile.
if	dbms = "MSS" then
	//	Refactor to functions...
	DBMS = "OLE DB"
	LogId = dsProfiles.Object.LogId[1]
	LogPass = dsProfiles.Object.Password[1]
	Lock = "RU"
	AutoCommit = (dsProfiles.Object.AutoCommit[1] = 1)
	DBParm = "PROVIDER='" + dsDefaultProfile.object.Provider[1] + "',DATASOURCE='" + dsProfiles.Object.ServerName[1] + "',PROVIDERSTRING='database=" + dsProfiles.Object.Database[1] + "'"

	if	dsProfiles.Object.IntegratedSecurity[1] = 1 then
		DBParm += ",INTEGRATEDSECURITY='SSPI'"
	end if
else
	DBMS = "ODBC"
	DBParm = "ConnectString='DSN=" + profileName + "'"
end if
destroy dsDefaultProfile
destroy dsProfiles

//	Attempt db connection.
if	of_Connect() <> DBSUCCESS then
	MessageBox("Database", "Unable to connect to " + profileName + " database!  " + SQLCA.SQLErrText)
	return FAILURE
end if
is_Profile = profileName

//	Turn off ansi warnings
execute immediate "set ansi_warnings off";

//	Connection established.
return SUCCESS

end event

public function datetime uf_get_server_dt ();DATETIME	l_dt_sys_datetime

CHOOSE CASE Left ( platform, 1 )
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

return Left ( Stringvar, 25 )
end function

public function integer of_oldconnect (string connectionname);
//	Local variables
ulong	lul_IntegratedSecurity
ulong	lul_AutoCommit
string	ls_Profile
string	ls_DBMS
string Provider
n_cst_associative_array	lnv_Args

//	If the registry settings don't exist, set them up.
inv_Reg.of_CheckDBRegSettings ( ConnectionName )

//	Get the default profile.
inv_Reg.of_GetDefaultProfile ( ConnectionName, ls_Profile, ls_DBMS )

//	If the default profile is not valid, prompt the user.
if IsNull ( ls_Profile, '' ) = '' or inv_Reg.of_GetDBPrompt ( ConnectionName ) or KeyDown ( KeyBackQuote! ) then
	//	Make sure the splash screen isn't showing.
	do while IsValid ( w_splash )
		Yield ( )
	loop
	OpenWithParm ( w_databaseprofiles, ConnectionName )
	if not IsValid ( Message.PowerObjectParm ) then
		return FAILURE
	end if
	lnv_Args = Message.PowerObjectParm
	dbms = lnv_Args.of_GetItem ( "dbms" )
	ls_Profile = lnv_Args.of_GetItem ( "profile" )
	if dbms = "MSS" then
		ServerName = lnv_Args.of_GetItem ( "servername" )
		Database = lnv_Args.of_GetItem ( "database" )
		LogId = lnv_Args.of_GetItem ( "logid" )
		LogPass = lnv_Args.of_GetItem ( "logpass" )
		AutoCommit = lnv_Args.of_GetItem ( "autocommit" )
		if lnv_Args.of_GetItem ( "integratedsecurity" ) then
			dbparm = "Secure=1"
		end if
	else
		dbparm = lnv_Args.of_GetItem ( "dbparm" )
	end if
else
	if ls_DBMS = "MSS" then
		dbms = "MSS"
		inv_Reg.of_GetSQLServerProfileSettings ( ConnectionName, ls_Profile, Provider, ServerName, Database, LogId, LogPass, lul_IntegratedSecurity, lul_AutoCommit )
		if lul_IntegratedSecurity = 1 then
			dbparm = "Secure=1"
		end if
		AutoCommit = ( lul_AutoCommit = 1 )
	else
		dbms = "ODBC"
		dbparm = "ConnectString='DSN=" + ls_Profile + "'"
	end if
end if

//	Attempt db connection.
if of_Connect ( ) <> DBSUCCESS then
	MessageBox ( "Database", "Unable to connect to database!" )
	return FAILURE
end if
is_Profile = ls_Profile

//	Connection established.
return SUCCESS

end function

public function integer of_reconnect ();
//	Close previous connection.
of_Disconnect ()

//	Reconnect.
if of_Connect () = 0 then
	//	Notify of reconnect.
	n_cst_associative_array lnv_Connect
	lnv_Connect.of_SetItem ("Connect", 1)
	gnv_App.inv_StateMsgRouter.of_Broadcast (lnv_Connect)
	return 0
else
	return -1
end if

return -1

end function

public function integer updateprinted (string _name, long _identifier);
//	Declarations.
integer	returnValue = FAILURE

//	Depending on mode, set appropriate flag.
choose case _name
	case "invoice"
		
		update	shipper
		set	invoice_printed = 'Y'
		where	invoice_number = :_identifier using this  ;
		
	case "po"
		
		update	po_detail
		set	printed = 'Y'
		where	po_number = :_identifier using this  ;
		
	case "packlist"
		
		update	shipper
		set	printed = 'Y'
		where	id = :_identifier using this  ;
		
	case "picklist"
		
		update	shipper
		set	picklist_printed = 'Y'
		where	id = :_identifier using this  ;
		
	case "billoflading"
		
		update	bill_of_lading
		set	printed = 'Y'
		from	shipper
		where	bol_number = bill_of_lading_number and
			id = :_identifier using this  ;
		
	case "label"
		
		update	object
		set	lastprint = GetDate ( )
		where	serial = :_identifier using this  ;
end choose

//	If there was a SQL error then return that result.
returnValue = sqlca.sqlcode
if returnValue <> SQLSUCCESS then
	of_Rollback ( )
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Unable to set printed flag.  " + sqlca.sqlerrtext )
else
	of_Commit ( )
end if

return returnValue

end function

public function integer uf_modify_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  UPDATE	effective_change_notice
     SET	operator = :a_s_operator,
			notes = :a_s_notes,
			engineering_level = :a_s_engineering_level
  WHERE	:a_s_part = part AND
  			:a_dt_effective_date = effective_date  ;

Return SQLCA.SQLCode
end function

public function integer uf_remove_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  DELETE	effective_change_notice
  WHERE	:a_s_part = part AND
  			:a_dt_effective_date = effective_date AND
			:a_s_operator = operator AND
			:a_s_notes = notes AND
			:a_s_engineering_level = engineering_level  ;

Return SQLCA.SQLCode
end function

public function integer uf_add_ecc (string a_s_part, datetime a_dt_effective_date, string a_s_operator, string a_s_notes, string a_s_engineering_level);  INSERT	effective_change_notice
  VALUES	( :a_s_part, :a_dt_effective_date, :a_s_operator, :a_s_notes, :a_s_engineering_level )  ;

Return SQLCA.SQLCode
end function

public function integer uf_get_prod_grid_rows (ref long a_l_rows);select	count ( * )
into	:a_l_rows
from	master_prod_sched  ;

return SQLCA.SQLCode
end function

public function integer of_get_product_line_for_part (string as_part, ref string as_product_line);select	product_line
into		:as_product_line
from		part
where		part = :as_part ;

return sqlca.sqlcode
end function

public function integer of_get_next_issue_number (ref long al_issue_number);boolean	lb_done
int		li_count,&
			li_return = 0

do while not lb_done
	select	next_issue
	into		:al_issue_number
	from		parameters ;

	update	parameters
	set		next_issue = :al_issue_number + 1 ;
	
	if sqlca.sqlcode <> 0 then
		li_return = 1
		lb_done = TRUE
	else	
		select	count(*)
		into		:li_count
		from		issues
		where		issue_number = :al_issue_number ;
		
		if li_count < 1 then 
			lb_done = TRUE
			commit ;
		end if
	end if
loop

return li_return
end function

public function integer of_get_defaults_for_issue (ref string as_category, ref string as_sub_category, ref string as_status);SELECT	issues_category.category  
INTO 		:as_category  
FROM 		issues_category  
WHERE 	issues_category.default_value = 'Y'   ;

SELECT 	issues_status.status  
INTO 		:as_status  
FROM 		issues_status  
WHERE 	issues_status.default_value = 'Y'   ;

SELECT 	issues_sub_category.sub_category  
INTO 		:as_sub_category  
FROM 		issues_sub_category  
WHERE 	issues_sub_category.default_value = 'Y'   ;

return 1
end function

public function integer of_calculate_multicurrency_price (string as_from, string as_to, decimal adec_price, ref decimal adec_calc_price);dec {6}	ldec_rate1,&
			ldec_rate2
string	ls_base_currency

select	base_currency
into		:ls_base_currency
from		parameters ;

if Isnull ( as_from,'' ) = '' then
	as_from = ls_base_currency
end if

if Isnull ( as_to, '' ) = '' then
	as_to = ls_base_currency
end if

if as_from = as_to then
	
	adec_calc_price = adec_price
	
else
	
	select	rate 
	into		:ldec_rate1 
	from		currency_conversion 
	where		effective_date = (	select	max (effective_date) 
											from		currency_conversion cc 
											where		effective_date < GetDate ( ) and 
														currency_code = :as_from ) and 
				currency_code = :as_from ;
				
	if ldec_rate1 = 0 then ldec_rate1 = 1
	
	adec_calc_price = adec_price * isnull(ldec_rate1,1)

	select	rate 
	into		:ldec_rate2 
	from		currency_conversion 
	where		effective_date = (	select	max (effective_date) 
											from		currency_conversion cc 
											where		effective_date < GetDate ( ) and 
														currency_code = :as_to ) and 
				currency_code = :as_to ;
				
	if ldec_rate2 = 0 then ldec_rate2 = 1

	adec_calc_price = adec_calc_price / isnull(ldec_rate2,1)
		
end if

return 0
end function

public function integer of_get_currency_display_symbol (string as_currency, ref string as_symbol);select	currency_display_symbol
into		:as_symbol
from		currency_conversion
where		currency_code = :as_currency ;

return sqlca.sqlcode

end function

public function integer of_get_currency_unit (string as_customer, string as_vendor, string as_destination, long al_order, long al_po, long al_invoice, ref string as_units[], ref integer ai_show_euro[]);int	li_index

if isnull(as_customer,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		customer
	where		customer = :as_customer ;
end if

if isnull(as_vendor,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		vendor
	where		code = :as_vendor ;
end if

if isnull(as_destination,'') > '' then
	li_index++
	select	default_currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		destination
	where		destination = :as_destination ;
end if

if isnull(al_order,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		order_header
	where		order_no = :al_order ;
end if

if isnull(al_po,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]
	from		po_header
	where		po_number = :al_po ;
end if

if isnull(al_invoice,0) > 0 then
	li_index++
	select	currency_unit,
				show_euro_amount
	into		:as_units[li_index],
				:ai_show_euro[li_index]

	from		shipper
	where		invoice_number = :al_invoice ;
end if

if li_index = 0 then
	li_index++
	select	base_currency
	into		:as_units[li_index]
	from		parameters ;
	ai_show_euro[1] = 1
end if

return 0

end function

public function integer of_creatermaobject (datastore ads_objectinfo);//************************************************************************************//
// Function Name:	of_creatermaobject
//
// Description:	This function initializes the datastores to create object and audit trail rows.
//						Calls the create object and audit trail services..
//
// Syntax:			LONG of_create	(	ads_objectinfo datastore by reference )
//
// Where:		   ads_objectinfo is the datastore that has all default values to create object 
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the object  
//
// Log of Changes:
// MB 06-01-1999 10:11:00  Original.
//************************************************************************************//

constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

datastore lds_objectinfo

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if IsValid ( ads_objectinfo ) then
	
	if ads_objectinfo.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		//	create updateable datastore to create new serial
		lds_objectinfo = create datastore
		lds_objectinfo.dataobject = 'd_object_info'
		lds_objectinfo.settransobject ( sqlca )
		
		//	copy the object info to the updateable datastore
		if ads_objectinfo.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_objectinfo, BEGINROW, Primary! ) = 1 THEN
			if lds_objectinfo.update() > 0 then				
				li_returnvalue = 0
			else
				li_returnvalue = -1
			end if
		end if
			
		destroy lds_objectinfo
			
	end if
	
end if

//  return
return li_returnvalue
end function

public function integer of_createaudittrail (ref datastore ads_audittrailinfo);//************************************************************************************//
// Function Name:	of_CreateAuditTrail
//
// Description:	This function create audit trail entries for the serial number being passed
//
// Syntax:			LONG of_create	(	DATASTORE *	ads_audittrailinfo )
//
// Where:			ads_audittrailinfo - datastore that has all the initial values for audit trail row
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the audit trail enty.  
//
// Log of Changes:
// MB 06-01-1999 12:34:00 Original.
//************************************************************************************//

constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

datastore lds_audit_trail_info

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if IsValid ( ads_audittrailinfo ) then

	if ads_audittrailinfo.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		lds_audit_trail_info = create datastore
		lds_audit_trail_info.dataobject = 'd_audit_trail_info'
		lds_audit_trail_info.settransobject ( sqlca )

		//	copy the object info to the updateable datastore
		if ads_audittrailinfo.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_audit_trail_info, BEGINROW, Primary! ) = 1 THEN
			if lds_audit_trail_info.update() > 0 then
				commit ;
				li_returnvalue = 0
			else
				rollback ;
				li_returnvalue = -1
			end if
		end if
		
		destroy lds_audit_trail_info
			
	end if
end if

//  return
return li_returnvalue


end function

public function integer of_delete_rma (long al_shipper, string as_part);// declare local variables
integer		li_count
string		ls_message

// check the detail to make sure no objects have been received against it.
if as_part > '' then
	select	count ( shipper )
	into		:li_count
	from		shipper_detail
	where		shipper = :al_shipper and
				part = :as_part and
				qty_packed < 0 ;
	ls_message = "Are you sure about deleting this RMA?"
else
	select	count ( shipper )
	into		:li_count
	from		shipper_detail
	where		shipper = :al_shipper and
				qty_packed < 0 ;
	ls_message = "Are you sure about deleting this RMA?  (All detail items will be deleted also)."
end if

			
if li_count > 0 then
	MessageBox ( monsys.msg_title, "You can only delete RMA's that haven't been received against!", Information! )
	return 0
else
	Choose Case MessageBox ( monsys.msg_title, ls_message, Question!, YesNo!, 2 )
		Case 1
			if as_part > '' then
				delete from shipper_detail
				where shipper = :al_shipper and
						part = :as_part ;

				if sqlca.sqlcode = 0 then
					commit ;
				else
					rollback;
					MessageBox ( monsys.msg_title, "Unable to delete RMA detail!", StopSign! )
					return 0
				end if
			else
//	Commented the below line to retain the detail items, for history purposes				
//				delete from shipper_detail
//				where shipper = :al_shipper ;
//
				if sqlca.sqlcode = 0 then
//	Changed the below statement from delete to update, as we don't want to get rid 
//	of the shipper
//					delete from shipper
//					where id = :al_shipper ;

					update	shipper
					set	status = 'E'
					where id = :al_shipper ;
					
					if sqlca.sqlcode = 0 then
						commit ;
					else
						rollback;
						MessageBox ( monsys.msg_title, "Unable to delete RMA header!", StopSign! )
						return 0
					end if
				else
					rollback;
					MessageBox ( monsys.msg_title, "Unable to delete RMA detail!", StopSign! )
					return 0
				end if
			end if
		Case Else
			return 0
	End Choose
end if

return 1
end function

public function integer of_createcreditmemo (long al_rma, string as_operator, ref long al_invoice);//************************************************************************************//
// Function Name:	of_createcreditmemo
//
// Description:	This function creates a credit memo for a particular rma shipper 
//
// Syntax:			LONG of_createcreditmemo ( al_rma long by value, 
//															as_operator string by value 
//															al_invoice long by reference )
//						
// Where:		   al_rma is the shipper for which credit memo needs to be created
//						as_operator is the operator trying to create the credit memo.
//						al_invoice  is the invoice number that will be returned from the stored proc
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which 
//						create the object  
//
// Log of Changes:
// MB 06-17-1999 11:36:00  Original.
//	MB 07-07-1999 modified, included the operator code.
//	MB 07-19-1999 modified, included invoice number argument.
//************************************************************************************//

integer	li_returnvalue

datastore lds_creditmemo

//	create updateable datastore to create credit memo ( invoice )
lds_creditmemo = create datastore
lds_creditmemo.dataobject = 'd_msp_credit_memo'
lds_creditmemo.settransobject ( sqlca )

// make sure datastore sent is valid
SetNull ( li_returnvalue )

if lds_creditmemo.Retrieve ( al_rma, as_operator, al_invoice ) > 0 then
	li_returnvalue = lds_creditmemo.object.result [1]
	al_invoice		= lds_creditmemo.object.invoice_number [1]
	if li_returnvalue = 0 then 
		commit ;
	else
		rollback ;
	end if
else
	li_returnvalue = -1
end if

destroy lds_creditmemo ;

//  return
return li_returnvalue
end function

public function boolean of_deletestagedshipper (long al_shipper);update	object
set	shipper = null,
	show_on_shipper = 'N',
	kanban_number = ''
where	shipper = :al_shipper ;

if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to update object.", StopSign! )
	return false
end if

delete from shipper_container
where shipper = :al_shipper ;
	
if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to delete shipper containers.", StopSign! )
	return false
end if

delete from shipper_detail
where shipper = :al_shipper ;
	
if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to delete shipper detail.", StopSign! )
	return false
end if

update 	shipper
set	status = 'E'
where	id = :al_shipper ;

if sqlca.sqlcode <> 0 then
	Rollback;
	MessageBox ( monsys.msg_title, "Unable to delete staged shipper!  Reason: Unable to update shipper.", StopSign! )
	return false
end if

Commit;
return true
end function

public function boolean of_customerpoexists (string as_customerpo, string as_destination);integer	li_count

select	count(order_no)
into	:li_count
from	order_header
where	customer_po = :as_customerpo and
	destination = :as_destination ;

return ( isnull(li_count,0) > 0 )
end function

public function string of_getprimarylocation (string as_part);string	ls_location

select	primary_location
into	:ls_location
from	part_inventory
where	part = :as_part ;

return isnull(ls_location,'')
end function

public function decimal of_customerstandardpack (string as_customer, string as_part, string as_unit);// function:		of_customerstandardpack
// description:	gets the standard pack for the customer / part starting at the part_customer
//						level and ending up at the part_inventory level if none is found.
//	arguments:		as_customer		customer code
//						as_part			part number
//						as_unit			ordered unit
//	returns:			decimal			standard pack quantity
// changes (date user notes)
// 3/31/00	cbr	created

// declare local variables
decimal	ldec_stdpack
string	ls_unit

// get standard pack and unit from part customer table
select	customer_standard_pack,
			customer_unit
into		:ldec_stdpack,
			:ls_unit
from		part_customer
where		customer = :as_customer and
			part = :as_part ;

// if record doesn't exist or standard pack is 0 get from part_inventory
if isnull ( ldec_stdpack, 0 ) <= 0 then
	select	standard_pack,
				standard_unit
	into		:ldec_stdpack,
				:ls_unit
	from		part_inventory
	where		part = :as_part ;
end if

// convert standard pack quantity to ordered unit
ldec_stdpack = f_convert_units ( ls_unit, as_unit, as_part, isnull(ldec_stdpack,0) )

// set to zero if less than zero
if isnull(ldec_stdpack,0) <= 0 then
	ldec_stdpack = 0
end if

// return the standard pack quantity
return ldec_stdpack

end function

public function integer of_get_ship_dest_pool_and_type (long al_shipper, ref string as_destination, ref string as_type, ref string as_pool_code);int	li_sqlcode

select	shipper.destination,
			destination.type
into		:as_destination,
			:as_type
from		shipper,
			destination
where		shipper.destination = destination.destination and
			shipper.id = :al_shipper ;

li_sqlcode = sqlca.sqlcode

select	pool_code
into		:as_pool_code
from		edi_setups
where		destination = :as_destination  ;
  
return li_sqlcode
end function

public function integer of_get_bol_dest_pool_and_type (long al_bol_number, ref string as_destination, ref string as_type, ref string as_pool_code);int		li_sqlcode

SELECT	bill_of_lading.destination,   
			destination.type  
INTO 		:as_destination,   
			:as_type  
FROM 		bill_of_lading,   
			destination  
WHERE 	bill_of_lading.destination = destination.destination and  
			bill_of_lading.bol_number = :al_bol_number    ;

li_sqlcode = sqlca.sqlcode

select	pool_code
into		:as_pool_code
from		edi_setups
where		destination = :as_destination ;

return li_sqlcode
end function

public function long of_checkshipper (long al_shipper);//************************************************************************************//
// Function Name:	of_checkshipper
//
// Description:	This function checks whether it's ready for ship outs
//
// 'Returns Codes:	Returns 0, 100, -1, -2, -3, -4, -5
//
// Log of Changes:  GPH 03-23-1999 11:15.00 Original.
//************************************************************************************//

// declare local variables
datastore	lds_Shipper
long        ll_result
string      ls_message
// create datastore
lds_Shipper = create datastore
lds_Shipper.DataObject = "d_msp_checkshipper"
lds_Shipper.SetTransObject ( sqlca )
lds_Shipper.Retrieve ( al_shipper )
if lds_shipper.rowcount() > 0 then 
	// get the result & validate
	ll_result = lds_Shipper.GetItemNumber ( 1, "result" )
	if ll_result <> 0 then
		Choose Case ll_result
			Case 100
					ls_message = "Invalid Shipper - " + string(al_shipper)			
			Case -1
					ls_message = "Status is not Approved for shipper - "+ string(al_shipper)
			Case -2
					ls_message = "Shipper - " + string(al_shipper)+" is Closed by another user"		
			Case -3
					ls_message = "Shipper - " + string(al_shipper) + " is not Staged"		
			Case -4
					ls_message = "Pack List is not printed for shipper - " + string(al_shipper)
			Case -5
					ls_message = "Bill of Lading is not printed for shipper - "	 + string(al_shipper)	
		End Choose
		Messagebox(monsys.msg_title,ls_message)
	end if 
else
	ll_result = -6
end if 	
// destroy datastore
destroy lds_Shipper
// return value
Return ll_result

end function

public function long of_updatekanbaninfo (long al_shipper);//************************************************************************************//
// Function Name:	of_updatekanbaninfo
//
// Description:	This function calls the kanban updation procedure through a dw
//
// Returns Codes:	Returns 0
//
// Log of Changes:  GPH 04-08-1999 16:31.00 Original.
//************************************************************************************//
// declare local variables
datastore	lds_kanbanrows
long        ll_result=0
long        ll_object_serial
long        ll_row
integer     li_rtn_code        
string      ls_message
string      ls_kanban_number
string      ls_kanban_status
string      ls_label
st_generic_structure lst_parm
// create datastore
lds_kanbanrows = create datastore
lds_kanbanrows.DataObject = "d_msp_update_kanban_info"
lds_kanbanrows.SetTransObject ( sqlca )
lds_kanbanrows.Retrieve ( al_shipper )
// if any rows are retrieved, process one by one
if lds_kanbanrows.rowcount() > 0 then 
	For ll_row = 1 to lds_kanbanrows.rowcount() 
 	    ls_kanban_number = lds_kanbanrows.object.#1 [ll_row]
	    ls_kanban_status = lds_kanbanrows.object.#2 [ll_row]
       ll_object_serial = lds_kanbanrows.object.#3 [ll_row]
	    ls_label         = lds_kanbanrows.object.#4 [ll_row]		 
 	    If ls_kanban_status = 'U' then 
 		    li_rtn_code = MessageBox ( monsys.msg_title, "The kanban label for the kanban number  ~r" + &
                                      ls_kanban_number + "has not been printed.  ~rWould you" + &
                                     "like to print it now?", Question!, YesNo! , 2 )
          If li_rtn_code = 1 then
					lst_parm.value1 = string(ll_object_serial)
					f_print_label ( lst_parm ) 
					li_rtn_Code = 2
          End If
       End if
		 // if printed delete the  row from kanban table
       If ls_kanban_status = 'X' or  ( ls_kanban_status = 'U' and li_Rtn_Code = 2 ) then
			 DELETE 
			   FROM kanban
			  WHERE (kanban_number = :ls_kanban_number) ;
			 // verify success status  
			 If (sqlca.sqlcode = 0) then
             commit ;
			 else
				 rollback ;
  			 end if  	 
	    End If
 	Next
End if 	
ll_result = 0 
// destroy datastore
destroy lds_kanbanrows
// return value
Return ll_result

end function

public function long of_setbolprintedstatus (long al_shipper, string as_status);long	ll_bol

select	bill_of_lading_number
into		:ll_bol
from		shipper
where		id = :al_shipper ;

if sqlca.sqlcode = 0 then
	update	bill_of_lading
	set		printed = :as_status
	where		bol_number = :ll_bol ;
end if

return sqlca.sqlcode
end function

public function long of_shipout (long al_shipper, string as_pronumber, string as_trucknumber, string as_operator, ref long al_invoice, datetime adt_dateshipped);declare ShipOut procedure for
msp_shipout :al_Shipper, :adt_dateshipped;

//	Set the operator code for the shipout and the truck pro number and truck number.
update	shipper
set	pro_number = :as_ProNumber,
		truck_number = :as_TruckNumber
where	id = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to set pro number while performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

update	shipper_detail
set	operator = :as_Operator
where	shipper = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to set operator while performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

//	Execute shipout.
execute ShipOut  ;

if SQLCode <> 0 then
	MONErrText = "Unable to execute msp_shipout while performing ShipOut.~r~n~r~n" + sqlerrtext
	close shipout ;
	return SQLCode
end if

close shipout ;

//	Retrieve invoice number.
select	invoice_number
into	:al_Invoice
from	shipper
where	id = :al_Shipper  ;

if SQLCode <> 0 then
	MONErrText = "Unable to retrieve invoice number performing ShipOut.~r~n~r~n" + sqlerrtext
	return SQLCode
end if

//	Return.
return SQLCode

end function

on n_tr.create
call super::create
end on

on n_tr.destroy
call super::destroy
end on

