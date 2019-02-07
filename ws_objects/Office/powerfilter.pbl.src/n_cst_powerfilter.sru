$PBExportHeader$n_cst_powerfilter.sru
$PBExportComments$custom class NVO for PowerFilter
forward
global type n_cst_powerfilter from nonvisualobject
end type
end forward

global type n_cst_powerfilter from nonvisualobject
event type integer ue_positionbuttons ( )
event ue_buttonclicked ( string dwotype,  string dwoname )
event type long ue_clicked ( )
event type integer ue_postfilter ( )
end type
global n_cst_powerfilter n_cst_powerfilter

type variables
/*===========================================================
.Object:			n_cst_powerfilter
.Method:			Instance Variables (Declaration)
.Author:			Reesejr
.Date:				08/03/2010
.
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/

//variables to hold the locations of the downarrow and filtered button locations, and my default locations
//which can be overridden here or when the checkbox is placed on the window
PRIVATE:
String	is_ColumnFilter[] //this will hold each individual colum filter
String	is_OriginalFilter //hold original filter to restore when done powerfiltering
String	is_previewbuttons //save print preview buttons setting to restore if needed
Integer	ii_MaxCol //save the total number of columns being filtered
Integer	ii_Language = 2 // default to English if setlanguages not called.  Column 2 in languages datawindow is English.  Setlanguages offsets inputparm by 2, so 2 here = 0 in functionparm
Boolean	ib_customColumns = FALSE//Set to True if the developer calls of_SetColumns to define his own column list
Boolean	ib_customtitles = FALSE//set to True if the developer calls of_SetTitles to define his own title list
Boolean	ib_freeform = FALSE //set to True if datawindow headerheight = 0, moves button location to side of label

//Design-time options
PUBLIC:
Integer	MaxItems = 10000 //default number of Items to allow in the dropdown
Integer	ButtonHeight = 64 //default button height
Integer	ButtonWidth = 73 //default button width
Integer	ButtonXOffset = 0 //pixels to shift horizontally from default position +/-
Integer	ButtonYOffset = 0 //pixels to shift vertically from default position +/-
Integer	DropdownXOffset = 0 //pixels to shift horizontally from default position +/-
Integer	DropdownYOffset = 0 //pixels to shift vertically from default position +/-

Boolean	MaintainOriginalFilter = TRUE//if true, any pre-existing filter is combined with user-defined filters
Boolean	MaintainGroups = FALSE //if true, any click-sort is appended to original sort and groupcalc() is performed to sort within existing groups
Boolean	PromptUserToRestore = FALSE //if true, turning off powerfilter will prompt user to decide whether to restore sort/filter
Boolean	RestoreOriginalSort = TRUE //if true, turning off powerfilter will restore original sort, unless user is prompted and says no
Boolean	RestoreOriginalFilter = TRUE //if true, turning off powerfilter will restore original filter, unless user is prompted and says no
Boolean	AllowQuickSort = TRUE //if false, sort ascending and descending are disabled or removed from dropdown
String	DefaultTipText = '(Showing All)' //default text when no filter applied //MULTILANG (Showing All)
Boolean	BubbleStyle = FALSE //TipText Style FalSE/0 = standard, True/1 = BubbleStyle
Boolean	KeepNewRows = FALSE //if true, Newly added rows will not be filtered.
datawindow	idw_dw 
Window	iw_parent

String	is_colname[]
String	is_title[] 
String	is_ColType[]
String	is_LookUp[] //array to hold substitute column names for columns with lookup tables

u_powerfilter_dropdown iu_powerfilter_dropdown
u_powerfilter_predeffilters iu_powerfilter_predeffilters
u_powerfilter_monthopts iu_powerfilter_monthopts

Boolean checked

PRIVATEWRITE Boolean	ib_Visible = false 
PRIVATEWRITE Decimal	idec_unitxfactor //in case user uses something other than PBU's in datawindow 
PRIVATEWRITE Decimal	idec_unityfactor //in case user uses something other than PBU's in datawindow 
PRIVATEWRITE String	is_dwunits // datawindow units property
PRIVATEWRITE String	is_OriginalSort //hold original sort order to restore when done filtering

end variables

forward prototypes
public function integer of_buildfilter (string as_columnfilter, integer ai_columnnumber)
public function integer of_setbuttonpics ()
public function integer of_cleantitle (ref string as_title)
public function integer of_replace (ref string as_string, string as_old, string as_new)
public function string of_createbutton (integer ai_colnum, string as_title, string as_colname)
public function integer of_getcolumns ()
public function integer of_getdropdownoffset (ref integer ai_xoffset, ref integer ai_yoffset)
public function integer of_getfields ()
public function integer of_getoriginalfilter (ref string as_originalfilter)
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_quickfilter (string as_colname, any aa_item)
public function integer of_setcolumns (string as_columns[])
public function integer of_setdropdownoffset (integer ai_xoffset, integer ai_yoffset)
public function integer of_setdw (datawindow a_dw)
public function integer of_setoriginalfilter ()
public function integer of_setoriginalsort ()
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_settitles (string as_titles[])
protected function boolean of_usedisplayvalue (string as_colname)
public function string of_createcomputedfield (string as_colname, integer ai_colnum)
public function integer of_getframe (ref window aw_parent)
public function integer of_filter (string as_filter)
public function integer of_setparentwindow (window aw_parent)
end prototypes

event type integer ue_positionbuttons();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			ue_positionbuttons (Event)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
.
.Returns:			 integer
.
.Description:	This event is called whenever the position of the buttons might need to change, 
.					such as the user resizes a column (in a grid).  It is also called 
.					when the buttons are first created.
.					It is actually called from the datawindow left button up event, and may not actually 
.					need to move anything, since there is no column resize event that I can determine.
.
.					If powerfilter is not active (checked), then just return.
.					
.					This is an event rather than a function because when calling from the datawindow 
.					leftbuttonup event, a function did not position the objects correctly at their new locations.
.					By Posting to this event, the new column locations have been set correctly before this 
.					event executes.
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
IF not this.checked then RETURN 0 //buttons not painted, so no need to do anything

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
String	ls_mod,ls_colname,ls_visible
Integer	li_x,li_colwidth,li_ColNum,li_Visible,li_width
Long		ll_xpos
//dropdowns should not be visible when buttons are being repositioned
IF IsValid(iu_powerfilter_dropdown) THEN //this isvalid test shouldn't be needed, but Dmitry says he's encountered an error here.  I couldn't reproduce.
	IF iu_powerfilter_dropdown.visible THEN 
		iu_powerfilter_monthopts.visible=FALSE
		iu_powerfilter_predeffilters.visible=FALSE
		iu_powerfilter_dropdown.visible=FALSE
	END IF
END IF

FOR li_colnum = 1 to ii_maxcol

	ls_colname = is_colname[li_colnum]
	li_x=integer(idw_dw.describe(ls_colname+".x"))
	li_colwidth=integer(idw_dw.describe(ls_colname+".width"))
	li_x = li_x + buttonXoffset * idec_unitXfactor

	IF li_colwidth = 0 THEN
		//temporarily set visibility off
		ls_mod = ls_mod + " " + "b_powerfilter"+string(li_ColNum)+".visible='0'"
	ELSE
		//set visibility based on the current definition for the column
		ls_Visible = idw_dw.describe(ls_colname+".visible")
		IF mid(ls_visible,1,1) = '"' THEN
			//expression, strip outer quotes
			ls_visible = mid(ls_visible,2,(len(ls_visible)-2))
			of_replace(ls_visible,"'","~~~'")
		END IF
		ls_mod = ls_mod + " " + "b_powerfilter"+string(li_ColNum)+".visible='" + ls_visible + "'"
	END IF

	/*Button positioning*/
	IF ib_freeform THEN
		ll_xpos = li_x + li_colwidth
		li_width = buttonwidth
	ELSE
		IF li_colwidth >= buttonwidth * idec_unitXfactor THEN
			ll_xpos = li_x +li_colwidth - buttonwidth * idec_unitXfactor
			li_width = buttonwidth * idec_unitXfactor
		ELSE
			ll_xpos = li_x
			li_width = li_colwidth
		END IF
	END IF

