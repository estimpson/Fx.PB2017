$PBExportHeader$u_powerfilter_predeffilters.sru
forward
global type u_powerfilter_predeffilters from userobject
end type
type dw_1 from datawindow within u_powerfilter_predeffilters
end type
end forward

global type u_powerfilter_predeffilters from userobject
integer width = 946
integer height = 3680
long backcolor = 134217744
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global u_powerfilter_predeffilters u_powerfilter_predeffilters

type variables
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String is_ColType,is_Title,is_ColName,is_ColumnFilter,is_ddFilter
Integer ii_ColNum,ii_prevrow,ii_selectedrow[]

u_powerfilter_dropdown iu_powerfilter_dropdown
n_cst_powerfilter iu_powerfilter_checkbox
u_powerfilter_monthopts iu_powerfilter_monthopts
datawindow	idw_dw

//MultLang Support
String is_equals
String is_doesnotequal
String is_isgreaterthan
String is_isgreaterthanorequalto
String is_islessthan
String is_islessthanorequalto
String is_beginswith
String is_doesnotbeginwith
String is_endswith
String is_doesnotendwith
String is_contains
String is_doesnotcontain
String is_AboveAverage
String is_After_Ellipsis
String is_AllDatesinthePeriod_Ellipsis
String is_Before_Ellipsis
String is_BeginsWith_Ellipsis
String is_BelowAverage
String is_Between_Ellipsis
String is_Contains_Ellipsis
String is_CustomFilter_Ellipsis
String is_DoesNotContain_Ellipsis
String is_DoesNotEqual_Ellipsis
String is_EndsWith_Ellipsis
String is_Equals_Ellipsis
String is_GreaterThanOrEqualTo_Ellipsis
String is_GreaterThan_Ellipsis
String is_LastMonth
String is_LastQuarter
String is_LastWeek
String is_LastYear
String is_LessThanOrEqualTo_Ellipsis
String is_LessThan_Ellipsis
String is_NextMonth
String is_NextQuarter
String is_NextWeek
String is_NextYear
String is_ThisMonth
String is_ThisQuarter
String is_ThisWeek
String is_ThisYear
String is_Today
String is_Tomorrow
String is_YeartoDate
String is_Yesterday
String is_Averageis
String is_Equals_Cap

end variables

forward prototypes
public function integer of_setdropdown (ref userobject a_powerfilter_dropdown)
public function integer of_flagrow (integer ai_row)
public function integer of_setlist (string as_coltype, string as_colname, string as_title, integer ai_colnum)
public function integer of_restorestate ()
public function integer of_position ()
public function decimal of_getaverage ()
public function integer of_setmonthopts (ref userobject a_powerfilter_monthopts)
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_initialize (datawindow a_dw, ref nonvisualobject a_powerfilter_checkbox, integer ai_maxcol)
end prototypes

public function integer of_setdropdown (ref userobject a_powerfilter_dropdown);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//This function is called from the powerfilter checkbox user object to 
//link the dropdown with the predefined filter list
iu_powerfilter_dropdown = a_powerfilter_dropdown
return 0
end function

public function integer of_flagrow (integer ai_row);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF ii_prevrow > 0 THEN
	dw_1.SetItem(ii_prevrow,'Selected',0) //unselect previous row, if any
END IF
IF ai_row > 0 THEN
	dw_1.SetItem(ai_row,'Selected',1)
	ii_Prevrow = ai_row
ELSE
	ii_Prevrow = 0
END IF
ii_selectedrow[ii_colnum]=ii_Prevrow //save state of this column selection, either 0 or the row that was selected
return ii_Prevrow
end function

public function integer of_setlist (string as_coltype, string as_colname, string as_title, integer ai_colnum);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
is_ColType = as_ColType
is_colname = as_colname
is_Title = as_Title //visible column title for user to see in PowerTip, custom filter, etc.
ii_ColNum = ai_ColNum //save for passing back to of_BuildFilter
////////////////////////////////////////////////////////
//Filter the PreDefined Options based on the Column Type
////////////////////////////////////////////////////////

