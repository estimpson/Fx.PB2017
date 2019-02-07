$PBExportHeader$u_powerfilter_dropdown.sru
forward
global type u_powerfilter_dropdown from userobject
end type
type p_1 from picture within u_powerfilter_dropdown
end type
type r_2 from rectangle within u_powerfilter_dropdown
end type
type p_resizer from picture within u_powerfilter_dropdown
end type
type cb_cancel from commandbutton within u_powerfilter_dropdown
end type
type cb_ok from commandbutton within u_powerfilter_dropdown
end type
type cbx_1 from checkbox within u_powerfilter_dropdown
end type
type dw_powerfilter from datawindow within u_powerfilter_dropdown
end type
type dw_buttons from datawindow within u_powerfilter_dropdown
end type
type ln_1 from line within u_powerfilter_dropdown
end type
type shl_msg from statichyperlink within u_powerfilter_dropdown
end type
end forward

global type u_powerfilter_dropdown from userobject
boolean visible = false
integer width = 1070
integer height = 1400
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_checkfocus ( )
p_1 p_1
r_2 r_2
p_resizer p_resizer
cb_cancel cb_cancel
cb_ok cb_ok
cbx_1 cbx_1
dw_powerfilter dw_powerfilter
dw_buttons dw_buttons
ln_1 ln_1
shl_msg shl_msg
end type
global u_powerfilter_dropdown u_powerfilter_dropdown

type variables
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Datawindow	idw_dw //datawindow that is being filtered
datastore	ids_powerfilter[] //array of datastores to hold items picklist, 1 for each column
String	is_ddFilter //filter for dropdownlist
String	is_ColName,is_Title,is_ColumnFilter,is_ColType,is_DefaultTipText,is_ColFormat
n_cst_powerfilter	iu_powerfilter_checkbox //pointer to the checkbox on the window so the of_buildfilter function can be called
u_powerfilter_predeffilters  iu_powerfilter_predeffilters
u_powerfilter_monthopts iu_powerfilter_monthopts
Integer	ii_ColNum //reference to the column number so the columnfilter can be properly passed back to build the whole filter
Integer	ii_MaxItems //sets the maximum number of items (number of items to add via loop) in the dropdown list, passed from checkbox during initialization

// --Other. --
integer	ii_minwidth  //minimum allowable size of the dropdown
integer	ii_minheight //minimum allowable height of the dropdown
integer	ii_maxwidth  //maximum allowable size of the dropdown
integer	ii_maxheight //maximum allowable height of the dropdown

//-- control offsets for resizing dropdown --
Integer	ii_dwXOffset,ii_dwYOffset
Integer	ii_dwbXOffset,ii_dwbYOffset
Integer	ii_OKXOffset,ii_OKYOffset
Integer	ii_CanXOffset,ii_CanYOffset
Integer	ii_resizerXOffset,ii_resizerYOffset
Integer	ii_rectXOffset,ii_rectYOffset
Integer	ii_lineyoffset,ii_evalxoffset,ii_evalyoffset

Window	iw_parent //parent window to know max size to resize dropdown

//keep track of state based on column
Boolean	ib_picturevisible[]
Boolean	ib_SelectAll[]
Boolean	ib_allowquicksort
Integer	ii_buttonsrow3[]
Integer	ii_buttonsrow4[]

s_powerfilter_parms is_ReturnParms[]
s_powerfilter_parms is_OpenParms[]

//For identifying parent window default control, to disable/re-enable default property
String				is_defaulttype, is_canceltype
OLECustomControl 	iocc_default, iocc_cancel
PictureButton		ipb_default, ipb_cancel
CommandButton		icb_default, icb_cancel

//MultLang Support
Integer ii_lang

String is_January
String is_February
String is_March
String is_April
String is_May
String is_June
String is_July
String is_August
String is_September
String is_October
String is_November
String is_December
String is_Blank
String is_MatchingCase
String is_SelectAll
String is_And
String is_Cancel
String is_ClearFilterFrom
String is_Clickanddragtochangesizeofdropdown
String is_DateFilters
String is_Doesnotequal_Cap
String is_Equals_Cap
String is_MatchCase
String is_NumberFilters
String is_OK
String is_Or
String is_SortAtoZ
String is_SortEarliesttoLatest
String is_SortLargesttoSmallest
String is_SortLatesttoEarliest
String is_SortNewesttoOldest
String is_SortOldesttoNewest
String is_SortSmallesttoLargest
String is_SortZtoA
String is_TextFilters
String is_TimeFilters

end variables

forward prototypes
public subroutine of_getvalues (string as_column)
public function integer of_getparentwindow (ref window aw_parent)
private function integer of_resize (integer ai_x, integer ai_y)
public function integer of_savestate ()
public function integer of_restorestate ()
public function integer of_customfilter (string as_filter1, string as_parm1, string as_filter2, string as_parm2, string as_andor)
public function integer of_replace (ref string as_string, string as_old, string as_new)
public function integer of_close ()
public function integer of_open (integer ai_colnum, string as_colname, string as_title, string as_coltype, string as_columnfilter)
public function integer of_getdefaultcontrol (window aw_parentwindow)
public function integer of_restoredefaultcontrol ()
public function integer of_monthfilter (string as_filter1, string as_parm1)
public function integer of_setpredef (ref userobject a_predeffilters, ref userobject a_monthopts)
public function integer of_cleardefaultcontrol ()
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_initialize (ref datawindow adw_dw, ref nonvisualobject a_powerfilter_checkbox, integer a_maxitems, integer ai_maxcol, boolean ab_allowquicksort, string as_defaulttiptext)
end prototypes

event ue_checkfocus();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
// This should be called from the losefocus event of each control on this user object (may be a postevent)
// to see if focus has shifted to another control on the user object, or totally away.  If away, the uo 
// should be closed.  Need to see if control classname could be duplicated on other object, if so, 
// need to give all of these controls 'unique' names

GraphicObject which_control
PowerObject	which_Parent

which_control = GetFocus() //identify the control that has focus
IF isvalid(which_control) THEN
	which_Parent = which_control.getparent( ) //get the parent of that control
	IF which_Parent = THIS THEN
		IF which_control <> dw_buttons then dw_buttons.object.rr_1.visible=FALSE //turn off highlight bar
		RETURN //this user object still has control
	END IF
	IF which_Parent = iu_powerfilter_predeffilters THEN
		dw_buttons.object.rr_1.visible="0~tif(getrow()=currentrow(),1,0)" //turn on highlight bar
		RETURN //predefined filters for this user object still has control
	END IF
	IF which_control = idw_dw THEN
		IF Match ( idw_dw.getobjectatpointer( ), 'b_powerfilter'+string(ii_colnum)) THEN
			RETURN //button for this control was clicked, it will close this instead of close/reopen
		END IF
	END IF
END IF
//If not valid (clicked outside of application?) or not this User Object control, then close this dropdown
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible=FALSE
of_close() //close dropdown, none of the objects have focus



end event

public subroutine of_getvalues (string as_column);////////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetValues
//
//	Access:    		Public
//
//	Arguments:
//  as_column:  	The column to get values for
//
//	Returns:   		None
//
//	Description:  	Obtains a list of distinct values for the specified
//					  	column from the DataWindow 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/

string			ls_value,ls_valuetest,ls_sort,ls_return,ls_mod
string			ls_AscendingText,ls_DescendingText,ls_FilterText,ls_ClearFilterText
string			ls_holdfilter
Boolean		lb_blankfound
Long			ll_row,ll_rowcount,ll_dropdownrows,ll_newrow,ll_rc,ll_filteredcount,ll_unfilteredcount
decimal		ld_numvalue
date			ldt_datevalue
datetime		ldtm_datetimevalue
time			ltm_timevalue
Integer		li_return
Long			ll_width,ll_height
String			ls_width,ls_height

SetPointer ( HourGlass! )

is_ColType = lower(left(idw_dw.Describe(as_column + ".Coltype"),5)) //use first 5 characters of coltype

is_colformat = idw_dw.Describe(is_colname+".Format")
IF Left(is_colformat,1) = '"' and right(is_colformat,1) = '"' THEN
	is_colformat = mid(is_colformat,2,len(is_colformat)-2) //strip off leading and ending double-quotes if there
END IF

//IF is_ColType = 'date' THEN
//	dw_powerfilter.dataobject = 'd_datetree'
//ELSEIF is_ColType = 'datet' THEN
//	dw_powerfilter.dataobject = 'd_powerfilter_datetimetree'
//ELSE
	dw_powerfilter.dataobject = 'd_powerfilter'
	//MULTILANG modify expressions for (Blank) here
	//this works as long as the property is an expression
	ls_mod = dw_powerfilter.describe('t_blank.text')
	of_replace( ls_mod,'(Blank)', is_blank)
	ls_return = dw_powerfilter.modify('t_blank.text='+ls_mod)

	ls_mod = dw_powerfilter.describe('t_blank.visible')
	of_replace( ls_mod,'(Blank)', is_blank)
	ls_return = dw_powerfilter.modify('t_blank.visible='+ls_mod)
	
	dw_powerfilter.SetRowFocusIndicator(FocusRect!)
//END IF
//restore state values
of_restorestate()

IF len(is_ColumnFilter) = 0 THEN
	ids_powerfilter[ii_colnum].reset()
END IF

ls_return = dw_powerfilter.Modify("timeitem.visible='0' dateitem.visible='0' datetimeitem.visible='0' numericitem.visible='0' item.visible='0' ")
CHOOSE CASE is_ColType
	CASE 'char(','char'
		ls_sort = 'item'
		ls_AscendingText = is_sortAtoZ //'Sort A to Z' //MULTILANG Sort A to Z
		ls_DescendingText =  is_sortZtoA //'Sort Z to A' //MULTILANG Sort Z to A
		ls_FilterText = is_TextFilters //'Text Filters' //MULTILANG Text Filters
		ls_ClearFilterText = is_clearfilterfrom + ' "' + is_Title + '"' //MULTILANG Clear Filter From
		this.of_replace(is_colformat,is_colname,"item")
		ls_return = dw_powerfilter.Modify('item.visible="1" ')
		ls_return = dw_powerfilter.Modify('item.Format="'+is_colformat+'"')
		if lower( idw_dw.Describe(as_column + ".BitmapName") ) = 'yes' then
			dw_powerfilter.Object.item.BitmapName = 'Yes' //Display as bitmap?
			ll_width = long(idw_dw.Describe(as_column + ".width"))
			ll_height = long(idw_dw.Describe(as_column + ".height"))
			
			Do while ll_height > 52 * 4
				ll_width = ll_width * .9
				ll_height = ll_height * .9
			Loop
			
			ls_width = string(ll_width)
			ls_height = string(ll_height)
			dw_powerfilter.Object.item.width = ls_width
			dw_powerfilter.Object.item.height =ls_height
			dw_powerfilter.Object.DataWindow.Detail.Height = ls_height
//			dw_powerfilter.Object.DataWindow.Detail.Height.AutoSize='Yes'
			ids_powerfilter[ii_colnum].Object.item.BitmapName = 'Yes'
			ids_powerfilter[ii_colnum].Object.item.width = ls_width
			ids_powerfilter[ii_colnum].Object.item.height = ls_height
			ids_powerfilter[ii_colnum].Object.DataWindow.Detail.Height = ls_height
