$PBExportHeader$n_cst_netout.sru
forward
global type n_cst_netout from nonvisualobject
end type
end forward

type str_crosstab from structure
	string		part
	datetime		due_date
	string		plant
	double		qnty
	double		qty_assigned
	double		onhand
	double		origin
	string		product_line
	string		parttype
	string		commodity
	string		activity
	integer		bucket_no
	double		qty_req_past
	double		qty_req_1
	double		qty_req_2
	double		qty_req_3
	double		qty_req_4
	double		qty_req_5
	double		qty_req_6
	double		qty_req_7
	double		qty_req_8
	double		qty_req_9
	double		qty_req_10
	double		qty_req_11
	double		qty_req_12
	double		qty_req_13
	double		qty_req_14
	double		qty_req_future
	string		part_type
	string		cum_row
	string		ecn_level
	string		group_technology
	double		source
	double		queue
end type

type str_processed from structure
	string		part[]
	double		quantity[]
end type

type str_part from structure
	string		part
	long		firstrow
	long		lastrow
end type

type str_bom from structure
	string		part
	integer		level
	double		quantity
end type

type str_data from structure
	long		origin
	long		source
	double		quantity
	string		part
end type

global type n_cst_netout from nonvisualobject
end type
global n_cst_netout n_cst_netout

type variables
Private:

long	il_Parts

str_part	istr_Parts [ ]

str_crosstab	ist_Data [ ]

string	is_TopPart

DECLARE PartList PROCEDURE FOR msp_low_level :is_TopPart  ;
end variables

forward prototypes
public function integer of_netout (ref datawindow adw_crosstab)
private function integer of_map ()
private function integer of_netout ()
private function integer of_rewrite ()
private function integer of_processpart (string as_part, double adbl_quantity)
private subroutine of_getpartfirstlast (string as_part, ref long al_first, ref long al_last)
end prototypes

public function integer of_netout (ref datawindow adw_crosstab);
//	Declarations.
str_statusbar	l_str_parm
long	ll_row, ll_rowcount

//	Open status bar.
l_str_parm.title = "Netout"
l_str_parm.enable_cancel = true
OpenWithParm ( w_progress_bar, l_str_parm )

//	Initialize by reading datawindow to structure.
w_progress_bar.wf_setstatus ( "Initializing...", 0 )
ll_rowcount = adw_Crosstab.RowCount ( )
for ll_row = 1 to ll_rowcount
	ist_data [ ll_row ] = adw_Crosstab.object.data [ ll_row ]
	if Integer ( 100 * ll_Row / ll_Rowcount ) <> Integer ( 100 * ( ll_Row - 1 ) / ll_RowCount ) then
		w_progress_bar.wf_setstatus ( "Initializing...", 100 * ll_Row / ll_RowCount )
	end if
next

//ist_data = adw_Crosstab.object.data
//w_progress_bar.wf_setstatus ( "Initializing...", 100 )

//	Find first and last rows for each part.
of_Map ( )

//	Netout.
of_Netout ( )

//	Rewrite.
of_ReWrite ( )

//	Finish by writing structure to datawindow
w_progress_bar.wf_setstatus ( "Finishing...", 0 )
adw_Crosstab.object.data = ist_data
w_progress_bar.wf_setstatus ( "Finishing...", 100 )

//	Close status bar.
Close ( w_progress_bar )

return 0
end function

private function integer of_map ();
//	Declarations.
long	ll_Row
long	ll_Rows

string	ls_LastPart
string	ls_Part

//	Prime data
ll_Rows = UpperBound ( ist_Data )
if ll_Rows > 0 then
	ls_Part = ist_Data [ 1 ].part
//	incst_PartFirstRow.of_SetItem ( ls_Part, 1 )
	il_Parts = 1
	istr_Parts [ il_Parts ].part = ls_Part
	istr_Parts [ il_Parts ].firstrow = 1
	ls_LastPart = ls_Part
end if
	
