$PBExportHeader$w_powerfilter_prompt_to_restore.srw
forward
global type w_powerfilter_prompt_to_restore from window
end type
type st_2 from statictext within w_powerfilter_prompt_to_restore
end type
type st_1 from statictext within w_powerfilter_prompt_to_restore
end type
type cbx_filter from checkbox within w_powerfilter_prompt_to_restore
end type
type cbx_sort from checkbox within w_powerfilter_prompt_to_restore
end type
type cb_cancel from commandbutton within w_powerfilter_prompt_to_restore
end type
type cb_ok from commandbutton within w_powerfilter_prompt_to_restore
end type
end forward

global type w_powerfilter_prompt_to_restore from window
string tag = "//MULTILANG  Restore Original?"
integer width = 2171
integer height = 712
boolean titlebar = true
string title = "Restore Original?"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
cbx_filter cbx_filter
cbx_sort cbx_sort
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_powerfilter_prompt_to_restore w_powerfilter_prompt_to_restore

type variables
Boolean ib_buttonpressed
//MultLang Support
String is_Cancel
String is_OK
String is_RestoreOriginalFilterDefinition
String is_RestoreOriginalSortOrder
String is_RestoreOriginal
String is_RestoreOriginalDefinitions
String is_YouHaveMadeChanges

end variables

forward prototypes
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_setcolor (long al_backcolor)
public function integer of_setfont (string as_fontname, string as_fontcolor)
end prototypes

public function integer of_setlanguage (integer ai_languagenumber);/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_lang
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

li_lang = ai_languagenumber //offset already done in checkbox, English = 0, is in column 2

is_Cancel = lds_lang.GetItemString(69,li_lang)
is_OK = lds_lang.GetItemString(79,li_lang)
is_RestoreOriginalFilterDefinition = lds_lang.GetItemString(81,li_lang)
is_RestoreOriginalSortOrder = lds_lang.GetItemString(82,li_lang)
is_RestoreOriginal = lds_lang.GetItemString(83,li_lang)
is_RestoreOriginalDefinitions = lds_lang.GetItemString(97,li_lang)
is_YouHaveMadeChanges = lds_lang.GetItemString(98,li_lang)
DESTROY lds_lang

this.title = is_RestoreOriginal
st_2.text = is_restoreoriginaldefinitions
st_1.text = is_Youhavemadechanges
cbx_filter.text = is_restoreoriginalfilterdefinition
cbx_sort.text = is_restoreoriginalsortorder
CB_ok.Text = is_OK
CB_Cancel.Text = is_Cancel 

RETURN 0
end function

public function integer of_setcolor (long al_backcolor);/*===========================================================
.Object:			w_powerfilter_promt_to_restore
.Method:			of_setcolor (Function)
.Author:			Reesejr
.Date:				03/13/2012
.
.Argument(s):	 long al_backcolor
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
.	03/13/2012	2.0		Reesejr	Initial Version
.============================================================*/
this.backcolor = al_backcolor
cbx_filter.backcolor = al_backcolor
cbx_sort.backcolor = al_backcolor
st_1.backcolor = al_backcolor
st_2.backcolor = al_backcolor
RETURN 0
end function

public function integer of_setfont (string as_fontname, string as_fontcolor);/*===========================================================
.Object:			w_powerfilter_prompt_to_restore
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

cbx_filter.textcolor=long(as_FontColor)
cbx_filter.facename=as_FontName

cbx_sort.textcolor=long(as_FontColor)
cbx_sort.facename=as_FontName

st_1.textcolor=long(as_FontColor)
st_1.facename=as_FontName

st_2.textcolor=long(as_FontColor)
st_2.facename=as_FontName

cb_ok.facename=as_FontName
cb_cancel.facename=as_FontName

return 0
end function

on w_powerfilter_prompt_to_restore.create
this.st_2=create st_2
this.st_1=create st_1
this.cbx_filter=create cbx_filter
this.cbx_sort=create cbx_sort
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.st_2,&
this.st_1,&
this.cbx_filter,&
this.cbx_sort,&
this.cb_cancel,&
this.cb_ok}
end on

on w_powerfilter_prompt_to_restore.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_filter)
destroy(this.cbx_sort)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;Integer li_width,li_diff

s_powerfilter_parms ls_openparms

ls_openparms = message.powerobjectparm
this.of_setlanguage( ls_openparms.parm14 )
this.of_setcolor( ls_openparms.parm15 )
this.of_setfont( ls_openparms.parm16,  ls_openparms.parm17)


//get length in characters of bigger text string
li_width = len(st_1.text)
if len(st_2.text) > li_width THEN li_width = len(st_2.text)

li_width = li_width * 27 //approximate PBU's per letter (27 for Russian)

//Adjust window width and object location due to different length translations
IF li_width > this.width THEN 
	li_diff = li_width - this.width
	this.width = li_width
	st_1.width = li_width
	st_2.width = li_width
	cbx_filter.x = cbx_filter.x + (li_diff / 2)
	cbx_sort.x = cbx_sort.x + (li_diff / 2)
	cb_cancel.x = cb_cancel.x + li_diff
	cb_ok.x = cb_ok.x + li_diff
END IF
end event

event closequery;if not ib_buttonpressed THEN
	cb_cancel.postevent(clicked!) //alt-F4 got us here, cancel appropriately via cb_cancel
	return 1  //neither button was pressed, don't allow close
else
	return 0
end if
end event

type st_2 from statictext within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG Would you like to restore the original definitions, or keep the current Sort and Filter definitions?"
integer y = 124
integer width = 2199
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Would you like to restore the original definitions, or keep the current Sort and Filter definitions?"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG You have made changes to the original Sort Order and/or Filtered Rows on Display."
integer y = 52
integer width = 2199
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "You have made changes to the original Sort Order and/or Filtered Rows on Display."
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_filter from checkbox within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG Restore Original Filter Definition"
integer x = 713
integer y = 356
integer width = 1458
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Restore Original Filter Definition"
boolean checked = true
end type

type cbx_sort from checkbox within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG Restore Original Sort Order"
integer x = 713
integer y = 276
integer width = 1454
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Restore Original Sort Order"
boolean checked = true
end type

type cb_cancel from commandbutton within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG Cancel"
integer x = 1737
integer y = 476
integer width = 347
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
s_powerfilter_restore_parms ls_response

ls_response.buttonpressed = FALSE //Cancel pressed
ls_response.restoresort = cbx_Sort.checked
ls_response.restorefilter = cbx_Filter.checked
ib_buttonpressed = TRUE
ClosewithReturn(parent,ls_response)

end event

type cb_ok from commandbutton within w_powerfilter_prompt_to_restore
string tag = "//MULTILANG OK"
integer x = 1358
integer y = 476
integer width = 347
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright © 2010 James R. Reese.  All Rights Reserved.
*/
s_powerfilter_restore_parms ls_response

ls_response.buttonpressed = TRUE //OK pressed
ls_response.restoresort = cbx_Sort.checked
ls_response.restorefilter = cbx_Filter.checked
ib_buttonpressed = TRUE
ClosewithReturn(parent,ls_response)

end event

