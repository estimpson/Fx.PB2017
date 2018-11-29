$PBExportHeader$u_router_explorer.sru
forward
global type u_router_explorer from u_explorer_ancestor
end type
type dw_2 from datawindow within u_router_explorer
end type
end forward

global type u_router_explorer from u_explorer_ancestor
integer width = 3515
integer height = 1100
event type integer ue_change_display ( integer a_i_mode )
event type integer ue_clicked_popup ( string a_s_item )
event type integer ue_maint_mode ( integer a_i_mode )
event ue_refresh ( )
event ue_save_router ( )
event ue_print_router ( )
event ue_fast_copy ( string as_part )
event ue_setup_parts ( )
dw_2 dw_2
end type
global u_router_explorer u_router_explorer

type variables
STRING		i_s_part
INT		i_i_bom_mode = 0
DATETIME	i_d_bom_date
BOOLEAN	i_b_router_maint
LONG		i_l_clicked_tv_row,&
		i_l_right_clicked_tv_row
WINDOW	i_w_parent,&
		i_w_mdi_frame
end variables

forward prototypes
public function integer of_check_for_orphans ()
public function integer of_retrieve_datastore (string a_s_part)
public function integer of_build_treeview ()
end prototypes

event ue_change_display;call super::ue_change_display;IF i_i_bom_mode <> a_i_mode THEN
	i_i_bom_mode = a_i_mode
	
	IF i_i_bom_mode = 3 THEN
		OpenWithParm ( w_bom_display_date, String ( i_d_bom_date ) )
		IF isnull ( Message.StringParm, '' ) > '' THEN 
			i_d_bom_date = DateTime ( Date ( Message.StringParm ), Time ( "00:00.0000" ) )
		ELSE
			Return 0
		END IF
	END IF
	
	of_retrieve_datastore ( i_s_part )
	
END IF

Return 1
end event

event type integer ue_clicked_popup(string a_s_item);//	Declare local variables
st_generic_structure	l_str_parm
STRING					l_s_part,&
							l_s_parent_part,&
							l_s_temp,&
							l_s_message,&
							l_s_machine,&
							l_s_tool,&
							l_s_activity,&
							l_s_parent_parent
DATETIME					l_dt_start,&
							rightNow
INT						l_i_count
LONG						ll_sequence

//	a_s_item contains Popup Menu Item (Text) that was chosen
// Based on that, take appropriate action
Choose Case a_s_item
	Case "Where Used Report"
		l_s_part = i_ds_treeview.object.part[i_l_right_clicked_tv_row]
		OpenWithParm ( w_where_used_report, l_s_part )
	Case "Cost"
	Case "Edit Machine","Edit Vendor"
		l_str_parm.value1		= i_ds_treeview.object.parent_item[i_l_right_clicked_tv_row]
		l_str_parm.value2		= i_ds_treeview.object.item[i_l_right_clicked_tv_row]
		l_str_parm.value3		= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
		OpenWithParm ( w_machine_activity_maint, l_str_parm )
		of_retrieve_datastore ( i_s_part )
	Case "Delete Machine"
