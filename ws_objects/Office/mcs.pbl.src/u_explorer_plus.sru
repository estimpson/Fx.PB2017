$PBExportHeader$u_explorer_plus.sru
forward
global type u_explorer_plus from userobject
end type
type st_1 from statictext within u_explorer_plus
end type
type tv_1 from u_treeview_ancestor within u_explorer_plus
end type
type dw_1 from u_datawindow_ancestor within u_explorer_plus
end type
type lv_1 from u_listview_ancestor within u_explorer_plus
end type
end forward

global type u_explorer_plus from userobject
integer width = 1989
integer height = 1136
long backcolor = 78682240
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event resize pbm_size
event type long tv_selectionchanged ( long oldhandle,  long newhandle )
event type long tv_begindrag ( long handle )
event type long tv_clicked ( long handle )
event type long tv_constructor ( )
event type long tv_doubleclicked ( long handle )
event type long tv_beginlabeledit ( long handle )
event type long tv_beginrightdrag ( long handle )
event type long tv_deleteitem ( long handle )
event type long tv_destructor ( )
event type long tv_dragdrop ( dragobject source,  long handle )
event type long tv_dragenter ( dragobject source )
event type long tv_dragleave ( dragobject source )
event type long tv_dragwithin ( dragobject source,  long handle )
event type long tv_endlabeledit ( long handle,  string newtext )
event type long tv_getfocus ( )
event type long tv_itemcollapsed ( long handle )
event type long tv_itemcollapsing ( long handle )
event type long tv_itemexpanded ( long handle )
event type long tv_itemexpanding ( long handle )
event type long tv_itempopulate ( long handle )
event type long tv_key ( keycode key,  unsignedlong keyflags )
event type long tv_losefocus ( )
event type long tv_other ( unsignedlong wparam,  long lparam )
event type long tv_rightclicked ( long handle )
event type long tv_rightdoubleclicked ( long handle )
event type long tv_selectionchanging ( long oldhandle,  long newhandle )
event type long tv_sort ( long handle1,  long handle2 )
event type long dw_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
event type long dw_constructor ( )
event type long dw_dberror ( long sqldbcode,  string sqlerrtext,  string sqlsyntax,  dwbuffer buffer,  long row )
event type long dw_destructor ( )
event type long dw_doubleclicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
event type long dw_dragdrop ( dragobject source,  long row,  dwobject dwo )
event type long dw_dragenter ( dragobject source )
event type long dw_dragleave ( dragobject source )
event type long dw_dragwithin ( dragobject source,  long row,  dwobject dwo )
event type long dw_editchanged ( long row,  dwobject dwo,  string data )
event dw_error ( unsignedinteger errornumber,  readonly string errortext,  readonly string errorwindowmenu,  readonly string errorobject,  readonly string errorscript,  unsignedinteger errorline,  ref exceptionaction action,  ref any returnvalue )
event type long dw_getfocus ( )
event type long dw_itemchanged ( long row,  dwobject dwo,  string data )
event type long dw_itemerror ( long row,  dwobject dwo,  string data )
event type long dw_itemfocuschanged ( long row,  dwobject dwo )
event type long dw_losefocus ( )
event type long dw_other ( unsignedlong wparam,  long lparam )
event type long dw_printend ( long pagesprinted )
event type long dw_printpage ( long pagenumber,  long copy )
event type long dw_printstart ( long pagesmax )
event type long dw_rbuttondown ( integer xpos,  integer ypos,  long row,  dwobject dwo )
event type long dw_resize ( unsignedlong sizetype,  integer newwidth,  integer newheight )
event type long dw_retrieveend ( long rowcount )
event type long dw_retrieverow ( long row )
event type long dw_retrievestart ( )
event type long dw_rowfocuschanged ( long currentrow )
event type long dw_scrollhorizontal ( long scrollpos,  integer pane )
event type long dw_scrollvertical ( long scrollpos )
event type long dw_sqlpreview ( sqlpreviewfunction request,  sqlpreviewtype sqltype,  string sqlsyntax,  dwbuffer buffer,  long row )
event type long dw_updateend ( long rowsinserted,  long rowsupdated,  long rowsdeleted )
event type long dw_updatestart ( )
event type long lv_begindrag ( integer index )
event type long lv_beginlabeledit ( integer index )
event type long lv_beginrightdrag ( integer index )
event type long lv_clicked ( integer index )
event type long lv_columnclick ( integer column )
event type long lv_constructor ( )
event type long lv_deleteallitems ( )
event type long lv_deleteitem ( integer index )
event type long lv_destructor ( )
event type long lv_doubleclicked ( integer index )
event type long lv_dragdrop ( dragobject source,  integer index )
event type long lv_dragenter ( dragobject source )
event type long lv_dragleave ( dragobject source )
event type long lv_dragwithin ( dragobject source,  integer index )
event type long lv_endlabeledit ( integer index,  string newlabel )
event type long lv_getfocus ( )
event type long lv_insertitem ( integer index )
event type long lv_itemchanged ( integer index,  boolean focuschanged,  boolean hasfocus,  boolean selectionchange,  boolean selected,  boolean otherchange )
event type long lv_itemchanging ( integer index,  boolean focuschange,  boolean hasfocus,  boolean selectionchange,  boolean selected,  boolean otherchange )
event type long lv_key ( keycode key,  unsignedlong keyflags )
event type long lv_losefocus ( )
event type long lv_other ( unsignedlong wparam,  long lparam )
event type long lv_rightclicked ( integer index )
event type long lv_rightdoubleclicked ( integer index )
event type long lv_sort ( integer index1,  integer index2,  integer column )
event ue_setup ( )
event ue_pre_setup ( )
st_1 st_1
tv_1 tv_1
dw_1 dw_1
lv_1 lv_1
end type
global u_explorer_plus u_explorer_plus

