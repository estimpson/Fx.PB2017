$PBExportHeader$w_location_form.srw
forward
global type w_location_form from w_sheet_4t
end type
type dw_1 from datawindow within w_location_form
end type
type gb_1 from groupbox within w_location_form
end type
end forward

global type w_location_form from w_sheet_4t
integer height = 1560
string title = "Location Setup"
string menuname = "m_location_setup"
event save_item pbm_custom01
event ue_exit pbm_custom02
event ue_new pbm_custom03
dw_1 dw_1
gb_1 gb_1
end type
global w_location_form w_location_form

type variables
st_generic_structure stParm

String cPlantRequired,&
          is_location

Boolean	ib_save_change = TRUE, &
	ib_save = FALSE, &
	ib_plant




end variables

forward prototypes
public subroutine wf_save ()
end prototypes

event save_item;String szLoc, szLocDesc, szMachine

If cPlantRequired = 'Y' Then
	If f_get_string_value ( dw_1.GetItemString ( 1, "plant" ) ) = "" Then
		MessageBox ( "ERROR", "Plant is required!  Save failed." )
		dw_1.SetColumn ( "plant" )
		dw_1.SetFocus ( )
		ib_plant = false
		Return
	Else
		ib_plant = True
		
	End if
Else 
	ib_plant = TRUE	
	
End if

If dw_1.Update ( ) = -1 Then
	RollBack ;
	Return
Else
   Commit ;
	ib_save_change=TRUE	
	ib_save = TRUE
End if

If dw_1.GetItemString ( 1, "type" ) = "MC" Then  

	szLoc = dw_1.GetItemString ( 1, "code" )
	szLocDesc = dw_1.GetItemString ( 1, "name" )

   SELECT machine_no
     INTO :szMachine  
     FROM machine
    WHERE machine_no = :szLoc   ;

	If SQLCA.SQLCode = 100  OR SQLCA.SQLCode = -1 Then

	   INSERT INTO machine
		          ( machine_no,   
		            mach_descp,   
		            status,   
		            cell )  
		   VALUES ( :szLoc,   
		            :szLocDesc,   
		            null,   
		            null )  ;
 
		If SQLCA.SQLCode <> 0 Then
			MessageBox ( "Error", "Unable to save machine record!", Information! )
			RollBack ;
      Else

			INSERT INTO machine_policy
					    ( Machine,   
			            job_change,   
			            schedule_queue,   
			            start_stop_login,   
				         process_control,   
           				access_inventory_control,   
			            material_substitution,   
			            change_std_pack,   
			            change_packaging,   
			            change_unit,   
			            job_completion_delete,   
			            material_issue_delete,   
			            defects_delete,   
			            downtime_delete,   
			            smallest_downtime_increment,   
			            downtime_histogram_days,   
			            work_order_display_window,   
			            packaging_line,   
			            operator_required )  
			   VALUES ( :szLoc,   
			            'N',   
			            'H',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
			            'N',   
          			   'N',   
			            0,   
			            0,   
			            '',   
			            'N',   
			            'N' )  ;

			If SQLCA.SQLCode <> 0 Then
				MessageBox ( "Error", "Unable to save machine policy record!", Information! )
				RollBack ;
		   Else
				Commit ;
				
			End If
     End If
	  
	ELSE	
	    Update machine
		 Set mach_descp = :szLocdesc
		 Where machine_no = :szLoc;  
		 
	If SQLCA.SQLCode <> 0 Then
		MessageBox ("Error",SQLCA.SQLErrText, Information!)
		RollBack;
	Else
		Commit;
		ib_save_change = True	
		ib_save = True
	End if
	
   End if
End if

If dw_1.GetItemString ( 1, "type" ) <> "MC" Then
		
	szLoc = dw_1.GetItemString ( 1, "code" )
	szLocDesc = dw_1.GetItemString ( 1, "name" )

   SELECT machine.machine_no  
     INTO :szMachine  
     FROM machine  
    WHERE machine.machine_no = :szLoc   ;

	If SQLCA.SQLCode = 0 then

	     DELETE FROM machine  
		  WHERE  machine_no = :szLoc   ;
		  
		  DELETE FROM machine_policy  
		  WHERE  machine = :szLoc   ;									//included on 7/18/00-sm 

 
		If SQLCA.SQLCode <> 0 Then
			MessageBox ( "Error", SQLCA.SQLErrText, Information! )
			RollBack ;
		End if

			Commit ;
	
	End if

