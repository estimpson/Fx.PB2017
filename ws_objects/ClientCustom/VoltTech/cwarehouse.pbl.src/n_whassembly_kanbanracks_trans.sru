$PBExportHeader$n_whassembly_kanbanracks_trans.sru
forward
global type n_whassembly_kanbanracks_trans from n_cst_fxtrans
end type
end forward

global type n_whassembly_kanbanracks_trans from n_cst_fxtrans
end type
global n_whassembly_kanbanracks_trans n_whassembly_kanbanracks_trans

forward prototypes
public function integer updateaisledefinition (long aislerowid, string newaisle, string newprefix, integer newlayers, integer newpositions)
public function integer newaisledefinition (string newparentlocation, string newaisle, string newprefix, integer newlayers, integer newpositions)
public function integer deleteaisledefinition (long aislerowid)
public function integer updatelocationcomponentpart (string location, string componentpart)
public function integer updatecomponentpartlocation (string componentpart, string location)
end prototypes

public function integer updateaisledefinition (long aislerowid, string newaisle, string newprefix, integer newlayers, integer newpositions);

//	Perform update
update
	makld
set
	Aisle = :newAisle
,	ParentLocationPrefix = :newPrefix
,	Layers = :newLayers
,	Positions = :newPositions
from
	custom.MES_AssemblyKanbanLocationDefinition makld
where
	makld.RowID = :aisleRowID using TransObject  ;

long	sqlResult
string	sqlError
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to update aisle definition:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer newaisledefinition (string newparentlocation, string newaisle, string newprefix, integer newlayers, integer newpositions);
//	Perform insert.
insert
	custom.MES_AssemblyKanbanLocationDefinition
(	ParentLocation
,	Aisle
,	ParentLocationPrefix
,	Layers
,	Positions
)
select
	ParentLocation = :newParentLocation
,	Aisle = :newAisle
,	ParentLocationPrefix = :newPrefix
,	Layers = :newLayers
,	Positions = :newPositions
using TransObject  ;

long	sqlResult
string	sqlError
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to insert aisle definition:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

return NO_ACTION

end function

public function integer deleteaisledefinition (long aislerowid);
//	Perform delete.
delete
	makld
from
	custom.MES_AssemblyKanbanLocationDefinition makld
where
	makld.RowID = :aisleRowID using TransObject  ;

long	sqlResult
string	sqlError
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete aisle definition:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer updatelocationcomponentpart (string location, string componentpart);
//	Perform update.
update
	mrkc
set
	PartCode = :componentPart
from
	dbo.MES_ReplenishmentKanbanCards mrkc
where
	mrkc.LocationCode = :location using TransObject  ;

long	sqlResult
string	sqlError
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to update kanban location component part:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer updatecomponentpartlocation (string componentpart, string location);

//	Perform update.
update
	mrkc
set
	LocationCode = :location
from
	dbo.MES_ReplenishmentKanbanCards mrkc
where
	mrkc.PartCode = :ComponentPart using TransObject  ;

long	sqlResult
string	sqlError
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to update component part kanban location:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

on n_whassembly_kanbanracks_trans.create
call super::create
end on

on n_whassembly_kanbanracks_trans.destroy
call super::destroy
end on

