$PBExportHeader$n_cst_statemsgrouter.sru
forward
global type n_cst_statemsgrouter from n_base
end type
end forward

global type n_cst_statemsgrouter from n_base
end type
global n_cst_statemsgrouter n_cst_statemsgrouter

type variables

public constant integer	TYPEMISMATCH = -2
public constant integer	PAUSED = 2
public constant integer	ONLINE = 1
public constant integer	OFFLINE = 0
public constant integer	INVALID = -1

private n_cst_statearray	inv_StateArray
private n_cst_requestorarray	inv_RequestorArray

end variables

forward prototypes
public function integer of_requestnotification (powerobject apo_requestor, string as_eventname, string as_states[])
public function integer of_sendevents ()
public function integer of_sendevents (integer ai_requestor)
public function integer of_offline (powerobject apo_requestor)
public function integer of_resume (powerobject apo_requestor)
public function integer of_Pause (powerobject apo_requestor)
public function integer of_requestnotification (powerobject apo_requestor, string as_state)
public function integer register (string state, powerobject requestor, boolean handlenow)
public function integer register (string state, powerobject requestor)
public function integer register (string eventname, string staterequestarray[], powerobject requestor)
public function integer of_broadcast (n_cst_associative_array broadcaststatearray)
public function integer register (string eventname, string staterequestarray[], powerobject requestorobject, boolean handlenow)
end prototypes

public function integer of_requestnotification (powerobject apo_requestor, string as_eventname, string as_states[]);
//	Check that at least one State has been mapped.
integer	li_States
li_States = UpperBound ( as_States )
if li_States = 0 then return FAILURE

//	Loop through the requested states, add the event to the state map of each.
integer li_Requestor, li_Event, li_State, i
n_cst_requestor	lnv_Requestor
n_cst_event	lnv_Event
n_cst_state	lnv_State

//	Add requestor to the list.
li_Requestor = inv_RequestorArray.of_GetIndex ( apo_Requestor )
lnv_Requestor = inv_RequestorArray.invRequestors [ li_Requestor ]
lnv_Requestor.Status = ONLINE

//	Add event to the list.
li_Event = lnv_Requestor.invEventArray.of_GetIndex ( as_EventName )
lnv_Event = lnv_Requestor.invEventArray.invEvents [ li_Event ]

//	Loop through each state.
for i = 1 to li_States
	//	Add states to the list.
	li_State = inv_StateArray.of_AddState ( as_States[i] )
	lnv_State = inv_StateArray.invStates [ li_State ]
	inv_StateArray.invStates [ li_State ].Name = as_States[i]
	//	Add a referenct to the requestor to each state.
	inv_StateArray.invStates [ li_State ].of_GetIndex ( li_Requestor )
	
	//	Add state to the list of states attached to this event.
	li_State = lnv_Event.invStateArray.of_AddState ( as_States[i] )
	lnv_Event.invStateArray.invStates [ li_State ] = lnv_State
next

//	Finished.
return success

end function

public function integer of_sendevents ();
//	Loop through requestors and send events to those that are online.
long	i
long	ll_Requestors
ll_Requestors = inv_RequestorArray.of_UpperBound ( )
for i = 1 to ll_Requestors
	if inv_RequestorArray.invRequestors [i].Status = ONLINE then
		of_SendEvents ( i )
	end if
next

//	Finished.
return SUCCESS

end function

public function integer of_sendevents (integer ai_requestor);
//	Get the status of the requestor.
long	i, j
long	ll_Events, ll_States
n_cst_requestor	lnv_Requestor
n_cst_event lnv_Event
n_cst_state lnv_State
n_cst_associative_array	lnv_Message

lnv_Requestor = inv_RequestorArray.invRequestors [ ai_Requestor ]
if not IsValid ( lnv_Requestor.Requestor ) then return INVALID
if lnv_Requestor.Status = ONLINE and lnv_Requestor.HasEvents then
	//	Loop through events and trigger those that need triggering.
	ll_Events = lnv_Requestor.invEventArray.of_UpperBound ( )
	for i = 1 to ll_Events
		lnv_Event = lnv_Requestor.invEventArray.invEvents [i]
		if lnv_Event.NeedsProcessing then
			//	Loop through states and 
			ll_States = lnv_Event.invStateArray.of_UpperBound ( )
			for j = 1 to ll_States
				lnv_State = lnv_Event.invStateArray.invStates [j]
				lnv_Message.of_SetItem ( lnv_State.Name, lnv_State.Value )
			next
			lnv_Event.NeedsProcessing = false
			lnv_Requestor.Requestor.dynamic event pfd_Event ( lnv_Event.Name, lnv_Message )
		end if
	next
	lnv_Requestor.HasEvents = false
end if

//	Finished.
return SUCCESS

end function

public function integer of_offline (powerobject apo_requestor);
//	Turn the requestor off line.
integer li_Requestor
li_Requestor = inv_RequestorArray.of_GetIndex ( apo_Requestor )
inv_RequestorArray.invRequestors [ li_Requestor ].Status = OFFLINE

//	Finished.
return success

end function

public function integer of_resume (powerobject apo_requestor);
//	Bring the requestor on line.
integer li_Requestor
li_Requestor = inv_RequestorArray.of_GetIndex ( apo_Requestor )
inv_RequestorArray.invRequestors [ li_Requestor ].Status = ONLINE

//	Send missed events to the requestor (if it was paused).
of_SendEvents ( li_Requestor )

//	Finished.
return success

end function