End if
end event

event ue_new;dw_1.Modify("code.TabSequence=10")
ib_save_change = TRUE
wf_save()
dw_1.Reset ( )
dw_1.InsertRow ( 0 )
dw_1.SetFocus ( )

end event

public subroutine wf_save ();long ll_row

integer il_mess1

If ib_save_change THEN
	IF is_location = "" THEN
		dw_1.AcceptText ( )
		dw_1.SetColumn("code")
		is_location = dw_1.GetText() 
	END IF
	IF is_location = "" THEN Return
	il_mess1=Messagebox ( Monsys.msg_title, " Do you want save changes to " + is_location + "'s standard information?", Question!, YesNo!, 1 )
	If  il_mess1 = 1 Then
		If	dw_1.update () = 1 Then
			COMMIT ;
			dw_1.Retrieve (is_location)
			ll_Row = dw_1.Find ( "code = '" + is_location + "'", 1, dw_1.RowCount ( ) )
			dw_1.ScrollToRow ( ll_Row )
			ib_save_change= FALSE
		ELSE
			ROLLBACK;
			MessageBox (Monsys.msg_title, "Invalid Data!, Changes could not be saved" )
			RETURN
		END IF
	End If
End If
end subroutine

event open;call super::open;String 	szRtnCode,&
			l_s_location

dw_1.SetTransObject ( sqlca )

stParm = Message.PowerObjectParm

SELECT parameters.plant_required  
  INTO :cPlantRequired  
  FROM parameters  ;

If cPlantRequired = 'Y' Then
	szRtnCode = dw_1.Modify ( "plant.dddw.Required=Yes" )
End if

l_s_location = f_get_string_value ( Message.StringParm )

if l_s_location = '' then
	dw_1.InsertRow ( 0 )
	dw_1.SetFocus ( )
	Return
else
	dw_1.Retrieve ( l_s_location )
End if


end event

on w_location_form.create
int iCurrent
call super::create
if this.MenuName = "m_location_setup" then this.MenuID = create m_location_setup
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
end on

on w_location_form.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event close;call super::close;integer 	imess1,&
			l_i_return_value = 0
			
If NOT ib_save_change Then
	imess1 = Messagebox ( "Warning", "Do you want to save the changes?", Exclamation!, YesNoCancel!,1)
	If imess1 = 1 Then
		TriggerEvent ( "save_item" )
		If ib_plant = False Then Return -1
		ib_save = TRUE
	Elseif imess1 = 2 Then
		ib_save_change = True
		ib_save = False
	Else
		Return -1
	End If
End If

//If ib_save Then
//	ib_save = FALSE
////	w_location_inquiry.Post Event ue_refresh ( )
//End If

Return 0
end event

type dw_1 from datawindow within w_location_form
integer x = 73
integer y = 64
integer width = 1317
integer height = 992
integer taborder = 10
string dataobject = "d_location_setup_form"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Long lColumn

String szLoc, szTempLoc

ib_save_change = FALSE

lColumn = dw_1.GetColumn ( )

If lColumn = 1 Then

	szLoc = dw_1.GetText ( ) //ItemString ( 1, "code" )

//	gnv_App.of_GetFrame().SetMicroHelp ( szLoc )

  SELECT location.code  
  	 INTO :szTempLoc  
    FROM location  
   WHERE location.code = :szLoc   ;

	If SQLCA.SQLCode = 0 Then
		dw_1.Retrieve ( szLoc )
		dw_1.Modify("code.TabSequence =0")
	End if
		
End if
end event

on editchanged;ib_save_change = FALSE
end on

event itemerror;//dw_1.SetActionCode (1)
return 1
end event

type gb_1 from groupbox within w_location_form
integer x = 37
integer width = 1390
integer height = 1184
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Location Information:"
end type