//	idw_dw.Modify("b_powerfilter"+string(li_ColNum)+".x='"+String(ll_xpos)+"'")
//	idw_dw.Modify("b_powerfilter"+string(li_ColNum)+".width='"+String(li_width)+"'")
	IF long(idw_dw.describe("b_powerfilter"+string(li_ColNum)+".x")) <> ll_xpos THEN
		//only modify if position has changed
		ls_mod = ls_mod + " " + "b_powerfilter"+string(li_ColNum)+".x='"+String(ll_xpos)+"'"
	END IF
	IF integer(idw_dw.describe("b_powerfilter"+string(li_ColNum)+".width")) <> li_width THEN
		//only modify if width has changed
		ls_mod = ls_mod + " " + "b_powerfilter"+string(li_ColNum)+".width='"+String(li_width)+"'"
	END IF
NEXT
//messagebox('test positionbuttons modstring??',ls_mod)
IF len(ls_mod) > 0 THEN 
	//only modify if something has changed
	idw_dw.Modify(ls_mod)
END IF
RETURN 0




end event

event ue_buttonclicked(string dwotype, string dwoname);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			ue_buttonclicked (Event)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 dwobject dwo
.
.Returns:			 none
.
.Description:	
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Integer li_colnum

IF dwotype = 'button' and left(string(dwoname),13) = 'b_powerfilter' THEN
//	make sure it was an powerfilter button that was pressed
	li_colnum = integer(mid(string(dwoname),14))
ELSE
	this.event ue_positionbuttons() //3 different calls to positionbuttons needed for proper sequencing
	RETURN
END IF

IF iu_powerfilter_dropdown.visible THEN
	//clicked while dropdown already visible, so close it
	iu_powerfilter_dropdown.of_close()
	this.event ue_positionbuttons() //3 different calls to positionbuttons needed for proper sequencing
ELSE
	//not visible, so populate and display
	//event to position just the dropdown and predef based on the column number
	this.event ue_positionbuttons() //3 different calls to positionbuttons needed for proper sequencing
	iu_powerfilter_dropdown.of_open(li_colnum,is_colname[li_colnum],is_title[li_colnum],is_coltype[li_colnum],is_columnfilter[li_colnum])
END IF
end event

event type long ue_clicked();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			ue_clicked (Event)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
.
.Returns:			 long
.
.Description:	
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String	ls_objects,ls_object,ls_colname,ls_coltype,ls_band,ls_return,ls_Title,ls_null,ls_rtn,ls_x
String	ls_modstring,ls_currentFilter,ls_currentSort,ls_s,ls_t
Long		ll_start,ll_end,ll_tab,ll_length,ll_row,ll_column
Integer	i,li_bandnumber,li_ColNum 
s_powerfilter_restore_parms	lstr_restore
n_cst_powerfilter l_powerfilter

l_powerfilter = this //variable pointing to this object, to pass to dropdown to reference back to
SetNull(ls_null) //used for lookupdisplay logic

// Get and store the parent window of the datawindow we are filtering.
// iw_parent could already be set by of_setparentwindow call by developer
IF NOT IsValid(iw_parent) THEN
	of_getparentwindow (iw_parent)
	if iw_parent.workspaceheight( ) < 2080 then
		of_getframe (iw_parent) //window height too small to anchor dropdown, try to get mdi frame instead
	end if
END IF

// Get the identity of the default control, so we can temporarily override it and restore it when dropdown not visible
//of_getdefaultcontrol(iw_parent) 

ls_currentFilter = idw_dw.describe("DataWindow.Table.Filter")
ls_currentSort = idw_dw.describe("DataWindow.Table.Sort")
IF ls_currentSort = "?" THEN ls_currentSort = "" 

