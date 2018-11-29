$PBExportHeader$w_physical_inventory.srw
$PBExportComments$Physical Inventory
forward
global type w_physical_inventory from w_sheet_4t
end type
type dw_part_list from datawindow within w_physical_inventory
end type
type dw_parts_onhand from datawindow within w_physical_inventory
end type
type st_manual3 from statictext within w_physical_inventory
end type
type st_manual2 from statictext within w_physical_inventory
end type
type cb_manual2 from commandbutton within w_physical_inventory
end type
type sle_accuracy from singlelineedit within w_physical_inventory
end type
type sle_total_discrepency from singlelineedit within w_physical_inventory
end type
type sle_total_objects from singlelineedit within w_physical_inventory
end type
type sle_group from singlelineedit within w_physical_inventory
end type
type sle_location from singlelineedit within w_physical_inventory
end type
type st_6 from statictext within w_physical_inventory
end type
type st_5 from statictext within w_physical_inventory
end type
type st_status from statictext within w_physical_inventory
end type
type sle_percentage from singlelineedit within w_physical_inventory
end type
type dw_objects_scanned from datawindow within w_physical_inventory
end type
type dw_objects_on_pallet from datawindow within w_physical_inventory
end type
type st_manual from statictext within w_physical_inventory
end type
type sle_manual from singlelineedit within w_physical_inventory
end type
type dw_objects_in_location from datawindow within w_physical_inventory
end type
type st_2 from statictext within w_physical_inventory
end type
type dw_batch from datawindow within w_physical_inventory
end type
type cbx_1 from checkbox within w_physical_inventory
end type
type dw_search_object from datawindow within w_physical_inventory
end type
type dw_location from datawindow within w_physical_inventory
end type
type cb_manual from commandbutton within w_physical_inventory
end type
type dw_discrepency from datawindow within w_physical_inventory
end type
type sle_base from singlelineedit within w_physical_inventory
end type
type dw_objects from datawindow within w_physical_inventory
end type
type st_1 from statictext within w_physical_inventory
end type
type st_4 from statictext within w_physical_inventory
end type
type st_3 from statictext within w_physical_inventory
end type
type dw_physical from datawindow within w_physical_inventory
end type
type gb_3 from groupbox within w_physical_inventory
end type
type gb_4 from groupbox within w_physical_inventory
end type
type gb_2 from groupbox within w_physical_inventory
end type
type gb_1 from groupbox within w_physical_inventory
end type
end forward

global type w_physical_inventory from w_sheet_4t
string title = "Physical Inventory"
string menuname = "m_physical_inventory"
event manual_scan pbm_custom01
event compare pbm_custom02
event reconcile pbm_custom03
event delete_physical pbm_custom04
event batch_process pbm_custom05
event scanpal pbm_custom06
event delete_lost pbm_custom07
event ue_graph pbm_custom08
event ue_import pbm_custom09
dw_part_list dw_part_list
dw_parts_onhand dw_parts_onhand
st_manual3 st_manual3
st_manual2 st_manual2
cb_manual2 cb_manual2
sle_accuracy sle_accuracy
sle_total_discrepency sle_total_discrepency
sle_total_objects sle_total_objects
sle_group sle_group
sle_location sle_location
st_6 st_6
st_5 st_5
st_status st_status
sle_percentage sle_percentage
dw_objects_scanned dw_objects_scanned
dw_objects_on_pallet dw_objects_on_pallet
st_manual st_manual
sle_manual sle_manual
dw_objects_in_location dw_objects_in_location
st_2 st_2
dw_batch dw_batch
cbx_1 cbx_1
dw_search_object dw_search_object
dw_location dw_location
cb_manual cb_manual
dw_discrepency dw_discrepency
sle_base sle_base
dw_objects dw_objects
st_1 st_1
st_4 st_4
st_3 st_3
dw_physical dw_physical
gb_3 gb_3
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
end type
global w_physical_inventory w_physical_inventory

type variables
String szLocation
String szFilter
String is_Type

Integer iPhysicalRow
end variables

forward prototypes
public subroutine wf_delay (integer iNumber)
public subroutine wf_compare (string szlocation)
public subroutine wf_clear_location (string szlocation)
public subroutine wf_send_to_location (string szLocation)
public subroutine wf_manual_scan (string szlocation, long lserial)
public function boolean wf_update_accuracy_history (long itotaldiscrepency, long itotalobjects, string szlocation, string sztype)
public function string wf_get_group (string szlocation)
public subroutine wf_show_graph ()
public subroutine wf_show_statitics (string szlocation, date ddate)
public function string wf_trim_location (string szLocation)
public function string wf_delete_garbage (string szserial)
public subroutine wf_process_pallet (long iparentserial, string szLocation)
public subroutine wf_create_backup_data (long a_serial)
end prototypes

on manual_scan;IF FileExists ( "PHYSICAL.DAT" ) THEN
	IF MessageBox ( "Delete Backup Data", "Would you like to delete " + &
						 "the backup data file that was created during your " + &
						 "last inventory scan?", Question!, YesNo! ) = 1 THEN
		FileDelete ( "PHYSICAL.DAT" )
	END IF
END IF

If IsNull(szLocation) then
	MessageBox("Warning", "Please specify the location first.", StopSign!)
	Return
End If

cb_manual.visible		= TRUE
cb_manual2.visible	= TRUE
st_manual.visible		= TRUE
sle_manual.visible	= TRUE
st_manual2.Visible   = TRUE
st_manual3.Visible   = TRUE

sle_manual.text		= ""
sle_manual.SetFocus()
end on

on compare;Integer 	iRow
Long		iTotalObjects
Long		iTotalDiscrepency

If IsNull(szLocation) then
	MessageBox("Warning", "You must select location first.", StopSign!)
	Return
End If

If Not cbx_1.checked then
	wf_clear_location(szLocation)		//Erase old discrepency data
	wf_compare(szLocation)				//Compare system and physical obj data
