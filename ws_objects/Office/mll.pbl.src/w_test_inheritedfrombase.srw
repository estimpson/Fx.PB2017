$PBExportHeader$w_test_inheritedfrombase.srw
forward
global type w_test_inheritedfrombase from w_label_base
end type
end forward

global type w_test_inheritedfrombase from w_label_base
end type
global w_test_inheritedfrombase w_test_inheritedfrombase

on w_test_inheritedfrombase.create
call super::create
end on

on w_test_inheritedfrombase.destroy
call super::destroy
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
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
string	ls_numberoflabels, ls_name1, ls_name2, ls_name3, ls_esc
long	ll_label

//	Initialization
ls_esc	= "~h1B"
ls_numberoflabels = "Q1"

//	Determine the number of labels to be printed
If is_nooflabels > "" Then ls_numberoflabels = "Q" + is_nooflabels

//	Parse name/description into 3 variables
ls_Name1 = MidA ( is_name, 1, 25 )
ls_Name2 = MidA ( is_name, 26, 25 )
ls_Name3 = MidA ( is_name, 52, 25 )

//	Start Printing
ll_Label = PrintOpen ( )
PrintSend ( ll_Label, ls_esc + "A" + ls_esc + "R" )
PrintSend ( ll_Label, ls_esc + "AR" )
SetPointer(HourGlass!)