//		l_s_part			= i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
//    the above was changed to part from parent_part 
		l_s_part			= i_ds_treeview.object.part[i_l_right_clicked_tv_row]		
		l_s_machine		= i_ds_treeview.object.item[i_l_right_clicked_tv_row]
		l_s_activity	= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
		IF MessageBox ( "Router Maintenance", "Are you sure about deleting machine for activity " + l_s_activity + "?", Question!, YesNo!, 2 ) = 1 THEN
			DELETE FROM part_machine
			WHERE part = :l_s_part AND
					machine = :l_s_machine AND
					activity = :l_s_activity ;
			IF sqlca.sqlcode <> 0 THEN
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete machine.  Reason: " + l_s_message, StopSign! )
				return 1
			END IF
			SELECT	count(*)
			INTO		:l_i_count
			FROM		part_machine_tool
			WHERE		part = :l_s_part AND
						machine = :l_s_machine ;
			IF l_i_count > 0 THEN
				IF MessageBox ( "Router Maintenance", "Do you also want to delete tool(s) for part " + l_s_part + " and machine " + l_s_machine + "?", Question!, YesNo!, 2 ) = 1 THEN 
					DELETE FROM	part_machine_tool
					WHERE			part 		= :l_s_part AND
									machine	= :l_s_machine ;
					IF sqlca.sqlcode = 0 THEN
						Commit;
						of_retrieve_datastore ( i_s_part )
					ELSE
						l_s_message = sqlca.sqlerrtext
						Rollback;
						MessageBox ( "Router Maintenance", "Unable to delete Tool.  Reason: " + l_s_message, StopSign! )
						return 1
					END IF
				ELSE
					Commit;
					of_retrieve_datastore ( i_s_part )
				END IF
			ELSE
				Commit;
				of_retrieve_datastore ( i_s_part )
			END IF
		END IF
	Case "Delete Vendor"
		// changed from parent part to part, fix issue with deleting vendor - SM 10/21/99
   	l_s_part			= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
		l_s_machine		= i_ds_treeview.object.item[i_l_right_clicked_tv_row]
		l_s_activity	= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
		IF MessageBox ( "Router Maintenance", "Are you sure about deleting vendor for outside process " + l_s_activity + "?", Question!, YesNo!, 2 ) = 1 THEN
			DELETE FROM part_machine
			WHERE part = :l_s_part AND
					machine = :l_s_machine AND
					activity = :l_s_activity ;
			IF sqlca.sqlcode <> 0 THEN
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete vendor.  Reason: " + l_s_message, StopSign! )
				return 1
			ELSE
				Commit;
				of_retrieve_datastore ( i_s_part )
			END IF
		END IF
	Case "Edit Activity","Edit Outside Process"
		CHOOSE CASE RightA(i_ds_treeview.object.item_type[i_l_right_clicked_tv_row],1)
			CASE "1"
				l_str_parm.value1		= i_s_part
				l_str_parm.value2		= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
				l_str_parm.value3		= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
				OpenWithParm ( w_activity_router_maint, l_str_parm )
				of_retrieve_datastore ( i_s_part )
			CASE "2"
				l_str_parm.value1		= i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
				l_str_parm.value2		= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
				l_str_parm.value3		= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
				OpenWithParm ( w_activity_router_maint, l_str_parm )
				of_retrieve_datastore ( i_s_part )
			CASE "3"
				l_str_parm.value1		= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
				l_str_parm.value2		= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
				l_str_parm.value3		= i_ds_treeview.object.activity[i_l_right_clicked_tv_row]
				OpenWithParm ( w_activity_router_maint, l_str_parm )
				of_retrieve_datastore ( i_s_part )
		END CHOOSE
	Case "Edit BOM Component"
		l_str_parm.value1		= i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
		l_str_parm.value2		= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
		l_str_parm.value3		= String ( i_ds_treeview.GetItemDateTime ( i_l_right_clicked_tv_row, "start_datetime" ), "yyyy/mm/dd hh:mm:ss.ffffff" ) //, "yyyy/mm/dd hh:mm" )
		OpenWithParm ( w_bom_edit_add, l_str_parm )
		of_retrieve_datastore ( i_s_part )
	Case "Delete BOM Component"
		l_s_part 			= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
		l_s_parent_part 	= i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
		l_s_activity		= i_ds_treeview.object.activity[i_ds_treeview.object.parent_row[i_l_right_clicked_tv_row]]
		l_dt_start			= i_ds_treeview.GetItemDateTime ( i_l_right_clicked_tv_row, "start_datetime" )
		IF MessageBox ( "Router Maintenance", "Are you sure about deleting component " + l_s_part + " from bill of material?", Question!, YesNo!, 2 ) = 1 THEN
			DELETE FROM	bill_of_material_ec
			WHERE			parent_part 	= :l_s_parent_part AND
							part				= :l_s_part AND
							start_datetime	= :l_dt_start ;
			IF sqlca.sqlcode = 0 THEN
				select
					dt.rightNow
				into
					:rightNow
				from
					(	select
							rightNow = getdate()
					) dt ;
				
				SELECT	count(*)
				INTO		:l_i_count
				FROM		bill_of_material_ec
				WHERE		parent_part = :l_s_parent_part and
							( end_datetime > :rightNow or 
							end_datetime is null );
				IF l_i_count < 1 THEN
					SELECT	count(*)
					INTO		:l_i_count
					FROM		activity_router
					WHERE		part = :l_s_parent_part and 

								code = :l_s_activity ;
					IF l_i_count > 0 THEN
						CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[i_ds_treeview.object.parent_row[i_l_right_clicked_tv_row]], 1 )
							CASE "A","O"
								DELETE FROM activity_router
								WHERE part = :l_s_parent_part and
										code = :l_s_activity ;
						END CHOOSE
						IF sqlca.sqlcode = 0 THEN
							DELETE FROM part_machine
							WHERE part = :l_s_parent_part and
									activity = :l_s_activity ; 
							IF sqlca.sqlcode <> 0 THEN
								l_s_message = sqlca.sqlerrtext
								Rollback;
								MessageBox ( "Router Maintenance", "Unable to delete machine.  Reason: " + l_s_message, StopSign! )
								return 1
							END IF
							SELECT	count(*)
							INTO		:l_i_count
							FROM		part_machine_tool
							WHERE		part = :l_s_parent_part ;
							IF l_i_count > 0 THEN
								DELETE FROM	part_machine_tool
								WHERE			part 		= :l_s_part ;
								IF sqlca.sqlcode = 0 THEN
									Commit;
									of_retrieve_datastore ( i_s_part )
								ELSE
									l_s_message = sqlca.sqlerrtext
									Rollback;
									MessageBox ( "Router Maintenance", "Unable to delete Tool.  Reason: " + l_s_message, StopSign! )
									return 1
								END IF
							ELSE
								Commit;
								of_retrieve_datastore ( i_s_part )
							END IF
						ELSE
							l_s_message = sqlca.sqlerrtext
							Rollback;
							MessageBox ( "Router Maintenance", "Unable to delete BOM Component.  Reason: " + l_s_message, StopSign! )
						END IF
					ELSE
						Commit;
						of_retrieve_datastore ( i_s_part )
					END IF
				ELSE
					// delete activity if there is one
					CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[i_ds_treeview.object.parent_row[i_l_right_clicked_tv_row]], 1 )
						CASE "A","O"
							CHOOSE CASE RightA(i_ds_treeview.object.item_type[i_l_right_clicked_tv_row],1)
								CASE "1"
									ll_sequence = i_ds_treeview.object.sequence[i_l_right_clicked_tv_row]
									DELETE FROM activity_router
									WHERE parent_part = :l_s_parent_part and
											sequence <= :ll_sequence	;
							END CHOOSE
					END CHOOSE
					IF sqlca.sqlcode = 0 THEN
						Commit;
					ELSE
						l_s_message = sqlca.sqlerrtext
						Rollback;
						MessageBox ( "Router Maintenance", "Unable to delete BOM Component.  Reason: " + l_s_message, StopSign! )
					END IF
					of_retrieve_datastore ( i_s_part )
				END IF
				
			ELSE
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete BOM Component.  Reason: " + l_s_message, StopSign! )
			END IF
		END IF
	Case "Edit Tool"
		l_str_parm.value1 = i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
		l_str_parm.value2 = i_ds_treeview.object.item[i_ds_treeview.object.parent_row[i_l_right_clicked_tv_row]]
		l_str_parm.value3 = i_ds_treeview.object.item[i_l_right_clicked_tv_row]
		OpenWithParm ( w_part_machine_tool_setup, l_str_parm )
		of_retrieve_datastore ( i_s_part )
	Case "Delete Tool"
		l_s_part 	= i_ds_treeview.object.part[i_l_right_clicked_tv_row]
		l_s_machine	= i_ds_treeview.object.item[i_ds_treeview.object.parent_row[i_l_right_clicked_tv_row]]
		l_s_tool		= i_ds_treeview.object.item[i_l_right_clicked_tv_row]
		IF MessageBox ( "Router Maintenance", "Are you sure about deleting tool " + l_s_tool + "?", Question!, YesNo!, 2 ) = 1 THEN
			DELETE FROM	part_machine_tool
			WHERE			part 		= :l_s_part AND

							machine	= :l_s_machine AND
							tool		= :l_s_tool ;
			IF sqlca.sqlcode = 0 THEN
				Commit;
				of_retrieve_datastore ( i_s_part )
			ELSE
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete Tool.  Reason: " + l_s_message, StopSign! )
				return 1
			END IF
		END IF
	CASE "Delete Activity","Delete Outside Process"
		l_s_parent_part 	= i_ds_treeview.object.parent_part[i_l_right_clicked_tv_row]
		l_s_part 	      = i_ds_treeview.object.part[i_l_right_clicked_tv_row]		
		ll_sequence			= i_ds_treeview.object.sequence[i_l_right_clicked_tv_row]
// machines associated with that activity needs to be deleted, but as the trigger is there
// currently I am unable to do that, I will have to alter the trigger to handle this situation
   	IF MessageBox ( "Router Maintenance", "Are you sure about deleting this activity from the top level part?", Question!, YesNo!, 2 ) = 1 THEN
			DELETE FROM activity_router
			WHERE parent_part = :l_s_part and  // l_s_parent_part and
					sequence <= :ll_sequence	;
			IF sqlca.sqlcode = 0 THEN
				Commit;				
				of_retrieve_datastore ( i_s_part )
			ELSE
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete activity.  Reason: " + l_s_message, StopSign! )
				return 1
			END IF
		END IF
End Choose
return 0



end event

event ue_maint_mode;IF IsValid ( w_popup_part_list ) THEN &
	Close ( w_popup_part_list )
IF IsValid ( w_popup_machine_list ) THEN &
	Close ( w_popup_machine_list )
IF IsValid ( w_popup_activity_list ) THEN &
	Close ( w_popup_activity_list )
IF IsValid ( w_popup_tool_list ) THEN &
	Close ( w_popup_tool_list )
IF IsValid ( w_popup_vendor_list ) THEN &
	Close ( w_popup_vendor_list )

IF i_b_router_maint THEN
	i_b_router_maint = FALSE
	Post Event ue_refresh ( )
END IF

CHOOSE CASE a_i_mode
	CASE 1
		Open ( w_popup_part_list )
	CASE 2
		Open ( w_popup_activity_list )
	CASE 3
		Open ( w_popup_machine_list )
	CASE 4
		i_b_router_maint = TRUE
//		DELETE FROM activity_router
//		WHERE parent_part = :i_s_part AND
//				part <> :i_s_part ;
//		IF sqlca.sqlcode <> 0 THEN
//			rollback;
//			MessageBox ( i_w_parent.Title, "Unable to delete existing router records.  Please see your system administrator!", StopSign! )
//			return 0
//		ELSE
//			commit;
//		END IF
		Post Event ue_refresh ( )
	CASE 5
		Open ( w_popup_vendor_list )
	CASE 6
		Open ( w_popup_tool_list )
	END CHOOSE

//Post Event ue_refresh ( )

return 1
end event

event ue_refresh;call super::ue_refresh;INT	l_i_count
LONG  l_l_rowcount

l_l_rowcount = i_ds_treeview.RowCount ( )

IF i_b_router_maint THEN
	FOR l_i_count = 1 to l_l_rowcount
		i_ds_treeview.object.item_handle[l_i_count] = 0
		i_ds_treeview.object.expanded[l_i_count] = 0
	NEXT
