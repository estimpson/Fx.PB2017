$PBExportHeader$u_job_material_input.sru
forward
global type u_job_material_input from UserObject
end type
type st_2 from statictext within u_job_material_input
end type
type st_1 from statictext within u_job_material_input
end type
type dw_part_online from datawindow within u_job_material_input
end type
type dw_bill_of_material from datawindow within u_job_material_input
end type
type dw_work_order_detail from datawindow within u_job_material_input
end type
type dw_stack from datawindow within u_job_material_input
end type
type dw_project_qty from datawindow within u_job_material_input
end type
type dw_qty_available from datawindow within u_job_material_input
end type
end forward

global type u_job_material_input from UserObject
int Width=3429
int Height=1560
boolean Border=true
long BackColor=77971394
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
event ue_save pbm_custom01
event ue_status_sheet ( )
st_2 st_2
st_1 st_1
dw_part_online dw_part_online
dw_bill_of_material dw_bill_of_material
dw_work_order_detail dw_work_order_detail
dw_stack dw_stack
dw_project_qty dw_project_qty
dw_qty_available dw_qty_available
end type
global u_job_material_input u_job_material_input

type variables
String	szJob		//Job number
String    	szPart		//Part number
Decimal 	nQty 		//Quantity
Long	iTotal		//Total count for w_progress

Boolean 	bRunningJob


end variables

forward prototypes
public subroutine uf_build_qty_table ()
public function decimal uf_project_qty (string as_part, string as_type)
public subroutine uf_assign_qty (string as_component, decimal ac_quantity)
public subroutine uf_build_project_qty ()
end prototypes

event ue_setup;szjob = a_st_parm.value2
dw_work_order_detail.Reset ()
dw_work_order_detail.Retrieve(szjob)
iTotal	= dw_work_order_detail.RowCount() + 1
uf_build_qty_table()


end event

event ue_save;dw_project_qty.accepttext()

uf_build_project_qty()
end event

event ue_status_sheet;	s_parm_list	lstr_parm
	lstr_parm.s_key_value		= dw_qty_available.object.part[dw_qty_available.getrow()]
	lstr_parm.s_parm_list[1]	= dw_qty_available.object.type[dw_qty_available.getrow()]
	lstr_parm.d_parm_list[1]	= today()
	OpenSheetWithParm( w_po_schedule_grid_status, lstr_parm, wmainscreen, 3, Original!)

end event

public subroutine uf_build_qty_table ();//***********************************************************************
//* Declaration
//***********************************************************************
Long iRow					//To keep the current row number
Long iTotalRows			//To keep the total number of rows in current datawindow
Long iComponentRow		//To keep the current row number in bill of material
Long iComponentTotalRows//To keep the total row # in BOM datawindow
Long iCount					//To keep the row count number

String  szDescription	//To keep the part description
String  szComponent		//To keep the component
String  szType				//To keep the type of the part
String  szbomtype			//To keep the bom type of the part

Decimal nOnHand			//To keep the onhand quantity
Decimal nRequired			//To keep the qty required in work order detail
Decimal nComponentQty	//To keep the qty in bill of material

//***********************************************************************
//* Initialization
//***********************************************************************

dw_qty_available.Reset()
dw_project_qty.Reset()
dw_qty_available.Modify("balance.color = '0~tif(balance > 0, 65280, 255)'")

//***********************************************************************
//* Main Routine
//***********************************************************************

iTotalRows	= dw_work_order_detail.RowCount()

For iRow = 1 to iTotalRows

	szPart	= dw_work_order_detail.GetItemString(iRow, "part")
	nQty		= f_get_value(dw_work_order_detail.GetItemNumber(iRow, "balance"))
	dw_bill_of_material.Retrieve(szPart)
	iComponentTotalRows	= dw_bill_of_material.RowCount()
	dw_project_qty.insertrow(1)
	
	dw_project_qty.setitem( 1, 'part', szPart )
	dw_project_qty.setitem( 1, 'description', f_get_part_info( szPart, 'NAME' ) )
	dw_project_qty.setitem( 1, 'um', f_get_part_info( szPart, 'STANDARD UNIT' ) )
	dw_project_qty.setitem( 1, 'calc_weight', 1 )
	dw_project_qty.setitem( 1, 'required_qty', nQty )
				
	For iComponentRow	= 1 to iComponentTotalRows

		szComponent		= dw_bill_of_material.GetItemString(iComponentRow, "part")
		szDescription	= f_get_part_info(szComponent, "NAME")
		szType			= f_get_part_info(szComponent, "CLASS")
		nOnHand			= f_get_value(Dec(f_get_part_info(szComponent, "ON HAND")))
		nComponentQty	= dw_bill_of_material.GetItemNumber(iComponentRow, "quantity")
		szbomtype      = dw_bill_of_material.GetItemString(iComponentRow, "type")

		dw_stack.insertrow ( 1 )
		dw_stack.setitem ( 1, 'parent_part', szPart )
		dw_stack.setitem ( 1, 'component', szComponent )
		dw_stack.setitem ( 1, 'bom_qty', nComponentQty )
		dw_stack.setitem ( 1, 'assigned_qty', nQty )

		iCount			= dw_qty_available.Find("part = '" + szComponent + "'", 1, 99999)
		If iCount > 0 then
			nRequired	= dw_qty_available.GetItemNumber(iCount, "QtyRequired")
			nRequired	= nRequired + (nQty * nComponentQty)
		Else
			dw_qty_available.InsertRow(1)
			dw_qty_available.SetItem(1, "Part", szComponent)
			dw_qty_available.SetItem(1, "description", szDescription)
			dw_qty_available.SetItem(1, "OnHandQty", nOnHand)
			dw_qty_available.SetItem(1, "type", szType)
			nRequired	= (nQty * nComponentQty)
			iCount		= 1
		End If

	   if (szbomtype = 'T') then nRequired=nComponentQty // if the bom type is tool

		dw_qty_available.SetItem(iCount, "QtyRequired", nRequired)
		dw_qty_available.SetItem(iCount, "Balance", (nOnHand - nRequired))
	Next

