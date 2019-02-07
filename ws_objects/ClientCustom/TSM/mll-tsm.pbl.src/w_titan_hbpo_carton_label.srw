$PBExportHeader$w_titan_hbpo_carton_label.srw
forward
global type w_titan_hbpo_carton_label from w_label_base
end type
end forward

global type w_titan_hbpo_carton_label from w_label_base
end type
global w_titan_hbpo_carton_label w_titan_hbpo_carton_label

on w_titan_hbpo_carton_label.create
call super::create
end on

on w_titan_hbpo_carton_label.destroy
call super::destroy
end on

event ue_open;call super::ue_open;/////////////////////////////////////////////////////////////////////////////////////////
//
//	window		: w_test_inheritedfrombase
//	
//	Arguments	: none, but ancestor has the st_generic_structure
//	
//	Return value	: none
//
//	Development	: HGP	7/8/03	Re-formatted and cleaned up
//
//	Variables used	: Instance variables
//				idt_objdate		: To store date of object datetime
//				idt_objdatetime		: To store object datetime
//				idt_effdate		: To store effective date 
//				id_quantity		: To store object quantity
//				il_serial		: To store serial number	
//				il_shipper		: To store shipper number
//				il_suffix		: To store suffix number
//				il_order		: To store order number	
//				is_part			: To store object part number
//				is_lot			: To store object lot number
//				is_location		: To store object location	
//				is_unit			: To store object unit of measure
//				is_origin		: To store object origin
//				is_custom4		: To store object custom4 data
//				is_custom5		: To store object custom5 data
//				is_name			: To store part name
//				is_company		: To store company name
//				is_caddress1		: To store company address line 1	
//				is_caddress2		: To store company address line 2
//				is_caddress3		: To store company address line 3	
//				is_ecnlevel		: To store part ecn level
//				is_destination		: To store destination 
//				is_ohdestination	: To store order header destination
//				is_customerpart		: To store customer part
//				is_sdcustomerpart	: To store shipper detail customer part
//				is_release		: To store release number
//				is_partcrossref		: To store part cross reference
//				is_customerpo		: To store customer po number
//				is_cname		: To store customer name 	
//				is_dname		: To store destination name	
//				is_daddress1		: To store destination address line 1
//				is_daddress2		: To store destination address line 2
//				is_daddress3		: To store destination address line 3
//				is_suppliercode		: To store supplier code 
//				is_nooflabels		: To store number of labels
//				is_type			: To store object type
//				is_kanban		: To store kanban number for the object
//				ltt_objtime		: To store the time of object datetime
//	
//			: Local variables
//				ls_numberoflabels	: To store the no. of labels
//				ls_name1,ls_name2,ls_name3: To store parsed part name
//				ls_esc			: To store escape character
//				ll_label		: To store the print handle
//
//////////////////////////////////////////////////////////////////////////////////////////
//	Declarations
string	ls_numberoflabels, ls_name1, ls_name2, ls_name3, ls_esc, ls_serial, ls_sl1
long	ll_label

//	Initialization
ls_esc	= "~h1B"
ls_numberoflabels = "Q1"

//	Determine the number of labels to be printed
If is_nooflabels > "" Then ls_numberoflabels = "Q" + is_nooflabels

//	Parse name/description into 3 variables
ls_Name1 = Mid ( is_name, 1, 25 )
ls_Name2 = Mid ( is_name, 26, 25 )
ls_Name3 = Mid ( is_name, 52, 25 )

//	Start Printing
ll_Label = PrintOpen ( )
PrintSend ( ll_Label, ls_esc + "A" + ls_esc + "R" )
PrintSend ( ll_Label, ls_esc + "AR" )
SetPointer(HourGlass!)

