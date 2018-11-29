$PBExportHeader$n_cst_shippingtrans_qrcl.sru
forward
global type n_cst_shippingtrans_qrcl from n_cst_fxtrans
end type
end forward

global type n_cst_shippingtrans_qrcl from n_cst_fxtrans
end type
global n_cst_shippingtrans_qrcl n_cst_shippingtrans_qrcl

type variables

end variables

forward prototypes
public function integer changeqtyrequired (string operator, long shipperid, string shipperpart, decimal newqtyrequired)
end prototypes

public function integer changeqtyrequired (string operator, long shipperid, string shipperpart, decimal newqtyrequired);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change qty required.
declare ChangeQtyRequired procedure for dbo.usp_Shipping_QRCL_ChangeQtyRequired
	@Operator = :operator
,	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@NewQtyRequired = :newQtyRequired
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ChangeQtyRequired  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change qty required:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ChangeQtyRequired
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change qty required:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ChangeQtyRequired   ;

//	Return.
return SUCCESS

end function

on n_cst_shippingtrans_qrcl.create
call super::create
end on

on n_cst_shippingtrans_qrcl.destroy
call super::destroy
end on