//			ids_powerfilter[ii_colnum].Object.DataWindow.Detail.Height.AutoSize='Yes'
		else
			dw_powerfilter.Object.item.BitmapName = 'No' //Display as bitmap?
			dw_powerfilter.Object.item.width = 782 
			dw_powerfilter.Object.item.height = 52 
			dw_powerfilter.Object.DataWindow.Detail.Height = '60'
//			dw_powerfilter.Object.DataWindow.Detail.Height.AutoSize='No'
			ids_powerfilter[ii_colnum].Object.item.BitmapName = 'No'
			ids_powerfilter[ii_colnum].Object.item.width = 782 
			ids_powerfilter[ii_colnum].Object.item.height = 52 
			ids_powerfilter[ii_colnum].Object.DataWindow.Detail.Height = '60'
//			ids_powerfilter[ii_colnum].Object.DataWindow.Detail.Height.AutoSize='No'
		end if
	CASE 'date'
		ls_sort = 'dateitem'
		ls_AscendingText = is_SortOldesttoNewest //'Sort Oldest to Newest' //MULTILANG Sort Oldest to Newest
		ls_DescendingText = is_SortNewesttoOldest //'Sort Newest to Oldest' //MULTILANG Sort Newest to Oldest
		ls_FilterText = is_DateFilters //'Date Filters'//MULTILANG Date Filters
		ls_ClearFilterText = is_clearfilterfrom + ' "' + is_Title + '"' //MULTILANG Clear Filter From
		this.of_replace(is_colformat,is_colname,"dateitem")
		ls_return = dw_powerfilter.Modify('dateitem.visible="1" ')
		ls_return = dw_powerfilter.Modify('dateitem.Format="'+is_colformat+'"')
	CASE 'datet','times'
		ls_sort = 'datetimeitem'
		ls_AscendingText = is_SortOldesttoNewest //'Sort Oldest to Newest' //MULTILANG Sort Oldest to Newest
		ls_DescendingText = is_SortNewesttoOldest //'Sort Newest to Oldest' //MULTILANG Sort Newest to Oldest
		ls_FilterText = is_DateFilters //'Date Filters'//MULTILANG Date Filters
		ls_ClearFilterText = is_clearfilterfrom + ' "' + is_Title + '"' //MULTILANG Clear Filter From
		this.of_replace(is_colformat,is_colname,"datetimeitem")
		ls_return = dw_powerfilter.Modify('datetimeitem.visible="1" ')
		ls_return = dw_powerfilter.Modify('datetimeitem.Format="'+is_colformat+'"')
	CASE 'int','long','numbe','real','ulong','decim'
		ls_sort = 'numericitem'
		ls_AscendingText = is_sortsmallesttolargest //'Sort Smallest to Largest' //MULTILANG Sort Smallest to Largest
		ls_DescendingText = is_sortlargesttosmallest //'Sort Largest to Smallest' //MULTILANG Sort Largest to Smallest
		ls_FilterText = is_numberfilters //'Number Filters'//MULTILANG Number Filters
		ls_ClearFilterText = is_clearfilterfrom + ' "' + is_Title + '"' //MULTILANG Clear Filter From
		this.of_replace(is_colformat,is_colname,"numericitem")
		ls_return = dw_powerfilter.Modify('numericitem.visible="1" ')
		ls_return = dw_powerfilter.Modify('numericitem.Format="'+is_colformat+'"')
	CASE 'time'
		ls_sort = 'timeitem'
		ls_AscendingText = is_sortearliesttolatest //'Sort Earliest to Latest' //MULTILANG Sort Earliest to Latest
		ls_DescendingText = is_sortlatesttoearliest //'Sort Latest to Earliest' //MULTILANG Sort Latest to Earliest
		ls_FilterText = is_timefilters //'Time Filters'//MULTILANG Time Filters
		ls_ClearFilterText = is_clearfilterfrom + ' "' + is_Title + '"' //MULTILANG Clear Filter From
		this.of_replace(is_colformat,is_colname,"timeitem")
		ls_return = dw_powerfilter.Modify('timeitem.visible="1" ')
		ls_return = dw_powerfilter.Modify('timeitem.Format="'+is_colformat+'"')
	CASE ELSE
		messagebox("Error",is_ColType + " column type for is_ColType not recognized")
		RETURN
END CHOOSE

IF ib_allowquicksort THEN
	dw_buttons.SetItem(1,'buttonname',ls_AscendingText)
	dw_buttons.SetItem(2,'buttonname',ls_DescendingText)
END IF
dw_buttons.SetItem(dw_buttons.rowcount()-1,'buttonname',ls_ClearFilterText)
dw_buttons.SetItem(dw_buttons.rowcount(),'buttonname',ls_FilterText)

ll_rowcount = idw_dw.rowcount()
ll_dropdownrows = ids_powerfilter[ii_colnum].rowcount()

FOR ll_row = 1 to ll_rowcount
	CHOOSE CASE is_ColType
		CASE 'char(','char'
			ls_value = idw_dw.GetItemString(ll_row,as_column)
			IF trim(ls_value) = '' THEN ls_value = trim(ls_value) //only trim if reduces to empty string
		CASE 'date'
			ls_value = String(idw_dw.GetItemDate(ll_row,as_column),'yyyy-mm-dd')
			ldt_datevalue = idw_dw.GetItemDate(ll_row,as_column)
		CASE 'datet','times'
			ls_value = String(idw_dw.GetItemDateTime(ll_row,as_column),'yyyy-mm-dd hh:mm:ss:ffffff')
			ldtm_datetimevalue = idw_dw.GetItemDateTime(ll_row,as_column)
		CASE 'int','long','numbe','real','ulong'
			ls_value = String(idw_dw.GetItemNumber(ll_row,as_column))
			ld_numvalue = idw_dw.GetItemNumber(ll_row,as_column)
		CASE 'time'
			ls_value = String(idw_dw.GetItemTime(ll_row,as_column),"hh:mm:ss:ffffff")
			ltm_timevalue = idw_dw.GetItemTime(ll_row,as_column)
		CASE 'decim'
			ls_value = String(idw_dw.GetItemDecimal(ll_row,as_column))
			ld_numvalue = idw_dw.GetItemDecimal(ll_row,as_column)
		CASE ELSE
			messagebox("Error",is_ColType + " column type for is_ColType not recognized")
			RETURN
	END CHOOSE

	ls_valuetest = ls_value + ' ' 
	IF ls_valuetest = ' ' OR isnull(ls_value) THEN
		lb_blankfound = TRUE
		CONTINUE
	END IF
	//See if value already added to the dropdown
	of_Replace(ls_value,'"','~~~"')
	IF ids_powerfilter[ii_colnum].Find('Item = "' + ls_value + '"',1,ll_dropdownrows) > 0 THEN
		CONTINUE
	END IF
	// Insert new row.
	of_Replace(ls_value,'~~~"','"')
	ll_dropdownrows = ids_powerfilter[ii_colnum].InsertRow ( 0 ) 
	ids_powerfilter[ii_colnum].SetItem ( ll_dropdownrows,"Item",ls_value)
	CHOOSE CASE is_ColType
		CASE 'decim','int','long','numbe','real','ulong'
			ids_powerfilter[ii_colnum].SetItem ( ll_dropdownrows,"NumericItem",ld_numvalue)
		CASE 'date'
			ids_powerfilter[ii_colnum].SetItem ( ll_dropdownrows,"dateItem",ldt_datevalue)
		CASE 'datet','times'
			ids_powerfilter[ii_colnum].SetItem ( ll_dropdownrows,"datetimeItem",ldtm_datetimevalue)
		CASE 'time'
			ids_powerfilter[ii_colnum].SetItem ( ll_dropdownrows,"TimeItem",ltm_timevalue)
	END CHOOSE
	IF ll_dropdownrows > ii_MaxItems THEN EXIT //limit dropdown to certain number of items (Excel limits to 10,000)
NEXT
ids_powerfilter[ii_colnum].setsort(ls_sort) //sort by appropriate column based on data type
ids_powerfilter[ii_colnum].sort() //sort the list by Item
dw_powerfilter.setsort(ls_sort) //set sort by appropriate column based on data type, don't sort visual yet, will be sorted in OK clicked event to build tooltip list

IF lb_blankfound THEN
	IF ids_powerfilter[ii_colnum].Rowcount() = 0 THEN //all items are blank, no other values added yet
		ids_powerfilter[ii_colnum].InsertRow(1)
		ids_powerfilter[ii_colnum].SetItem(1,'Item',is_Blank ) //MULTILANG (Blank)
	ELSE
		IF ids_powerfilter[ii_colnum].find("Item = '"+is_Blank+"'",1,ids_powerfilter[ii_colnum].Rowcount()) = 0 THEN //MULTILANG (Blank)
			ids_powerfilter[ii_colnum].InsertRow(1)
			ids_powerfilter[ii_colnum].SetItem(1,'Item',is_Blank )  //MULTILANG (Blank)
		END IF
	END IF
END IF

//Last thing to do is COPY data from  non-visual datastore to the visual dw_powerfilter
li_return = ids_powerfilter[ii_colnum].RowsCopy(1,ids_powerfilter[ii_colnum].RowCount(), Primary!, dw_powerfilter, 1, Primary!)
dw_powerfilter.sort()

end subroutine

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  public
//
//	Arguments:
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/

powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

private function integer of_resize (integer ai_x, integer ai_y);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_pointerx, li_pointery,li_width,li_height,li_minx,li_miny,li_maxx,li_maxy,li_objectwidth

iw_parent.setredraw(false)
this.setredraw(false)

iu_powerfilter_monthopts.visible = FALSE
iu_powerfilter_predeffilters.visible = FALSE

// Always keep the resizer on top of other objects.
p_resizer.SetPosition(ToTop!)

// Get the new position.
li_pointerx = ai_x
li_pointery = ai_y

//Get current max values so don't allow drag off of window
If IsValid(iw_parent) Then
	ii_maxwidth = iw_parent.workspacewidth() 
	ii_maxheight = iw_parent.workspaceheight()
Else
	ii_maxwidth = ii_minwidth
	ii_maxheight = ii_minheight
End If
li_minx = this.x + ii_minwidth
li_miny = this.y + ii_minheight

//Don't allow resize smaller than original size or beyond parent boundaries
IF li_pointerx >= li_minx and li_pointerx <= ii_maxwidth THEN
	li_width = li_pointerx - this.x
ELSEIF li_pointerx > ii_maxwidth THEN
	li_width = ii_maxwidth - this.x
ELSE
	li_width = ii_minwidth 
END IF
IF li_pointery >= li_miny and li_pointery <= ii_maxheight THEN
	li_height = li_pointery - this.y
ELSEIF li_pointery > ii_maxheight THEN
	li_height = ii_maxheight - this.y
ELSE
	li_height = ii_minheight
END IF

