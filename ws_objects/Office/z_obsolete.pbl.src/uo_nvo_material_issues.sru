$PBExportHeader$uo_nvo_material_issues.sru
forward
global type uo_nvo_material_issues from nonvisualobject
end type
end forward

global type uo_nvo_material_issues from nonvisualobject
end type
global uo_nvo_material_issues uo_nvo_material_issues

forward prototypes
public subroutine uf_issue (long arg_serial, string arg_part, string arg_workorder, string arg_machine, string arg_type, datawindow arg_dwcommon, datawindow arg_dwobject, datawindow arg_dwtran, datawindow arg_dwscanserial, string arg_operator)
end prototypes

public subroutine uf_issue (long arg_serial, string arg_part, string arg_workorder, string arg_machine, string arg_type, datawindow arg_dwcommon, datawindow arg_dwobject, datawindow arg_dwtran, datawindow arg_dwscanserial, string arg_operator);BOOLEAN   l_b_del

DATASTORE l_ds_object, &
          l_ds_partinventory, &
			 l_ds_workorder, &
			 l_ds_parameters, &
			 l_ds_partonline
			 
DECIMAL	 nQty, &
          nStdQty, &
			 l_d_newqty, &
			 l_d_newstdqty, &
			 l_d_onhandqty, &
			 l_d_qty_completed, &
			 l_d_tot_iq, &
			 l_d_diff

INT 		 iRtnCode, &
          l_i_lotqty
			 
LONG      l_i_serial, &
          ll_nbr, &
			 ll_foundrow
			 
STRING 	 szUM, & 
          s_Operator, &
			 szCustom1, &
			 szCustom2, &
			 szCustom3, &
			 szCustom4, &
			 szCustom5, &
			 cCheck1, &
			 cCheck2, &
			 cCheck3, &
			 cCheck4, &
			 cCheck5, &
			 cCheckLot, &
			 szLot, &
			 cSafetyPart, &
  			 cLotActivated, &
			 s_Status, &
			 l_s_part, &
			 l_s_machine, &
			 l_s_createsyntax, &
			 l_s_insertsyntax, &
			 l_s_err

st_generic_structure stParm