//	Loop through all rows
for ll_Row = 2 to ll_Rows
	
	//	Check this Part against LastPart
	ls_Part = ist_Data [ ll_Row ].part
	if ls_Part <> ls_LastPart then
		istr_Parts [ il_Parts ].lastrow = ll_Row - 1
		il_Parts ++
		istr_Parts [ il_Parts ].part = ls_Part
		istr_Parts [ il_Parts ].firstrow = ll_Row
		ls_LastPart = ls_Part
	
		w_progress_bar.wf_setstatus ( "Mapping [" + String ( ls_Part ) + "]...", 100 * ll_Row / ll_Rows )
	end if
next

//	LastRow
istr_Parts [ il_Parts ].lastrow = ll_Rows

return 0
end function

private function integer of_netout ();
//	Declarations
double	ldbl_Onhand
double	ldbl_quantityassigned
double	ldbl_netquantity
double	ldbl_checkquantity

long	ll_PartRow
long	ll_Parts
long	ll_firstrow
long	ll_lastrow
long	ll_Partrowtemp

string	ls_Part

datastore	lds_LowLevel
datastore	lds_Onhand

//	Initialize.
lds_LowLevel = create datastore
lds_LowLevel.DataObject = "d_mps_parts"
lds_LowLevel.SetTransObject ( SQLCA )

lds_Onhand = create datastore
lds_Onhand.DataObject = "d_netout_onhand"
lds_Onhand.SetTransObject ( SQLCA )

//	Get low level for all parts.
lds_LowLevel.retrieve ( '' )

//	Loop through all parts.
ll_Parts = lds_LowLevel.RowCount ( )
for ll_PartRow = 1 to ll_Parts
	
	//	Retrieve onhand for part.
	ls_Part = lds_LowLevel.object.part [ ll_PartRow ]
	if lds_Onhand.Retrieve ( ls_Part ) > 0 then
		
		//	Process onhand.
		ldbl_Onhand = lds_Onhand.object.total_onhand [ 1 ]
		if ldbl_Onhand > 0 then
			
			//	Process part.
			w_progress_bar.wf_setstatus ( "Processing: " + ls_Part, 1 + 100 * ll_PartRow / ll_Parts )

			of_ProcessPart ( ls_Part, ldbl_Onhand )
		end if
	end if

	//	Check for cancel.
	Yield ( )
	if bCancel then
		return -1
	end if
next


lds_LowLevel.DataObject = "d_mps_parts_assigned"
lds_LowLevel.SetTransObject ( SQLCA )

//	Get low level for all parts.
lds_LowLevel.retrieve ( )

//	Loop through all parts.
ll_Parts = lds_LowLevel.RowCount ( )
for ll_PartRowtemp = 1 to ll_Parts
	
	//	Retrieve onhand for part.
	ls_Part = lds_LowLevel.object.part [ ll_PartRowtemp ]
	
	//	Get First and Last row for top part.
	of_GetPartFirstLast ( ls_Part, ll_FirstRow, ll_LastRow )

	if ll_FirstRow > 0 then
	
		ldbl_quantityassigned = 0 
		
		//	Eliminate net requirements in default (due date) order.
		ll_PartRow = ll_FirstRow
		do
			ldbl_quantityAssigned += ist_Data [ ll_PartRow ].qty_assigned
			ldbl_netquantity = ist_Data [ ll_PartRow ].qnty - ist_Data [ ll_PartRow ].onhand
	
			if ldbl_QuantityAssigned > 0 then
				if ldbl_QuantityAssigned > ldbl_netQuantity then
					ist_Data [ ll_PartRow ].qty_assigned = ldbl_netquantity
					ldbl_quantityassigned -= ldbl_netquantity
				else
					ist_Data [ ll_PartRow ].qty_assigned = ldbl_QuantityAssigned
					ldbl_Quantityassigned = 0
				end if
			end if
			ldbl_checkquantity = ist_Data [ ll_PartRow ].qty_assigned + ist_Data [ ll_PartRow ].onhand
	
			ll_PartRow++
		loop while ll_PartRow <= ll_LastRow and ldbl_checkquantity > 0
	end if 
	
	//	Check for cancel.
	Yield ( )
	if bCancel then
		return -1
	end if