type variables
boolean		i_b_moveinprogress=False
long		i_l_hiddencolor=0,&
		i_l_previous_lv_item
integer		i_i_barthickness=18,&
		i_i_windowborder=25
dragobject	i_do_left,&
		i_do_right
treeviewitem	i_tvi_lastclickeditem,&
		i_tvi_lastrightclickeditem
listviewitem	i_lvi_lastitem
boolean		i_b_dsdriven,&
		ib_cancel

end variables

forward prototypes
public function integer of_resizepanels ()
public function integer of_resize ()
public function integer of_setrightpanel (string a_s_item)
end prototypes

event resize;of_resize ( )
end event

event dw_clicked;dw_1.SelectRow ( 0, FALSE )
if row > 0 then &
	dw_1.SelectRow ( row, TRUE )
	
return 0
end event

public function integer of_resizepanels ();// If either panel is invalid then exit
if NOT isvalid ( i_do_left ) or NOT isvalid ( i_do_right ) then return -1

// Left vertical object processing
i_do_left.Resize ( st_1.X - i_do_left.X, i_do_left.Height )

// Middle splitter object processing
st_1.Resize ( st_1.width, i_do_left.Height )

// Right vertical object processing
i_do_right.Move ( st_1.X + st_1.Width, i_i_WindowBorder)
i_do_right.Resize ( width - i_do_right.X - i_i_WindowBorder - 5, i_do_right.Height )

Return 1

end function

public function integer of_resize ();if NOT isvalid ( i_do_left ) or NOT isvalid ( i_do_right ) then return -1

// Left vertical object processing
i_do_left.Move ( i_i_WindowBorder, i_i_WindowBorder )
i_do_left.Resize ( st_1.X - i_do_left.X, height - i_do_left.Y - i_i_WindowBorder )

// Right vertical object processing
i_do_right.Move ( st_1.X + st_1.width, i_i_WindowBorder )
i_do_right.Resize ( width - i_do_right.X - i_i_WindowBorder - 5, height - i_do_right.Y - i_i_WindowBorder )

