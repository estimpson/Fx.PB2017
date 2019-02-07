$PBExportHeader$w_machine_inventory.srw
forward
global type w_machine_inventory from Window
end type
type dw_scan_serial from datawindow within w_machine_inventory
end type
type cb_stopwo from commandbutton within w_machine_inventory
end type
type cb_consumed from commandbutton within w_machine_inventory
end type
type cb_wo from commandbutton within w_machine_inventory
end type
type cb_5 from commandbutton within w_machine_inventory
end type
type dw_header from datawindow within w_machine_inventory
end type
type dw_bill from datawindow within w_machine_inventory
end type
type dw_workorder_detail from datawindow within w_machine_inventory
end type
type cb_2 from commandbutton within w_machine_inventory
end type
type dw_transactions from datawindow within w_machine_inventory
end type
type cb_1 from commandbutton within w_machine_inventory
end type
type st_3 from statictext within w_machine_inventory
end type
type st_1 from statictext within w_machine_inventory
end type
type cb_4 from commandbutton within w_machine_inventory
end type
type cb_message from commandbutton within w_machine_inventory
end type
type st_4 from statictext within w_machine_inventory
end type
type rb_1 from radiobutton within w_machine_inventory
end type
type rb_2 from radiobutton within w_machine_inventory
end type
type dw_objects from datawindow within w_machine_inventory
end type
type cb_3 from commandbutton within w_machine_inventory
end type
type cb_6 from commandbutton within w_machine_inventory
end type
type dw_common_set from datawindow within w_machine_inventory
end type
end forward

global type w_machine_inventory from Window
int X=0
int Y=0
int Width=2898
int Height=2244
boolean TitleBar=true
string Title="Machine Inventory/Material Issues"
long BackColor=78748035
boolean ControlMenu=true
boolean MinBox=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
string Icon="msf.ico"
dw_scan_serial dw_scan_serial
cb_stopwo cb_stopwo
cb_consumed cb_consumed
cb_wo cb_wo
cb_5 cb_5
dw_header dw_header
dw_bill dw_bill
dw_workorder_detail dw_workorder_detail
cb_2 cb_2
dw_transactions dw_transactions
cb_1 cb_1
st_3 st_3
st_1 st_1
cb_4 cb_4
cb_message cb_message
st_4 st_4
rb_1 rb_1
rb_2 rb_2
dw_objects dw_objects
cb_3 cb_3
cb_6 cb_6
dw_common_set dw_common_set
end type
global w_machine_inventory w_machine_inventory

type variables
String is_Defect
String is_machine 
String is_workorder
String is_part,  & 
          is_undopart
String i_s_scannedserial
String is_SubPart	//Substitute Part Yes/No
Long  iObjectRow                 //Row number
Long  iSerial                         //Serial number
Long  iAuditRow                    //Audit trail row
Long  iCommonSetRow=0

Boolean bDragAudit = FALSE //Whether dragging audit trail 
Boolean bDragBox = FALSE   //Whether object is dragged
Boolean bAllowReverse 
uo_nvo_material_issues i_uo_nvo_mi
end variables

forward prototypes
public subroutine wf_create_common_set ()
public subroutine wf_message (boolean bType)
public subroutine wf_scrap_qty ()
public function integer wf_create_defect_code (string as_quantity)
public function long wf_issues (long al_serial, character ac_mode)
public function boolean wf_allow_reverse (string as_machine)
end prototypes

public subroutine wf_create_common_set ();//	Declarations
String 	ls_part		//Current part number
string  ls_type		//Part type in bom
Long	iRow		//Row number
Long	iBillRow	//Row number in the bill of material
Long	iComRow		//Row number in the common set datawindow
Decimal	ld_qty		//Quantity
Decimal ld_qty_completed

ld_qty_completed = w_machine.dw_3.getitemdecimal(1,'qty_completed')
dw_workorder_detail.Retrieve(is_WorkOrder)

// Based on whether the material substutition is enabled or not, assign the respective dataobject
if is_SubPart = 'Y' then
	dw_common_set.dataobject = "dw_common_set_for_bill_of_material"
else	
	dw_common_set.dataobject = "dw_common_set_for_bom_without"
end if 	

dw_common_set.settransobject ( sqlca ) 
dw_common_set.Retrieve ( is_WorkOrder , ld_qty_completed)

iComRow = dw_common_set.Rowcount()
if (iComRow > 0) then
	for iRow = 1 to iComRow
		 ls_part = dw_common_set.getitemstring(iRow,"part")
		 select type, quantity
		   into :ls_type, :ld_qty
  		   from bill_of_material
		  where (part = :ls_part) ;
		 if (ls_type = 'T') then dw_common_set.SetItem(iRow, "cwo_quantity", ld_qty)		 
	next
end if 

if iCommonSetRow > 0 then 
	dw_common_set.scrolltorow ( iCommonSetRow ) 
	dw_common_set.SelectRow ( iCommonSetRow, True )
end if 	
		

end subroutine

public subroutine wf_message (boolean bType);If bType Then
	cb_message.Show ( )
	st_4.Show ( )
	rb_1.Show ( )
	rb_2.Show ( )
	cb_3.Show ( )
	cb_4.Show ( )
Else
	st_4.Hide ( )
	rb_1.Hide ( )
	rb_2.Hide ( )
	cb_3.Hide ( )
	cb_4.Hide ( )
	cb_message.Show ( )
End if
end subroutine

public subroutine wf_scrap_qty ();
end subroutine

public function integer wf_create_defect_code (string as_quantity);st_generic_structure st_Parm

st_Parm.Value1 = is_Machine
st_Parm.Value2 = is_Part
st_Parm.Value3 = as_Quantity
st_Parm.Value4 = szOperator
st_Parm.Value5 = is_WorkOrder