ELSE
	FOR l_i_count = 1 to l_l_rowcount
		i_ds_treeview.object.item_handle[l_i_count] = 0
		i_ds_treeview.object.expanded[l_i_count] = 1
	NEXT
END IF

of_build_treeview ( )

end event

event ue_save_router;// Declare local variables
LONG		l_l_row,&
			l_l_rowcount
INT		l_i_end_seq,&
			l_i_count,&
			l_i_sequence
STRING	l_s_part,&
			l_s_current_parent,&
			l_s_current_part,&
			l_s_parent_part,&
			l_s_code,&
			l_s_notes,&
			l_s_labor,&
			l_s_material,&
			l_s_cost_bill,&
			l_s_group_location,&
			l_s_process,&
			l_s_doc1,&
			l_s_doc2,&
			l_s_doc3,&
			l_s_doc4,&
			l_s_dw_parent,&
			l_s_dw_part,&
			l_s_item_type
BOOLEAN	l_b_error
DEC		l_n_cost,&
			l_n_price,&
			l_n_cost_price_factor
DATETIME	l_dt_time_stamp

// Show status
IF IsValid ( i_w_mdi_frame ) THEN &
	i_w_mdi_frame.SetMicroHelp ( "Saving flow router for " + i_s_part + "..." )

//Delete all current activity_router records for top level part
DELETE FROM activity_router
WHERE parent_part = :i_s_part AND
		part <> :i_s_part ;

IF sqlca.sqlcode = 0 THEN
	
	// Loop through datastore and get last sequence
	l_l_rowcount = i_ds_treeview.RowCount ( )
	FOR l_l_row = 1 TO l_l_rowcount
		IF ( LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "A" OR &
			LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "O" ) AND &
			i_ds_treeview.object.expanded[l_l_row] = 1 THEN
			IF RightA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "1" AND &
				i_ds_treeview.object.part[l_l_row] <> i_s_part THEN
				IF i_ds_treeview.object.parent_part[l_l_row] = i_ds_treeview.object.part[l_l_row] THEN
					i_ds_treeview.object.item_type[l_l_row] = LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) + "3"
				ELSE
					i_ds_treeview.object.item_type[l_l_row] = LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) + "2"
				END IF
			END IF
			l_i_end_seq++
		END IF
	NEXT	
	
	IF l_i_end_seq > 0 THEN
				
		// Loop through datastore and build router for each expanded activity
		FOR l_l_row = 1 TO l_l_rowcount
			l_s_dw_parent = i_ds_treeview.object.parent_part[l_l_row]
			l_s_dw_part = i_ds_treeview.object.part[l_l_row]
			l_s_item_type = i_ds_treeview.object.item_type[l_l_row]
			
//			IF l_s_dw_parent = l_s_dw_part and l_s_dw_parent <> i_s_part THEN
//				i_ds_treeview.object.item_type[l_l_row] = "A3"
//			END IF
			
			IF ( LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "A" OR &
				LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "O" ) AND &
				i_ds_treeview.object.expanded[l_l_row] = 1 THEN
	
				SELECT	Count (*)
				INTO		:l_i_count
				FROM		activity_router
				WHERE		parent_part = :i_s_part AND
							part = :l_s_dw_part ;
							
				IF l_i_count > 0 THEN
					UPDATE 	activity_router
					SET		sequence = :l_i_end_seq
					WHERE		parent_part = :i_s_part AND
								part = :l_s_dw_part ;
				ELSE
					l_i_end_seq --
					
					CHOOSE CASE RightA ( i_ds_treeview.object.item_type[l_l_row], 1 )
						CASE "2"
							l_s_current_parent = l_s_dw_parent
							l_s_current_part = l_s_dw_part
						CASE "3"		
							l_s_current_parent = l_s_dw_part
							l_s_current_part = l_s_dw_part
					END CHOOSE
				
					SELECT	min(parent_part)
					INTO		:l_s_current_parent
					FROM		activity_router 
					WHERE		part = :l_s_current_part ;
					
					SELECT	code,   
								part,   
								notes,   
								labor,   
								material,   
								cost_bill,   
								group_location,   
								process,   
								doc1,   
								doc2,   
								doc3,   
								doc4,   
								cost,   
								price,   
								cost_price_factor,
								time_stamp
					INTO		:l_s_code,   
								:l_s_part,   
								:l_s_notes,   
								:l_s_labor,   
								:l_s_material,   
								:l_s_cost_bill,   
								:l_s_group_location,   
								:l_s_process,   
								:l_s_doc1,   
								:l_s_doc2,   
								:l_s_doc3,   
								:l_s_doc4,   
								:l_n_cost,   
								:l_n_price,   
								:l_n_cost_price_factor,
								:l_dt_time_stamp
					FROM		activity_router
					WHERE		parent_part = :l_s_current_parent AND 
								part = :l_s_current_part ;
	
					IF sqlca.sqlcode = 0 THEN
						INSERT INTO activity_router  
								( 	parent_part,   
									sequence,   
									code,   
									part,   
									notes,   
									labor,   
									material,   
									cost_bill,   
									group_location,   
									process,   
									doc1,   
									doc2,   
									doc3,   
									doc4,   
									cost,   
									price,   
									cost_price_factor,
									time_stamp )  
						VALUES (	:i_s_part,   
									:l_i_end_seq,   
									:l_s_code,   
									:l_s_part,   
									:l_s_notes,   
									:l_s_labor,   
									:l_s_material,   
									:l_s_cost_bill,   
									:l_s_group_location,   
									:l_s_process,   
									:l_s_doc1,   
									:l_s_doc2,   
									:l_s_doc3,   
									:l_s_doc4,   
									:l_n_cost,   
									:l_n_price,   
									:l_n_cost_price_factor,
									:l_dt_time_stamp ) ;
					END IF
				END IF
				
				IF sqlca.sqlcode = -1 THEN
					l_b_error = TRUE
					rollback;
					MessageBox ( "Router Maintenance", "Unable to save flow router for " + i_s_part + ".  Insert Failes", StopSign! )
					EXIT
				END IF
			END IF
		NEXT	
		IF NOT l_b_error THEN
			commit;
		END IF
	END IF
ELSE
	rollback;
	MessageBox ( "Router Maintenance", "Unable to save flow router for " + i_s_part + ".  Delete Failed", StopSign! )
END IF

i_b_router_maint = FALSE

of_retrieve_datastore ( i_s_part )
end event

event ue_print_router;treeviewitem ltv_item
//sm
long ll_item, &
	  ll_row,&
	  ll_item_level,&	
	  ll_pictureindex

string ls_part
		
		 
dw_2.reset()
ll_item = tv_1.finditem(roottreeitem!,0)
ll_row = 0

do while ll_item > 0
	tv_1.getitem(ll_item,ltv_item)
	
	ls_part = ltv_item.label
	ll_item_level = ltv_item.level
	ll_pictureindex = ltv_item.pictureindex
	
	ll_row++
	dw_2.insertrow(0)
	
	dw_2.setitem(ll_row,'Part',ls_part)	
	dw_2.setitem(ll_row,'level',(ll_item_level*50))						//changed the level from 60 to 50  SM 4/12/00
	dw_2.setitem(ll_row,'picture',ll_pictureindex)
	
	ll_item = tv_1.finditem(nextvisibletreeitem!,ll_item)	
	
loop 

dw_2.print()