CHOOSE CASE LOWER(is_ColType)
	CASE 'date','datet','times'
		dw_1.SetFilter('datatype in ("Date","All")')
	CASE 'char(','char'
		dw_1.SetFilter('datatype in ("Char","All")')
	CASE 'int','long','numbe','real','ulong','decim'
		dw_1.SetFilter('datatype in ("Num","All")')
	CASE 'time'
		dw_1.SetFilter('datatype in ("Time","All")')
	CASE ELSE
		messagebox("Error",is_ColType + " column type for is_ColType not recognized")
		RETURN -1
END CHOOSE
dw_1.Filter()
dw_1.sort()
dw_1.height = dw_1.rowcount() * 88 + 44
this.height = dw_1.height + 16
of_restorestate() //restore any row that may have been selected
iu_powerfilter_monthopts.of_setlist( is_coltype,is_colname,is_title,ii_colnum)
Return 0
end function

public function integer of_restorestate ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//restores state of the list based on the column
Integer li_selectedrow,li_row
FOR li_row = 1 to dw_1.rowcount()
	dw_1.SetItem(li_row,'selected',0) //clear any possible flag from a different column
NEXT
li_selectedrow = ii_selectedrow[ii_colnum]
IF li_selectedrow > 0 THEN 
	dw_1.SetItem(li_selectedrow,'selected',1) //restore flag from this column, if any
END IF
RETURN 0
end function

public function integer of_position ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//Position the list based on associated dropdown and location on screen

this.x = iu_powerfilter_dropdown.x + iu_powerfilter_dropdown.width
//test to see if list goes off right side of window.  If so, move to other side of dropdown
IF this.x + this.width > parent.dynamic workspacewidth( ) THEN//idw_dw.width THEN 
	this.x = iu_powerfilter_dropdown.x - this.width
END IF
this.y = iu_powerfilter_dropdown.y + (88 * (iu_powerfilter_dropdown.dw_buttons.rowcount() - 1)) + 4
//test to see if list drops too low.  If so, position higher.
IF this.y + this.height > parent.dynamic workspaceheight( ) &
	AND parent.dynamic workspaceheight( ) - this.height > 0 THEN
	this.y = (parent.dynamic workspaceheight( ) - this.height)
END IF

Return 0
end function

public function decimal of_getaverage ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Decimal	ld_average
String	ls_return

ls_return = idw_dw.Modify( &
'create compute(band=foreground alignment="0" ' + &
'expression="avg(' + is_colname + '  for all )" ' + &
'border="0" color="255" x="1" y="1" height="1" width="1" format="[GENERAL]" html.valueishtml="0"  ' + &
'name=powerfilter_computed_average ' + &
'visible="0"  ' + &
'font.face="Tahoma" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" ' + &
'background.mode="2" background.color="0" )')

//check to see if any filtered values needing to be added back into the average
IF idw_dw.filteredcount() > 0 THEN
	//turn off redraw, clear existing filter before capture average
	//no need to reapply original filter or turn on redraw, since new filter gets applied jsut after this, and redraw is turned off and on then
	idw_dw.setredraw(FALSE)
	IF iu_powerfilter_checkbox.maintainoriginalfilter THEN
		String ls_OriginalFilter
		iu_powerfilter_checkbox.of_GetOriginalFilter(ls_OriginalFilter)
		idw_dw.SetFilter(ls_OriginalFilter)
	ELSE
		idw_dw.SetFilter('')
	END IF
	idw_dw.Filter()
END IF
ld_average = dec(idw_dw.Object.powerfilter_computed_average[1])
ls_return = idw_dw.Modify("destroy powerfilter_computed_average")

Return ld_average
end function

public function integer of_setmonthopts (ref userobject a_powerfilter_monthopts);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//This function is called from the powerfilter checkbox user object to 
//link the dropdown with the predefined filter list
iu_powerfilter_monthopts = a_powerfilter_monthopts
return 0
end function

