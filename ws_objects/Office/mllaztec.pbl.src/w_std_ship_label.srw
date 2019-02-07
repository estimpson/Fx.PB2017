$PBExportHeader$w_std_ship_label.srw
$PBExportComments$Chrysler version.  Will need to be recompiled for use with 2000 build (with new msd.pbd).
forward
global type w_std_ship_label from Window
end type
type st_7 from statictext within w_std_ship_label
end type
type sle_shipper from singlelineedit within w_std_ship_label
end type
type cb_chrysler from commandbutton within w_std_ship_label
end type
type st_6 from statictext within w_std_ship_label
end type
type sle_destinationname from singlelineedit within w_std_ship_label
end type
type em_labelcount from editmask within w_std_ship_label
end type
type st_5 from statictext within w_std_ship_label
end type
type cb_print from commandbutton within w_std_ship_label
end type
type sle_address3 from singlelineedit within w_std_ship_label
end type
type sle_address2 from singlelineedit within w_std_ship_label
end type
type sle_address1 from singlelineedit within w_std_ship_label
end type
type st_4 from statictext within w_std_ship_label
end type
type st_3 from statictext within w_std_ship_label
end type
type st_2 from statictext within w_std_ship_label
end type
type st_1 from statictext within w_std_ship_label
end type
type sle_destinationcode from singlelineedit within w_std_ship_label
end type
end forward

global type w_std_ship_label from Window
int X=1074
int Y=480
int Width=1701
int Height=1112
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
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
global w_std_ship_label w_std_ship_label

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

on w_std_ship_label.create
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

on w_std_ship_label.destroy
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

type st_7 from statictext within w_std_ship_label
int X=457
int Y=744
int Width=274
int Height=76
boolean Enabled=false
string Text="Shipper"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_shipper from singlelineedit within w_std_ship_label
int X=750
int Y=736
int Width=494
int Height=80
int TabOrder=60
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_chrysler from commandbutton within w_std_ship_label
int X=937
int Y=852
int Width=512
int Height=88
int TabOrder=70
string Text="Print Chrysler"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Freightliner  Destination  Label
//5/19/03 JAC  CSR 169937  RFQ 7322  AZTEC MFG

//  Declarations
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
STRING   ls_phone

//  Get the company information.
SELECT	company_name,
			address_1,
			address_2,
			address_3,
			phone_number
  INTO	:ls_company,
			:ls_address1,
			:ls_address2,
			:ls_address3,
			:ls_phone
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
//	PrintSend ( ll_Label, lc_esc + "A" + lc_esc + "R" )
//	PrintSend ( ll_Label, lc_esc + "AR" )

//  Start Printing
PrintSend ( ll_Label, lc_Esc + "A" )
// Change orientation for testing
// PrintSend ( ll_Label, lc_Esc + "R" + lc_Esc + "R" + lc_Esc + "R" )



	//	Destination
	PrintSend ( ll_Label, lc_esc + "V055" + lc_esc + "H55" + lc_esc + "M" + "FREIGHTLINERER PLANT LOCATION CODE" )
	PrintSend ( ll_Label, lc_esc + "V065" + lc_esc + "H115" + lc_esc + "$B,125,200,0" + lc_esc + "$=" + ls_destination )

	// Dock Code
	PrintSend ( ll_Label, lc_esc + "V055" + lc_esc + "H815" + lc_esc + "M" + "DOCK LOCATION" )
	PrintSend ( ll_Label, lc_esc + "V065" + lc_esc + "H845" + lc_esc + "$B,125,200,0" + lc_esc + "$=" + ls_dock )

	// Location
	PrintSend ( ll_Label, lc_esc + "V255" + lc_esc + "H35" + lc_esc + "M" + "LOCATION" )
	PrintSend ( ll_Label, lc_esc + "V280" + lc_esc + "H35" + lc_esc + "M" + "(1L)" )
	PrintSend ( ll_Label, lc_esc + "V230" + lc_esc + "H220" + lc_esc + "$B,125,140,0" + lc_esc + "$=" + ls_location )
   PrintSend ( ll_Label, lc_esc + "V370" + lc_esc + "H80" + lc_esc + "B103203" + "*" + "1L" + ls_location + "*"  )
	
	// print label count
	//	Printsend ( ll_Label, lc_esc + "V255" + lc_esc + "H1000" + lc_esc + "WL1" + String ( li_labelcount ) + " OF " + string ( li_numberoflabels ) )
	
	//	Destination Address
	PrintSend ( ll_Label, lc_esc + "V615" + lc_esc + "H35" + lc_esc + "M" + "SHIP TO" )
	PrintSend ( ll_Label, lc_esc + "V615" + lc_esc + "H150" + lc_esc + "WB1" + upper ( sle_destinationname.text ) )
	PrintSend ( ll_Label, lc_esc + "V660" + lc_esc + "H150" + lc_esc + "WB1" + upper ( sle_address1.text ) )
	PrintSend ( ll_Label, lc_esc + "V695" + lc_esc + "H150" + lc_esc + "WB1" + upper ( sle_address2.text ) )
	PrintSend ( ll_Label, lc_esc + "V730" + lc_esc + "H150" + lc_esc + "WB1" + upper ( sle_address3.text ) )

	// Ship Date
	PrintSend ( ll_Label, lc_esc + "V615" + lc_esc + "H815" + lc_esc + "M" + "SHIP DATE" )
	PrintSend ( ll_Label, lc_esc + "V665" + lc_esc + "H895" + lc_esc + "WL1" + string( today() ) )
	
	// Our Address
