$PBExportHeader$n_cst_globalshipsched.sru
forward
global type n_cst_globalshipsched from n_cst_gmaps
end type
end forward

global type n_cst_globalshipsched from n_cst_gmaps
end type
global n_cst_globalshipsched n_cst_globalshipsched

type variables

Public:
string	is_Customer, is_Destination

end variables

forward prototypes
public subroutine of_gss (n_cst_associative_array anv_gssmessage)
public function integer of_createshipper (ref datastore ads_ShipperHeader, ref long al_ShipperID)
public function integer of_createshipper (ref datawindow adw_ShipperHeader, ref long al_ShipperID)
public function integer of_findshipperdetail (long al_Shipper, string as_Part, long al_Suffix)
private function integer of_createshipperdetail (ref datastore ads_ShipperDetail)
public function integer of_createshipperdetail (long al_shipperid, long al_orderno, string as_part, long al_suffix, string as_shipper)
public function integer of_updateshipperrequirements (long al_ShipperID, string as_Part, long al_Suffix, decimal adec_Quantity)
public function integer of_reconcileshipper (long al_ShipperID)
public subroutine of_editshipperheader (n_cst_associative_array anv_gssmessage)
end prototypes

public subroutine of_gss (n_cst_associative_array anv_gssmessage);
//	Read drag message.
string	ls_Originator
ls_Originator = IsNull ( anv_GSSMessage.of_GetItem ( "Originator" ), ls_Originator )

//	Perform appropriate measures according to the originator.
datetime	ldt_DueDT, ldt_DeliveryDT
integer	li_Return = -1, li_Counter, li_OrderCount, li_OrderDetailRows
long	ll_Orders []
long  ll_Ids []
string	ls_ShipTo
string	ls_SQLErrors, ls_DWErrors, ls_OrderDetailInfoSyntax, ls_OrderDetailInfoSelect

n_ds	lnds_OrderDetailInfo

choose case ls_Originator
	case "Order Headers"
		//	Each order will be scheduled separately.  Loop through each and process.
		ll_Orders = IsNull ( anv_GSSMessage.of_GetItem ( "Orders" ), ll_Orders )
		li_OrderCount = UpperBound ( ll_Orders )
		for li_Counter = 1 to li_OrderCount
			//	Get the shipto for this order.
			select	destination
			into	:ls_ShipTo
			from	CSOrderHeaders
			where	OrderNo = :ll_Orders [li_Counter] using SQLCA  ;
			
			//	Get the desired departure date for this order.
			select	Min ( DueDT ), Min ( DeliveryDT )
			into	:ldt_DueDT, :ldt_DeliveryDT
			from	CSOrderDetails
			where	OrderNo = :ll_Orders [li_Counter] and
				CommittedQty < StdQty using SQLCA  ;
			
			//	Retrieve the order detail information for the selected order.
			//	Using this select statement, build a datastore and retrieve data.
			ls_OrderDetailInfoSelect = &
				"select	CSOrderDetails.PartNumber, " +&
				"	CSOrderDetails.DueDT, " +&
				"	SuggestedQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
				"	CSOrderDetails.Unit, " +&
				"	ScheduledQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
				"	CSOrderDetails.PackSize, " +&
				"	convert ( integer, CSOrderDetails.OrderNo ), " +&
				"	CSOrderDetails.CustomerPart, " +&
				"	CSOrderDetails.Suffix, " +&
				"	Shipper = -1, " +&
				"	Note = convert ( varchar (255), '' ) " +&
				"from	CSOrderDetails " +&
				"where	CSOrderDetails.OrderNo = " + String (ll_Orders [li_Counter])
			
			lnds_OrderDetailInfo = create n_ds
			ls_OrderDetailInfoSyntax = SQLCA.SyntaxFromSQL ( ls_OrderDetailInfoSelect, "", ls_SQLErrors )
			if ls_SQLErrors > "" then
				MessageBox ( monsys.msg_Title, "Application error (Unable to build DW Syntax for retrieving Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + "):  " + ls_SQLErrors, StopSign! )
				return
			end if
			
			//	Create datastore.
			lnds_OrderDetailInfo.Create ( ls_OrderDetailInfoSyntax, ls_DWErrors )
			if ls_DWErrors > "" then
				MessageBox ( monsys.msg_Title, "Application error (Unable to Create DW for retrieving Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + "):  " + ls_DWErrors, StopSign! )
				return
			end if
			
			//	Retrieve details.
			lnds_OrderDetailInfo.of_SetTransObject ( SQLCA )
			li_OrderDetailRows = lnds_OrderDetailInfo.Retrieve ()
			choose case li_OrderDetailRows
				case is < 0
					MessageBox ( monsys.msg_Title, "Application error (Unable to Retrieve Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + ")!", StopSign! )
					return
				case 0
					if li_Counter = li_OrderCount then
						MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Orders [li_Counter] ) + ")." )
					else
						if MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Orders [li_Counter] ) + ").  Do you wish to continue with the next order?", Question!, YesNo!, 2 ) = 2 then return
					end if
				case else
					//	Open dialogue to schedule this shipper.
					anv_GSSMessage.of_SetItem ( "shipper detail", lnds_OrderDetailInfo )
					anv_GSSMessage.of_SetItem ( "shipper note", "" )