next

return 0
end function

private function integer of_rewrite ();
//	Declarations
long	ll_Row
long	ll_Rows

//	Initialize
ll_Rows = UpperBound ( ist_Data )
w_progress_bar.cb_1.enabled = false
for ll_Row = 1 to ll_Rows
		choose case ist_Data [ ll_Row ].bucket_no
			case -1
				ist_Data [ ll_Row ].qty_req_past = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_past = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_past = ist_Data [ ll_Row ].onhand
			case 0
				ist_Data [ ll_Row ].qty_req_1 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_1 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_1 = ist_Data [ ll_Row ].onhand
			case 1
				ist_Data [ ll_Row ].qty_req_2 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_2 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_2 = ist_Data [ ll_Row ].onhand
			case 2
				ist_Data [ ll_Row ].qty_req_3 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_3 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_3 = ist_Data [ ll_Row ].onhand
			case 3
				ist_Data [ ll_Row ].qty_req_4 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_4 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_4 = ist_Data [ ll_Row ].onhand
			case 4
				ist_Data [ ll_Row ].qty_req_5 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_5 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_5 = ist_Data [ ll_Row ].onhand
			case 5
				ist_Data [ ll_Row ].qty_req_6 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_6 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_6 = ist_Data [ ll_Row ].onhand
			case 6
				ist_Data [ ll_Row ].qty_req_7 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_7 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_7 = ist_Data [ ll_Row ].onhand
			case 7
				ist_Data [ ll_Row ].qty_req_8 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_8 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_8 = ist_Data [ ll_Row ].onhand
			case 8
				ist_Data [ ll_Row ].qty_req_9 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_9 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_9 = ist_Data [ ll_Row ].onhand
			case 9
				ist_Data [ ll_Row ].qty_req_10 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_10 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_10 = ist_Data [ ll_Row ].onhand
			case 10
				ist_Data [ ll_Row ].qty_req_11 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_11 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_11 = ist_Data [ ll_Row ].onhand
			case 11
				ist_Data [ ll_Row ].qty_req_12 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_12 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_12 = ist_Data [ ll_Row ].onhand
			case 12
				ist_Data [ ll_Row ].qty_req_13 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_13 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_13 = ist_Data [ ll_Row ].onhand
			case 13
				ist_Data [ ll_Row ].qty_req_14 = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_14 = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_14 = ist_Data [ ll_Row ].onhand
			case 14
				ist_Data [ ll_Row ].qty_req_future = ist_Data [ ll_Row ].qnty - ist_Data [ ll_Row ].qty_assigned - ist_Data [ ll_Row ].onhand
//				ist_Data [ ll_Row ].qty_agn_future = ist_Data [ ll_Row ].qty_assigned
//				ist_Data [ ll_Row ].qty_oh_future = ist_Data [ ll_Row ].onhand
		end choose
	if Int ( Mod ( 100 * ll_Row / ll_Rows, 10 ) ) = 1 then w_progress_bar.wf_setstatus ( "Rewriting data to grid...", 101 * ll_Row / ll_Rows )
next
Return 0
end function

private function integer of_processpart (string as_part, double adbl_quantity);//	Declarations.
datetime	ldt_due
double	ldbl_QuantityRequired
double	ldbl_QuantityAssigned
double	ldbl_QuantityOnhand
double	ldbl_NetQuantity
double	ldbl_BOMQty
double	ldbl_Extended
double	ldbl_AssignedOnhandQuantity
double	ldbl_appliedonhand
double	ldbl_onhandtemp
long	ll_FirstRow
long	ll_LastRow
long	ll_PartRow
long	ll_ProcessedRow
long	ll_ProcessedRows
long	ll_ChildPartRow
long	ll_ChildPartRows
long	ll_origin
long	ll_source
long	ll_childorigin
long	ll_childsource
long	ll_Time
string	ls_tmppart
string	ls_ChildPart
int	li_idx, &
	li_maxidx, &
	li_ctr
