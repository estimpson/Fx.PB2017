$PBExportHeader$u_dw_releaseschedule.sru
forward
global type u_dw_releaseschedule from u_dw
end type
type st_releasesched from structure within u_dw_releaseschedule
end type
end forward

type st_releasesched from structure
	decimal { 0 }		order_no
	string		part_number
	string		customer_part
	long		suffix
	decimal { 6 }		past
	long		pasttype
	decimal { 6 }		day1
	long		day1type
	decimal { 6 }		day2
	long		day2type
	decimal { 6 }		day3
	long		day3type
	decimal { 6 }		day4
	long		day4type
	decimal { 6 }		day5
	long		day5type
	decimal { 6 }		day6
	long		day6type
	decimal { 6 }		day7
	long		day7type
	decimal { 6 }		future
	long		futuretype
	long		pastsequence
	long		day1sequence
	long		day2sequence
	long		day3sequence
	long		day4sequence
	long		day5sequence
	long		day6sequence
	long		day7sequence
	long		futuresequence
	integer		maxcolumn
end type

global type u_dw_releaseschedule from u_dw
integer width = 3406
integer height = 1048
string dragicon = "Rectangle!"
string dataobject = "d_resleaseschedule"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
event ue_rangecleared()
event ue_rangeselected()
event mousemove pbm_mousemove
end type
global u_dw_releaseschedule u_dw_releaseschedule

forward prototypes
private function integer of_checkrange()
private function integer of_gettoken(string as_expression, character ac_delimiter, ref long al_start, ref string as_value)
private function integer of_setrange(string as_range)
public function integer of_selectall()
public function integer of_clear()
public function integer of_getrange(ref long al_orderno[], ref long al_sequence[], ref double adbl_quantity[], ref string as_part[], ref long al_suffix[])
end prototypes

event mousemove;
//	Check if datawindow has a selected region.
if object.datawindow.selected = "" then
	post event ue_rangecleared()
	return
end if

//	Send range selected message.
post event ue_rangeselected()


end event

private function integer of_checkrange();
//	Declarations.
string	ls_Range
string	ls_Token
string	ls_SubToken

integer	li_ReturnValue = 0
integer	li_CurrentColumn
integer	li_Column

long	ll_NextToken = 0
long	ll_NextSubToken
long	ll_CurrentRow
long	ll_BeginRow
long	ll_EndRow

//	Initializations.
ls_Range = object.datawindow.selected
ll_CurrentRow = GetClickedRow()
li_CurrentColumn = GetClickedColumn()

//	Do not process zero row clicks.
if ll_CurrentRow = 0 then return 0

//	Loop through tokens.
do
	of_GetToken(ls_Range, ';', ll_NextToken, ls_Token)
	
	//	Get begin row and end row(the first two SubTokens).
	ll_NextSubToken = 0
	of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
	ll_BeginRow = Long(ls_SubToken)
	of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
	ll_EndRow = Long(ls_SubToken)
	
	//	Check row range.
	if ll_CurrentRow <= ll_EndRow and ll_CurrentRow >= ll_BeginRow then
		
		//	Get all the columns(SubTokens).
		do
			of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
			li_Column = Integer(Describe(ls_SubToken + ".id"))
			
			//	Check column.
			if li_CurrentColumn = li_Column then
				
				//	Begin dragging.
				Drag(Begin!)
				
				//	Ensure dragging still shows range.
				post function of_SetRange(ls_Range)
			end if
		loop while ll_NextSubToken > 0
	end if		
	
loop while ll_NextToken > 0

//	Return.
return 0

end function

private function integer of_gettoken(string as_expression, character ac_delimiter, ref long al_start, ref string as_value);
//	Declarations.
integer	li_ReturnValue = 1

long	ll_Length
long	ll_DelimPos

//	Initializations.
ll_Length = Len(as_Expression)

//	Find delimiter.
ll_DelimPos = Pos(as_Expression, ac_Delimiter, al_Start + 1)

//	If found set value to portion of string up to delimiter.  Set retun value to indicate more.
if ll_DelimPos > 0 then
	as_Value = Mid(as_Expression, al_Start + 1, ll_DelimPos - al_Start - 1)
else
//	Otherwise set value to whole expression.
	as_Value = Mid(as_Expression, al_Start + 1, ll_Length)
end if
al_Start = ll_DelimPos

//	Return.
return li_ReturnValue
end function

private function integer of_setrange(string as_range);
//	Set selected range.
object.datawindow.selected = as_Range

//	Make sure range was selected, otherwise send range cleared message.
if as_Range = "" then
	post event ue_rangecleared()
	return 0
end if

//	Send range selected message.
post event ue_rangeselected()

//	Return.
Return 0
end function

public function integer of_selectall();
//	Declarations.
string	ls_Range
string	ls_Columns = "/part_customer_part/past_due/day_1/day_2/day_3/day_4/day_5/day_6/day_7"

long	ll_EndRow

//	Initializations.
ll_EndRow = RowCount()
ls_Range = "1/" + String(ll_EndRow) + ls_Columns

//	Assing range to datawindow selected.
Object.Datawindow.Selected = ls_Range

//	Make sure range was selected, otherwise send range cleared message.
if ls_Range = "" then
	post event ue_rangecleared()
	return 0
end if

//	Send range selected message.
post event ue_rangeselected()


//	Return.
return 0
end function

public function integer of_clear();
//	Clear datawindow selected.
object.datawindow.selected = ""

//	Send range cleared message.
post event ue_rangecleared()

//	Return.
return 0
end function