Else
	For iRow = 1 to dw_location.RowCount()
		dw_location.ScrollToRow(iRow)
		szLocation = dw_location.GetItemString(iRow, "code")
		wf_clear_location(szLocation)
		wf_compare(szLocation)
	Next
End If

iTotalDiscrepency	= dw_discrepency.RowCount()
iTotalObjects		= dw_physical.RowCount() + dw_objects.RowCount()

If Not wf_update_accuracy_history(iTotalDiscrepency, iTotalObjects, szLocation, 'L') then
	Rollback;
	MessageBox("SQL Error", SQLCA.SQLErrText, StopSign!)
Else
	wf_show_statitics(szLocation, Today())
End If
end on

on reconcile;Integer iRow 

If IsNull(szLocation) then
	MessageBox("Warning", "You must select location first.", StopSign!)
	Return
End If

If MessageBox("Waring", "This operation will send discrepency to LOST location and make physical inventory as the system inventory, continue to proceed?", Question!, YesNo!) = 1 then
	dw_discrepency.SetFilter("location='" + szLocation + "'")
	dw_discrepency.Filter()

	For iRow = 1 to dw_discrepency.RowCount()
		dw_search_object.Retrieve(dw_discrepency.GetItemNumber(iRow, "serial")) 

		If dw_discrepency.GetItemString(iRow, "physical") = "Y" then
			wf_send_to_location(dw_discrepency.GetItemString(iRow, "location"))
		End If

		If dw_discrepency.GetItemString(iRow, "system") = "Y" then 	//In system but not in physical, then send to LOST
			wf_send_to_location("LOST")
		End If

		dw_discrepency.ScrollToRow(iRow)
		dw_discrepency.SelectRow(iRow, TRUE)
	Next	

	wf_clear_location(szLocation)

	dw_objects.Retrieve(szLocation)

End If
end on

on delete_physical;If iPhysicalRow > 0 then
	If MessageBox("System Message", "Sure to delete object " + &
		String(dw_physical.GetItemNumber(iPhysicalRow, "serial")),&
		StopSign!, YesNo!) = 1 then
		dw_physical.DeleteRow(iPhysicalRow)
	End If
End If
end on

on batch_process;Integer  i_Row, i_FileNum, i, i_Temp

String   s_Serial
String   s_Type, s_Loc

Long     l_Serial

Boolean  b_ValidLocBarCode	 = FALSE
Boolean 	b_MultipleLocation = FALSE
Boolean	b_FirstLine			 = TRUE
Boolean	b_OK					 = TRUE


IF MessageBox ( "Multiple Locations", "Are you importing data for multiple locations?", Question!, YesNo! ) = 2 THEN
	IF IsNull ( szLocation ) THEN
		MessageBox ( "Warning", "Please specify the location first.", StopSign! )
		Return
	END IF
ELSE
	b_MultipleLocation	= TRUE
END IF

IF MessageBox( "System Message", "Batch process will download data from root directory \SCANNER.DAT ~r Please press 'OK' when ready", StopSign!, OKCancel! ) = 2 then
	Return	
END IF	

i_FileNum = FileOpen ( "scanner.dat", LineMode!, Read! )

DO WHILE b_OK AND ( NOT ( FileRead ( i_FileNum, s_Serial ) = -100 OR ( i_FileNum = -1 ) ) )
	s_Serial  = Trim ( s_Serial )
	s_Type	= LeftA ( s_Serial, 1 ) 
	IF s_Serial <> "" THEN
		IF s_Serial = "ERROR" THEN
			MessageBox ( "Error in SCANNER.DAT File", "Please check all connections to ScanPal and be sure that it is connected to the appropriate COM port before downloading data.", StopSign! )  
			b_OK	= FALSE
		ELSE
			IF NOT b_MultipleLocation AND b_FirstLine THEN
				b_FirstLine = FALSE
			END IF
			IF b_MultipleLocation AND b_FirstLine THEN
				b_FirstLine	= FALSE
				IF s_Type <> "L" THEN
					MessageBox ( "Warning", "You must scan a location barcode first!", StopSign! )
					b_OK			= FALSE
				END IF
			END IF			
		END IF
		IF b_OK THEN
			IF s_Type = 'L' AND b_MultipleLocation THEN
				szLocation  = Trim( s_Serial )
				szLocation	= RightA ( szLocation, LenA ( szLocation ) - 1)
			ELSEIF s_Type = "S" THEN
				s_Serial = RightA ( s_Serial, LenA ( s_Serial ) - 1 )
				dw_batch.InsertRow ( 1 )
				dw_batch.SetItem ( 1, 1, s_Serial )
				dw_batch.SetItem ( 1, 2, szLocation )
		   END IF
			IF ( NOT b_MultipleLocation ) AND ( NOT b_FirstLine ) AND ( s_Type = "L" ) THEN
				MessageBox ( "Wrong Mode", "Serial numbers from more than " + &
								 "one location exist in the data file.  You " + &
								 "must be in 'Multiple Locations' mode in order" + &
								 " to batch process this file.", StopSign!, OK! )
				FileClose ( i_FileNum )
				Return
			END IF
		END IF
	END IF
LOOP

IF i_FileNum = -1 THEN
	MessageBox ( "System Error", "Cannot find \SCANNER.DAT file.  Try clicking the ScanPal button to run the Scanner program first.", StopSign! )
END IF

FileClose ( i_FileNum )

IF b_OK THEN 
	FOR i_Row = 1 TO dw_batch.RowCount ( )
		 wf_manual_scan( dw_batch.GetItemString ( i_Row, 2 ), &
							 Long ( dw_batch.GetItemString ( i_Row, 1 ) ) )
	Next
	dw_physical.SetSort("1a")
	dw_physical.Sort()
END IF

s_Loc = dw_Location.GetItemString ( 1, "code" )
 