public function integer of_setlanguage (integer ai_languagenumber);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_lang,li_row,li_rows
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

li_lang = ai_languagenumber //offset already done in checkbox, English = 0, is in column 2

is_equals = lds_lang.GetItemString(2,li_lang)
is_doesnotequal = lds_lang.GetItemString(3,li_lang)
is_isgreaterthan = lds_lang.GetItemString(4,li_lang)
is_isgreaterthanorequalto = lds_lang.GetItemString(5,li_lang)
is_islessthan = lds_lang.GetItemString(6,li_lang)
is_islessthanorequalto = lds_lang.GetItemString(7,li_lang)
is_beginswith = lds_lang.GetItemString(8,li_lang)
is_doesnotbeginwith = lds_lang.GetItemString(9,li_lang)
is_endswith = lds_lang.GetItemString(10,li_lang)
is_doesnotendwith = lds_lang.GetItemString(11,li_lang)
is_contains = lds_lang.GetItemString(12,li_lang)
is_doesnotcontain = lds_lang.GetItemString(13,li_lang)
is_AboveAverage = lds_lang.GetItemString(14,li_lang)
is_After_Ellipsis = lds_lang.GetItemString(15,li_lang)
is_AllDatesinthePeriod_Ellipsis = lds_lang.GetItemString(16,li_lang)
is_Before_Ellipsis = lds_lang.GetItemString(17,li_lang)
is_BeginsWith_Ellipsis = lds_lang.GetItemString(18,li_lang)
is_BelowAverage = lds_lang.GetItemString(19,li_lang)
is_Between_Ellipsis = lds_lang.GetItemString(20,li_lang)
is_Contains_Ellipsis = lds_lang.GetItemString(21,li_lang)
is_CustomFilter_Ellipsis = lds_lang.GetItemString(22,li_lang)
is_DoesNotContain_Ellipsis = lds_lang.GetItemString(23,li_lang)
is_DoesNotEqual_Ellipsis = lds_lang.GetItemString(24,li_lang)
is_EndsWith_Ellipsis = lds_lang.GetItemString(25,li_lang)
is_Equals_Ellipsis = lds_lang.GetItemString(26,li_lang)
is_GreaterThanOrEqualTo_Ellipsis = lds_lang.GetItemString(27,li_lang)
is_GreaterThan_Ellipsis = lds_lang.GetItemString(28,li_lang)
is_LastMonth = lds_lang.GetItemString(29,li_lang)
is_LastQuarter = lds_lang.GetItemString(30,li_lang)
is_LastWeek = lds_lang.GetItemString(31,li_lang)
is_LastYear = lds_lang.GetItemString(32,li_lang)
is_LessThanOrEqualTo_Ellipsis = lds_lang.GetItemString(33,li_lang)
is_LessThan_Ellipsis = lds_lang.GetItemString(34,li_lang)
is_NextMonth = lds_lang.GetItemString(35,li_lang)
is_NextQuarter = lds_lang.GetItemString(36,li_lang)
is_NextWeek = lds_lang.GetItemString(37,li_lang)
is_NextYear = lds_lang.GetItemString(38,li_lang)
is_ThisMonth = lds_lang.GetItemString(39,li_lang)
is_ThisQuarter = lds_lang.GetItemString(40,li_lang)
is_ThisWeek = lds_lang.GetItemString(41,li_lang)
is_ThisYear = lds_lang.GetItemString(42,li_lang)
is_Today = lds_lang.GetItemString(43,li_lang)
is_Tomorrow = lds_lang.GetItemString(44,li_lang)
is_YeartoDate = lds_lang.GetItemString(45,li_lang)
is_Yesterday = lds_lang.GetItemString(46,li_lang)

is_Averageis = lds_lang.GetItemString(68,li_lang)
is_Equals_Cap = lds_lang.GetItemString(75,li_lang)
DESTROY lds_lang

