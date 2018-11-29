$PBExportHeader$bll_gss.sru
forward
global type bll_gss from n_base
end type
end forward

global type bll_gss from n_base autoinstantiate
end type

type variables
end variables

forward prototypes
public function integer newshipperheader (bel_shipperheader _shipperheader)
public function integer findshipperdetail (long shipperid, string part, long suffix)
public function integer createshipperdetail (long shipperid, long orderno, string part, long suffix, string note)
public function integer updateshipperrequirements (long shipperid, string part, long suffix, decimal quantity)
public function integer reconcileshipper (long shipperid)
end prototypes

public function integer newshipperheader (bel_shipperheader _shipperheader);
//	Create a new ShipperHeader db.
dal_ShipperHeaderDB shipperHeaderDB
shipperHeaderDB = create dal_ShipperHeaderDB
shipperHeaderDB.SetTransObject(SQLCA)

//	Return.
return shipperHeaderDB.NewShipper(_shipperHeader)

end function

public function integer findshipperdetail (long shipperid, string part, long suffix);
int result

select
	1
into
	:result
from
	dbo.shipper_detail
where
	shipper = :shipperID
	and part_original = :part
	and coalesce(suffix, -1) = coalesce(:suffix, -1)  ;

if	result = 1 then
	return 0
else
	return -1
end if

end function

public function integer createshipperdetail (long shipperid, long orderno, string part, long suffix, string note);
//	Declare local variables.
integer	li_ReturnValue

long	ll_NewShipperDetailRows

DataStore	lds_ShipperDetailNew

//	Check for valid data.
SetNull ( li_ReturnValue )
if not IsNull (shipperId ) and not IsNull (part ) then

	//	Build data for shipper detail.
	lds_ShipperDetailNew = create DataStore
	lds_ShipperDetailNew.DataObject = "d_shipper_detail_new"
	lds_ShipperDetailNew.SetTransObject ( SQLCA )
	ll_NewShipperDetailRows = lds_ShipperDetailNew.Retrieve (orderNo, shipperId, part, IsNull (suffix, 0))
	
	//	If data build succeeded, create shipper detail using overloaded function.
	if ll_NewShipperDetailRows = 1 then

			//	Set the note.
			lds_ShipperDetailNew.object.note [1] = note
			
			//	Create shipper detail.
			DataStore	lds_ShipperDetail
			
			// make sure datastore sent is valid
			SetNull ( li_returnvalue )
			if IsValid (lds_ShipperDetailNew) then
				if lds_ShipperDetailNew.RowCount ( ) = 0 then
					destroy lds_ShipperDetailNew
					li_returnvalue = 100
				else
					//	create updateable datastore to create new shipper detail
					lds_ShipperDetail = create DataStore
					lds_ShipperDetail.DataObject = "d_shipper_detail"
					lds_ShipperDetail.SetTransObject ( SQLCA )
					//	copy the shipper information to the updateable datastore and update if successful
					if lds_ShipperDetailNew.RowsCopy ( 1, 1, Primary!, lds_ShipperDetail, 1, Primary! ) = 1 then
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
	else
		li_ReturnValue = 100
	end if
end if
destroy lds_ShipperDetailNew

//  Return.
return li_ReturnValue


end function

public function integer updateshipperrequirements (long shipperid, string part, long suffix, decimal quantity);
//  declare local variables
integer	li_ReturnValue
 
//	check for valid data
SetNull ( li_returnvalue )

if IsNull ( shipperID ) then
	Return li_returnvalue
end if

//  execute
UPDATE	shipper_detail
   SET	qty_required = qty_required + :quantity,
   		qty_original = qty_original + :quantity
 WHERE	shipper = :shipperID AND
 		part_original = :part AND
		IsNull ( suffix, 0 ) = IsNull ( :suffix, 0 )  ;

li_ReturnValue = SQLCA.SQLCode

//  return
return li_ReturnValue
end function

public function integer reconcileshipper (long shipperid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare ReconcileShipper procedure for dbo.usp_ShippingDock_ReconcileShipper
	@ShipperID = :shipperID
,	@TranDT = :tranDT output
,	@Result = :procResult output  using SQLCA  ;

execute ReconcileShipper  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	rollback using SQLCA  ;
	MessageBox(monsys.msg_Title, "Failed on execute, unable to reconcile shipper (" + String(shipperID) + "):  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	ReconcileShipper
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	rollback using SQLCA  ;
	MessageBox(monsys.msg_Title, "Failed on result, unable to reconcile shipper (" + String(shipperID) + "):  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ReconcileShipper  ;

//	Return.
return 0

end function

on bll_gss.create
call super::create
end on

on bll_gss.destroy
call super::destroy
end on

