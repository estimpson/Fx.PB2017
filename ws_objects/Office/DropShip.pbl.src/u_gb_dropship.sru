$PBExportHeader$u_gb_dropship.sru
forward
global type u_gb_dropship from u_gb
end type
end forward

global type u_gb_dropship from u_gb
int Width=859
int Height=476
end type
global u_gb_dropship u_gb_dropship

type variables

//	Public:
constant integer	FAILURE = -1
constant integer	SUCCESS = 1

constant integer	ORDER = 1
constant integer	PO = 2
constant integer	SHIPPER = 3
constant integer	SHIPPERDETAIL = 4

integer	ii_GB = ORDER

string	is_DefaultText
string	is_Message [ 4 ] = { "Drag to PO or Shipper", "Drop to delete PO", "Drop to delete Shipper", "Drop to delete Shipper Line Item" }

end variables

forward prototypes
public function integer of_dragging (boolean ab_Dragging, integer ai_Source)
end prototypes

public function integer of_dragging (boolean ab_Dragging, integer ai_Source);
//	Declarations.
integer li_ReturnValue = SUCCESS

//	Restore defaults if not dragging.
if not ab_Dragging then
	text = is_DefaultText
	weight = 400
else
	text = is_Message [ ai_Source ]
	if ii_GB = ai_Source then
		weight = 400
	else
		weight = 700
	end if
end if

//	Return.
return li_ReturnValue

end function

event constructor;call super::constructor;
//	Setup messages.  Example:
//ii_GB = ORDER
//is_DefaultText = "Order Detail"
//is_Message = { "Drag to PO or Shipper", "Drop to delete PO", "Drop to delete Shipper", "Drop to delete Shipper Line Item" }

end event