//					//PCV anv_GSSMessage.of_SetItem ( "shipper id", 0 ) new
//					anv_GSSMessage.of_SetItem ( "shipper id", 0 )  //old
					anv_GSSMessage.of_SetItem ( "shipto", ls_ShipTo )
					anv_GSSMessage.of_SetItem ( "DueDT", ldt_DueDT )
					anv_GSSMessage.of_SetItem ( "DeliveryDT", ldt_DeliveryDT)
					OpenWithParm ( w_shipper_manifest_new, anv_GSSMessage )
					li_Return = Message.DoubleParm
			end choose
		next
		
	case "Order Details"
		//	Each order will be scheduled separately.  Loop through each and process.
		long ll_Distinct_Orders []
		integer li_Counter_Target
		long ll_OrderNo , ll_Total_Elements_Distinct_Orders 
		boolean lb_Found
		string ls_Ids
		ll_Orders = IsNull ( anv_GSSMessage.of_GetItem ( "Orders" ), ll_Orders )
		// With this code, ll_Distinct_Orders is an array, with the different OrderNo values
		// e.g. : if ll_orders has this values:  [1,2,3,1,3,4,5,2,3,2]
		// ll_Distinct_Orders will be: [1,2,3,4,5]
		for li_Counter = 1 to UpperBound (ll_Orders)
			ll_OrderNo	=	ll_Orders [ li_Counter ]
			lb_Found		=	False
			ll_Total_Elements_Distinct_Orders =	UpperBound(ll_Distinct_Orders)
			li_Counter_Target = 1
			do while  ( li_Counter_Target <= ll_Total_Elements_Distinct_Orders ) and ( lb_found = False )
				if ll_OrderNo	=	ll_Distinct_Orders [ li_Counter_Target] then
					lb_found	=	True
				end if
				li_Counter_Target ++
			loop
			if lb_found = False then
				ll_Total_Elements_Distinct_Orders ++
				ll_Distinct_Orders [ ll_Total_Elements_Distinct_Orders ] = ll_OrderNo
			end if
		next
		
		ll_Ids = IsNull ( anv_GSSMessage.of_GetItem ( "Ids" ), ll_Ids )
		ls_Ids = '('
		for li_Counter = 1 to UpperBound ( ll_Ids )
			ls_Ids += string ( ll_Ids [ li_Counter ] ) + ","
		next
		ls_Ids = mid (ls_Ids,1,len(ls_Ids) - 1)
		ls_Ids += ')'
		//ls_Ids has all the values of the field Id, e.g. (1232,1122,4332,2345)
		
		//li_OrderCount = UpperBound ( ll_Orders )
		li_OrderCount = UpperBound ( ll_Distinct_Orders )
		for li_Counter = 1 to li_OrderCount
			//	Get the shipto for this order.
			select	destination
			into	:ls_ShipTo
			from	CSOrderHeaders
			where	OrderNo = :ll_Distinct_Orders [li_Counter] using SQLCA  ;
			
			//	Get the desired departure date for this order.
			select	Min(DueDT), Min(DeliveryDT)
			into	:ldt_DueDT, :ldt_DeliveryDT
			from	CSOrderDetails
			where	OrderNo = :ll_Distinct_Orders [li_Counter] using SQLCA  ;
			
			//	Retrieve the order detail information for the selected order.
			//	Using this select statement, build a datastore and retrieve data.
			ls_OrderDetailInfoSelect = &
				"select	CSOrderDetails.PartNumber, " +&
				"	CSOrderDetails.DueDT, " +&
				"	SuggestedQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
				"	CSOrderDetails.Unit, " +&
				"	ScheduledQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
				"	CSOrderDetails.PackSize, " +&
				"	convert ( integer, CSOrderDetails.OrderNo ), " +&
				"	CSOrderDetails.CustomerPart, " +&
				"	CSOrderDetails.Suffix, " +&
				"	Shipper = -1, " +&
				"	Note = convert ( varchar (255), '' ) " +&
				"from	CSOrderDetails " +&
				"where	CSOrderDetails.OrderNo = " + String (ll_Distinct_Orders [li_Counter] )+ " and CSOrderDetails.Id in " + ls_Ids
			
			lnds_OrderDetailInfo = create n_ds
			ls_OrderDetailInfoSyntax = SQLCA.SyntaxFromSQL ( ls_OrderDetailInfoSelect, "", ls_SQLErrors )
			if ls_SQLErrors > "" then
				MessageBox ( monsys.msg_Title, "Application error (Unable to build DW Syntax for retrieving Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + "):  " + ls_SQLErrors, StopSign! )
				return
			end if
			
			//	Create datastore.
			lnds_OrderDetailInfo.Create ( ls_OrderDetailInfoSyntax, ls_DWErrors )
			if ls_DWErrors > "" then
				MessageBox ( monsys.msg_Title, "Application error (Unable to Create DW for retrieving Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + "):  " + ls_DWErrors, StopSign! )
				return
			end if
			
			//	Retrieve details.
			lnds_OrderDetailInfo.of_SetTransObject ( SQLCA )
			li_OrderDetailRows = lnds_OrderDetailInfo.Retrieve ()
			choose case li_OrderDetailRows
				case is < 0
					MessageBox ( monsys.msg_Title, "Application error (Unable to Retrieve Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ")!", StopSign! )
					return
				case 0
					if li_Counter = li_OrderCount then
						MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ")." )
					else
						if MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ").  Do you wish to continue with the next order?", Question!, YesNo!, 2 ) = 2 then return
					end if
				case else
					//	Open dialogue to schedule this shipper.
					anv_GSSMessage.of_SetItem ( "shipper detail", lnds_OrderDetailInfo )
					anv_GSSMessage.of_SetItem ( "shipper note", "" )
					//PCV anv_GSSMessage.of_SetItem ( "shipper id", 0 ) new
					anv_GSSMessage.of_SetItem ( "shipper id", 0 ) //old
					anv_GSSMessage.of_SetItem ( "shipto", ls_ShipTo )
					anv_GSSMessage.of_SetItem ( "DueDT", ldt_DueDT )
					anv_GSSMessage.of_SetItem ( "DeliveryDT", ldt_DeliveryDT)
					OpenWithParm ( w_shipper_manifest_new, anv_GSSMessage )
					li_Return = Message.DoubleParm
			end choose
		next
