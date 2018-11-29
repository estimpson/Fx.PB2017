$PBExportHeader$w_user_defined.srw
forward
global type w_user_defined from w_sheet_4t
end type
type dw_2 from datawindow within w_user_defined
end type
type dw_1 from datawindow within w_user_defined
end type
end forward

global type w_user_defined from w_sheet_4t
integer x = 214
integer y = 221
integer height = 1560
string title = "User Defined Setups"
string menuname = "m_user_defined_menu"
event add_item pbm_custom01
event save_item pbm_custom02
event check_item pbm_custom03
event delete_item pbm_custom04
dw_2 dw_2
dw_1 dw_1
end type
global w_user_defined w_user_defined

type variables
Long i_l_Sequence

Boolean  bitemchanged = False

String i_s_Module

end variables

event add_item;Long l_l_RowCount

l_l_RowCount = 1

dw_2.SetFocus ()
dw_2.InsertRow ( 1 )
dw_2.SetRow ( l_l_RowCount )
dw_2.SetItem ( l_l_RowCount, "module", i_s_Module )
dw_2.SetItem ( l_l_RowCount, "sequence", i_l_Sequence )
dw_2.SetColumn ( "code" )
end event

event save_item;gnv_App.of_GetFrame().SetMicroHelp ( "Saving Window Contents..." )

If dw_1.Update ( ) = -1 Then

	RollBack ;
	gnv_App.of_GetFrame().SetMicroHelp ( "Unable To Save Contents Of Window..." )

Else

	If dw_2.Update ( ) = -1 Then

		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Unable To Save Contents Of Window..." )

	Else

		Commit ;
		bitemchanged = False
		gnv_App.of_GetFrame().SetMicroHelp ( "Contents Of Window Saved..." )

	End if

End if
end event

event check_item;Int l_i_RtnCode

If bitemchanged Then

	l_i_RtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case l_i_RtnCode 

     Case 1

			w_user_defined.TriggerEvent( "save_item" )

     Case 3

		  Return       

   End Choose

End If
end event

event delete_item;String l_s_code

Long l_l_Row

Int l_i_RtnCode

l_l_Row = dw_2.Getrow ( )

If l_l_Row < 1 Then Return

l_s_code = dw_2.GetItemString ( l_l_row, 1 )

l_i_RtnCode = MessageBox ( monsys.msg_title, "Are you sure you want~rto delete code: " + l_s_code + "?", Question!, OkCancel!, 2 )

If l_i_RtnCode = 1 Then

	SetMicroHelp ( "Deleting Record..." )
	dw_2.DeleteRow ( l_l_Row )

	If dw_2.Update ( ) = -1 Then
		RollBack ;
		SetMicroHelp ( "Unable To Delete Record..." )
	Else
		Commit ;	
		bitemchanged = False
		setMicroHelp ( "Record Deleted..." )
	End if

End if
end event

event closequery;call super::closequery;Int l_i_RtnCode

If bitemchanged Then

	l_i_RtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case l_i_RtnCode 

     Case 1

			This.TriggerEvent( "save_item" )

          If bitemchanged = True AND l_i_RtnCode = 1 Then
				  Message.Returnvalue = 1   
          End If

	  Case 2 

         close ( this )
  
     Case 3

		  Message.Returnvalue = 1       

     End Choose

Else

      close ( this )
     
End If
	




end event

event open;call super::open;If dw_1.RowCount ( ) > 0 Then

	dw_1.SelectRow ( 1, True )
	i_s_Module  = dw_1.GetItemString ( 1, "module" )
	i_l_Sequence = dw_1.GetItemNumber ( 1, "sequence" )
	dw_2.Retrieve ( i_s_Module, i_l_Sequence )	

End if
end event

on w_user_defined.create
int iCurrent
call super::create
if this.MenuName = "m_user_defined_menu" then this.MenuID = create m_user_defined_menu
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_1
end on

on w_user_defined.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from datawindow within w_user_defined
integer x = 1262
integer y = 32
integer width = 1659
integer height = 1380
integer taborder = 20
string dataobject = "d_user_definable_data_by_mod_seq"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on editchanged;bitemchanged = True
end on

on itemchanged;bitemchanged = True
end on

event constructor;settransobject ( sqlca )
end event

type dw_1 from datawindow within w_user_defined
integer x = 41
integer y = 32
integer width = 1207
integer height = 1380
integer taborder = 10
string dataobject = "d_user_definable_setup_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If bitemchanged Then
	w_user_defined.TriggerEvent("check_item")
End IF

If row < 1 Then Return

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, row, True )

dw_1.SetRow ( Row )

i_s_Module = dw_1.GetItemString ( Row, "module" )
i_l_Sequence = dw_1.GetItemNumber ( Row, "sequence" )

dw_2.Retrieve ( i_s_Module, i_l_Sequence )


end event

on editchanged;bitemchanged = True
end on

on itemchanged;bitemchanged = True
end on

event constructor;settransobject ( sqlca )
retrieve()
end event