IF li_height <> this.height or li_width <> this.width THEN
	this.width = li_width
	this.height = li_height
	// Position resizer on its new location.
	p_resizer.X = li_width - p_resizer.width - ii_resizerxoffset
	p_resizer.Y = li_height - p_resizer.height - ii_resizeryoffset
			
	//reposition buttons and datawindow
	cb_ok.X = li_width - cb_ok.width - ii_okxoffset
	cb_ok.Y = li_height - cb_ok.height - ii_okyoffset
	cb_cancel.X = li_width - cb_cancel.width - ii_canxoffset
	cb_cancel.Y = li_height - cb_cancel.height - ii_canyoffset
	dw_powerfilter.width = li_width - dw_powerfilter.x - ii_dwxoffset
	dw_powerfilter.height = li_height - dw_powerfilter.y - ii_dwyoffset
	
	shl_msg.width = li_width - shl_msg.x - ii_evalxoffset
	shl_msg.y = li_height - shl_msg.height - ii_evalyoffset
	
	dw_buttons.width = li_width - dw_buttons.x - ii_dwbxoffset
	dw_buttons.object.rr_1.width = dw_buttons.width - integer(dw_buttons.object.rr_1.x)
	dw_buttons.object.l_1.x2 = dw_buttons.width
	dw_buttons.object.buttonname.width = dw_buttons.width - integer(dw_buttons.object.buttonname.x)
	dw_buttons.object.p_arrow.x = dw_buttons.width - 45 
	
	CHOOSE CASE dw_powerfilter.dataobject
		CASE 'd_powerfilter'
			IF dw_powerfilter.object.item.bitmapname = 'no' THEN //only resize if not a bitmap
				li_objectwidth = dw_powerfilter.width - integer(dw_powerfilter.object.item.x) - 4
				dw_powerfilter.object.item.width = li_objectwidth
				dw_powerfilter.object.timeitem.width = li_objectwidth
				dw_powerfilter.object.dateitem.width = li_objectwidth
				dw_powerfilter.object.datetimeitem.width = li_objectwidth
				dw_powerfilter.object.numericitem.width = li_objectwidth
				dw_powerfilter.object.t_blank.width = li_objectwidth
			END IF
		CASE 'd_powerfilter_datetree'
			dw_powerfilter.object.dateitem.width = dw_powerfilter.width - integer(dw_powerfilter.object.dateitem.x) - 4
			dw_powerfilter.object.compute_month.width = dw_powerfilter.width - integer(dw_powerfilter.object.compute_month.x) - 4
			dw_powerfilter.object.compute_year.width = dw_powerfilter.width - integer(dw_powerfilter.object.compute_year.x) - 4
		CASE 'd_powerfilter_datetimetree'
			dw_powerfilter.object.datetimeitem.width = dw_powerfilter.width - integer(dw_powerfilter.object.datetimeitem.x) - 4
			dw_powerfilter.object.compute_month.width = dw_powerfilter.width - integer(dw_powerfilter.object.compute_month.x) - 4
			dw_powerfilter.object.compute_year.width = dw_powerfilter.width - integer(dw_powerfilter.object.compute_year.x) - 4
	END CHOOSE
	
	ln_1.endy = li_height - ii_lineyoffset
	
	r_2.width = li_width - r_2.x - ii_rectxoffset
	r_2.height = li_height - r_2.y - ii_rectyoffset
	iu_powerfilter_predeffilters.x = this.x + li_width
	IF iu_powerfilter_predeffilters.x + iu_powerfilter_predeffilters.width > iw_parent.workspacewidth() THEN 
		iu_powerfilter_predeffilters.x = this.x - iu_powerfilter_predeffilters.width
	END IF

END IF

this.setredraw(true)
iw_parent.setredraw(true)

Return 0
end function

public function integer of_savestate ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//Save state of objects since now using 1 dropdown for all columns, restore these values in of_GetValues
ib_picturevisible[ii_colnum]=p_1.visible
ib_SelectAll[ii_colnum]=cbx_1.checked
ii_buttonsrow3[ii_colnum] = dw_buttons.GetItemnumber(dw_buttons.rowcount()-1,'Active')
ii_buttonsrow4[ii_colnum] = dw_buttons.GetItemnumber(dw_buttons.rowcount(),'Selected') //was hardcoded 4, but disallowing sort deletes rows 1 and 2
RETURN 0
end function

public function integer of_restorestate ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//restore state values
p_1.visible=ib_picturevisible[ii_colnum]
cbx_1.checked=ib_SelectAll[ii_colnum]

dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',ii_buttonsrow3[ii_colnum])
dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',ii_buttonsrow4[ii_colnum])
return 0
end function

public function integer of_customfilter (string as_filter1, string as_parm1, string as_filter2, string as_parm2, string as_andor);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String ls_filter,ls_parm,ls_andor,ls_andordisplay,ls_PowerTipText,ls_colname,ls_coltype
String ls_delimfront,ls_delimback,ls_dditem,ls_wildfront,ls_wildback,ls_not,ls_nullcheck,ls_isnull,ls_ddnull,ls_ddnullcheck
String ls_strdelim,ls_strback
Integer li_start_pos,li_return
Boolean	lb_MatchCase,lb_checkdecimal
	Integer	li_year,li_month,li_row,li_firstrow,li_lastrow
	Boolean	ib_partial
	String	ls_setvalue
Long ll_row,ll_rows,ll_filteredrows
IF as_filter1 <> '' THEN 
	//pre-defined filter option was selected
	is_ReturnParms[ii_colnum].Parm1 = as_filter1
	is_ReturnParms[ii_colnum].Parm2 = as_parm1
	is_ReturnParms[ii_colnum].Parm3 = as_filter2
	is_ReturnParms[ii_colnum].Parm4 = as_parm2
	is_ReturnParms[ii_colnum].Parm5 = as_andor
	is_ReturnParms[ii_colnum].parm9 = lb_MatchCase //default to FALSE
	is_ReturnParms[ii_colnum].parm10 = is_ColType //Type of data column 
	is_ReturnParms[ii_colnum].parm12 = '' //DisplayText for multiple language support 
	is_ReturnParms[ii_colnum].parm13 = '' //DisplayText for multiple language support 
ELSE
	IF upperbound(is_ReturnParms) < ii_colnum THEN
		is_ReturnParms[ii_colnum].Parm1 = ''
		is_ReturnParms[ii_colnum].Parm2 = ''
		is_ReturnParms[ii_colnum].Parm3 = ''
		is_ReturnParms[ii_colnum].Parm4 = ''
		is_ReturnParms[ii_colnum].Parm5 = ''
		is_ReturnParms[ii_colnum].parm9 = FALSE //default to FALSE
		is_ReturnParms[ii_colnum].parm10 = is_ColType //Type of data column 
	is_ReturnParms[ii_colnum].parm12 = ''  
	is_ReturnParms[ii_colnum].parm13 = '' 
	END IF
END IF

is_OpenParms[ii_colnum].Parm1 = is_ReturnParms[ii_colnum].Parm1 //filter1
is_OpenParms[ii_colnum].Parm2 = is_ReturnParms[ii_colnum].Parm2 //parm1
is_OpenParms[ii_colnum].Parm3 = is_ReturnParms[ii_colnum].Parm3 //filter2
is_OpenParms[ii_colnum].Parm4 = is_ReturnParms[ii_colnum].Parm4 //parm2
is_OpenParms[ii_colnum].Parm5 = is_ReturnParms[ii_colnum].Parm5 //and/or
is_OpenParms[ii_colnum].Parm6 = is_Title
is_OpenParms[ii_colnum].Parm7 = this.ids_powerfilter[ii_colnum] //array or datastore?
is_OpenParms[ii_colnum].Parm8 = is_ReturnParms[ii_colnum].Parm8 //CANCEL pressed?
is_OpenParms[ii_colnum].Parm9 = is_ReturnParms[ii_colnum].Parm9 //MatchCase True/False
is_OpenParms[ii_colnum].Parm10 = is_ColType
//is_colformat = idw_dw.Describe(is_colname+".Format")
is_OpenParms[ii_colnum].Parm11 = is_colformat
is_OpenParms[ii_colnum].Parm12 = is_ReturnParms[ii_colnum].Parm12 //displaytext
is_OpenParms[ii_colnum].Parm13 = is_ReturnParms[ii_colnum].Parm13 //displaytext
is_OpenParms[ii_colnum].Parm14 = ii_lang //MULTILANG language

IF as_parm1 = '' THEN
	//no parameter value passed in, so prompt for values, otherwise, a pre-defined option was chosen
	OpenwithParm(w_powerfilter_custom,is_OpenParms[ii_colnum])
	is_ReturnParms[ii_colnum] = message.powerobjectparm
	idw_dw.setfocus()
END IF

IF upper(string(is_ReturnParms[ii_colnum].parm8)) = 'CANCEL' THEN RETURN -1 //cancel pressed, no need to do anything?

lb_MatchCase = is_ReturnParms[ii_colnum].parm9 //= TRUE/FALSE for Matching Case.  IF FALSE, then use UPPER() or LOWER() on all parameters

IF isnull(iu_powerfilter_checkbox.is_lookup[ii_colnum]) THEN
	ls_colname = is_colname
	ls_coltype = is_coltype 
ELSE
	ls_colname = iu_powerfilter_checkbox.is_lookup[ii_colnum]
	ls_coltype = 'char'
END IF

CHOOSE CASE ls_ColType
	CASE 'char(','char'
		ls_delimfront = '"'
		ls_delimback = '"'
		ls_dditem = 'Item'
	CASE 'date'
		ls_delimfront = 'date("'
		ls_delimback = '")'
		ls_dditem = 'dateitem'
	CASE 'datet'
		ls_delimfront = 'datetime("'
		ls_delimback = '")'
		ls_dditem = 'datetimeItem'
	CASE 'int','long','ulong'
		ls_delimfront = ''
		ls_delimback = ''
		ls_dditem = 'numericItem'
	CASE 'numbe','real','decim'
		lb_checkdecimal = TRUE
		ls_delimfront = ''
		ls_delimback = ''
		ls_dditem = 'numericItem'
	CASE 'time'
		ls_delimfront = 'time("'
		ls_delimback = '")'
		ls_dditem = 'TimeItem'
	CASE 'times'
		ls_delimfront = 'datetime("'
		ls_delimback = '")'
		ls_dditem = 'DateTimeItem'
	CASE ELSE
		messagebox("Error",ls_ColType + " column type for ls_ColType not recognized")
		RETURN -1
END CHOOSE

ls_andor = string(is_ReturnParms[ii_colnum].Parm5)
IF upper(ls_andor) = 'AND' THEN
	ls_andordisplay = is_and //MULTILANG And
ELSE
	ls_andordisplay = is_or //MULTILANG Or
END IF

ls_parm = string(is_ReturnParms[ii_colnum].parm2)

IF ls_parm = is_Blank THEN //MULTILANG (Blank)
	ls_Parm = ''
	ls_isnull = ' isnull('+ls_colname+') or '
	ls_ddnull = ' isnull('+ls_dditem+') or string('+ls_dditem+') = "'+is_Blank+'" or ' //MULTILANG (Blank)
ELSE
	of_Replace(ls_Parm,'"','~~~"')
	IF lb_checkdecimal THEN of_Replace(ls_Parm,',','.') //decimals must be in US format
	ls_isnull = ''
	ls_ddnull = ''
END IF
// replace MS series wildcard with PB wildcard
li_start_pos = Pos(ls_parm, '*')

IF li_start_pos > 0 THEN
	of_Replace(ls_parm,'*','%')
	IF lower(String(is_ReturnParms[ii_colnum].Parm1)) = 'equals' THEN
		is_ReturnParms[ii_colnum].Parm1 = 'like' 
	END IF
END IF

// replace MS single wildcard with PB wildcard
li_start_pos = Pos(ls_parm, '?')
IF li_start_pos > 0 THEN
	of_Replace(ls_parm,'?','_')
	IF lower(String(is_ReturnParms[ii_colnum].Parm1)) = 'equals' THEN
		is_ReturnParms[ii_colnum].Parm1 = 'like' 
	END IF