end choose

end subroutine

public function integer of_createshipper (ref datastore ads_ShipperHeader, ref long al_ShipperID);
//************************************************************************************//
// Function Name:	of_CreateShipper
//
// Description:		This function creates a new shipper.
//
// Syntax:		long of_CreateShipper ( DataStore * ads_ShipperHeader,
//						long * al_ShipperId )
//
// Where:		ads_ShipperHeader	The data to be inserted in shipper header.
//			al_ShipperId		The id of the created shipper.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which create the 
//			shipper.  al_ShipperId will be changed to the created id no error
//			occurred.  If ads_ShipperHeader is null, function returns null.
//
// Log of Changes:
// EES 02-22-1999 10:26.00 Original.
//************************************************************************************//

//	Declare local variables.
constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

DataStore	lds_ShipperHeader
DataStore	lds_GetNextShipper

//	Make sure datastore sent is valid.
SetNull ( li_returnvalue )
if IsValid ( ads_ShipperHeader ) then
	if ads_ShipperHeader.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		//	Create and retrieve datastore to get next shipper number.
		lds_GetNextShipper = create DataStore
		lds_GetNextShipper.DataObject = "d_msp_get_next_shipper"
		lds_GetNextShipper.SetTransObject ( SQLCA )
		//	Make sure a row was returned in getting next shipper number.
		if lds_GetNextShipper.Retrieve ( ) > 0 then
			//	Put new shipper number in ads_ShipperHeader.
			al_ShipperId = lds_GetNextShipper.object.shipper [ 1 ]
			ads_ShipperHeader.object.id [ 1 ] = al_ShipperId
			//	Create updateable datastore to create new shipper.
			lds_ShipperHeader = create DataStore
			lds_ShipperHeader.DataObject = "d_shipper_header"
			lds_ShipperHeader.SetTransObject ( SQLCA )
			//	Copy the shipper information to the updateable datastore and update if successful.
			if ads_ShipperHeader.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_ShipperHeader, BEGINROW, Primary! ) = 1 then
				//	Create shipper.
				if lds_ShipperHeader.Update ( ) = 1 then
					li_returnvalue = 0
				else
					li_returnvalue = -1
				end if
			end if
			destroy lds_ShipperHeader
		end if
		destroy lds_GetNextShipper
	end if
