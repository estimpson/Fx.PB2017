$PBExportHeader$u_powerfilter_monthopts.sru
forward
global type u_powerfilter_monthopts from userobject
end type
type dw_1 from datawindow within u_powerfilter_monthopts
end type
end forward

global type u_powerfilter_monthopts from userobject
integer width = 535
integer height = 1420
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global u_powerfilter_monthopts u_powerfilter_monthopts

type variables
/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
String is_ColType,is_Title,is_ColName,is_ColumnFilter,is_ddFilter
Integer ii_ColNum,ii_prevrow,ii_selectedrow[]

u_powerfilter_dropdown iu_powerfilter_dropdown
n_cst_powerfilter iu_powerfilter_checkbox
u_powerfilter_predeffilters iu_powerfilter_predeffilters
datawindow	idw_dw

//MultLang Support
String is_Quarter1
String is_Quarter2
String is_Quarter3
String is_Quarter4
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

String is_Equals_Cap

end variables

forward prototypes
public function integer of_setdropdown (ref userobject a_powerfilter_dropdown)
public function integer of_flagrow (integer ai_row)
public function integer of_setlist (string as_coltype, string as_colname, string as_title, integer ai_colnum)
public function integer of_restorestate ()
public function integer of_position ()
public function integer of_setpredef (ref userobject a_powerfilter_predeffilters)
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_initialize (datawindow a_dw, ref nonvisualobject a_powerfilter_checkbox, integer ai_maxcol)
public function integer of_setcolor (string as_background_color)
public function integer of_adjustsize ()
public function integer of_setfont (string as_fontname, string as_fontcolor)
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
integer li_return
IF ii_prevrow > 0 THEN
	dw_1.SetItem(ii_prevrow,'Selected',0) //unselect previous row, if any
END IF
IF ai_row > 0 THEN
	dw_1.SetItem(ai_row,'Selected',1)
	li_return = iu_powerfilter_predeffilters.dw_1.SetItem( (iu_powerfilter_predeffilters.dw_1.rowcount()-1),'Selected',1)
	iu_powerfilter_predeffilters.ii_selectedrow[ii_colnum]=(iu_powerfilter_predeffilters.dw_1.rowcount()-1)
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

dw_1.height = dw_1.rowcount() * 80 + 44
this.height = dw_1.height + 12
of_restorestate() //restore any row that may have been selected
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

this.x = iu_powerfilter_predeffilters.x + iu_powerfilter_predeffilters.width
//test to see if list goes off right side of window.  If so, move to other side of dropdown
IF this.x + this.width > parent.dynamic workspacewidth( ) THEN//idw_dw.width THEN 
	IF iu_powerfilter_predeffilters.x - this.width > 0 THEN //JRR 79770 - don't assume there is room to the left, test to see 
		this.x = iu_powerfilter_predeffilters.x - this.width
	ELSE //JRR 79770 - don't assume there is room to the left, test to see 
		this.x = parent.dynamic workspacewidth() - this.width //JRR 79770 - if not enough room on left, have this overlap dropdown on the right 
	END IF //JRR 79770 
END IF
this.y = iu_powerfilter_predeffilters.y + (80 * (iu_powerfilter_predeffilters.dw_1.rowcount() - 2)) + 4
//test to see if list drops too low.  If so, position higher.
IF this.y + this.height > parent.dynamic workspaceheight( ) &
	AND parent.dynamic workspaceheight( ) - this.height > 0 THEN
	this.y = (parent.dynamic workspaceheight( ) - this.height)
END IF
of_adjustsize( )
Return 0
end function

public function integer of_setpredef (ref userobject a_powerfilter_predeffilters);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
//This function is called from the powerfilter checkbox user object to 
//link the dropdown with the predefined filter list
iu_powerfilter_predeffilters = a_powerfilter_predeffilters
return 0
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

is_Quarter1 	= lds_lang.GetItemString(47,li_lang)
is_Quarter2 	= lds_lang.GetItemString(48,li_lang)
is_Quarter3 	= lds_lang.GetItemString(49,li_lang)
is_Quarter4 	= lds_lang.GetItemString(50,li_lang)
is_January 		= lds_lang.GetItemString(51,li_lang)
is_February 	= lds_lang.GetItemString(52,li_lang)
is_March 		= lds_lang.GetItemString(53,li_lang)
is_April 		= lds_lang.GetItemString(54,li_lang)
is_May 			= lds_lang.GetItemString(55,li_lang)
is_June 			= lds_lang.GetItemString(56,li_lang)
is_July 			= lds_lang.GetItemString(57,li_lang)
is_August 		= lds_lang.GetItemString(58,li_lang)
is_September	= lds_lang.GetItemString(59,li_lang)
is_October 		= lds_lang.GetItemString(60,li_lang)
is_November 	= lds_lang.GetItemString(61,li_lang)
is_December 	= lds_lang.GetItemString(62,li_lang)

is_Equals_Cap 	= lds_lang.GetItemString(75,li_lang)
DESTROY lds_lang