OpenWithParm ( w_defect, st_Parm )

return 0
end function

public function long wf_issues (long al_serial, character ac_mode);//	Declarations
datetime	ldt_LastMaterialIssue

decimal	ln_ObjectQuantity
decimal	ln_QtyIss
decimal	ln_QtyReq
decimal	ln_IssueQty
decimal	ln_IssueAltQty
decimal	ln_RemObjectQty
decimal	ln_RemObjectAltQty

integer	li_ReturnCode

long	ll_LastMaterialIssue
long	ll_InvalidLot

string	ls_ObjectPart
string	ls_ObjectStatus
string	ls_ObjectUnit
string	ls_ObjectPlant

st_generic_structure	lst_Parm

//	Get Object info.
select	part,
	status,
	std_quantity,
	unit_measure,
	plant
into	:ls_ObjectPart,
	:ls_ObjectStatus,
	:ln_ObjectQuantity,
	:ls_ObjectUnit,
	:ls_ObjectPlant
from	object
where	serial = :al_Serial  ;

//	Verify serial was found.
if SQLCA.SQLCode <> 0 then
	MessageBox ( "Warning!", "Invalid Serial." )
	if ac_Mode = "S" then
		dw_scan_serial.setitem ( 1 , "scan_serial", "" )
		dw_scan_serial.setfocus ( )
	end if
	return -1
end if

//	Verify object status is approved.
if ls_ObjectStatus <> "A" then
	MessageBox ( "Warning!", "Object not approved." )
	if ac_Mode = "S" then
		dw_scan_serial.setitem ( 1 , "scan_serial", "" )
		dw_scan_serial.setfocus ( )
	end if
	return -1
end if

//	Find the last material issue for this part and workorder.
select	Max ( date_stamp )
into	:ldt_LastMaterialIssue
from	audit_trail
where	type = 'M' and
	workorder = :is_WorkOrder and
	part = :ls_ObjectPart  ;

select	Max ( serial )
into	:ll_LastMaterialIssue
from	audit_trail
where	type = 'M' and
	date_stamp = :ldt_LastMaterialIssue  ;

//	Check for invalid lot change.
select	1
into	:ll_InvalidLot
from	parameters
	join work_order on work_order.work_order = :is_WorkOrder and
		lot_control_activated = 'Y'
	join part_inventory on part_inventory.part = :ls_ObjectPart and
		part_inventory.safety_part = 'Y'
	join audit_trail on audit_trail.serial = :ll_LastMaterialIssue and
		date_stamp = :ldt_LastMaterialISsue and
		audit_trail.type = 'M'
	join object on object.serial = :al_Serial
where	(	audit_trail.custom1 <> object.custom1 and
		parameters.shop_floor_check_u1 = 'Y' ) or
	(	audit_trail.custom2 <> object.custom2 and
		parameters.shop_floor_check_u2 = 'Y' ) or
	(	audit_trail.custom3 <> object.custom3 and
		parameters.shop_floor_check_u3 = 'Y' ) or
	(	audit_trail.custom4 <> object.custom4 and
		parameters.shop_floor_check_u4 = 'Y' ) or
	(	audit_trail.custom5 <> object.custom5 and
		parameters.shop_floor_check_u5 = 'Y' ) or
	(	audit_trail.lot <> object.lot and
		parameters.shop_floor_check_lot = 'Y' )  ;

if ll_InvalidLot = 1 then
	li_ReturnCode = MessageBox ( "Error", "This material can not be issued without first completing old material.  You need to perform job completions first or choose a different material.  Would you like to go to the completion screen?", Question!, YesNo!, 1 )
	if li_ReturnCode = 1 then
		lst_Parm.Value1 = szOperator
		lst_Parm.Value2 = is_Part
		lst_Parm.Value3 = is_Machine
		lst_Parm.Value4 = is_WorkOrder
		lst_Parm.Value10 = "ForceJC"
		OpenWithParm ( w_part_production, lst_Parm )
	end if
	return -1
end if

//	Mark work order for lot change.
update	work_order
set	lot_control_activated = 'Y'
where	work_order = :is_WorkOrder  ;

//	Calculate issue quantity appropriately, depending on the mode.
select	isnull(Sum ( audit_trail.std_quantity ),0)
into	:ln_QtyIss
from	audit_trail
where	workorder = :is_WorkOrder and
	type = 'M' and
	audit_trail.part = :ls_ObjectPart  ;

choose case ac_Mode
	case "L"	//	Issue one lot's worth.
		select	isnull(Sum ( bill_of_material.std_qty * part_machine.mfg_lot_size ),0)
		into	:ln_QtyReq
		from	workorder_detail
			join work_order on work_order.work_order = workorder_detail.workorder
			join part_machine on part_machine.part = workorder_detail.part and
				part_machine.machine = work_order.machine_no
			join bill_of_material on workorder_detail.part = bill_of_material.parent_part 
		where	workorder_detail.workorder = :is_WorkOrder and
			bill_of_material.part = :ls_ObjectPart ;
		
		ln_IssueQty = ln_QtyReq - Mod ( ln_QtyIss, ln_QtyReq )
	case "T"	//	Issue for whole work order.
		select	isnull(Sum ( bill_of_material.std_qty * workorder_detail.qty_required ),0)
		into	:ln_QtyReq
		from	workorder_detail
			join work_order on work_order.work_order = workorder_detail.workorder
			join bill_of_material on workorder_detail.part = bill_of_material.parent_part
		where	workorder_detail.workorder = :is_WorkOrder and
			bill_of_material.part = :ls_ObjectPart;
		
		ln_IssueQty = ln_QtyReq - ln_QtyIss
	case "C"	//	Issue consumed quantity.
		select	isnull(Sum ( bill_of_material.std_qty * workorder_detail.qty_completed ),0)
		into	:ln_QtyReq
		from	workorder_detail
			join work_order on work_order.work_order = workorder_detail.workorder
			join bill_of_material on workorder_detail.part = bill_of_material.parent_part
		where	workorder_detail.workorder = :is_WorkOrder and
			bill_of_material.part = :ls_ObjectPart;
		
		ln_IssueQty = ln_QtyReq - ln_QtyIss
	case "S"	//	Issue entire object.
		
		ln_IssueQty = ln_ObjectQuantity //ln_QtyIss changed from qtyiss to objectqty