//String l_s_type,l_s_label,l_s_part, &
//		 l_s_parent_item, l_s_temp
//
//Integer l_i_count, &
//		  l_i_level, &
//		  l_i_row, &
//		  l_i_max_level,&
//		  l_i_row_count
//
//dw_2.Reset()
//l_i_row = 0
//
//datastore l_ds_treeview
//l_ds_treeview = i_ds_treeview
//
//l_ds_treeview.SetSort('item_level A,item_type_number A, Part A')
//l_ds_treeview.Sort()
//
//If l_ds_treeview.rowcount() > 0 THEN
//	
//	l_i_max_level	= l_ds_treeview.object.item_level [ l_ds_treeview.rowcount() ]
//	
//	for l_i_count = 1 to l_i_max_level
//	
//		l_s_temp = "item_level="+string (l_i_count)
//		l_ds_treeview.SetFilter (l_s_temp)
//		l_ds_treeview.Filter()
//		
//		FOR l_i_row_count = l_ds_treeview.rowcount() to 1 step -1 
//			
//			l_s_type = l_ds_treeview.GetItemString(l_i_row_count, "item_type" ) 
//			l_s_part = l_ds_treeview.GetItemString(l_i_row_count, "part")
//			l_i_level = l_ds_treeview.GetItemNumber(l_i_row_count, "item_level")		
//			l_s_label = l_ds_treeview.GetItemString(l_i_row_count, "item_label" ) 
//			l_s_parent_item = l_ds_treeview.GetItemString(l_i_row_count, "parent_item" ) 
//			
//			l_s_temp =  "part='"+l_s_parent_item+"'"
//			l_i_row = dw_2.Find ( "part='"+l_s_parent_item+"'", 1, dw_2.rowcount() ) 			
//			
//	IF l_i_row <= 0 THEN 
//		l_i_row = dw_2.InsertRow(0)
//	ELSE
//		l_i_row = l_i_row + 1
//		dw_2.InsertRow(l_i_row)
//	END IF
//
//	dw_2.SetItem(l_i_row,1,l_s_type)	
//	dw_2.SetItem(l_i_row,2,l_s_label)
//	dw_2.SetItem(l_i_row,3,l_i_level)
//	dw_2.SetItem(l_i_row,4,l_s_part)
//	dw_2.setitem(l_i_row,5,l_s_parent_item )
//	l_i_row = 0
//			
//  NEXT
//  l_ds_treeview.SetFilter( "" )
//  l_ds_treeview.Filter ()
//		
// NEXT
//	
//END IF
//
//dw_2.print()
//  
//
end event

event ue_fast_copy(string as_part);//declare local variables
long  ll_row, &
		ll_count

string ls_tdy

datastore l_ds_activity 
datastore l_ds_activity1
datastore l_ds_bom
datastore l_ds_bom1
datastore l_ds_part_machine
datastore l_ds_part_machine1
datastore l_ds_part_machine_tool
datastore l_ds_part_machine_tool1

l_ds_activity = create datastore
l_ds_activity.dataobject = 'd_activity'
l_ds_activity.settransobject(sqlca)

l_ds_activity1 = create datastore
l_ds_activity1.dataobject = 'd_activity'
l_ds_activity1.settransobject(sqlca)

l_ds_bom = create datastore
l_ds_bom.dataobject = 'd_bill_of_material'
l_ds_bom.settransobject(sqlca)

l_ds_bom1 = create datastore
l_ds_bom1.dataobject = 'd_bill_of_material'
l_ds_bom1.settransobject(sqlca)

l_ds_part_machine = create datastore
l_ds_part_machine.dataobject = 'd_router_part_machine'
l_ds_part_machine.settransobject(sqlca)

l_ds_part_machine1 = create datastore
l_ds_part_machine1.dataobject = 'd_router_part_machine'
l_ds_part_machine1.settransobject(sqlca)

l_ds_part_machine_tool = create datastore
l_ds_part_machine_tool.dataobject = 'd_part_machine_tool'
l_ds_part_machine_tool.settransobject(sqlca)

l_ds_part_machine_tool1 = create datastore
l_ds_part_machine_tool1.dataobject = 'd_part_machine_tool'
l_ds_part_machine_tool1.settransobject(sqlca)

datetime rightNow
select
	dt.rightNow
into
	:rightNow
from
	(	select
			rightNow = getdate()
	) dt ;

ls_tdy = string(rightNow)

// check if a part is selected
if as_part > '' then
	
	// retrieve activity router rows for i_s_part 
	ll_row = l_ds_activity.retrieve(i_s_part)	
	l_ds_activity.rowscopy(1, l_ds_activity.rowcount(), Primary!,l_ds_activity1,1, primary!)
	
	// set parent part on the copied rows to as_part 
	for ll_Count  = 1 to l_ds_activity1.rowcount() 
		l_ds_activity1.setitem(ll_count, 'parent_part', as_part)
		l_ds_activity1.setitem(ll_count, 'part', as_part)
	next
	
	// update rows for as_part to activity_router
	if l_ds_activity1.update() > 0 then
		
		// retrieve bill of material rows for i_s_part 
		 ll_row = l_ds_bom.retrieve(i_s_part)		 
		 l_ds_bom.rowscopy(1, l_ds_bom.rowcount(), Primary!,l_ds_bom1,1, primary!)
		 
   // set parent part on the copied rows to as_part 
		for ll_Count  = 1 to l_ds_bom1.rowcount() 
			l_ds_bom1.setitem(ll_count, 'parent_part', as_part)
			l_ds_bom1.setitem(ll_count, 'date_changed', string(rightNow))
		next
	// update rows for as_part to bill_of_material_ec
		 if l_ds_bom1.update() > 0 then

        //retrieve part machine rows for i_s_part
	      ll_row = l_ds_part_machine.retrieve(i_s_part)			
      	l_ds_part_machine.rowscopy(1, l_ds_part_machine.rowcount(), Primary!,l_ds_part_machine1,1, primary!)

         //set parent part on the copied rows to as_part
			for ll_Count  = 1 to l_ds_part_machine1.rowcount() 
				l_ds_part_machine1.setitem(ll_count, 'part', as_part)
			next
	      //update rows for as_part to part_machine
   	   if l_ds_part_machine1.update() > 0 then
				
				
	  	      //retrieve part machine tool rows for i_s_part
		      ll_row = l_ds_part_machine_tool.retrieve(i_s_part)            
		      l_ds_part_machine_tool.rowscopy(1, l_ds_part_machine_tool.rowcount() , Primary!,l_ds_part_machine_tool1,1, primary!)
      		
				//set parent part on the copied rows to as_part
				for ll_Count  = 1 to l_ds_part_machine_tool1.rowcount() 
				 	l_ds_part_machine_tool1.setitem(ll_count, 'part', as_part)
				next
				
				//update rows for as_part to part_machine_tool
		      if l_ds_part_machine_tool1.update() > 0 then

    				commit;
			      MessageBox( monsys.msg_title,"Update Successful", information!)
					
				else
					
					MessageBox(monsys.msg_title, "Update of table activity_router not successful " + sqlca.sqlerrtext , Information!)				
					rollback;
				end if
			else
				
				MessageBox(monsys.msg_title, "Update of table bill_of_material_ec not successful "  + sqlca.sqlerrtext, Information!)
				rollback;
			end if 
		else
		
			MessageBox(monsys.msg_title, "Update of table part_machine not Successful "  + sqlca.sqlerrtext, Information!)
			rollback;
		end if

	else

		rollback;
		MessageBox(monsys.msg_title, "Update of table part_machine_tool not successful "  + sqlca.sqlerrtext, Information!)
		
	end if

end if

// destroy datastore
destroy l_ds_activity
destroy l_ds_bom
destroy l_ds_part_machine
destroy l_ds_part_machine_tool

destroy l_ds_activity1
destroy l_ds_bom1
destroy l_ds_part_machine1
destroy l_ds_part_machine_tool1

// included these lines to re-retrieve this list

datawindowchild ldwc_fastcopy

