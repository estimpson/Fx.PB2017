$PBExportHeader$w_object_inquiry.srw
forward
global type w_object_inquiry from w_inquiry_ancestor
end type
end forward

global type w_object_inquiry from w_inquiry_ancestor
string title = "Object Inquiry"
string menuname = "m_object_inquiry"
long backcolor = 78682240
event ue_correct ( )
event ue_label pbm_custom11
end type
global w_object_inquiry w_object_inquiry

type variables
long i_l_row
end variables

event ue_correct();long						l_l_serial,&
							l_l_row

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 then return

l_l_Serial = dw_inquiry.GetItemNumber ( l_l_row, "serial" )

OpenWithParm ( w_correct_object, l_l_serial )

end event

event ue_label;long						l_l_serial,&
							l_l_row,&
							l_l_count
							
st_generic_structure	l_str_parm

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 then return

if NOT dw_inquiry.IsSelected ( l_l_row ) then return

FOR l_l_count = 1 To dw_inquiry.RowCount() 
	
	IF dw_inquiry.IsSelected( l_l_count) THEN
	 l_l_Serial = dw_inquiry.GetItemNumber ( l_l_count, "serial" )
    l_str_parm.Value1 = String ( l_l_Serial )
    SetMicroHelp('Label is being printed')
    f_print_label ( l_str_Parm )
   END IF
NEXT
 SetMicroHelp('Ready')

end event

on w_object_inquiry.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_object_inquiry" then this.MenuID = create m_object_inquiry
end on

on w_object_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_add;call super::ue_add;
Open(w_manual_add_object)

end event

event ue_delete;call super::ue_delete;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	User	Date	Notes/changes
//	----	----	-------------
//	GPH	3/30/00	Included std qty & qty to reflect in audit_trail table, declared dqty variable. Also included
//			in the select & into
//			If Not f_create_audit_trail ( lSerial, "D",szOperator,String ( dNewOnHand ), string(dqty), string(dstdqty),"","","","","","No Commit" ) Then
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Int	iRtnCode
Long	lSerial
Long	lShipper,&
	l_l_row
Dec 	dStdQty
Dec	dQty
Dec	dNewOnHand
String	szPart
String	szOperator
String	cDeleteAuditTrail
String	cStatus

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 or NOT dw_inquiry.IsSelected ( l_l_row ) then return

Open ( w_operator_entry )

szOperator = f_get_string_value ( Message.StringParm )

if szOperator = '' then return

lSerial = dw_inquiry.GetItemNumber ( l_l_row, "serial" )

if MessageBox ( "Delete", "Do you really want to delete serial# " + String ( lSerial ) + "?", Question!, YesNo!, 2 ) = 2 then return

SELECT	object.std_quantity,
	object.quantity,
	object.part,
	object.shipper,
	object.status
INTO 	:dStdQty,
	:dQty,
	:szPart,
	:lShipper,
	:cStatus
FROM	object  
WHERE	object.serial = :lSerial;

If f_get_value ( lShipper ) > 0 Then
	RollBack ;
	MessageBox ( "Error", "You can not delete an object that has been staged!", StopSign! )
	Return
End if

If cStatus = 'A' Then &
	dNewOnHand = f_update_onhand ( szPart, dStdQty, "-*" )
	
// 6/8/2001 - The below if st. and block is commented out as, we decided not to allow the 
// 		user to delete audit_trail records. This was done for sp423

select	audit_deletion
into	:cDeleteAuditTrail
from	parameters ;

if isnull(cDeleteAuditTrail,'N') = 'Y' then 

	If MessageBox ( "Audit Trail", "Do you also want to delete the audit trail for this object?", Question!, YesNo!, 2 ) = 1 Then
	
		DELETE 
		FROM	audit_trail
		WHERE	serial = :lSerial   ;
	
		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! Datawindow" )
			Return
		End if
	End if
end if 

If Not f_create_audit_trail ( lSerial, "D",szOperator,String ( dNewOnHand ), string(dqty), string(dstdqty),"","","","","","No Commit" ) Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! Creating Audit Trail" )
	RollBack ;
	Return
Else
	dw_inquiry.DeleteRow ( l_l_row )

	If dw_inquiry.Update ( ) = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! Datawindow" )
		Return
	Else
		Commit ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )
	End if

End if

end event

type st_1 from w_inquiry_ancestor`st_1 within w_object_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_object_inquiry
string dataobject = "dw_object_inquiry"
boolean hsplitscroll = true
end type

event dw_inquiry::clicked;/*  Declare Variables  */
Long	l_l_Count
Long	l_l_Row
Long  l_l_PrevRow

/*  Initialize Variables  */

l_l_Row = row
i_l_Row   = l_l_Row

If l_l_Row < 1 Then Return

If KeyDown ( keyShift! ) Then

   l_l_PrevRow = dw_inquiry.GetRow()

	If l_l_PrevRow < l_l_Row Then

		For l_l_Count = l_l_PrevRow to l_l_Row
			SelectRow ( This, l_l_Count, True )
		Next

   Else

		For l_l_Count = l_l_Row to l_l_PrevRow
			SelectRow ( This, l_l_Count, True )
		Next
   
	End If 

Elseif KeyDown ( keyControl! ) Then

	If This.IsSelected ( l_l_Row ) Then
		This.SelectRow ( l_l_Row, False )
	Else
		This.SelectRow ( l_l_Row, True )
	End if

Else

	SelectRow ( This, 0, False )
	SelectRow ( This, l_l_Row, True )

End if

l_l_PrevRow = l_l_Row
end event

event dw_inquiry::retrievestart;call super::retrievestart;gnv_App.of_GetFrame().Menuid.Dynamic mf_switch(0) // Disable buttons
end event

event dw_inquiry::retrieveend;call super::retrieveend;gnv_App.of_GetFrame().Menuid.Dynamic mf_switch(1) // Enable buttons
end event