end if

//  Return.
return li_returnvalue

end function

public function integer of_createshipper (ref datawindow adw_ShipperHeader, ref long al_ShipperID);//************************************************************************************//
// Function Name:	of_CreateShipper
//
// Description:		This function creates a new shipper.
//
// Syntax:			long of_CreateShipper	(	DataStore *	adw_ShipperHeader,
//												long *		al_ShipperId )
//
// Where:		adw_ShipperHeader			The data to be inserted in shipper header.
//				al_ShipperId				The id of the created shipper.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which create the 
//					shipper.  al_ShipperId will be changed to the created id no error
//					occurred.  If adw_ShipperHeader is null, function returns null.
//
// Log of Changes:
// EES 02-22-1999 10:26.00 Original.
//************************************************************************************//

// declare local variables
constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_returnvalue

DataStore	lds_ShipperHeader
DataStore	lds_GetNextShipper

// make sure datastore sent is valid
SetNull ( li_returnvalue )
if IsValid ( adw_ShipperHeader ) then
	if adw_ShipperHeader.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		// create and retrieve datastore to get next shipper number
		lds_GetNextShipper = create DataStore
		lds_GetNextShipper.DataObject = "d_msp_get_next_shipper"
		lds_GetNextShipper.SetTransObject ( SQLCA )

		// make sure a row was returned in getting next shipper number
		if lds_GetNextShipper.Retrieve ( ) > 0 then
			//	put new shipper number in adw_ShipperHeader
			al_ShipperId = lds_GetNextShipper.object.shipper [ 1 ]
			adw_ShipperHeader.object.id [ 1 ] = al_ShipperId
			//	create updateable datastore to create new shipper
			lds_ShipperHeader = create DataStore
			lds_ShipperHeader.DataObject = "d_shipper_header"
			lds_ShipperHeader.SetTransObject ( SQLCA )
			//	copy the shipper information to the updateable datastore and update if successful
			if adw_ShipperHeader.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_ShipperHeader, BEGINROW, Primary! ) = 1 THEN
				//	create shipper
				if lds_ShipperHeader.Update ( ) = 1 THEN
					li_returnvalue = 0
				else
					li_returnvalue = -1
				end if
			end if
			destroy lds_ShipperHeader
		end if
		destroy lds_GetNextShipper
	end if
end if

//  return
return li_returnvalue

end function

public function integer of_findshipperdetail (long al_Shipper, string as_Part, long al_Suffix);//************************************************************************************//
// Function Name:	of_FindShipperDetail
//
// Description:		This function finds a shipper detail line item.
//
// Syntax:			long of_FindShipperDetail	(	long	al_ShipperId,
//													string	as_Part,
//													long	al_Suffix )
//
// Where:		al_shipper_id		The shipper of the shipper detail to find.
//				as_part				The part of the shipper detail to find.
//				al_suffix			The suffix of the shipper detail to find.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which find the
//					shipper detail. if al_shipper_id or as_part is null, function
//					returns null.
//
// Log of Changes:
// EES 02-22-1999 10:26.00 Original.
//************************************************************************************//

//  Declarations.
integer	li_ReturnValue
 
//	Check for valid data.
SetNull ( li_returnvalue )

if IsNull ( al_shipper ) then
	Return li_returnvalue
end if

//  Execute.
SELECT	part_original
  INTO	:as_Part
  FROM	shipper_detail
 WHERE	shipper = :al_Shipper AND
 		part_original = :as_Part AND
		IsNull ( suffix, 0 ) = IsNull ( :al_Suffix, 0 )  ;

li_ReturnValue = SQLCA.SQLCode

//  return.
return li_ReturnValue
end function

private function integer of_createshipperdetail (ref datastore ads_ShipperDetail);//************************************************************************************//
// Function Name:	of_CreateShipperDetail
//
// Description:		This function creates a new shipper detail line item.
//
// Syntax:			long of_CreateShipper	(	DataStore *	ads_ShipperDetail )
//
// Where:			ads_ShipperDetail			The data to be inserted in shipper detail.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which create the 
//					shipper detail line item.  If ads_ShipperHeader is not valid,
//					function returns null.
//
// Log of Changes:
// EES 02-23-1999 17:02.00 Original.
//************************************************************************************//