Integer li_row,li_rows
li_rows = dw_1.rowcount()
li_row = dw_1.Find("filtertype = 'Quarter 1'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_quarter1 )
li_row = dw_1.Find("filtertype = 'Quarter 2'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_quarter2 )
li_row = dw_1.Find("filtertype = 'Quarter 3'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_quarter3 )
li_row = dw_1.Find("filtertype = 'Quarter 4'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_quarter4 )
li_row = dw_1.Find("filtertype = 'January'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_january )
li_row = dw_1.Find("filtertype = 'February'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_february )
li_row = dw_1.Find("filtertype = 'March'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_march )
li_row = dw_1.Find("filtertype = 'April'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_april )
li_row = dw_1.Find("filtertype = 'May'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_may )
li_row = dw_1.Find("filtertype = 'June'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_june )
li_row = dw_1.Find("filtertype = 'July'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_july )
li_row = dw_1.Find("filtertype = 'August'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_august )
li_row = dw_1.Find("filtertype = 'September'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_september )
li_row = dw_1.Find("filtertype = 'October'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_october )
li_row = dw_1.Find("filtertype = 'November'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_november )
li_row = dw_1.Find("filtertype = 'December'" , 1, li_rows)
IF li_row > 0 then dw_1.Setitem( li_row,'displaytext',is_december )

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

public function integer of_setcolor (string as_background_color);/*===========================================================
.Object:			u_powerfilter_monthopts
.Method:			of_setcolor (Function)
.Author:			Reesejr
.Date:				01/31/2011
.
.Argument(s):	 string as_background_color
.
.Returns:			 integer
.
.Description:	
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2011 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	08/03/2010	1.00		Reesejr	Initial Version
.============================================================*/
dw_1.Object.DataWindow.Color = long(as_background_color)
dw_1.Object.l_1.Background.Color =  long(as_background_color)
RETURN 0
end function

public function integer of_adjustsize ();/*
of_adjustsize()

shrink height, widen and add scroll bar so it will fit into a smaller window
*/
//return 0
IF this.height >= parent.dynamic workspaceheight( ) THEN
                this.height = parent.dynamic workspaceheight( ) // shrink to fit
                dw_1.height = this.height - dw_1.y - 8
	this.width = 535 + 60
	dw_1.width = 521 + 60
	dw_1.vscrollbar=true
	this.y = 0
END IF

return 0
end function

public function integer of_setfont (string as_fontname, string as_fontcolor);/*===========================================================
.Object:			u_powerfilter_dropdown
.Method:			of_setfont (Function)
.Author:			Reesejr
.Date:				7/7/2013
.
.Argument(s):	 string	as_FontName
.					 string	as_FontColor
.
.Returns:			 integer
.
.Description:	sets font type and foreground (text) color for all objects on this objecttype
.					
.PowerFilter Datawindow Filter Service
.Copyright © 2010 James R. Reese.  All Rights Reserved.
.============================================================
.	History
.	Date			Version	Author	Comment
.============================================================
.	07/07/2013	2.00		Reesejr	Initial Version of this function
.============================================================*/
IF as_FontName = '' then as_FontName = 'Tahoma'
IF as_FontColor = '' then as_FontColor = '0'

dw_1.Object.displaytext.Color=as_FontColor
dw_1.Object.displaytext.Font.Face=as_FontName

return 0
end function

on u_powerfilter_monthopts.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_powerfilter_monthopts.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_powerfilter_monthopts
event ue_mousemove pbm_dwnmousemove
event ue_dwnkey pbm_dwnkey
event ue_setrow ( integer row )
string tag = "//MULTILANG in the shared data in the dataobject"
integer x = 5
integer y = 4
integer width = 521
integer height = 1416
integer taborder = 10
string title = "none"
string dataobject = "d_powerfilter_monthopts"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
this.setrow(row)
end event

event ue_dwnkey;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
IF key = KeyLeftArrow! THEN
	//go back to dropdown, close this list
	iu_powerfilter_predeffilters.dw_1.setfocus()
	iu_powerfilter_predeffilters.dw_1.setrow(iu_powerfilter_predeffilters.dw_1.rowcount()-1)
	parent.visible = FALSE
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
String ls_FilterType,ls_displaytext
String ls_parm1,ls_Filter1
String ls_PowerTip
Integer li_Return,li_row

li_row = row
IF li_row = 0 THEN li_row = this.rowcount() //clicked in fudge factor space below last row, assume they meant last row

ls_FilterType = This.GetItemString(li_row,'filtertype')

CHOOSE CASE Lower(ls_FilterType)
	CASE 'quarter 1'
		ls_Filter1 = 'In'
		ls_Parm1 = '(01,02,03)'
	CASE 'quarter 2'
		ls_Filter1 = 'In'
		ls_Parm1 = '(04,05,06)'
	CASE 'quarter 3'
		ls_Filter1 = 'In'
		ls_Parm1 = '(07,08,09)'
	CASE 'quarter 4'
		ls_Filter1 = 'In'
		ls_Parm1 = '(10,11,12)'
	CASE 'january'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '01'
	CASE 'february'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '02'
	CASE 'march'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '03'
	CASE 'april'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '04'
	CASE 'may'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '05'
	CASE 'june'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '06'
	CASE 'july'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '07'
	CASE 'august'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '08'
	CASE 'september'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '09'
	CASE 'october'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '10'
	CASE 'november'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '11'
	CASE 'december'
		ls_Filter1 = 'Equals'
		ls_Parm1 = '12'
END CHOOSE		
li_return = iu_powerfilter_dropdown.of_monthfilter( ls_Filter1,ls_parm1)
IF li_return = 0 THEN
	//customfilter returned successfully, flag which option was used
	IF ls_PowerTip <> '' THEN 
		idw_dw.Modify("b_powerfilter"+string(ii_ColNum)+".tooltip.tip='"+ is_equals_cap +" "+ls_PowerTip+"'") //MULTILANG Equals
	END IF
	parent.of_flagrow(li_row)
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

