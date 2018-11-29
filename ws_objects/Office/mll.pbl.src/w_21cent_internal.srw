$PBExportHeader$w_21cent_internal.srw
forward
global type w_21cent_internal from window
end type
end forward

global type w_21cent_internal from window
integer width = 1801
integer height = 1220
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_21cent_internal w_21cent_internal

forward prototypes
public subroutine printobjectlabel (long serial, integer labellocation, long numberoflabels, string labelname)
end prototypes

public subroutine printobjectlabel (long serial, integer labellocation, long numberoflabels, string labelname);//  Standard label for raw

/////////////////////////////////////////////////
//  Declaration
//
long printerHandle		  // 32-bit Open Handle
long poNumber

string esc         // Escape Code
string loc        // location
string lot        // Material lot
string unit       // unit Of Measure
string operator   // operator
string part
string partType
string description
string destination
string supplier
string company
string temp
string name1
string name2
string name3
string address1, address2, address3
string vendorName
string userDef

Dec {0} dQuantity

Date mfgDate
Time mfgTime

Datetime firstDT

mfgDate = date(firstDT)
mfgTime = time(firstDT)

  select part.name, description_short, part.type  
    into :temp, 
			:description,
			:partType
    from part  
   where part.part = :part   ;

  select vendor.name  
    into :vendorName
    from vendor, po_header  
   where vendor.code = po_header.vendor_code and
   		po_header.po_number = :poNumber ;


//	string loc
	string locationList[]
	execute immediate "if @@trancount = 0 then begin transaction getlocationes end save transaction getlocations" using SQLCA;

	declare locations cursor for
		select
			locationCode
		from
			partPutAwaylocations
		where
			partCode = :part
		order by locationCode using SQLCA ;

	open locations;

	do while sqlca.sqlcode = 0
		fetch
			locations
		into
			:loc ;

		locationList[UpperBound(locationList) + 1] = loc 
	loop

	close locations ;
	execute immediate "rollback transaction getlocations" using SQLCA;
	
	
	select user_defined_1
	  into :userDef
	  from part_characteristics
	where part = :part  ;

	

//  select edi_setups.supplier_code  
//    into :supplier  
//    from edi_setups  
//   where edi_setups.destination = :destination   ;

select parameters.company_name, address_1, address_2, address_3
	into :company,
		  :address1,
			:address2,
			:address3
	From parameters ;
	

name1 = Mid(temp, 1, 20)
name2 = Mid(temp, 21, 20)
name3 = Mid(temp, 41, 20)

esc = "~h1B"


/////////////////////////////////////////////////
//  Main Routine
//

printerHandle = PrintOpen()

//  Start Printing
PrintSend(printerHandle, esc + "A")
PrintSend(printerHandle, esc + "CS4") // Speed 4 of 6
PrintSend(printerHandle, esc + "Z")
PrintSend(printerHandle, esc + "A")
PrintSend(printerHandle, esc + "#EB2") // Darkness 2 of 5
PrintSend(printerHandle, esc + "Z")
PrintSend(printerHandle, esc + "A" + esc + "R")

//  Part Info
choose case labelLocation
	case 0
		PrintSend(printerHandle, esc + "V063" + esc + "H756" + esc + "M" + "PART NO")
		PrintSend(printerHandle, esc + "V080" + esc + "H760" + esc + "$B,60,100,0" + esc + "$=" + part)
		PrintSend(printerHandle, esc + "V190" + esc + "H760" + esc + "B103095" + "*" + "S" + string(serial) + "*")
		
		//	Date plate
		PrintSend(printerHandle, esc + "V063" + esc + "H296" + esc + "$B,100,125,0" + esc + "$=" + string(mfgDate, "MMMYY"))
		PrintSend(printerHandle, esc + "V063" + esc + "H596" + esc + "(200,125")
		
	case 1
		PrintSend(printerHandle, esc + "V063" + esc + "H296" + esc + "M" + "PART NO")
		PrintSend(printerHandle, esc + "V100" + esc + "H300" + esc + "$B,60,100,0" + esc + "$=" + part)
		PrintSend(printerHandle, esc + "V063" + esc + "H" + String(300 + Len(part) * 60 + 50) + esc + "B103095" + "*" + "S" + string(serial) + "*")
		
		//	Date plate
		PrintSend(printerHandle, esc + "V063" + esc + "H1096" + esc + "$B,100,125,0" + esc + "$=" + string(mfgDate, "MMMYY"))
		PrintSend(printerHandle, esc + "V063" + esc + "H1096" + esc + "(200,125")
		
	case 2, 3
		PrintSend(printerHandle, esc + "V063" + esc + "H296" + esc + "M" + "PART NO")
		PrintSend(printerHandle, esc + "V080" + esc + "H300" + esc + "$B,60,100,0" + esc + "$=" + part)
		PrintSend(printerHandle, esc + "V180" + esc + "H300" + esc +"B103095" + "*" + "S" + string(serial) + "*")
		
end choose

PrintSend(printerHandle, esc + "V275" + esc + "H250" + esc + "FW02H1112")