str_bom	lst_PartList [ ]

long	ll_indxno=1

str_data	lstr_onhanddata[]
str_data	lstr_onhanddatatemp[]

long	ll_idxelements[]

//	Get First and Last row for top part.
of_GetPartFirstLast ( as_Part, ll_FirstRow, ll_LastRow )

if ll_FirstRow > 0 then
	
	//	Eliminate net requirements in default (due date) order.
	ll_PartRow = ll_FirstRow
	do
		//	Get the origin and source of the parent 		
		ll_origin = ist_Data [ ll_PartRow ].origin
		ll_source = ist_Data [ ll_PartRow ].source
		ls_tmppart = ist_Data [ ll_PartRow ].part
		
		ldbl_QuantityRequired = ist_Data [ ll_PartRow ].qnty
//		ldbl_QuantityAssigned = ist_Data [ ll_PartRow ].qty_assigned
		ldbl_QuantityOnhand = ist_Data [ ll_PartRow ].onhand
//		ldbl_NetQuantity = ( ldbl_QuantityRequired - ( ldbl_QuantityAssigned + ldbl_QuantityOnhand ) )
		ldbl_NetQuantity = ( ldbl_QuantityRequired - ldbl_QuantityOnhand )

		if ldbl_NetQuantity > 0 then
			if ldbl_NetQuantity < adbl_Quantity then
				ist_Data [ ll_PartRow ].onhand = ldbl_NetQuantity + ldbl_QuantityOnhand
				adbl_Quantity -= ldbl_NetQuantity
				ll_ProcessedRows++
				ldbl_AssignedOnhandQuantity += ldbl_NetQuantity

				//	Assign origin, source and applied onhand into the structure
				if ll_origin > 0 and ll_source > 0 then 
					lstr_onhanddata[ll_indxno].origin = ll_origin
					lstr_onhanddata[ll_indxno].source = ll_source
					lstr_onhanddata[ll_indxno].quantity = ldbl_NetQuantity
					lstr_onhanddata[ll_indxno].part = ls_tmppart
					ll_indxno++
				end if 	
			else
				ist_Data [ ll_PartRow ].onhand = ldbl_QuantityOnhand + adbl_Quantity
				ll_ProcessedRows++
				ldbl_AssignedOnhandQuantity += adbl_Quantity

				//	Assign origin, source and applied onhand into the structure				
				if ll_origin > 0 and ll_source > 0 then 
					lstr_onhanddata[ll_indxno].origin = ll_origin
					lstr_onhanddata[ll_indxno].source = ll_source
					lstr_onhanddata[ll_indxno].quantity = adbl_quantity
					lstr_onhanddata[ll_indxno].part = ls_tmppart					
					ll_indxno++
				end if 	
				adbl_Quantity = 0
			end if
		end if
		
		ll_PartRow++
	loop while ll_PartRow <= ll_LastRow and adbl_Quantity > 0
