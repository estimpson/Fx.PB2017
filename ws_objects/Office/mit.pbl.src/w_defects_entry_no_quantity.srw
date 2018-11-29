$PBExportHeader$w_defects_entry_no_quantity.srw
forward
global type w_defects_entry_no_quantity from window
end type
type cb_exit from commandbutton within w_defects_entry_no_quantity
end type
type st_choose_defect from statictext within w_defects_entry_no_quantity
end type
type dw_defects from datawindow within w_defects_entry_no_quantity
end type
type cb_enter from commandbutton within w_defects_entry_no_quantity
end type
end forward

global type w_defects_entry_no_quantity from window
integer x = 59
integer y = 72
integer width = 2825
integer height = 1820
windowtype windowtype = response!
long backcolor = 77897888
cb_exit cb_exit
st_choose_defect st_choose_defect
dw_defects dw_defects
cb_enter cb_enter
end type
global w_defects_entry_no_quantity w_defects_entry_no_quantity

type variables
String 	sReason
String 	sDefectQuantity
Long 	NRowNumber
String 	szMachine
String 	szPart
Dec	id_Quantity
end variables

on open;dw_defects.settransobject ( sqlca )
dw_defects.retrieve ()



end on

on w_defects_entry_no_quantity.create
this.cb_exit=create cb_exit
this.st_choose_defect=create st_choose_defect
this.dw_defects=create dw_defects
this.cb_enter=create cb_enter
this.Control[]={this.cb_exit,&
this.st_choose_defect,&
this.dw_defects,&
this.cb_enter}
end on

on w_defects_entry_no_quantity.destroy
destroy(this.cb_exit)
destroy(this.st_choose_defect)
destroy(this.dw_defects)
destroy(this.cb_enter)
end on

type cb_exit from commandbutton within w_defects_entry_no_quantity
integer x = 727
integer y = 1456
integer width = 658
integer height = 256
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

on clicked;CloseWithReturn ( Parent, "" )
end on

type st_choose_defect from statictext within w_defects_entry_no_quantity
integer x = 722
integer y = 32
integer width = 1280
integer height = 160
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Choose a Defect Code"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_defects from datawindow within w_defects_entry_no_quantity
integer x = 32
integer y = 224
integer width = 2752
integer height = 1184
integer taborder = 20
string dataobject = "dw_defects_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on clicked;// Get Reason 

nRowNumber = dw_defects.getclickedrow ( )

////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If nRowNumber = 0 Then Return

SelectRow ( dw_defects, 0, False )
SelectRow ( dw_defects, nRowNumber, True )

sReason = dw_defects.getitemstring ( nrownumber, "code" )



	



end on

type cb_enter from commandbutton within w_defects_entry_no_quantity
integer x = 1385
integer y = 1456
integer width = 658
integer height = 256
integer taborder = 10
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Enter"
end type

on clicked;CloseWithReturn ( Parent, sReason )
end on