// Middle splitter object processing
st_1.Resize ( st_1.width, i_do_left.Height )

return 1
end function

public function integer of_setrightpanel (string a_s_item);Choose Case a_s_item
	Case "listview"
		if i_do_right <> lv_1 then
			i_do_right = lv_1
			dw_1.Hide ( )
			of_resize ( )
			lv_1.Show ( )
		end if
	Case "datawindow"
		if i_do_right <> dw_1 then
			i_do_right = dw_1
			lv_1.Hide ( )
			of_resize ( )
			dw_1.Show ( )
		end if
End Choose

return 1
end function

event constructor;i_do_left 	= tv_1

of_setrightpanel ( "listview" )

TriggerEvent ( "ue_pre_setup" )
PostEvent ( "ue_setup" )

end event

on u_explorer_plus.create
this.st_1=create st_1
this.tv_1=create tv_1
this.dw_1=create dw_1
this.lv_1=create lv_1
this.Control[]={this.st_1,&
this.tv_1,&
this.dw_1,&
this.lv_1}
end on

on u_explorer_plus.destroy
destroy(this.st_1)
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.lv_1)
end on

type st_1 from statictext within u_explorer_plus
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 585
integer y = 16
integer width = 37
integer height = 1024
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SPLIT.cur"
long backcolor = 81324524
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
if i_b_moveinprogress then
	//process only if moved
	if parent.pointerx() > tv_1.x and &
		parent.pointerx() < lv_1.x + lv_1.width and &
		this.x <> parent.pointerx() then
		this.x = parent.pointerx()
		//Resize the panels
		of_resizepanels()
	end if
end if
end event

event mouseup;//Hide the bar
//this.BackColor = i_l_hiddencolor

//Resize the panels
of_resizepanels()

//Moving is no longer in progess.
i_b_moveinprogress = false
end event

event mousedown;//Initiate Move process
i_b_moveinprogress = true

end event

type tv_1 from u_treeview_ancestor within u_explorer_plus
integer x = 18
integer y = 16
integer width = 567
integer height = 1024
integer taborder = 10
end type

event selectionchanged;call super::selectionchanged;return Parent.Trigger Event tv_selectionchanged ( oldhandle, newhandle )
end event

event begindrag;call super::begindrag;return Parent.Trigger Event tv_begindrag ( handle )
end event

event clicked;call super::clicked;return Parent.Trigger Event tv_clicked ( handle )
end event

event constructor;call super::constructor;return Parent.Trigger Event tv_constructor ( )
end event

event doubleclicked;call super::doubleclicked;return Parent.Trigger Event tv_doubleclicked ( handle )
end event

event beginlabeledit;call super::beginlabeledit;return Parent.Trigger Event tv_beginlabeledit ( handle )
end event

event beginrightdrag;call super::beginrightdrag;return Parent.Trigger Event tv_beginrightdrag ( handle )
end event

event deleteitem;call super::deleteitem;return Parent.Trigger Event tv_deleteitem ( handle )
end event

event destructor;call super::destructor;return Parent.Trigger Event tv_destructor ( )
end event

event dragdrop;call super::dragdrop;return Parent.Trigger Event tv_dragdrop ( source, handle )
end event

event dragenter;call super::dragenter;return Parent.Trigger Event tv_dragenter ( source )
end event

event dragleave;call super::dragleave;return Parent.Trigger Event tv_dragleave ( source )
end event

event dragwithin;call super::dragwithin;return Parent.Trigger Event tv_dragwithin ( source, handle )
end event

event endlabeledit;call super::endlabeledit;return Parent.Trigger Event tv_endlabeledit ( handle, newtext )
end event

event getfocus;call super::getfocus;return Parent.Trigger Event tv_getfocus ( )
end event

event itemcollapsed;call super::itemcollapsed;return Parent.Trigger Event tv_itemcollapsed ( handle )
end event

event itemcollapsing;call super::itemcollapsing;return Parent.Trigger Event tv_itemcollapsing ( handle )
end event