/*
	// 	Eliminate assigned quantity in default (due date) order.
	if adbl_Quantity > 0 then
		ll_PartRow = ll_FirstRow
		do
			ldbl_QuantityAssigned = ist_Data [ ll_PartRow ].qty_assigned
			ldbl_QuantityOnhand = ist_Data [ ll_PartRow ].onhand
			ldt_due = ist_Data [ ll_PartRow ].due_date
	
			if ldbl_QuantityAssigned > 0 then
				if ldbl_QuantityAssigned < adbl_Quantity then
					ist_Data [ ll_PartRow ].qty_assigned = 0
					ist_Data [ ll_PartRow ].onhand = ldbl_QuantityOnhand + ldbl_QuantityAssigned
					ll_ProcessedRows++
					ldbl_AssignedOnhandQuantity += ldbl_QuantityAssigned
					adbl_Quantity -= ldbl_QuantityAssigned
				else
					ist_Data [ ll_PartRow ].qty_assigned = ldbl_QuantityAssigned - adbl_Quantity
					ist_Data [ ll_PartRow ].onhand = ldbl_QuantityOnhand + adbl_Quantity
					ll_ProcessedRows++
					ldbl_AssignedOnhandQuantity += adbl_Quantity
					adbl_Quantity = 0
				end if
			end if
	
			ll_PartRow++
		loop while ll_PartRow <= ll_LastRow and adbl_Quantity > 0
	end if
*/	
	//	Expand bill of materials.
	
	if ll_ProcessedRows > 0 then
		
		is_TopPart = as_Part
		
		execute PartList  ;
		
		do while sqlca.sqlcode = 0
			ll_ChildPartRows ++
			
			fetch	PartList
			into	:lst_PartList [ ll_ChildPartRows ].part,
					:lst_PartList [ ll_ChildPartRows ].level,
					:lst_PartList [ ll_ChildPartRows ].quantity  ;
		loop
		close PartList  ;
		
		ll_ChildPartRows --
	end if
	
	//	Process onhand through bill of materials.
	for ll_ChildPartRow = 2 to ll_ChildPartRows

		//	Calculate extended quantity to assign to children.
		ls_ChildPart = lst_PartList [ ll_ChildPartRow ].part
		ldbl_BOMQty = lst_PartList [ ll_ChildPartRow ].quantity
		ldbl_Extended = ldbl_BOMQTY * ldbl_AssignedOnhandQuantity
		
		//	Initilize the array	
		lstr_onhanddatatemp = lstr_onhanddata

		//	extract the parent from the general array into temp array for the current component
		li_maxidx = Upperbound ( lstr_onhanddatatemp ) 
		if li_maxidx > 0 then
			for li_idx = 1 to li_maxidx
				lstr_onhanddatatemp[li_idx].quantity = lstr_onhanddatatemp[li_idx].quantity * ldbl_BOMQTY
			next 	
		end if 	
		
		// 	Get first and last row in grid for current part
		of_GetPartFirstLast ( ls_ChildPart, ll_FirstRow, ll_LastRow )
		
		if ll_FirstRow > 0 then 
			
			//	Eliminate net requirements from children parts in default (due date) order.
			ll_PartRow = ll_FirstRow
			do				
				//	Get the child's origin, source
				ll_childorigin = ist_Data [ ll_PartRow ].origin
				ll_childsource = ist_Data [ ll_PartRow ].source
				//	Search for that origin,source in the structure
				//	Upon finding get the quantity assigned
				li_maxidx = Upperbound ( lstr_onhanddatatemp ) 
				if li_maxidx > 0 then
					li_ctr = 0
					ldbl_appliedonhand = 0 
					for li_idx = 1 to li_maxidx
						if lstr_onhanddatatemp[li_idx].origin = ll_childorigin and lstr_onhanddatatemp[li_idx].source = ll_childsource then 
							ldbl_appliedonhand += lstr_onhanddatatemp[li_idx].quantity
							li_ctr++
							ll_idxelements[li_ctr] = li_idx
						end if    
					next 	
				end if 	
				
				ldbl_QuantityRequired = ist_Data [ ll_PartRow ].qnty
//				ldbl_QuantityAssigned = ist_Data [ ll_PartRow ].qty_assigned
				ldbl_QuantityOnhand = ist_Data [ ll_PartRow ].onhand
