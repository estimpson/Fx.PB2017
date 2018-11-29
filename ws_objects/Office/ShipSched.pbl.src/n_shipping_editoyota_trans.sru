﻿$PBExportHeader$n_shipping_editoyota_trans.sru
forward
global type n_shipping_editoyota_trans from n_cst_fxtrans
end type
end forward

global type n_shipping_editoyota_trans from n_cst_fxtrans
end type
global n_shipping_editoyota_trans n_shipping_editoyota_trans

type variables

public constant long OBJECTSTATUS_IGNORE = -2
public constant long OBJECTSTATUS_LOST = -1
public constant long OBJECTSTATUS_UNKNOWN = 0
public constant long OBJECTSTATUS_FOUND = 1
public constant long OBJECTSTATUS_FOUNDADJ = 2
public constant long OBJECTSTATUS_FOUNDREL = 3
public constant long OBJECTSTATUS_FOUNDADJREL = 4
public constant long OBJECTSTATUS_RECOVER = 5

end variables

forward prototypes
public function integer savenewshipper (ref long newshipperid, string lastmanifestnumber, datetime pickupdt, string plant, string fob, string carrier, string transmode, string freighttype, decimal freightcharge, string aetcnumber, string dockcode, string shippernotes)
public function integer deletemanifestdetailspart (string customerpart, long pickupid, string lastmanifestnumber)
public function integer restoremanifestdetailspart (string customerpart, long pickupid, string manifestnumber)
end prototypes

public function integer savenewshipper (ref long newshipperid, string lastmanifestnumber, datetime pickupdt, string plant, string fob, string carrier, string transmode, string freighttype, decimal freightcharge, string aetcnumber, string dockcode, string shippernotes);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create new shipper.
declare NewShipper procedure for EDIToyota.usp_SaveNewShipper
	@LastManifestNumber = :lastManifestNumber
,	@FOB = :fob
,	@Carrier = :carrier
,	@TransMode = :transMode
,	@FreightType = :freightType
,	@FreightCharge = :freightCharge
,	@AETCNumber = :aetcNumber
,	@DockCode = :dockCode
,	@ShipperNotes = :shipperNotes
,	@NewShipperID = :newShipperID output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewShipper  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewShipper
into
	:newShipperID
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewShipper   ;

//	Return.
return SUCCESS

end function

public function integer deletemanifestdetailspart (string customerpart, long pickupid, string lastmanifestnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to delete manifest details part.
declare DeleteManifestDetailsPart procedure for EDIToyota.usp_DeleteManifestDetailsPart
	@CustomerPart = :customerPart
,	@PickupID = :pickupID
,	@LastManifestNumber = :lastManifestNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeleteManifestDetailsPart  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete manifest details part:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeleteManifestDetailsPart
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to delete manifest details part:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeleteManifestDetailsPart   ;

//	Return.
return SUCCESS

end function

public function integer restoremanifestdetailspart (string customerpart, long pickupid, string manifestnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to restore manifest details part.
declare RestoreManifestDetailsPart procedure for EDIToyota.usp_RestoreManifestDetailsPart
	@CustomerPart = :customerPart
,	@PickupID = :pickupID
,	@ManifestNumber = :manifestNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RestoreManifestDetailsPart  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to restore manifest details part:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RestoreManifestDetailsPart
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to restore manifest details part:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close RestoreManifestDetailsPart   ;

//	Return.
return SUCCESS

end function

on n_shipping_editoyota_trans.create
call super::create
end on

on n_shipping_editoyota_trans.destroy
call super::destroy
end on