IF s_Loc <> "" THEN
	dw_physical.SetFilter ( "location='" + s_Loc + "'" )
	dw_physical.Filter ( )
ELSE
	MessageBox ( "Warning",  "Please select Location" )
END IF

end on

on scanpal;IF MessageBox ( "System Message", "You are about to run the ScanPal " + &
					 "program in DOS mode.  Please make sure the ScanPal " + &
					 "unit is connected to an available COM port, then " + &
                "press OK when ready.  Note: When the ScanPal program " + &
					 "prompts you for the scanner data file name that it " + &
                "will create, please type 'SCANNER.'  That is the file " + &
                "'The Monitor' will look for when you run the batch " +  &
                "process.", Information!, OKCancel! ) = 2 Then
	Return	
END IF	

Run ( "SCANPAL.PIF" )




end on

on delete_lost;Long    iRow
Long    iTotalRows
Long    iSerial
Long    l_RowCount
Long    l_Row

String  s_Part

Dec {2} dec_Quantity
Dec {2} dec_OnHand

str_progress stParm

If MessageBox("Warning", "Are you sure you want to delete all objects in LOST location?", Question!, YesNo!) = 1 then

	dw_objects_in_location.Retrieve("LOST")

	stParm.title	= "Delete objects in LOST"
	OpenWithParm(w_progress, stParm)
	
	iTotalRows	= dw_objects_in_location.RowCount()

	For iRow = 1 to iTotalRows

		iSerial		= dw_objects_in_location.GetItemNumber(iRow, "serial")
	
		w_progress.wf_progress(iRow / iTotalRows, "Deleting object " + String(iSerial))

		If f_create_audit_trail(iSerial, "D", "", "", "", "", "", "", "", "", "", "") then

			DELETE FROM object  
   		WHERE serial = :iSerial   ;

			If SQLCA.SQLCode = 0 then
				Commit;
			Else
				Rollback;
			End If

		Else

			MessageBox("SQL Error", SQLCA.SQLErrText, StopSign!)

		End If

		
	Next

	Close(w_progress)

	dw_part_list.Retrieve ( )

	stParm.title = "Updating Quantities OnHand"
	OpenWithParm ( w_progress, stParm )

	l_RowCount = dw_part_list.RowCount ( )
	iRow       = 0
	iTotalRows = 0

	FOR l_Row = 1 TO l_RowCount
		s_Part = dw_part_list.GetItemString ( l_Row, "part" )

		w_progress.wf_progress ( l_Row / l_RowCount, "Updating OnHand for Part: " + s_Part )		

		dw_parts_onhand.Retrieve ( s_Part )
		iTotalRows = dw_parts_onhand.RowCount ( )

		dec_OnHand = 0

		FOR iRow = 1 TO iTotalRows
			dec_Quantity = dw_parts_onhand.GetItemNumber ( iRow, "std_quantity" )
			dec_OnHand   = dec_OnHand + dec_Quantity
		NEXT

		UPDATE part_online
			SET on_hand = :dec_OnHand
		 WHERE part = :s_Part	;

		IF SQLCA.SQLCode = 0 THEN
			Commit;
		ELSE
			MessageBox ( "System Error", "Update of OnHand Failed!", StopSign!, OK! )
			Rollback;
		END IF

	NEXT

	Close ( w_progress )

END IF
end on

on ue_graph;//OpenSheetWithParm(w_, szLocation, w_main_screen, 3, Original!)
end on

on ue_import;Integer  i_Row, i_FileNum, i, i_Temp

String   s_Serial
String   s_Type, s_Loc

Long     l_Serial

Boolean  b_ValidLocBarCode	 = FALSE
Boolean 	b_MultipleLocation = FALSE
Boolean	b_FirstLine			 = TRUE
Boolean	b_OK					 = TRUE


IF MessageBox ( "Multiple Locations", "Are you importing data for multiple locations?", Question!, YesNo! ) = 2 THEN
	IF IsNull ( szLocation ) THEN
		MessageBox ( "Warning", "Please specify the location first.", StopSign! )
		Return
	END IF
ELSE
	b_MultipleLocation	= TRUE
END IF

IF MessageBox( "System Message", "Batch process will download data from root directory \PHYSICAL.DAT ~r Please press 'OK' when ready", StopSign!, OKCancel! ) = 2 then
	Return	
END IF	

i_FileNum = FileOpen ( "PHYSICAL.DAT", LineMode!, Read! )

DO WHILE b_OK AND ( NOT ( FileRead ( i_FileNum, s_Serial ) = -100 OR ( i_FileNum = -1 ) ) )
	s_Serial  = Trim ( s_Serial )
	s_Type	= LeftA ( s_Serial, 1 ) 
	IF s_Serial <> "" THEN
		IF s_Serial = "ERROR" THEN
			MessageBox ( "Error in PHYSICAL.DAT File", "Please check all connections to ScanPal and be sure that it is connected to the appropriate COM port before downloading data.", StopSign! )  
			b_OK	= FALSE
		ELSE
			IF NOT b_MultipleLocation AND b_FirstLine THEN
				b_FirstLine = FALSE
			END IF
			IF b_MultipleLocation AND b_FirstLine THEN
				b_FirstLine	= FALSE
				IF s_Type <> "L" THEN
					MessageBox ( "Warning", "You must scan a location barcode first!", StopSign! )
					b_OK			= FALSE
				END IF
			END IF			
		END IF
		IF b_OK THEN
			IF s_Type = 'L' AND b_MultipleLocation THEN
				szLocation  = Trim( s_Serial )
				szLocation	= RightA ( szLocation, LenA ( szLocation ) - 1)
			ELSEIF s_Type = "S" THEN
				s_Serial = RightA ( s_Serial, LenA ( s_Serial ) - 1 )
				dw_batch.InsertRow ( 1 )
				dw_batch.SetItem ( 1, 1, s_Serial )
				dw_batch.SetItem ( 1, 2, szLocation )
		   END IF
			IF ( NOT b_MultipleLocation ) AND ( NOT b_FirstLine ) AND ( s_Type = "L" ) THEN
				MessageBox ( "Wrong Mode", "Serial numbers from more than " + &
								 "one location exist in the data file.  You " + &
								 "must be in 'Multiple Locations' mode in order" + &
								 " to batch process this file.", StopSign!, OK! )
				FileClose ( i_FileNum )
				Return
			END IF
		END IF
	END IF