dw_1.setitem ( 1, 1, '' ) 
dw_1.getchild ( 'part', ldwc_fastcopy )
ldwc_fastcopy.settransobject ( sqlca )
If ldwc_fastcopy.retrieve() > 0 then
	ldwc_fastcopy.setfilter ( "part_part<>'" + i_s_part + "'" )
	ldwc_fastcopy.filter ()
end if
ldwc_fastcopy.selectrow ( 0, false )







end event

event ue_setup_parts;datawindowchild ldwc_copy

dw_1.dataobject = "d_fast_copy" 
dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.insertrow(0)
dw_1.setfocus ()

dw_1.getchild("part", ldwc_copy)
ldwc_copy.settransobject(sqlca)

If ldwc_copy.retrieve() > 0 then
	ldwc_copy.setfilter ( "part_part<>'" + i_s_part + "'" )
	ldwc_copy.filter ()
end if
end event

public function integer of_check_for_orphans ();LONG		l_l_row_outer,&
			l_l_row_inner,&
			l_l_rowcount
BOOLEAN	l_b_found
INT		l_i_return = 1
STRING	l_s_parent_item,&
			l_s_item,&
			l_s_item_type
			
l_l_rowcount = i_ds_treeview.RowCount ( )

FOR l_l_row_outer = 1 TO l_l_rowcount
	l_b_found = FALSE
	CHOOSE CASE i_ds_treeview.object.item_type[l_l_row_outer]
		CASE "A1","A2","A3"
			l_s_item = i_ds_treeview.object.item[l_l_row_outer]
			FOR l_l_row_inner = 1 TO l_l_rowcount
				l_s_parent_item = i_ds_treeview.object.parent_item[l_l_row_inner]
				l_s_item_type = i_ds_treeview.object.item_type[l_l_row_inner]
				IF l_s_parent_item = l_s_item THEN
					IF LeftA ( l_s_item_type, 1 ) = "M" AND RightA ( l_s_item_type, 1 ) <> "T" THEN &
						l_b_found = TRUE
				END IF
			NEXT
			IF NOT l_b_found THEN
				l_i_return = MessageBox ( "Close Router Maintenance", "This router will be unusable until you specify a machine for each activity.  Are you sure you want to exit?", Question!, YesNo!, 2 )
				Exit
			END IF
		CASE "O1","O2","O3"
			l_s_item = i_ds_treeview.object.item[l_l_row_outer]
			FOR l_l_row_inner = 1 TO l_l_rowcount
				l_s_parent_item = i_ds_treeview.object.parent_item[l_l_row_inner]
				l_s_item_type = i_ds_treeview.object.item_type[l_l_row_inner]
				IF l_s_parent_item = l_s_item THEN
					IF l_s_item_type = "OP" THEN &
						l_b_found = TRUE
				END IF
			NEXT
			IF NOT l_b_found THEN
				l_i_return = MessageBox ( "Close Router Maintenance", "This router will be unusable until you specify a vendor for each outside process.  Are you sure you want to exit?", Question!, YesNo!, 2 )
				Exit
			END IF
		CASE "CM","CT"
			FOR l_l_row_inner = 1 TO l_l_rowcount
				IF i_ds_treeview.object.parent_part[l_l_row_inner] = &
					i_ds_treeview.object.part[l_l_row_outer] AND &
					i_ds_treeview.object.part[l_l_row_inner] <> &
					i_ds_treeview.object.part[l_l_row_outer] THEN
					l_b_found = TRUE
				END IF
			NEXT
			IF l_b_found THEN
				l_i_return = MessageBox (  "Close Router Maintenance", "This router will be unusable unitl you specify an activity for each component with components.  Are you sure you want to exit?", Question!, YesNo!, 2 )
				Exit
			END IF
	END CHOOSE
NEXT

return l_i_return
end function

public function integer of_retrieve_datastore (string a_s_part);i_ds_treeview.SetTransObject ( sqlca )
i_ds_treeview.Retrieve ( i_s_part, i_i_bom_mode, i_d_bom_date )

i_ds_treeview.Sort ( )

of_build_treeview ( )

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( i_s_part, i_i_bom_mode, i_d_bom_date )
dw_1.Sort ( )

commit;

return 1

end function

public function integer of_build_treeview ();long				l_l_count,&
					l_l_rowcount,&
					l_l_parent_row,&
					l_l_parent_handle,&
					l_l_new_handle
long				ll_parentid
INT				l_i_pictureindex,&
					l_i_item_level,&
					l_i_components
STRING			l_s_parent_item,&
					l_s_item,&
					l_s_item_label,&
					l_s_item_type
BOOLEAN			l_b_children,&
					l_b_expanded
treeviewitem	l_tvi_item

tv_1.DeleteItem ( 0 )
l_l_rowcount = i_ds_treeview.RowCount ( )

i_ds_treeview.SetSort('parent_id A,item_id A, item A')
i_ds_treeview.Sort()

For l_l_count = 1 to l_l_rowcount
	l_s_parent_item 	= i_ds_treeview.object.parent_item[l_l_count]
	l_s_item				= i_ds_treeview.object.item[l_l_count]
	l_s_item_label		= i_ds_treeview.object.item_label[l_l_count]
	l_i_item_level		= i_ds_treeview.object.item_level[l_l_count]
	l_s_item_type		= i_ds_treeview.object.item_type[l_l_count]
	l_i_components		= i_ds_treeview.object.components[l_l_count]
	l_l_new_handle		= 0
	l_l_parent_row		= 0
	ll_parentid			= i_ds_treeview.object.parent_id[l_l_count]
	
	CHOOSE CASE l_s_item_type
		CASE "A1","O1"
			l_i_pictureindex = 1
		CASE "A2","A3","O2","O3"
			l_i_pictureindex = 2
		CASE "CM"
			l_i_pictureindex = 3
		CASE "CT"
			l_i_pictureindex = 4
		CASE "SM","ST"
			l_i_pictureindex = 5
		CASE "MP"
			l_i_pictureindex = 6
		CASE "MS"
			l_i_pictureindex = 7
		CASE "MT"
			l_i_pictureindex = 8
		CASE "OP"
			l_i_pictureindex = 9
	END CHOOSE
	
	IF l_s_parent_item <> l_s_item THEN
		l_l_parent_row = i_ds_treeview.Find ( "item_id = " + String ( ll_parentid ), 1, l_l_rowcount )
	ELSE
		l_l_parent_row = 0
	END IF
	
	IF i_b_router_maint THEN
		l_b_children = ( LeftA ( l_s_item_type, 1 ) = "A" OR &
							( LeftA ( l_s_item_type, 1 ) = 'O' AND RightA ( l_s_item_type, 1 ) <> 'P' ) )
		l_b_expanded = FALSE
	ELSE
		l_b_children = FALSE
		l_b_expanded = TRUE
	END IF

	IF l_l_parent_row > 0 THEN
		IF  l_i_item_level - 1 = i_ds_treeview.object.item_level[l_l_parent_row] AND &
			i_ds_treeview.object.item[l_l_parent_row] = l_s_parent_item THEN
			i_ds_treeview.object.parent_row[l_l_count] = l_l_parent_row
			l_l_parent_handle = i_ds_treeview.object.item_handle[l_l_parent_row]
			IF i_b_router_maint THEN
				IF LeftA ( l_s_item_type, 1 ) = 'A' OR &
					( LeftA ( l_s_item_type, 1 ) = 'O' AND RightA ( l_s_item_type, 1 ) <> 'P' ) THEN
					l_l_new_handle =	tv_1.of_additem ( FALSE, l_b_children, '', &
											l_b_expanded, l_s_item_label, l_i_pictureindex, l_i_pictureindex, &
											l_l_parent_handle )
				END IF 
			ELSE
				l_l_new_handle =	tv_1.of_additem ( FALSE, l_b_children, '', &
										l_b_expanded, l_s_item_label, l_i_pictureindex, l_i_pictureindex, &
										l_l_parent_handle )
			END IF
			IF l_l_new_handle > 0 THEN
				i_ds_treeview.object.item_handle[l_l_count] = l_l_new_handle