public function integer of_getrange(ref long al_orderno[], ref long al_sequence[], ref double adbl_quantity[], ref string as_part[], ref long al_suffix[]);
//	Declarations.
constant integer	DAY7 = 9
constant integer	DAY6 = 8
constant integer	DAY5 = 7
constant integer	DAY4 = 6
constant integer	DAY3 = 5
constant integer	DAY2 = 4
constant integer	DAY1 = 3
constant integer	PASTDUE = 2
constant integer	NOQTY = 1

integer	li_ReturnRows = 0
integer	li_ReturnValue = 0
integer	li_Column

long	ll_NextToken = 0
long	ll_NextSubToken
long	ll_Row
long	ll_BeginRow
long	ll_EndRow

string	ls_Range
string	ls_Token
string	ls_SubToken

st_releasesched lst_ReleaseSched [ ]

//	Initializations.
ls_Range = object.datawindow.selected
lst_ReleaseSched = object.data

//	Make sure range was selected.
if ls_Range = "" then
	return 0
end if

//	Loop through tokens.
do
	of_GetToken(ls_Range, ';', ll_NextToken, ls_Token)
	
	//	Get begin row and end row(the first two SubTokens).
	ll_NextSubToken = 0
	of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
	ll_BeginRow = Long(ls_SubToken)
	of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
	ll_EndRow = Long(ls_SubToken)
	
	//	Get all the columns(SubTokens).
	do
		of_GetToken(ls_Token, '/', ll_NextSubToken, ls_SubToken)
		
		//	The subtoken is the name of a column that has been selected.
		//	Each column corresponds to the past due or one of the seven daily
		//	buckets or is outside of the range.  Rows which are selected
		//	but do not have a column in the bucket range selected are still
		//	added to the schedule, but with a zero quantity.
		choose case ls_SubToken
			case "past_due"
				li_Column = PASTDUE
			case "day_1"
				li_Column = DAY1
			case "day_2"
				li_Column = DAY2
			case "day_3"
				li_Column = DAY3
			case "day_4"
				li_Column = DAY4
			case "day_5"
				li_Column = DAY5
			case "day_6"
				li_Column = DAY6
			case "day_7"
				li_Column = DAY7
			case else
				li_Column = NOQTY
		end choose
		
		//li_Column = Integer(Describe(ls_SubToken + ".id"))
				
		//	Check row range.
		for ll_Row = ll_BeginRow to ll_EndRow
			
			//	Check column.
			if lst_ReleaseSched [ ll_Row ].maxcolumn < li_Column then
				
				//	Set maxcolumn.
				lst_ReleaseSched [ ll_Row ].maxcolumn = li_Column
			end if
		next
	loop while ll_NextSubToken > 0
	
loop while ll_NextToken > 0

//	Loop through all rows and add those which have a maxcolumn > 0 to the array to pass back.
ll_EndRow = UpperBound(lst_ReleaseSched)
for ll_Row = 1 to ll_EndRow
	
	//	Action depends on maxcolumn for this row.
	choose case lst_ReleaseSched [ ll_Row ].maxcolumn
		case DAY7
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day7sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2 +&
				lst_ReleaseSched [ ll_Row ].day3 +&
				lst_ReleaseSched [ ll_Row ].day4 +&
				lst_ReleaseSched [ ll_Row ].day5 +&
				lst_ReleaseSched [ ll_Row ].day6 +&
				lst_ReleaseSched [ ll_Row ].day7
		case DAY6
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day6sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2 +&
				lst_ReleaseSched [ ll_Row ].day3 +&
				lst_ReleaseSched [ ll_Row ].day4 +&
				lst_ReleaseSched [ ll_Row ].day5 +&
				lst_ReleaseSched [ ll_Row ].day6
		case DAY5
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day5sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2 +&
				lst_ReleaseSched [ ll_Row ].day3 +&
				lst_ReleaseSched [ ll_Row ].day4 +&
				lst_ReleaseSched [ ll_Row ].day5
		case DAY4
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day4sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2 +&
				lst_ReleaseSched [ ll_Row ].day3 +&
				lst_ReleaseSched [ ll_Row ].day4
		case DAY3
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day3sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2 +&
				lst_ReleaseSched [ ll_Row ].day3
		case DAY2
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day2sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1 +&
				lst_ReleaseSched [ ll_Row ].day2
		case DAY1
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].day1sequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past +&
				lst_ReleaseSched [ ll_Row ].day1
		case PASTDUE
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].pastsequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] =&
				lst_ReleaseSched [ ll_Row ].past
		case NOQTY
			//	Increment return rows and calculate quantity.
			li_ReturnRows ++
			al_OrderNo [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].order_no
			al_Sequence [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].pastsequence
			as_Part [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].part_number
			al_Suffix [ li_ReturnRows ] = lst_ReleaseSched [ ll_Row ].suffix
			adbl_Quantity [ li_ReturnRows ] = 0
	end choose
next

//	Return.
return 0

end function

event clicked;call super::clicked;
//	Check if clicked cell is already selected.
of_CheckRange()
end event

event retrievestart;call super::retrievestart;
//	Clear any datawindow selection.
object.datawindow.selected = ""

//	Send range cleared message.
post event ue_rangecleared()
end event

event constructor;call super::constructor;
//	Set Transaction Object and Retrieve.
SetTransObject(SQLCA)

//	Turn off Row Selection service.
of_SetRowSelect(false)

//	Turn off PFC right button popup menu so that our own can be used.
ib_RMBMenu = false
end event

on u_dw_releaseschedule.create
call super::create
end on

on u_dw_releaseschedule.destroy
call super::destroy
end on