LOOP

IF i_FileNum = -1 THEN
	MessageBox ( "System Error", "Cannot find \PHYSICAL.DAT file.  " + &
					 "This backup data file is created only when you " + &
					 "manually scan serial numbers.", StopSign! )
END IF

FileClose ( i_FileNum )

IF b_OK THEN 
	FOR i_Row = 1 TO dw_batch.RowCount ( )
		 wf_manual_scan( dw_batch.GetItemString ( i_Row, 2 ), &
							 Long ( dw_batch.GetItemString ( i_Row, 1 ) ) )
	Next
	dw_physical.SetSort("1a")
	dw_physical.Sort()
END IF

s_Loc = dw_Location.GetItemString ( 1, "code" )
 
IF s_Loc <> "" THEN
	dw_physical.SetFilter ( "location='" + s_Loc + "'" )
	dw_physical.Filter ( )
ELSE
	MessageBox ( "Warning",  "Please select Location" )
END IF
end on

public subroutine wf_delay (integer iNumber);Integer iCount

For iCount = 1 to iNumber
Next
end subroutine

public subroutine wf_compare (string szlocation);Integer iMax
Integer iCount
Integer iDestRow
Long	  iTotalRowso,iTotalRowsp
string  szloc

Boolean bProcess

iMax		= dw_objects.RowCount()

sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_base.visible			= TRUE
sle_percentage.visible	= TRUE
st_status.visible			= TRUE
st_status.text				= "Checking system objects..."
iTotalRowso					= dw_objects.RowCount()

szLoc = dw_location.GetItemString(1,1)

If iTotalRowso <> 0 THEN

For iCount = 1 to iTotalRowso

	sle_percentage.width	= sle_base.width * iCount / iTotalRowso
	
	bProcess	= FALSE
	iDestRow	= dw_physical.Find("serial=" + &
						String(dw_objects.GetItemNumber(iCount, "serial")), &
						1, dw_physical.RowCount()) 

	If iDestRow = 0 then	//In system but not in physical
		bProcess	= TRUE
	End If

	If bProcess then
		
		dw_discrepency.InsertRow(1)
		dw_discrepency.SetItem(1, "serial", dw_objects.GetItemNumber(iCount, "serial"))
		dw_discrepency.SetItem(1, "part", dw_objects.GetItemString(iCount, "part"))
		dw_discrepency.SetItem(1, "system", "Y")
		dw_discrepency.SetItem(1, "location", szLoc)

	End If

	dw_objects.ScrollToRow(iCount)
	dw_objects.SelectRow(iCount, TRUE)

Next

dw_objects.SelectRow(0, FALSE)

End if


iMax			= dw_physical.RowCount()
sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_base.visible			= TRUE
sle_percentage.visible	= TRUE
st_status.visible			= TRUE
st_status.text				= "Checking system objects..."
iTotalRowsp					= dw_physical.RowCount()


If iTotalRowsp <> 0 THEN

For iCount 	= iTotalRowsp to 1 Step -1

	sle_percentage.width	= sle_base.width * (iTotalRowsp - iCount) / iTotalRowsp

	iDestRow = dw_objects.Find("serial=" + &
								String(dw_physical.GetItemNumber(iCount, "serial")), &
								1, dw_objects.RowCount()) 
	If iDestRow = 0 then
		dw_discrepency.InsertRow(1)
		dw_discrepency.SetItem(1, "serial", dw_physical.GetItemNumber(iCount, "serial"))
		dw_discrepency.SetItem(1, "part", dw_physical.GetItemString(iCount, "part"))
		dw_discrepency.SetItem(1, "physical", "Y")
		dw_discrepency.SetItem(1, "location", szLoc)
	End If

 	dw_physical.ScrollToRow(iCount)
	dw_physical.SelectRow(iCount, TRUE)

Next

dw_physical.SelectRow(0, FALSE)

End if

dw_discrepency.SetSort("1a")
dw_discrepency.Sort()

sle_percentage.visible	= FALSE
sle_base.visible			= FALSE
st_status.visible			= FALSE


end subroutine

public subroutine wf_clear_location (string szlocation);Integer iRow

dw_discrepency.SetFilter("location='" + szLocation +"'")
dw_discrepency.Filter()

For iRow = 1 to dw_discrepency.RowCount()
	dw_discrepency.DeleteRow(1)
Next

dw_discrepency.SetFilter("location=''")
dw_discrepency.Filter()




end subroutine

public subroutine wf_send_to_location (string szLocation);If dw_search_object.RowCount() > 0 then
	dw_search_object.SetItem(1, "location", szLocation)
	If dw_search_object.Update() > 0 then
		Commit;
	Else
		RollBack;
	End If
End If
end subroutine

public subroutine wf_manual_scan (string szlocation, long lserial);If dw_objects_scanned.Find("serial = " + String ( lSerial ), 1, dw_physical.RowCount()) > 0 then
	sle_manual.text	= ""
	sle_manual.SetFocus()
	Return
Else
	dw_objects_scanned.InsertRow(1)
	dw_objects_scanned.SetItem(1, "serial", lSerial)
End If

dw_search_object.Retrieve(lSerial)