//				ldbl_NetQuantity = ( ldbl_QuantityRequired - ( ldbl_QuantityAssigned + ldbl_QuantityOnhand ) )
				ldbl_NetQuantity = ( ldbl_QuantityRequired - ldbl_QuantityOnhand )

				if ldbl_NetQuantity > 0 and ldbl_Extended > 0 THEN
					if ldbl_NetQuantity < ldbl_extended then
						if ldbl_netquantity < ldbl_appliedonhand then 
							ist_Data [ ll_PartRow ].onhand = ldbl_NetQuantity + ldbl_QuantityOnhand 
							ldbl_onhandtemp = ldbl_NetQuantity
							ldbl_Extended -= ldbl_NetQuantity
						else
							ist_Data [ ll_PartRow ].onhand = ldbl_appliedonhand + ldbl_QuantityOnhand 
							ldbl_onhandtemp = ldbl_appliedonhand
							ldbl_Extended -= ldbl_appliedonhand
						end if 
					else
						if ldbl_extended < ldbl_appliedonhand then 	
							ist_Data [ ll_PartRow ].onhand = ldbl_Extended + ldbl_QuantityOnhand 
							ldbl_onhandtemp = ldbl_extended							
							ldbl_Extended = 0
						else
							ist_Data [ ll_PartRow ].onhand = ldbl_appliedonhand + ldbl_QuantityOnhand 
							ldbl_onhandtemp = ldbl_appliedonhand
							ldbl_Extended -= ldbl_appliedonhand
						end if 							
					end if
					li_maxidx = Upperbound ( ll_idxelements ) 
					if li_maxidx > 0 then
						for li_idx = 1 to li_maxidx
							li_ctr = ll_idxelements[li_idx]
							if lstr_onhanddatatemp[li_ctr].quantity < ldbl_onhandtemp then 
								ldbl_onhandtemp -= lstr_onhanddatatemp[li_ctr].quantity
								lstr_onhanddatatemp[li_ctr].quantity = 0 
							else
								lstr_onhanddatatemp[li_ctr].quantity -= ldbl_onhandtemp
								ldbl_onhandtemp = 0
							end if    
						next 	
					end if 	
				end if
				
				ll_PartRow++
				
			loop while ll_PartRow <= ll_LastRow and ldbl_Extended > 0
/*			
			// 	Eliminate assigned quantity from children parts in default (due date) order.
			if ldbl_Extended > 0 then
				ll_PartRow = ll_FirstRow
				do	
					ldbl_QuantityAssigned = ist_Data [ ll_PartRow ].qty_assigned
					ldbl_QuantityOnhand = ist_Data [ ll_PartRow ].onhand
					ldt_Due = ist_Data [ ll_PartRow ].due_date
		
					if ldbl_QuantityAssigned > 0 then
						IF ldbl_QuantityAssigned < ldbl_Extended then
							ist_Data [ ll_PartRow ].qty_assigned = 0
							ist_Data [ ll_PartRow ].onhand = ldbl_QuantityOnhand + ldbl_QuantityAssigned
							ldbl_Extended -= ldbl_QuantityAssigned
						else
							ist_Data [ ll_PartRow ].qty_assigned = ldbl_QuantityAssigned - ldbl_Extended
							ist_Data [ ll_PartRow ].onhand = ldbl_QuantityOnhand + ldbl_Extended
							ldbl_Extended = 0
						end if
					end if
					ll_PartRow++
				loop while ll_PartRow <= ll_LastRow and ldbl_Extended > 0
			end if
*/			
		end if
	next
end if

Return 0
end function

private subroutine of_getpartfirstlast (string as_part, ref long al_first, ref long al_last);
//	Declarations
long	ll_PartPointer
long	ll_High
long	ll_Low

//	Initialize
ll_High = il_Parts
ll_Low = 1
ll_PartPointer = ( ll_High + ll_Low ) / 2

//	Find part through bracketing.
do
	if as_Part > istr_Parts [ ll_PartPointer ].part then
		ll_Low = ll_PartPointer + 1
		ll_PartPointer = ( ll_High + ll_Low ) / 2
	else
		ll_High = ll_PartPointer
		ll_PartPointer = ( ll_High + ll_Low ) / 2
	end if
loop while ll_Low <> ll_High

if as_Part = istr_Parts [ ll_PartPointer ].part then
	al_First = istr_Parts [ ll_PartPointer ].firstrow
	al_Last = istr_Parts [ ll_PartPointer ].lastrow
else
	al_First = 0
	al_Last = -1
end if
end subroutine

on n_cst_netout.create
TriggerEvent( this, "constructor" )
end on

on n_cst_netout.destroy
TriggerEvent( this, "destructor" )
end on

