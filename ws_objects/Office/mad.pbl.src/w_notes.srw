$PBExportHeader$w_notes.srw
forward
global type w_notes from w_sheet_4t
end type
type cb_1 from commandbutton within w_notes
end type
type cb_2 from commandbutton within w_notes
end type
type dw_1 from datawindow within w_notes
end type
end forward

global type w_notes from w_sheet_4t
integer x = 214
integer y = 221
integer height = 1560
string title = "Notes"
string menuname = "m_part_note"
event ue_save ( )
event ue_close ( )
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_notes w_notes

event ue_save();cb_1.event clicked()
end event

event ue_close();cb_2.event clicked()
end event

on open;String szPart

szPart = Message.StringParm

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( szPart )
end on

on w_notes.create
int iCurrent
call super::create
if this.MenuName = "m_part_note" then this.MenuID = create m_part_note
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_notes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_notes
boolean visible = false
integer x = 782
integer y = 412
integer width = 256
integer height = 128
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;If dw_1.Update ( ) = -1 Then
	RollBack ;
	Return
End if

Commit ;

Close ( w_notes )
end event

type cb_2 from commandbutton within w_notes
boolean visible = false
integer x = 1079
integer y = 412
integer width = 256
integer height = 124
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;Close ( w_notes )


end event

type dw_1 from datawindow within w_notes
integer x = 41
integer y = 32
integer width = 1522
integer height = 480
integer taborder = 10
string dataobject = "d_part_master_notes"
borderstyle borderstyle = stylelowered!
end type

event editchanged;
Integer	iline

iline	= GetRow()

//dw_1.Modify ( "description_long.X1 = 1" )
//dw_1.Modify ( "description_long.X2 =20" )
//dw_1.Modify ( "description_long.Y1 = 1" )
string setting
setting = dw_1.Describe ( "description_long.TabSequence" )


//commented below as the tabsequence the column has tabsequence-sm 4/28/00
//dw_1.Modify ( "description_long.TabSequence=10" )
end event