// declare local variables
constant integer	BEGINROW = 1
constant integer	ENDROW = 1

integer	li_ReturnValue

DataStore	lds_ShipperDetail

// make sure datastore sent is valid
SetNull ( li_returnvalue )
if IsValid ( ads_ShipperDetail ) then
	if ads_ShipperDetail.RowCount ( ) = 0 then
		li_returnvalue = 100
	else
		//	create updateable datastore to create new shipper detail
		lds_ShipperDetail = create DataStore
		lds_ShipperDetail.DataObject = "d_shipper_detail"
		lds_ShipperDetail.SetTransObject ( SQLCA )
		//	copy the shipper information to the updateable datastore and update if successful
		if ads_ShipperDetail.RowsCopy ( BEGINROW, ENDROW, Primary!, lds_ShipperDetail, BEGINROW, Primary! ) = 1 then
			//	create shipper detail
			if lds_ShipperDetail.Update ( ) = 1 then
				li_ReturnValue = 0
			else
				li_ReturnValue = -1
			end if
		end if
		destroy lds_ShipperDetail
	end if
end if

//  return
return li_ReturnValue
end function

public function integer of_createshipperdetail (long al_shipperid, long al_orderno, string as_part, long al_suffix, string as_shipper);//************************************************************************************//
// Function Name:	of_CreateShipperDetail
//
// Description:		This function creates a new shipper detail line item.
//
// Syntax:			long of_CreateShipperDetail	(	long	al_ShipperId,
//													long	al_OrderNo,
//													string	as_Part,
//													long	al_Suffix )
//
// Where:		al_ShipperId		The shipper of the shipper detail to create.
//				al_OrderNo			The order from which the demand originates.
//				as_Part				The part of the shipper detail to create.
//				al_Suffix			The suffix of the shipper detail to create.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which creates the
//					shipper detail. If al_ShipperId or as_Part is null, function
//					returns null.
//
// Log of Changes:
// EES 02-23-1999 17:06.00 Original.
//************************************************************************************//

//	Declare local variables.
integer	li_ReturnValue

long	ll_NewShipperDetailRows

DataStore	lds_ShipperDetailNew

//	Check for valid data.
SetNull ( li_ReturnValue )
if not IsNull ( al_ShipperId ) and not IsNull ( as_Part ) then

	//	Build data for shipper detail.
	lds_ShipperDetailNew = create DataStore
	lds_ShipperDetailNew.DataObject = "d_shipper_detail_new"
	lds_ShipperDetailNew.SetTransObject ( SQLCA )
	ll_NewShipperDetailRows = lds_ShipperDetailNew.Retrieve ( al_OrderNo, al_ShipperId, as_Part, IsNull ( al_Suffix, 0 ) )
	
	//	If data build succeeded, create shipper detail using overloaded function.
	if ll_NewShipperDetailRows = 1 then

			//	Set the note.
			lds_ShipperDetailNew.object.note [1] = as_Shipper
			
			//	Create shipper detail.
			li_ReturnValue = of_CreateShipperDetail ( lds_ShipperDetailNew )
	else
		li_ReturnValue = 100
	end if
end if

//  Return.
return li_ReturnValue


end function

public function integer of_updateshipperrequirements (long al_ShipperID, string as_Part, long al_Suffix, decimal adec_Quantity);//************************************************************************************//
// Function Name:	of_UpdateShipperRequirement
//
// Description:		This function finds a shipper detail line item.
//
// Syntax:			long of_UpdateShipperRequirement	(	long	al_ShipperId,
//															string	as_Part,
//															long	al_Suffix,
//															decimal	adec_quantity )
//
// Where:		al_shipper_id		The shipper of the shipper detail to updaet.
//				as_part				The part of the shipper detail to find.
//				al_suffix			The suffix of the shipper detail to find.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which find the
//					shipper detail. If al_shipper_id or as_part is null, function
//					returns null.
//
// Log of Changes:
// EES 02-22-1999 10:26.00 Original.
//************************************************************************************//

//  declare local variables
integer	li_ReturnValue
 
//	check for valid data
SetNull ( li_returnvalue )

if IsNull ( al_ShipperID ) then
	Return li_returnvalue
end if