end choose

//	Calculate the actual issue quantity, alternate quantity, remaining object quantity, and remaining object alternate quantity.
if ln_IssueQty >= ln_ObjectQuantity then
	
	//	Full object to be consumed.
	ln_IssueQty = ln_ObjectQuantity
	ln_IssueAltQty = f_convert_units ( "", ls_ObjectUnit, ls_ObjectPart, ln_IssueQty )
	
	ln_RemObjectQty = 0
	ln_RemObjectAltQty = 0
else
	
	//	Partial object remaining.
	ln_IssueAltQty = f_convert_units ( "", ls_ObjectUnit, ls_ObjectPart, ln_IssueQty )
	
	ln_RemObjectQty = ln_ObjectQuantity - ln_IssueQty
	ln_RemObjectAltQty = f_convert_units ( "", ls_ObjectUnit, ls_ObjectPart, ln_RemObjectQty )
end if

if	ln_IssueQty > 0 then 
	//	Create audit trail for the issue.
	if not f_create_audit_trail ( al_Serial, "M", String ( ln_IssueAltQty ), String ( ln_IssueQty ), ls_ObjectUnit, is_machine, "", "", ls_ObjectPlant, is_WorkOrder, szOperator, "No Commit") then
		
		//	Failure writing audit_trail, rollback.
		rollback  ;
		
		MessageBox ( "Error", "Unable to write to audit trail." )
		Return -1
	end if
	
	//	Delete object or update and print new label.
	if ln_RemObjectQty > 0 then
		
		//	Update object and print new label.
		update	object
		set	quantity = :ln_RemObjectAltQty,
			std_quantity = :ln_RemObjectQty
		where	serial = :al_Serial  ;
		
		if SQLCA.SQLCode <> 0 then
			
			//	Failure update object, rollback.
			rollback  ;
			
			MessageBox ( "Error", "Unable to set quantity on object." )
			Return -1
		end if
		
		update	part_online
		set	on_hand = on_hand - :ln_IssueQty
		where	part = :ls_ObjectPart  ;
		
		if SQLCA.SQLCode <> 0 then
			
			//	Failure update part online, rollback.
			rollback  ;
			
			MessageBox ( "Error", "Unable to update part online." )
			Return -1
		end if
		
		commit  ;
		
		lst_Parm.Value1 = String ( al_Serial )
		f_print_label ( lst_Parm )
	else
		
		//	Remove object.
		delete	object
		where	serial = :al_Serial  ;
	
		if SQLCA.SQLCode <> 0 then
			
			//	Failure deleting object, rollback.
			rollback  ;
			
			MessageBox ( "Error", "Unable to remove object." )
			Return -1
		end if
		
		update	part_online
		set	on_hand = on_hand - :ln_IssueQty
		where	part = :ls_ObjectPart  ;
		
		if SQLCA.SQLCode <> 0 then
			
			//	Failure update part online, rollback.
			rollback  ;
			
			MessageBox ( "Error", "Unable to update part online." )
			Return -1
		end if
		
		commit  ;
	end if
else
	Messagebox ( "System Message", "Sorry, can't continue with this issue, but you could drag & drop if you want to issue this object or use issue total command button")
end if 

//	Refresh screen with latest changes.
dw_transactions.Retrieve ( ls_ObjectPart, is_WorkOrder )
dw_objects.Retrieve ( ls_ObjectPart, is_WorkOrder )
wf_create_common_set ( )

//	If in serial scan mode, set focus to scan.
if ac_Mode = "S" then
	dw_scan_serial.SetItem ( 1, "scan_serial", "" )
	dw_scan_serial.SetFocus ( )
end if
return 0
end function

public function boolean wf_allow_reverse (string as_machine);String ls_Delete
SELECT machine_policy.material_issue_delete  
  INTO :ls_Delete  
  FROM machine_policy  
 WHERE machine_policy.machine = :as_Machine ;

If ls_Delete = "Y" then
	Return TRUE
Else
	Return FALSE
End If

end function

event open;Dec  l_d_qty_completed

dw_header.SetTransObject(sqlca)
dw_workorder_detail.SetTransObject(sqlca)
dw_bill.SetTransObject(sqlca)
dw_transactions.SetTransObject(sqlca)
dw_objects.SetTransObject(sqlca)

i_uo_nvo_mi = Create uo_nvo_material_issues
is_Machine  = Message.StringParm

// Get the whether material substitution is enabled or not. 
Select	material_Substitution
into	:is_SubPart
from	machine_policy
where	machine = :is_machine;

// Get work order no. for this machine with sequence 1
Select work_order.work_order  
  Into :is_WorkOrder  
  From work_order  
 Where ( work_order.machine_no = :is_Machine ) AND  
       ( work_order.sequence = 1 )   ;

If SQLCA.SQLCode = -1 then
	MessageBox("Warning", "No work order found for machine:" + is_Machine)
	Close(this)
End If

dw_header.Retrieve(is_WorkOrder)

bAllowReverse = wf_allow_reverse(is_Machine)

wf_create_common_set()

UPDATE work_order  
   SET lot_control_activated = 'N'  
 WHERE work_order = :is_WorkOrder   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
Else
	Commit ;