If dw_search_object.RowCount() > 0 then

	If dw_search_object.GetItemString(1, "type") = 'S' then	//Pallet
		wf_process_pallet(lSerial,szLocation)
		wf_create_backup_data ( lSerial )
	Else																		//Individual boxes
		dw_physical.InsertRow(1)
		dw_physical.SetItem(1, "serial", lSerial)
		dw_physical.SetItem(1, "part", dw_search_object.GetItemString(1, "part"))
		dw_physical.SetItem(1, "quantity", dw_search_object.GetItemNumber(1, "quantity"))
		dw_physical.SetItem(1, "unit_measure", dw_search_object.GetItemString(1, "unit_measure"))
		dw_physical.SetItem(1, "location", szLocation)
		wf_create_backup_data ( lSerial )
	End If

Else
	dw_physical.InsertRow(1)
	dw_physical.SetItem(1, "serial", lSerial)
	dw_physical.SetItem(1, "part", "UNKNOWN")
	dw_physical.SetItem(1, "location", szLocation)
End If		

sle_manual.text	= ""
sle_manual.SetFocus()
end subroutine

public function boolean wf_update_accuracy_history (long itotaldiscrepency, long itotalobjects, string szlocation, string sztype);Date 		dDate

String 	szCode
String 	szGroup

Decimal	nAccuracy

Long		iGroupTotalDisc
Long		iGroupTotalObjs

dDate			= Today()
SetNull(szCode)

If  iTotalObjects <> 0 THEN

nAccuracy	= (iTotalObjects - iTotalDiscrepency) * 100 / iTotalObjects

ELSE
nAccuracy  = 100
End IF

SetNull(szCode)

szGroup	= wf_get_group(szLocation)

SELECT code INTO:szCode FROM inventory_accuracy_history 
 WHERE ( code = :szLocation ) AND  
       ( type = :szType ) AND  
       ( date_counted = :dDate )   ;

If szCode > ' ' then
	UPDATE inventory_accuracy_history  
	   SET accuracy_percentage = :nAccuracy,   
	       total_objects = :iTotalObjects,   
	       total_discrepency = :iTotalDiscrepency  
	 WHERE ( code = :szLocation ) AND  
	       ( type = :szType ) AND  
	       ( date_counted = :dDate )   ;
Else

  	INSERT INTO inventory_accuracy_history  
         (  code,   
            type,   
            date_counted,   
            accuracy_percentage,   
            total_objects,   
            total_discrepency,
				group_no )  
  	VALUES ( :szLocation,   
   	      :szType,   
            :dDate,   
            :nAccuracy,   
            :iTotalObjects,   
            :iTotalDiscrepency,
				:szGroup )  ;

End If


If SQLCA.SQLCode = 0 then		//Successfully update

	COMMIT;

If  szGroup <> ''  Then  //  new null value condition starts here

  	SELECT sum(inventory_accuracy_history.total_objects),   
          sum(inventory_accuracy_history.total_discrepency)  
   INTO   :iGroupTotalObjs,   
          :iGroupTotalDisc  
   FROM   inventory_accuracy_history  
   WHERE  group_no = :szGroup AND date_counted = :dDate  ;

	iGroupTotalDisc	= f_get_value(iGroupTotalDisc)
	iGroupTotalObjs	= f_get_value(iGroupTotalObjs)
	szType				= 'G'
	
	SetNull(szCode)
	SELECT code INTO:szCode FROM inventory_accuracy_history 
 	WHERE ( code = :szGroup ) AND  
   	   ( type = :szType ) AND  
       	( date_counted = :dDate )   ;

	If szCode > ' ' then

		nAccuracy	= (iGroupTotalObjs - iGroupTotalDisc) * 100 / iGroupTotalObjs
		UPDATE inventory_accuracy_history  
		   SET accuracy_percentage = :nAccuracy,   
		       total_objects 		= :iGroupTotalObjs,   
		       total_discrepency 	= :iGroupTotalDisc  
		 WHERE ( code = :szGroup) AND  
		       ( type = :szType ) AND  
		       ( date_counted = :dDate )   ;
	Else
	  	INSERT INTO inventory_accuracy_history  
	         (  code,   
	            type,   
	            date_counted,   
	            accuracy_percentage,   
	            total_objects,   
	            total_discrepency )  
	  	VALUES ( :szGroup,   
	   	      :szType,   
	            :dDate,   
	            :nAccuracy,   
	            :iGroupTotalObjs,   
	            :iGroupTotalDisc )  ;
	End If

	If SQLCA.SQLCode = 0 then
		Commit;
		Return TRUE
	Else
		Return FALSE
	End If

Else 
	MessageBox ("No Groups",  "Group attributes not calculated")
      Return TRUE
End IF

Else
	Return FALSE
End If
end function

public function string wf_get_group (string szlocation);String szGroup

SELECT location.group_no  
  INTO :szGroup  
  FROM location  
 WHERE location.code = :szLocation;

Return f_get_string_value(szGroup)
end function

public subroutine wf_show_graph ();//If rb_group.checked then
//	dw_accuracy.Retrieve('G', Date(sle_date_from.text), Date(sle_date_to.text))
//Else
//	dw_accuracy.Retrieve('L', Date(sle_date_from.text), Date(sle_date_to.text))
//End If
end subroutine

public subroutine wf_show_statitics (string szlocation, date ddate);Long	iTotalObjects
Long	iTotalDiscrepency
Decimal nAccuracy

SELECT total_objects, total_discrepency, accuracy_percentage
  INTO :itotalObjects, :iTotalDiscrepency, :nAccuracy
  FROM inventory_accuracy_history 
 WHERE ( code = :szLocation ) AND  
       ( type = 'L' ) AND  
       ( date_counted = :dDate )   ;

sle_location.text				= szLocation
sle_group.text					= wf_get_group(szLocation)
sle_total_objects.text		= String(iTotalObjects)
sle_total_discrepency.text	= String(iTotalDiscrepency)
sle_accuracy.text				= String(nAccuracy)
	
end subroutine

public function string wf_trim_location (string szLocation);String szChar

szLocation	= Trim(szLocation)
szChar		= Upper(RightA(szLocation, 1))

If ( (szChar > 'A') AND (szChar < 'Z')) OR ((szChar > '1')  AND (szChar < '9')) then
	Return szLocation
