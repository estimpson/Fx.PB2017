HA$PBExportHeader$n_shipping_expedite_trans.sru
forward
global type n_shipping_expedite_trans from n_cst_fxtrans
end type
end forward

global type n_shipping_expedite_trans from n_cst_fxtrans
end type
global n_shipping_expedite_trans n_shipping_expedite_trans

forward prototypes
public function integer isexpeditetransmode (string transmode, ref boolean isexpedite)
public function integer isaetcrequired (string destination, ref boolean isaetcrequired)
end prototypes

public function integer isexpeditetransmode (string transmode, ref boolean isexpedite);
int isExpediteValue

select
	tm.IsExpedite
into
	:isExpediteValue
from
	dbo.trans_mode tm
where
	tm.code = :transMode  ;

isExpedite = (isExpediteValue = 1)
return SUCCESS

end function

public function integer isaetcrequired (string destination, ref boolean isaetcrequired);
int isAETCRequiredValue

select
	ds.IsAETCRequired
into
	:isAETCRequiredValue
from
	dbo.destination_shipping ds
where
	ds.destination = :destination;

isAETCRequired = (isAETCRequiredValue = 1)
return SUCCESS

end function

on n_shipping_expedite_trans.create
call super::create
end on

on n_shipping_expedite_trans.destroy
call super::destroy
end on

