$PBExportHeader$n_cst_outsideprocessing_inventorytrans.sru
forward
global type n_cst_outsideprocessing_inventorytrans from n_cst_fxtrans
end type
end forward

global type n_cst_outsideprocessing_inventorytrans from n_cst_fxtrans
end type
global n_cst_outsideprocessing_inventorytrans n_cst_outsideprocessing_inventorytrans

forward prototypes
public function integer adjustvendorinventory (string vendorlocation, string partcode, decimal adjustedqty)
end prototypes

public function integer adjustvendorinventory (string vendorlocation, string partcode, decimal adjustedqty);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create/edit/remove material substitution.
declare AdjustVendorInventory procedure for dbo.usp_OutsideProcessing_AdjustVendorInventory
	@Operator = :User
,	@VendorLocation = :vendorLocation
,	@PartCode = :partCode
,	@AdjustedQty = :adjustedQty
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AdjustVendorInventory  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to adjust vendor inventory:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AdjustVendorInventory
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to adjust vendor inventory:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close AdjustVendorInventory  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_outsideprocessing_inventorytrans.create
call super::create
end on

on n_cst_outsideprocessing_inventorytrans.destroy
call super::destroy
end on

