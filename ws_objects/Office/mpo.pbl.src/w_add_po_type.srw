$PBExportHeader$w_add_po_type.srw
$PBExportComments$the window to select blanket or normal po type
forward
global type w_add_po_type from w_response
end type
type cb_2 from commandbutton within w_add_po_type
end type
type cb_1 from commandbutton within w_add_po_type
end type
type rb_2 from radiobutton within w_add_po_type
end type
type rb_1 from radiobutton within w_add_po_type
end type
end forward

global type w_add_po_type from w_response
integer x = 1070
integer y = 648
integer width = 741
integer height = 628
string title = "Add Purchase Order"
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
end type
global w_add_po_type w_add_po_type

on open;string ls_type

select order_type
into   :ls_type
from   parameters ;

If ls_type = 'N' Then
    rb_2.checked = true
Else
    rb_1.checked = true
End if
end on

on deactivate;Close ( This )
end on

on w_add_po_type.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
end on

on w_add_po_type.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

type cb_2 from commandbutton within w_add_po_type
integer x = 407
integer y = 352
integer width = 256
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_add_po_type
integer x = 69
integer y = 352
integer width = 256
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;If rb_1.Checked = True Then
	OpenSheetWithParm ( w_blanket_po_entry, -1, gnv_App.of_GetFrame(), 0, Original! )
Elseif rb_2.Checked = True Then
	OpenSheetWithParm ( w_normal_po_entry, -1, gnv_App.of_GetFrame(), 0, Original! )
End if
Close(Parent)
end event

type rb_2 from radiobutton within w_add_po_type
integer x = 73
integer y = 128
integer width = 585
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Normal Order"
end type

type rb_1 from radiobutton within w_add_po_type
integer x = 73
integer y = 32
integer width = 585
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Blanket Order"
boolean checked = true
end type