//				tv_1.GetItem ( l_l_new_handle, l_tvi_item )
//				l_tvi_item.label = l_tvi_item.label + '[' + String ( l_l_new_handle ) + ']'
//				tv_1.SetItem ( l_l_new_handle, l_tvi_item )
			END IF
		END IF
	ELSE
		IF i_b_router_maint THEN
			IF LeftA ( l_s_item_type, 1 ) = 'A' OR &
					( LeftA ( l_s_item_type, 1 ) = 'O' AND RightA ( l_s_item_type, 1 ) <> 'P' ) THEN
				l_l_new_handle = 	tv_1.of_additem ( FALSE, l_b_children, '', l_b_expanded, l_s_item_label, &
										l_i_pictureindex, l_i_pictureindex, 0 )
			END IF
		ELSE
			l_l_new_handle = 	tv_1.of_additem ( FALSE, l_b_children, '', l_b_expanded, l_s_item_label, &
									l_i_pictureindex, l_i_pictureindex, 0 )
		END IF
		IF l_l_new_handle > 0 THEN
			i_ds_treeview.object.item_handle[l_l_count] = l_l_new_handle
//			tv_1.GetItem ( l_l_new_handle, l_tvi_item )
//			l_tvi_item.label = l_tvi_item.label + '[' + String ( l_l_new_handle ) + ']'
//			tv_1.SetItem ( l_l_new_handle, l_tvi_item )
		END IF
	END IF
Next

dw_1.Reset ( )

i_ds_treeview.RowsCopy ( 1, i_ds_treeview.rowcount(), Primary!, dw_1, 1, Primary!)

return 1
end function

on u_router_explorer.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on u_router_explorer.destroy
call super::destroy
destroy(this.dw_2)
end on

event constructor;call super::constructor;i_s_part = Message.StringParm

	
end event

event destructor;call super::destructor;Trigger Event ue_maint_mode ( 0 )

end event

event ue_pre_setup;call super::ue_pre_setup;GraphicObject l_go_object

l_go_object = Parent
Do While l_go_object.TypeOf ( ) <> Window!
	l_go_object = Parent
Loop

i_w_parent = l_go_object
i_w_mdi_frame = i_w_parent.ParentWindow ( )

st_1.x = ( i_w_parent.WorkSpaceWidth ( ) / 2 ) - ( st_1.width / 2 )
of_resize ( )


end event

event ue_setup;call super::ue_setup;i_ds_treeview.DataObject = 'd_router_datastore'

of_retrieve_datastore ( i_s_part )
		
i_l_clicked_tv_row = i_ds_treeview.Find ( "item_level = 1", 1, i_ds_treeview.RowCount ( ) )

end event

type st_1 from u_explorer_ancestor`st_1 within u_router_explorer
end type

type tv_1 from u_explorer_ancestor`tv_1 within u_router_explorer
end type

event tv_1::constructor;call super::constructor;deleteitems 		= FALSE
editlabels			= FALSE
hasbuttons			= TRUE
haslines			= TRUE
hideselection		= FALSE
linesatroot		= TRUE
pictureheight		= 16
picturewidth		= 16
AddPicture ( "absolute.bmp" )		// absolute router path
AddPicture ( "activity.bmp" )		// activity
AddPicture ( "bom_mat.bmp" )		// bom - material
AddPicture ( "bom_tool.bmp" )		// bom - tool
AddPicture ( "bom_sub.bmp" )		// bom - substitute
AddPicture ( "mach_pri.bmp" )		// machine - primary
AddPicture ( "mach_alt.bmp" )		// machine - alternate
AddPicture ( "tool.bmp" )			// tool
AddPicture ( "outsidep.bmp" )

return 1
end event

event tv_1::dragdrop;call super::dragdrop;window					l_w_mdiframe
int						l_i_count
string					l_s_prevsort,&
							l_s_temp,&
							l_s_data
m_explorer_base		l_m_popup,&
							l_m_popupitems[]
boolean					l_b_nomenu
treeviewitem			l_tvi_item
long						l_l_order,&
							l_l_row,&
							l_l_rowcount
st_generic_structure	l_str_parm
datawindow				l_dw_temp

IF handle < 1 THEN return 1
IF i_b_router_maint THEN return 1

GetItem ( handle, l_tvi_item )

l_l_rowcount = i_ds_treeview.RowCount ( )

l_l_row = i_ds_treeview.Find ( "item_handle = " + string ( handle ), 1, l_l_rowcount )

if l_l_row > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.item_label[l_l_row] then 
		return 1
	end if
else
	return 1
end if

SelectItem ( handle )

//of_clear_parms ( )

CHOOSE CASE source.TypeOf ( )
	CASE DataWindow!
		l_dw_temp = source
		l_s_data = l_dw_temp.Trigger DYNAMIC Event ue_get_data ( ) //l_dw_temp.GetItemString ( l_dw_temp.GetRow ( ), w_popup_list_ancestor.i_s_data_column )
		CHOOSE CASE source.tag
			CASE "machine"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "A" THEN
					l_b_nomenu = TRUE
					l_str_parm.value1		= i_ds_treeview.object.part[l_l_row]
					l_str_parm.value2		= l_s_data
					l_str_parm.value3		= i_ds_treeview.object.activity[l_l_row]
					l_str_parm.value10 	= "Add" 
					OpenWithParm ( w_machine_activity_maint, l_str_parm )
					IF Message.DoubleParm = 1 THEN
						Parent.Trigger DYNAMIC Event ue_refresh ( )
						of_retrieve_datastore ( i_s_part )
					END IF
				END IF
			CASE "part"
				str_bom_return_info	l_str_bom_return
				CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 )
					CASE "A","C","O"
						l_b_nomenu = TRUE
						l_str_parm.value1		= i_ds_treeview.object.part[l_l_row]
						l_str_parm.value2		= l_s_data
						l_str_parm.value10 	= "Add" 
						OpenWithParm ( w_bom_edit_add, l_str_parm )
						IF Message.DoubleParm = 1 THEN
							Parent.Trigger DYNAMIC Event ue_refresh ( )
							of_retrieve_datastore ( i_s_part )
						END IF
				END CHOOSE
			CASE "activity"
				IF i_ds_treeview.object.components[l_l_row] > 0 THEN
					CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 )
						CASE "A"
							// Make user aware that old activity will be over-written
							l_str_parm.value1 = i_ds_treeview.object.parent_part[l_l_row]
							l_str_parm.value2 = i_ds_treeview.object.part[l_l_row]
							l_str_parm.value3 = l_s_data
							l_str_parm.value10 = "Add"
							OpenWithParm ( w_activity_router_maint, l_str_parm )
							IF Message.DoubleParm = 1 THEN &
								of_retrieve_datastore ( i_s_part )
						CASE "C"
							l_str_parm.value1 = i_ds_treeview.object.parent_part[l_l_row]
							l_str_parm.value2 = i_ds_treeview.object.part[l_l_row]
							l_str_parm.value3 = l_s_data
							l_str_parm.value10 = "Add"
							OpenWithParm ( w_activity_router_maint, l_str_parm )
							IF Message.DoubleParm = 1 THEN &
								of_retrieve_datastore ( i_s_part )
						CASE "O"
							// Make user aware that old outside process will be over-written
							l_str_parm.value1 = i_ds_treeview.object.parent_part[l_l_row]
							l_str_parm.value2 = i_ds_treeview.object.part[l_l_row]
							l_str_parm.value3 = l_s_data
							l_str_parm.value10 = "Add"
							OpenWithParm ( w_activity_router_maint, l_str_parm )
							IF Message.DoubleParm = 1 THEN &
								of_retrieve_datastore ( i_s_part )
					END CHOOSE
				END IF
			CASE "tool"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "M" AND &
					RightA ( i_ds_treeview.object.item_type[l_l_row], 1 ) <> "T" THEN
					l_b_nomenu = TRUE
					l_str_parm.value1 = i_ds_treeview.object.parent_item[l_l_row]
					l_str_parm.value2 = i_ds_treeview.object.item[l_l_row]
					l_str_parm.value3 = l_s_data
					l_str_parm.value10 = "Add"
					OpenWithParm ( w_part_machine_tool_setup, l_str_parm )
					IF Message.DoubleParm = 1 THEN &
						of_retrieve_datastore ( i_s_part )
				END IF
			CASE "vendor"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "O" AND &
					RightA ( i_ds_treeview.object.item_type[l_l_row], 1 ) <> "P" THEN
					l_b_nomenu = TRUE
					l_str_parm.value1		= i_ds_treeview.object.part[l_l_row]
					l_str_parm.value2		= l_s_data
					l_str_parm.value3		= i_ds_treeview.object.activity[l_l_row]
					l_str_parm.value10 	= "Add" 
					OpenWithParm ( w_machine_activity_maint, l_str_parm )
					IF Message.DoubleParm = 1 THEN
						Parent.Trigger DYNAMIC Event ue_refresh ( )
						of_retrieve_datastore ( i_s_part )
					END IF
				END IF
		END CHOOSE
