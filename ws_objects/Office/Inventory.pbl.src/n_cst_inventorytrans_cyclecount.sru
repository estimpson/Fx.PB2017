$PBExportHeader$n_cst_inventorytrans_cyclecount.sru
forward
global type n_cst_inventorytrans_cyclecount from n_cst_fxtrans
end type
end forward

global type n_cst_inventorytrans_cyclecount from n_cst_fxtrans
end type
global n_cst_inventorytrans_cyclecount n_cst_inventorytrans_cyclecount

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
public function integer newheader (string description, ref string cyclecountnumber)
public function integer begin (string cyclecountnumber)
public function integer addobject (string cyclecountnumber, long serial)
public function integer markobject (string cyclecountnumber, long serial, long newstatus)
public function integer correctquantity (string cyclecountnumber, long serial, decimal newquantity)
public function integer correctlocation (string cyclecountnumber, long serial, string newlocation)
public function integer recoverobject (string cyclecountnumber, long serial, decimal quantity, string location)
public function integer endcount (string cyclecountnumber)
public function integer marklistedobjects (string cyclecountnumber, string seriallist, long newstatus)
public function integer addlistedobjects (string cyclecountnumber, string seriallist)
public function integer newseriallist ()
end prototypes

public function integer newheader (string description, ref string cyclecountnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to open new cycle count.
declare NewHeader procedure for dbo.usp_InventoryControl_CycleCount_NewHeader
	@User = :User
,	@Description = :description
,	@CycleCountNumber = :cycleCountNumber output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewHeader  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to open new cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewHeader
into
	:cycleCountNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to open new cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewHeader  ;

//	Return.
return SUCCESS

end function

public function integer begin (string cyclecountnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to begin cycle count.
declare Begin procedure for dbo.usp_InventoryControl_CycleCount_Begin
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Begin  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to begin cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
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
	MessageBox(monsys.msg_Title, "Failed on result, unable to begin cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close Begin   ;

//	Return.
return SUCCESS

end function

public function integer addobject (string cyclecountnumber, long serial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare AddObject procedure for dbo.usp_InventoryControl_CycleCount_AddObject
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@Serial = :serial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AddObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to add object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
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
	MessageBox(monsys.msg_Title, "Failed on result, unable to add object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AddObject   ;

//	Return.
return SUCCESS

end function

public function integer markobject (string cyclecountnumber, long serial, long newstatus);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to mark cycle count object.
declare MarkObject procedure for dbo.usp_InventoryControl_CycleCount_MarkObject
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@Serial = :serial
,	@NewStatus = :newStatus
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute MarkObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to mark cycle count object:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	MarkObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to mark cycle count object:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close MarkObject   ;

//	Return.
return SUCCESS

end function

public function integer correctquantity (string cyclecountnumber, long serial, decimal newquantity);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to correct cycle count quantity.
declare CorrectQuantity procedure for dbo.usp_InventoryControl_CycleCount_CorrectQuantity
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@Serial = :serial
,	@NewQuantity = :newQuantity
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CorrectQuantity  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to correct cycle count quantity:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CorrectQuantity
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to correct cycle count quantity:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CorrectQuantity   ;

//	Return.
return SUCCESS

end function

public function integer correctlocation (string cyclecountnumber, long serial, string newlocation);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to correct cycle count location.
declare CorrectLocation procedure for dbo.usp_InventoryControl_CycleCount_CorrectLocation
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@Serial = :serial
,	@NewLocation = :newLocation
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CorrectLocation  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to correct cycle count location:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CorrectLocation
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to correct cycle count location:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CorrectLocation   ;

//	Return.
return SUCCESS

end function

public function integer recoverobject (string cyclecountnumber, long serial, decimal quantity, string location);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to recover object to cycle count.
declare RecoverObject procedure for dbo.usp_InventoryControl_CycleCount_RecoverObject
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@Serial = :serial
,	@Quantity = :quantity
,	@Location = :location
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RecoverObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to recover object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RecoverObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to recover object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RecoverObject   ;

//	Return.
return SUCCESS

end function

public function integer endcount (string cyclecountnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to end cycle count.
declare EndCount procedure for dbo.usp_InventoryControl_CycleCount_End
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EndCount  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to end cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EndCount
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to end cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close EndCount   ;

//	Return.
return SUCCESS

end function

public function integer marklistedobjects (string cyclecountnumber, string seriallist, long newstatus);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to mark listed cycle count objects.
declare MarkListedObjects procedure for dbo.usp_InventoryControl_CycleCount_MarkListedObjects
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@SerialList = :serialList
,	@NewStatus = :newStatus
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute MarkListedObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to mark cycle count object:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	MarkListedObjects
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to mark cycle count object:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close MarkListedObjects   ;

//	Return.
return SUCCESS

end function

public function integer addlistedobjects (string cyclecountnumber, string seriallist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add listed object to cycle count.
declare AddListedObjects procedure for dbo.usp_InventoryControl_CycleCount_AddListedObjects
	@User = :User
,	@CycleCountNumber = :cycleCountNumber
,	@SerialList = :serialList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AddListedObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to add object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AddListedObjects
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to add object to cycle count:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AddListedObjects   ;

//	Return.
return SUCCESS

end function

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

on n_cst_inventorytrans_cyclecount.create
call super::create
end on

on n_cst_inventorytrans_cyclecount.destroy
call super::destroy
end on

