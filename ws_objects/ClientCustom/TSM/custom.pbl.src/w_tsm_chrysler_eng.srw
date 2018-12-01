$PBExportHeader$w_tsm_chrysler_eng.srw
forward
global type w_tsm_chrysler_eng from Window
end type
type st_5 from statictext within w_tsm_chrysler_eng
end type
type sle_4 from singlelineedit within w_tsm_chrysler_eng
end type
type st_4 from statictext within w_tsm_chrysler_eng
end type
type st_3 from statictext within w_tsm_chrysler_eng
end type
type st_2 from statictext within w_tsm_chrysler_eng
end type
type st_1 from statictext within w_tsm_chrysler_eng
end type
type sle_3 from singlelineedit within w_tsm_chrysler_eng
end type
type sle_2 from singlelineedit within w_tsm_chrysler_eng
end type
type sle_1 from singlelineedit within w_tsm_chrysler_eng
end type
type cb_1 from commandbutton within w_tsm_chrysler_eng
end type
end forward

global type w_tsm_chrysler_eng from Window
int X=672
int Y=268
int Width=2043
int Height=1016
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_5 st_5
sle_4 sle_4
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
cb_1 cb_1
end type
global w_tsm_chrysler_eng w_tsm_chrysler_eng

type variables
St_generic_structure  Stparm
end variables

on w_tsm_chrysler_eng.create
this.st_5=create st_5
this.sle_4=create sle_4
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.st_5,&
this.sle_4,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.cb_1}
end on

on w_tsm_chrysler_eng.destroy
destroy(this.st_5)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_1)
end on

event open;Stparm = Message.PowerObjectParm
end event

type st_5 from statictext within w_tsm_chrysler_eng
int X=18
int Y=180
int Width=521
int Height=76
boolean Enabled=false
boolean Border=true
string Text="Eng Change Level:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_tsm_chrysler_eng
int X=571
int Y=176
int Width=1033
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_tsm_chrysler_eng
int Width=2007
int Height=116
boolean Enabled=false
string Text="Chrysler Engineering Label"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_tsm_chrysler_eng
int X=18
int Y=556
int Width=521
int Height=76
boolean Enabled=false
boolean Border=true
string Text="Ship To Location:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78164112
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_tsm_chrysler_eng
int X=18
int Y=432
int Width=521
int Height=72
boolean Enabled=false
boolean Border=true
string Text="Sequence Number:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78164112
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_tsm_chrysler_eng
int X=18
int Y=308
int Width=521
int Height=76
boolean Enabled=false
boolean Border=true
string Text="Control Number:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78164112
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_tsm_chrysler_eng
int X=571
int Y=556
int Width=1408
int Height=92
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_tsm_chrysler_eng
int X=571
int Y=432
int Width=1038
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_tsm_chrysler_eng
int X=571
int Y=308
int Width=1038
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_tsm_chrysler_eng
int X=759
int Y=720
int Width=475
int Height=128
int TabOrder=40
string Text="PRINT"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//  Standard label for job completion

/////////////////////////////////////////////////
//  Declaration
//
//Stparm = Message.PowerObjectParm
//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle

String cEsc         // Escape Code
String szLoc        // Location
String szLot        // Material Lot
String szUnit       // Unit Of Measure
String szOperator   // Operator
String szPart, szP
String szDescription
String szdestination
String szSupplier
String szCompany, szEng
String szTemp
String szName1
String szName2
String szName3
String szAddress1, szAddress2, szAddress3
String szNumberofLabels
String szLabelname
String s_cust_part
String	s_eng
String	s_operator
String	s_eng_level
String ls_control_number
String ls_sequence_number
String ls_ship_to_location
String ls_eng_change

Long   lSerial

Dec {0} dQuantity

Time tTime

Date dDate

Datetime dt_date_time
DateTime	s_max_date
DateTime	s_date_time

/////////////////////////////////////////////////
//  Initialization
//

lSerial = Long(Stparm.Value1)

ls_control_number = sle_1.text

ls_sequence_number = sle_2.text

ls_ship_to_location = sle_3.text

