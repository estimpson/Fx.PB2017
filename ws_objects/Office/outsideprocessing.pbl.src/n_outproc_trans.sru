$PBExportHeader$n_outproc_trans.sru
forward
global type n_outproc_trans from n_cst_fxtrans
end type
end forward

global type n_outproc_trans from n_cst_fxtrans
end type
global n_outproc_trans n_outproc_trans

forward prototypes
public function integer adjustvendorinventory (long opdefrowid, string partcode, decimal adjustedqty)
public function integer newbacktobackshipment (long opdefrowid, string confirmedsid, decimal quantity, string note, ref string receivernumber)
end prototypes

public function integer adjustvendorinventory (long opdefrowid, string partcode, decimal adjustedqty);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create/edit/remove material substitution.
declare AdjustVendorInventory procedure for dbo.usp_OutProc_AdjustVendorInventory
	@User = :User
,	@OPDefRowID = :opDefRowID
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

public function integer newbacktobackshipment (long opdefrowid, string confirmedsid, decimal quantity, string note, ref string receivernumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare NewBackToBackShipment procedure for dbo.usp_OutProc_NewBackToBackShipment
	@Operator = :user
,	@OPDefRowID = :opDefRowID
,	@ConfirmedSID = :confirmedSID
,	@Quantity = :quantity
,	@Note = :note
,	@ReceiverNumber = :receiverNumber output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewBackToBackShipment  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to create new back to back shipment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewBackToBackShipment
into
	:receiverNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to create new back to back shipment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewBackToBackShipment   ;

//	Return.
return SUCCESS

end function

on n_outproc_trans.create
call super::create
end on

on n_outproc_trans.destroy
call super::destroy
end on