End if

end event

on w_machine_inventory.create
this.dw_scan_serial=create dw_scan_serial
this.cb_stopwo=create cb_stopwo
this.cb_consumed=create cb_consumed
this.cb_wo=create cb_wo
this.cb_5=create cb_5
this.dw_header=create dw_header
this.dw_bill=create dw_bill
this.dw_workorder_detail=create dw_workorder_detail
this.cb_2=create cb_2
this.dw_transactions=create dw_transactions
this.cb_1=create cb_1
this.st_3=create st_3
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_message=create cb_message
this.st_4=create st_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_objects=create dw_objects
this.cb_3=create cb_3
this.cb_6=create cb_6
this.dw_common_set=create dw_common_set
this.Control[]={this.dw_scan_serial,&
this.cb_stopwo,&
this.cb_consumed,&
this.cb_wo,&
this.cb_5,&
this.dw_header,&
this.dw_bill,&
this.dw_workorder_detail,&
this.cb_2,&
this.dw_transactions,&
this.cb_1,&
this.st_3,&
this.st_1,&
this.cb_4,&
this.cb_message,&
this.st_4,&
this.rb_1,&
this.rb_2,&
this.dw_objects,&
this.cb_3,&
this.cb_6,&
this.dw_common_set}
end on

on w_machine_inventory.destroy
destroy(this.dw_scan_serial)
destroy(this.cb_stopwo)
destroy(this.cb_consumed)
destroy(this.cb_wo)
destroy(this.cb_5)
destroy(this.dw_header)
destroy(this.dw_bill)
destroy(this.dw_workorder_detail)
destroy(this.cb_2)
destroy(this.dw_transactions)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_message)
destroy(this.st_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_objects)
destroy(this.cb_3)
destroy(this.cb_6)
destroy(this.dw_common_set)
end on

event close;Destroy i_uo_nvo_mi
end event

type dw_scan_serial from datawindow within w_machine_inventory
event ue_key pbm_dwnkey
int X=937
int Y=524
int Width=1102
int Height=480
int TabOrder=40
boolean Visible=false
string DataObject="d_scan_serial"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_key;Int    l_i_pos, &
       l_i_len, &
		 l_i_nochar
IF keydown (KeyEnter!) THEN
	This.Accepttext()
	i_s_scannedserial=dw_scan_serial.getitemstring(1,'scan_serial')	
	l_i_len = LenA(i_s_scannedserial)
	l_i_pos = PosA(i_s_scannedserial,'S')
	IF l_i_pos > 0 Then 
		l_i_nochar = l_i_len - l_i_pos
		i_s_scannedserial = RightA(i_s_scannedserial, l_i_nochar)
	End if 
	wf_issues(Long(i_s_scannedserial),'S')	
END IF 
end event

event buttonclicked;dw_scan_serial.Hide()
end event

event constructor;This.Settransobject(sqlca)
IF This.Rowcount()=0 Then This.Insertrow(0)
This.Setfocus()

end event

type cb_stopwo from commandbutton within w_machine_inventory
int X=1234
int Y=1556
int Width=407
int Height=136
int TabOrder=140
string Text="Un Issue"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Decimal dStdQty, &
	l_d_totalissued
decimal	nAltQtyUnissue
String  ls_part
string	ls_Unit
Long     ll_nbr
Long     ll_foundrow
Decimal  l_d_qtycompleted, &
         l_d_diff
IF iauditrow>0 then 
	dw_transactions.Drag (End!)
	bDragBox=False
	
	//bDragAudit=False
	l_d_totalissued   = dw_transactions.GetItemNumber ( iAuditRow, "ti_qty" )
	dStdQty = dw_transactions.GetItemNumber ( iAuditRow, "std_quantity" )
	ls_part = dw_transactions.GetItemString ( iAuditRow, "part" )
	ls_Unit = dw_transactions.object.unit [ iAuditRow ]
	
	ll_nbr = dw_common_set.RowCount()
	ll_foundrow = dw_common_set.Find("part = '"+ ls_part +"'", 1, ll_nbr)
	
	IF ll_foundrow > 0 THEN
		l_d_qtycompleted=dw_common_set.getitemnumber(ll_foundrow,'ctheoritical_qty')
		IF l_d_qtycompleted < l_d_totalissued THEN
			l_d_diff = (l_d_totalissued - l_d_qtycompleted)
			IF l_d_diff >= dStdQty THEN 
				szreturnedstring = 'Full'
			Else
				nAltQtyUnissue = f_convert_units ( "", ls_Unit, ls_part, l_d_diff )
				szreturnedstring = 'Partial'+ String(nAltQtyUnissue)
			End if 
			dw_objects.Triggerevent('dragfinish')
		Else
			Messagebox("Warning!","Un issue is not allowed as theoritical qty consumed is greater than or equal to the issued quantity")
		End if 			
	End if 		
	
End if 	
end event

type cb_consumed from commandbutton within w_machine_inventory
int X=1234
int Y=1392
int Width=407
int Height=136
int TabOrder=150
string Text="Issue Used"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_objects.Drag (End!)
bDragBox=False
bDragAudit  = False

IF iserial > 0 then wf_issues(iserial,'C')


end event

type cb_wo from commandbutton within w_machine_inventory
int X=1234
int Y=1228
int Width=407
int Height=136
int TabOrder=120
string Text="Issue Total"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_objects.Drag(End!)
bDragBox=False
bDragAudit  = False
IF iserial>0 then wf_issues(iserial,'T')

end event

type cb_5 from commandbutton within w_machine_inventory
int X=1234
int Y=1716
int Width=407
int Height=136
int TabOrder=130
string Text="Scan"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF dw_scan_serial.visible=False Then
	dw_scan_serial.Show()
	dw_scan_serial.setfocus()
