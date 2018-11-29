$PBExportHeader$w_standard_internal_rwf.srw
forward
global type w_standard_internal_rwf from Window
end type
end forward

global type w_standard_internal_rwf from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_standard_internal_rwf w_standard_internal_rwf

event open;////////////////////////////////////////////////////////////////////////////////////////
//	Standard internal label for raw/wip/fin
//	Arguments	: st_generic_structure getting 
//				serial#
//				no. of labels
//	Return value	: None
//	
//	Developers	: HGP	07/08/03 Reformatted the code and combined into one
//					 for all 3 types
//	
//	Local variables
//			ld_quantity	: To store object quantity
//			ldt_datetime	: To store object last date & time
//			ldt_date	: To store only the date from object datetime
//			ll_label	: To store the print open handle
//			ll_serial	: To store the serial number
//			ls_esc		: To store the escape character
//			ls_loc		: To store the location
//			ls_lot		: To store the object lot number
//			ls_unit		: To store the object unit of measure
//			ls_operator	: To store the operator associated with the object
//			ls_part		: To store the part number
//			ls_description	: To store the part description
//			ls_time		: To store the time as a string
//			ls_ptype	: To store the part type (R,W,F)
//			lst_parm	: To store the argument data structure
//			lt_time		: To store the time from the object datetime
////////////////////////////////////////////////////////////////////////////////////////
//	Declaration
Dec {0} ld_quantity	
Datetime ldt_datetime
Date	ldt_Date
long	ll_label
long	ll_serial
string	ls_esc         // escape code
string	ls_loc        // location
string	ls_lot        // material lot
string	ls_unit       // unit of measure
string	ls_operator   // operator
string	ls_part
string	ls_description
string	ls_numberoflabels
string	ls_time
string	ls_ptype
St_generic_structure lst_parm
time	lt_time

//	Initialization
lst_parm= message.powerobjectparm
ll_serial = long(lst_parm.value1)
ls_esc	= "~h1B"

//	Get data from object & part table
select	object.part,   
	object.lot,   
	object.location,   
	object.unit_measure,   
	object.operator,   
	object.quantity,   
	object.last_time,
	part.name,
	part.type
into	:ls_part,
	:ls_lot,   
	:ls_loc,   
	:ls_unit,   
	:ls_operator,   
	:ld_quantity,   
	:ldt_datetime,
	:ls_description,
	:ls_ptype
from	object
	join part on part.part = object.part
where	object.serial = :ll_serial;

//	Extract date & time portion
ldt_date = date(ldt_datetime)
lt_time = time(ldt_datetime)
ls_time = MidA(string(lt_time), 1, 5)

//	Determine the number of labels
if lst_parm.value11 = "" then
	ls_numberofLabels = "Q1"
else
	ls_numberofLabels = "Q" + lst_parm.value11
end if

//	Start printing
ll_label = printopen ( )
PrintSend ( ll_Label, ls_esc + "A" + ls_esc + "R" )
PrintSend ( ll_Label, ls_esc + "AR" )

//	Part Info
PrintSend ( ll_Label, ls_esc + "V083" + ls_esc + "H296" + ls_esc + "M" + "PART NO" )
PrintSend ( ll_Label, ls_esc + "V100" + ls_esc + "H300" + ls_esc + "$B,60,100,0" + ls_esc + "$=" + ls_part )
PrintSend ( ll_Label, ls_esc + "V200" + ls_esc + "H300" + ls_esc + "WL1" + ls_description )
PrintSend ( ll_Label, ls_esc + "V300" + ls_esc + "H296" + ls_esc + "M" + "LOT #" )
PrintSend ( ll_Label, ls_esc + "V325" + ls_esc + "H296" + ls_esc + "WL1" + ls_lot )
PrintSend ( ll_Label, ls_esc + "V400" + ls_esc + "H296" + ls_esc + "M" + "QUANTITY" )
PrintSend ( ll_Label, ls_esc + "V410" + ls_esc + "H296" + ls_esc + "$A,150,125,0" + ls_esc + "$=" + String(ld_quantity) )
PrintSend ( ll_Label, ls_esc + "V470" + ls_esc + "H905" + ls_esc + "WL1" + ls_unit )

//	Serial Info
PrintSend ( ll_Label, ls_esc + "V550" + ls_esc + "H296" + ls_esc + "M" + "SERIAL #" )
PrintSend ( ll_Label, ls_esc + "V566" + ls_esc + "H300" + ls_esc + "$A,110,100,0" + ls_esc + "$=" + String(ll_serial) )
PrintSend ( ll_Label, ls_esc + "V718" + ls_esc + "H296" + ls_esc + "B103095" + "*" + "S" + String ( ll_Serial ) + "*" )
if ls_ptype = 'R' then 
	PrintSend ( ll_Label, ls_esc + "V300" + ls_esc + "H1020" + ls_esc + "$A,125,100,0" + ls_esc + "$=" + "R A W" )
elseif ls_ptype = 'W' then 
	PrintSend ( ll_Label, ls_esc + "V300" + ls_esc + "H1020" + ls_esc + "$A,125,100,0" + ls_esc + "$=" + "W I P" )
elseif ls_ptype = 'F' then 
	PrintSend ( ll_Label, ls_esc + "V300" + ls_esc + "H1020" + ls_esc + "$A,125,100,0" + ls_esc + "$=" + "F I N" )	
end if 	
PrintSend ( ll_Label, ls_esc + "V570" + ls_esc + "H1020" + ls_esc + "WB1" + "LOCAT " + ls_loc)
PrintSend ( ll_Label, ls_esc + "V630" + ls_esc + "H1020" + ls_esc + "WB1" + "TIME  " + ls_time )
PrintSend ( ll_Label, ls_esc + "V690" + ls_esc + "H1020" + ls_esc + "WB1" + "DATE  " + String(ldt_date) )
PrintSend ( ll_Label, ls_esc + "V750" + ls_esc + "H1020" + ls_esc + "WB1" + "OPER  " + ls_operator )

//	Draw Lines
PrintSend ( ll_Label, ls_esc + "N" )
PrintSend ( ll_Label, ls_esc + "V425" + ls_esc + "H522" + ls_esc + "FW02H0339" )
PrintSend ( ll_Label, ls_esc + "V425" + ls_esc + "H291" + ls_esc + "FW02H0233" )
PrintSend ( ll_Label, ls_esc + "V050" + ls_esc + "H291" + ls_esc + "FW02V1112" )
PrintSend ( ll_Label, ls_esc + "V425" + ls_esc + "H520" + ls_esc + "FW02V725" )
PrintSend ( ll_Label, ls_esc + "V425" + ls_esc + "H425" + ls_esc + "FW02V125" )
PrintSend ( ll_Label, ls_esc + "V550" + ls_esc + "H425" + ls_esc + "FW02H95" )
PrintSend ( ll_Label, ls_esc + ls_numberofLabels )
PrintSend ( ll_Label, ls_esc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_standard_internal_rwf.create
end on

on w_standard_internal_rwf.destroy
end on