IF arg_serial > 0 THEN
	l_i_serial = arg_serial
	l_ds_object = Create Datastore
	l_s_createsyntax = "SELECT part, status, quantity, std_quantity, unit_measure, custom1, custom2, custom3, custom4, custom5, lot "  &
	  	                + " FROM object WHERE serial = "+String(l_i_serial)
   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
	l_ds_object.Create(l_s_insertsyntax,l_s_err)
   l_ds_object.Settransobject(sqlca)
	l_ds_object.Retrieve()
	IF l_ds_object.rowcount() > 0 Then
		l_s_part = l_ds_object.object.part[1]
		s_status = l_ds_object.object.status[1]
		nqty     = l_ds_object.object.quantity[1]		
		nstdqty  = l_ds_object.object.std_quantity[1]		
		szum     = l_ds_object.object.unit_measure[1]		
		szcustom1= l_ds_object.object.custom1[1]		
		szcustom2= l_ds_object.object.custom2[1]				
		szcustom3= l_ds_object.object.custom3[1]				
		szcustom4= l_ds_object.object.custom4[1]				
		szcustom5= l_ds_object.object.custom5[1]				
		szlot    = l_ds_object.object.lot[1]
		IF s_Status = 'A' THEN
			ll_nbr = arg_dwcommon.RowCount()
			ll_foundrow = arg_dwcommon.Find("part = '"+ l_s_part +"'", 1, ll_nbr)
			IF ll_foundrow > 0 THEN
				l_ds_partinventory = Create Datastore
				l_s_createsyntax = "SELECT safety_part " &
				  	                + " FROM part_inventory WHERE part = "+l_s_part
			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
				l_ds_partinventory.Create(l_s_insertsyntax,l_s_err)			
			   l_ds_partinventory.Settransobject(sqlca)
				l_ds_partinventory.Retrieve()
				IF l_ds_partinventory.Rowcount() > 0 THEN 
					csafetypart = l_ds_partinventory.object.safety_part[1]
				End if 	
				l_ds_workorder = Create Datastore
				l_s_createsyntax = "SELECT lot_control_activated " &
				  	                + " FROM work_order WHERE work_order = "+arg_workorder
			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
				l_ds_workorder.Create(l_s_insertsyntax,l_s_err)			
			   l_ds_workorder.Settransobject(sqlca)
				l_ds_workorder.Retrieve()
				IF l_ds_workorder.Rowcount() > 0 THEN 
					cLotActivated = l_ds_workorder.object.lot_control_activated[1]
				End if 	
				If arg_dwtran.RowCount ( ) > 0 And cSafetyPart = 'Y' And cLotActivated = 'Y' Then
					l_ds_parameters = Create Datastore
					l_s_createsyntax = "SELECT shop_floor_check_u1, shop_floor_check_u2, shop_floor_check_u3 " &
					                   + "shop_floor_check_u4, shop_floor_check_u5 " & 
					  	                + " FROM parameters "
				   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
					l_ds_parameters.Create(l_s_insertsyntax,l_s_err)				
				   l_ds_parameters.Settransobject(sqlca)
					l_ds_parameters.Retrieve()
					IF l_ds_parameters.Rowcount() > 0 THEN 
						ccheck1 = l_ds_parameters.object.shop_floor_check_u1[1]
						ccheck2 = l_ds_parameters.object.shop_floor_check_u2[1]					
						ccheck3 = l_ds_parameters.object.shop_floor_check_u3[1]					
						ccheck4 = l_ds_parameters.object.shop_floor_check_u4[1]					
						ccheck5 = l_ds_parameters.object.shop_floor_check_u5[1]					
					End if 	
					If cCheck1 = 'Y' Then 
						If szCustom1 <> arg_dwtran.GetItemSTRING ( 1, "custom1" ) Then &
							bChanged = True
					End if		
					If cCheck2 = 'Y' And Not bChanged Then 
						If szCustom2 <> arg_dwtran.GetItemSTRING ( 1, "custom2" ) Then &
							bChanged = True
					End if 		
					If cCheck3 = 'Y' And Not bChanged Then 
						If szCustom3 <> arg_dwtran.GetItemSTRING ( 1, "custom3" ) Then &
							bChanged = True
					End if 		
					If cCheck4 = 'Y' And Not bChanged Then 
						If szCustom4 <> arg_dwtran.GetItemSTRING ( 1, "custom4" ) Then &
							bChanged = True
					End if 		
					If cCheck5 = 'Y' And Not bChanged Then 
						If szCustom5 <> arg_dwtran.GetItemSTRING ( 1, "custom5" ) Then &
							bChanged = True
					End if 		
					If cCheckLot = 'Y' And Not bChanged Then 
						If szLot <> arg_dwtran.GetItemSTRING ( 1, "lot" ) Then &
							bChanged = True
					End if 		
					If bChanged Then 
						iRtnCode = MessageBox ( "Error", "Information has changed from previous transaction!  You need to perform a job completion on current object or scan another serial number.  Would you like to go to the completion screen?", Question!, YesNo!, 1 )
						If iRtnCode = 1 Then
							stParm.Value1  = arg_operator
							stParm.Value2  = arg_part
							stParm.Value3  = arg_machine
							stParm.Value4  = arg_workorder
							stParm.Value10 = "ForceJC"
							OpenWithParm ( w_part_production, stParm )
						Else
				  		   UPDATE work_order  
					      SET lot_control_activated = 'Y'  
						   WHERE work_order = :szWorkOrder   ;
							
//							l_ds_workorder.setitem(1,'lot_control_activated','Y')
//							l_ds_workorder.update()
							If SQLCA.SQLCode = -1 Then
								RollBack ;
							Else
								Commit ;
							End if
						End if 	
					End if	
				End if
			Else
			   UPDATE work_order  
			      SET lot_control_activated = 'Y'  
			    WHERE work_order = :szWorkOrder   ;