//  execute
UPDATE	shipper_detail
   SET	qty_required = qty_required + :adec_quantity,
   		qty_original = qty_original + :adec_quantity
 WHERE	shipper = :al_ShipperID AND
 		part_original = :as_Part AND
		IsNull ( suffix, 0 ) = IsNull ( :al_Suffix, 0 )  ;

li_ReturnValue = SQLCA.SQLCode

//  return
return li_ReturnValue
end function

public function integer of_reconcileshipper (long al_ShipperID);//************************************************************************************//
// Function Name:	of_ReconcileShipper
//
// Description:		This function reconciles a shipper.
//
// Syntax:			LONG of_ReconcileShipper	(	LONG	al_Shipper_id )
//
// Where:		al_Shipper_id				The id of the shipper to reconcile.
//
// Returns Codes:	Returns the SQLCode result of the SQL statements which reconcile
//					the shipper. If al_Shipper_id is null, function returns null.
//
// Log of Changes:
// EES 02-22-1999 10:26.00 Original.
//************************************************************************************//

//  Declarations.
INTEGER	li_ReturnValue

DataStore	lds_msp_reconcile_shipper

//	Check for valid data.
SetNull ( li_ReturnValue )

IF IsNull ( al_ShipperID )  THEN
	Return li_ReturnValue
END IF

//  Initializations.
lds_msp_reconcile_shipper = CREATE DataStore
lds_msp_reconcile_shipper.DataObject = "d_msp_reconcile_shipper"
lds_msp_reconcile_shipper.SetTransObject ( SQLCA )

//  Execute.
IF lds_msp_reconcile_shipper.Retrieve ( al_ShipperID ) > 0 THEN
	li_ReturnValue = lds_msp_reconcile_shipper.object.result [ 1 ]
END IF

//  Clean up.
DESTROY lds_msp_reconcile_shipper

//  Return.
Return li_ReturnValue
end function

public subroutine of_editshipperheader (n_cst_associative_array anv_gssmessage);long ll_Shipper_Id
ll_Shipper_Id = IsNull ( anv_GSSMessage.of_GetItem ( "shipper id" ) , ll_Shipper_Id )

OpenWithParm ( w_shipper_manifest, ll_Shipper_Id , gnv_app.of_GetFrame ( ) )

//anv_GSSMessage.of_SetItem ( "shipper note", "" )


