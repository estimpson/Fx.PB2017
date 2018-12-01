$PBExportHeader$w_tsm_destination.srw
$PBExportComments$Chrysler version.  Will need to be recompiled for use with 2000 build (with new msd.pbd).
forward
global type w_tsm_destination from window
end type
type st_7 from statictext within w_tsm_destination
end type
type sle_shipper from singlelineedit within w_tsm_destination
end type
type cb_chrysler from commandbutton within w_tsm_destination
end type
type st_6 from statictext within w_tsm_destination
end type
type sle_destinationname from singlelineedit within w_tsm_destination
end type
type em_labelcount from editmask within w_tsm_destination
end type
type st_5 from statictext within w_tsm_destination
end type
type cb_print from commandbutton within w_tsm_destination
end type
type sle_address3 from singlelineedit within w_tsm_destination
end type
type sle_address2 from singlelineedit within w_tsm_destination
end type
type sle_address1 from singlelineedit within w_tsm_destination
end type
type st_4 from statictext within w_tsm_destination
end type
type st_3 from statictext within w_tsm_destination
end type
type st_2 from statictext within w_tsm_destination
end type
type st_1 from statictext within w_tsm_destination
end type
type sle_destinationcode from singlelineedit within w_tsm_destination
end type
end forward

global type w_tsm_destination from window
integer x = 1074
integer y = 480
integer width = 1701
integer height = 1112
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
st_7 st_7
sle_shipper sle_shipper
cb_chrysler cb_chrysler
st_6 st_6
sle_destinationname sle_destinationname
em_labelcount em_labelcount
st_5 st_5
cb_print cb_print
sle_address3 sle_address3
sle_address2 sle_address2
sle_address1 sle_address1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_destinationcode sle_destinationcode
end type
global w_tsm_destination w_tsm_destination

type variables

end variables

event open;//  Variable declarations

STRING	ls_destination
STRING	ls_dockcode
STRING	ls_numberoflabels

LONG	ll_shipperid

//  Get the destination from the message.
ls_destination = message.stringparm

//  Get the shipper number.
IF NOT IsValid ( w_shipping_dock ) THEN
	MessageBox ( "Warning.", "This label can only be printed from the Shipping Dock." )
	Close ( this )
	Return
END IF
ll_shipperid = w_shipping_dock.iShipper

//  Determine the proper destination code.
SELECT	destination.destination
  INTO	:ls_dockcode
  FROM	shipper_detail,
			order_header,
			destination
 WHERE	shipper_detail.shipper = :ll_shipperid AND
			shipper_detail.order_no = order_header.order_no AND
			order_header.location = destination.destination
GROUP BY destination.destination  ;

IF ls_dockcode > "" THEN
	ls_destination = ls_dockcode
END IF

//  Display the address.
SELECT	destination,
			name,
			address_1,
			address_2,
			address_3
  INTO	:sle_destinationcode.text,
			:sle_destinationname.text,
			:sle_address1.text,
			:sle_address2.text,
			:sle_address3.text
  FROM	destination
 WHERE	destination = :ls_destination  ;
 
 sle_shipper.text = string( ll_shipperid )
 
end event

on w_tsm_destination.create
this.st_7=create st_7
this.sle_shipper=create sle_shipper
this.cb_chrysler=create cb_chrysler
this.st_6=create st_6
this.sle_destinationname=create sle_destinationname
this.em_labelcount=create em_labelcount
this.st_5=create st_5
this.cb_print=create cb_print
this.sle_address3=create sle_address3
this.sle_address2=create sle_address2
this.sle_address1=create sle_address1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_destinationcode=create sle_destinationcode
this.Control[]={this.st_7,&
this.sle_shipper,&
this.cb_chrysler,&
this.st_6,&
this.sle_destinationname,&
this.em_labelcount,&
this.st_5,&
this.cb_print,&
this.sle_address3,&
this.sle_address2,&
this.sle_address1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_destinationcode}
end on

