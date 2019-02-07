$PBExportHeader$u_powerfilter_checkbox.sru
$PBExportComments$stub object to replace original checkbox with NVO calls
forward
global type u_powerfilter_checkbox from checkbox
end type
end forward

global type u_powerfilter_checkbox from checkbox
string tag = "//MULTILANG Filter"
integer width = 201
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Filter"
event type integer ue_positionbuttons ( )
event ue_buttonclicked ( string dwotype,  string dwoname )
event type integer ue_postfilter ( )
end type
global u_powerfilter_checkbox u_powerfilter_checkbox

type variables
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//Design-time options
PUBLIC:
Integer	MaxItems = 10000 //default number of Items to allow in the dropdown
Integer	ButtonHeight = 76 //default button height
Integer	ButtonWidth = 87 //default button width
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

n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer of_buildfilter (string as_columnfilter, integer ai_columnnumber)
public function integer of_setdw (datawindow a_dw)
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_setbuttonpics ()
public function string of_createbutton (integer ai_colnum, string as_title, string as_colname)
public function integer of_settitles (string as_titles[])
public function integer of_setcolumns (string as_columns[])
public function integer of_getcolumns ()
public function integer of_cleantitle (ref string as_title)
public function integer of_replace (ref string as_string, string as_old, string as_new)
public function integer of_getoriginalfilter (ref string as_originalfilter)
public function integer of_setdropdownoffset (integer ai_xoffset, integer ai_yoffset)
public function integer of_getdropdownoffset (ref integer ai_xoffset, ref integer ai_yoffset)
public function integer of_setoriginalsort ()
public function integer of_setoriginalfilter ()
public function integer of_getfields ()
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_quickfilter (string as_colname, any aa_item)
public function integer of_setparentwindow (window aw_parent)
end prototypes

event type integer ue_positionbuttons();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.

This event is called whenever the position of the buttons might need to change, 
such as the user resizes a column (in a grid).  It is also called 
when the buttons are first created.
It is actually called from the datawindow left button up event, and may not actually need to move anything, 
since there is no column resize event that I can determine.

If powerfilter is not active (checked), then just return

This is an event rather than a function because when calling from the datawindow leftbuttonup event, a function did not position the
objects correctly at their new locations.  by Posting to this event, the new column locations have been set correctly before this event executes.

*/
RETURN iu_powerfilter.event ue_positionbuttons()
end event

event ue_buttonclicked(string dwotype, string dwoname);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter.event ue_buttonclicked(dwotype,dwoname)
end event

event type integer ue_postfilter();/*===========================================================
.Object:			u_powerfilter_checkbox
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
RETURN iu_powerfilter.event ue_postfilter()
end event

public function integer of_buildfilter (string as_columnfilter, integer ai_columnnumber);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.

This function is called from the dropdown user object when a new filter is applied.
It receives the new filter string for that column, and the column reference number.

It then updates the appropriate column filter instance in this object, and rebuilds the entire datawindow filter
based on all of the column filters that have been defined and passed back to this function
*/
Return iu_powerfilter.of_buildfilter( as_columnfilter, ai_columnnumber)
end function

public function integer of_setdw (datawindow a_dw);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_setdw( a_dw)

end function

public function integer of_getparentwindow (ref window aw_parent);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
return iu_powerfilter.of_getparentwindow( aw_parent )

end function

public function integer of_setbuttonpics ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Return iu_powerfilter.of_setbuttonpics( )

end function

public function string of_createbutton (integer ai_colnum, string as_title, string as_colname);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//create a button in the datawindow header
return iu_powerfilter.of_createbutton( ai_colnum, as_title, as_colname )
end function

public function integer of_settitles (string as_titles[]);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Return iu_powerfilter.of_settitles( as_titles[] )

end function

public function integer of_setcolumns (string as_columns[]);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Return iu_powerfilter.of_setcolumns( as_columns[] )
end function

public function integer of_getcolumns ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Return iu_powerfilter.of_getcolumns( )
end function

public function integer of_cleantitle (ref string as_title);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Return iu_powerfilter.of_cleantitle( as_title )
end function

public function integer of_replace (ref string as_string, string as_old, string as_new);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_replace( as_string, as_old, as_new )
end function

public function integer of_getoriginalfilter (ref string as_originalfilter);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_getoriginalfilter( as_originalfilter )
end function