Else
	Return LeftA(szLocation, LenA(szLocation) - 1)	
End If




end function

public function string wf_delete_garbage (string szserial);String szChar

szSerial		= Trim(szSerial)
szChar		= Upper(RightA(szSerial, 1))

If ( (szChar >= 'A') AND (szChar <= 'Z')) OR ((szChar >= '1')  AND (szChar <= '9')) then
	Return Trim(szSerial)
Else
	Return Trim(RightA(szSerial, LenA(szSerial) - 1)	)
End If


end function

public subroutine wf_process_pallet (long iparentserial, string szLocation);Long iRow
Long iTotalRows
Long iSerial

Decimal nQuantity

String szPart

dw_objects_on_pallet.Retrieve(iParentSerial)

iTotalRows	= dw_objects_on_pallet.RowCount()

For iRow	= 1 to iTotalRows 

		iSerial	= dw_objects_on_pallet.GetItemNumber(iRow, "serial")
		szPart	= dw_objects_on_pallet.GetItemString(iRow, "part")
		nQuantity= dw_objects_on_pallet.GetItemNumber(iRow, "quantity")

		dw_physical.InsertRow(1)
		dw_physical.SetItem(1, "serial", iSerial)
		dw_physical.SetItem(1, "part", szPart)
		dw_physical.SetItem(1, "quantity", nQuantity)
		dw_physical.SetItem(1, "location", szLocation)

Next 
end subroutine

public subroutine wf_create_backup_data (long a_serial);Int i_FileNum

IF FileExists ( "PHYSICAL.DAT" ) THEN
	i_FileNum = FileOpen ( "PHYSICAL.DAT", Linemode!, Write!, Shared!, Append! )
ELSE
	i_FileNum = FileOpen ( "PHYSICAL.DAT", Linemode!, Write!, Shared!, Replace! )
END IF

IF i_FileNum <> -1 THEN
	FileWrite ( i_FileNum, ( is_Type + String ( a_Serial ) ) )
	FileClose ( i_FileNum )
ELSE
	MessageBox ( "Error", "Error writing to backup data file.  However" + &
					 ", this will not interfere with the manual scan " + &
					 "process.", Exclamation!, OK! )
	FileClose ( i_FileNum )
END IF


end subroutine

on open;dw_location.SetTransObject(sqlca)
dw_objects.SetTransObject(sqlca)
dw_physical.SetTransObject(sqlca)
dw_search_object.SetTransObject(sqlca)
dw_objects_in_location.SetTransObject(sqlca)
dw_objects_on_pallet.SetTransObject(sqlca)
dw_part_list.SetTransObject ( SQLCA )
dw_parts_onhand.SetTransObject ( SQLCA )

dw_physical.Modify("serial.color = '0 ~tif(IsNull(quantity), 255, 0)'") 
dw_location.Retrieve()
dw_location.SetSort("1a")
dw_location.Sort()
dw_location.InsertRow(1)

SetNull(szLocation)



end on

on w_physical_inventory.create
int iCurrent
call super::create
if this.MenuName = "m_physical_inventory" then this.MenuID = create m_physical_inventory
this.dw_part_list=create dw_part_list
this.dw_parts_onhand=create dw_parts_onhand
this.st_manual3=create st_manual3
this.st_manual2=create st_manual2
this.cb_manual2=create cb_manual2
this.sle_accuracy=create sle_accuracy
this.sle_total_discrepency=create sle_total_discrepency
this.sle_total_objects=create sle_total_objects
this.sle_group=create sle_group
this.sle_location=create sle_location
this.st_6=create st_6
this.st_5=create st_5
this.st_status=create st_status
this.sle_percentage=create sle_percentage
this.dw_objects_scanned=create dw_objects_scanned
this.dw_objects_on_pallet=create dw_objects_on_pallet
this.st_manual=create st_manual
this.sle_manual=create sle_manual
this.dw_objects_in_location=create dw_objects_in_location
this.st_2=create st_2
this.dw_batch=create dw_batch
this.cbx_1=create cbx_1
this.dw_search_object=create dw_search_object
this.dw_location=create dw_location
this.cb_manual=create cb_manual
this.dw_discrepency=create dw_discrepency
this.sle_base=create sle_base
this.dw_objects=create dw_objects
this.st_1=create st_1
this.st_4=create st_4
this.st_3=create st_3
this.dw_physical=create dw_physical
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_part_list
this.Control[iCurrent+2]=this.dw_parts_onhand
this.Control[iCurrent+3]=this.st_manual3
this.Control[iCurrent+4]=this.st_manual2
this.Control[iCurrent+5]=this.cb_manual2
this.Control[iCurrent+6]=this.sle_accuracy
this.Control[iCurrent+7]=this.sle_total_discrepency
this.Control[iCurrent+8]=this.sle_total_objects
this.Control[iCurrent+9]=this.sle_group
this.Control[iCurrent+10]=this.sle_location
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_status
this.Control[iCurrent+14]=this.sle_percentage
this.Control[iCurrent+15]=this.dw_objects_scanned
this.Control[iCurrent+16]=this.dw_objects_on_pallet
this.Control[iCurrent+17]=this.st_manual
this.Control[iCurrent+18]=this.sle_manual
this.Control[iCurrent+19]=this.dw_objects_in_location
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.dw_batch
this.Control[iCurrent+22]=this.cbx_1
this.Control[iCurrent+23]=this.dw_search_object
this.Control[iCurrent+24]=this.dw_location
this.Control[iCurrent+25]=this.cb_manual
this.Control[iCurrent+26]=this.dw_discrepency
this.Control[iCurrent+27]=this.sle_base
this.Control[iCurrent+28]=this.dw_objects
this.Control[iCurrent+29]=this.st_1
this.Control[iCurrent+30]=this.st_4
this.Control[iCurrent+31]=this.st_3
this.Control[iCurrent+32]=this.dw_physical
this.Control[iCurrent+33]=this.gb_3
this.Control[iCurrent+34]=this.gb_4
this.Control[iCurrent+35]=this.gb_2
this.Control[iCurrent+36]=this.gb_1
end on

