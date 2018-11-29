$PBExportHeader$n_cst_partmastertrans_relatedparts.sru
forward
global type n_cst_partmastertrans_relatedparts from n_cst_fxtrans
end type
end forward

global type n_cst_partmastertrans_relatedparts from n_cst_fxtrans
end type
global n_cst_partmastertrans_relatedparts n_cst_partmastertrans_relatedparts

forward prototypes
public function integer newrelatedpartgroup (string partcode, string groupname)
public function integer editrelatedpartgroupname (string partcode, string groupguid, string groupname)
public function integer addrelatedpart (string partcode, string groupguid)
public function integer removerelatedpart (string partcode, string groupguid)
public function integer getrelatedparts (string partcode, ref n_partmaster_relatedpartitem partitems[])
end prototypes

public function integer newrelatedpartgroup (string partcode, string groupname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create group.
declare NewRelatedPartGroup procedure for dbo.usp_PartMaster_NewRelatedPartGroup
	@PartCode =:partCode
,	@GroupName = :groupName
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewRelatedPartGroup  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewRelatedPartGroup
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewRelatedPartGroup   ;

//	Return.
return SUCCESS

end function

public function integer editrelatedpartgroupname (string partcode, string groupguid, string groupname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to edit group name.
declare EditRelatedPartGroupName procedure for dbo.usp_PartMaster_EditRelatedPartGroupName
	@PartCode =:partCode
,	@GroupGUID = :groupGUID
,	@GroupName = :groupName
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EditRelatedPartGroupName  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create edit group name:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EditRelatedPartGroupName
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create edit group name:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close EditRelatedPartGroupName   ;

//	Return.
return SUCCESS

end function

public function integer addrelatedpart (string partcode, string groupguid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to edit group name.
declare AddRelatedPart procedure for dbo.usp_PartMaster_AddRelatedPart
	@PartCode =:partCode
,	@GroupGUID = :groupGUID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AddRelatedPart  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to add part to group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AddRelatedPart
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to add part to group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AddRelatedPart   ;

//	Return.
return SUCCESS

end function

public function integer removerelatedpart (string partcode, string groupguid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to edit group name.
declare RemoveRelatedPart procedure for dbo.usp_PartMaster_RemoveRelatedPart
	@PartCode =:partCode
,	@GroupGUID = :groupGUID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RemoveRelatedPart  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to remove part from group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RemoveRelatedPart
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to remove part from group:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RemoveRelatedPart   ;

//	Return.
return SUCCESS

end function

public function integer getrelatedparts (string partcode, ref n_partmaster_relatedpartitem partitems[]);declare relatedParts cursor for
select
	pmprpl.IsGroup
,	GroupName = case pmprpl.IsAnonymous when 1 then '<Anonymous>' else pmprpl.GroupName end
,	pmprpl.RelatedPartCode
from
	dbo.PartMaster_PartRelatedPartList pmprpl
where
	PartCode = :partCode
order by
	pmprpl.GroupName
,	pmprpl.IsGroup desc  ;

open relatedParts  ;

int	Values = 0

do while 1 = 1
	int isGroup
	string groupName, relatedPart
	fetch
		relatedParts
	into
		:isGroup
	,	:groupName
	,	:relatedPart
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	partItems[Values] = create n_partmaster_relatedpartitem 
	partItems[Values].IsGroup = (isGroup = 1)
	partItems[Values].GroupName = groupName
	partItems[Values].RelatedPart = relatedPart
loop

close relatedParts  ;

commit  ;

return SUCCESS

end function

on n_cst_partmastertrans_relatedparts.create
call super::create
end on

on n_cst_partmastertrans_relatedparts.destroy
call super::destroy
end on

