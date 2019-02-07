$PBExportHeader$u_tr_ordervalidation.sru
forward
global type u_tr_ordervalidation from u_tr_base
end type
end forward

global type u_tr_ordervalidation from u_tr_base
end type
global u_tr_ordervalidation u_tr_ordervalidation

type variables

end variables

forward prototypes
public function integer of_transferinsertedrelease (decimal order_no)
public function integer of_createinsertedrelease (decimal order_no, datetime due_date, decimal quantity, string releasetype, string note, string forecasttype)
public function integer of_removeinsertedrelease (decimal order_no, integer sequence)
public function integer of_updateinsertedrelease (decimal order_no, integer sequence, decimal quantity)
public function long of_commit ()
public function long of_rollback ()
end prototypes

public function integer of_transferinsertedrelease (decimal order_no);//  Declarations.
declare TransferInsertedRelease procedure for
msp_transferinsertedrelease :order_no  ;

//  Execute.
sqlca.autocommit = true
execute TransferInsertedRelease  ;
sqlca.autocommit = false

//  Return.
Return SQLCA.SQLCode
end function

public function integer of_createinsertedrelease (decimal order_no, datetime due_date, decimal quantity, string releasetype, string note, string forecasttype);
//  Declarations.
declare CreateInsertedRelease procedure for
msp_createinsertedrelease :order_no, :due_date, :quantity, :releasetype, :note, :forecasttype  ;

//  Execute.
sqlca.autocommit = true
execute CreateInsertedRelease  ;
sqlca.autocommit = false
//  Return.
Return SQLCA.SQLCode
end function

public function integer of_removeinsertedrelease (decimal order_no, integer sequence);
//  Declarations.
declare RemoveInsertedRelease procedure for
msp_removeinsertedrelease :order_no, :sequence  ;

//  Execute.
sqlca.autocommit = true
execute RemoveInsertedRelease  ;
sqlca.autocommit = false
//  Return.
Return SQLCA.SQLCode
end function

public function integer of_updateinsertedrelease (decimal order_no, integer sequence, decimal quantity);
//  Declarations.
declare UpdateInsertedRelease procedure for
msp_updateinsertedrelease :order_no, :sequence, :quantity  ;

//  Execute.
sqlca.autocommit = true
execute UpdateInsertedRelease  ;
sqlca.autocommit = false
//  Return.
Return SQLCA.SQLCode
end function

public function long of_commit ();
//	Commit.
commit  ;

//	Return.
return SQLCA.SQLCode
end function

public function long of_rollback ();
//	Rollback.
rollback  ;

//	Return.
return SQLCA.SQLCode
end function

on u_tr_ordervalidation.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on u_tr_ordervalidation.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

event destructor;DISCONNECT  ;
end event