on w_tsm_destination.destroy
destroy(this.st_7)
destroy(this.sle_shipper)
destroy(this.cb_chrysler)
destroy(this.st_6)
destroy(this.sle_destinationname)
destroy(this.em_labelcount)
destroy(this.st_5)
destroy(this.cb_print)
destroy(this.sle_address3)
destroy(this.sle_address2)
destroy(this.sle_address1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_destinationcode)
end on

type st_7 from statictext within w_tsm_destination
integer x = 457
integer y = 744
integer width = 274
integer height = 76
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Shipper"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_shipper from singlelineedit within w_tsm_destination
integer x = 750
integer y = 736
integer width = 494
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_chrysler from commandbutton within w_tsm_destination
integer x = 928
integer y = 856
integer width = 512
integer height = 96
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Chrysler"
end type

event clicked;//  Declarations
CHAR	lc_esc

LONG	ll_label
LONG	ll_shipperid

INTEGER	li_labelcount
INTEGER	li_numberoflabels

STRING	ls_company
STRING	ls_address1
STRING	ls_address2
STRING	ls_address3
STRING	ls_destination
STRING	ls_dock
STRING	ls_location

//  Get the company information.
SELECT	company_name,
			address_1,
			address_2,
			address_3
  INTO	:ls_company,
			:ls_address1,
			:ls_address2,
			:ls_address3
  FROM	parameters  ;

//  Get the shipper information.
//ll_shipperid = w_shipping_dock.iShipper
ll_shipperid = long( sle_shipper.text )

SELECT	destination,
			shipping_dock
  INTO	:ls_destination,
			:ls_dock
  FROM	shipper
 WHERE	shipper.id = :ll_shipperid ;
 
if isnull ( ls_destination ) then ls_destination = ""
if isnull ( ls_dock ) then ls_dock = ""
 
ls_location = ls_destination + ls_dock

//  Get the number of labels to print.
li_numberoflabels = Integer ( em_labelcount.text )

//  Print the labels.
FOR li_labelcount = 1 to li_numberoflabels

	ll_Label = PrintOpen ( )

	lc_esc = "~h1B"

	//	Start Printing
	PrintSend ( ll_Label, lc_esc + "A" + lc_esc + "R" )
	PrintSend ( ll_Label, lc_esc + "AR" )

	//	Destination
	PrintSend ( ll_Label, lc_esc + "V055" + lc_esc + "H255" + lc_esc + "M" + "DAIMLERCHRYSLER CORPORATION PLANT CODE" )
	PrintSend ( ll_Label, lc_esc + "V085" + lc_esc + "H315" + lc_esc + "$B,125,160,0" + lc_esc + "$=" + ls_destination )

	// Dock Code
	PrintSend ( ll_Label, lc_esc + "V055" + lc_esc + "H1015" + lc_esc + "M" + "DOCK LOC" )
	PrintSend ( ll_Label, lc_esc + "V085" + lc_esc + "H1045" + lc_esc + "$B,125,160,0" + lc_esc + "$=" + ls_dock )

	// Location
	PrintSend ( ll_Label, lc_esc + "V255" + lc_esc + "H235" + lc_esc + "M" + "LOCATION" )
	PrintSend ( ll_Label, lc_esc + "V280" + lc_esc + "H235" + lc_esc + "M" + "(1L)" )
	PrintSend ( ll_Label, lc_esc + "V230" + lc_esc + "H420" + lc_esc + "$B,125,140,0" + lc_esc + "$=" + ls_location )
   PrintSend ( ll_Label, lc_esc + "V370" + lc_esc + "H280" + lc_esc + "B103203" + "*" + "1L" + ls_location + "*"  )
	
	// print label count
	//	Printsend ( ll_Label, lc_esc + "V255" + lc_esc + "H1200" + lc_esc + "WL1" + String ( li_labelcount ) + " OF " + string ( li_numberoflabels ) )
	
	//	Destination Address
	PrintSend ( ll_Label, lc_esc + "V615" + lc_esc + "H235" + lc_esc + "M" + "SHIP TO" )
	PrintSend ( ll_Label, lc_esc + "V645" + lc_esc + "H315" + lc_esc + "WB1" + upper ( sle_destinationname.text ) )
	PrintSend ( ll_Label, lc_esc + "V680" + lc_esc + "H315" + lc_esc + "WB1" + upper ( sle_address1.text ) )
	PrintSend ( ll_Label, lc_esc + "V715" + lc_esc + "H315" + lc_esc + "WB1" + upper ( sle_address2.text ) )
	PrintSend ( ll_Label, lc_esc + "V750" + lc_esc + "H315" + lc_esc + "WB1" + upper ( sle_address3.text ) )

	// Ship Date
	PrintSend ( ll_Label, lc_esc + "V615" + lc_esc + "H1015" + lc_esc + "M" + "SHIP DATE" )
	PrintSend ( ll_Label, lc_esc + "V665" + lc_esc + "H1065" + lc_esc + "WL1" + string( today() ) )
	
	// Our Address
	PrintSend ( ll_Label, lc_esc + "V795" + lc_esc + "H275" + lc_esc + "M" + ls_company + " " + ls_address1 + " " + ls_address2+ " " + ls_address3 )
	
	//	Draw Lines
	PrintSend ( ll_Label, lc_esc + "V235" + lc_esc + "H235" + lc_esc + "FW02H1155" )
	PrintSend ( ll_Label, lc_esc + "V605" + lc_esc + "H235" + lc_esc + "FW02H1155" )
	PrintSend ( ll_Label, lc_esc + "V040" + lc_esc + "H995" + lc_esc + "FW02V195" )
	PrintSend ( ll_Label, lc_esc + "V605" + lc_esc + "H995" + lc_esc + "FW02V185" )
	
	// End Printing
	PrintSend ( ll_Label, lc_esc + "Q1" )
	PrintSend ( ll_Label, lc_esc + "Z" )
	PrintClose ( ll_Label )

