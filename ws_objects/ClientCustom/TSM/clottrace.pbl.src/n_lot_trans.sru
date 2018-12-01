$PBExportHeader$n_lot_trans.sru
forward
global type n_lot_trans from n_cst_fxtrans
end type
end forward

global type n_lot_trans from n_cst_fxtrans
end type
global n_lot_trans n_lot_trans

forward prototypes
public function integer traceforward_gettreeitems (string tracenumber, string parentid, ref n_lot_trace_treeitem treeitems[])
public function integer tracebackward_gettreeitems (string tracenumber, string parentid, ref n_lot_trace_treeitem treeitems[])
public function integer gettracedescription (string tracenumber, ref string tracedescription)
public function integer newtraceheader (string description, string seriallist, ref string tracenumber)
public function integer refreshtraceup (string tracenumber)
public function integer refreshtracedown (string tracenumber)
end prototypes

public function integer traceforward_gettreeitems (string tracenumber, string parentid, ref n_lot_trace_treeitem treeitems[]);declare childTreeItems cursor for
select
	TreeItemID = ltbu.BottomUpID.ToString()
,	ltbu.Serial
,	ltbu.Part
,	ltbu.Quantity
,	ltbu.TranDT
,	ltbu.LinkType
,	ltbu.Chain
,	HasChildren =
		case
			when
				exists
					(	select
							*
						from
							dbo.LOT_TraceBottomUp ltbu2
						where
							ltbu2.BottomUpID.GetAncestor(1) = ltbu.BottomUpID
					)
				then 1
			else 0
		end
from
	dbo.LOT_TraceBottomUp ltbu
where
	ltbu.TraceNumber = :traceNumber
	and ltbu.BottomUpID.GetAncestor(1) = :parentID
order by
	ltbu.LinkType
,	ltbu.TranDT  ;

open childTreeItems  ;

int	Values = 0

do while 1 = 1
	long serial
	decimal quantity
	datetime tranDT
	string	treeItemID, part, linkType, chain
	int hasChildren
	
	fetch
		childTreeItems
	into
		:treeItemID
	,	:serial
	,	:part
	,	:quantity
	,	:tranDT
	,	:linkType
	,	:chain
	,	:hasChildren
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	treeItems[Values] = create n_lot_trace_treeitem 
	treeItems[Values].TreeItemID = treeItemID
	treeItems[Values].Serial = serial
	treeItems[Values].Part = part
	treeItems[Values].Quantity = quantity
	treeItems[Values].TranDT = tranDT
	treeItems[Values].LinkType = linkType
	treeItems[Values].Chain = chain
	treeItems[Values].HasChildren = (hasChildren = 1)
loop

close childTreeItems  ;

commit  ;

return SUCCESS

end function

public function integer tracebackward_gettreeitems (string tracenumber, string parentid, ref n_lot_trace_treeitem treeitems[]);declare childTreeItems cursor for
select
	TreeItemID = lttd.TopDownID.ToString()
,	lttd.Serial
,	lttd.Part
,	lttd.Quantity
,	lttd.TranDT
,	lttd.LinkType
,	lttd.Chain
,	HasChildren =
		case
			when
				exists
					(	select
							*
						from
							dbo.LOT_TraceTopDown lttd2
						where
							lttd2.TopDownID.GetAncestor(1) = lttd.TopDownID
					)
				then 1
			else 0
		end
from
	dbo.LOT_TraceTopDown lttd
where
	lttd.TraceNumber = :traceNumber
	and lttd.TopDownID.GetAncestor(1) = :parentID
order by
	lttd.LinkType
,	lttd.TranDT  ;

open childTreeItems  ;

int	Values = 0

do while 1 = 1
	long serial
	decimal quantity
	datetime tranDT
	string	treeItemID, part, linkType, chain
	int hasChildren
	
	fetch
		childTreeItems
	into
		:treeItemID
	,	:serial
	,	:part
	,	:quantity
	,	:tranDT
	,	:linkType
	,	:chain
	,	:hasChildren
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	treeItems[Values] = create n_lot_trace_treeitem 
	treeItems[Values].TreeItemID = treeItemID
	treeItems[Values].Serial = serial
	treeItems[Values].Part = part
	treeItems[Values].Quantity = quantity
	treeItems[Values].TranDT = tranDT
	treeItems[Values].LinkType = linkType
	treeItems[Values].Chain = chain
	treeItems[Values].HasChildren = (hasChildren = 1)
loop

close childTreeItems  ;

commit  ;

return SUCCESS

end function

public function integer gettracedescription (string tracenumber, ref string tracedescription);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to get trace description.
select
	lth.Description
into
	:traceDescription
from
	dbo.LOT_TraceHeaders lth
where
	lth.TraceNumber = :traceNumber
	using TransObject  ;

sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Unable to get trace description:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer newtraceheader (string description, string seriallist, ref string tracenumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add a new trace.
declare NewTraceHeader procedure for dbo.usp_LOT_NewTraceHeader
	@User = :User
,	@Description = :description
,	@SerialList = :serialList
,	@TraceNumber = :traceNumber output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewTraceHeader  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new trace header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewTraceHeader
into
	:traceNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new trace header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewTraceHeader   ;

//	Return.
return SUCCESS

end function

public function integer refreshtraceup (string tracenumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to trace forward.
declare RefreshTrace procedure for dbo.usp_LOT_TraceForward
	@TraceNumber = :traceNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RefreshTrace  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to refresh trace:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RefreshTrace
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to refresh trace:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RefreshTrace   ;

//	Return.
return SUCCESS

end function

public function integer refreshtracedown (string tracenumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to trace backward.
declare RefreshTrace procedure for dbo.usp_LOT_TraceBackward
	@TraceNumber = :traceNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RefreshTrace  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to refresh trace:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RefreshTrace
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to refresh trace:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RefreshTrace   ;

//	Return.
return SUCCESS

end function

on n_lot_trans.create
call super::create
end on

on n_lot_trans.destroy
call super::destroy
end on