on w_physical_inventory.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_part_list)
destroy(this.dw_parts_onhand)
destroy(this.st_manual3)
destroy(this.st_manual2)
destroy(this.cb_manual2)
destroy(this.sle_accuracy)
destroy(this.sle_total_discrepency)
destroy(this.sle_total_objects)
destroy(this.sle_group)
destroy(this.sle_location)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_status)
destroy(this.sle_percentage)
destroy(this.dw_objects_scanned)
destroy(this.dw_objects_on_pallet)
destroy(this.st_manual)
destroy(this.sle_manual)
destroy(this.dw_objects_in_location)
destroy(this.st_2)
destroy(this.dw_batch)
destroy(this.cbx_1)
destroy(this.dw_search_object)
destroy(this.dw_location)
destroy(this.cb_manual)
destroy(this.dw_discrepency)
destroy(this.sle_base)
destroy(this.dw_objects)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_physical)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_part_list from datawindow within w_physical_inventory
boolean visible = false
integer x = 1957
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 100
string dataobject = "dw_list_of_parts_mic"
boolean livescroll = true
end type

type dw_parts_onhand from datawindow within w_physical_inventory
boolean visible = false
integer x = 1632
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 90
string dataobject = "d_parts_onhand"
boolean livescroll = true
end type

type st_manual3 from statictext within w_physical_inventory
boolean visible = false
integer x = 910
integer y = 856
integer width = 1275
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Type in serial number then press Enter button to accept"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_manual2 from statictext within w_physical_inventory
boolean visible = false
integer x = 1051
integer y = 464
integer width = 1006
integer height = 72
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Manual Scan Serial Numbers"
boolean focusrectangle = false
end type

type cb_manual2 from commandbutton within w_physical_inventory
boolean visible = false
integer x = 1435
integer y = 1020
integer width = 247
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;cb_manual.visible		= FALSE
cb_manual2.visible	= FALSE
st_manual.visible		= FALSE
sle_manual.visible	= FALSE
st_manual2.visible   = FALSE
st_manual3.visible   = FALSE

dw_physical.SetSort("1a")
dw_physical.Sort()
end on

type sle_accuracy from singlelineedit within w_physical_inventory
integer x = 2322
integer y = 1264
integer width = 384
integer height = 80
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type sle_total_discrepency from singlelineedit within w_physical_inventory
integer x = 2322
integer y = 1168
integer width = 384
integer height = 80
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type sle_total_objects from singlelineedit within w_physical_inventory
integer x = 2322
integer y = 1072
integer width = 384
integer height = 80
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type sle_group from singlelineedit within w_physical_inventory
integer x = 2322
integer y = 976
integer width = 384
integer height = 80
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type sle_location from singlelineedit within w_physical_inventory
integer x = 2322
integer y = 880
integer width = 384
integer height = 80
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
end type

type st_6 from statictext within w_physical_inventory
integer x = 1486
integer y = 1264
integer width = 645
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Accuracy Percentage (%):"
boolean focusrectangle = false
end type

type st_5 from statictext within w_physical_inventory
integer x = 1486
integer y = 1176
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Total Discrepency:"
boolean focusrectangle = false
end type

type st_status from statictext within w_physical_inventory
boolean visible = false
integer x = 1883
integer y = 48
integer width = 585
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Status:"
boolean focusrectangle = false
end type

type sle_percentage from singlelineedit within w_physical_inventory
boolean visible = false
integer x = 2487
integer y = 64
integer width = 37
integer height = 32
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_objects_scanned from datawindow within w_physical_inventory
boolean visible = false
integer x = 1307
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 80
string dataobject = "dw_external_physical_objects_in_location"
boolean livescroll = true
end type

type dw_objects_on_pallet from datawindow within w_physical_inventory
boolean visible = false
integer x = 983
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 230
string dataobject = "dw_objects_on_pallets_mic"
boolean livescroll = true
end type

type st_manual from statictext within w_physical_inventory
boolean visible = false
integer x = 1321
integer y = 672
integer width = 471
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Serial Number"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_manual from singlelineedit within w_physical_inventory
boolean visible = false
integer x = 1326
integer y = 744
integer width = 471
integer height = 104
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
end type

on modified;Long 		iSerial
Long		iLength

String 	szSerial, szValidSerial, s_ValidLocation

szSerial	= Trim ( This.Text )

IF Upper ( LeftA ( szSerial, 1 ) ) = "S" THEN
	is_Type = "S"
	iLength	= LenA ( szSerial )
	szSerial	= RightA ( szSerial, iLength - 1 )
ELSEIF Upper ( LeftA ( szSerial, 1 ) ) = "L" THEN
	is_Type = "L"
	iLength	= LenA ( szLocation )
	szSerial	= RightA ( szSerial, iLength - 1 )
ELSE
	is_Type = "S"
END IF

IF is_Type = "S" THEN
	SELECT	serial
	INTO		:szValidSerial
	FROM		object
	WHERE		serial = :szSerial;
ELSEIF is_Type = "L" THEN
	SELECT	code
	INTO		:s_ValidLocation
	FROM		location
	WHERE		code = :szLocation	;
END IF
	
IF  SQLCA.SQLCode <> 0  THEN
	MessageBox ("Validation error",  "Not a valid Serial Number or Location")
ELSE
	wf_manual_scan(szLocation, Long (szSerial))
END IF
end on

type dw_objects_in_location from datawindow within w_physical_inventory
boolean visible = false
integer x = 658
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 220
string dataobject = "dw_serial_in_location"
boolean livescroll = true
end type

type st_2 from statictext within w_physical_inventory
integer x = 55
integer y = 32
integer width = 256
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Location:"
boolean focusrectangle = false
end type