Else
	dw_scan_serial.Hide()
End if 	
	
end event

type dw_header from datawindow within w_machine_inventory
int X=18
int Y=16
int Width=2834
int Height=176
int TabOrder=10
string DataObject="d_machine_inventory_header"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_bill from datawindow within w_machine_inventory
int X=603
int Y=1776
int Width=494
int Height=364
int TabOrder=160
boolean Visible=false
string DataObject="dw_bill_of_material_qty_available"
boolean LiveScroll=true
end type

type dw_workorder_detail from datawindow within w_machine_inventory
int X=37
int Y=1772
int Width=494
int Height=364
int TabOrder=100
boolean Visible=false
string DataObject="dw_work_order_detail"
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_machine_inventory
int X=805
int Y=1716
int Width=407
int Height=136
int TabOrder=90
string Text="IC"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String cAccessInventory

SELECT machine_policy.access_inventory_control  
  INTO :cAccessInventory  
  FROM machine_policy  
 WHERE machine_policy.machine = :is_Machine   ;

If cAccessInventory = 'Y' Then
	Run ( 'Mit' )
Else
	MessageBox ( "Error", "Access to inventory denied!", StopSign! )
End if
end event

type dw_transactions from datawindow within w_machine_inventory
int X=1664
int Y=1128
int Width=1189
int Height=572
int TabOrder=20
string DragIcon="BOX.ICO"
string DataObject="dw_list_of_transactions"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event dragdrop;//	Declarations
INT 	iRtnCode
Decimal	nQty
Decimal	nStdQty
STRING 	szUM
STRING  s_Operator
STRING	szCustom1
STRING	szCustom2
STRING	szCustom3
STRING	szCustom4
STRING	szCustom5
STRING	cCheck1
STRING	cCheck2
STRING	cCheck3
STRING	cCheck4
STRING	cCheck5
STRING	cCheckLot
STRING   szLot
STRING	cSafetyPart
STRING	cLotActivated
STRING	s_Status
STRING	ls_plant
st_generic_structure stParm
Boolean lb_Changed = False

//	Object dragged is true
If bDragBox then
	//	Assign values to local variables from the dw
	bDragBox 	= False
	nQty 			= dw_objects.GetItemNumber ( iObjectRow, "quantity" )
	szUm			= dw_objects.GetItemSTRING ( iObjectRow, "unit_measure" )
	nStdQty		= f_calc_std_qty ( szUM, dw_objects.GetItemString ( iobjectRow , 'part' ), nQty ) //-mb 01/13/04
	szCustom1	= dw_objects.GetItemSTRING ( iObjectRow, "custom1" )
	szCustom2	= dw_objects.GetItemSTRING ( iObjectRow, "custom2" )
	szCustom3	= dw_objects.GetItemSTRING ( iObjectRow, "custom3" )
	szCustom4	= dw_objects.GetItemSTRING ( iObjectRow, "custom4" )
	szCustom5	= dw_objects.GetItemSTRING ( iObjectRow, "custom5" )
	szLot			= dw_objects.GetItemSTRING ( iObjectRow, "lot" )
	s_Status		= dw_objects.GetItemSTRING ( iObjectRow, "status" )
	ls_Plant		= dw_objects.GetItemSTRING ( iObjectRow, "plant" )
	
	//	Check the object status
	IF s_Status <> 'A' THEN
		MessageBox ( "Warning!", "Unable to issue object.~rObject status is not approved!", StopSign! )
		Return ;
	END IF

	//	Check whether the part is a safety part
	SELECT	safety_part  
	INTO	:cSafetyPart  
	FROM	part_inventory  
	WHERE	part = :is_part;

	//	Check whether lot control is activated
	Select	lot_control_activated
	Into	:cLotActivated
	From	work_order
	Where	work_order = :is_workorder;

	//	Check if the values are satisfied, if so do the following
	If dw_transactions.RowCount ( ) > 0 And cSafetyPart = 'Y' And cLotActivated = 'Y' Then
		SELECT	shop_floor_check_u1,   
			shop_floor_check_u2,   
			shop_floor_check_u3,   
			shop_floor_check_u4,   
			shop_floor_check_u5,   
			shop_floor_check_lot  
		INTO	:cCheck1,   
			:cCheck2,   
			:cCheck3,   
			:cCheck4,   
			:cCheck5,   
			:cCheckLot  
		FROM	parameters;
		If cCheck1 = 'Y' Then
			If szCustom1 <> dw_transactions.GetItemSTRING ( 1, "custom1" ) Then &
				lb_changed = True
		End if
		If cCheck2 = 'Y' And Not lb_changed Then
			If szCustom2 <> dw_transactions.GetItemSTRING ( 1, "custom2" ) Then &
				lb_changed = True
		End if
		If cCheck3 = 'Y' And Not lb_changed Then
			If szCustom3 <> dw_transactions.GetItemSTRING ( 1, "custom3" ) Then &
				lb_changed = True
		End if
		If cCheck4 = 'Y' And Not lb_changed Then
			If szCustom4 <> dw_transactions.GetItemSTRING ( 1, "custom4" ) Then &
				lb_changed = True
		End if
		If cCheck5 = 'Y' And Not lb_changed Then
			If szCustom5 <> dw_transactions.GetItemSTRING ( 1, "custom5" ) Then &
				lb_changed = True
		End if
		If cCheckLot = 'Y' And Not lb_changed Then
			If szLot <> dw_transactions.GetItemSTRING ( 1, "lot" ) Then &
				lb_changed = True
		End if
		If lb_changed Then
			iRtnCode = MessageBox ( "Error", "Information has changed from previous transaction!  You need to perform a job completion on current object or scan another serial number.  Would you like to go to the completion screen?", Question!, YesNo!, 1 )
			If iRtnCode = 1 Then
				stParm.Value1  = szOperator
				stParm.Value2  = is_part
				stParm.Value3  = is_machine
				stParm.Value4  = is_workorder
				stParm.Value10 = "ForceJC"
				OpenWithParm ( w_part_production, stParm )
			Else
				UPDATE	work_order  
				SET	lot_control_activated = 'Y'  
				WHERE	work_order = :is_workorder;
				If SQLCA.SQLCode = -1 Then
					RollBack ;
				Else
					Commit ;
				End if
			End if	
			Return
		End if
	Else
		UPDATE	work_order  
		SET	lot_control_activated = 'Y'  
		WHERE	work_order = :is_workorder   ;
	
		If SQLCA.SQLCode = -1 Then
			RollBack ;
			Return
		End if
	End if
	If f_create_audit_trail(iSerial, "M", STRING(nQty), STRING(nStdQty), szUM, &
				is_machine, "", "", ls_Plant, is_workorder, szOperator, "No Commit") then

		DELETE	FROM object  
		WHERE	serial = :iSerial;
		If SQLCA.SQLCode = -1 then
			Rollback;
		Else
			UPDATE	part_online
			SET	on_hand = on_hand - :nStdQty
			WHERE	part = :is_part  ;
			IF SQLCA.SQLCode = -1 THEN
				messagebox ( "System Error", "Unable to update on-hand quantity" )
				Rollback  ;
			ELSE
				dw_transactions.Retrieve ( is_part, is_workorder )
				dw_objects.DeleteRow(iObjectRow)
				Commit ;
				wf_create_common_set()
			END IF
		End If
	Else
		Rollback;
	End If	
