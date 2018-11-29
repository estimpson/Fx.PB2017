$PBExportHeader$n_cst_inventorytrans.sru
forward
global type n_cst_inventorytrans from n_cst_fxtrans
end type
end forward

global type n_cst_inventorytrans from n_cst_fxtrans
end type
global n_cst_inventorytrans n_cst_inventorytrans

forward prototypes
public function integer validatelocation (string locationcode)
public function integer getboxlabelparms_forobject (long boxserial, ref string boxlabelformat)
end prototypes

public function integer validatelocation (string locationcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

select
	GetDate()
into
	:tranDT
from
	dbo.location l
where
	l.code = :locationCode using TransObject ;

sqlResult = TransObject.SQLCode

if	sqlResult = 100 then
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Invalid location: {" + String(IsNull(locationCode, "N/A")) + "}")
	return FAILURE
end if

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to validate location:  {" + String(sqlResult) + "," + String(IsNull(locationCode, "N/A")) + "} " + sqlError)
	return FAILURE
end if

//	Return success.
return SUCCESS

end function

public function integer getboxlabelparms_forobject (long boxserial, ref string boxlabelformat);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Read serial number and box label format.
select
	boxLabelFormat = case when p.type != 'N' then pi.label_format end
into
	:boxLabelFormat
from
	dbo.object o
	join dbo.part p
		on o.part = p.part
	join dbo.part_inventory pi
		on o.part = pi.part
where
	o.serial = :boxSerial  ;

if	SQLCA.SQLCode <> 0 then
	sqlResult = SQLCA.SQLCode
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	return FAILURE
end if

//	Return.
return SUCCESS

end function

on n_cst_inventorytrans.create
call super::create
end on

on n_cst_inventorytrans.destroy
call super::destroy
end on