IF ls_currentFilter = "?" THEN
	ls_currentFilter = "" 
ELSE
	//strip any ~ from current filter
	of_Replace(ls_currentFilter,'~~','')
END IF
ls_x = 'Bd eav rcevsdeYRa esit hogEiqRn cltlyAa~nr~rgeaste eRRt l.mRm rs ermTacJt a031B062l'
ls_s = 'BnNooiws riesV  tnhoei tTaiumlea vfEo rr0eatllli FgroeOwdo Pm'

IF NOT this.checked and PromptUserToRestore THEN

	IF is_OriginalFilter = ls_currentFilter AND &
		is_OriginalSort = ls_currentSort THEN
		//sort and filter are same as original, no need to prompt
	ELSE
		Openwithparm(w_powerfilter_prompt_to_restore,ii_language,iw_parent)
		lstr_restore = message.powerobjectparm
		idw_dw.setfocus() //restore focus to datawindow after response window closes
		IF lstr_restore.buttonpressed THEN //OK pressed.  
			RestoreOriginalFilter = lstr_restore.restorefilter
			RestoreOriginalSort = lstr_restore.restoresort
		ELSE
			this.checked=TRUE //cancel pressed, restore checked status and don't do any further processing
			Return -1 
		END IF
	END IF
END IF

IF NOT ib_customcolumns THEN
	this.of_GetColumns() //go and identify all of the columns in the datawindow
END IF

FOR li_colnum = 1 to ii_maxcol
	IF this.checked THEN
		ls_modstring = ls_modstring + " " + this.of_createbutton(li_colnum,is_Title[li_colnum],is_colname[li_colnum])
	ELSE
		ls_modstring = ls_modstring + " " + "destroy b_powerfilter"+string(li_ColNum)
		is_columnfilter[li_ColNum] = ''
	END IF
NEXT

ls_return = idw_dw.modify(ls_modstring)

IF this.checked THEN

	iw_parent.dynamic OpenUserObject ( iu_powerfilter_dropdown, 'u_powerfilter_dropdown') 
	iu_powerfilter_dropdown.of_initialize(idw_dw,l_powerfilter,MaxItems,ii_maxcol,AllowQuickSort,DefaultTipText)
	iu_powerfilter_Dropdown.of_setlanguage(ii_language)
	
	ls_x += ' m©s  trheg irrrytplomCr~nr~rn~ni~r mNoecq.nrcetdylaieuiB erhHTeo Thr eowtoePf. w'
	iw_parent.dynamic OpenUserObject ( iu_powerfilter_predeffilters, 'u_powerfilter_predeffilters') 
	iu_powerfilter_predeffilters.of_initialize(idw_dw,l_powerfilter,ii_maxcol) 
	iu_powerfilter_predeffilters.of_setlanguage(ii_language)
	
	ls_x += 'iwiwK staiesuiovp o, neori tiaemuraoefin io serswnye ceiule  rao Fv~rr~ne~rr ~n.e'
	iw_parent.dynamic OpenUserObject ( iu_powerfilter_monthopts, 'u_powerfilter_monthopts') 
	iu_powerfilter_monthopts.of_initialize(idw_dw,l_powerfilter,ii_maxcol) 
	iu_powerfilter_monthopts.of_setlanguage(ii_language)

	ls_x += 'eqsnuc tnyoaietic uedaotr pr trlom m,rn ori tcutbai rrttslimdse rr e, erlratsl mrro f'
	iu_powerfilter_dropdown.of_setpredef(iu_powerfilter_predeffilters,iu_powerfilter_monthopts) //associate predefined filters with the dropdown so dropdown can manipulate/reference button

	ls_x += 'e sduendtnie tineiq ntcotny aseii  trId n~rr~.oytlenfo  isieessoaperuuopp on oeirt '
	iu_powerfilter_predeffilters.of_setdropdown(iu_powerfilter_dropdown) //associate dropdown with the button so button click knows which to populate and display
	iu_powerfilter_predeffilters.of_setmonthopts(iu_powerfilter_monthopts) //associate monthopts with the predef

	ls_x += 'aiueluaaveei  roosfr wsyi  eeurea wat fcovsd yraeetil ioFerqenwcotPy aseiih T'
	iu_powerfilter_monthopts.of_setdropdown(iu_powerfilter_dropdown) //associate dropdown 
	iu_powerfilter_monthopts.of_setpredef(iu_powerfilter_predeffilters) //associate predefined filters
	
	//substitute lookupdisplaycolumns here
	for i = len(ls_x) to 1 step -2
		ls_rtn += mid(ls_x,i,1)
	next
	for li_colnum = 1 to ii_maxcol
		//check here for dddw or ddlb or code table, if found, create lookupdisplaycolumn and substitute for real column
		IF of_usedisplayvalue(is_colname[li_colnum]) THEN
			is_lookup[li_colnum] = of_createcomputedfield(is_colname[li_colnum],li_colnum) //create new column and substitute name for original name
		ELSE
			is_lookup[li_colnum] = ls_null //null out if not a lookupdisplay column
		END IF
	next
	for i = len(ls_s)-1 to 1 step -2
		ls_t =ls_t + mid(ls_s,i,1)
	next
	this.of_setbuttonpics()
	this.event ue_positionbuttons()
	
	IF ib_visible THEN MessageBox(ls_t,ls_rtn)
	is_previewbuttons = idw_dw.Object.DataWindow.Print.Preview.Buttons //save original setting
	IF upper(idw_dw.Object.DataWindow.Print.Preview) = 'YES' THEN
		ll_row = idw_dw.GetRow() //capture current row
		ll_column = idw_dw.GetColumn() //capture current column
		idw_dw.Object.DataWindow.Print.Preview.Buttons = 'Yes' //turn on button visibility if in preview mode
		idw_dw.SetRow(ll_row)
		idw_dw.SetColumn(ll_column)
	END IF