type dw_batch from datawindow within w_physical_inventory
boolean visible = false
integer x = 9
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 210
string dataobject = "dw_external_template"
boolean vscrollbar = true
boolean livescroll = true
end type

type cbx_1 from checkbox within w_physical_inventory
boolean visible = false
integer x = 695
integer y = 144
integer width = 677
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Compare all locations"
end type

type dw_search_object from datawindow within w_physical_inventory
boolean visible = false
integer x = 334
integer y = 1432
integer width = 325
integer height = 252
integer taborder = 240
string dataobject = "dw_search_object_info"
boolean livescroll = true
end type

type dw_location from datawindow within w_physical_inventory
event key_pressed pbm_char
integer x = 343
integer y = 32
integer width = 622
integer height = 96
integer taborder = 10
string dataobject = "dw_location_dropdown_grey"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on key_pressed;//***********************************************************************
//* Declaration
//***********************************************************************

String	szChar				//The current character
Long		iFound_row			//The row found
Int		iNum_chars			//The total characters

//***********************************************************************
//* Initialization
//***********************************************************************


//***********************************************************************
//* Main Routine
//***********************************************************************

szChar = CharA(message.wordparm)			//Get the current character pressed
If Message.wordparm = 8 /* Backspace */  then
	iNum_chars = LenA(szFilter)
	If iNum_chars > 0 then szFilter = LeftA(szFilter, iNum_chars -1)		
													// Throw away last character
	Else
		szFilter = szFilter + szChar
End If

If LenA(szFilter) > 0 then					// Do case-insensitive search
	iFound_row = This.Find("serial = " + Lower(szFilter) , 1 , 99999)

	If iFound_row > 0 then 
		This.ScrollToRow(iFound_row)
		//This.SetRedraw(FALSE)
		//This.SelectRow(iSelectedRow, FALSE)
		//This.SelectRow(iFound_row, TRUE)
		//This.SetRedraw(TRUE)
	Else	// Filter function did not find any matching row
	   Beep(1)
		iNum_chars = LenA(szFilter)
		If iNum_chars > 0 then szFilter = LeftA(szFilter, iNum_chars -1)		
													// Throw away last character
		Message.processed = true
	End if
End if




end on

on itemchanged;integer iTotalRowso
szLocation = Trim(this.GetText())

dw_objects.Retrieve(szLocation)

dw_physical.SetFilter("location = '" + szLocation + "'")
dw_physical.Filter()

dw_physical.SetSort("1a")
dw_physical.Sort()

//dw_discrepency.SetFilter("location= '" + szLocation + "'")
//dw_discrepency.Filter()
dw_discrepency.SetFilter("location= ''")
dw_discrepency.Filter()


//  Refresh data Accuracy group box
//sle_percentage.visible	= FALSE
//sle_percentage.width		= 0
//sle_base.visible			= TRUE
//sle_percentage.visible	= TRUE
//st_status.visible			= TRUE
//st_status.text				= "Checking system objects..."
iTotalRowso					= dw_objects.RowCount()
sle_location.text				= ""
sle_group.text					= ""
sle_total_objects.text		= ""
sle_total_discrepency.text	= ""
sle_accuracy.text				= ""

//Show Statistics
//wf_show_statitics(szLocation, Today())


end on

on editchanged;//***********************************************************************
//* Declaration
//***********************************************************************

String	szChar				//The current character
Long		iFound_row			//The row found
Int		iNum_chars			//The total characters

//***********************************************************************
//* Initialization
//***********************************************************************


//***********************************************************************
//* Main Routine
//***********************************************************************

szFilter	= this.GetText()

If LenA(szFilter) > 0 then					// Do case-insensitive search
	iFound_row = This.Find("code = '" + Lower(szFilter) + "'" , 1 , 99999)

	If iFound_row > 0 then 
		This.ScrollToRow(iFound_row)
	End if
End if




end on

type cb_manual from commandbutton within w_physical_inventory
boolean visible = false
integer x = 896
integer y = 436
integer width = 1298
integer height = 736
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type dw_discrepency from datawindow within w_physical_inventory
integer x = 55
integer y = 864
integer width = 1280
integer height = 560
integer taborder = 150
string dataobject = "dw_external_discrepency"
boolean vscrollbar = true
boolean livescroll = true
end type

type sle_base from singlelineedit within w_physical_inventory
boolean visible = false
integer x = 2487
integer y = 64
integer width = 238
integer height = 32
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_objects from datawindow within w_physical_inventory
integer x = 50
integer y = 224
integer width = 1280
integer height = 544
integer taborder = 50
string dataobject = "dw_objects_in_location_size10"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_physical_inventory
integer x = 1486
integer y = 912
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Location:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_physical_inventory
integer x = 1486
integer y = 1088
integer width = 640
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Total Objects Processed:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_physical_inventory
integer x = 1486
integer y = 996
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Group:"
boolean focusrectangle = false
end type

type dw_physical from datawindow within w_physical_inventory
integer x = 1371
integer y = 228
integer width = 1390
integer height = 544
integer taborder = 250
string dataobject = "dw_external_physical_objects_in_location"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

on clicked;iPhysicalRow	= this.GetClickedRow()

If iPhysicalRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iPhysicalRow, TRUE)
End If
end on

type gb_3 from groupbox within w_physical_inventory
integer x = 1371
integer y = 148
integer width = 1390
integer height = 624
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Objects in Physical Inventory"
end type

type gb_4 from groupbox within w_physical_inventory
integer x = 1371
integer y = 800
integer width = 1390
integer height = 624
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Accuracy"
end type

type gb_2 from groupbox within w_physical_inventory
integer x = 55
integer y = 800
integer width = 1280
integer height = 624
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Discrepency"
end type

type gb_1 from groupbox within w_physical_inventory
integer x = 55
integer y = 148
integer width = 1280
integer height = 624
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Objects in Database"
end type

