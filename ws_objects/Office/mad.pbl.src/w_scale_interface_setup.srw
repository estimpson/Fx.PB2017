$PBExportHeader$w_scale_interface_setup.srw
$PBExportComments$mad
forward
global type w_scale_interface_setup from Window
end type
type st_2 from statictext within w_scale_interface_setup
end type
type dw_2 from datawindow within w_scale_interface_setup
end type
type st_1 from statictext within w_scale_interface_setup
end type
type dw_1 from datawindow within w_scale_interface_setup
end type
end forward

global type w_scale_interface_setup from Window
int X=672
int Y=264
int Width=3200
int Height=1544
boolean TitleBar=true
string Title="Scale Interface Setup [w_scale_interface_setup]"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event add_scale pbm_custom01
event delete_scale pbm_custom02
event save_scale pbm_custom03
event check_item pbm_custom04
st_2 st_2
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global w_scale_interface_setup w_scale_interface_setup

type variables
boolean bitemchanged = False
end variables

on add_scale;SelectRow ( dw_1, 0, False )
dw_2.Reset ( )
dw_2.SetTransObject ( sqlca )
dw_2.InsertRow ( 1 )
dw_2.SetColumn ( "type_of_scale" )
dw_2.SetFocus ( )
end on

on delete_scale;Long	lRow
Int	iRtnCode

lRow = dw_1.GetRow ( )

If lRow < 1 Then Return

iRtnCode = MessageBox ( "Delete", "Are you sure about deleting ~r " + dw_1.GetItemString ( lRow, "type_of_scale" ) + "?", Question!, YesNo!, 2 )

If iRtnCode = 1 Then
	dw_1.DeleteRow ( lRow )
	If dw_1.Update ( ) = -1 Then
		RollBack ;
	Else
		dw_2.Reset ( )
		Commit ;
	End if
End if
end on

on save_scale;String s_Steady_char

// To check steady character of datawindow

dw_2.AcceptText ( )

s_Steady_char = dw_2.GetItemString ( 1, "steady_character")

If ISNULL(s_Steady_char) OR s_Steady_char = '' Then

   dw_2.Triggerevent ( dbError! )

Else

	If dw_2.Update ( ) = -1 Then        // To update the dw
		RollBack ;
	Else
		Commit ;
		bitemchanged = False
	End if

	dw_1.Retrieve ( )

End If
end on

on check_item;Int i_Rtncode

If bitemchanged = True Then

	i_Rtncode = MessageBox ( "Warning", "Would you like to save the changes?", Exclamation!, YesNoCancel!, 3 )

	If i_Rtncode = 1 Then

		TriggerEvent ( "save_scale" )

        If bitemchanged = True AND i_Rtncode = 1 Then
           w_scale_interface_setup.dw_1.SetFocus ( )
        End If
	
	ElseIf i_Rtncode = 2 Then

		Close ( w_scale_interface_setup )

	Else

      dw_2.SetFocus ( )

	End If

End If

If bitemchanged = False Then

  Close ( w_scale_interface_setup )

End If
end on

on open;dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( )
end on

on w_scale_interface_setup.create
this.st_2=create st_2
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.dw_2,&
this.st_1,&
this.dw_1}
end on

on w_scale_interface_setup.destroy
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

on activate;If gnv_App.of_GetFrame().MenuName <> "m_scale_interface_setups_menu" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_scale_interface_setups_menu )
end on

type st_2 from statictext within w_scale_interface_setup
int X=1097
int Y=32
int Width=1646
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Scale Entry"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554560
long BackColor=79741120
long BorderColor=128
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_scale_interface_setup
int X=1097
int Y=108
int Width=1646
int Height=1184
int TabOrder=20
string DataObject="d_scale_entry"
BorderStyle BorderStyle=StyleLowered!
end type

on itemchanged;bitemchanged = True
end on

event dberror;MessageBox ( "Update Error", "Steady Character cannot be null!", Exclamation! )

bitemchanged = True

return (2)
end event

on editchanged;bitemchanged = True
end on

type st_1 from statictext within w_scale_interface_setup
int X=91
int Y=32
int Width=951
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="List of Possible Scales"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554560
long BackColor=79741120
long BorderColor=128
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_scale_interface_setup
int X=91
int Y=108
int Width=951
int Height=1184
int TabOrder=10
string DataObject="d_scale_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Long lRow

lRow = dw_1.GetClickedRow ( )

SelectRow ( dw_1, 0, False )

If lRow < 1 Then Return

SelectRow ( dw_1, lRow, True )

dw_2.SetTransObject ( sqlca )
dw_2.Retrieve ( dw_1.GetItemString ( lRow, "type_of_scale" ) )
end on