//
////	Read drag message.
//string	ls_Originator
//ls_Originator = IsNull ( anv_GSSMessage.of_GetItem ( "Originator" ), ls_Originator )
//
////	Perform appropriate measures according to the originator.
//datetime	ldt_DueDT
//integer	li_Return = -1, li_Counter, li_OrderCount, li_OrderDetailRows
//long	ll_Orders []
//long  ll_Ids []
//string	ls_ShipTo
//string	ls_SQLErrors, ls_DWErrors, ls_OrderDetailInfoSyntax, ls_OrderDetailInfoSelect
//
//n_ds	lnds_OrderDetailInfo
//
//choose case ls_Originator
//	case "Order Headers"
//		//	Each order will be scheduled separately.  Loop through each and process.
//		ll_Orders = IsNull ( anv_GSSMessage.of_GetItem ( "Orders" ), ll_Orders )
//		li_OrderCount = UpperBound ( ll_Orders )
//		for li_Counter = 1 to li_OrderCount
//			//	Get the shipto for this order.
//			select	destination
//			into	:ls_ShipTo
//			from	CSOrderHeaders
//			where	OrderNo = :ll_Orders [li_Counter] using SQLCA  ;
//			
//			//	Get the desired departure date for this order.
//			select	Min ( DueDT )
//			into	:ldt_DueDT
//			from	CSOrderDetails
//			where	OrderNo = :ll_Orders [li_Counter] and
//				CommittedQty < StdQty using SQLCA  ;
//			
//			//	Retrieve the order detail information for the selected order.
//			//	Using this select statement, build a datastore and retrieve data.
//			ls_OrderDetailInfoSelect = &
//				"select	CSOrderDetails.PartNumber, " +&
//				"	CSOrderDetails.DueDT, " +&
//				"	SuggestedQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
//				"	CSOrderDetails.Unit, " +&
//				"	ScheduledQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
//				"	CSOrderDetails.PackSize, " +&
//				"	convert ( integer, CSOrderDetails.OrderNo ), " +&
//				"	CSOrderDetails.CustomerPart, " +&
//				"	CSOrderDetails.Suffix, " +&
//				"	Shipper = -1, " +&
//				"	Note = convert ( varchar (255), '' ) " +&
//				"from	CSOrderDetails " +&
//				"where	CSOrderDetails.OrderNo = " + String (ll_Orders [li_Counter])
//			
//			lnds_OrderDetailInfo = create n_ds
//			ls_OrderDetailInfoSyntax = SQLCA.SyntaxFromSQL ( ls_OrderDetailInfoSelect, "", ls_SQLErrors )
//			if ls_SQLErrors > "" then
//				MessageBox ( monsys.msg_Title, "Application error (Unable to build DW Syntax for retrieving Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + "):  " + ls_SQLErrors, StopSign! )
//				return
//			end if
//			
//			//	Create datastore.
//			lnds_OrderDetailInfo.Create ( ls_OrderDetailInfoSyntax, ls_DWErrors )
//			if ls_DWErrors > "" then
//				MessageBox ( monsys.msg_Title, "Application error (Unable to Create DW for retrieving Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + "):  " + ls_DWErrors, StopSign! )
//				return
//			end if
//			
//			//	Retrieve details.
//			lnds_OrderDetailInfo.of_SetTransObject ( SQLCA )
//			li_OrderDetailRows = lnds_OrderDetailInfo.Retrieve ()
//			choose case li_OrderDetailRows
//				case is < 0
//					MessageBox ( monsys.msg_Title, "Application error (Unable to Retrieve Order Detail info abour OrderNo " + String (ll_Orders [li_Counter] ) + ")!", StopSign! )
//					return
//				case 0
//					if li_Counter = li_OrderCount then
//						MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Orders [li_Counter] ) + ")." )
//					else
//						if MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Orders [li_Counter] ) + ").  Do you wish to continue with the next order?", Question!, YesNo!, 2 ) = 2 then return
//					end if
//				case else
//					//	Open dialogue to schedule this shipper.
//					anv_GSSMessage.of_SetItem ( "shipper detail", lnds_OrderDetailInfo )
//					anv_GSSMessage.of_SetItem ( "shipper note", "" )
////					//PCV anv_GSSMessage.of_SetItem ( "shipper id", 0 ) new
////					anv_GSSMessage.of_SetItem ( "shipper id", 0 )  //old
//					anv_GSSMessage.of_SetItem ( "shipto", ls_ShipTo )
//					anv_GSSMessage.of_SetItem ( "DueDT", ldt_DueDT )
//					OpenWithParm ( w_shipper_manifest_new, anv_GSSMessage )
//					li_Return = Message.DoubleParm
//			end choose
//		next
//		
//	case "Order Details"
//		//	Each order will be scheduled separately.  Loop through each and process.
//		long ll_Distinct_Orders []
//		integer li_Counter_Target
//		long ll_OrderNo , ll_Total_Elements_Distinct_Orders 
//		boolean lb_Found
//		string ls_Ids
//		ll_Orders = IsNull ( anv_GSSMessage.of_GetItem ( "Orders" ), ll_Orders )
//		// With this code, ll_Distinct_Orders is an array, with the different OrderNo values
//		// e.g. : if ll_orders has this values:  [1,2,3,1,3,4,5,2,3,2]
//		// ll_Distinct_Orders will be: [1,2,3,4,5]
//		for li_Counter = 1 to UpperBound (ll_Orders)
//			ll_OrderNo	=	ll_Orders [ li_Counter ]
//			lb_Found		=	False
//			ll_Total_Elements_Distinct_Orders =	UpperBound(ll_Distinct_Orders)
//			li_Counter_Target = 1
//			do while  ( li_Counter_Target <= ll_Total_Elements_Distinct_Orders ) and ( lb_found = False )
//				if ll_OrderNo	=	ll_Distinct_Orders [ li_Counter_Target] then
//					lb_found	=	True
//				end if
//				li_Counter_Target ++
//			loop
//			if lb_found = False then
//				ll_Total_Elements_Distinct_Orders ++
//				ll_Distinct_Orders [ ll_Total_Elements_Distinct_Orders ] = ll_OrderNo
//			end if
//		next
//		
//		ll_Ids = IsNull ( anv_GSSMessage.of_GetItem ( "Ids" ), ll_Ids )
//		ls_Ids = '('
//		for li_Counter = 1 to UpperBound ( ll_Ids )
//			ls_Ids += string ( ll_Ids [ li_Counter ] ) + ","
//		next
//		ls_Ids = mid (ls_Ids,1,len(ls_Ids) - 1)
//		ls_Ids += ')'
//		//ls_Ids has all the values of the field Id, e.g. (1232,1122,4332,2345)
//		
//		//li_OrderCount = UpperBound ( ll_Orders )
//		li_OrderCount = UpperBound ( ll_Distinct_Orders )
//		for li_Counter = 1 to li_OrderCount
//			//	Get the shipto for this order.
//			select	destination
//			into	:ls_ShipTo
//			from	CSOrderHeaders
//			where	OrderNo = :ll_Distinct_Orders [li_Counter] using SQLCA  ;
//			
//			//	Get the desired departure date for this order.
//			select	DueDT
//			into	:ldt_DueDT
//			from	CSOrderDetails
//			where	OrderNo = :ll_Distinct_Orders [li_Counter] using SQLCA  ;
//			
//			//	Retrieve the order detail information for the selected order.
//			//	Using this select statement, build a datastore and retrieve data.
//			ls_OrderDetailInfoSelect = &
//				"select	CSOrderDetails.PartNumber, " +&
//				"	CSOrderDetails.DueDT, " +&
//				"	SuggestedQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
//				"	CSOrderDetails.Unit, " +&
//				"	ScheduledQty = ( CSOrderDetails.StdQty - CSOrderDetails.CommittedQty ) * CSOrderDetails.UnitConversion, " +&
//				"	CSOrderDetails.PackSize, " +&
//				"	convert ( integer, CSOrderDetails.OrderNo ), " +&
//				"	CSOrderDetails.CustomerPart, " +&
//				"	CSOrderDetails.Suffix, " +&
//				"	Shipper = -1, " +&
//				"	Note = convert ( varchar (255), '' ) " +&
//				"from	CSOrderDetails " +&
//				"where	CSOrderDetails.OrderNo = " + String (ll_Distinct_Orders [li_Counter] )+ " and CSOrderDetails.Id in " + ls_Ids
//			
//			lnds_OrderDetailInfo = create n_ds
//			ls_OrderDetailInfoSyntax = SQLCA.SyntaxFromSQL ( ls_OrderDetailInfoSelect, "", ls_SQLErrors )
//			if ls_SQLErrors > "" then
//				MessageBox ( monsys.msg_Title, "Application error (Unable to build DW Syntax for retrieving Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + "):  " + ls_SQLErrors, StopSign! )
//				return
//			end if
//			
//			//	Create datastore.
//			lnds_OrderDetailInfo.Create ( ls_OrderDetailInfoSyntax, ls_DWErrors )
//			if ls_DWErrors > "" then
//				MessageBox ( monsys.msg_Title, "Application error (Unable to Create DW for retrieving Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + "):  " + ls_DWErrors, StopSign! )
//				return
//			end if
//			
//			//	Retrieve details.
//			lnds_OrderDetailInfo.of_SetTransObject ( SQLCA )
//			li_OrderDetailRows = lnds_OrderDetailInfo.Retrieve ()
//			choose case li_OrderDetailRows
//				case is < 0
//					MessageBox ( monsys.msg_Title, "Application error (Unable to Retrieve Order Detail info abour OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ")!", StopSign! )
//					return
//				case 0
//					if li_Counter = li_OrderCount then
//						MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ")." )
//					else
//						if MessageBox ( monsys.msg_Title, "Warning, No Order Detail found for OrderNo " + String (ll_Distinct_Orders [li_Counter] ) + ").  Do you wish to continue with the next order?", Question!, YesNo!, 2 ) = 2 then return
//					end if
//				case else
//					//	Open dialogue to schedule this shipper.
//					anv_GSSMessage.of_SetItem ( "shipper detail", lnds_OrderDetailInfo )
//					anv_GSSMessage.of_SetItem ( "shipper note", "" )
//					//PCV anv_GSSMessage.of_SetItem ( "shipper id", 0 ) new
//					anv_GSSMessage.of_SetItem ( "shipper id", 0 ) //old
//					anv_GSSMessage.of_SetItem ( "shipto", ls_ShipTo )
//					anv_GSSMessage.of_SetItem ( "DueDT", ldt_DueDT )
//					OpenWithParm ( w_shipper_manifest_new, anv_GSSMessage )
//					li_Return = Message.DoubleParm
//			end choose
//		next
//end choose

end subroutine

on n_cst_globalshipsched.create
TriggerEvent( this, "constructor" )
end on

on n_cst_globalshipsched.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
//	This type:
is_Type = "Global Ship Schedule"
is_CSView = "u_cst_globalshipsched"
is_CSViewDW = "d_globalshipsched"

end event