END IF

ls_wildfront = ''
ls_wildback = ''
ls_nullcheck = ''
ls_ddnullcheck = ''
ls_not = ''
ls_strdelim = ''
ls_strback = ''
CHOOSE CASE lower(String(is_ReturnParms[ii_colnum].Parm1))
	CASE 'equals'
		ls_filter = '= '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
	CASE 'does not equal'
		ls_filter = '= '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_not = 'Not '
	CASE 'is greater than'
		ls_filter = '> '
	CASE 'is greater than or equal to'
		ls_filter = '>= '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
	CASE 'is less than'
		ls_filter = '< '
	CASE 'is less than or equal to'
		ls_filter = '<= '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
	CASE 'begins with'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_wildback = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'does not begin with'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_not = 'Not '
		ls_wildback = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'ends with'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_wildfront = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'does not end with'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_not = 'Not '
		ls_wildfront = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'contains'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_wildfront = '%'
		ls_wildback = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'like' //this is an internal change when 'equals' has wildcards in the params
		is_ReturnParms[ii_colnum].Parm1 = 'Equals' //change back to original value
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_wildfront = ''  //no wildcard other than what the user provided
		ls_wildback = ''
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE 'does not contain'
		ls_filter = 'Like '
		ls_nullcheck = ls_isnull
		ls_ddnullcheck = ls_ddnull
		ls_not = 'Not '
		ls_wildfront = '%'
		ls_wildback = '%'
		ls_strdelim = 'String('
		ls_strback = ')'
		ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
		ls_delimback='"' 
	CASE ''
		ls_filter = ''
END CHOOSE
IF ls_parm = '' THEN
	//(Blank) is parm, so don't add any wildcards for Like, Contain, etc.
	ls_wildfront = ''
	ls_wildback = ''
END IF
IF NOT lb_MatchCase THEN
	IF ls_strdelim <> '' OR ls_dditem = 'Item' THEN
		ls_Parm = LOWER(ls_Parm)
		ls_strdelim = 'LOWER(' + ls_strdelim
		ls_strback = ls_strback + ')'
	END IF
END IF
is_ColumnFilter = '('+ls_not+'(' + ls_nullcheck + ls_strdelim + ls_colname +ls_strback + ' ' + ls_filter + ls_delimfront + ls_wildfront + ls_parm + ls_wildback + ls_delimback +'))'
is_ddFilter = '('+ls_not+'(' + ls_ddnullcheck  + ls_strdelim + ls_dditem +ls_strback +' ' + ls_filter + ls_delimfront + ls_wildfront + ls_parm + ls_wildback + ls_delimback +'))'
ls_PowerTipText = String(is_ReturnParms[ii_colnum].Parm12) + ' ' + string(is_ReturnParms[ii_colnum].parm2)
//////////////////////////////////////////////////////////////////
//SECOND FILTER LOGIC STARTS HERE
//////////////////////////////////////////////////////////////////
ls_parm = string(is_ReturnParms[ii_colnum].parm4)

IF ls_parm = is_Blank THEN //MULTILANG
	ls_Parm = ''
	ls_isnull = ' isnull('+ls_colname+') or '
	ls_ddnull = ' isnull('+ls_dditem+') or string('+ls_dditem+') = "'+is_Blank+'" or ' //MULTILANG (Blank)
ELSE
	of_Replace(ls_parm,'"','~~~"')
	IF lb_checkdecimal THEN of_Replace(ls_parm,',','.') //decimals must be in US format
	ls_isnull = ''
	ls_ddnull = ''
END IF
// replace MS series wildcard with PB wildcard
li_start_pos = Pos(ls_parm, '*', 1)

IF li_start_pos > 0 THEN
	of_Replace( ls_parm, '*', '%')
	IF lower(String(is_ReturnParms[ii_colnum].Parm3)) = 'equals' THEN
		is_ReturnParms[ii_colnum].Parm3 = 'like' 
	END IF
END IF
// replace MS single wildcard with PB wildcard
li_start_pos = Pos(ls_parm, '?', 1) 
IF li_start_pos > 0 THEN
	of_Replace( ls_parm, '?','_')
	IF lower(String(is_ReturnParms[ii_colnum].Parm3)) = 'equals' THEN
		is_ReturnParms[ii_colnum].Parm3 = 'like' 
	END IF
END IF

IF String(is_ReturnParms[ii_colnum].Parm3) = '' or isnull(is_ReturnParms[ii_colnum].Parm3) THEN
	//no second filter defined
ELSE
	ls_wildfront = ''
	ls_wildback = ''
	ls_nullcheck = ''
	ls_ddnullcheck = ''
	ls_not = ''
	ls_strdelim = ''
	ls_strback = ''
	CHOOSE CASE LOWER(String(is_ReturnParms[ii_colnum].Parm3))
		CASE 'equals'
			ls_filter = '= '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
		CASE 'does not equal'
			ls_filter = '= '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_not = 'Not '
		CASE 'is greater than'
			ls_filter = '> '
		CASE 'is greater than or equal to'
			ls_filter = '>= '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
		CASE 'is less than'
			ls_filter = '< '
		CASE 'is less than or equal to'
			ls_filter = '<= '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
		CASE 'begins with'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_wildback = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'does not begin with'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_not = 'Not '
			ls_wildback = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'ends with'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_wildfront = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'does not end with'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_not = 'Not '
			ls_wildfront = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'contains'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_wildfront = '%'
			ls_wildback = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'like' //this is an internal change when 'equals' has wildcards in the params
			is_ReturnParms[ii_colnum].Parm3 = 'Equals' //change back to original value
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_wildfront = '' //no wildcard other than what the user provided
			ls_wildback = ''
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE 'does not contain'
			ls_filter = 'Like '
			ls_nullcheck = ls_isnull
			ls_ddnullcheck = ls_ddnull
			ls_not = 'Not '
			ls_wildfront = '%'
			ls_wildback = '%'
			ls_strdelim = 'String('
			ls_strback = ')'
			ls_delimfront='"' //String-like comparison change delimiters to string(colname) and "parm"
			ls_delimback='"' 
		CASE ''
			ls_filter = ''
	END CHOOSE
	IF ls_parm = '' THEN
		//(Blank) is parm, so don't add any wildcards for Like, Contain, etc.
		ls_wildfront = ''
		ls_wildback = ''
	END IF
	IF NOT lb_MatchCase THEN
		IF ls_strdelim <> '' OR ls_dditem = 'Item' THEN
			ls_Parm = LOWER(ls_Parm)
			ls_strdelim = 'LOWER(' + ls_strdelim
			ls_strback = ls_strback + ')'
		END IF
	END IF
	is_ColumnFilter = is_ColumnFilter + ' ' + ls_andor +' '+ '('+ls_not+'(' + ls_nullcheck + ls_strdelim + ls_colname +ls_strback + ' ' + ls_filter + ls_delimfront + ls_wildfront + ls_parm + ls_wildback + ls_delimback +'))'
	is_ddFilter = is_ddFilter +  ' ' + ls_andor +' '+ '('+ls_not+'(' + ls_ddnullcheck  + ls_strdelim + ls_dditem +ls_strback +' ' + ls_filter + ls_delimfront + ls_wildfront + ls_parm + ls_wildback + ls_delimback +'))'
	ls_PowerTipText = ls_PowerTipText + ' ' + ls_andordisplay + ' ' + string(is_ReturnParms[ii_colnum].Parm13) + ' ' + string(is_ReturnParms[ii_colnum].parm4)
END IF
//put outer parens on to combine with other column filters
is_ColumnFilter = '(' + is_ColumnFilter + ')'
IF lb_MatchCase THEN
	ls_PowerTipText = ls_PowerTipText + '~r~n'+ is_MatchingCase //MULTILANG (Matching Case)
END IF
////////////////////set checkmarks in the dropdown list
ll_rows = this.ids_powerfilter[ii_colnum].rowcount( )
FOR ll_row = 1 to ll_rows
	this.ids_powerfilter[ii_colnum].Object.check[ll_row] = "0"
NEXT
this.ids_powerfilter[ii_colnum].setfilter(is_ddFilter)
this.ids_powerfilter[ii_colnum].filter( )

ll_filteredrows = this.ids_powerfilter[ii_colnum].rowcount( )
FOR ll_row = 1 to ll_filteredrows
	this.ids_powerfilter[ii_colnum].Object.check[ll_row] = "1"
NEXT
li_return = this.ids_powerfilter[ii_colnum].setfilter("") //clear the filter
li_return = this.ids_powerfilter[ii_colnum].filter( ) //get all rows back into Primary
this.ids_powerfilter[ii_colnum].sort() //sort by Item
IF ll_filteredrows < ll_rows THEN
	this.cbx_1.checked = FALSE
ELSE
	this.cbx_1.checked = TRUE
END IF

//set correct picture on column button to indicate if there is a filter on this column
IF is_ColumnFilter = '' THEN 
	this.dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',0)
	this.dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',0)
ELSE
	this.dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',1)
	this.dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',1)
END IF
this.P_1.visible=FALSE //turn off indicator for checklist Filter Selection
//set tooltip text here to show filter definition
//IF len(ls_PowerTipText) > 150 THEN ls_PowerTipText = left(ls_PowerTipText,150) + '...'
//of_Replace(ls_PowerTipText,'"','~~~"') 
//of_Replace(ls_PowerTipText,"'","~~~'") 
//idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".ToolTip.Tip='"+ls_PowerTipText+"'")
//call function in checkbox to build and apply master filter with changes to this column's filter

iu_powerfilter_checkbox.of_buildfilter(is_ColumnFilter,ii_ColNum)
RETURN 0

end function

public function integer of_replace (ref string as_string, string as_old, string as_new);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Long	ll_startpos

ll_startpos = Pos(as_string, as_old )
// Only enter the loop if you find old_str.
DO WHILE ll_startpos > 0
	 as_string = Replace(as_string, ll_startpos, Len(as_old), as_new)	 // Replace old_str with new_str.
	 ll_startpos = Pos(as_string, as_old, ll_startpos+Len(as_new))	 // Find the next occurrence of old_str.
LOOP
RETURN 0
end function

public function integer of_close ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//Logic that executes anytime dropdown closes, regardless of OK/Cancel/or predefined Filter
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
this.visible = FALSE
cb_cancel.cancel = FALSE //turn off Cancel attribute for this button when not visible
cb_cancel.default = FALSE //turn off default attribute for this button when not visible
of_restoredefaultcontrol( ) //restore default control to original window control, if any
of_resize( 0, 0) //resize to original proportions upon close
dw_buttons.SetRow(1) //move highlight back to top of button list

Return 0
end function

public function integer of_open (integer ai_colnum, string as_colname, string as_title, string as_coltype, string as_columnfilter);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//position dropdown prior to display, sets button text and predefined filter options, etc.
//initialize already performed one time when checkbox clicked, just need to set items that are column-specific here.

Integer	li_height,li_width, li_pointerx, li_pointery
Integer	li_x,li_y //final coordinates to set this object
Integer	li_scrolloffset
Long		ll_zoomoffset,ll_xpos
Integer	li_dwoffsetx,li_dwoffsety //dw x and y position relative to parent window (may include tab or other control)
Integer	li_ddxoffset,li_ddyoffset //dropdown x and y offset values set by developer as needed to adjust default positioning
String	ls_colname, ls_coltype //for substituting lookupdisplay column name

