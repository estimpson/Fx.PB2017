$PBExportHeader$w_calculate_assigned_qty_in_mps.srw
$PBExportComments$(mst.pbl) To calculate the qty_assigned in MPS rows.
forward
global type w_calculate_assigned_qty_in_mps from Window
end type
type dw_3 from datawindow within w_calculate_assigned_qty_in_mps
end type
type dw_1 from datawindow within w_calculate_assigned_qty_in_mps
end type
end forward

global type w_calculate_assigned_qty_in_mps from Window
int X=672
int Y=264
int Width=2089
int Height=1264
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_3 dw_3
dw_1 dw_1
end type
global w_calculate_assigned_qty_in_mps w_calculate_assigned_qty_in_mps

type variables
String  	szPart   //Part number
String  	szType  //Type
String  	szPlant  //Plant code
String	is_work_order

Decimal nQty        //Quantity
Decimal nTotalQty //Total quantity
Decimal nQtyAssigned

Long    iOrder    //Order number

st_generic_structure stParm

end variables

forward prototypes
public subroutine wf_assign_qty (decimal ac_qty)
public subroutine wf_zero_out_qty_assigned (string aspart)
public function decimal wf_get_qty_in_workorder (string aspart)
public function decimal wf_get_qty_in_po (string aspart)
end prototypes

public subroutine wf_assign_qty (decimal ac_qty);/* Declaration */
Decimal 	nQtyLeft, &
			lc_Qty_Assigned

Long		iRow
Long		iRowId
Long   	li_count

String	szOrigin, &
			ls_sql

date		ld_date

time		lt_time

datetime	ldt_date, ldt_time

/* Initialization */

dw_3.SetTransObject ( sqlca )
dw_3.Retrieve ( szPart )

nQtyLeft	= ac_qty

/* Main Process */
For li_count = 1 to dw_3.rowcount() 
	
	nQty 	  				= dw_3.GetItemNumber ( li_Count, 'qnty' )
	lc_qty_assigned 	= dw_3.GetItemNumber ( li_Count, 'qty_assigned' )
	
	IF nQtyLeft > 0 THEN

		If nQtyLeft > nQty then
			dw_3.SetItem ( li_Count, 'qty_assigned' , nQty)
	      nQtyLeft	= nQtyLeft - nQty
		Else
			dw_3.SetItem ( li_Count, 'qty_assigned' , nQtyLeft)
	      nQtyLeft	= 0
		End If
	END IF
	
Next

If dw_3.Update() = 1 then
	Commit;
Else
	Rollback;
End If


end subroutine

public subroutine wf_zero_out_qty_assigned (string aspart);Update master_prod_sched  
  Set qty_assigned = 0  
Where part = :asPart   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

end subroutine

public function decimal wf_get_qty_in_workorder (string aspart);Decimal lnQty

SELECT sum(workorder_detail.qty_required )  
    INTO :lnQty  
    FROM workorder_detail  
   WHERE workorder_detail.part = :asPart   ;

Return f_get_value(lnQty)
end function

public function decimal wf_get_qty_in_po (string aspart);// This function will calculate the total qty in po detail per part 

Decimal lnQty

SELECT sum(po_detail.standard_qty )  
	INTO  :lnQty  
  	FROM  po_detail  
 	WHERE ( po_detail.part_number = :asPart ) AND  
       	( po_detail.status <> 'C' );

Return f_get_value(lnQty)
end function

event open;//************************************************************************
//* Declaration
//************************************************************************

Datetime  ddue

String sorigin
String ssource
String sworkorder

Integer iRow

//************************************************************************
//* Initialization
//************************************************************************

stParm			= Message.PowerObjectParm

szPart			= stParm.value1
nTotalQty		= Dec(stParm.value2)
szType			= stParm.value3
szPlant			= stParm.value4
is_work_order	= stParm.value5

//************************************************************************
//* Main Routine
//************************************************************************

rollback ;
wf_zero_out_qty_assigned(szPart)

If szType = "P" then
	nQtyAssigned	= wf_get_qty_in_po(szPart)
Else
	nQtyAssigned	= wf_get_qty_in_workorder(szPart)
End If

Rollback ;

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(szPart)

If g_s_platform = 'Microsoft SQL Server' THEN
	
		For iRow = 1 to dw_1.RowCount() 

			nQty  = dw_1.GetItemNumber(iRow, "qnty")

			If nQtyAssigned > nQty Then
				dw_1.SetItem(iRow, "qty_assigned", nQty )
				dw_1.SetItem(iRow, "workorder", is_work_order )
				nQtyAssigned = nQtyAssigned - nQty
			Else 
				dw_1.SetItem(iRow, "qty_assigned", nQtyAssigned )
				dw_1.SetItem(iRow, "workorder", is_work_order )
				nQtyAssigned = 0
			End if
		
			If dw_1.Update() > 0 then
				commit ;
			Else
				rollback ;
			End if

	   Next

ELSE

	wf_assign_qty ( nQtyAssigned )

END IF

Close(this)
end event

on w_calculate_assigned_qty_in_mps.create
this.dw_3=create dw_3
this.dw_1=create dw_1
this.Control[]={this.dw_3,&
this.dw_1}
end on

on w_calculate_assigned_qty_in_mps.destroy
destroy(this.dw_3)
destroy(this.dw_1)
end on

type dw_3 from datawindow within w_calculate_assigned_qty_in_mps
int X=1074
int Y=164
int Width=494
int Height=360
int TabOrder=20
boolean Visible=false
string DataObject="d_mps_update_qty_assigned"
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_calculate_assigned_qty_in_mps
int X=384
int Y=176
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
string DataObject="d_update_prod_sched"
boolean LiveScroll=true
end type