ls_eng_change = sle_4.text

  SELECT object.part,   
         object.lot,   
         object.location,   
         object.last_date,   
         object.unit_measure,   
         object.operator,   
         object.quantity,   
         object.last_time,
			object.destination
    INTO :szPart,   
         :szLot,   
         :szLoc,   
         :dt_Date_time,   
         :szUnit,   
         :szOperator,   
         :dQuantity,   
         :dt_date_Time, 
			:szdestination 
    FROM object  
   WHERE object.serial = :lSerial   ;

ddate = date(dt_date_time)
ttime = Time(dt_date_time)

//szP = Stparm.Value2

  SELECT part.name, description_short  
    INTO :szTemp, 
			:szDescription 
    FROM part,
	 		object
   WHERE part.part = object.part  AND
   		object.serial = :lSerial	;

  SELECT edi_setups.supplier_code,
  			order_header.customer_part
    INTO :szSupplier,
	 		:s_cust_part
    FROM edi_setups,
	 		shipper,
			object,
			shipper_detail,
			order_header
   WHERE CONVERT ( int, object.origin ) = shipper.id  AND
			order_header.order_no = shipper_detail.order_no  AND
			shipper.id = shipper_detail.shipper  AND
			edi_setups.destination = shipper.destination  AND
			object.serial = :lSerial	;

SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;

//SELECT max ( effective_Date ) 
//  INTO :s_max_date
//  FROM effective_change_notice,
//       object	
//WHERE effective_change_notice.part = object.part AND
//       object.serial = :lserial  ;
		 
SELECT   effective_change_notice.engineering_level,
			effective_change_notice.operator
  INTO	:s_eng,
  			:s_operator
  FROM   effective_change_notice,
  			object
 WHERE   //effective_date =  :s_date_time   AND
			effective_change_notice.part = object.part  AND
	 		object.serial = :lSerial   ;
			 
//IF isnull ( s_operator ) OR s_operator = '' THEN
//	s_eng_level = s_eng
//ELSE
//	s_eng_level = s_operator
//END IF

If Stparm.value11 = "" Then 
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If

//szSupplier = Stparm.value3

szName1 = Mid ( szTemp, 1, 20 )
szName2 = Mid ( szTemp, 21, 20 )
szName3 = Mid ( szTemp, 41, 20 )

cEsc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

ll_Label = PrintOpen ( )

//  Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

//  Part Info
PrintSend ( ll_Label, cEsc + "V090" + cEsc + "H210" + cEsc + "S" + "PART NO.(P)" )
// PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H346" + cEsc + "M" + "(P)" )
PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc + "$=" + szTemp )
PrintSend ( ll_Label, cEsc + "V075" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc + "$=" + szPart )
PrintSend ( ll_Label, cEsc + "V135" + cEsc + "H405" + cEsc + "B103070" + "*" + "P" + szPart + "*" )

//  Quantity Info
PrintSend ( ll_Label, cEsc + "V365" + cEsc + "H210" + cEsc + "S" + "QUANTITY (Q)" )
// PrintSend ( ll_Label, cEsc + "V288" + cEsc + "H346" + cEsc + "M" + "(Q)" )
PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc +"$=" + String(dQuantity) )
PrintSend ( ll_Label, cEsc + "V410" + cEsc + "H405" + cEsc + "B103070" + "*" +"Q" + String(dQuantity) + "*" )

//  Control Number
PrintSend ( ll_Label, cEsc + "V505" + cEsc + "H210" + cEsc + "S" + "CONTROL # (S)" )
PrintSend ( ll_Label, cEsc + "V490" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc +"$=" + ls_control_number )
PrintSend ( ll_Label, cEsc + "V550" + cEsc + "H405" + cEsc + "B103070" + "*" +"S" + ls_control_number + "*" )


// Sequence Number
PrintSend ( ll_Label, cEsc + "V645" + cEsc + "H210" + cEsc + "S" + "SEQUENCE # (M)" )
PrintSend ( ll_Label, cEsc + "V630" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc +"$=" + ls_sequence_number )
PrintSend ( ll_Label, cEsc + "V690" + cEsc + "H405" + cEsc + "B103070" + "*" +"M" + ls_sequence_number + "*" )


