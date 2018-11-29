$PBExportHeader$u_dwpbbase.sru
forward
global type u_dwpbbase from u_dwdragdropitem
end type
end forward

global type u_dwpbbase from u_dwdragdropitem
int Width=3177
int Height=1912
string DataObject="d_pb_resource_list"
event ue_shiftrclick ( long shiftid,  long row )
event ue_taskrclick ( long taskid,  long row )
event ue_resourcerclick ( string resourceid,  long row )
event ue_movetask ( long fromresource,  long toresource,  long newsequence,  long currentsequence,  long id )
event ue_resequencetask ( long resource,  long newsequence,  long currentsequence,  long id )
end type
global u_dwpbbase u_dwpbbase

type variables
Protected:

datetime		idt_RetrieveBegin

integer		ii_Interval

long		il_CursorTaskOffset

string		is_IntervalType

n_cst_resource	in_cst_ResourceList [ ]


end variables

forward prototypes
protected function integer of_extractidrow (string as_name, ref long al_id, ref long al_row, ref long al_taskseq)
end prototypes

protected function integer of_extractidrow (string as_name, ref long al_id, ref long al_row, ref long al_taskseq);
//	Declarations.
integer	li_SeparatorPos
integer	li_SndSeparatorPos
integer	li_Length

//	I.	Extract Id and Row from name.

//		A.	Determine position of separator and length.
		
li_SeparatorPos = PosA ( as_Name, '_' )
li_SndSeparatorPos = PosA ( as_Name, '_', li_SeparatorPos + 1 ) 
li_Length = LenA ( as_Name )

//		B.	Parse Id and Row.

al_Id = Long ( MidA ( as_Name, li_SeparatorPos + 1, ( li_SndSeparatorPos - (li_SeparatorPos + 1 ) ) ) )
al_TaskSeq = Long ( RightA ( as_Name, li_Length - li_SndSeparatorPos ) )
al_Row = Long ( MidA ( as_Name, 2, li_SeparatorPos - 2 ) )

//	Return.
return 1
end function

event rbuttondown;
//	Declarations
long	ll_Id
long	ll_Row
long	ll_TaskSeq

string	ls_ResourceId
string	ls_Name

// Check Row value 
if row <= 0 then return 
ls_Name = dwo.Name

//	I.	Depending on object type ( resource, task, or shift ) generate appropriate event.
choose case dwo.Type
	case "column"
		if ls_Name = 'resource_name' then 
			ls_ResourceId = object.resource_name [ row ] 
			//	A.	Trigger resource right click event.
			event ue_resourcerclick ( ls_ResourceId, row )
		end if 	
	case "text"
		
		if of_ExtractIdRow ( ls_Name, ll_Id, ll_Row, ll_TaskSeq ) = 1 then		
			//	B.	Check for s or t predicate.
			choose case LeftA ( ls_Name, 1 )
				case 's'
					//	1.	Trigger shift right click event.
					event ue_shiftrclick ( ll_Id, row )
				case 't'
					//	2.	Trigger task right click event.
					event ue_taskrclick ( ll_Id, row )
	
			end choose
		end if 	
end choose

end event

event ue_dragitembegin;
//	Declarations.
integer	li_XOffset
integer	li_IntervalWidth
integer	li_XPosUnits

long	ll_CursorSeconds
long	ll_TaskSeconds
long	ll_Id
long	ll_Row
long	ll_TaskSeq

//	I.	Calculate the seconds from RetrieveBegin to current cursor position.

//		A.	Get the IntervalWidth and Xoffset from the DataWindow.
li_XOffset = object.xoffset [ 1 ]
li_IntervalWidth = object.intervalwidth [ 1 ]

//		B.	Calculate the XPos in dwUnits.
li_XPosUnits = PixelsToUnits ( xpos, XPixelsToUnits! )

//		C.	Depending on interval type, calculate the seconds...
choose case is_IntervalType
	case 'Minute'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 60 / ( li_IntervalWidth + 8 )
	case 'Hour'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 60 * 60 / ( li_IntervalWidth + 8 )
	case 'Day'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 24 * 60 * 60 / ( li_IntervalWidth + 8 )
	case 'Week'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 7 * 24 * 60 * 60 / ( li_IntervalWidth + 8 )