End If
bDragBox	= FALSE
bDragAudit	= FALSE
end event

event clicked;bDragAudit	= FALSE
bDragBox    = False

If Not bAllowReverse then
	Return
End If

iAuditRow	= row

If iAuditRow > 0 then
	this.Drag(begin!)
	bDragAudit	= TRUE
End If
end event

type cb_1 from commandbutton within w_machine_inventory
int X=1664
int Y=1716
int Width=407
int Height=136
int TabOrder=80
string Text="Exit"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type st_3 from statictext within w_machine_inventory
int X=18
int Y=1048
int Width=1189
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Available Inventory"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_machine_inventory
int X=1664
int Y=1048
int Width=1189
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Material Issues  Audit Trail"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from commandbutton within w_machine_inventory
int X=1554
int Y=1008
int Width=256
int Height=128
int TabOrder=60
boolean Visible=false
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_message from commandbutton within w_machine_inventory
int X=1065
int Y=592
int Width=878
int Height=560
int TabOrder=40
boolean Visible=false
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_machine_inventory
int X=1079
int Y=608
int Width=841
int Height=80
boolean Visible=false
boolean Enabled=false
string Text="Select Action:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_machine_inventory
int X=1289
int Y=704
int Width=585
int Height=80
boolean Visible=false
string Text="Undo Issue"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_machine_inventory
int X=1289
int Y=848
int Width=585
int Height=80
boolean Visible=false
string Text="Partial Issue"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_objects from datawindow within w_machine_inventory
event dragfinish pbm_custom01
int X=23
int Y=1128
int Width=1189
int Height=572
int TabOrder=50
string DragIcon="BOX.ICO"
string DataObject="dw_list_of_objects"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event dragfinish;//	Declarations
st_generic_structure st_Parm
String	ls_Type
String	ls_part
String	ls_unit
String	ls_location
String	ls_customer
String	ls_ponumber
String	ls_lot
String	ls_cstatus
String	ls_custom1
String	ls_custom2
String	ls_custom3
String	ls_custom4
String	ls_custom5
String	ls_plant
String	ls_temppart
String	ls_UserStatus
String	ls_packagetype
String	ls_partname
String	ls_orig_unit

Long	lSerial, &
		l_Dummy
		
Dec 	dQuantity, &
		dQuantity_new
Dec	dStdQty, &
      dStdQty_new
Dec	dWeight
Dec	dCost
Dec	d_Qty, &
		d_StdQty
Dec	d_QtyOld, &
		d_StdQtyOld
Dec	ld_stdcost, &
		ld_std_qty

DateTime	dtDate
DateTime	dtNow
Date		dLastDate
Time		tLastTime

boolean		lb_confirm = True

//	Check type
ls_Type = f_get_string_value ( szReturnedString )
If ls_Type = "" Then Return

//	Assign values to local variables from the dw
lSerial 		= dw_transactions.GetItemNumber ( iAuditRow, "serial" )
dStdQty		= dw_transactions.GetItemNumber ( iAuditRow, "std_quantity" )
ls_part		= dw_transactions.GetItemString ( iAuditRow, "part" )
ls_unit		= dw_transactions.GetItemString ( iAuditRow, "unit" )
dtDate   	= dw_transactions.GetItemDateTime ( iAuditRow, "date_stamp" )
dLastDate 	= Today ( )
tLastTime 	= Now ( )
dtNow			= DateTime(Today(),Now())
ls_location	= dw_transactions.GetItemString ( iAuditRow, "from_loc" )
ls_customer	= dw_transactions.GetItemString ( iAuditRow, "customer" )
ls_ponumber	= dw_transactions.GetItemString ( iAuditRow, "po_number" )
ls_lot		= dw_transactions.GetItemString ( iAuditRow, "lot" )
dWeight		= dw_transactions.GetItemNumber ( iAuditRow, "weight" )
ls_cstatus	= dw_transactions.GetItemString ( iAuditRow, "status" )
ls_UserStatus	= dw_transactions.GetItemString ( iAuditRow, "user_defined_status" )
dCost			= dw_transactions.GetItemNumber ( iAuditRow, "cost" )
ls_custom1	= dw_transactions.GetItemString ( iAuditRow, "custom1" )
ls_custom2	= dw_transactions.GetItemString ( iAuditRow, "custom2" )
ls_custom3	= dw_transactions.GetItemString ( iAuditRow, "custom3" )
ls_custom4	= dw_transactions.GetItemString ( iAuditRow, "custom4" )
ls_custom5	= dw_transactions.GetItemString ( iAuditRow, "custom5" )
ls_plant		= dw_transactions.GetItemString ( iAuditRow, "plant" )
ls_partname	= dw_transactions.GetItemString ( iAuditRow, "part_name" )
ls_packagetype	= dw_transactions.GetItemString ( iAuditRow, "package_type" )
ld_stdCost	= dw_transactions.GetItemNumber ( iAuditRow, "std_cost" )

