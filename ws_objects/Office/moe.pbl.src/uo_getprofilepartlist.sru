$PBExportHeader$uo_getprofilepartlist.sru
$PBExportComments$moe
forward
global type uo_getprofilepartlist from datastore
end type
end forward

global type uo_getprofilepartlist from datastore
string DataObject="d_customer_getprofile_list"
end type
global uo_getprofilepartlist uo_getprofilepartlist

type variables
long	il_weekno

end variables

forward prototypes
public function long retrieve (string as_customer, long al_order, string as_sort)
end prototypes

public function long retrieve (string as_customer, long al_order, string as_sort);object.datawindow.table.select = String ( object.datawindow.table.select ) + " order by " + as_sort

return Retrieve ( as_customer, al_order )


end function

event retrieverow;SetItem ( row, "sequence", row )
SetItem ( row, "week_no", il_weekno )
SetItem ( row, "row_id", row )
//SetItem ( row, "calc_type", f_get_calc_type ( ) )

end event

on uo_getprofilepartlist.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_getprofilepartlist.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetTransObject ( sqlca )
il_weekno = f_get_week_no ( Today ( ) )
end event