//	Lot, vendor, virgin/regrind.
PrintSend(printerHandle, esc + "V279" + esc + "H296" + esc + "M" + "lot #")
PrintSend(printerHandle, esc + "V335" + esc + "H296" + esc + "WB1" + lot)

PrintSend(printerHandle, esc + "V275" + esc + "H740" + esc + "FW02V100")

if	partType = 'R' then
	PrintSend(printerHandle, esc + "V279" + esc + "H746" + esc + "M" + "VENDOR")
	PrintSend(printerHandle, esc + "V335" + esc + "H746" + esc + "WB1" + mid(vendorName,1,20))
	
	PrintSend(printerHandle, esc + "V275" + esc + "H1220" + esc + "FW02V100")
	
	PrintSend(printerHandle, esc + "V293" + esc + "H1226" + esc + "FW0202V030H030")
	PrintSend(printerHandle, esc + "V325" + esc + "H1226" + esc + "FW0202V030H030")
	PrintSend(printerHandle, esc + "V303" + esc + "H1270" + esc + "M" + "VIRGIN")
	PrintSend(printerHandle, esc + "V335" + esc + "H1270" + esc + "M" + "REGRIND")
end if

PrintSend(printerHandle, esc + "V375" + esc + "H250" + esc + "FW02H1112")

//	Description, date
PrintSend(printerHandle, esc + "V379" + esc + "H296" + esc + "M" + "DESCRIPTION")
PrintSend(printerHandle, esc + "V405" + esc + "H296" + esc + "WB1" + MID(temp,1,35))

PrintSend(printerHandle, esc + "V379" + esc + "H1116" + esc + "M" + "DATE ORIG:")
PrintSend(printerHandle, esc + "V405" + esc + "H1116" + esc + "WB1" + string(mfgDate,"MM/DD/YY") + " "+ string(mfgTime,"HH:MM"))

PrintSend(printerHandle, esc + "V445" + esc + "H250" + esc + "FW02H1112")
PrintSend(printerHandle, esc + "V445" + esc + "H1100" + esc + "FW02V0528")

//	Quantity
PrintSend(printerHandle, esc + "V449" + esc + "H296" + esc + "M" + "QUANTITY")
if	dQuantity > 0 then
	PrintSend(printerHandle, esc + "V460" + esc + "H296" + esc + "$A,150,125,0" + esc + "$=" + string(dQuantity) + "WL1  " + unit)
else
	PrintSend(printerHandle, esc + "V460" + esc + "H296" + esc + "$A,150,125,0" + esc + "$=" + string(dQuantity) + "WL1  " + unit)
	PrintSend(printerHandle, esc + "V460" + esc + "H596" + esc + "WL1" + "REVERSED")
	PrintSend(printerHandle, esc + "V452" + esc + "H586" + esc + "(260,60")
end if

PrintSend(printerHandle, esc + "V595" + esc + "H250" + esc + "FW02H725")

//	R A W / W I P / F I N
choose case labelName
	case "RAW", "RAWOP"
		PrintSend(printerHandle, esc + "V460" + esc + "H1070" + esc + "$A,125,100,0" + esc + "$=" + "R A W")
	case "WIP"
		PrintSend(printerHandle, esc + "V460" + esc + "H1070" + esc + "$A,125,100,0" + esc + "$=" + "W I P")
	case else
		PrintSend(printerHandle, esc + "V460" + esc + "H1070" + esc + "$A,125,100,0" + esc + "$=" + "F I N")
end choose