// Get the original unit from audit trail for that serial and compute qty and std_qty -mb 01/14/04
select unit
into :ls_orig_unit
from audit_trail
where serial = :lserial and
		type in  ( 'A', 'J', 'R' ) 
order by date_Stamp desc;

if ls_unit = ls_orig_unit then
	dQuantity	= f_convert_units ( "", ls_unit, ls_part, dStdQty )
else
	dQuantity	= f_convert_units ( ls_orig_unit, ls_unit, ls_part, dStdQty )
end if

d_QtyOld 	= dQuantity
d_StdQtyOld	= dStdQty

//	Check whether the type was partial and arrive at the quantity
If LeftA ( ls_Type, 7 ) = "Partial" Then
	dQuantity = Dec ( RightA ( ls_Type, LenA ( ls_Type ) - 7 ) )
	dStdQty = f_convert_units ( ls_unit, "", ls_part, dQuantity )
End if

//	Check whether the type was scrap and arrive at the quantity
IF LeftA ( ls_Type, 5 ) = "Scrap" THEN
	dQuantity = Dec ( RightA ( ls_Type, LenA ( ls_Type ) - 5 ) )
	dStdQty = f_convert_units ( ls_unit, "", ls_part, dQuantity )
END IF

//	If the object is being scrapped, do the following
IF LeftA ( ls_Type, 5 ) = "Scrap" THEN
	//	create a defect entry in defects table
	IF wf_create_defect_code ( String ( dStdQty ) ) = -1 THEN
		Return
	END IF
	//	Get the difference in quantities	
	// modified qtys to be computed from proper qtys -mb 01/14/04
	d_Qty = d_qtyold - dQuantity 
	d_StdQty = d_stdqtyold - dStdQty

	//	Create another audit_trail record with the original quantity with a -ve value
	if f_create_audit_trail(lserial, "N", STRING(d_QtyOld), STRING(d_StdQtyOld), ls_unit, &
					is_machine, "", "", ls_plant, is_workorder, szOperator, "No Commit") then 

		//	Change the type on the original serial from M to N 
		dw_transactions.SetItem ( iAuditRow, "type", 'N' ) 

		//	Create another audit_trail record with the difference in quantity
		// modified std_qty to be computed for the new unit and qty -mb 01/14/04
		if f_create_audit_trail(lserial, "M", STRING(d_Qty), STRING(f_convert_units ( ls_unit, "", ls_part, d_qty ) ), ls_unit, &
				is_machine, "", "", ls_plant, is_workorder, szOperator, "No Commit") then
				
			//	create a audit_trail record with D
			if f_create_audit_trail (lSerial, 'D', szOperator, '0', String ( dQuantity ), String ( dStdQty ), ls_unit, is_machine, is_defect, ls_part, is_workorder, '' ) then 
				lb_confirm = true
			else
				lb_confirm = false
			end if 
		else
			lb_confirm = false
		end if 	
	else
		lb_confirm = false
	end if 	

	//	Update the dw				
	IF dw_transactions.Update ( ) = -1 THEN
		RollBack  ;
		MessageBox ( monsys.msg_title, "Delete" )
	ELSE
		if lb_confirm then 	
			Commit  ;
		else
			rollback;
		end if 	
		//	re-retrieve the dw  & print the label
		dw_transactions.Retrieve(ls_part, is_workorder)
		dw_objects.Retrieve(ls_part)
	END IF
	Return
END IF

//	update the on hand quantity in part online table
UPDATE	part_online
SET	on_hand = on_hand + :dStdQty
WHERE	part = :ls_part;

IF SQLCA.SQLCode <> 0 THEN
	MessageBox ( "Warning", "Unable to update part_online." )
	Return
END IF

//	Get the original quantities from object table, if the serial exists
SELECT	object.quantity,
	object.std_quantity  
INTO	:d_Qty,
	:d_StdQty  
FROM	object  
WHERE	object.serial = :lSerial;

If SQLCA.SQLCode = 0 Then
	//	Arrive at the new quantities		
	dQuantity_new = dQuantity + d_Qty
	dStdQty_new   = dStdQty + d_StdQty
	
	//	update object table with the new quantities
	UPDATE	object  
	SET	quantity = :dQuantity_new,   
		std_quantity = :dStdQty_new 
	WHERE	object.serial = :lSerial;
