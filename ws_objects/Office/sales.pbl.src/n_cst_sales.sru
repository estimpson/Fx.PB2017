$PBExportHeader$n_cst_sales.sru
forward
global type n_cst_sales from n_base
end type
end forward

global type n_cst_sales from n_base
end type
global n_cst_sales n_cst_sales

type variables

constant int RECEIVER_NEW = 0, RECEIVER_CONFIRMED = 1, RECEIVER_SHIPPED = 2, RECEIVER_ARRIVED = 3, RECEIVER_RECEIVED = 4, RECEIVER_PUTAWAY = 5, RECEIVER_ARCHIVED = 6
string User

end variables

forward prototypes
public function integer getblanketorderreleases (long activeorderno, ref long procresult)
public function integer getblanketorderdistributedreleases (ref long procresult)
public function integer saveblanketorderdistributedreleases (ref long procresult)
end prototypes

public function integer getblanketorderreleases (long activeorderno, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare GetBlanketOrderReleases procedure for dbo.usp_GetBlanketOrderReleases
	@ActiveOrderNo = :activeOrderNo,
	@Result =:procResult output using SQLCA  ;

execute GetBlanketOrderReleases  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get blanket order releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	GetBlanketOrderReleases
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get blanket order releasesr:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close GetBlanketOrderReleases  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer getblanketorderdistributedreleases (ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare GetBlanketOrderDistributedReleases procedure for dbo.usp_GetBlanketOrderDistributedReleases
	@Result =:procResult output,
	@Debug = 0 using SQLCA  ;

execute GetBlanketOrderDistributedReleases  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get blanket order distributed releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	GetBlanketOrderDistributedReleases
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get blanket order distributed releasesr:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close GetBlanketOrderDistributedReleases  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer saveblanketorderdistributedreleases (ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare SaveBlanketOrderDistributedReleases procedure for dbo.usp_SaveBlanketOrderDistributedReleases
	@Result =:procResult output using SQLCA  ;

execute SaveBlanketOrderDistributedReleases  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to save blanket order distributed releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	SaveBlanketOrderDistributedReleases
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to save blanket order distributed releasesr:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SaveBlanketOrderDistributedReleases  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

event pfd_event;
choose case EventName
	case "User"
		User = eventmessage.of_GetItem("User")
end choose

end event

on n_cst_sales.create
call super::create
end on

on n_cst_sales.destroy
call super::destroy
end on

event constructor;call super::constructor;
gnv_App.inv_StateMSGRouter.Register("User", this, true)

end event