powerobject	lpo_parentobject //powerobjects have no x and y values, need to use common ancestor for window and windowobjects in loop
dragobject	lpo_parent //dragobjects do have x and y, need to use powerobject reference in loop, but dragobject to get x and y

//set instance variables to values for this column
ii_colnum = ai_colnum
is_ColName = as_colname
is_Title = as_title
is_ColType = as_coltype
is_ColumnFilter = as_ColumnFilter

//get pointer positions relative to current window, in case offsets logic doesn't work
li_pointerx = iw_parent.pointerx()
li_pointery = iw_parent.pointery()

li_height = integer(idw_dw.Describe("DataWindow.Header.Height")) / iu_powerfilter_checkbox.idec_unityfactor //use header, not each object in header to position vertically

li_scrolloffset = Integer(idw_dw.Object.DataWindow.HorizontalScrollPosition) / iu_powerfilter_checkbox.idec_unitxfactor 
li_dwoffsetx = idw_dw.x
li_dwoffsety = idw_dw.y

// Loop getting the parent of the object until it is of type window!, accumulating x and y values along the way
lpo_parentobject = idw_dw.GetParent()
do while IsValid (lpo_parentobject) 
	if lpo_parentobject.TypeOf() <> window! then
		lpo_parent = lpo_parentobject
		li_dwoffsetx = li_dwoffsetx + lpo_parent.x
		li_dwoffsety = li_dwoffsety + lpo_parent.y
		lpo_parentobject = lpo_parentobject.GetParent()
	else
		exit
	end if
loop

IF idw_dw.TitleBar THEN li_dwoffsety = li_dwoffsety + 108
IF idw_dw.Resizable THEN li_dwoffsetx = li_dwoffsetx + 32

IF upper(idw_dw.Object.DataWindow.Print.Preview) = 'YES' THEN
	li_dwoffsety = li_dwoffsety + integer(idw_dw.Object.DataWindow.Print.Margin.Top) / iu_powerfilter_checkbox.idec_unityfactor 
	li_dwoffsetx = li_dwoffsetx + integer(idw_dw.Object.DataWindow.Print.Margin.Left) / iu_powerfilter_checkbox.idec_unitxfactor 
END IF

IF upper(idw_dw.Object.DataWindow.Print.Preview.Rulers) = 'YES' THEN
	li_dwoffsety = li_dwoffsety + 76
	li_dwoffsetx = li_dwoffsetx + 80
END IF


ll_xpos=long(idw_dw.describe("b_powerfilter"+string(ii_colnum)+".x")) / iu_powerfilter_checkbox.idec_unitxfactor 
li_width=integer(idw_dw.describe("b_powerfilter"+string(ii_colnum)+".width")) / iu_powerfilter_checkbox.idec_unitxfactor 

/*adjust for any DW zoom*/
ll_zoomoffset = long(idw_dw.object.datawindow.zoom)
ll_xpos = ll_xpos * ll_zoomoffset / 100.0
li_width = li_width * ll_zoomoffset / 100.0
li_height = li_height * ll_zoomoffset / 100.0
li_scrolloffset = li_scrolloffset * ll_zoomoffset / 100.0

/*dropdown positioning*/
li_x = (ll_xpos + li_width - this.width - li_scrolloffset + li_dwoffsetx +8) 

IF abs(li_x - (li_pointerx - this.width)) > 100 THEN
	li_x = li_pointerx - this.width + 45//use pointer position instead since location differs dramatically
END IF
IF li_x < 1 THEN li_x = 1

li_y = (li_dwoffsety + li_height ) 

IF abs(li_y - (li_pointery + 40)) > 100 THEN
	li_y = li_pointery + 40 //use pointer position instead since location differs dramatically
END IF
IF li_y < 1 THEN li_y = 1
//test to see if dropdown drops too low.  If so, position above title IF IT WILL FIT, otherwise keep below.
IF li_y + this.height > iw_parent.workspaceheight( ) &
	AND li_dwoffsety - this.height > 0 THEN
	li_y = (li_dwoffsety - this.height)
END IF
iu_powerfilter_checkbox.of_Getdropdownoffset(li_ddxoffset,li_ddyoffset) //passed by reference
//adjust offset values if developer has chosen to override default location
li_x = li_x + li_ddxoffset 
li_y = li_y + li_ddyoffset 

this.move(li_x,li_y)

IF isnull(iu_powerfilter_checkbox.is_lookup[ii_colnum]) THEN
	ls_colname = as_colname
	ls_coltype = is_coltype 
ELSE
	ls_colname = iu_powerfilter_checkbox.is_lookup[ii_colnum]
	ls_coltype =  'char'
END IF
//set predefined filter list, positioning occurs when dw_1 in filterobject gets focus
iu_powerfilter_predeffilters.of_setlist( ls_coltype,is_colname,is_title,ai_colnum)

this.of_getvalues(ls_colname) //gets dropdown list values, as well as restores state and sets button descriptions, etc.
this.bringtotop=TRUE
this.dw_buttons.setfocus()
this.visible=TRUE
this.cb_cancel.cancel=TRUE //make the cancel button function as it should since multiple buttons exist, only 1 visible should have cancel attribute
this.of_cleardefaultcontrol( ) //temporarily turn off default and cancel properties on underlying window while dropdown is visible
RETURN 0

end function

public function integer of_getdefaultcontrol (window aw_parentwindow);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_NumControls,li_i
CommandButton lcb_button
PictureButton lpb_button
OLECustomControl locc_control
 
li_NumControls = upperBound(aw_parentwindow.control)

For li_i = 1 To li_NumControls
	CHOOSE CASE Typeof(aw_parentwindow.control[li_i])
		CASE CommandButton!
			lcb_button = aw_parentwindow.control[li_i]
			IF lcb_button.default=TRUE THEN
				//found default object
				icb_default = lcb_button
				is_defaulttype = 'CommandButton'
				EXIT
			END IF
		CASE PictureButton!
			lpb_button = aw_parentwindow.control[li_i]
			IF lpb_button.default=TRUE THEN
				//found default object
				ipb_default = lpb_button
				is_defaulttype = 'PictureButton'
				EXIT
			END IF
		CASE OLECustomControl!
			locc_control = aw_parentwindow.control[li_i]
			IF locc_control.default=TRUE THEN
				//found default object
				iocc_default = locc_control
				is_defaulttype = 'OLECustomControl'
				EXIT
			END IF
	END CHOOSE
NEXT
//Now find control that has Cancel = TRUE
For li_i = 1 To li_NumControls
	CHOOSE CASE Typeof(aw_parentwindow.control[li_i])
		CASE CommandButton!
			lcb_button = aw_parentwindow.control[li_i]
			IF lcb_button.Cancel=TRUE THEN
				//found Cancel object
				icb_Cancel = lcb_button
				is_Canceltype = 'CommandButton'
				EXIT
			END IF
		CASE PictureButton!
			lpb_button = aw_parentwindow.control[li_i]
			IF lpb_button.Cancel=TRUE THEN
				//found Cancel object
				ipb_Cancel = lpb_button
				is_Canceltype = 'PictureButton'
				EXIT
			END IF
		CASE OLECustomControl!
			locc_control = aw_parentwindow.control[li_i]
			IF locc_control.Cancel=TRUE THEN
				//found Cancel object
				iocc_Cancel = locc_control
				is_Canceltype = 'OLECustomControl'
				EXIT
			END IF
	END CHOOSE
NEXT
Return 0


end function

public function integer of_restoredefaultcontrol ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
CHOOSE CASE is_defaulttype
	CASE 'CommandButton'
		icb_default.default = TRUE
	CASE 'PictureButton'
		ipb_default.default = TRUE
	CASE 'OLECustomControl'
		iocc_default.default = TRUE
END CHOOSE

CHOOSE CASE is_canceltype
	CASE 'CommandButton'
		icb_cancel.cancel = TRUE
	CASE 'PictureButton'
		ipb_cancel.cancel = TRUE
	CASE 'OLECustomControl'
		iocc_cancel.cancel = TRUE
END CHOOSE

RETURN 0
end function

public function integer of_monthfilter (string as_filter1, string as_parm1);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String	ls_filter,ls_parm,ls_PowerTipText
String	ls_dditem
Integer	li_start_pos,li_return
Integer	li_year,li_month,li_row,li_firstrow,li_lastrow
Boolean	ib_partial
String	ls_setvalue
Long		ll_row,ll_rows,ll_filteredrows

ls_parm = as_parm1

CHOOSE CASE is_ColType
	CASE 'char(','char'
		ls_dditem = 'Item'
	CASE 'date'
		ls_dditem = 'dateitem'
	CASE 'datet'
		ls_dditem = 'datetimeItem'
	CASE 'int','long','numbe','real','ulong','decim'
		ls_dditem = 'numericItem'
	CASE 'time'
		ls_dditem = 'TimeItem'
	CASE 'times'
		ls_dditem = 'DateTimeItem'
	CASE ELSE
		messagebox("Error",is_ColType + " column type for is_ColType not recognized")
		RETURN -1
END CHOOSE

CHOOSE CASE lower(as_filter1)
	CASE 'equals'
		ls_filter = '= '
	CASE 'in'
		ls_filter = 'in '
END CHOOSE
is_ColumnFilter = '(month(' + is_colname + ') ' + ls_filter + ls_parm + ')'
is_ddFilter = '(month('+ ls_dditem +') ' + ls_filter + ls_parm + ')'
ls_PowerTipText = as_filter1 + ' ' + as_parm1
//put outer parens on to combine with other column filters
is_ColumnFilter = '(' + is_ColumnFilter + ')'
////////////////////set checkmarks in the dropdown list
ll_rows = this.ids_powerfilter[ii_colnum].rowcount( )
FOR ll_row = 1 to ll_rows
	this.ids_powerfilter[ii_colnum].Object.check[ll_row] = "0"
NEXT
this.ids_powerfilter[ii_colnum].setfilter(is_ddFilter)
this.ids_powerfilter[ii_colnum].filter( )

ll_filteredrows = this.ids_powerfilter[ii_colnum].rowcount( )
FOR ll_row = 1 to ll_filteredrows
	this.ids_powerfilter[ii_colnum].Object.check[ll_row] = "1"
NEXT
li_return = this.ids_powerfilter[ii_colnum].setfilter("") //clear the filter
li_return = this.ids_powerfilter[ii_colnum].filter( ) //get all rows back into Primary
this.ids_powerfilter[ii_colnum].sort() //sort by Item
IF ll_filteredrows < ll_rows THEN
	this.cbx_1.checked = FALSE
ELSE
	this.cbx_1.checked = TRUE
END IF

