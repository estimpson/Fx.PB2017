$PBExportHeader$w_part_char.srw
forward
global type w_part_char from w_sheet_4t
end type
type st_1 from statictext within w_part_char
end type
type dw_1 from datawindow within w_part_char
end type
end forward

global type w_part_char from w_sheet_4t
integer height = 1560
string title = "Part Characteristics"
string menuname = "m_part_char"
event ue_exit pbm_custom01
event ue_save pbm_custom02
st_1 st_1
dw_1 dw_1
end type
global w_part_char w_part_char

type variables
String szPart

Boolean ib_Close, &
              ib_item_changed
end variables

event ue_exit;close ( w_part_char )
end event

event ue_save;If dw_1.Update ( ) = -1 Then
	 dw_1.SetFocus ()
	 RollBack ;
 Else
	 Commit ;
	 ib_item_changed = FALSE
    Close ( w_part_char )
End if
end event

on open;szPart = Message.StringParm
ib_close = false

dw_1.settransobject ( sqlca )
If dw_1.Retrieve ( szPart ) < 1 Then
	dw_1.InsertRow ( 0 )
	dw_1.SetItem ( 1, "part", szPart )
End if

  SELECT user_definable_module_labels.label  
    INTO :st_1.Text  
    FROM user_definable_module_labels  
   WHERE ( user_definable_module_labels.module = 'PM' ) AND  
         ( user_definable_module_labels.sequence = 3 )   ;

st_1.Text = st_1.Text + ":"

end on

on w_part_char.create
int iCurrent
call super::create
if this.MenuName = "m_part_char" then this.MenuID = create m_part_char
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_part_char.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
end on

event closequery;call super::closequery;Integer  l_i_rtn_Code

IF ib_item_changed THEN

	l_i_rtn_code = MessageBox ( 'System Message', "Do you want to save changes", &
					Question!, YesNoCancel!, 3 ) 

	IF  l_i_rtn_code = 1 THEN
			TriggerEvent ( 'ue_Save' )
	ELSEIF l_i_rtn_code = 2 THEN
			RETURN 0  
	ELSE
			RETURN 1
	END IF

ELSE
	RETURN 0  
END IF
end event

type st_1 from statictext within w_part_char
integer x = 59
integer y = 512
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "User Defined:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_part_char
integer x = 41
integer y = 28
integer width = 987
integer height = 576
integer taborder = 10
string dataobject = "dw_part_char"
boolean border = false
boolean livescroll = true
end type

on itemerror;dw_1.SetText ("")
end on

event itemchanged;ib_item_changed = TRUE
end event

event editchanged;ib_item_changed = TRUE
end event