event itemexpanded;call super::itemexpanded;return Parent.Trigger Event tv_itemexpanded ( handle )
end event

event itemexpanding;call super::itemexpanding;return Parent.Trigger Event tv_itemexpanding ( handle )
end event

event itempopulate;call super::itempopulate;return Parent.Trigger Event tv_itempopulate ( handle )
end event

event key;call super::key;return Parent.Trigger Event tv_key ( key, keyflags )
end event

event losefocus;call super::losefocus;return Parent.Trigger Event tv_losefocus ( )
end event

event rightclicked;call super::rightclicked;return Parent.Trigger Event tv_rightclicked ( handle )
end event

event rightdoubleclicked;call super::rightdoubleclicked;return Parent.Trigger Event tv_rightdoubleclicked ( handle )
end event

event selectionchanging;call super::selectionchanging;return Parent.Trigger Event tv_selectionchanging ( oldhandle, newhandle )
end event

event sort;call super::sort;return Parent.Trigger Event tv_sort ( handle1, handle2 )
end event

type dw_1 from u_datawindow_ancestor within u_explorer_plus
event ue_cancel ( )
integer x = 622
integer y = 16
integer width = 1317
integer height = 1024
integer taborder = 3
string dragicon = "Application!"
end type

event ue_cancel;ib_cancel = TRUE
end event

event clicked;return Parent.Trigger Event dw_clicked ( xpos, ypos, row, dwo )
end event

event constructor;call super::constructor;return Parent.Trigger Event dw_constructor ( )
end event

event dberror;call super::dberror;return Parent.Trigger Event dw_dberror ( sqldbcode, sqlerrtext, sqlsyntax, buffer, row )
end event

event destructor;call super::destructor;return Parent.Trigger Event dw_destructor ( )
end event

event doubleclicked;call super::doubleclicked;return Parent.Trigger Event dw_doubleclicked ( xpos, ypos, row, dwo )
end event

event dragdrop;call super::dragdrop;return Parent.Trigger Event dw_dragdrop ( source, row, dwo )
end event

event dragenter;call super::dragenter;return Parent.Trigger Event dw_dragenter ( source )
end event

event dragleave;call super::dragleave;return Parent.Trigger Event dw_dragleave ( source )
end event

event dragwithin;call super::dragwithin;return Parent.Trigger Event dw_dragwithin ( source, row, dwo )
end event

event editchanged;call super::editchanged;return Parent.Trigger Event dw_editchanged ( row, dwo, data )
end event

event error;call super::error;//return Parent.Trigger Event dw_error ( errornumber, errortext, errorwindowmenu, errorobject, errorscript, errorline, action, returnvalue )
end event

event getfocus;call super::getfocus;return Parent.Trigger Event dw_getfocus ( )
end event

event itemchanged;call super::itemchanged;return Parent.Trigger Event dw_itemchanged ( row, dwo, data )
end event

event itemerror;call super::itemerror;return Parent.Trigger Event dw_itemerror ( row, dwo, data )
end event

event itemfocuschanged;call super::itemfocuschanged;return Parent.Trigger Event dw_itemfocuschanged ( row, dwo )
end event

event losefocus;call super::losefocus;return Parent.Trigger Event dw_losefocus ( )
end event

event printend;call super::printend;return Parent.Trigger Event dw_printend ( pagesprinted )
end event

event printpage;call super::printpage;return Parent.Trigger Event dw_printpage ( pagenumber, copy )
end event

event printstart;call super::printstart;return Parent.Trigger Event dw_printstart ( pagesmax )
end event

event rbuttondown;call super::rbuttondown;return Parent.Trigger Event dw_rbuttondown ( xpos, ypos, row, dwo )
end event

event retrieveend;call super::retrieveend;//return Parent.Trigger Event dw_retrieveend ( rowcount )
end event

event resize;call super::resize;return Parent.Trigger Event dw_resize ( sizetype, newwidth, newheight )
end event