IF this.dw_powerfilter.dataobject = 'd_powerfilter_datetree' THEN
	//need to check for full/partial/empty years and months to set checkyear and checkmonth appropriately
	//find 1st row with year = reference year, find last row with year = reference year
	//if all checked, then checkyear for all = 1.  if none checked, then checkyear for all = 0. if mix, then checkyear = 2
	this.ids_powerfilter[ii_colnum].setsort('dateitem a')
	this.ids_powerfilter[ii_colnum].sort()
	FOR li_row = 1 to this.ids_powerfilter[ii_colnum].rowcount()
		
		li_year = year(this.ids_powerfilter[ii_colnum].GetItemDate(li_row,'dateitem')) //reference year for row/band selected
		li_month = month(this.ids_powerfilter[ii_colnum].GetItemDate(li_row,'dateitem')) //reference month for row/band selected
		IF isnull(li_year) THEN //(Blank) row, so set that one row and be done
			ls_setvalue = this.ids_powerfilter[ii_colnum].GetItemString(li_row,'check')
			this.ids_powerfilter[ii_colnum].SetItem(li_row,'checkyear',ls_setvalue)
			this.ids_powerfilter[ii_colnum].SetItem(li_row,'checkmonth',ls_setvalue)
		ELSE
			li_firstrow = this.ids_powerfilter[ii_colnum].Find ( "year(dateitem) = "+string(li_year),1,this.ids_powerfilter[ii_colnum].rowcount())
			li_lastrow = this.ids_powerfilter[ii_colnum].Find ( "year(dateitem) = "+string(li_year),this.ids_powerfilter[ii_colnum].rowcount(),li_firstrow)
			if li_lastrow = 0 then li_lastrow = li_firstrow 
			ib_partial = FALSE
			FOR li_row = li_firstrow +1 TO li_lastrow
				IF this.ids_powerfilter[ii_colnum].getitemstring(li_row,'check') <> this.ids_powerfilter[ii_colnum].getitemstring(li_row - 1,'check') THEN
					ib_partial = TRUE
					EXIT
				END IF
			NEXT
			IF ib_partial THEN 
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkyear','2')
			ELSE
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkyear',this.ids_powerfilter[ii_colnum].getitemstring(li_firstrow,'check'))
			END IF
			
			li_firstrow = this.ids_powerfilter[ii_colnum].Find ( "year(dateitem) = "+string(li_year)+" and month(dateitem) = "+string(li_month),1,this.ids_powerfilter[ii_colnum].rowcount())
			li_lastrow = this.ids_powerfilter[ii_colnum].Find ( "year(dateitem) = "+string(li_year)+" and month(dateitem) = "+string(li_month),this.ids_powerfilter[ii_colnum].rowcount(),li_firstrow)
			if li_lastrow = 0 then li_lastrow = li_firstrow //last row was = to reference month
			ib_partial = FALSE
			FOR li_row = li_firstrow +1 TO li_lastrow
				IF this.ids_powerfilter[ii_colnum].getitemstring(li_row,'check') <> this.ids_powerfilter[ii_colnum].getitemstring(li_row - 1,'check') THEN
					ib_partial = TRUE
					EXIT
				END IF
			NEXT
			IF ib_partial THEN 
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkmonth','2')
			ELSE
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkmonth',this.ids_powerfilter[ii_colnum].getitemstring(li_firstrow,'check'))
			END IF
			li_row = li_lastrow 
		END IF
	NEXT
ELSEIF this.dw_powerfilter.dataobject = 'd_powerfilter_datetimetree' THEN
	//same logic block as for dateitem, except references changed from dateitem to datetimeitem and getitemdate to getitemdatetime
	this.ids_powerfilter[ii_colnum].setsort('datetimeitem a')
	this.ids_powerfilter[ii_colnum].sort()
	FOR li_row = 1 to this.ids_powerfilter[ii_colnum].rowcount()
		
		li_year = year(date(this.ids_powerfilter[ii_colnum].GetItemDatetime(li_row,'datetimeitem'))) //reference year for row/band selected
		li_month = month(date(this.ids_powerfilter[ii_colnum].GetItemDatetime(li_row,'datetimeitem'))) //reference month for row/band selected
		IF isnull(li_year) THEN //(Blank) row, so set that one row and be done
			ls_setvalue = this.ids_powerfilter[ii_colnum].GetItemString(li_row,'check')
			this.ids_powerfilter[ii_colnum].SetItem(li_row,'checkyear',ls_setvalue)
			this.ids_powerfilter[ii_colnum].SetItem(li_row,'checkmonth',ls_setvalue)
		ELSE
			li_firstrow = this.ids_powerfilter[ii_colnum].Find ( "year(datetimeitem) = "+string(li_year),1,this.ids_powerfilter[ii_colnum].rowcount())
			li_lastrow =  this.ids_powerfilter[ii_colnum].Find ( "year(datetimeitem) = "+string(li_year),this.ids_powerfilter[ii_colnum].rowcount(),li_firstrow)
			if li_lastrow = 0 then li_lastrow = li_firstrow 
			ib_partial = FALSE
			FOR li_row = li_firstrow +1 TO li_lastrow
				IF this.ids_powerfilter[ii_colnum].getitemstring(li_row,'check') <> this.ids_powerfilter[ii_colnum].getitemstring(li_row - 1,'check') THEN
					ib_partial = TRUE
					EXIT
				END IF
			NEXT
			IF ib_partial THEN 
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkyear','2')
			ELSE
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkyear',this.ids_powerfilter[ii_colnum].getitemstring(li_firstrow,'check'))
			END IF
			
			li_firstrow = this.ids_powerfilter[ii_colnum].Find ( "year(datetimeitem) = "+string(li_year)+" and month(datetimeitem) = "+string(li_month),1,this.ids_powerfilter[ii_colnum].rowcount())
			li_lastrow =  this.ids_powerfilter[ii_colnum].Find ( "year(datetimeitem) = "+string(li_year)+" and month(datetimeitem) = "+string(li_month),this.ids_powerfilter[ii_colnum].rowcount(),li_firstrow)
			if li_lastrow = 0 then li_lastrow = li_firstrow //last row was = to reference month
			ib_partial = FALSE
			FOR li_row = li_firstrow +1 TO li_lastrow
				IF this.ids_powerfilter[ii_colnum].getitemstring(li_row,'check') <> this.ids_powerfilter[ii_colnum].getitemstring(li_row - 1,'check') THEN
					ib_partial = TRUE
					EXIT
				END IF
			NEXT
			IF ib_partial THEN 
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkmonth','2')
			ELSE
				this.ids_powerfilter[ii_colnum].setitem(li_firstrow,'checkmonth',this.ids_powerfilter[ii_colnum].getitemstring(li_firstrow,'check'))
			END IF
			li_row = li_lastrow 
		END IF
	NEXT
END IF

//set correct picture on column button to indicate if there is a filter on this column
IF is_ColumnFilter = '' THEN 
	this.dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',0)
	this.dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',0)
ELSE
	this.dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',1)
	this.dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',1)
END IF
this.P_1.visible=FALSE //turn off indicator for checklist Filter Selection
//set tooltip text here to show filter definition
IF len(ls_PowerTipText) > 150 THEN ls_PowerTipText = left(ls_PowerTipText,150) + '...'
idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".ToolTip.Tip='"+ls_PowerTipText+"'")
//call function in checkbox to build and apply master filter with changes to this column's filter

iu_powerfilter_checkbox.of_buildfilter(is_ColumnFilter,ii_ColNum)
RETURN 0

end function

public function integer of_setpredef (ref userobject a_predeffilters, ref userobject a_monthopts);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//This function is called from the powerfilter checkbox user object to 
//link the dropdown with the preddefinedFilterList
iu_powerfilter_predeffilters = a_predeffilters
iu_powerfilter_monthopts = a_monthopts
return 0
end function

public function integer of_cleardefaultcontrol ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//temporarily clears default and cancel properties on parent window

CHOOSE CASE is_defaulttype
	CASE 'CommandButton'
		icb_default.default = FALSE
	CASE 'PictureButton'
		ipb_default.default = FALSE
	CASE 'OLECustomControl'
		iocc_default.default = FALSE
END CHOOSE

CHOOSE CASE is_canceltype
	CASE 'CommandButton'
		icb_cancel.cancel = FALSE
	CASE 'PictureButton'
		ipb_cancel.cancel = FALSE
	CASE 'OLECustomControl'
		iocc_cancel.cancel = FALSE
END CHOOSE

RETURN 0
end function

public function integer of_setlanguage (integer ai_languagenumber);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_lang
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

li_lang = ai_languagenumber //offset already done in checkbox, English = 0, is in column 2
ii_lang = li_lang //save to pass to custom window

is_January 		= lds_lang.GetItemString(51,li_lang)
is_February 	= lds_lang.GetItemString(52,li_lang)
is_March 		= lds_lang.GetItemString(53,li_lang)
is_April 		= lds_lang.GetItemString(54,li_lang)
is_May 			= lds_lang.GetItemString(55,li_lang)
is_June 			= lds_lang.GetItemString(56,li_lang)
is_July 			= lds_lang.GetItemString(57,li_lang)
is_August 		= lds_lang.GetItemString(58,li_lang)
is_September 	= lds_lang.GetItemString(59,li_lang)
is_October 		= lds_lang.GetItemString(60,li_lang)
is_November 	= lds_lang.GetItemString(61,li_lang)
is_December 	= lds_lang.GetItemString(62,li_lang)
is_Blank 		= lds_lang.GetItemString(63,li_lang)
is_MatchingCase= lds_lang.GetItemString(64,li_lang)
is_SelectAll 	= lds_lang.GetItemString(65,li_lang)
is_And 			= lds_lang.GetItemString(67,li_lang)
is_Cancel 		= lds_lang.GetItemString(69,li_lang)
is_ClearFilterFrom 	= lds_lang.GetItemString(70,li_lang)
is_Clickanddragtochangesizeofdropdown = lds_lang.GetItemString(71,li_lang)
is_DateFilters 		= lds_lang.GetItemString(73,li_lang)
is_Doesnotequal_Cap 	= lds_lang.GetItemString(74,li_lang)
is_Equals_Cap 	= lds_lang.GetItemString(75,li_lang)
is_MatchCase 	= lds_lang.GetItemString(77,li_lang)
is_NumberFilters 		= lds_lang.GetItemString(78,li_lang)
is_OK 			= lds_lang.GetItemString(79,li_lang)
is_Or 			= lds_lang.GetItemString(80,li_lang)
is_SortAtoZ 	= lds_lang.GetItemString(85,li_lang)
is_SortEarliesttoLatest 	= lds_lang.GetItemString(86,li_lang)
is_SortLargesttoSmallest 	= lds_lang.GetItemString(87,li_lang)
is_SortLatesttoEarliest 	= lds_lang.GetItemString(88,li_lang)
is_SortNewesttoOldest 		= lds_lang.GetItemString(89,li_lang)
is_SortOldesttoNewest 		= lds_lang.GetItemString(90,li_lang)
is_SortSmallesttoLargest 	= lds_lang.GetItemString(91,li_lang)
is_SortZtoA 	= lds_lang.GetItemString(92,li_lang)
is_TextFilters = lds_lang.GetItemString(93,li_lang)
is_TimeFilters = lds_lang.GetItemString(94,li_lang)
DESTROY lds_lang

CB_ok.Text = is_OK
CB_Cancel.Text = is_Cancel 
cbx_1.text = is_selectall
p_resizer.powertiptext = is_clickanddragtochangesizeofdropdown

RETURN 0
end function

public function integer of_initialize (ref datawindow adw_dw, ref nonvisualobject a_powerfilter_checkbox, integer a_maxitems, integer ai_maxcol, boolean ab_allowquicksort, string as_defaulttiptext);/*===========================================================
.Object:			u_powerfilter_dropdown
.Method:			of_initialize (Function)
.Author:			Reesejr
.Date:				11/29/2010
.
.Argument(s):	 ref datawindow adw_dw
.					 ref n_cst_powerfilter a_powerfilter_checkbox
.					 integer a_maxitems
.					 integer ai_maxcol
.					 boolean ab_allowquicksort
.					 string as_defaulttiptext
.
.Returns:			 integer
.
.Description:	
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	11/29/2010	1.00		Reesejr	Initial Version
.============================================================*/
Integer	li_colnum

