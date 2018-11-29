$PBExportHeader$n_cst_inventorytrans_quality.sru
forward
global type n_cst_inventorytrans_quality from n_cst_fxtrans
end type
end forward

global type n_cst_inventorytrans_quality from n_cst_fxtrans
end type
global n_cst_inventorytrans_quality n_cst_inventorytrans_quality

type variables

public constant string OBJECTSTATUS_APPROVED = 'A'

end variables

forward prototypes
public function integer newseriallist ()
public function integer newheader (string description, ref string qualitybatchnumber)
public function integer addobject (string qualitybatchnumber, long serial)
public function integer begin (string qualitybatchnumber)
public function integer setobjectstate (string qualitybatchnumber, long serial, string newstatus, decimal scrapquantity, string notes)
public function integer getdefaultuserdefinedstatus (string basestatus, ref string userdefinedstatus)
public function integer writeobjectstatus (string qualitybatchnumber, long serial)
public function integer endqualitybatch (string qualitybatchnumber)
end prototypes

public function integer newseriallist ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to close job.
string	syntax
syntax = &
"if	object_id('tempdb..#serialList') is not null begin" + "\r\n" +&
"	drop table #serialList" + "\r\n" +&
"end" + "\r\n" +&
"" + "\r\n" +&
"create table #serialList" + "\r\n" +&
"(	Serial int" + "\r\n" +&
",	RowID int not null IDENTITY(1, 1) primary key" + "\r\n" +&
")" + "\r\n" +&
""

declare NewSerialList dynamic procedure for sqlsa  ;

prepare sqlsa from :syntax using TransObject  ;

execute NewSerialList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new serial list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewSerialList  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer newheader (string description, ref string qualitybatchnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to open new cycle count.
declare NewHeader procedure for dbo.usp_InventoryControl_QualityBatch_NewHeader
	@User = :User
,	@Description = :description
,	@QualityBatchNumber = :qualityBatchNumber output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewHeader  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to open new quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewHeader
into
	:qualityBatchNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to open new quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewHeader  ;

//	Return.
return SUCCESS

end function

public function integer addobject (string qualitybatchnumber, long serial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare AddObject procedure for dbo.usp_InventoryControl_QualityBatch_AddObject
	@User = :User
,	@QualityBatchNumber = :qualityBatchNumber
,	@Serial = :serial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AddObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to add object to quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AddObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to add object to quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AddObject   ;

//	Return.
return SUCCESS

end function

public function integer begin (string qualitybatchnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to begin quality batch.
declare Begin procedure for dbo.usp_InventoryControl_QualityBatch_Begin
	@User = :User
,	@QualityBatchNumber = :qualityBatchNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Begin  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to begin quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	Begin
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to begin quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close Begin   ;

//	Return.
return SUCCESS

end function

public function integer setobjectstate (string qualitybatchnumber, long serial, string newstatus, decimal scrapquantity, string notes);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare SetObjectState procedure for dbo.usp_InventoryControl_QualityBatch_SetObjectState
	@User = :User
,	@QualityBatchNumber = :qualityBatchNumber
,	@Serial = :serial
,	@NewStatus = :newStatus
,	@ScrapQuantity = :scrapQuantity
,	@Notes = :notes
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetObjectState  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set object state:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetObjectState
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set object state:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetObjectState   ;

//	Return.
return SUCCESS

end function

public function integer getdefaultuserdefinedstatus (string basestatus, ref string userdefinedstatus);
select
	uds.display_name
into
	:userDefinedStatus
from
	dbo.user_defined_status uds
where
	uds.type = :baseStatus
	and uds.base = 'Y'  ;

if	SQLCA.SQLCode <> 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Status " + baseStatus + " not defined.  Check user defined status definitions in Basic Setups.")
	return FAILURE
end if

return SUCCESS

end function

public function integer writeobjectstatus (string qualitybatchnumber, long serial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to quality batch.
declare WriteObjectStatus procedure for dbo.usp_InventoryControl_QualityBatch_WriteObjectStatus
	@User = :User
,	@QualityBatchNumber = :qualityBatchNumber
,	@Serial = :serial
,	@DeleteScrapped = null /*Let dbo.parameter.delete_scrapped_objects determine.*/
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute WriteObjectStatus  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to write object [" + String(IsNull(serial, -1)) + "] status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	WriteObjectStatus
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to write object [" + String(IsNull(serial, -1)) + "] status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close WriteObjectStatus   ;

//	Return.
return SUCCESS

end function

public function integer endqualitybatch (string qualitybatchnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to open new cycle count.
declare EndQualityBatch procedure for dbo.usp_InventoryControl_QualityBatch_EndQualityBatch
	@User = :User
,	@QualityBatchNumber = :qualityBatchNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EndQualityBatch  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to end quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EndQualityBatch
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to end quality batch:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close EndQualityBatch  ;

//	Return.
return SUCCESS

end function

on n_cst_inventorytrans_quality.create
call super::create
end on

on n_cst_inventorytrans_quality.destroy
call super::destroy
end on

