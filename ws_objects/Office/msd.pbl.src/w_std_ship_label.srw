$PBExportHeader$w_std_ship_label.srw
$PBExportComments$TEMPORARY FOR STAMPINGS, INC.
forward
global type w_std_ship_label from window
end type
type dw_1 from u_fxdw within w_std_ship_label
end type
end forward

global type w_std_ship_label from window
integer x = 672
integer y = 264
integer width = 1605
integer height = 568
boolean titlebar = true
string title = "Destination Label"
boolean controlmenu = true
windowtype windowtype = response!
dw_1 dw_1
end type
global w_std_ship_label w_std_ship_label

type variables

private:
long _shipper

string _objectName

end variables

forward prototypes
public subroutine printlabels ()
end prototypes

public subroutine printlabels ();
int labelCount
dw_1.AcceptText()
labelCount = dw_1.Object.FinalLabelCount[1]

if	IsNull(_objectName, "") <> "w_std_ship_label" then
	st_generic_structure stParm
	stParm.Value1 = String(_shipper)
	stParm.Value11 = String(labelCount)
	window labelCode
	openwithParm(labelCode, stParm, _objectName)
	close (this)
	return
end if

//Script : open for w_std_ship_label
string company
string destinationName
string companyAddress1, companyAddress2, companyAddress3
string destinationAddress1, destinationAddress2, destinationAddress3

select
	p.company_name
,	p.address_1
,	p.address_2
,	p.address_3
,	d.name
,	d.address_1
,	d.address_2
,	d.address_3
into
	:company
,	:companyAddress1
,	:companyAddress2
,	:companyAddress3
,	:destinationName
,	:destinationAddress1
,	:destinationAddress2
,	:destinationAddress3
from
	dbo.shipper s
	join dbo.destination d
		on d.destination = s.destination
	cross join dbo.parameters p
where
	s.id = :_shipper   ;

long labelHandle
labelHandle = PrintOpen ( )

//	Start Printing
string cEsc = "~h1B"

PrintSend ( labelHandle, cEsc + "A" + cEsc + "R" )
PrintSend ( labelHandle, cEsc + "AR" )

//	Upper Box Data
PrintSend ( labelHandle, cEsc + "V060" + cEsc + "H340" + cEsc + "M" + "FROM:" )
PrintSend ( labelHandle, cEsc + "V080" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + company )
PrintSend ( labelHandle, cEsc + "V155" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + companyAddress1 )
PrintSend ( labelHandle, cEsc + "V230" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + companyAddress2 )
PrintSend ( labelHandle, cEsc + "V305" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + companyAddress3 )

//	Lower Box Data
PrintSend ( labelHandle, cEsc + "V430" + cEsc + "H340" + cEsc + "M" + "TO:" )
PrintSend ( labelHandle, cEsc + "V460" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + destinationName )
PrintSend ( labelHandle, cEsc + "V535" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + destinationAddress1 )
PrintSend ( labelHandle, cEsc + "V610" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + destinationAddress2 )
PrintSend ( labelHandle, cEsc + "V685" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + destinationAddress3 )

//	Draw Lines
PrintSend ( labelHandle, cEsc + "N" )

//	Top Box
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H050" + cEsc + "FW06V1020" )		//	Top Horz Line
PrintSend ( labelHandle, cEsc + "V1100" + cEsc + "H050" + cEsc + "FW06H0336" )	//	Left Vert Line
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H050" + cEsc + "FW06H0330" )		//	Right Vert Line
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H380" + cEsc + "FW06V1020" )  		//	Bottom Horz Line 

//	Bottom Box
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H410" + cEsc + "FW06V1020" )		//	Top Horz Line
PrintSend ( labelHandle, cEsc + "V1100" + cEsc + "H410" + cEsc + "FW06H0356" )	//	Left Vert Line
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H410" + cEsc + "FW06H0350" )		//	Right Vert Line
PrintSend ( labelHandle, cEsc + "V80" + cEsc + "H760" + cEsc + "FW06V1020" )		//	Bottom Horz Line

PrintSend ( labelHandle, cEsc + "Q" + string(labelCount))
PrintSend ( labelHandle, cEsc + "Z" )
PrintClose ( labelHandle )
close (this)
return

end subroutine

event open;
//	Get the destination label setup.
int labelCount

select top 1
	object_name
,	copies
into
	:_objectName
,	:labelCount
from
	dbo.report_library rl
where
	rl.name in ('DESTINATION LABEL', 'Destination')  ;

//  Initialization from shipper screen.
if	not IsValid (w_shipping_dock) then
	msgbox("Unknown error printing destination label.  Please re-open shipping dock and try again.", StopSign!)
	close (this)
	return
end if

_shipper = w_shipping_dock.iShipper
if	dw_1.Retrieve(_shipper) <= 0 then
	MsgBox ("Invalid shipper.  Re-open shipper and try again.", StopSign!)
	post Close(this)
	return
end if

dw_1.Object.PerLiftLabels[1] = labelCount

end event

on w_std_ship_label.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_std_ship_label.destroy
destroy(this.dw_1)
end on

type dw_1 from u_fxdw within w_std_ship_label
integer width = 1463
integer height = 460
integer taborder = 10
string dataobject = "d_destinationlabel_copies"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;SetTransObject(SQLCA)

end event

event clicked;call super::clicked;
choose case lower(dwo.Name)
	case "p_ok"
		printLabels()
	case "p_cancel"
		post close(parent)
end choose

end event