NEXT

Close ( parent )
end event

type st_6 from statictext within w_tsm_destination
integer x = 91
integer y = 232
integer width = 649
integer height = 72
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Destination Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_destinationname from singlelineedit within w_tsm_destination
integer x = 750
integer y = 224
integer width = 786
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type em_labelcount from editmask within w_tsm_destination
integer x = 951
integer y = 608
integer width = 247
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "1"
alignment alignment = right!
string mask = "###"
end type

type st_5 from statictext within w_tsm_destination
integer x = 238
integer y = 608
integer width = 695
integer height = 96
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Number of Labels:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_tsm_destination
integer x = 247
integer y = 856
integer width = 530
integer height = 96
integer taborder = 60
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Standard"
end type

event clicked;//  Declarations
CHAR	lc_esc

LONG	ll_label

INTEGER	li_labelcount
INTEGER	li_numberoflabels

STRING	ls_company
STRING	ls_address1
STRING	ls_address2
STRING	ls_address3

//  Get the company information.
SELECT	company_name,
			address_1,
			address_2,
			address_3
  INTO	:ls_company,
			:ls_address1,
			:ls_address2,
			:ls_address3
  FROM	parameters  ;

//  Get the number of labels to print.
li_numberoflabels = Integer ( em_labelcount.text )