idw_dw = adw_dw //save reference to datawindow being filtered

iu_powerfilter_checkbox = a_powerfilter_checkbox //save reference to powerfilter checkbox
ii_MaxItems = a_maxitems - 1 // number of items to include in the dropdown.  Excel stops at 10,000, may want to stop sooner depending on performance
is_DefaultTipText = as_DefaultTipText
ib_allowquicksort = ab_allowquicksort

//create 1 datastore per column to hold history of Filtered items.  appropriate datastore data is copied to dw_powerfilter in of_getvalues
FOR li_colnum = 1 to ai_maxcol
	ids_powerfilter[li_colnum] = create datastore
	ids_powerfilter[li_colnum].DataObject = 'd_powerfilter'
	ib_picturevisible[li_colnum]=FALSE
	ib_SelectAll[li_colnum]=TRUE
	ii_buttonsrow3[li_colnum]=0
	ii_buttonsrow4[li_colnum]=0
NEXT

//sorting not allowed per developer option
IF NOT ib_allowquicksort THEN
	IF dw_buttons.rowcount() = 4 THEN
		//delete the first two rows, which are the sort option rows
		//need to adjust elsewhere and resize controls since currently rows are hard-coded
		dw_buttons.Deleterow( 1)
		dw_buttons.Deleterow( 1)
		dw_buttons.height = dw_buttons.height - 176 //shorten dw control by 2 detail rows
		//shift all other controls up or shorten
		p_1.y = p_1.y - 176
		p_resizer.y = p_resizer.y - 176
		cb_cancel.y = cb_cancel.y - 176
		cb_ok.y = cb_ok.y - 176
		cbx_1.y = cbx_1.y - 176
		dw_powerfilter.y = dw_powerfilter.y - 176
		shl_msg.y = shl_msg.y - 176
		ln_1.beginy = ln_1.beginy - 176
		ln_1.endy = ln_1.endy - 176
		r_2.height = r_2.height - 176
		this.height = this.height - 176
	END IF
END IF

//Save initial offset positions for controls that move or resize
ii_dwxoffset = this.width - dw_powerfilter.x - dw_powerfilter.width
ii_dwyoffset = this.height - dw_powerfilter.y - dw_powerfilter.height
ii_dwbxoffset = this.width - dw_buttons.x - dw_buttons.width
ii_dwbyoffset = this.height - dw_buttons.y - dw_buttons.height
ii_OKxoffset = this.width - cb_ok.x - cb_ok.width
ii_OKyoffset = this.height - cb_ok.y - cb_ok.height
ii_Canxoffset = this.width - cb_cancel.x - cb_cancel.width
ii_Canyoffset = this.height - cb_cancel.y - cb_cancel.height

ii_resizerxoffset = this.width - p_resizer.x - p_resizer.width
ii_resizeryoffset = this.height - p_resizer.y - p_resizer.height

ii_Rectxoffset = this.width - r_2.x - r_2.width
ii_Rectyoffset = this.height - r_2.y - r_2.height

ii_lineyoffset = this.height - ln_1.endy

ii_evalxoffset = this.width - shl_msg.x - shl_msg.width
ii_evalyoffset = this.height - shl_msg.y - shl_msg.height

ii_minwidth = this.width
ii_minheight = this.height

// Get and store the parent object of this dropdown.
of_getparentwindow (iw_parent)
// Get and store which control on the parent window is the default control
of_getdefaultcontrol(iw_parent)

shl_msg.visible = iu_powerfilter_checkbox.ib_Visible
shl_msg.enabled = iu_powerfilter_checkbox.ib_Visible
RETURN 0
end function

on u_powerfilter_dropdown.create
this.p_1=create p_1
this.r_2=create r_2
this.p_resizer=create p_resizer
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_1=create cbx_1
this.dw_powerfilter=create dw_powerfilter
this.dw_buttons=create dw_buttons
this.ln_1=create ln_1
this.shl_msg=create shl_msg
this.Control[]={this.p_1,&
this.r_2,&
this.p_resizer,&
this.cb_cancel,&
this.cb_ok,&
this.cbx_1,&
this.dw_powerfilter,&
this.dw_buttons,&
this.ln_1,&
this.shl_msg}
end on

on u_powerfilter_dropdown.destroy
destroy(this.p_1)
destroy(this.r_2)
destroy(this.p_resizer)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_1)
destroy(this.dw_powerfilter)
destroy(this.dw_buttons)
destroy(this.ln_1)
destroy(this.shl_msg)
end on

type p_1 from picture within u_powerfilter_dropdown
boolean visible = false
integer x = 23
integer y = 424
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "PF_checkmark_PF.bmp"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type r_2 from rectangle within u_powerfilter_dropdown
long linecolor = 134217744
integer linethickness = 12
long fillcolor = 1073741824
integer x = -9
integer width = 1079
integer height = 1400
end type

type p_resizer from picture within u_powerfilter_dropdown
event ue_mousemove pbm_mousemove
string tag = "//MULTILANG PowerTipText"
integer x = 1024
integer y = 1360
integer width = 32
integer height = 28
string pointer = "SizeNWSE!"
boolean originalsize = true
string picturename = "PF_resize_PF.bmp"
boolean focusrectangle = false
string powertiptext = "Click and drag to change size of dropdown"
end type

event ue_mousemove;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_pointerx, li_pointery,li_width,li_height

If Not KeyDown(keyLeftButton!) Then
	Return
End If
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE

// Get the new position.
li_pointerx = iw_parent.PointerX()
li_pointery = iw_parent.PointerY()	
//w_powerfilterdemo_main.st_test.text = string(li_pointerx) + '/' + string(li_pointery)
parent.of_resize(li_pointerx,li_pointery)

Return 1

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
parent.EVENT POST ue_checkfocus()

end event

event constructor;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
// Defined the object to be on Top of other objects.
this.SetPosition(ToTop!)


end event

type cb_cancel from commandbutton within u_powerfilter_dropdown
event ue_key pbm_keydown
string tag = "//MULTILANG  Cancel"
integer x = 658
integer y = 1248
integer width = 379
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean default = true
end type

event ue_key;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
CHOOSE CASE key 
	CASE KeyUpArrow!,KeyLeftArrow!
		cb_ok.SetFocus()
	CASE KeyDownArrow!,KeyRightArrow!
		dw_buttons.SetRow(1)
		dw_buttons.SetFocus()
END CHOOSE
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
of_close()
//Restore state of objects since cancel was pressed, don't want to save state changes. Restore these values in of_GetValues
of_restorestate()
idw_dw.setfocus() //restore focus to datawindow
end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
parent.EVENT POST ue_checkfocus()
this.default=FALSE

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
this.default=TRUE
end event

type cb_ok from commandbutton within u_powerfilter_dropdown
event ue_key pbm_keydown
string tag = "//MULTILANG OK"
integer x = 242
integer y = 1248
integer width = 379
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event ue_key;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
CHOOSE CASE key 
	CASE KeyUpArrow!,KeyLeftArrow!
		dw_powerfilter.SetFocus()
//		dw_powerfilter.SelectTreeNode(1,1,True)
	CASE KeyDownArrow!,KeyRightArrow!
		cb_cancel.SetFocus()
END CHOOSE
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Long ll_checkedcount,ll_uncheckedcount
Long	ll_row,ll_rows,ll_startloop
String ls_item,ls_delimfront,ls_delimback,ls_equal
String ls_Not,ls_comma,ls_PowerTipText,ls_colname
Boolean	lb_blankfound,lb_checkdecimal

SetPointer(HourGlass!)

//If this is a column with codetable, use alternate column name, otherwise use original column name
IF isnull(iu_powerfilter_checkbox.is_lookup[ii_colnum]) THEN
	ls_colname = is_colname
ELSE
	ls_colname = iu_powerfilter_checkbox.is_lookup[ii_colnum]
END IF

//if (Select All) checked, then no filter on this column
IF cbx_1.checked THEN
	is_ColumnFilter = ''
	ls_PowerTipText = is_DefaultTipText
ELSE
	CHOOSE CASE is_ColType
		CASE 'char(','char'
			ls_delimfront = '"'
			ls_delimback = '"'
		CASE 'int','long','ulong'
			ls_delimfront = ''
			ls_delimback = ''
		CASE 'numbe','real','decim'
			lb_checkdecimal = TRUE //numeric types that could hold decimal must be checked to convert commas to periods if international format uses comma for decimal place
			ls_delimfront = ''
			ls_delimback = ''
		CASE 'time'
			ls_delimfront = 'time("'
			ls_delimback = '")'
		CASE 'date'
			ls_delimfront = 'date("'
			ls_delimback = '")'
		CASE 'datet','times'
			ls_delimfront = 'datetime("'
			ls_delimback = '")'
		CASE ELSE
			messagebox("Error",is_ColType + " column type for is_ColType not recognized")
			RETURN -1
	END CHOOSE
	//compare number of checked vs. non-checked, and build smaller list using 'NOT IN" instead of 'IN'
	dw_powerfilter.setredraw(false)
	dw_powerfilter.setfilter('check = "1"') //only include the checked items
	dw_powerfilter.Filter( )
	ll_checkedcount = dw_powerfilter.rowcount( )
	ll_uncheckedcount = dw_powerfilter.filteredcount( )

	ls_Not = ''
	ls_equal = is_equals_cap + ' "' //'Equals "' //MULTILANG Equals
	
	IF ll_uncheckedcount < ll_checkedcount THEN
		//reverse the logic to 'NOT IN' instead of 'IN' since checks outnumber not checks
		dw_powerfilter.setfilter('check = "0"') //only include the non-checked items
		dw_powerfilter.Filter( )
		ls_Not = 'Not '
		ls_equal = is_doesnotequal_cap + ' "' //'Does not equal "' //MULTILANG Does not equal
	END IF
		
	dw_powerfilter.sort()
	ll_rows = dw_powerfilter.rowcount( )
	IF ll_rows > 0 THEN
		ll_row = 1
		ls_item = dw_powerfilter.GetItemString( ll_row, 'Item' )
		ls_PowerTipText = ls_equal + ls_item 
		CHOOSE CASE ls_item
			CASE is_Blank //MULTILANG
				is_ColumnFilter = '(isnull(' + ls_colname + ') or trim(string(' + ls_colname + ')) = "" '
				IF ll_rows > 1 THEN
					ll_row = 2
					ls_item = dw_powerfilter.GetItemString( ll_row, 'Item' )
					ls_PowerTipText = ls_PowerTipText + ', ' + ls_Item 
					of_Replace(ls_Item,'"','~~~"')
					is_ColumnFilter = is_ColumnFilter + ' or '  +ls_colname + ' in (' + ls_delimfront + ls_item + ls_delimback 
					lb_blankfound=TRUE
				END IF
				ll_startloop = 3
			CASE ELSE
				of_Replace(ls_Item,'"','~~~"')
				IF lb_checkdecimal THEN of_Replace(ls_item,',','.') //decimals must be in US format
				is_ColumnFilter = ls_colname + ' in (' + ls_delimfront + ls_item + ls_delimback 
				ll_startloop = 2
		END CHOOSE
		
		FOR ll_row = ll_startloop to ll_rows
			ls_item = dw_powerfilter.GetItemString( ll_row, 'Item')
			ls_PowerTipText = ls_PowerTipText + ', ' + ls_Item 
			of_Replace(ls_Item,'"','~~~"') //change all double-quotes to tilde-double-quotes in Item String for filter string
			IF lb_checkdecimal THEN of_Replace(ls_item,',','.') //decimals must be in US format
			is_ColumnFilter = is_ColumnFilter + ',' + ls_delimfront + ls_item + ls_delimback
		NEXT
		is_ColumnFilter = '(' + ls_Not + '(' + is_ColumnFilter + ')))'
		IF lb_blankfound THEN is_ColumnFilter = is_ColumnFilter + ')' //closing paren for null 'OR' clauses
		ls_PowerTipText = ls_PowerTipText + '"'
	ELSE
		is_ColumnFilter = '' //none checked is same as (Select All) checked, (no filter)
		ls_PowerTipText = is_DefaultTipText
	END IF
	dw_powerfilter.setfilter('')
	dw_powerfilter.filter( )
	dw_powerfilter.sort()
	dw_powerfilter.setredraw(TRUE)