event retrieverow;Yield ( )
if ib_cancel then 
	ib_cancel = FALSE
	return 1
end if
end event

event retrievestart;call super::retrievestart;//return Parent.Trigger Event dw_retrievestart ( )
end event

event rowfocuschanged;call super::rowfocuschanged;return Parent.Trigger Event dw_rowfocuschanged ( currentrow )
end event

event scrollhorizontal;call super::scrollhorizontal;return Parent.Trigger Event dw_scrollhorizontal ( scrollpos, pane )
end event

event scrollvertical;call super::scrollvertical;return Parent.Trigger Event dw_scrollvertical ( scrollpos )
end event

event sqlpreview;call super::sqlpreview;return Parent.Trigger Event dw_sqlpreview ( request, sqltype, sqlsyntax, buffer, row )
end event

event updateend;call super::updateend;return Parent.Trigger Event dw_updateend ( rowsinserted, rowsupdated, rowsdeleted )
end event

event updatestart;call super::updatestart;return Parent.Trigger Event dw_updatestart ( )
end event

type lv_1 from u_listview_ancestor within u_explorer_plus
integer x = 622
integer y = 16
integer width = 1317
integer height = 1024
integer taborder = 20
end type

event begindrag;call super::begindrag;return Parent.Trigger Event lv_begindrag ( index )
end event

event beginlabeledit;call super::beginlabeledit;return Parent.Trigger Event lv_beginlabeledit ( index )
end event

event beginrightdrag;call super::beginrightdrag;return Parent.Trigger Event lv_beginrightdrag ( index )
end event

event clicked;call super::clicked;return Parent.Trigger Event lv_clicked ( index )
end event

event columnclick;call super::columnclick;return Parent.Trigger Event lv_columnclick ( column )
end event

event constructor;call super::constructor;return Parent.Trigger Event lv_constructor ( )
end event

event deleteallitems;call super::deleteallitems;return Parent.Trigger Event lv_deleteallitems ( )
end event

event deleteitem;call super::deleteitem;return Parent.Trigger Event lv_deleteitem ( index )
end event

event destructor;call super::destructor;return Parent.Trigger Event lv_destructor ( )
end event

event doubleclicked;call super::doubleclicked;return Parent.Trigger Event lv_doubleclicked ( index )
end event

event dragdrop;call super::dragdrop;return Parent.Trigger Event lv_dragdrop ( source, index )
end event

event dragenter;call super::dragenter;return Parent.Trigger Event lv_dragenter ( source )
end event

event dragleave;call super::dragleave;return Parent.Trigger Event lv_dragleave ( source )
end event

event dragwithin;call super::dragwithin;return Parent.Trigger Event lv_dragwithin ( source, index )
end event

event endlabeledit;call super::endlabeledit;return Parent.Trigger Event lv_endlabeledit ( index, newlabel )
end event

event getfocus;call super::getfocus;return Parent.Trigger Event lv_getfocus ( )
end event

event insertitem;call super::insertitem;return Parent.Trigger Event lv_insertitem ( index )
end event

event itemchanged;call super::itemchanged;return Parent.Trigger Event lv_itemchanged ( index, focuschange, hasfocus, selectionchange, selected, otherchange )

end event

event itemchanging;call super::itemchanging;return Parent.Trigger Event lv_itemchanging ( index, focuschange, hasfocus, selectionchange, selected, otherchange )

end event

event key;call super::key;//return Parent.Trigger Event lv_key ( key, keyflags )

end event

event losefocus;call super::losefocus;return Parent.Trigger Event lv_losefocus ( )
end event

event rightclicked;call super::rightclicked;return Parent.Trigger Event lv_rightclicked ( index )
end event

event rightdoubleclicked;call super::rightdoubleclicked;return Parent.Trigger Event lv_rightdoubleclicked ( index )
end event

event sort;call super::sort;return Parent.Trigger Event lv_sort ( index1, index2, column )
end event