li_rows = dw_1.rowcount()
li_row = dw_1.Find("filtertype = 'Equals...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_equals_ellipsis)
li_row = dw_1.Find("filtertype = 'Does Not Equal...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_DoesNotEqual_Ellipsis )
li_row = dw_1.Find("filtertype = 'Begins With...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_beginswith_ellipsis )
li_row = dw_1.Find("filtertype = 'Ends With...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_endswith_ellipsis )
li_row = dw_1.Find("filtertype = 'Contains...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_contains_ellipsis )
li_row = dw_1.Find("filtertype = 'Does Not Contain...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_doesnotcontain_ellipsis )
li_row = dw_1.Find("filtertype = 'Greater Than...' and datatype = 'Num'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_greaterthan_ellipsis )
li_row = dw_1.Find("filtertype = 'Greater Than Or Equal To...' and datatype = 'Num'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_greaterthanorequalto_ellipsis )
li_row = dw_1.Find("filtertype = 'Less Than...' and datatype = 'Num'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lessthan_ellipsis )
li_row = dw_1.Find("filtertype = 'Less Than Or Equal To...' and datatype = 'Num'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lessthanorequalto_ellipsis )
li_row = dw_1.Find("filtertype = 'Between...' and datatype = 'Num'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_between_ellipsis )
li_row = dw_1.Find("filtertype = 'Above Average'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_aboveaverage )
li_row = dw_1.Find("filtertype = 'Below Average'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_belowaverage )
li_row = dw_1.Find("filtertype = 'Greater Than...' and datatype = 'Time'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_greaterthan_ellipsis )
li_row = dw_1.Find("filtertype = 'Greater Than Or Equal To...' and datatype = 'Time'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_greaterthanorequalto_ellipsis )
li_row = dw_1.Find("filtertype = 'Less Than...' and datatype = 'Time'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lessthan_ellipsis )
li_row = dw_1.Find("filtertype = 'Less Than Or Equal To...' and datatype = 'Time'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lessthanorequalto_ellipsis )
li_row = dw_1.Find("filtertype = 'Between...' and datatype = 'Time'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_between_ellipsis )
li_row = dw_1.Find("filtertype = 'Before...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_before_ellipsis )
li_row = dw_1.Find("filtertype = 'After...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_after_ellipsis )
li_row = dw_1.Find("filtertype = 'Between...' and datatype = 'Date'" , 1, li_rows) 
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_between_ellipsis )
li_row = dw_1.Find("filtertype = 'Tomorrow'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_tomorrow )
li_row = dw_1.Find("filtertype = 'Today'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_today )
li_row = dw_1.Find("filtertype = 'Yesterday'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_yesterday )
li_row = dw_1.Find("filtertype = 'Next Week'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_nextweek )
li_row = dw_1.Find("filtertype = 'This Week'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_thisweek )
li_row = dw_1.Find("filtertype = 'Last Week'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lastweek )
li_row = dw_1.Find("filtertype = 'Next Month'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_nextmonth )
li_row = dw_1.Find("filtertype = 'This Month'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_thismonth )
li_row = dw_1.Find("filtertype = 'Last Month'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lastmonth )
li_row = dw_1.Find("filtertype = 'Next Quarter'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_nextquarter )
li_row = dw_1.Find("filtertype = 'This Quarter'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_thisquarter )
li_row = dw_1.Find("filtertype = 'Last Quarter'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lastquarter )
li_row = dw_1.Find("filtertype = 'Next Year'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_nextyear )
li_row = dw_1.Find("filtertype = 'This Year'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_thisyear )
li_row = dw_1.Find("filtertype = 'Last Year'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_lastyear )
li_row = dw_1.Find("filtertype = 'Year to Date'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_yeartodate )
li_row = dw_1.Find("filtertype = 'All Dates in the Period...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_alldatesintheperiod_ellipsis )
li_row = dw_1.Find("filtertype = 'Custom Filter...'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_customfilter_ellipsis )

RETURN 0
end function

public function integer of_initialize (datawindow a_dw, ref nonvisualobject a_powerfilter_checkbox, integer ai_maxcol);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer li_col
this.visible = FALSE

idw_dw = a_dw
iu_powerfilter_checkbox = a_powerfilter_checkbox

FOR li_col = 1 to ai_maxcol
	ii_selectedrow[li_col]=0
NEXT

RETURN 0

end function

on u_powerfilter_predeffilters.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_powerfilter_predeffilters.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_powerfilter_predeffilters
event ue_mousemove pbm_dwnmousemove
event ue_dwnkey pbm_dwnkey
event ue_setrow ( integer row )
string tag = " //MULTILANG in the shared data in the dataobject"
integer x = 5
integer y = 4
integer width = 933
integer height = 3656
integer taborder = 10
string title = "none"
string dataobject = "d_powerfilter_filteropts"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF KeyDown(KeyLeftArrow!) or &
	KeyDown(KeyRightArrow!) or &
	KeyDown(KeyUpArrow!) or &
	KeyDown(KeyDownArrow!) or & 
	KeyDown(KeyTab!) THEN RETURN
	
IF row = this.rowcount() - 1 THEN
	CHOOSE CASE lower(is_ColType)
		CASE 'date','datet'
			iu_powerfilter_monthopts.dw_1.SetFocus()
			iu_powerfilter_monthopts.visible = TRUE 
	END CHOOSE
ELSE
	iu_powerfilter_monthopts.visible = FALSE
	this.SetFocus()
END IF
this.setrow(row)
end event

event ue_dwnkey;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF key = KeyLeftArrow! THEN
	//go back to dropdown, close this list
	iu_powerfilter_dropdown.dw_buttons.setfocus()
	iu_powerfilter_dropdown.dw_buttons.setrow(iu_powerfilter_dropdown.dw_buttons.rowcount())
	parent.visible = FALSE
END IF
IF this.getrow() = this.rowcount() -1 THEN
	CHOOSE CASE lower(is_ColType)
		CASE 'date','datet'
			CHOOSE CASE key
				CASE KeyRightArrow!
					iu_powerfilter_monthopts.dw_1.SetFocus()
					iu_powerfilter_monthopts.Visible = TRUE 
			END CHOOSE
	END CHOOSE
END IF
IF key = KeyDownArrow! and this.getrow() = this.rowcount() THEN
	this.event post ue_setrow(1) //scroll from bottom to top
END IF
IF key = KeyUpArrow! and this.getrow() = 1 THEN
	this.event post ue_setrow(this.rowcount()) //scroll from top to bottom
END IF

IF key = KeyEnter! THEN
	//Enter usually scrolls down on DW, I want to trigger click
	parent.visible = FALSE //don't let them see scrolldown that gets corrected later
	DWObject dwo_column
	dwo_column = this.object.filtertype
	this.event post clicked( PointerX(), Pointery(), this.getrow(), dwo_column)
	//need to adjust final location since Enter still scrolls to next line
	this.event post ue_setrow(this.getrow())
END IF
end event

event ue_setrow(integer row);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//this is for scrolling from top to bottom or bottom to top
//post to this event in the key event to set the row after the keypress has been processed.
//otherwise, the top row or bottom row get skipped
this.setrow(row)
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String ls_FilterType
String ls_parm1,ls_parm2,ls_Filter1,ls_Filter2,ls_AndOr
String ls_DayName //,ls_PowerTip
Date		ld_Date,ld_EndDate
Decimal	ld_average
Integer li_Day,li_currentmonth,li_StartMonth,li_EndMonth,li_Month,li_currentyear,li_Year
Integer li_Return,li_row

ls_AndOr = 'And'
li_row = row
IF li_row = 0 THEN li_row = this.rowcount()

ls_FilterType = This.GetItemString(li_row,'filtertype')
CHOOSE CASE Lower(ls_FilterType)
	CASE 'equals...'
		ls_Filter1 = 'Equals'
	CASE 'does not equal...'
		ls_Filter1 = 'Does Not Equal'
	CASE 'begins with...'
		ls_Filter1 = 'Begins With'
	CASE 'ends with...'
		ls_Filter1 = 'Ends with'
	CASE 'contains...'
		ls_Filter1 = 'Contains'
	CASE 'does not contain...'
		ls_Filter1 = 'Does Not Contain'
	CASE 'less than...','before...'
		ls_Filter1 = 'Is Less Than'
	CASE 'greater than...','after...'
		ls_Filter1 = 'Is Greater Than'
	CASE 'less than or equal to...'
		ls_Filter1 = 'Is Less Than Or Equal To'
	CASE 'greater than or equal to...'
		ls_Filter1 = 'Is Greater Than Or Equal To'
	CASE 'between...'
		ls_Filter1 = 'Is Greater Than Or Equal To'
		ls_Filter2 = 'Is Less Than Or Equal To'
		ls_AndOr = 'And'
	CASE 'above average'
		ld_average = of_GetAverage()
		ls_parm1 = String(ld_average) 
//		ls_PowerTip = ls_FilterType + '.~r~n~r~n(' + is_Averageis + ' ' +String(ld_average,'#,##0.00') +')' //set the PowerTip based on the PreDefined Label //MULTILANG Average is
		ls_Filter1 = 'Is Greater Than'
	CASE 'below average'
		ld_average = of_GetAverage()
		ls_parm1 = String(ld_average) 
//		ls_PowerTip = ls_FilterType + '.~r~n~r~n(' + is_Averageis + ' ' +String(ld_average,'#,##0.00') +')' //set the PowerTip based on the PreDefined Label //MULTILANG Average is
		ls_Filter1 = 'Is Less Than'
	CASE 'tomorrow'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		//determine tomorrows date, set parms, and go, without displaying custom filter window
		ls_Filter1 = 'Equals'
		ls_Parm1 = String(RelativeDate ( today(), 1 ))
	CASE 'today'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Equals'
		ls_Parm1 = String(today())
	CASE 'yesterday'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Equals'
		ls_Parm1 = String(RelativeDate ( today(), -1 ))
	CASE 'next week'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		//define week as Sun-Sat, so test dayname, loop back until = Sunday, then add 7 days and use modified BETWEEN logic
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_date = RelativeDate(Today(),7) //1 week from today puts me into next week, then same logic as this week
		ls_dayname = DayName ( ld_date )
		DO UNTIL ls_dayname = 'Sunday'
			ld_date = RelativeDate( ld_date,-1)
			ls_dayname = DayName ( ld_date )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(RelativeDate( ld_date,7))
	CASE 'this week'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		//define week as Sun-Sat, so test dayname, loop back until = Sunday, then add 7 days and use modified BETWEEN logic
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_date = Today()
		ls_dayname = DayName ( ld_date )
		DO UNTIL ls_dayname = 'Sunday'
			ld_date = RelativeDate( ld_date,-1)
			ls_dayname = DayName ( ld_date )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(RelativeDate( ld_date,7))
	CASE 'last week'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		//define week as Sun-Sat, so test dayname, loop back until = Sunday, then add 7 days and use modified BETWEEN logic
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_date = RelativeDate(Today(),-7) //1 week before today puts me into last week, then same logic as this week
		ls_dayname = DayName ( ld_date )
		DO UNTIL ls_dayname = 'Sunday'
			ld_date = RelativeDate( ld_date,-1)
			ls_dayname = DayName ( ld_date )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(RelativeDate( ld_date,7))
	CASE 'next month'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_date = RelativeDate(Today(),1) //start with tomorrow, loop until day = 1, then loop until month changes
		li_day = Day ( ld_date )
		DO UNTIL li_day = 1
			ld_date = RelativeDate( ld_date,1)
			li_day = Day ( ld_date )
		LOOP
		ld_EndDate = RelativeDate(ld_date,28) //no need to loop 1st 28 days to get to 1st of next month
		li_day = Day ( ld_EndDate )
		DO UNTIL li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'this month'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_date = Today() //start with today, loop back until day = 1, then loop until month changes
		li_day = Day ( ld_date )
		DO UNTIL li_day = 1
			ld_date = RelativeDate( ld_date,-1)
			li_day = Day ( ld_date )
		LOOP
		ld_EndDate = RelativeDate(ld_date,28) //no need to loop 1st 28 days to get to 1st of next month
		li_day = Day ( ld_EndDate )
		DO UNTIL li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'last month'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_enddate = Today() //start with today, loop back until day = 1, then loop until month changes
		li_day = Day ( ld_enddate )
		DO UNTIL li_day = 1
			ld_enddate = RelativeDate( ld_enddate,-1)
			li_day = Day ( ld_enddate )
		LOOP
		ld_Date = RelativeDate(ld_enddate,-28) //no need to loop 1st 28 days to get to 1st of last month
		li_day = Day ( ld_Date )
		DO UNTIL li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
		LOOP
		ls_Parm1 = String(ld_date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'next quarter'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		//determine quarter based on month
		li_currentmonth = month(today())
		CHOOSE CASE li_currentmonth
			CASE 1,2,3
				li_StartMonth = 4
				li_EndMonth = 7
			CASE 4,5,6
				li_StartMonth = 7
				li_EndMonth = 10
			CASE 7,8,9
				li_StartMonth = 10
				li_EndMonth = 1
			CASE 10,11,12
				li_StartMonth = 1
				li_EndMonth = 4
		END CHOOSE
		ld_Date = today()
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = li_StartMonth and li_day = 1
			ld_Date = RelativeDate( ld_Date,1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ld_EndDate = RelativeDate(ld_date,90) //always at least 90 days in a quarter (31+28+31=90)
		li_Day = Day(ld_EndDate)
		li_Month = Month(ld_EndDate)
		DO UNTIL li_Month = li_EndMonth and li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
			li_Month = Month(ld_EndDate)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'this quarter'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		//determine quarter based on month
		li_currentmonth = month(today())
		CHOOSE CASE li_currentmonth
			CASE 1,2,3
				li_StartMonth = 1
				li_EndMonth = 4
			CASE 4,5,6
				li_StartMonth = 4
				li_EndMonth = 7
			CASE 7,8,9
				li_StartMonth = 7
				li_EndMonth = 10
			CASE 10,11,12
				li_StartMonth = 10
				li_EndMonth = 1
		END CHOOSE
		ld_Date = today()
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = li_StartMonth and li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ld_EndDate = RelativeDate(ld_date,90) //always at least 90 days in a quarter (31+28+31=90)
		li_Day = Day(ld_EndDate)
		li_Month = Month(ld_EndDate)
		DO UNTIL li_Month = li_EndMonth and li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
			li_Month = Month(ld_EndDate)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'last quarter'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		//determine quarter based on month
		li_currentmonth = month(today())
		CHOOSE CASE li_currentmonth
			CASE 1,2,3
				li_StartMonth = 10
				li_EndMonth = 1
			CASE 4,5,6
				li_StartMonth = 1
				li_EndMonth = 4
			CASE 7,8,9
				li_StartMonth = 4
				li_EndMonth = 7
			CASE 10,11,12
				li_StartMonth = 7
				li_EndMonth = 10
		END CHOOSE
		ld_Date = today()
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = li_StartMonth and li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ld_EndDate = RelativeDate(ld_date,90) //always at least 90 days in a quarter (31+28+31=90)
		li_Day = Day(ld_EndDate)
		li_Month = Month(ld_EndDate)
		DO UNTIL li_Month = li_EndMonth and li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
			li_Month = Month(ld_EndDate)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'next year'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_Date = today()
		li_CurrentYear = year(ld_Date)
		li_Year = Year(ld_Date)
		DO UNTIL li_Year <> li_CurrentYear
			ld_Date = RelativeDate( ld_Date,1)
			li_Year = Year ( ld_Date )
		LOOP
		ld_EndDate = RelativeDate(ld_date,365) //always at least 365 days in a year
		li_Day = Day(ld_EndDate)
		li_Month = Month(ld_EndDate)
		DO UNTIL li_Month = 1 and li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
			li_Month = Month(ld_EndDate)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'this year'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_Date = today()
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = 1 and li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ld_EndDate = RelativeDate(ld_date,365) //always at least 365 days in a year
		li_Day = Day(ld_EndDate)
		li_Month = Month(ld_EndDate)
		DO UNTIL li_Month = 1 and li_day = 1
			ld_EndDate = RelativeDate( ld_EndDate,1)
			li_day = Day ( ld_EndDate )
			li_Month = Month(ld_EndDate)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'last year'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_EndDate = today()
		li_CurrentYear = year(ld_EndDate)
		li_Year = Year(ld_EndDate)
		DO UNTIL li_Year <> li_CurrentYear
			ld_EndDate = RelativeDate( ld_EndDate,-1)
			li_Year = Year ( ld_EndDate )
		LOOP
		ld_EndDate = RelativeDate( ld_EndDate,1)
		ld_Date = RelativeDate(ld_EndDate,-365) //always at least 365 days in a year
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = 1 and li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'year to date'
//		ls_PowerTip = ls_FilterType //set the PowerTip based on the PreDefined Label
		ls_Filter1 = 'Is Greater Than or equal to'
		ls_Filter2 = 'Is Less Than' 
		ls_AndOr = 'And'
		ld_Date = today()
		ld_EndDate = RelativeDate(ld_Date,1)
		li_Day = Day(ld_Date)
		li_Month = Month(ld_Date)
		DO UNTIL li_Month = 1 and li_day = 1
			ld_Date = RelativeDate( ld_Date,-1)
			li_day = Day ( ld_Date )
			li_Month = Month(ld_Date)
		LOOP
		ls_Parm1 = String(ld_Date)
		ls_Parm2 = String(ld_EndDate)
	CASE 'all dates in the period...'
		RETURN //ignore click on all dates, since it opens another list automatically
	CASE 'custom filter...'
END CHOOSE		
li_return = iu_powerfilter_dropdown.of_customfilter( ls_Filter1,ls_parm1,ls_Filter2,ls_parm2,ls_AndOr)
IF li_return = 0 THEN
	//customfilter returned successfully, flag which option was used
//	IF ls_PowerTip <> '' THEN 
//		idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".tooltip.tip='"+is_Equals_cap+" "+ls_PowerTip+"'") //MULTILANG Equals
//	END IF
	parent.of_flagrow(li_row)
	iu_powerfilter_monthopts.of_flagrow(0)
ELSE
	//custom filter failed or user pressed cancel
END IF
iu_powerfilter_dropdown.of_close()
iu_powerfilter_dropdown.of_savestate()	
idw_dw.setfocus( ) //restore focus to datawindow
end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
GraphicObject which_control
PowerObject	which_Parent

which_control = GetFocus() //identify the control that has focus
IF isvalid(which_control) THEN
	which_Parent = which_control.getparent( ) //get the parent of that control
	IF which_Parent = iu_powerfilter_dropdown THEN
		iu_powerfilter_dropdown.event post ue_checkfocus()
		RETURN //Dropdown parent for this user object still has control
	ELSEIF which_Parent = iu_powerfilter_monthopts THEN
		RETURN //month options has control, keep this and dropdown visible
	END IF
END IF
//If not valid (clicked outside of application?) or not this User Object control, then close this dropdown
parent.visible=FALSE
iu_powerfilter_dropdown.event post ue_checkfocus()

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
parent.of_position( ) //position list when getting focus, which should be just before becoming visible

end event