END IF
//close dropdown (still exists, just not visible)
of_close()
//turn off any predefined filter check
iu_powerfilter_predeffilters.of_flagrow(0) //0 means turn off if a previous row was flagged, don't flag new row
iu_powerfilter_monthopts.of_flagrow(0)
//set correct picture on column button to indicate if there is a filter on this column
IF is_ColumnFilter = '' THEN 
	dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',0)
	p_1.visible=FALSE
ELSE
	dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',1)
	p_1.visible=TRUE
END IF
dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',0) //turn off the custom filter picture
//set tooltip text 
//IF len(ls_PowerTipText) > 150 THEN ls_PowerTipText = left(ls_PowerTipText,150) + '...'
//of_Replace(ls_PowerTipText,'"','~~~"') 
//of_Replace(ls_PowerTipText,"'","~~~'") 
//idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".Tooltip.Tip='"+ls_PowerTipText+"'")

//call function in checkbox to build and apply master filter with changes to this column's filter
iu_powerfilter_checkbox.of_buildfilter(is_ColumnFilter,ii_ColNum)
//Save state of objects since now using 1 dropdown for all columns, restore these values in of_GetValues
of_savestate()
//clear previous contents of datastore before copying back from visual
ids_powerfilter[ii_colnum].reset() 
//copy all rows with current checkvalues back to datastore
dw_powerfilter.RowsCopy(1,dw_powerfilter.RowCount(), Primary!, ids_powerfilter[ii_colnum], 1, Primary!)
idw_dw.setfocus( ) //restore focus to datawindow

end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.default=FALSE
parent.EVENT POST ue_checkfocus()

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
this.default=TRUE

end event

type cbx_1 from checkbox within u_powerfilter_dropdown
event ue_key pbm_keydown
string tag = "//MULTILANG (Select All)"
integer x = 165
integer y = 360
integer width = 891
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = " (Select All)                                       "
boolean checked = true
end type

event ue_key;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
CHOOSE CASE key
	CASE KeyDownArrow!
		dw_powerfilter.SetFocus()
//		dw_powerfilter.SelectTreeNode(1, 1, TRUE)
	CASE KeyUpArrow!
		dw_buttons.SetRow(dw_buttons.rowcount())
		dw_buttons.SetFocus()
END CHOOSE
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Long ll_row,ll_rows

ll_rows = dw_powerfilter.rowcount()

IF this.checked THEN
	//select all items
	FOR ll_row = 1 to ll_rows
		dw_powerfilter.Object.check[ll_row] = "1"
		dw_powerfilter.Object.checkmonth[ll_row] = "1"
		dw_powerfilter.Object.checkyear[ll_row] = "1"
	NEXT
ELSE
	//unselect all items
	FOR ll_row = 1 to ll_rows
		dw_powerfilter.Object.check[ll_row] = "0"
		dw_powerfilter.Object.checkmonth[ll_row] = "0"
		dw_powerfilter.Object.checkyear[ll_row] = "0"
	NEXT
END IF

end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
parent.EVENT POST ue_checkfocus()
cb_ok.default=FALSE

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
cb_ok.default=TRUE

end event

type dw_powerfilter from datawindow within u_powerfilter_dropdown
event ue_mousemove pbm_dwnmousemove
event ue_dwnkey pbm_dwnkey
integer x = 151
integer y = 432
integer width = 882
integer height = 792
integer taborder = 30
string title = "none"
string dataobject = "d_powerfilter"
boolean vscrollbar = true
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
	KeyDown(KeySpaceBar!) or & 
	KeyDown(KeyTab!) THEN RETURN
	
this.setfocus()
this.setrow(row)
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE

end event

event ue_dwnkey;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF key = KeyUpArrow! and this.getrow() = 1 THEN
	cbx_1.SetFocus()
END IF
IF key = KeyDownArrow! and this.getrow() = this.rowcount() THEN
	cb_ok.SetFocus()
END IF
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String 	ls_band,ls_level,ls_checked,ls_setvalue
Integer	li_tab,li_year,li_month
Boolean	ib_partial
Long		ll_row,ll_firstrow,ll_lastrow
ll_row = row
IF NOT ll_row > 0 THEN RETURN
IF this.GetItemString(row,"check") = '1' THEN
	this.SetItem( row, "check", '0')
ELSE
	this.SetItem( row, "check", '1')
END IF
this.SetRow( row )

//see if all items checked or not to set 'Select All' checkbox
IF this.Find ( "check = '0' or isnull(check)", 1, this.rowcount() + 1 ) = 0 THEN
	cbx_1.checked = TRUE
ELSE
	cbx_1.checked = FALSE
END IF
end event

event constructor;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.SetRowFocusIndicator(FocusRect!)
end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
cb_ok.default=FALSE
parent.EVENT POST ue_checkfocus()

end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter_monthopts.visible=FALSE
iu_powerfilter_predeffilters.visible = FALSE
cb_ok.default=TRUE

end event

event scrollhorizontal;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.Object.DataWindow.HorizontalScrollPosition=1 //force back to beginning of dw, don't allow horizontal scroll after resize
end event

type dw_buttons from datawindow within u_powerfilter_dropdown
event ue_mousemove pbm_dwnmousemove
event ue_dwnkey pbm_dwnkey
integer x = 5
integer y = 4
integer width = 1051
integer height = 356
integer taborder = 10
string title = "none"
string dataobject = "d_powerfilter_ddbuttons"
boolean border = false
borderstyle borderstyle = stylelowered!
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

IF row = this.rowcount() THEN
	iu_powerfilter_predeffilters.dw_1.SetFocus()
	iu_powerfilter_predeffilters.visible = TRUE 
ELSE
	iu_powerfilter_monthopts.visible=FALSE
	iu_powerfilter_predeffilters.visible = FALSE
	this.SetFocus()
END IF
this.setrow(row)
end event

event ue_dwnkey;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF this.getrow() = this.rowcount() THEN
	CHOOSE CASE key
		CASE KeyDownArrow!
			cbx_1.SetFocus()
		CASE KeyRightArrow!
			iu_powerfilter_predeffilters.dw_1.SetFocus()
			iu_powerfilter_predeffilters.Visible = TRUE 
	END CHOOSE
END IF
IF this.getrow() = 1 THEN
	CHOOSE CASE key
		CASE KeyUpArrow!
			cb_Cancel.SetFocus()
	END CHOOSE
END IF

IF key = KeyEnter! THEN
	//Enter usually scrolls down on DW, I want to trigger click
	DWObject dwo_column
	dwo_column = this.object.buttonname
	this.event post clicked( PointerX(), Pointery(), this.getrow(), dwo_column)
	//need to adjust final location since Enter still scrolls to next line
END IF
end event

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String ls_return, ls_colname
String ls_PowerTipText

IF row > 0 THEN
	//test for valid row
ELSE
	RETURN
END IF
IF GetItemNumber(row,'Active') = 1 THEN
	//Active Button
ELSE
	Return //button not flagged as active, so don't perform any logic
END IF

IF isnull(iu_powerfilter_checkbox.is_lookup[ii_colnum]) THEN
	ls_colname = is_colname
ELSE
	ls_colname = iu_powerfilter_checkbox.is_lookup[ii_colnum]
END IF

CHOOSE CASE row
	CASE this.rowcount()
		//custom filter either row 4 or row 2
	CASE this.rowcount() - 1
		//clear filter either row 3 or row 1
		is_ColumnFilter = ''
		ls_PowerTipText = is_DefaultTipText
		iu_powerfilter_checkbox.of_setbuttonpics()
		dw_buttons.SetItem(dw_buttons.rowcount()-1,'Active',0)
		dw_buttons.SetItem(dw_buttons.rowcount(),'Selected',0)
		p_1.visible = FALSE
		iu_powerfilter_predeffilters.of_flagrow(0) //clear any flagged row on predefined filter list
		iu_powerfilter_monthopts.of_flagrow(0)
//		idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".ToolTip.Tip='"+ls_PowerTipText+"'")
		cbx_1.checked = TRUE
		//call function in checkbox to build and apply master filter with changes to this column's filter
		iu_powerfilter_checkbox.of_buildfilter(is_ColumnFilter,ii_ColNum)
		of_close()
		of_savestate()	
	CASE 1 //sort ascending
		IF iu_powerfilter_checkbox.maintaingroups THEN
			idw_dw.setredraw(false)
			idw_dw.setsort( iu_powerfilter_checkbox.is_originalsort + ',' + ls_ColName )
			idw_dw.sort()
			idw_dw.groupcalc()
			idw_dw.setredraw(true)
		ELSE
			idw_dw.setsort( ls_ColName )
			idw_dw.sort()
		END IF
		iu_powerfilter_checkbox.of_setbuttonpics()
		of_close()
	CASE 2 //sort descending
		IF iu_powerfilter_checkbox.maintaingroups THEN
			idw_dw.setredraw(false)
			idw_dw.setsort( iu_powerfilter_checkbox.is_originalsort + ',' + ls_ColName + " Desc"  )
			idw_dw.sort()
			idw_dw.groupcalc()
			idw_dw.setredraw(true)
		ELSE
			idw_dw.setsort( ls_ColName + " Desc" )
			idw_dw.sort()
		END IF
		iu_powerfilter_checkbox.of_setbuttonpics()
		of_close()
END CHOOSE
end event

event losefocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.object.rr_1.visible=FALSE

parent.EVENT POST ue_checkfocus()

end event

event scrollhorizontal;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.Object.DataWindow.HorizontalScrollPosition=1 //force back to beginning of dw, don't allow horizontal scroll after resize
end event

event getfocus;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.object.rr_1.visible="0~tif(getrow() = currentRow(),1,0)"
cb_ok.default=FALSE

end event

type ln_1 from line within u_powerfilter_dropdown
long linecolor = 134217744
integer linethickness = 4
integer beginx = 123
integer beginy = 340
integer endx = 123
integer endy = 1380
end type

type shl_msg from statichyperlink within u_powerfilter_dropdown
integer x = 155
integer y = 1156
integer width = 873
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217856
string text = "Unlicensed Evaluation version"
alignment alignment = center!
boolean focusrectangle = false
string url = "www.PowerToTheBuilder.com"
end type

