HA$PBExportHeader$n_cst_shippingtrans_options.sru
forward
global type n_cst_shippingtrans_options from n_cst_fxtrans
end type
end forward

global type n_cst_shippingtrans_options from n_cst_fxtrans
end type
global n_cst_shippingtrans_options n_cst_shippingtrans_options

type variables

public constant long OBJECTSTATUS_IGNORE = -2
public constant long OBJECTSTATUS_LOST = -1
public constant long OBJECTSTATUS_UNKNOWN = 0
public constant long OBJECTSTATUS_FOUND = 1
public constant long OBJECTSTATUS_FOUNDADJ = 2
public constant long OBJECTSTATUS_FOUNDREL = 3
public constant long OBJECTSTATUS_FOUNDADJREL = 4
public constant long OBJECTSTATUS_RECOVER = 5

end variables

forward prototypes
public function integer allowchangedestination (long shipperid, ref long value)
end prototypes

public function integer allowchangedestination (long shipperid, ref long value);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to get change destination option.
declare OptionChangeDestination procedure for dbo.usp_Shipping_OptionChangeDestination
	@ShipperID = :shipperID
,	@Value = :value out
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute OptionChangeDestination  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get destination change option:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	OptionChangeDestination
into
	:value
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get destination change option:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close OptionChangeDestination   ;

//	Return.
return SUCCESS

end function

on n_cst_shippingtrans_options.create
call super::create
end on

on n_cst_shippingtrans_options.destroy
call super::destroy
end on