//	Serial
choose case labelLocation
	case 0, 1
		PrintSend(printerHandle, esc + "V599" + esc + "H756" + esc + "M" + "SERIAL #")
		if	partType <> "N" then
			PrintSend(printerHandle, esc + "V618" + esc + "H760" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
		else
			PrintSend(printerHandle, esc + "V618" + esc + "H760" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
			PrintSend(printerHandle, esc + "V618" + esc + "H1100" + esc + "WL1" + "NON-INV")
			PrintSend(printerHandle, esc + "V612" + esc + "H1100" + esc + "(225,60")
		end if
	case 2
		PrintSend(printerHandle, esc + "V599" + esc + "H296" + esc + "M" + "SERIAL #")
		if	partType <> "N" then
			PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
		else
			PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
			PrintSend(printerHandle, esc + "V618" + esc + "H750" + esc + "WL1" + "NON-INV")
			PrintSend(printerHandle, esc + "V612" + esc + "H740" + esc + "(225,60")
		end if
		
		//	Date plate
		PrintSend(printerHandle, esc + "V618" + esc + "H296" + esc + "$B,100,125,0" + esc + "$=" + string(mfgDate, "MMMYY"))
		PrintSend(printerHandle, esc + "V618" + esc + "H596" + esc + "(200,125")
	case 3
		PrintSend(printerHandle, esc + "V599" + esc + "H296" + esc + "M" + "SERIAL #")
		if	partType <> "N" then
			PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
		else
			PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
			PrintSend(printerHandle, esc + "V618" + esc + "H750" + esc + "WL1" + "NON-INV")
			PrintSend(printerHandle, esc + "V612" + esc + "H740" + esc + "(225,60")
		end if
		
		//	Date plate
		PrintSend(printerHandle, esc + "V618" + esc + "H1096" + esc + "$B,100,125,0" + esc + "$=" + string(mfgDate, "MMMYY"))
		PrintSend(printerHandle, esc + "V618" + esc + "H1096" + esc + "(200,125")
end choose

PrintSend(printerHandle, esc + "V599" + esc + "H296" + esc + "M" + "SERIAL #")
if	partType <> "N" then
	PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
else
	PrintSend(printerHandle, esc + "V618" + esc + "H300" + esc + "$A,110,100,0" + esc + "$=" + string(serial))
	PrintSend(printerHandle, esc + "V618" + esc + "H750" + esc + "WL1" + "NON-INV")
	PrintSend(printerHandle, esc + "V612" + esc + "H740" + esc + "(225,60")
end if
PrintSend(printerHandle, esc + "V718" + esc + "H296" + esc + "B103095" + "*" + "S" + string(serial) + "*")

//	Number of labels.
PrintSend(printerHandle, esc + "Q" + string(numberOfLabels))

//	Finished
PrintSend(printerHandle, esc + "Z")

//	Print locations (raw only)
if	partType = "R" then
	PrintSend(printerHandle, esc + "A" + esc + "R")
	
	PrintSend(printerHandle, esc + "V063" + esc + "H296" + esc + "M" + "locATIONS")
	int i
	int iVShift = 120
	string sVShift
	for i = 1 to UpperBound(locationList) - 1
		if	i < 20 then
			sVShift = "V" + string(iVShift)
			PrintSend(printerHandle, esc + sVShift + esc + "H296" + esc + "WB1" + string(locationList[i]))
			iVShift = iVShift + 35
		else
			PrintSend(printerHandle, esc + "V783" + esc + "H296" + esc + "M" + "...see warehouse log book for more.")
			exit
		end if
	next
	
	//	Print MSDS
	PrintSend(printerHandle, esc + "R")
	//PrintSend(printerHandle, esc + "N")
	
	PrintSend(printerHandle, esc + "V900" + esc + "H035" + esc + "(60,55")
	PrintSend(printerHandle, esc + "V905" + esc + "H110" + esc + "WL1" + "HEALTH")
	PrintSend(printerHandle, esc + "V895" + esc + "H030" + esc + "(700,65")
	PrintSend(printerHandle, esc + "V905" + esc + "H045" + esc + "WL1" + Mid(userDef, 1, 1))
	
	PrintSend(printerHandle, esc + "V970" + esc + "H035" + esc + "(60,55")
	PrintSend(printerHandle, esc + "V975" + esc + "H110" + esc + "WL1" + "FLAMMABILITY")
	PrintSend(printerHandle, esc + "V965" + esc + "H030" + esc + "(70,65")
	PrintSend(printerHandle, esc + "V975" + esc + "H045" + esc + "WL1" + Mid(userDef, 2, 1))
	
	PrintSend(printerHandle, esc + "V1040" + esc + "H035" + esc + "(60,55")
	PrintSend(printerHandle, esc + "V1045" + esc + "H110" + esc + "WL1" + "REACTIVITY")
	PrintSend(printerHandle, esc + "V1035" + esc + "H030" + esc + "(700,65")
	PrintSend(printerHandle, esc + "V1045" + esc + "H045" + esc + "WL1" + Mid(userDef, 3, 1))
	
	PrintSend(printerHandle, esc + "V1110" + esc + "H035" + esc + "(60,55")
	PrintSend(printerHandle, esc + "V1115" + esc + "H110" + esc + "WL1" + "PROTECTIVE EQUIPMENT")
	PrintSend(printerHandle, esc + "V1105" + esc + "H030" + esc + "(70,65")
	PrintSend(printerHandle, esc + "V1115" + esc + "H045" + esc + "WL1" + Mid(userDef, 4, 1))
	
	
	
	PrintSend(printerHandle, esc + "Z")
	
	PrintClose(printerHandle)
end if

end subroutine

event open;
/*	Rotate the license place around the label. */
st_generic_structure labelParm
labelParm = Message.PowerObjectParm
long serial
serial = Long(labelParm.Value1)

integer labellocation
select
	ll.Labellocation
into
	:labellocation
from
	custom.Labellocation ll using SQLCA  ;

int numberOfLabels
if	labelParm.value11 > "" then
	numberOfLabels = long(labelParm.value11)
else
	numberOfLabels = 1
end if

//	Test all...
PrintObjectLabel(serial, 1, numberOfLabels, labelParm.value12)
PrintObjectLabel(serial, 2, numberOfLabels, labelParm.value12)
PrintObjectLabel(serial, 3, numberOfLabels, labelParm.value12)
PrintObjectLabel(serial, 4, numberOfLabels, labelParm.value12)
Close(this)

end event

on w_21cent_internal.create
end on

on w_21cent_internal.destroy
end on