Next
					
end subroutine

public function decimal uf_project_qty (string as_part, string as_type);/*
Description	:	To calculate the projected quantity based on the available
					quantity in BOM list.
Author		:	Jim Wu
Start Date	:	06/22/96
Modification:
*/
string	ls_component

integer	li_count, &
			li_row, &
			li_dw_qty_available_row, &
			li_stack_row

decimal	lc_bom_qty, &
			lc_assigned_qty, &
			lc_ratio, &
			lc_item_ratio, &
			lc_qty_left

/* Initialization */
dw_stack.setfilter( "parent_part='" + as_part + "'" )
dw_stack.filter()

setnull(lc_ratio)

li_count	= dw_stack.rowcount()

if as_type = 'EXTRA' then
	for li_row = 1 to dw_qty_available.rowcount()
		ls_component	= dw_qty_available.getitemstring( li_row, 'part' )
		lc_qty_left		= &
						dec( dw_qty_available.getitemstring( li_row, 'value1' ) )
		dw_qty_available.setitem( li_row, 'value1', '0' )				
		li_stack_row	= dw_stack .find( "parent_part ='" + as_part + &
				"' AND component='" + ls_component + "'", 1, &
											99999 )
		if li_stack_row > 0 then
			dw_stack.setitem( li_stack_row, 'assigned_qty', lc_qty_left )
		else
			dw_stack.setitem( li_stack_row, 'assigned_qty', 0 )
		end if
	next
end if

dw_stack.setfilter( "parent_part='" + as_part + "'" )
dw_stack.filter()

li_count	= dw_stack.rowcount()

/* Main Process */
for li_row = 1 to li_count
	lc_bom_qty			= dw_stack.getitemnumber( li_row, 'bom_qty' )
	lc_assigned_qty	= dw_stack.getitemnumber( li_row, 'assigned_qty' )
	if lc_bom_qty > 0 then
		lc_item_ratio	= (lc_assigned_qty / lc_bom_qty )
		if lc_item_ratio < 0 then
			lc_item_ratio	= 0
		end if
	else
		lc_item_ratio	= 0		
	end if		

	if isnull( lc_ratio ) then
		lc_ratio	= lc_item_ratio
	else
		if lc_item_ratio < lc_ratio then	
			lc_ratio	= lc_item_ratio
		end if
	end if

next

//Save the extra quantity for the next process
for li_row = 1 to li_count
	ls_component		= dw_stack.getitemstring( li_row, 'component' )
	lc_bom_qty			= dw_stack.getitemnumber( li_row, 'bom_qty' )
	lc_assigned_qty	= dw_stack.getitemnumber( li_row, 'assigned_qty' )
	lc_qty_left			= lc_assigned_qty - ( lc_bom_qty * lc_ratio )
	li_dw_qty_available_row	= dw_qty_available.find( "part='" + ls_component + &
															"'" , 1, 99999)
	if li_dw_qty_available_row > 0 then
		lc_qty_left	= &
			dec(	dw_qty_available.getitemstring( li_dw_qty_available_row, &
					'value1' ) )
		lc_qty_left	+=  lc_assigned_qty - ( lc_bom_qty * lc_ratio )
		dw_qty_available.setitem( 	li_dw_qty_available_row, 'value1', &
											string( lc_qty_left ) )
	end if		
	
next

return lc_ratio 
end function

public subroutine uf_assign_qty (string as_component, decimal ac_quantity);/*
Description	:	To allocate the component quantity to parent part.
Author		:	Jim Wu
Start Date	:	06/19/96
Modification:
*/


/* Declaration */
integer	li_count, &
			li_row, &
			li_project_row, &
			li_project_count

decimal	lc_total_weight = 0, &
			lc_item_weight, &
			lc_bom_qty

string	ls_part

/* Initialization */
dw_stack.setfilter( "component = '" + as_component + "'")
dw_stack.filter()

li_count				= dw_stack.rowcount()
li_project_count	= dw_project_qty.rowcount()

/* Main Process */