END CHOOSE

Parent.SetFocus ( )

SelectItem ( i_l_clicked_tv_row )

return 0
end event

event tv_1::dragleave;call super::dragleave;IF i_b_router_maint THEN return 1

IF i_l_clicked_tv_row > 0 THEN &
	SelectItem ( i_l_clicked_tv_row )

return 0
end event

event tv_1::dragwithin;call super::dragwithin;treeviewitem			l_tvi_item
long						l_l_order,&
							l_l_row,&
							l_l_rowcount
st_generic_structure	l_str_parm
string					l_s_prevsort,&
							l_s_temp

if handle < 1 then return 1
IF i_b_router_maint THEN return 1

GetItem ( handle, l_tvi_item )

l_l_rowcount = i_ds_treeview.RowCount ( )

l_l_row = i_ds_treeview.Find ( "item_handle = " + string ( handle ), 1, l_l_rowcount )

if l_l_row > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.item_label[l_l_row] then 
		return 1
	end if
else
	return 1
end if

//SelectItem ( handle )

CHOOSE CASE source.TypeOf ( )
	CASE DataWindow!
		CHOOSE CASE source.tag
			CASE "machine"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "A" THEN
					IF source.DragIcon <> "machine.ico" THEN &
						source.DragIcon = "machine.ico"
				ELSE
					IF source.DragIcon <> "not.ico" THEN &
						source.DragIcon = "not.ico"
				END IF
			CASE "part"
				CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 )
					CASE "A","O","C"
						IF source.DragIcon <> "bom_mat.ico" THEN &
							source.DragIcon = "bom_mat.ico"
					CASE ELSE
						IF source.DragIcon <> "not.ico" THEN &
							source.DragIcon = "not.ico"
				END CHOOSE
			CASE "activity"
				IF i_ds_treeview.object.components[l_l_row] > 0 THEN
					CHOOSE CASE LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 )
						CASE "A","O","C"
							IF source.DragIcon <> "activity.ico" THEN &
								source.DragIcon = "activity.ico"
						CASE ELSE
							IF source.DragIcon <> "not.ico" THEN &
								source.DragIcon = "not.ico"
					END CHOOSE
				ELSE
					IF source.DragIcon <> "not.ico" THEN &
						source.DragIcon = "not.ico"
				END IF
			CASE "tool"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = "M" AND &
					RightA ( i_ds_treeview.object.item_type[l_l_row], 1 ) <> "T" THEN
					IF source.DragIcon <> "tool.ico" THEN &
						source.DragIcon = "tool.ico"
				ELSE
					IF source.DragIcon <> "not.ico" THEN &
						source.DragIcon = "not.ico"
				END IF
			CASE "vendor"
				IF LeftA ( i_ds_treeview.object.item_type[l_l_row], 1 ) = 'O' AND &
					RightA ( i_ds_treeview.object.item_type[l_l_row], 1 ) <> 'P' THEN
					IF source.DragIcon <> "outsidep.ico" THEN &
						source.DragIcon = "outsidep.ico"
				ELSE
					IF source.DragIcon <> "not.ico" THEN &
						source.DragIcon = "not.ico"
				END IF
		END CHOOSE
END CHOOSE
return 0
end event

event tv_1::rightclicked;call super::rightclicked;window				l_w_mdiframe
int					l_i_count
treeviewitem		l_tvi_item
string				l_s_prevsort
m_explorer_base	l_m_popup,&
						l_m_popupitems[]
boolean				l_b_nomenu
LONG					l_l_rowcount

if handle < 1 then 
	SelectItem ( i_l_clicked_tv_row )
	return 1
end if

IF i_b_router_maint THEN return 1

GetItem ( handle, l_tvi_item )

if NOT l_tvi_item.Selected then
	SelectItem ( i_l_clicked_tv_row )
	return 1
end if

l_l_rowcount = i_ds_treeview.RowCount ( )

i_l_right_clicked_tv_row = i_ds_treeview.Find ( "item_handle = " + string ( l_tvi_item.itemhandle ), 1, l_l_rowcount )

if i_l_right_clicked_tv_row > 0 then
	if l_tvi_item.label <> i_ds_treeview.object.item_label[i_l_right_clicked_tv_row] then
		i_l_right_clicked_tv_row = 0
		SelectItem ( i_ds_treeview.object.item_handle[i_l_clicked_tv_row] )
		return 1
	end if
else
	SelectItem ( i_ds_treeview.object.item_handle[i_l_clicked_tv_row] )
	return 1
end if

Choose Case i_ds_treeview.object.item_type[i_l_right_clicked_tv_row]
	Case "A1","A2","A3"
//		IF i_ds_treeview.object.item_level[i_l_right_clicked_tv_row] = 1 THEN
//			l_m_popupitems[1] = CREATE m_explorer_base
//			l_m_popupitems[1].Item[1].Text = "Where Used Report"
//			l_m_popupitems[2] = CREATE m_explorer_base
//			l_m_popupitems[2].Item[1].Text = "Edit Activity"
//		ELSE
			l_m_popupitems[1] = CREATE m_explorer_base
			l_m_popupitems[1].Item[1].Text = "Where Used Report"
			l_m_popupitems[2] = CREATE m_explorer_base
			l_m_popupitems[2].Item[1].Text = "Edit Activity"
			l_m_popupitems[3] = CREATE m_explorer_base
			l_m_popupitems[3].Item[1].Text = "Delete Activity"
			IF i_ds_treeview.object.item_level[i_l_right_clicked_tv_row] > 1 THEN
				l_m_popupitems[4] = CREATE m_explorer_base
				l_m_popupitems[4].Item[1].Text = "Edit BOM Component"
				l_m_popupitems[5] = CREATE m_explorer_base
				l_m_popupitems[5].Item[1].Text = "Delete BOM Component"
			END IF
//		END IF
	Case "O1","O2","O3"