//				l_ds_workorder.setitem(1,'lot_control_activated','Y')
//				l_ds_workorder.update()
				If SQLCA.SQLCode = -1 Then
					RollBack ;
				End if
			End if
			l_b_del=false
			Choose case arg_type
				Case 'L' // issue lot wise
					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cbatch_quantity')
					IF l_i_lotqty < nqty THEN
						nqty = l_i_lotqty
						nstdqty = l_i_lotqty
					Else
						l_b_del=true
					End if 	
				Case 'T' // issue for the whole work order
					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cwo_quantity')
					IF l_i_lotqty < nqty THEN
						nqty = l_i_lotqty
						nstdqty = l_i_lotqty
					Else
						l_b_del=true
					End if 	
				Case 'C' // issue consumed qty
					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cqty_completed')
//					IF l_i_lotqty < nqty THEN
//						nqty = l_i_lotqty
//						nstdqty = l_i_lotqty
//					Else
//						l_b_del=true
//					End if 	
					IF arg_dwtran.rowcount() > 0 Then 
						l_d_tot_iq=arg_dwtran.getitemnumber(1,'ti_qty')
					Else
						l_d_tot_iq=0
					End if 	
					If l_d_tot_iq > l_i_lotqty Then
						l_d_diff = (l_d_tot_iq - l_i_lotqty) 
					Else
						l_d_diff = (l_i_lotqty - l_d_tot_iq)
					End if 	
					IF nqty > l_d_diff THEN
						nqty = l_d_diff
						nstdqty = l_d_diff
					Else
						l_b_del=true
					End if 	
				Case 'S' // issue scanned
					l_b_del=true					
			End Choose		
   		If f_create_audit_trail(l_i_Serial, "M", STRING(nQty), STRING(nStdQty), szUM, &
									arg_machine, "", "", "", arg_workorder, arg_operator, "No Commit") then 
	         IF l_b_del Then  
			  		DELETE FROM object  
			   	WHERE serial = :l_i_Serial   ;
//					l_ds_object.deleterow(1) 
					
				Else
//					l_d_newqty    = l_ds_object.object.quantity[1] - nqty 
//					l_d_newstdqty = l_ds_object.object.std_quantity[1] - nstdqty 
//					l_ds_object.setitem(1,'quantity',l_d_newqty)
//					l_ds_object.setitem(1,'std_quantity',l_d_newstdqty)					
//					l_ds_object.update()
					Update object
 					   set quantity = (quantity - :nqty),
						    std_quantity = (std_quantity - :nstdqty)
  			   	 WHERE serial = :l_i_Serial  ;							 
				END IF 		
			End if	
			If SQLCA.SQLCode = -1 then
				Rollback;
			Else
//				l_ds_partonline = Create Datastore
//				l_s_createsyntax = "SELECT on_hand " &
//				  	                + " FROM part_online where part = "+l_s_part 
//			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
//				l_ds_partonline.Create(l_s_insertsyntax,l_s_err)				
//			   l_ds_partonline.Settransobject(sqlca)
//				l_ds_partonline.Retrieve()
//				If l_ds_partonline.rowcount() > 0 Then 
//					l_d_onhandqty = l_ds_partonline.object.on_hand[1] - nstdqty
//					l_ds_partonline.setitem(1,'on_hand',l_d_onhandqty)
//					l_ds_partonline.update()
//				End if 
				
				UPDATE part_online
				   SET on_hand = on_hand - :nStdQty
				 WHERE part = :l_s_Part  ;

				IF SQLCA.SQLCode = -1 THEN
					messagebox ( "Warning!", "Unable to save data" )
					Rollback  ;
				ELSE
					Commit ;					
               arg_dwtran.Retrieve ( l_s_Part, arg_workorder )
					arg_dwobject.Retrieve ( l_s_Part, arg_workorder )	
					w_machine_inventory.wf_create_common_set()
				END IF
			End If
		Else
			Messagebox('Warning!','Invalid Serial no.')
		End if 	
	Else	
		MessageBox ( "Warning!", "Unable to issue object.~rObject status is not approved!", StopSign! )
	END IF
	Destroy l_ds_object
	Destroy l_ds_partinventory
	Destroy l_ds_workorder 	
	Destroy l_ds_parameters
