$PBExportHeader$w_part_inquiry.srw
forward
global type w_part_inquiry from w_inquiry_ancestor
end type
end forward

global type w_part_inquiry from w_inquiry_ancestor
string title = "Part Setup"
string menuname = "m_part_inquiry"
string defaultsheetname = "w_part_master"
end type
global w_part_inquiry w_part_inquiry

on w_part_inquiry.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_part_inquiry" then this.MenuID = create m_part_inquiry
end on

on w_part_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_add;call super::ue_add;OpenSheet ( DefaultSheet, DefaultSheetName, gnv_App.of_GetFrame(), 3, Original! )
end event

event ue_delete;String 	szPart,&
		l_s_dummy
long		l_l_row,&
		l_l_count

l_l_row = dw_inquiry.GetRow ( )

if l_l_row < 1 or NOT dw_inquiry.IsSelected ( l_l_row ) then return

szPart = dw_inquiry.GetItemString ( l_l_row, "part" )

DECLARE part_vendor_relationship CURSOR FOR  
SELECT part_vendor.part  
FROM part_vendor  
WHERE part_vendor.part = :szPart   ;

DECLARE releases_exist CURSOR FOR  
SELECT po_detail.po_number  
FROM po_detail  
WHERE po_detail.part_number = :szPart   ;

//  Check for existing objects with part number

SELECT count(object.serial)
INTO :l_l_count
FROM object  
WHERE object.part = :szPart   ;

If l_l_count > 0 Then 
MessageBox ( "Error", "Objects exist with this part number,~r" + &
								 "        Unable to Delete!", StopSign! )
Return
End if

// check for existing bill of material with part number 

select count(bom.parent_part)
into :l_l_count	  
from bill_of_material_ec bom
where ( bom.parent_part = :szPart ) and
	(bom.end_datetime > getdate(*) or
	 bom.end_datetime is null);

if l_l_count > 0 then
MessageBox ( monsys.msg_title, "bill of material exists with this part number,~r" + &
									"		Unable to Delete!", StopSign!)
return
end if
//
select count(bom.part)
into :l_l_count	  
from bill_of_material_ec bom
where ( bom.part = :szPart ) and
	(bom.end_datetime > getdate(*) or
	 bom.end_datetime is null);

if l_l_count > 0 then
MessageBox ( monsys.msg_title, "bill of material exists with this part number,~r" + &
									"		Unable to Delete!", StopSign!)
return
end if

//check for existing blanket orders with the part number

select count(order_no) 
into :l_l_count
from order_header 
where order_header.blanket_part = :szPart ;

if l_l_count > 0 then
MessageBox ( monsys.msg_title, "Orders exists with this part number,~r" + &
									"		Unable to Delete!", StopSign!)
return
end if

//check for existing orders with the part number

select count(order_no) 
into :l_l_count
from order_detail 
where order_detail.part_number = :szPart ;

if l_l_count > 0 then
MessageBox ( monsys.msg_title, "Orders exists with this part number,~r" + &
									"		Unable to Delete!", StopSign!)
return
end if


Open part_vendor_relationship ;
Fetch part_vendor_relationship Into :l_s_Dummy ;

If SQLCA.SQLCode = 0 Then
MessageBox ( "Error", "There is a part-vendor relationship setup~r" + &
							 " for this part number, Unable to Delete!", StopSign! )
Close part_vendor_relationship ;
Return
End if
Close part_vendor_relationship ;

Open releases_exist ;
Fetch releases_exist Into :l_s_Dummy ;

If SQLCA.SQLCode = 0 Then
MessageBox ( "Error", "There are active releases for this part~r" + &
							 "      number, Unable to Delete!", StopSign! )
Close releases_exist ;
Return
End if
Close releases_exist ;


If MessageBox ( "Delete", "Do you really want to delete part " + szPart + "?", Question!, YesNo!, 2 ) = 1 Then

gnv_App.of_GetFrame().SetMicroHelp ( "Deleting Records..." )

DELETE FROM part_characteristics  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_inventory  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

//   DELETE FROM part_mfg  
//    WHERE part = :szPart   ;
//
//	If SQLCA.SQLCode = -1 Then
//		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
//		RollBack ;
//		Return
//	End if

DELETE FROM part_customer  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_customer_price_matrix  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_machine  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_online  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_packaging  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_purchasing  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_revision  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if


DELETE FROM part_standard  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_unit_conversion  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_vendor_price_matrix  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if

DELETE FROM part_vendor  
 WHERE part = :szPart   ;

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
else
	commit;
End if

  DELETE FROM bill_of_material_ec   
  WHERE (bill_of_material_ec.parent_part = :szPart) and
	(bill_of_material_ec.end_datetime > getdate(*) or
	 bill_of_material_ec.end_datetime is null);  

If SQLCA.SQLCode = -1 Then
	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
	RollBack ;
End if
//added the following to enable delete of new part-sm 5/17/00
DELETE FROM part
WHERE part = :szPart   ;
	
	If SQLCA.SQLCode = -1 Then
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed! " + SQLCA.SQLErrText )
		RollBack ;
	else
		commit;
		gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )
	End if


dw_inquiry.DeleteRow ( l_l_row )

//If dw_inquiry.Update ( ) = -1 then
//
//	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Failed!" + sqlca.sqlerrtext)
//	RollBack ;
//Else
//	Commit ;
//
//	gnv_App.of_GetFrame().SetMicroHelp ( "Delete Successful!" )
//
//End if

//else
//	commit;
//
End if

dw_inquiry.SetFocus ( )

end event

event pfc_preopen;call super::pfc_preopen;TableNames = {"part"}

end event

type st_1 from w_inquiry_ancestor`st_1 within w_part_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_part_inquiry
string dataobject = "d_part_inquiry_setups"
boolean hsplitscroll = true
integer rowselection = 1
end type

event dw_inquiry::doubleclicked;string	l_s_part

dw_inquiry.DBcancel()

if row < 1 then return

l_s_part = GetItemString ( row, "part" )

OpenSheetWithParm ( DefaultSheet, l_s_part, DefaultSheetName, gnv_App.of_GetFrame(), 3, Original! )
end event

event dw_inquiry::constructor;call super::constructor;
of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.SINGLE)

end event

