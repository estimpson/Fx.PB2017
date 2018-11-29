$PBExportHeader$w_part_revision.srw
$PBExportComments$Part Revision maintenance response window.
forward
global type w_part_revision from Window
end type
type dw_1 from datawindow within w_part_revision
end type
type cb_5 from commandbutton within w_part_revision
end type
type cb_4 from commandbutton within w_part_revision
end type
type cb_3 from commandbutton within w_part_revision
end type
type cb_2 from commandbutton within w_part_revision
end type
type cb_1 from commandbutton within w_part_revision
end type
end forward

global type w_part_revision from Window
int X=833
int Y=361
int Width=2753
int Height=1209
boolean TitleBar=true
string Title="Part Revision"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
event ue_close pbm_custom09
dw_1 dw_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_part_revision w_part_revision

type variables
str_part_revision istr_part_revision
string is_part

end variables

event ue_close;istr_part_revision.part = dw_1.getitemstring(dw_1.getrow(),1)
istr_part_revision.revision = dw_1.getitemstring(dw_1.getrow(),'revision')
istr_part_revision.engineering_level = dw_1.getitemstring(dw_1.getrow(),'engineering_level')
istr_part_revision.effective_datetime = dw_1.getitemdatetime(dw_1.getrow(),'effective_datetime')

close(this)
end event

event open;is_part = message.stringparm
long ll_currow

dw_1.settransobject(sqlca)
if dw_1.retrieve(is_part) = 0 then
	ll_currow = dw_1.insertrow(0)
	dw_1.setrow(ll_currow)
	dw_1.scrolltorow(ll_currow)
	dw_1.setitem(ll_currow,'part',is_part )
	dw_1.setitem(ll_currow,'effective_datetime',today() )
else
	dw_1.setrow(dw_1.rowcount())
end if

dw_1.setfocus()

end event

event close;closewithreturn(this,istr_part_revision)
end event

on w_part_revision.create
this.dw_1=create dw_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.dw_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_part_revision.destroy
destroy(this.dw_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_part_revision
int X=42
int Y=29
int Width=2657
int Height=909
int TabOrder=1
string DataObject="d_part_revision"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;setrow(row)
selectrow(0,false)
selectrow(row,true)
end event

type cb_5 from commandbutton within w_part_revision
int X=1761
int Y=973
int Width=266
int Height=109
int TabOrder=10
string Text="Apply"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()

end event

type cb_4 from commandbutton within w_part_revision
int X=1473
int Y=973
int Width=266
int Height=109
int TabOrder=20
string Text="Remove"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.deleterow(dw_1.getrow())

end event

type cb_3 from commandbutton within w_part_revision
int X=1203
int Y=973
int Width=247
int Height=109
int TabOrder=30
string Text="Add"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_currow

ll_currow = dw_1.insertrow(0)
dw_1.setrow(ll_currow)
dw_1.scrolltorow(ll_currow)
dw_1.setitem(ll_currow,'part',is_part )
dw_1.setitem(ll_currow,'effective_datetime',today() )
dw_1.setfocus()

end event

type cb_2 from commandbutton within w_part_revision
int X=933
int Y=973
int Width=247
int Height=109
int TabOrder=50
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;setnull(istr_part_revision.engineering_level)
close(parent)
end event

type cb_1 from commandbutton within w_part_revision
int X=663
int Y=973
int Width=247
int Height=109
int TabOrder=40
string Text="Okay"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()
parent.triggerevent('ue_close')

end event