public function integer of_setdropdownoffset (integer ai_xoffset, integer ai_yoffset);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_setdropdownoffset( ai_xoffset, ai_yoffset )
end function

public function integer of_getdropdownoffset (ref integer ai_xoffset, ref integer ai_yoffset);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//function to read the horizontal and/or vertical offset position from the default calculated position for the dropdown.
//Generally, does not need to be used, but if the default placement of the dropdown is not correct or desired location,
//this function reads the offset instance variables set at design time or via of_SetDropDownOffset. 
//this function is called from u_powerfilter_dropdown.of_open(), which calculates the position of the dropdown.
//
//Default dropdown position is right-aligned with the associated button, and top of dropdown is positioned at bottom of DW header.
RETURN iu_powerfilter.of_getdropdownoffset( ai_xoffset, ai_yoffset )
end function

public function integer of_setoriginalsort ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_setoriginalsort( )

end function

public function integer of_setoriginalfilter ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
RETURN iu_powerfilter.of_setoriginalfilter( )

end function

public function integer of_getfields ();/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//Based on of_GetColumns, but used instead when header height = 0 (implying freeform datawindow, not tabular or grid
//loop objects to get column names based on column label names matching column names with "_t" suffix
Return iu_powerfilter.of_getfields( )
end function

public function integer of_setlanguage (integer ai_languagenumber);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

this.text = lds_lang.GetItemString(76,ai_languagenumber + 2) //set 'Filter' on object
DESTROY lds_lang

RETURN iu_powerfilter.of_setlanguage( ai_languagenumber )
end function

public function integer of_quickfilter (string as_colname, any aa_item);return iu_powerfilter.of_quickfilter( as_colname, aa_item )
end function

public function integer of_setparentwindow (window aw_parent);/*===========================================================
.Object:			u_powerfilter_checkbox
.Method:			of_setparentwindow (Function)
.Author:			Reesejr
.Date:				12/21/2010
.
.Argument(s):	 window aw_parent
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
return iu_powerfilter.of_setparentwindow( aw_parent )

end function

on u_powerfilter_checkbox.create
end on

on u_powerfilter_checkbox.destroy
end on

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter.checked = this.checked
Return iu_powerfilter.event ue_clicked()

end event

event constructor;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
iu_powerfilter = create n_cst_powerfilter

iu_powerfilter.MaxItems						 =	MaxItems //= 10000 //default number of Items to allow in the dropdown
iu_powerfilter.ButtonHeight				 =	ButtonHeight //= 76 //default button height
iu_powerfilter.ButtonWidth 				 =	ButtonWidth //= 87 //default button width
iu_powerfilter.ButtonXOffset				 =	ButtonXOffset //= 0 //pixels to shift horizontally from default position +/-
iu_powerfilter.ButtonYOffset				 =	ButtonYOffset //= 0 //pixels to shift vertically from default position +/-
iu_powerfilter.DropdownXOffset			 =	DropdownXOffset //= 0 //pixels to shift horizontally from default position +/-
iu_powerfilter.DropdownYOffset			 =	DropdownYOffset //= 0 //pixels to shift vertically from default position +/-
iu_powerfilter.MaintainOriginalFilter	 =	MaintainOriginalFilter //= TRUE//if true, any pre-existing filter is combined with user-defined filters
iu_powerfilter.PromptUserToRestore		 =	PromptUserToRestore //= FALSE //if true, turning off powerfilter will prompt user to decide whether to restore sort/filter
iu_powerfilter.RestoreOriginalSort		 =	RestoreOriginalSort //= TRUE //if true, turning off powerfilter will restore original sort, unless user is prompted and says no
iu_powerfilter.RestoreOriginalFilter	 =	RestoreOriginalFilter //= TRUE //if true, turning off powerfilter will restore original filter, unless user is prompted and says no
iu_powerfilter.AllowQuickSort				 =	AllowQuickSort //= TRUE //if false, sort ascending and descending are disabled or removed from dropdown
iu_powerfilter.DefaultTipText				 =	DefaultTipText //= '(Showing All)' //default text when no filter applied //MULTILANG (Showing All)
iu_powerfilter.BubbleStyle					 =	BubbleStyle //= FALSE //TipText Style FalSE/0 = standard, True/1 = BubbleStyle
iu_powerfilter.KeepNewRows					 = KeepNewRows //= FALSE //if true, Newly added rows will not be filtered.

end event

