$PBExportHeader$n_cst_tr_gss.sru
forward
global type n_cst_tr_gss from nonvisualobject
end type
end forward

global type n_cst_tr_gss from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_getorderinfo (long al_orderno, long al_sequence, string as_part, long al_suffix, ref datetime adt_due, ref string as_um, ref double adbl_standardpack, ref string as_customerpart, ref string as_note)
end prototypes

public function integer of_getorderinfo (long al_orderno, long al_sequence, string as_part, long al_suffix, ref datetime adt_due, ref string as_um, ref double adbl_standardpack, ref string as_customerpart, ref string as_note);
//	Read data from order detail.
execute immediate 'set rowcount 1'  ;

if	SQLCA.SQLCode <> 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to set rowcount.  " + SQLCA.SQLErrText)
	rollback  ;
	return -1// FAILURE
end if

select	DueDT = order_detail.due_date,
	UM = order_detail.unit,
	StdPackQty = part_packaging.quantity,
	CustomerPart = order_detail.customer_part,
	PartNote = Coalesce(order_detail.notes, order_header.notes)
into	:adt_Due,
	:as_UM,
	:adbl_StandardPack,
	:as_CustomerPart,
	:as_Note
from	order_detail
	join order_header on order_header.order_no = order_detail.order_no
	left join part_packaging on order_detail.part_number = part_packaging.part and
		part_packaging.code = Coalesce(order_detail.packaging_type, order_header.package_type)
where	order_detail.order_no = :al_OrderNo and
	order_detail.part_number = :as_Part and
	Coalesce(order_detail.suffix, -1) = Coalesce(:al_Suffix, -1) and
	Coalesce(order_detail.committed_qty, 0) < order_detail.std_qty
order by
	order_detail.due_date,
	order_detail.sequence  ;

if	SQLCA.SQLCode <> 0 then
	//MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to read release information.  " + SQLCA.SQLErrText)
	rollback  ;
	execute immediate 'set rowcount 0'  ;
	return -1// FAILURE
end if

execute immediate 'set rowcount 0'  ;

if	SQLCA.SQLCode <> 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to reset rowcount.  " + SQLCA.SQLErrText)
	rollback  ;
	return -1// FAILURE
end if

//	Return.
return 0

end function

on n_cst_tr_gss.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_tr_gss.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