//	Part Info
PrintSend ( ll_Label, ls_esc + "V065" + ls_esc + "H270" + ls_esc + "M" + "PART NO." )
PrintSend ( ll_Label, ls_esc + "V090" + ls_esc + "H270" + ls_esc + "M" + "(P)" )
if LenA(is_customerpart) < 15 then
   PrintSend ( ll_Label, ls_esc + "V025" + ls_esc + "H400" + ls_esc + "$B,100,160,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V166" + ls_esc + "H305" + ls_esc + "B103101" + "*" + "P" + is_customerpart + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V025" + ls_esc + "H400" + ls_esc + "$B,60,160,0"  + ls_esc + "$=" + is_customerpart )
   PrintSend ( ll_Label, ls_esc + "V172" + ls_esc + "H305" + ls_esc + "B102101" + "*" + "P" + is_customerpart + "*"  )
end if

//	Line Feed Code Info
//PrintSend ( ll_Label, ls_esc + "V065" + ls_esc + "H1100" + ls_esc + "L0101" + ls_esc + "M" + "LINE FEED " )
//PrintSend ( ll_Label, ls_esc + "V090" + ls_esc + "H1100" + ls_esc + "L0204" + ls_esc + "WL1" + szLine )

//	Quantity Info
PrintSend ( ll_Label, ls_esc + "V280" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "QUANTITY" )
PrintSend ( ll_Label, ls_esc + "V305" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(Q)" )
PrintSend ( ll_Label, ls_esc + "V249" + ls_esc + "H400" + ls_esc + "$A,100,160,0" + ls_esc + "$=" + String(id_quantity) )
PrintSend ( ll_Label, ls_esc + "V385" + ls_esc + "H305" + ls_esc + "B103101" + "*" +"Q" + String(id_quantity) + "*" )
if is_unit <> "PC" and is_unit <> "EA" and is_unit <> "UN" then &
	PrintSend ( ll_Label, ls_esc + "V335" + ls_esc + "H720" + ls_esc + "L0101" + ls_esc + "WL1" + is_unit )

//	Customer PO
PrintSend ( ll_Label, ls_esc + "V280" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "PURCHASE ORDER NO." )
PrintSend ( ll_Label, ls_esc + "V305" + ls_esc + "H805" + ls_esc + "L0101" + ls_esc + "M" + "(K)" )
PrintSend ( ll_Label, ls_esc + "V332" + ls_esc + "H960" + ls_esc + "L0101" + ls_esc + "WL1" + is_customerpo )
if LenA(is_customerpo) < 9 then
	PrintSend ( ll_Label, ls_esc + "V385" + ls_esc + "H850" + ls_esc + "B103101" + "*" + "K" + is_customerpo + "*" )
else
	PrintSend ( ll_Label, ls_esc + "V385" + ls_esc + "H850" + ls_esc + "B102101" + "*" + "K" + is_customerpo + "*" )
end if

//	Supplier Info
PrintSend ( ll_Label, ls_esc + "V495" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "SUPPLIER" )
PrintSend ( ll_Label, ls_esc + "V520" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(V)" )
PrintSend ( ll_Label, ls_esc + "V495" + ls_esc + "H400" + ls_esc + "L0101" + ls_esc + "WL1" + is_suppliercode )
if LenA(is_suppliercode) < 9 then
   PrintSend ( ll_Label, ls_esc + "V543" + ls_esc + "H305" + ls_esc + "B103101" + "*" + "V" + is_suppliercode + "*"  )
else
   PrintSend ( ll_Label, ls_esc + "V543" + ls_esc + "H305" + ls_esc + "B102101" + "*" + "V" + is_suppliercode + "*"  )
end if

//	Serial Number Info
PrintSend ( ll_Label, ls_esc + "V655" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "SERIAL " )
PrintSend ( ll_Label, ls_esc + "V680" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + "(S)" )
PrintSend ( ll_Label, ls_esc + "V655" + ls_esc + "H400" + ls_esc + "L0101" + ls_esc + "WL1" + String(il_serial))
PrintSend ( ll_Label, ls_esc + "V703" + ls_esc + "H305" + ls_esc + "B103101" + "*" + "S" + String(il_serial) + "*")

//	Engineering Change
PrintSend ( ll_Label, ls_esc + "V495" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "ENG. LEVEL" )
PrintSend ( ll_Label, ls_esc + "V520" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "(T)" )
PrintSend ( ll_Label, ls_esc + "V495" + ls_esc + "H1105" + ls_esc + "L0101" + ls_esc + "WL1" + is_ecnlevel )
PrintSend ( ll_Label, ls_esc + "V543" + ls_esc + "H975" + ls_esc + "B103101" + "*" + "T" + is_ecnlevel + "*")

//	Manufacturing Date 
PrintSend ( ll_Label, ls_esc + "V668" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "MFG. DATE" )
PrintSend ( ll_Label, ls_esc + "V660" + ls_esc + "H1105" + ls_esc + "L0101" + ls_esc + "WB1" + String(idt_objdate, "mm/dd/yy") )

//	Description
PrintSend ( ll_Label, ls_esc + "V708" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "DESCRIPTION" )
PrintSend ( ll_Label, ls_esc + "V700" + ls_esc + "H1105" + ls_esc + "L0101" + ls_esc + "WB1" + ls_name1 )

//	Internal Part Info
PrintSend ( ll_Label, ls_esc + "V748" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "INT PART NO" )
PrintSend ( ll_Label, ls_esc + "V740" + ls_esc + "H1105" + ls_esc + "L0101" + ls_esc + "WB1" + is_part )

//	Company Info
PrintSend ( ll_Label, ls_esc + "V810" + ls_esc + "H270" + ls_esc + "L0101" + ls_esc + "M" + is_company + "   " + is_caddress3 )

//	Customer
PrintSend ( ll_Label, ls_esc + "V788" + ls_esc + "H930" + ls_esc + "L0101" + ls_esc + "M" + "CUSTOMER")
PrintSend ( ll_Label, ls_esc + "V780" + ls_esc + "H1105" + ls_esc + "L0101" + ls_esc + "WB1" + is_cname)

////  Additional Code for Future Modifications
////PrintSend ( ll_Label, ls_esc + "V260" + ls_esc + "H1150" + ls_esc + "M" + "CHANGE" )
////PrintSend ( ll_Label, ls_esc + "V280" + ls_esc + "H1150" + ls_esc + "M" + "LETTER" )
////PrintSend ( ll_Label, ls_esc + "V250" + ls_esc + "H900" + ls_esc + "$A,50,50,0" + ls_esc + "$=" + szTemp )
////PrintSend ( ll_Label, ls_esc + "V425" + ls_esc + "H900" + ls_esc + "$A,40,40,0" + ls_esc + "$=" + "E&E : " + szPart)
////PrintSend ( ll_Label, ls_esc + "V479" + ls_esc + "H1070" + ls_esc + "M" + "MATERIAL LOT : " )
////PrintSend ( ll_Label, ls_esc + "V510" + ls_esc + "H1070" + ls_esc + "WB1" + szLot )
////PrintSend ( ll_Label, ls_esc + "V555" + ls_esc + "H1070" + ls_esc + "M" + "FINAL LOT : " )
////PrintSend ( ll_Label, ls_esc + "V585" + ls_esc + "H1070" + ls_esc + "WB1" + szFinal )
////PrintSend ( ll_Label, ls_esc + "V340" + ls_esc + "H900" + ls_esc + "$A,95,95,0" + ls_esc + "$=" + "LOC: " + szLine )
////PrintSend ( ll_Label, ls_esc + "V350" + ls_esc + "H1135" + ls_esc + "WB1" + ls_esc + szENG )

//  Draw Lines
PrintSend ( ll_Label, ls_esc + "N" )
PrintSend ( ll_Label, ls_esc + "V632" + ls_esc + "H273" + ls_esc + "FW02H0217" )
PrintSend ( ll_Label, ls_esc + "V503" + ls_esc + "H490" + ls_esc + "FW02H0320" )
//PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H565" + ls_esc + "FW02V0380" ) 
//PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H735" + ls_esc + "FW02V0380" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H273" + ls_esc + "FW02V1127" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H490" + ls_esc + "FW02V1127" )
PrintSend ( ll_Label, ls_esc + "V038" + ls_esc + "H648" + ls_esc + "FW02V1127" )

PrintSend ( ll_Label, ls_esc + ls_numberoflabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