end choose

//	II.	Calculate the offset in Seconds from Cursor to Task.

//		A.	Find the dragged task's seconds.

//			1.	Extract the id and row from the object name.
if of_ExtractIdRow ( dwoName, ll_Id, ll_Row, ll_TaskSeq ) = 1 then
	
//			2.	Find the task seconds from the retrieve begin from the db.
	select	DateDiff ( second, :idt_RetrieveBegin, task_start )
	into	:ll_TaskSeconds
	from	mvw_resource_task_list
	where	task_id = :ll_Id  ;

//		B.	Calculate and store the offset.
	il_CursorTaskOffset = ll_CursorSeconds - ll_TaskSeconds
end if

end event

event ue_dragitemend;
//	Declarations.
datetime	ldt_Start
datetime	ldt_TaskBegin

integer	li_XOffset
integer	li_IntervalWidth
integer	li_XPosUnits

long	ll_CursorSeconds
long	ll_TaskSeconds
long	ll_Id
long	ll_Row
long	ll_NewSequence
long	ll_TaskSeq

string	ls_ResourceName

datetime ldt_check

datastore	lds_checkdate

//	I.	Calculate the seconds from RetrieveBegin to current cursor position.

//		A.	Get the IntervalWidth and Xoffset from the DataWindow.
li_XOffset = object.xoffset [ 1 ]
li_IntervalWidth = object.intervalwidth [ 1 ]

//		B.	Calculate the XPos in dwUnits.
li_XPosUnits = PixelsToUnits ( xpos, XPixelsToUnits! )

//		C.	Depending on interval type, calculate the seconds...
choose case is_IntervalType
	case 'Minute'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 60 / ( li_IntervalWidth + 8 )
	case 'Hour'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 60 * 60 / ( li_IntervalWidth + 8 )
	case 'Day'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 24 * 60 * 60 / ( li_IntervalWidth + 8 )
	case 'Week'
		ll_CursorSeconds = ( li_XPosUnits - 18 - li_XOffset ) * ii_Interval * 7 * 24 * 60 * 60 / ( li_IntervalWidth + 8 )
end choose

//	II.	Calculate the Task Seconds from the offset.
ll_TaskSeconds = ll_CursorSeconds - il_CursorTaskOffset

//	III.	Find the new sequence for the task.
if row > 0 then 
	ls_ResourceName = object.resource_name [ row ]
	
	//		A.	Extract the id and row from the object name.
	if of_ExtractIdRow ( dwoName, ll_Id, ll_Row, ll_TaskSeq ) = 1 then

		//ldt_TaskBegin = in_cst_ResourceList [ ll_row ].in_cst_TaskQueue [ ll_TaskSeq ].idt_Begin
		lds_checkdate = create datastore
		lds_checkdate.dataobject = 'd_datecheck'
		lds_checkdate.settransobject ( sqlca ) 
		sqlca.autocommit = true
		lds_checkdate.retrieve ( ll_TaskSeconds, idt_RetrieveBegin ) 
		sqlca.autocommit = false
		if lds_checkdate.rowcount () > 0 then ldt_check = lds_checkdate.object.result [ 1 ] 	
		Destroy lds_checkdate
		
		select	Count ( 1 ) + 1
		into	:ll_NewSequence
		from	mvw_resource_task_list
		where	resource_name = :ls_ResourceName and
			task_start < :ldt_check ;
	
		ll_NewSequence = IsNull ( ll_NewSequence, 1 )
	//	IV.	Send moved or resequenced event.
		
	//			1.	If row has changed send move else resequence.
		if ll_Row <> row then
			event ue_MoveTask ( ll_Row, row, ll_NewSequence, ll_TaskSeq, ll_id )
		else
			if ll_Taskseq <> ll_NewSequence then 
				event ue_ResequenceTask ( ll_Row, ll_NewSequence, ll_TaskSeq, ll_id )
			end if 	
		end if
	end if
end if

end event