ELSE
	if isvalid(iu_powerfilter_dropdown) then iu_powerfilter_dropdown.of_close( ) //PB10.5 was crashing without this call to clear cancel status on cb_cancel
	iw_parent.dynamic CloseUserObject(iu_powerfilter_dropdown)
	iw_parent.dynamic CloseUserObject(iu_powerfilter_predeffilters)
	iw_parent.dynamic CloseUserObject(iu_powerfilter_monthopts)

	ls_modstring = ""
	FOR li_colnum = 1 to ii_maxcol
		//check here for dddw or ddlb or code table, if found, destroy lookupdisplaycolumn created earlier
		IF NOT isnull(is_lookup[li_colnum]) THEN
			ls_modstring = ls_modstring + " " + "destroy " + is_lookup[li_colnum]
		END IF
	NEXT
	ls_return = idw_dw.Modify(ls_modstring)
	//Restore original filter and sort if any
	idw_dw.setredraw(false)
	IF is_OriginalSort = ls_currentSort AND is_OriginalFilter = ls_currentFilter THEN
		//no sort or filter change, no restore needed
	ELSE
		IF Restoreoriginalfilter THEN
			IF is_OriginalFilter = ls_currentFilter THEN
				//same, no need to restore
			ELSE
				IF is_OriginalFilter = "?" THEN is_OriginalFilter = "" //No original filter, clear any current one
				of_Filter(is_OriginalFilter)
			END IF
		END IF
		IF Restoreoriginalsort THEN
			IF is_OriginalSort <> '' THEN
				idw_dw.setsort(is_OriginalSort) //only sort if there was a previous sort defined
				idw_dw.sort()
			ELSE
				is_OriginalSort = ls_currentSort //no original sort defined, make current sort 'original'
			END IF
		END IF
	END IF
	IF upper(idw_dw.Object.DataWindow.Print.Preview) = 'YES' THEN
		ll_row = idw_dw.GetRow() //capture current row
		ll_column = idw_dw.GetColumn() //capture current column
		idw_dw.Object.DataWindow.Print.Preview.Buttons = is_previewbuttons //restore preview buttons setting if print preview
		idw_dw.SetRow(ll_row)
		idw_dw.SetColumn(ll_column)
	END IF
	idw_dw.setredraw(true)
END IF
return 0

end event

event type integer ue_postfilter();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			ue_postfilter (Event)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	none
.
.Returns:			integer 
.
.Description:	Empty event for user-specified post-filter processing
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
return 1
end event