Else	
	//	if the serial doesn't exists, create a new record in object table
	ld_std_qty = f_convert_units (  ls_orig_unit, "", ls_part, dQuantity )
	
	INSERT INTO object  
		( serial,   
		part,   
		location,   
		last_date,   
		unit_measure,   
		operator,   
		status,   
		destination,   
		station,   
		origin,   
		cost,   
		weight,   
		parent_serial,   
		note,   
		quantity,   
		last_time,   
		date_due,   
		customer,   
		sequence,   
		shipper,   
		lot,   
		type,   
		po_number,   
		name,   
		plant,   
		start_date,   
		std_quantity,   
		package_type,
		std_cost,
		field1,   
		field2,   
		custom1,   
		custom2,   
		custom3,   
		custom4,   
		custom5,   
		show_on_shipper,
		user_defined_status )  
	VALUES	(:lSerial,   
		:ls_part,   
		:ls_location,   
		:dtNow,   
		:ls_orig_unit,   
		:szOperator,   
		:ls_cstatus,   
		null,   
		null,   
		null,   
		:dCost,   
		null,   
		null,   
		null,   
		:dQuantity,   
		:dtNow,   
		null,   
		:ls_customer,   
		null,   
		null,   
		:ls_lot,   
		null,   
		:ls_ponumber,   
		:ls_partname,   
		:ls_plant,   
		null,   
		:ld_std_qty,   
		:ls_packagetype,   
		:ld_stdcost,
		null,   
		null,   
		:ls_custom1,   
		:ls_custom2,   
		:ls_custom3,   
		:ls_custom4,   
		:ls_custom5,   
		null,
		:ls_UserStatus )  ;
End if

If SQLCA.SQLCode = -1 Then
	RollBack ;
	MessageBox ( monsys.msg_title, "Insert" )
Else
	//	If it's partial, update the original record in audit_trail
	If LeftA ( ls_Type, 7 ) = "Partial" Then
		
		//	Get the difference in quantities		
		// modified to use proper qtys - mb 01/14/04
		d_Qty = d_qtyold - dQuantity 
		d_StdQty = d_stdqtyold - dStdQty

		//	Create another audit_trail record with the original quantity with a -ve value
		if f_create_audit_trail(lserial, "N", STRING(d_QtyOld), STRING(d_StdQtyOld), ls_unit, &
					is_machine, "", "", ls_plant, is_workorder, szOperator, "No Commit") then 

			//	Change the type on the original serial from M to N 
			dw_transactions.SetItem ( iAuditRow, "type", 'N' ) 

			//	Create another audit_trail record with the difference in quantity 
			// modified std_qty to be computed for the new unit and qty -mb 01/14/04
			if f_create_audit_trail(lserial, "M", STRING(d_Qty), STRING(f_convert_units ( ls_unit, "", ls_part, d_qty ) ), ls_unit, &
					is_machine, "", "", ls_plant, is_workorder, szOperator, "No Commit") then 
				lb_confirm = true
			else
				lb_confirm = false
			end if 
		else
			lb_confirm = false
		end if 	
	Else
		//	if it's full unissue, delete the audit_trail row
		dw_transactions.DeleteRow ( iAuditRow )
		lb_confirm = true
	End if

	//	update dw
	If dw_transactions.Update ( ) = -1 Then
		RollBack ;
		MessageBox ( monsys.msg_title, "Delete" )
	Else
		if lb_confirm then 
			Commit ;
		else
			rollback;
		end if 	
		//	re-retrieve the dw  & print the label
		dw_transactions.Retrieve(ls_part, is_workorder)
		dw_objects.Retrieve(ls_part)

		//	Print label for partial.
		if LeftA ( ls_type, 7 ) = "Partial" then
			st_Parm.Value1 = String ( lSerial )
			f_print_label ( st_Parm )
		end if
	End if
End if

//	Rebuild the top dw to reflect the values.
wf_create_common_set()

end event

event dragdrop; /*  Declare Variables  */
Dec 		ld_quantity
decimal		ln_StdQuantity

string	ls_Unit

/*  Main  */
If bDragAudit Then
	bDragAudit = False
	is_undopart= dw_transactions.GetItemString ( iAuditRow, "part" )
	ls_Unit = dw_transactions.GetItemString ( iAuditRow, "unit" )
	ln_StdQuantity = dw_transactions.GetItemNumber ( iAuditRow, "std_quantity" )
	ld_quantity = f_convert_units ( "", ls_Unit, is_undopart, ln_StdQuantity )
	OpenWithParm ( w_undo_type, ld_quantity )
End if
end event

event clicked;iObjectRow	= this.GetClickedRow()
bDragBox	= FALSE
bDragAudit	= False
If iObjectRow > 0 then
	this.Drag(Begin!)
	bDragBox	= TRUE
	iSerial	= this.GetItemNumber(iObjectRow,  "serial")
	is_Part	= this.GetItemString(iObjectRow,  "part")
End If

end event

event constructor;datawindowchild ldwc_object	

getchild ( 'unit_measure', ldwc_object )
ldwc_object.settransobject ( sqlca )

end event

type cb_3 from commandbutton within w_machine_inventory
int X=1170
int Y=1008
int Width=256
int Height=128
int TabOrder=70
boolean Visible=false
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_6 from commandbutton within w_machine_inventory
int X=1234
int Y=1064
int Width=407
int Height=136
int TabOrder=110
string Text="Issue Lot"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_objects.Drag(End!)
bDragBox=False
bDragAudit  = False
IF iserial>0 then wf_issues(iserial,'L')


end event

type dw_common_set from datawindow within w_machine_inventory
int X=23
int Y=196
int Width=2834
int Height=848
int TabOrder=30
string DataObject="dw_common_set_for_bill_of_material"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event clicked;datawindowchild l_dwc_object	

SelectRow ( This, 0, False )
if row > 0 then 
	icommonsetrow = Row
	SelectRow ( This, row, True )
	is_Part	= this.GetItemString( row, "part")
	dw_transactions.Retrieve(is_Part, is_WorkOrder)
	// populate the unit list for the objects -mb 01/13/04
	dw_objects.getchild ( 'unit_measure', l_dwc_object )
	l_dwc_object.settransobject ( sqlca )
	l_dwc_object.retrieve ( is_part ) 	
	dw_objects.Retrieve(is_Part)
end if 	

end event

event constructor;SetTransObject ( SQLCA )
end event

