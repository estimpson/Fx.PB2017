$PBExportHeader$w_po_inquiry.srw
forward
global type w_po_inquiry from w_inquiry_ancestor
end type
end forward

global type w_po_inquiry from w_inquiry_ancestor
string title = "PO Inquiry"
string menuname = "m_po_inquiry"
event ue_closereleases ( )
end type
global w_po_inquiry w_po_inquiry

type variables
Long i_l_po_number
end variables

event ue_closereleases;long	ll_deletecount
if i_l_po_number > 0 then 
	if Messagebox ( monsys.msg_title, "This will close all the fully received releases for PO #:" + string(i_l_po_number ) + " Do you want to contine 'Y/N'", Question!,YesNo!, 2 ) = 1 then
		delete from po_detail where po_number = :i_l_po_number and received >= quantity ;
		ll_deletecount = sqlca.sqlnrows
		if sqlca.sqlcode = -1 then
			rollback;
			Messagebox ( monsys.msg_title, "No releases were closed!")
		else
			commit;
			Messagebox ( monsys.msg_title, "Totally "+string(ll_deletecount) + " releases were closed!")
		end if
	end if 	
end if 	
end event

on w_po_inquiry.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_po_inquiry" then this.MenuID = create m_po_inquiry
end on

on w_po_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_delete;call super::ue_delete;long		l_l_row,&
			l_l_order,&
			l_l_count
int		l_i_rtn_code
boolean	l_b_no_message
string	l_s_temp
 
l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 or NOT dw_inquiry.IsSelected ( l_l_row ) then return

l_l_order = dw_inquiry.GetItemNumber ( l_l_row, "po_number" )

 SELECT count(po_number)
 	INTO :l_l_count
   FROM po_detail  
  WHERE po_number = :l_l_order ;

If l_l_count > 0 Then
		MessageBox ( "Error", "You can not delete an po with active releases!", StopSign! )
		Return
else	
		l_b_no_message = True
end if

if Not l_b_no_message then
	l_i_rtn_code = 2
else
	l_i_rtn_code = MessageBox ( "Delete", "Do you really want to delete po# " + String ( l_l_order ) + "?", Question!, YesNo!, 2 )
end if

If l_i_rtn_code = 1 Then

	l_s_temp = String ( l_l_order )

	gnv_App.of_GetFrame().SetMicroHelp ( "Deleting Records..." )

   DELETE FROM po_detail  
	    WHERE ( po_number = :l_l_order ) ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if
	
	DELETE FROM po_detail_history
	 WHERE ( po_number = :l_l_order ) ;

 	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if
	 
   DELETE FROM po_header 
	      WHERE po_number = :l_l_order   ;
	
	If SQLCA.SQLCode = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

	If dw_inquiry.DeleteRow ( l_l_row ) = -1 Then
		RollBack ;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		Return
	End if

	Commit ;

   dw_inquiry.retrieve()

	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )

End if

dw_inquiry.SetRow ( 1 )
dw_inquiry.SetFocus ( )

end event

event ue_add;call super::ue_add;open(w_add_po_type)
end event

type st_1 from w_inquiry_ancestor`st_1 within w_po_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_po_inquiry
string dataobject = "d_po_inquiry"
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;call super::doubleclicked;string	l_s_type
Long 	   l_l_po_number

dw_inquiry.DBcancel()

if row < 1 then return

l_l_po_number = GetItemNumber ( row, "po_number" )
i_l_po_number = l_l_po_number
l_s_type		  = GetItemString ( row, "type" )

If l_s_type = 'B' then
	OpenSheetWithParm ( w_blanket_po_entry, l_l_po_number, gnv_App.of_GetFrame(), 3, Original! )
else
	OpenSheetWithParm ( w_normal_po_entry, l_l_po_number, gnv_App.of_GetFrame(), 3, Original! )
end if
end event

event dw_inquiry::clicked;call super::clicked;//Long 	   l_l_po_number
//
//dw_inquiry.DBcancel()

if row < 1 then return

i_l_po_number = GetItemNumber ( row, "po_number" )


end event