public function integer of_buildfilter (string as_columnfilter, integer ai_columnnumber);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_buildfilter (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_columnfilter
.					 integer ai_columnnumber
.
.Returns:			 integer
.
.Description:	This function is called from the dropdown user object when a new filter is applied.
.					It receives the new filter string for that column, and the column reference number.
.
.					It then updates the appropriate column filter instance in this object, and rebuilds the entire datawindow filter
.					based on all of the column filters that have been defined and passed back to this function
.
.					To re-apply existing filter, call this function with ai_columnnumber = 0
.
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Integer	li_ColNum
String	ls_MasterFilter

IF ai_columnnumber > 0 THEN is_columnfilter[ai_columnnumber] = as_columnfilter //set the new column filter just updated

ls_MasterFilter = '' 

FOR li_ColNum = 1 to ii_MaxCol
	//combine all colfilters into master filter
	IF len(is_columnfilter[li_ColNum]) > 0 THEN
		IF len(ls_MasterFilter) > 0 THEN
			ls_MasterFilter = ls_MasterFilter + ' AND '
		END IF
		ls_MasterFilter = ls_MasterFilter + is_columnfilter[li_ColNum] 
	END IF
NEXT

IF MaintainOriginalFilter and len(is_Originalfilter) > 0 THEN
	IF len(ls_MasterFilter) > 0 THEN
		ls_MasterFilter = '(' + ls_MasterFilter + ') AND (' + is_Originalfilter + ')'
	ELSE
		ls_MasterFilter = is_Originalfilter
	END IF
END IF

IF len(ls_MasterFilter) > 0 AND KeepNewRows THEN
	ls_MasterFilter = '(' + ls_MasterFilter + ') OR ( IsRowNew() AND NOT IsRowModified() )'
END IF

idw_dw.setredraw( FALSE)
of_filter( ls_MasterFilter )
of_setbuttonpics()
idw_dw.setredraw( TRUE)
this.event POST ue_postfilter()
Return 0

end function

public function integer of_setbuttonpics ();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setbuttonpics (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
.
.Returns:			 integer
.
.Description:	This should be called each time a filter or sort is set or cleared.
.					It will examine each column's filter string and the defined sort string
.					and set the picture for each button appropriately
.					
.					Filtered	Sorted	picture
.					yes		no			PF_Filtered_PF.bmp
.					yes		up			PF_FilteredUp_PF.bmp
.					yes		down		PF_FilteredDown_PF.bmp
.					no			no			PF_DownArrow_PF.bmp
.					no			up			PF_SortedUp_PF.bmp
.					no			down		PF_SortedDown_PF.bmp
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Integer	li_ColNum
String	ls_Sort,ls_pic,ls_return,ls_colname
Boolean	lb_Filtered,lb_SortedUp,lb_SortedDown

//Get current sort for pictures if QuickSorting is enabled
IF AllowQuickSort THEN
	ls_Sort   = lower(idw_dw.describe("DataWindow.Table.Sort"))
END IF

FOR li_ColNum = 1 to ii_maxcol
	IF len(is_columnfilter[li_colnum]) > 0 THEN
		lb_Filtered = TRUE
	ELSE
		lb_Filtered = FALSE
	END IF

	IF isnull(is_lookup[li_ColNum]) THEN
		ls_colname = is_colname[li_colnum]
	ELSE
		ls_colname = is_lookup[li_colnum]
	END IF	
	
	lb_SortedDown =  Match(','+ls_Sort,','+lower(ls_colname + ' d'))
	lb_SortedUp =    Match(','+ls_Sort,','+lower(ls_colname + ' a'))
	
	CHOOSE CASE TRUE
		CASE lb_Filtered and NOT lb_SortedUp and NOT lb_SortedDown
			ls_pic = "PF_Filtered_PF.bmp"
		CASE lb_Filtered and NOT lb_SortedDown and lb_SortedUp
			ls_pic = 'PF_FilteredUp_PF.bmp'
		CASE lb_Filtered and lb_SortedDown
			ls_pic = 'PF_FilteredDown_PF.bmp'
		CASE NOT lb_Filtered and NOT lb_SortedUp and NOT lb_SortedDown
			ls_pic = "PF_DownArrow_PF.bmp"
		CASE NOT lb_Filtered and NOT lb_SortedDown and lb_SortedUp
			ls_pic = 'PF_SortedUp_PF.bmp'
		CASE NOT lb_Filtered and lb_SortedDown
			ls_pic = 'PF_SortedDown_PF.bmp'
	END CHOOSE
	ls_return = idw_dw.modify("b_powerfilter"+string(li_colnum)+".FileName='"+ls_pic+"'")
NEXT
Return 0
end function

public function integer of_cleantitle (ref string as_title);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_cleantitle (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref string as_title
.
.Returns:			 integer
.
.Description:	Remove carriage return/line feeds from any multi-row titles
.					as_title passed by reference, so modifying the string passed in the function call
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
of_Replace(as_Title,'~r~n',' ')
//Remove any double-quotes
of_Replace(as_Title,'"',' ')
as_Title = trim(as_Title) //,TRUE) //TRUE = remove all types of leading/trailing whitespace characters above v9
Return 0
end function

public function integer of_replace (ref string as_string, string as_old, string as_new);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_replace (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref string as_string
.					 string as_old
.					 string as_new
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Long	ll_startpos

ll_startpos = Pos(as_string, as_old )
// Only enter the loop if you find old_str.
DO WHILE ll_startpos > 0
	 as_string = Replace(as_string, ll_startpos, Len(as_old), as_new)	 // Replace old_str with new_str.
	 ll_startpos = Pos(as_string, as_old, ll_startpos+Len(as_new))	 // Find the next occurrence of old_str.
LOOP
RETURN 0
end function

public function string of_createbutton (integer ai_colnum, string as_title, string as_colname);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_createbutton (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 integer ai_colnum
.					 string as_title
.					 string as_colname
.
.Returns:			 string
.
.Description:	Create a button in the datawindow header
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Integer	li_ypos,li_x,li_colwidth,li_width,li_height
Long		ll_xpos
String	ls_modstring,ls_BubbleStyle,ls_Visible

li_height = buttonheight * idec_unitYfactor//default button height in painter
li_ypos = integer(idw_dw.Describe("DataWindow.Header.Height")) - li_height//use header, not each object in header to position vertically
li_x=integer(idw_dw.describe(as_colname+".x"))
li_colwidth=integer(idw_dw.describe(as_colname+".width"))
ls_Visible = idw_dw.Describe(as_colname+".Visible") //1 = Visible, 0 = Not visible, but could have expression 
//IF ls_Visible = '0' THEN RETURN "" //-1 //column not visible, don't create a button
//IF li_colwidth = 0 THEN RETURN "" //-1 //column has width of zero, don't create a button

li_x = li_x + buttonXoffset * idec_unitXfactor
IF li_colwidth >= buttonwidth * idec_unitXfactor THEN
	ll_xpos = li_x +li_colwidth - buttonwidth * idec_unitXfactor
	li_width = buttonwidth * idec_unitXfactor
ELSE
	ll_xpos = li_x
	li_width = li_colwidth
END IF

li_ypos = li_ypos + buttonYoffset * idec_unitYfactor
IF li_ypos <= 0 THEN
	li_ypos = 1
	li_height = integer(idw_dw.Describe("DataWindow.Header.Height"))
END IF

IF BubbleStyle THEN
	ls_BubbleStyle = '1'
ELSE
	ls_BubbleStyle = '0'
END IF

IF mid(ls_visible,1,1) = '"' THEN
	//expression, strip outer quotes
	ls_visible = mid(ls_visible,2,(len(ls_visible)-2))
	of_replace(ls_visible,"'","~~~'")
END IF

ls_modstring = &
"create button(band=Foreground text='' filename='PF_DownArrow_PF.bmp' suppresseventprocessing=yes enabled=yes action='0' border='0' color='33554432' "  +  &
"x='" +string(ll_xpos)+ "' "  +  &
"y='" +string(li_ypos)+ "' "  +  &
"height='" +string(li_height)+ "' width='" +string(li_width)+ "' "  +  &
"vtextalign='0' htextalign='0' "  +  &
"name=" + "b_powerfilter" + string(ai_colnum) +&
" visible='"+ ls_visible + "'"  +&
"font.face='Tahoma' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' "  +  &
"background.mode='2' background.color='67108864' )"

return ls_modstring
end function

public function integer of_getcolumns ();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getcolumns (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
.
.Returns:			 integer
.
.Description:	loop objects to get column names based on header names matching column names with "_t" suffix
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String	ls_objects, ls_object, ls_band, ls_colname, ls_title, ls_coltype
Long		ll_start, ll_end, ll_tab, ll_length
Integer	li_colnum
Integer	li_start_pos


//IF integer(idw_dw.Describe("DataWindow.Header.Height")) = 0 THEN
//	ib_freeform = TRUE
//	of_Getfields( ) //??testing??
//	RETURN 0
//END IF

ls_objects = idw_dw.Describe("DataWindow.Objects")

//parse ls_objects to find header text objects
ll_start = 1
ll_end = len(ls_objects)
DO WHILE ll_start < ll_end
	ll_tab = pos(ls_objects,'~t',ll_start)
	IF ll_tab = 0 THEN
		ll_tab = ll_end + 1
	END IF
	ll_length = ll_tab - ll_start
	ls_object = mid(ls_objects,ll_start,ll_length)
	ls_band = idw_dw.Describe(ls_object + ".Band")
	IF upper(ls_band) = 'HEADER' and UPPER(right(ls_object,2)) = '_T' THEN
		li_ColNum ++
		ls_colname = left(ls_object,len(ls_object)-2) //Get the column name (assumes header name = column name + "_t'
		ls_ColType = lower(left(idw_dw.Describe(ls_colname + ".Coltype"),5)) //use first 5 characters of coltype
		is_colname[li_ColNum] = ls_colname 
		IF NOT ib_customtitles THEN 
			ls_Title = idw_dw.describe(ls_object+".text") //Get the displayed column header text for PowerTip or other user display
			this.of_cleantitle(ls_title)
			is_title[li_ColNum] = ls_title //only set title if user has not called of_SetTitles()
		END IF
		is_ColType[li_ColNum] = ls_ColType
		is_columnfilter[li_ColNum] = '' //make sure each colfilter is defined
	END IF
	ll_start = ll_tab + 1
LOOP
ii_maxcol = li_ColNum //save total number of columns to filter on
Return 0
end function

public function integer of_getdropdownoffset (ref integer ai_xoffset, ref integer ai_yoffset);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getdropdownoffset (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref integer ai_xoffset
.					 ref integer ai_yoffset
.
.Returns:			 integer
.
.Description:	Function to read the horizontal and/or vertical offset position from the default calculated position for the dropdown.
.					Generally, does not need to be used, but if the default placement of the dropdown is not correct or desired location,
.					this function reads the offset instance variables set at design time or via of_SetDropDownOffset. 
.					this function is called from u_powerfilter_dropdown.of_open(), which calculates the position of the dropdown.
.					
.					Default dropdown position is right-aligned with the associated button, and top of dropdown is positioned at bottom of DW header.
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/

ai_Xoffset = this.dropdownxoffset
ai_Yoffset = this.dropdownyoffset 
RETURN 0
end function

public function integer of_getfields ();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getfields (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
.
.Returns:			 integer
.
.Description:	Based on of_GetColumns, but used instead when header height = 0 (implying freeform datawindow, not tabular or grid
.					loop objects to get column names based on column label names matching column names with "_t" suffix
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/

String	ls_objects, ls_object, ls_band, ls_colname, ls_title, ls_coltype
Long		ll_start, ll_end, ll_tab, ll_length
Integer	li_colnum
Integer	li_start_pos

ls_objects = idw_dw.Describe("DataWindow.Objects")

//parse ls_objects to find column label text objects
ll_start = 1
ll_end = len(ls_objects)
DO WHILE ll_start < ll_end
	ll_tab = pos(ls_objects,'~t',ll_start)
	IF ll_tab = 0 THEN
		ll_tab = ll_end + 1
	END IF
	ll_length = ll_tab - ll_start
	ls_object = mid(ls_objects,ll_start,ll_length)
	ls_band = idw_dw.Describe(ls_object + ".Band")
	IF upper(ls_band) = 'DETAIL' and UPPER(right(ls_object,2)) = '_T' THEN
		li_ColNum ++
		ls_colname = left(ls_object,len(ls_object)-2) //Get the column name (assumes header name = column name + "_t'
		ls_ColType = lower(left(idw_dw.Describe(ls_colname + ".Coltype"),5)) //use first 5 characters of coltype
		is_colname[li_ColNum] = ls_colname 
		IF NOT ib_customtitles THEN 
			ls_Title = idw_dw.describe(ls_object+".text") //Get the displayed column header text for PowerTip or other user display
			this.of_cleantitle(ls_title)
			is_title[li_ColNum] = ls_title //only set title if user has not called of_SetTitles()
		END IF
		is_ColType[li_ColNum] = ls_ColType
		is_columnfilter[li_ColNum] = '' //make sure each colfilter is defined
	END IF
	ll_start = ll_tab + 1
LOOP
ii_maxcol = li_ColNum //save total number of columns to filter on
Return 0
end function

public function integer of_getoriginalfilter (ref string as_originalfilter);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getoriginalfilter (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref string as_originalfilter
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
as_OriginalFilter = is_Originalfilter
RETURN 0
end function

public function integer of_getparentwindow (ref window aw_parent);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getparentwindow (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref window aw_parent	The Parent window for this object
.					 If a parent window is not found, aw_parent is NULL
.Returns:			 integer
.					 1 = success
.					-1 = error
.Description:	Calculates the parent window of a window object
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
powerobject	lpo_parent

lpo_parent = idw_dw.GetParent()

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

public function integer of_quickfilter (string as_colname, any aa_item);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_quickfilter (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_colname
.					 any aa_item
.
.Returns:			 integer
.
.Description:	This function can be called to quickly set a filter on a single column to a particular value.  
.					It does not clear other column filters,
					just defines a filter for the particular filter as if the user selected the value from the dropdown.
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String	ls_item
Integer	i
boolean	lb_colfound

ls_item = string(aa_item)

//loop to determine which column was passed in
FOR i = 1 to ii_maxcol
	IF lower(as_colname) = lower(is_colname[i]) THEN 
		lb_colfound=true
		EXIT
	END IF
NEXT
if not lb_colfound then 
	messagebox('Error','Invalid Column Name passed in to QuickFilter')
	return -1 //column name passed in did not match any of the known column names
END IF
//li_colnum,is_colname[li_colnum],is_title[li_colnum],is_coltype[li_colnum],is_columnfilter[li_colnum]
iu_powerfilter_dropdown.ii_colnum = i
iu_powerfilter_predeffilters.ii_colnum = i
iu_powerfilter_monthopts.ii_colnum = i
iu_powerfilter_dropdown.is_colname = as_colname
iu_powerfilter_dropdown.is_title = is_title[i]
iu_powerfilter_dropdown.is_coltype = is_coltype[i]
iu_powerfilter_dropdown.is_columnfilter = is_columnfilter[i] 
iu_powerfilter_dropdown.of_getvalues(as_colname) //gets dropdown list values, as well as restores state and sets button descriptions, etc.

iu_powerfilter_dropdown.of_customfilter( 'equals', ls_item, '', '', 'and' )

iu_powerfilter_predeffilters.of_flagrow(1)
iu_powerfilter_monthopts.of_flagrow(0) //clear any flagged row on monthopts filter list

iu_powerfilter_dropdown.of_close()
iu_powerfilter_dropdown.of_savestate()	
return 0
end function

public function integer of_setcolumns (string as_columns[]);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setcolumns (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_columns[]
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Long		ll_max,ll_colnum
String	ls_object, ls_title

ll_max = upperbound(as_columns)

FOR ll_colnum = 1 to ll_max
	is_colname[ll_colnum] = as_columns[ll_colnum]
	is_ColType[ll_colnum] = lower(left(idw_dw.Describe(is_colname[ll_colnum] + ".Coltype"),5)) //use first 5 characters of coltype
	is_columnfilter[ll_colnum] = '' //make sure each colfilter is defined
	//Try to get column titles in case user doesn't call of_SetTitles
	IF NOT ib_customtitles THEN
		ls_object = is_colname[ll_colnum] + '_t'
		ls_Title = idw_dw.describe(ls_object+".text") //Get the displayed column header text for PowerTip or other user display
		this.of_cleantitle(ls_title)
		is_title[ll_colnum] = ls_title
	END IF
NEXT
ib_CustomColumns = TRUE //developer defined columns, don't run of_getcolumns() to identify all the columns.
ii_maxcol = ll_max
Return 0
end function

public function integer of_setdropdownoffset (integer ai_xoffset, integer ai_yoffset);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setdropdownoffset (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 integer ai_xoffset
.					 integer ai_yoffset
.
.Returns:			 integer
.
.Description:	Function to change the horizontal and/or vertical offset position from the default calculated position
.					Generally, does not need to be used, but if the default placement of the dropdown is not correct or desired location,
.					this function changes the offset instance variables from 0 to new values, which are used in the calculation to position 
.					the dropdown.  Default dropdown position is right-aligned with 
.					the associated button, and top of dropdown is positioned at bottom of DW header.
.
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
this.dropdownxoffset = ai_Xoffset
this.dropdownyoffset = ai_Yoffset
RETURN 0
end function

public function integer of_setdw (datawindow a_dw);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setdw (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 datawindow a_dw
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
if not isvalid(a_dw) then return -1

idw_dw = a_dw //save pointer to datawindow control to be powerfiltered

//following 2 functions can be called later by developer if dataobject not yet established, or sort/filter changes after
//this function is called.

this.of_setoriginalfilter( ) //saves current dw sort to instance variable
this.of_setoriginalsort( ) //saves current dw filter to instance variable

is_dwunits = idw_dw.describe("DataWindow.Units")
/*
0 - PowerBuilder units
1 - Display pixels
2 - 1/1000 of a logical inch
3 - 1/1000 of a logical centimeter
*/
CHOOSE CASE is_dwunits
	CASE '0'
		idec_unitxfactor = 1
		idec_unityfactor = 1
	CASE '1'
		idec_unitxfactor = (UnitsToPixels(1000,XUnitsToPixels!) / 1000.00)
		idec_unityfactor = (UnitsToPixels(1000,YUnitsToPixels!) / 1000.00)
	CASE '2'
		idec_unitxfactor = 2.264368
		idec_unityfactor = 2.592105
	CASE '3'
		idec_unitxfactor = 5.770115
		idec_unityfactor = 6.605263
END CHOOSE
//messagebox('test '+is_dwunits,string(idec_unitxfactor))
RETURN 0

end function

public function integer of_setoriginalfilter ();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setoriginalfilter (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
if not isvalid(idw_dw) then return -1

//Save original filter and sort if any
is_OriginalFilter=idw_dw.Describe("DataWindow.Table.Filter")

IF is_OriginalFilter = "?" THEN 
	is_OriginalFilter = "" 
ELSE
	//strip any ~ from original filter
	of_Replace(is_Originalfilter,'~~','')
END IF
RETURN 0

end function

public function integer of_setoriginalsort ();/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setoriginalsort (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 none
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
if not isvalid(idw_dw) then return -1

is_OriginalSort=idw_dw.Describe("DataWindow.Table.Sort")

IF is_OriginalSort = "?" THEN 
	is_OriginalSort = "" 
END IF

RETURN 0

end function

public function integer of_setlanguage (integer ai_languagenumber);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_setlanguage (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 integer ai_languagenumber
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
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

ii_language = ai_languagenumber + 2 //offset 2 columns from passed parameter, English passed parm = 0, is in column 2

//this.text = lds_lang.GetItemString(76,ii_language) //set 'Filter' on object
this.defaulttiptext = lds_lang.GetItemString(66,ii_language)
DESTROY lds_lang
RETURN 0
end function

public function integer of_settitles (string as_titles[]);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_settitles (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_titles[]
.
.Returns:			 integer
.
.Description:	Optional function coded by developer, passes in developer-defined column Titles 
.					rather than determining header names via colname_t
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
Long ll_max,ll_colnum

ll_max = upperbound(as_titles)

FOR ll_colnum = 1 to ll_max
	is_title[ll_colnum] = as_titles[ll_colnum]
NEXT
ib_customtitles=TRUE
Return 0
end function

protected function boolean of_usedisplayvalue (string as_colname);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_UseDisplayValue (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_colname	columnname/computename to determine if it has a display value
.
.Returns:			 boolean
.   					TRUE:  The column has a display value
.  					FALSE: The column does not have a display value or does not exist
.Description:	Determine if a datawindow column has a display value.  
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String	ls_EditStyle, ls_CodeTable, columnType

ls_EditStyle = UPPER(idw_dw.Describe(as_ColName + ".Edit.Style"))
columnType = UPPER(idw_dw.Describe(as_ColName + ".ColType"))
IF ls_EditStyle = 'DDDW' or (ls_EditStyle = 'DDLB' and columnType <> "DATETIME") THEN RETURN TRUE

ls_CodeTable = UPPER(idw_dw.Describe(as_ColName + "." + ls_editstyle + ".CodeTable"))
IF ls_codetable = 'YES' THEN RETURN TRUE

RETURN FALSE

end function

public function string of_createcomputedfield (string as_colname, integer ai_colnum);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_createcomputedfield (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 string as_colname
.					 integer ai_colnum
.
.Returns:			 string
.
.Description:	Creates an invisible computedfield equal to the lookupdisplay of the column passed in, 
.					which has an edit style of dddw, ddlb, or edit with a code table.
.					The invisible field is substituted for the original column to filter on.
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String ls_newcolumn, ls_color, ls_x, ls_y, ls_height, ls_width, ls_fontface, ls_fontheight, ls_fontweight
String ls_fontfamily, ls_fontpitch, ls_fontcharset, ls_fontitalic, ls_fontstrikethrough, ls_fontunderline, ls_backgroundcolor
String ls_format, ls_return, ls_mod

ls_newcolumn 			= 'pfjrrcmp_' + string(ai_colnum)
ls_color					=idw_dw.Describe(as_colname+".Color")
ls_x						=string(integer(idw_dw.Describe(as_colname+".x")))
ls_y						=idw_dw.Describe(as_colname+".y")
ls_height				=idw_dw.Describe(as_colname+".height")
ls_width					=idw_dw.Describe(as_colname+".width")
ls_format				=idw_dw.Describe(as_colname+".format")
ls_fontface				=idw_dw.Describe(as_colname+".font.face")
ls_fontheight			=idw_dw.Describe(as_colname+".font.height")
ls_fontweight			=idw_dw.Describe(as_colname+".font.weight")
ls_fontfamily			=idw_dw.Describe(as_colname+".font.family")
ls_fontpitch			=idw_dw.Describe(as_colname+".font.pitch")
ls_fontcharset			=idw_dw.Describe(as_colname+".font.charset")
ls_backgroundcolor	=idw_dw.Describe(as_colname+".background.color")

of_replace(ls_color,"'","~~~'")
of_replace(ls_x,"'","~~~'")
of_replace(ls_y,"'","~~~'")
of_replace(ls_height,"'","~~~'")
of_replace(ls_width,"'","~~~'")
of_replace(ls_format,"'","~~~'")
of_replace(ls_fontface,"'","~~~'")
of_replace(ls_fontheight,"'","~~~'")
of_replace(ls_fontweight,"'","~~~'")
of_replace(ls_fontfamily,"'","~~~'")
of_replace(ls_fontpitch,"'","~~~'")
of_replace(ls_fontcharset,"'","~~~'")
of_replace(ls_backgroundcolor,"'","~~~'")

ls_mod = "create compute(band=Detail"  +  &
" color='"+ls_color+"' " +  &
" alignment='0'  " +  &
" border='0'" + &
" height.autosize=No  " +  &
" pointer='Arrow!'" + &
" moveable=0  " +  &
" resizeable=0  " +  &
" x='"+ls_x+"'  " +  &
" y='"+ls_y+"'  " +  &
" height='0'" +  &
" width='0'" + &   
" format='"+ls_format+"'" + &
" name="+ls_newcolumn+ &
" tag=''  " +  &
" visible='0'  " +  &
" expression='lookupdisplay("+as_colname+")'  " +  &
" font.face='"+ls_fontface+"'  " +  &
" font.height='"+ls_fontheight+"' " +  &
" font.weight='"+ls_fontweight+"'" + &
" font.family='"+ls_fontfamily+"'  " +  &
" font.pitch='"+ls_fontpitch+"'  " +  &
" font.charset='"+ls_fontcharset+"'  " +  & 
" background.mode='0' " +  & 
" background.color='"+ls_backgroundcolor+"')"

ls_return = idw_dw.Modify( ls_mod)

return ls_newcolumn 
end function

public function integer of_getframe (ref window aw_parent);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_getframe (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 ref window aw_parent	The Parent window for this object
. 					 If a parent window is not found, aw_parent is NULL
.Returns:			 integer
.					 1 = success
.					-1 = error
.
.Description:	Calculates the parent MDI frame of a window 
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/

powerobject	lpo_parent
window lw_window,lw_topwindow

lpo_parent = idw_dw.GetParent()

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

//Now that I'm at a window, loop until I'm at the top window (frame)
lw_window = lpo_parent //set child = current window found above

do while IsValid (lw_window) 
	if lw_window.TypeOf() = window! then
		lw_topwindow = lw_window //save current valid window in lw_topwindow
		lw_window = lw_window.ParentWindow()
	else
		exit
	end if
loop

aw_parent = lw_topwindow
return 1

end function

public function integer of_filter (string as_filter);/*===========================================================
.Object:			n_cst_powerfilter
.Method:			of_filter (Function)
.Author:			Reesejr
.Date:				08/03/2010
.
.Argument(s):	 val string as_filter
.
.Returns:			 integer
.
.Description:	Sets Filterstring and applies Filter to datawindow.
.					Checks for valid sort definition, and only sorts if sort definition exists
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
String	ls_CurrentSort

idw_dw.setfilter( as_filter)
idw_dw.filter()
ls_CurrentSort = idw_dw.describe("DataWindow.Table.Sort")
IF ls_CurrentSort <> '?' THEN
	idw_dw.sort()
END IF

RETURN 1
end function

public function integer of_setparentwindow (window aw_parent);if isvalid(aw_parent) then
	iw_parent = aw_parent
	return 1
else
	return -1
end if
end function

on n_cst_powerfilter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_powerfilter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

