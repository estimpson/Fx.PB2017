$PBExportHeader$u_dw_search.sru
forward
global type u_dw_search from u_dw
end type
end forward

global type u_dw_search from u_dw
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type
global u_dw_search u_dw_search

on u_dw_search.create
call super::create
end on

on u_dw_search.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Turn on the linded dw search.
of_SetLinkDWSearch ( true )

/*
Usage:
inv_LinkDWSearch.of_Register ( "[SearchDWColumn]", [SearchInDW].object.[SearchInColumn], [SearchInDW])
*/
end event

event editchanged;call super::editchanged;
//	Process edit changes.
inv_LinkDWSearch.event pfc_EditChanged ( row, dwo, data )

end event

event itemfocuschanged;call super::itemfocuschanged;
//	Process item focus changes.
inv_LinkDWSearch.event pfc_itemfocuschanged ( row, dwo )

end event

event getfocus;call super::getfocus;
//	Process item focus changes.
inv_LinkDWSearch.event pfc_getfocus ()

end event