public function integer of_Pause (powerobject apo_requestor);
//	Pause the requestor.
integer li_Requestor
li_Requestor = inv_RequestorArray.of_GetIndex ( apo_Requestor )
inv_RequestorArray.invRequestors [ li_Requestor ].Status = PAUSED

//	Finished.
return success

end function

public function integer of_requestnotification (powerobject apo_requestor, string as_state);
//	Treat the single state as an element name.
string	ls_State [1]
ls_State [1] = as_State

//	Call general function.
return of_RequestNotification ( apo_Requestor, as_State, ls_State )

end function

public function integer register (string state, powerobject requestor, boolean handlenow);
//	Treat the single state as an element name.
string	stateArray[1]
stateArray[1] = State

//	Call general function.
return Register (state, stateArray, requestor, handleNow)

end function

public function integer register (string state, powerobject requestor);
//	Treat the single state as an element name.
string	stateArray[1]
stateArray[1] = State

//	Call general function.
return Register (state, stateArray, requestor, false)

end function

public function integer register (string eventname, string staterequestarray[], powerobject requestor);
//	Call general function.
return Register(eventName, stateRequestArray, requestor, false)

end function

public function integer of_broadcast (n_cst_associative_array broadcaststatearray);
//	Check that at least one State has been sent.
int	broadcastStateArrayCount
broadcastStateArrayCount = broadcastStateArray.of_UpperBound()
if broadcastStateArrayCount = 0 then return FAILURE

//	Loop through the sent states...
integer	stateIndex
int i, j, k
string	stateName
any	stateValue
string	broadcastStateValueClassName
string	stateValueClassName
long	requestorCount, eventCount
integer	requestorStatus
n_cst_state	state
n_cst_requestor	requestor
n_cst_event	lnv_Event
for	i = 1 to broadcastStateArrayCount
	stateName = broadcastStateArray.of_GetItemIndexor(i)
	stateValue = broadcastStateArray.of_GetItem(i)
	//	Set current state value.
	stateIndex = inv_StateArray.of_AddState(stateName)
	state = inv_StateArray.invStates[stateIndex]
	try
		stateValueClassName = ClassName(state.Value)
	catch (runtimeerror er1)   
		any any1
		state.Value = any1
		stateValueClassName = ClassName(state.Value)
	end try
	try
		broadcastStateValueClassName = ClassName(stateValue)
	catch (runtimeerror er2)
		any any2
		stateValue = any1
		SetNull(stateValue)
		broadcastStateValueClassName = ClassName(stateValue)
	end try
	if	stateValueClassName = broadcastStateValueClassName or stateValueClassName = "any" or isNull(stateValueClassName) then
		state.Value = stateValue
	else
		return TYPEMISMATCH
	end if
	
	//	Loop through list of state requestors.
	requestorCount = UpperBound(state.RequestorIndexArray)
	for	j = 1 to requestorCount
		//	Check requestor status.
		requestor = inv_RequestorArray.invRequestors[state.RequestorIndexArray[j]]
		requestorStatus = requestor.Status
		requestor.HasEvents =(requestorStatus = ONLINE or requestorStatus = PAUSED)
		if(requestorStatus = ONLINE or requestorStatus = PAUSED) then
			//	Loop through list of events.
			eventCount = requestor.invEventArray.of_UpperBound()
			for	k = 1 to eventCount
				lnv_Event = requestor.invEventArray.invEvents[k]
				//	Look at event for this state.
				lnv_Event.NeedsProcessing = lnv_Event.invStateArray.of_GetIndex(stateName) > 0
			next
		end if
	next
next

//	Send events.
return of_SendEvents()

end function

public function integer register (string eventname, string staterequestarray[], powerobject requestorobject, boolean handlenow);
//	Check that at least one State has been mapped.
integer	stateRequestCount
stateRequestCount = UpperBound(stateRequestArray)
if stateRequestCount = 0 then return FAILURE

//	Loop through the requested states, add the event to the state map of each.
integer requestorIndex, eventIndex, stateIndex, i
n_cst_requestor	requestor
n_cst_event	lnv_Event
n_cst_state	state

//	Add requestor to the list.
requestorIndex = inv_RequestorArray.of_GetIndex(requestorObject)
requestor = inv_RequestorArray.invRequestors[requestorIndex]
requestor.Status = ONLINE

//	Add event to the list.
eventIndex = requestor.invEventArray.of_GetIndex(eventName)
lnv_Event = requestor.invEventArray.invEvents[eventIndex]

//	Loop through each state.
boolean newState
for	i = 1 to stateRequestCount
	
	//	Add states to the list.
	newState = false
	stateIndex = inv_StateArray.of_AddState(stateRequestArray[i], newState)
	state = inv_StateArray.invStates[stateIndex]
	inv_StateArray.invStates[stateIndex].Name = stateRequestArray[i]
	//	Add a referenct to the requestor to each state.
	inv_StateArray.invStates[stateIndex].FindAddRequestorIndex(requestorIndex)
	
	//	Add state to the list of states attached to this event.
	stateIndex = lnv_Event.invStateArray.of_AddState(stateRequestArray[i], newState)
	lnv_Event.invStateArray.invStates[stateIndex] = state	
	
	if	handleNow and not newState then
		requestor.HasEvents = true
		lnv_Event.NeedsProcessing = true
		of_SendEvents()
	end if
next

//	Finished.
return success

end function

on n_cst_statemsgrouter.create
call super::create
end on

on n_cst_statemsgrouter.destroy
call super::destroy
end on

event constructor;call super::constructor;
inv_StateArray = create n_cst_statearray
inv_RequestorArray = create n_cst_requestorarray

end event

event destructor;call super::destructor;
destroy inv_StateArray
destroy inv_RequestorArray

end event