//		IF i_ds_treeview.object.item_level[i_l_right_clicked_tv_row] = 1 THEN
//			l_m_popupitems[1] = CREATE m_explorer_base
//			l_m_popupitems[1].Item[1].Text = "Where Used Report"
//			l_m_popupitems[2] = CREATE m_explorer_base
//			l_m_popupitems[2].Item[1].Text = "Edit Activity"
//		ELSE
			l_m_popupitems[1] = CREATE m_explorer_base
			l_m_popupitems[1].Item[1].Text = "Where Used Report"
			l_m_popupitems[2] = CREATE m_explorer_base
			l_m_popupitems[2].Item[1].Text = "Edit Outside Process"
			l_m_popupitems[3] = CREATE m_explorer_base
			l_m_popupitems[3].Item[1].Text = "Delete Outside Process"
			IF i_ds_treeview.object.item_level[i_l_right_clicked_tv_row] > 1 THEN
				l_m_popupitems[4] = CREATE m_explorer_base
				l_m_popupitems[4].Item[1].Text = "Edit BOM Component"
				l_m_popupitems[5] = CREATE m_explorer_base
				l_m_popupitems[5].Item[1].Text = "Delete BOM Component"
			END IF
//		END IF
	Case "CM","CT","SM","ST"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Where Used Report"
		IF i_ds_treeview.object.item_level[i_l_right_clicked_tv_row] > 1 THEN
			l_m_popupitems[2] = CREATE m_explorer_base
			l_m_popupitems[2].Item[1].Text = "Edit BOM Component"
			l_m_popupitems[3] = CREATE m_explorer_base
			l_m_popupitems[3].Item[1].Text = "Delete BOM Component"
		END IF
	Case "MP","MS"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Machine"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Delete Machine"
	Case "MT"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Tool"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Delete Tool"
	Case "OP"
		l_m_popupitems[1] = CREATE m_explorer_base
		l_m_popupitems[1].Item[1].Text = "Edit Vendor"
		l_m_popupitems[2] = CREATE m_explorer_base
		l_m_popupitems[2].Item[1].Text = "Delete Vendor"
	Case Else
		l_b_nomenu = TRUE
End Choose

if NOT l_b_nomenu then

	l_m_popup = CREATE m_explorer_base

	//l_w_mdiframe = Parent.ParentWindow ( )

	For l_i_count = 1 to UpperBound ( l_m_popupitems )
		l_m_popup.m_action.Item[l_i_count] = l_m_popupitems[l_i_count].Item[1]
	Next
	
	if isvalid ( i_w_mdi_frame ) then
		l_m_popup.m_action.PopMenu ( i_w_mdi_frame.PointerX(), i_w_mdi_frame.PointerY() )
	else
		l_m_popup.m_action.PopMenu ( Parent.PointerX(), Parent.PointerY() )
	end if
	
	if i_l_clicked_tv_row > 0 then &
		SelectItem ( i_ds_treeview.object.item_handle[i_l_clicked_tv_row] )
	
end if

return 0
end event

event tv_1::itemexpanded;call super::itemexpanded;INT				l_i_level
LONG				l_l_handle,&
					l_l_rowcount,&
					l_l_row,&
					l_l_up_handle,&
					l_l_down_handle,&
					l_l_child,&
					l_l_next
treeviewitem	l_tvi_item
STRING			l_s_prev_sort

IF handle < 1 THEN return
IF NOT i_b_router_maint THEN return

GetItem ( handle, l_tvi_item )

l_i_level = 1

l_l_handle = handle
l_l_rowcount = i_ds_treeview.RowCount ( )

// Find clicked item in i_ds_treeview and set expanded = 1
l_s_prev_sort = i_ds_treeview.object.datawindow.table.sort
i_ds_treeview.SetSort ( "item_handle A" )
i_ds_treeview.Sort ( )
l_l_row = i_ds_treeview.Find ( "item_handle = " + String ( l_l_handle ), 1, l_l_rowcount )
IF l_l_row > 0 THEN 
	IF i_ds_treeview.object.item_handle[l_l_row] = l_l_handle THEN
		i_ds_treeview.object.expanded[l_l_row] = 1
	END IF
END IF
i_ds_treeview.SetSort ( l_s_prev_sort )
i_ds_treeview.Sort ( )

// Collapse the upward branches
l_l_up_handle = FindItem ( PreviousTreeItem!, l_l_handle )
DO WHILE l_l_up_handle <> -1
	f_collapse_tv_branch_with_datastore ( tv_1, l_l_up_handle, i_ds_treeview )
	l_l_up_handle = FindItem ( PreviousTreeItem!, l_l_up_handle )
LOOP

l_l_down_handle = FindItem ( NextTreeItem!, l_l_handle )
DO WHILE l_l_down_handle <> -1
	f_collapse_tv_branch_with_datastore ( tv_1, l_l_down_handle, i_ds_treeview )
	l_l_down_handle = FindItem ( NextTreeItem!, l_l_down_handle )
LOOP

end event

event tv_1::itemcollapsed;call super::itemcollapsed;IF handle < 1 THEN return
IF NOT i_b_router_maint THEN return

f_collapse_tv_branch_with_datastore ( tv_1, handle, i_ds_treeview )

end event

event tv_1::clicked;call super::clicked;treeviewitem		l_tvi_item
LONG					l_l_rowcount

if handle < 1 then 
	return 1
end if

IF i_b_router_maint THEN return 1

GetItem ( handle, l_tvi_item )

//if NOT l_tvi_item.Selected then
//	return 1
//end if

l_l_rowcount = i_ds_treeview.RowCount ( )

i_l_clicked_tv_row = i_ds_treeview.Find ( "item_handle = " + string ( l_tvi_item.itemhandle ), 1, l_l_rowcount )

	Choose Case i_ds_treeview.object.item_type[i_l_clicked_tv_row]
		Case "A1","A2","A3","O1","O2","O3","CM","SM"
			dw_1.dataobject = "d_issues_list"
			dw_1.SetTransObject ( sqlca )
			dw_1.object.datawindow.table.select = dw_1.object.datawindow.table.select + " WHERE product_code = '" + i_ds_treeview.object.part[i_l_clicked_tv_row] + "' OR product_component = '" + i_ds_treeview.object.part[i_l_clicked_tv_row] + "'"
			dw_1.SetTransObject ( sqlca )
			dw_1.Retrieve ( )
			dw_1.Tag = i_ds_treeview.object.item_type[i_l_clicked_tv_row]
		Case else
			dw_1.Reset ( )
			dw_1.dataobject = ""
			dw_1.Tag = ""
	end choose

end event

type dw_1 from u_explorer_ancestor`dw_1 within u_router_explorer
end type

event dw_1::doubleclicked;st_generic_structure	lstr_parm

if row > 0 then
	Choose Case Tag
		Case "A1","A2","A3","O1","O2","O3","CM","SM"
			lstr_parm.value1 = String ( GetItemNumber ( row, "issue_number" ) )
			OpenSheetWithParm ( w_issue_manager, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
	end choose
end if
end event

event dw_1::itemchanged;datawindowchild ldwc_fastcopy

long		ll_row

if dw_1.dataobject = 'd_fast_copy' then
	
	getchild ( 'part', ldwc_fastcopy )
		
	ll_row = ldwc_fastcopy.Find ( "part = '" + data + "'", 1, ldwc_fastcopy.RowCount ( ) )
	if ll_row > 0 then
		ldwc_fastcopy.scrolltorow ( ll_row )
		ldwc_fastcopy.selectrow ( ll_row, true )
	end if
	
	if ldwc_fastcopy.getselectedrow ( 0 ) <= 0 then
		messagebox ( monsys.msg_title, "Enter a Valid Part Number!", Information! )
		this.setitem ( 1, row, '' )
		return 
	else
		if f_get_part_info ( data, 'NAME' ) > '' then
			if data > '' then
				parent.trigger event ue_fast_copy ( data )		
			end if	
		end if
	end if

end if


end event

type dw_2 from datawindow within u_router_explorer
boolean visible = false
integer x = 896
integer y = 240
integer width = 2610
integer height = 668
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Visual Bill Of Material"
string dataobject = "d_print_bom"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