for li_row = 1 to li_count
	ls_part			= dw_stack.getitemstring( li_row, 'parent_part' )
	li_project_row	= dw_project_qty.find( "part = '" + ls_part + "'", 1, 99999)

	if li_project_row > 0 then
		lc_item_weight 	= 	dw_project_qty.getitemnumber( li_project_row, &
									'calc_weight' )
		lc_total_weight 	+=	dw_stack.getitemnumber( li_row, 'bom_qty' ) * &
									lc_item_weight
	end if 
next


for li_row = 1 to li_count
	ls_part			= dw_stack.getitemstring( li_row, 'parent_part' )
	lc_bom_qty		= dw_stack.getitemnumber( li_row, 'bom_qty' )

	li_project_row	= dw_project_qty.find( "part = '" + ls_part + "'", 1, 99999)
	if li_project_row > 0 then
		lc_item_weight = 	dw_project_qty.getitemnumber( li_project_row, &
								'calc_weight' )
		if lc_total_weight > 0 then
			dw_stack.setitem( li_row, 'assigned_qty', &
				ac_quantity * lc_bom_qty * lc_item_weight / lc_total_weight )
		else
			dw_stack.setitem( li_row, 'assigned_qty', 0 )
		end if
	end if 
next

end subroutine

public subroutine uf_build_project_qty ();/*
Description	:	This function will build the projective production quantity
Author		:	Jim Wu
Start Date	:	06/19/96
Modification:
*/


/* Declaration */
integer	li_count, &
			li_row

string	ls_part

decimal	lc_qty

boolean	lb_update

/* Initialization */
li_count	= dw_qty_available.rowcount()

/* Main Process */
for li_row = 1 to li_count
	ls_part	= dw_qty_available.getitemstring( li_row, 'part' )
	lc_qty	= dw_qty_available.getitemnumber( li_row, 'onhandqty' )
	dw_qty_available.setitem( li_row, 'value1', '0' )
	uf_assign_qty( ls_part, lc_qty )
next

li_count	= dw_project_qty.rowcount()

for li_row = 1 to li_count
	ls_part	= dw_project_qty.getitemstring( li_row, 'part' )
	lc_qty	= dw_project_qty.getitemnumber( li_row, 'required_qty' )
	dw_project_qty.setitem( li_row, 'projected_qty', uf_project_qty ( ls_part, 'REGULAR' ) )
next

//Step 2: To allocate extra quantity
lb_update	= TRUE

do while lb_update 
	lb_update	= FALSE
	for li_row  = 1 to li_count
		ls_part	= dw_project_qty.getitemstring( li_row, 'part' )
		lc_qty	= uf_project_qty( ls_part, 'EXTRA' )
		if lc_qty > 0 then
			lb_update	= TRUE
			lc_qty		+= dw_project_qty.getitemnumber( li_row, 'projected_qty' )
			dw_project_qty.setitem( li_row, 'projected_qty', lc_qty )
		end if
	next
loop

end subroutine

on u_job_material_input.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_part_online=create dw_part_online
this.dw_bill_of_material=create dw_bill_of_material
this.dw_work_order_detail=create dw_work_order_detail
this.dw_stack=create dw_stack
this.dw_project_qty=create dw_project_qty
this.dw_qty_available=create dw_qty_available
this.Control[]={this.st_2,&
this.st_1,&
this.dw_part_online,&
this.dw_bill_of_material,&
this.dw_work_order_detail,&
this.dw_stack,&
this.dw_project_qty,&
this.dw_qty_available}
end on

on u_job_material_input.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_part_online)
destroy(this.dw_bill_of_material)
destroy(this.dw_work_order_detail)
destroy(this.dw_stack)
destroy(this.dw_project_qty)
destroy(this.dw_qty_available)
end on

type st_2 from statictext within u_job_material_input
int X=18
int Y=684
int Width=864
int Height=52
boolean Enabled=false
string Text="  Projective Production Quantity :   "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_job_material_input
int X=14
int Width=768
int Height=52
boolean Enabled=false
string Text="  Raw Material Requirement :   "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_part_online from datawindow within u_job_material_input
int X=1051
int Y=1544
int Width=494
int Height=360
int TabOrder=30
boolean Visible=false
string DataObject="dw_part_online_info"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_bill_of_material from datawindow within u_job_material_input
int X=1605
int Y=1544
int Width=494
int Height=360
int TabOrder=50
boolean Visible=false
string DataObject="dw_bill_of_material_qty_available"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_work_order_detail from datawindow within u_job_material_input
int X=553
int Y=1540
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="dw_workorder_detail"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_stack from datawindow within u_job_material_input
int X=9
int Y=1540
int Width=494
int Height=360
int TabOrder=40
boolean Visible=false
string DataObject="d_external_bom_info"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type dw_project_qty from datawindow within u_job_material_input
int X=5
int Y=736
int Width=2807
int Height=600
int TabOrder=20
string DataObject="d_external_projected_quantity_for_job"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_qty_available from datawindow within u_job_material_input
int X=9
int Y=52
int Width=2798
int Height=624
int TabOrder=10
string DataObject="dw_external_qty_available"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;if this.rowcount() > 0 then 
	parent.triggerevent('ue_status_sheet')
end if 	

end event