//  Print the labels.
FOR li_labelcount = 1 to li_numberoflabels

	ll_Label = PrintOpen ( )

	lc_esc = "~h1B"

	//	Start Printing
	PrintSend ( ll_Label, lc_esc + "A" + lc_esc + "R" )
	PrintSend ( ll_Label, lc_esc + "AR" )

	//	Upper Box Data
	PrintSend ( ll_Label, lc_esc + "V080" + lc_esc + "H340" + lc_esc + "M" + "FROM:" )
	PrintSend ( ll_Label, lc_esc + "V100" + lc_esc + "H335" + lc_esc + "$A,36,36,0" + lc_esc + "$=" + ls_company )
	PrintSend ( ll_Label, lc_esc + "V175" + lc_esc + "H335" + lc_esc + "$A,36,36,0" + lc_esc + "$=" + ls_address1 )
	PrintSend ( ll_Label, lc_esc + "V250" + lc_esc + "H335" + lc_esc + "$A,36,36,0" + lc_esc + "$=" + ls_address2 )
	PrintSend ( ll_Label, lc_esc + "V325" + lc_esc + "H335" + lc_esc + "$A,36,36,0" + lc_esc + "$=" + ls_address3 )

	// print label count
	
	Printsend ( ll_Label, lc_esc + "V080" + lc_esc + "H1200" + lc_esc + "$A,36,36,0" + lc_esc + "$=" + String ( li_labelcount ) + " of " + string ( li_numberoflabels ) )

  //	Lower Box Data
  PrintSend ( ll_Label, lc_esc + "V430" + lc_esc + "H340" + lc_esc + "M" + "TO:" )
  PrintSend ( ll_Label, lc_esc + "V460" + lc_esc + "H335" + lc_esc + "$A,60,75,0" + lc_esc + "$=" + sle_destinationname.text )
  PrintSend ( ll_Label, lc_esc + "V535" + lc_esc + "H335" + lc_esc + "$A,60,75,0" + lc_esc + "$=" + sle_address1.text )
  PrintSend ( ll_Label, lc_esc + "V610" + lc_esc + "H335" + lc_esc + "$A,60,75,0" + lc_esc + "$=" + sle_address2.text )
  PrintSend ( ll_Label, lc_esc + "V685" + lc_esc + "H335" + lc_esc + "$A,60,75,0" + lc_esc + "$=" + sle_address3.text )


  //	Draw Lines
  PrintSend ( ll_Label, lc_esc + "N" )

  //	Top Box
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H050" + lc_esc + "FW06V1020" )		   //	Top Horz Line
  PrintSend ( ll_Label, lc_esc + "V1100" + lc_esc + "H050" + lc_esc + "FW06H0336" )		// Left Vert Line
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H050" + lc_esc + "FW06H0330" )		   //	Right Vert Line
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H380" + lc_esc + "FW06V1020" )  		// Bottom Horz Line 

  //	Bottom Box
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H410" + lc_esc + "FW06V1020" )		   //	Top Horz Line
  PrintSend ( ll_Label, lc_esc + "V1100" + lc_esc + "H410" + lc_esc + "FW06H0356" )		//	Left Vert Line
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H410" + lc_esc + "FW06H0350" )		   //	Right Vert Line
  PrintSend ( ll_Label, lc_esc + "V80" + lc_esc + "H760" + lc_esc + "FW06V1020" )		   // Bottom Horz Line

  PrintSend ( ll_Label, lc_esc + "Q1" )
  PrintSend ( ll_Label, lc_esc + "Z" )
  PrintClose ( ll_Label )

NEXT

Close ( parent )
end event

type sle_address3 from singlelineedit within w_tsm_destination
integer x = 750
integer y = 512
integer width = 786
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type sle_address2 from singlelineedit within w_tsm_destination
integer x = 750
integer y = 416
integer width = 786
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type sle_address1 from singlelineedit within w_tsm_destination
integer x = 750
integer y = 320
integer width = 786
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type st_4 from statictext within w_tsm_destination
integer x = 91
integer y = 520
integer width = 649
integer height = 72
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Address3:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_tsm_destination
integer x = 91
integer y = 416
integer width = 649
integer height = 72
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Address2:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_tsm_destination
integer x = 91
integer y = 320
integer width = 649
integer height = 72
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Address1:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_tsm_destination
integer x = 91
integer y = 144
integer width = 649
integer height = 72
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Destination Code:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_destinationcode from singlelineedit within w_tsm_destination
integer x = 750
integer y = 128
integer width = 786
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long backcolor = 16777215
boolean autohscroll = false
boolean displayonly = true
end type

