$PBExportHeader$w_location_inquiry.srw
$PBExportComments$location inquiry window
forward
global type w_location_inquiry from w_inquiry_ancestor
end type
end forward

global type w_location_inquiry from w_inquiry_ancestor
string title = "Location Setup"
string menuname = "m_location_inquiry"
string defaultsheetname = "w_location_form"
event ue_label pbm_custom10
end type
global w_location_inquiry w_location_inquiry

type variables
string		i_s_location
end variables

event ue_label;call super::ue_label;long		l_l_row
string	l_s_location

l_l_row = dw_inquiry.GetRow ( )

if l_l_row > 0 and dw_inquiry.IsSelected ( l_l_row ) then
	l_s_location = dw_inquiry.GetItemString ( l_l_row, "code" )
	OpenWithParm ( w_std_location_label, l_s_location )
end if
end event

on w_location_inquiry.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_location_inquiry" then this.MenuID = create m_location_inquiry
end on

on w_location_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_add;call super::ue_add;OpenSheet ( DefaultSheet, DefaultSheetName, gnv_App.of_GetFrame(), 3, Original! )
if f_get_value ( Message.DoubleParm ) > 0 then
	dw_inquiry.Retrieve ( )
end if
end event

event ue_delete;call super::ue_delete;String 	l_s_location,&
			l_s_type
long		l_l_row,&
			l_l_count
int		l_i_rtncode

//
//  Check for existing objects in the location
//  If so, get out.
//

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 then return

if NOT dw_inquiry.IsSelected ( l_l_row ) then return

l_s_location	= dw_inquiry.GetItemString ( l_l_row, "code" )
l_s_type     	= dw_inquiry.GetItemString ( l_l_row, "type" )

SELECT count(object.serial)
  INTO :l_l_count
  FROM object  
 WHERE object.location = :l_s_location   ;
	
If l_l_count > 0 Then 
	MessageBox ( "Error", "You can not delete locations that have objects in them!", StopSign! )
	Return
End if

l_i_rtncode = MessageBox ( "Delete", "Are you sure you want to delete " + l_s_location + "?", Question!, OkCancel!, 2 )

If l_i_rtncode = 1 Then
	
	gnv_App.of_GetFrame().SetMicroHelp ( "Deleting Records..." )
		
	If l_s_type = 'MC' Then

		DELETE FROM machine  
		 WHERE machine_no = :l_s_location   ;

		DELETE FROM machine_policy  
		 WHERE machine = :l_s_location   ;
			
		DELETE FROM machine_process  
		 WHERE machine = :l_s_location   ;

		If SQLCA.SQLCode = -1 Then
			RollBack ;
			MessageBox ( "Error", SQLCA.SQLErrText, StopSign! )
			Return
		Else
			Commit ;
		End if

	End if

	If dw_inquiry.DeleteRow ( l_l_row ) = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

	If dw_inquiry.Update ( ) = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

	Commit ;

	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )

End if

dw_inquiry.SetFocus ( )

end event

type st_1 from w_inquiry_ancestor`st_1 within w_location_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_location_inquiry
string dataobject = "d_dbo_location-all"
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;string	l_s_location

dw_inquiry.DBCancel()

if row < 1 then return

l_s_location = GetItemString ( row, "code" )

OpenSheetWithParm ( DefaultSheet, l_s_location, DefaultSheetName, gnv_App.of_GetFrame(), 3, Original! )

end event

event dw_inquiry::retrievestart;call super::retrievestart;long		l_l_row

l_l_row = GetRow ( )

if l_l_row < 1 or NOT IsSelected ( l_l_row ) then return

i_s_location = GetItemString ( l_l_row, "code" )

end event

event dw_inquiry::retrieveend;call super::retrieveend;long	l_l_row

if i_s_location > "" then
	l_l_row = Find ( "code = '" + i_s_location + "'", 1, RowCount ( ) )
	if l_l_row > 0 then
		ScrollToRow ( l_l_row )
		SelectRow ( 0, FALSE )
		SelectRow ( l_l_row, TRUE )
	end if
	i_s_location = ""
end if

SetPointer(Arrow!)
end event