//	Destroy l_ds_partonline
END IF 
IF arg_type='S' THEN
	arg_dwscanserial.setitem(1,'scan_serial','')
	arg_dwscanserial.setfocus()
End if


//BOOLEAN   l_b_del
//DATASTORE l_ds_object, &
//          l_ds_partinventory, &
//			 l_ds_workorder, &
//			 l_ds_parameters, &
//			 l_ds_partonline
//DECIMAL	 nQty, &
//          nStdQty, &
//			 l_d_newqty, &
//			 l_d_newstdqty, &
//			 l_d_onhandqty 
//INT 		 iRtnCode, &
//          l_i_lotqty
//LONG      l_i_serial, &
//          ll_nbr, &
//			 ll_foundrow
//STRING 	 szUM, & 
//          s_Operator, &
//			 szCustom1, &
//			 szCustom2, &
//			 szCustom3, &
//			 szCustom4, &
//			 szCustom5, &
//			 cCheck1, &
//			 cCheck2, &
//			 cCheck3, &
//			 cCheck4, &
//			 cCheck5, &
//			 cCheckLot, &
//			 szLot, &
//			 cSafetyPart, &
//  			 cLotActivated, &
//			 s_Status, &
//			 l_s_part, &
//			 l_s_machine, &
//			 l_s_createsyntax, &
//			 l_s_insertsyntax, &
//			 l_s_err
//st_generic_structure stParm
//IF arg_serial > 0 THEN
//	l_i_serial = arg_serial
//	l_ds_object = Create Datastore
//	l_s_createsyntax = "SELECT part, status, quantity, std_quantity, unit_measure, custom1, custom2, custom3, custom4, custom5, lot "  &
//	  	                + " FROM object WHERE serial = "+String(l_i_serial)
//   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
//	l_ds_object.Create(l_s_insertsyntax,l_s_err)
//   l_ds_object.Settransobject(sqlca)
//	l_ds_object.Retrieve()
//	IF l_ds_object.rowcount() > 0 Then
//		l_s_part = l_ds_object.object.part[1]
//		s_status = l_ds_object.object.status[1]
//		nqty     = l_ds_object.object.quantity[1]		
//		nstdqty  = l_ds_object.object.std_quantity[1]		
//		szum     = l_ds_object.object.unit_measure[1]		
//		szcustom1= l_ds_object.object.custom1[1]		
//		szcustom2= l_ds_object.object.custom2[1]				
//		szcustom3= l_ds_object.object.custom3[1]				
//		szcustom4= l_ds_object.object.custom4[1]				
//		szcustom5= l_ds_object.object.custom5[1]				
//		szlot    = l_ds_object.object.lot[1]
//		IF s_Status = 'A' THEN
//			ll_nbr = arg_dwcommon.RowCount()
//			ll_foundrow = arg_dwcommon.Find("part = '"+ l_s_part +"'", 1, ll_nbr)
//			IF ll_foundrow > 0 THEN
//				l_ds_partinventory = Create Datastore
//				l_s_createsyntax = "SELECT safety_part " &
//				  	                + " FROM part_inventory WHERE part = '"+l_s_part+"'"
//			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
//				l_ds_partinventory.Create(l_s_insertsyntax,l_s_err)			
//			   l_ds_partinventory.Settransobject(sqlca)
//				l_ds_partinventory.Retrieve()
//				IF l_ds_partinventory.Rowcount() > 0 THEN 
//					csafetypart = l_ds_partinventory.object.safety_part[1]
//				End if 	
//				l_ds_workorder = Create Datastore
//				l_s_createsyntax = "SELECT lot_control_activated " &
//				  	                + " FROM work_order WHERE work_order = '"+arg_workorder+"'"
//			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
//				l_ds_workorder.Create(l_s_insertsyntax,l_s_err)			
//			   l_ds_workorder.Settransobject(sqlca)
//				l_ds_workorder.Retrieve()
//				IF l_ds_workorder.Rowcount() > 0 THEN 
//					cLotActivated = l_ds_workorder.object.lot_control_activated[1]
//				End if 	
//				If arg_dwtran.RowCount ( ) > 0 And cSafetyPart = 'Y' And cLotActivated = 'Y' Then
//					l_ds_parameters = Create Datastore
//					l_s_createsyntax = "SELECT shop_floor_check_u1, shop_floor_check_u2, shop_floor_check_u3 " &
//					                   + "shop_floor_check_u4, shop_floor_check_u5 " & 
//					  	                + " FROM parameters "
//				   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
//					l_ds_parameters.Create(l_s_insertsyntax,l_s_err)				
//				   l_ds_parameters.Settransobject(sqlca)
//					l_ds_parameters.Retrieve()
//					IF l_ds_parameters.Rowcount() > 0 THEN 
//						ccheck1 = l_ds_parameters.object.shop_floor_check_u1[1]
//						ccheck2 = l_ds_parameters.object.shop_floor_check_u2[1]					
//						ccheck3 = l_ds_parameters.object.shop_floor_check_u3[1]					
//						ccheck4 = l_ds_parameters.object.shop_floor_check_u4[1]					
//						ccheck5 = l_ds_parameters.object.shop_floor_check_u5[1]					
//					End if 	
//					If cCheck1 = 'Y' Then 
//						If szCustom1 <> arg_dwtran.GetItemSTRING ( 1, "custom1" ) Then &
//							bChanged = True
//					End if		
//					If cCheck2 = 'Y' And Not bChanged Then 
//						If szCustom2 <> arg_dwtran.GetItemSTRING ( 1, "custom2" ) Then &
//							bChanged = True
//					End if 		
//					If cCheck3 = 'Y' And Not bChanged Then 
//						If szCustom3 <> arg_dwtran.GetItemSTRING ( 1, "custom3" ) Then &
//							bChanged = True
//					End if 		
//					If cCheck4 = 'Y' And Not bChanged Then 
//						If szCustom4 <> arg_dwtran.GetItemSTRING ( 1, "custom4" ) Then &
//							bChanged = True
//					End if 		
//					If cCheck5 = 'Y' And Not bChanged Then 
//						If szCustom5 <> arg_dwtran.GetItemSTRING ( 1, "custom5" ) Then &
//							bChanged = True
//					End if 		
//					If cCheckLot = 'Y' And Not bChanged Then 
//						If szLot <> arg_dwtran.GetItemSTRING ( 1, "lot" ) Then &
//							bChanged = True
//					End if 		
//					If bChanged Then 
//						iRtnCode = MessageBox ( "Error", "Information has changed from previous transaction!  You need to perform a job completion on current object or scan another serial number.  Would you like to go to the completion screen?", Question!, YesNo!, 1 )
//						If iRtnCode = 1 Then
//							stParm.Value1  = arg_operator
//							stParm.Value2  = arg_part
//							stParm.Value3  = arg_machine
//							stParm.Value4  = arg_workorder
//							stParm.Value10 = "ForceJC"
//							OpenWithParm ( w_part_production, stParm )
//						Else
//							l_ds_workorder.setitem(1,'lot_control_activated','Y')
//							l_ds_workorder.update()
//							If SQLCA.SQLCode = -1 Then
//								RollBack ;
//							Else
//								Commit ;
//							End if
//						End if 	
//					End if	
//				End if
//			Else
//				l_ds_workorder.setitem(1,'lot_control_activated','Y')
//				l_ds_workorder.update()
//				If SQLCA.SQLCode = -1 Then
//					RollBack ;
//				End if
//			End if
//			l_b_del=false
//			Choose case arg_type
//				Case 'L' // issue lot wise
//					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cbatch_quantity')
//					IF l_i_lotqty < nqty THEN
//						nqty = l_i_lotqty
//						nstdqty = l_i_lotqty
//					Else
//						l_b_del=true
//					End if 	
//				Case 'T' // issue for the whole work order
//					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cwo_quantity')
//					IF l_i_lotqty < nqty THEN
//						nqty = l_i_lotqty
//						nstdqty = l_i_lotqty
//					Else
//						l_b_del=true
//					End if 	
//				Case 'C' // issue consumed qty
//					l_i_lotqty=arg_dwcommon.getitemnumber(ll_foundrow,'cqty_completed')
//					IF l_i_lotqty < nqty THEN
//						nqty = l_i_lotqty
//						nstdqty = l_i_lotqty
//					Else
//						l_b_del=true
//					End if 	
//				Case 'S' // issue scanned
//					l_b_del=true					
//			End Choose		
//   		If f_create_audit_trail(l_i_Serial, "M", STRING(nQty), STRING(nStdQty), szUM, &
//									arg_machine, "", "", "", arg_workorder, arg_operator, "No Commit") then 
//	         IF l_b_del Then  
//					l_ds_object.deleterow(1) 
//				Else
////					l_d_newqty    = l_ds_object.object.quantity[1] 
////					l_d_newqty    = l_d_newqty - nqty 
////					l_d_newstdqty = l_ds_object.object.std_quantity[1] 
////					l_d_newstdqty = l_d_newstdqty - nstdqty 
////					l_ds_object.update()
//					Update object
// 					   set quantity = (quantity - :nqty),
//						    std_quantity = (std_quantity - :nstdqty)
//  			   	 WHERE serial = :l_i_Serial  	;			
//				END IF 		
//			End if	
//			If SQLCA.SQLCode = -1 then
//				Rollback;
//			Else
////				l_ds_partonline = Create Datastore
////				l_s_createsyntax = "SELECT on_hand " &
////				  	                + " FROM part_online where part = '"+l_s_part+"'" 
////			   l_s_insertsyntax = SQLCA.SyntaxFromSql(l_s_createsyntax,"",l_s_err)
////				l_ds_partonline.Create(l_s_insertsyntax,l_s_err)				
////			   l_ds_partonline.Settransobject(sqlca)
////				l_ds_partonline.Retrieve()
////				If l_ds_partonline.rowcount() > 0 Then 
////					l_d_onhandqty = l_ds_partonline.object.on_hand[1] - nstdqty
////					l_ds_partonline.setitem(1,'on_hand',l_d_onhandqty)
////					l_ds_partonline.update()
//				UPDATE part_online
//				   SET on_hand = on_hand - :nStdQty
//				 WHERE part = :l_s_Part  ;
//				IF SQLCA.SQLCode = -1 THEN
//					messagebox ( "Warning!", "Unable to save data" )
//					Rollback  ;
//				ELSE
//					Commit ;					
//	            arg_dwtran.Retrieve ( l_s_Part, arg_workorder)
//					arg_dwobject.Retrieve ( l_s_Part, arg_workorder )					
//				END IF
//			End if 	
//		Else
//			Messagebox('Warning!','Invalid Serial no.')
//		End if 	
//	Else	
//		MessageBox ( "Warning!", "Unable to issue object.~rObject status is not approved!", StopSign! )
//	END IF
//	Destroy l_ds_object
//	Destroy l_ds_partinventory
//	Destroy l_ds_workorder 	
//	Destroy l_ds_parameters
//	Destroy l_ds_partonline
//END IF 
//IF arg_type='S' THEN
//	arg_dwscanserial.setitem(1,'scan_serial','')
//	arg_dwscanserial.setfocus()

end subroutine

on uo_nvo_material_issues.create
TriggerEvent( this, "constructor" )
end on

on uo_nvo_material_issues.destroy
TriggerEvent( this, "destructor" )
end on