// SHIP TO LOCATION
PrintSend ( ll_Label, cEsc + "V775" + cEsc + "H210" + cEsc + "S" + "SHIP TO LOC:" )
PrintSend ( ll_Label, cEsc + "V765" + cEsc + "H405" + cEsc + "$A,40,45,0" + cEsc +"$=" + ls_ship_to_location )


//  Supplier Info
// PrintSend ( ll_Label, cEsc + "V479" + cEsc + "H350" + cEsc + "M" + "SUPPLIER" )
// PrintSend ( ll_Label, cEsc + "V504" + cEsc + "H350" + cEsc + "M" + "(V)" )
// PrintSend ( ll_Label, cEsc + "V475" + cEsc + "H500" + cEsc + "WL1" + szSupplier )
// PrintSend ( ll_Label, cEsc + "V518" + cEsc + "H381" + cEsc + "B103095" + "*" + "V" + szSupplier + "*" )

//  Serial Number Info
// PrintSend ( ll_Label, cEsc + "V631" + cEsc + "H346" + cEsc + "M" + "SERIAL " )
// PrintSend ( ll_Label, cEsc + "V656" + cEsc + "H346" + cEsc + "M" + "(S)" )
// PrintSend ( ll_Label, cEsc + "V625" + cEsc + "H500" + cEsc + "WL1" + String(lSerial))
// PrintSend ( ll_Label, cEsc + "V668" + cEsc + "H381" + cEsc + "B103095" + "*" + "S" + String(lSerial) + "*")

//  Description Info
// PrintSend ( ll_Label, cEsc + "V263" + cEsc + "H900" + cEsc + "$A,40,40,0" + cEsc + "$=" + szTemp )

//  Date Manufactured Info
// PrintSend ( ll_Label, cEsc + "V315" + cEsc + "H900" + cEsc + "$A,40,40,0" + cEsc + "$=" + "DATE MFG" )
// PrintSend ( ll_Label, cEsc + "V370" + cEsc + "H900" + cEsc + "$A,50,50,0" + cEsc + "$=" + String(today()) )

//  Engineering Change Info
PrintSend ( ll_Label, cEsc + "V225" + cEsc + "H210" + cEsc + "S" + "ENGINEERING CHANGE" )
PrintSend ( ll_Label, cEsc + "V240" + cEsc + "H210" + cEsc + "S" + "LEVEL" )
PrintSend ( ll_Label, cEsc + "V210" + cEsc + "H405" + cEsc + "$A,80,70,0" + cEsc + "$=" + ls_eng_change ) 
PrintSend ( ll_Label, cEsc + "V270" + cEsc + "H405" + cEsc + "B103070" + "*" + ls_eng_change + "*" )

//  Additional Part Info
// PrintSend ( ll_Label, cEsc + "V490" + cEsc + "H1050" + cEsc + "$A,40,40,0" + cEsc + "$=" + "E&E : " + szPart )

//  Company Info
PrintSend ( ll_Label, cEsc + "V810" + cEsc + "H405" + cEsc + "M" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 )

//  Draw Lines
PrintSend ( ll_Label, cEsc + "N" )
// PrintSend ( ll_Label, cEsc + "V395" + cEsc + "H472" + cEsc + "FW03H0299" )
PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H350" + cEsc + "FW03V1190" )
// PrintSend ( ll_Label, cEsc + "V537" + cEsc + "H254" + cEsc + "FW03H0220" )
// PrintSend ( ll_Label, cEsc + "V150" + cEsc + "H300" + cEsc + "FW03H0175" )
// PrintSend ( ll_Label, cEsc + "V300" + cEsc + "H300" + cEsc + "FW03H0175" )
PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H215" + cEsc + "FW03V1190" )
PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H490" + cEsc + "FW03V1190" )
PrintSend ( ll_Label, cEsc + "V025" + cEsc + "H630" + cEsc + "FW03V1190" )

PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
//Close ( this )
end event