//	Part Info
PrintSend ( ll_Label, ls_esc + "V076" + ls_esc + "H270" + ls_esc + "M" + "PART" )
PrintSend ( ll_Label, ls_esc + "V100" + ls_esc + "H270" + ls_esc + "M" + "(P)" )
if len(is_customerpart) < 15 then
   PrintSend ( ll_Label, ls_esc + "V035" + ls_esc + "H400" + ls_esc + "$B,100,130,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V145" + ls_esc + "H305" + ls_esc + "B103101" + "*" + "P" + is_customerpart + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V035" + ls_esc + "H400" + ls_esc + "$B,60,130,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V145" + ls_esc + "H305" + ls_esc + "B102101" + "*" + "P" + is_customerpart + "*"  )
end if

//	Quantity Info
PrintSend ( ll_Label, ls_esc + "V265" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "QUANTITY" )
PrintSend ( ll_Label, ls_esc + "V285" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(Q)" )
PrintSend ( ll_Label, ls_esc + "V285" + ls_esc + "H400" + ls_esc + "L0101" + ls_esc + "WL1"  + String(id_quantity) )
PrintSend ( ll_Label, ls_esc + "V330" + ls_esc + "H305" + ls_esc + "B103101" + "*" +"Q" + String(id_quantity) + "*" )
if is_unit <> "PC" and is_unit <> "EA" and is_unit <> "UN" then &
	PrintSend ( ll_Label, ls_esc + "V245" + ls_esc + "H720" + ls_esc + "L0101" + ls_esc + "WL1" + is_unit )

//	Customer PO
PrintSend ( ll_Label, ls_esc + "V265" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "DESCRIPTION" )
PrintSend ( ll_Label, ls_esc + "V290" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + ls_name1 )
if len(is_name) > 25 then
	PrintSend ( ll_Label, ls_esc + "V320" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + ls_name2 )	
end if

//	Destination
PrintSend ( ll_Label, ls_esc + "V355" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "TO" )
PrintSend ( ll_Label, ls_esc + "V390" + ls_esc + "H820" + ls_esc + "L0101" + ls_esc + "M" + "HBPO " + is_daddress3 )

//	Supplier Info
PrintSend ( ll_Label, ls_esc + "V455" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, ls_esc + "V480" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(V)" )
PrintSend ( ll_Label, ls_esc + "V475" + ls_esc + "H410" + ls_esc + "L0101" + ls_esc + "WL1" + is_suppliercode )
if len(is_suppliercode) < 9 then
   PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H305" + ls_esc + "B103101" + "*" + "V" + is_suppliercode + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V525" + ls_esc + "H305" + ls_esc + "B102101" + "*" + "V" + is_suppliercode + "*"  )
end if

//	Ship from Info
PrintSend ( ll_Label, ls_esc + "V455" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "SHIP FROM" )
PrintSend ( ll_Label, ls_esc + "V485" + ls_esc + "H945" + ls_esc + "L0101" + ls_esc + "M" + is_company)
PrintSend ( ll_Label, ls_esc + "V515" + ls_esc + "H945" + ls_esc + "L0101" + ls_esc + "M" + is_caddress1)
PrintSend ( ll_Label, ls_esc + "V545" + ls_esc + "H945" + ls_esc + "L0101" + ls_esc + "M" + is_caddress2)
PrintSend ( ll_Label, ls_esc + "V585" + ls_esc + "H945" + ls_esc + "L0101" + ls_esc + "M" + is_caddress3)

ls_serial = "3STTD"+trim(string(il_serial))
//	Serial Number Info
PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL " )
PrintSend ( ll_Label, ls_esc + "V665" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(3S)" )
PrintSend ( ll_Label, ls_esc + "V640" + ls_esc + "H415" + ls_esc + "L0101" + ls_esc + "WL1" + "TTD"+trim(string(il_serial)))
PrintSend ( ll_Label, ls_esc + "V695" + ls_esc + "H305" + ls_esc + "B103101" + "*" + ls_serial + "*")

PrintSend ( ll_Label, ls_esc + "V760" + ls_esc + "H1250" + ls_esc + "L0101" + ls_esc + "M" + string(today()))

//  Draw Lines
PrintSend ( ll_Label, ls_esc + "N" )
PrintSend ( ll_Label, ls_esc + "V632" + ls_esc + "H260" + ls_esc + "FW02H0190" )
PrintSend ( ll_Label, ls_esc + "V503" + ls_esc + "H447" + ls_esc + "FW02H0180" )
PrintSend ( ll_Label, ls_esc + "V370" + ls_esc + "H630" + ls_esc + "FW02H0190" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H260" + ls_esc + "FW02V1127" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H447" + ls_esc + "FW02V1127" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H628" + ls_esc + "FW02V1127" )

PrintSend ( ll_Label, ls_esc + ls_numberoflabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