//	PrintSend ( ll_Label, lc_esc + "V795" + lc_esc + "H35" + lc_esc + "M" + "SHIP FROM    " + ls_company + " " + ls_address1 + " " + ls_address2+ " " + ls_address3 + " " + ls_phone)
	PrintSend ( ll_Label, lc_esc + "V795" + lc_esc + "H35" + lc_esc + "M" + "SHIP FROM  AZTEC MFG CORP  15378 OAKWOOD DR  ROMULUS MICH 48174 (734) 942-7433")
	
	//	Draw Lines
	PrintSend ( ll_Label, lc_esc + "V235" + lc_esc + "H35" + lc_esc + "FW02H1155" )
	PrintSend ( ll_Label, lc_esc + "V605" + lc_esc + "H35" + lc_esc + "FW02H1155" )
   PrintSend ( ll_Label, lc_esc + "V790" + lc_esc + "H35" + lc_esc + "FW02H1155" )
	PrintSend ( ll_Label, lc_esc + "V040" + lc_esc + "H795" + lc_esc + "FW02V195" )
	PrintSend ( ll_Label, lc_esc + "V605" + lc_esc + "H795" + lc_esc + "FW02V185" )
	
	// End Printing
	PrintSend ( ll_Label, lc_esc + "Q1" )
	PrintSend ( ll_Label, lc_esc + "Z" )
	PrintClose ( ll_Label )

NEXT

Close ( parent )
end event

type st_6 from statictext within w_std_ship_label
int X=91
int Y=232
int Width=649
int Height=72
boolean Enabled=false
string Text="Destination Name:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_destinationname from singlelineedit within w_std_ship_label
int X=750
int Y=224
int Width=786
int Height=80
int TabOrder=10
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_labelcount from editmask within w_std_ship_label
int X=951
int Y=608
int Width=247
int Height=100
int TabOrder=50
Alignment Alignment=Right!
string Mask="###"
string Text="1"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_std_ship_label
int X=238
int Y=608
int Width=695
int Height=96
boolean Enabled=false
string Text="Number of Labels:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_print from commandbutton within w_std_ship_label
int X=247
int Y=856
int Width=530
int Height=88
int TabOrder=60
string Text="Print Standard"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type sle_address3 from singlelineedit within w_std_ship_label
int X=750
int Y=512
int Width=786
int Height=80
int TabOrder=40
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_address2 from singlelineedit within w_std_ship_label
int X=750
int Y=416
int Width=786
int Height=80
int TabOrder=30
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_address1 from singlelineedit within w_std_ship_label
int X=750
int Y=320
int Width=786
int Height=80
int TabOrder=20
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_std_ship_label
int X=91
int Y=520
int Width=649
int Height=72
boolean Enabled=false
string Text="Address3:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_std_ship_label
int X=91
int Y=416
int Width=649
int Height=72
boolean Enabled=false
string Text="Address2:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_std_ship_label
int X=91
int Y=320
int Width=649
int Height=72
boolean Enabled=false
string Text="Address1:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_std_ship_label
int X=91
int Y=144
int Width=649
int Height=72
boolean Enabled=false
string Text="Destination Code:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_destinationcode from singlelineedit within w_std_ship_label
int X=750
int Y=128
int Width=786
int Height=80
boolean AutoHScroll=false
boolean DisplayOnly=true
string Pointer="Arrow!"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

