$PBExportHeader$w_std_ship_label_tsm_1199.srw
forward
global type w_std_ship_label_tsm_1199 from Window
end type
type st_1 from statictext within w_std_ship_label_tsm_1199
end type
type em_1 from editmask within w_std_ship_label_tsm_1199
end type
type cb_1 from commandbutton within w_std_ship_label_tsm_1199
end type
end forward

shared variables

end variables

global type w_std_ship_label_tsm_1199 from Window
int X=672
int Y=264
int Width=1582
int Height=576
boolean TitleBar=true
string Title="Destination Label"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
em_1 em_1
cb_1 cb_1
end type
global w_std_ship_label_tsm_1199 w_std_ship_label_tsm_1199

on w_std_ship_label_tsm_1199.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_1}
end on

on w_std_ship_label_tsm_1199.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
end on

type st_1 from statictext within w_std_ship_label_tsm_1199
int X=18
int Y=48
int Width=974
int Height=112
boolean Enabled=false
string Text="NUMBER OF LABELS"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_std_ship_label_tsm_1199
int X=1024
int Y=32
int Width=475
int Height=112
int TabOrder=10
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_std_ship_label_tsm_1199
int X=530
int Y=176
int Width=457
int Height=224
int TabOrder=20
string Text="&OK"
boolean Default=true
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Script : open for w_std_ship_label

///////////////////////////////////////////////////////////////////
//	   Declaration
//

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle

String cEsc					                     //  Escape Code
String szCompany			                     //  Company Name
String szDestination		                     //  Destination Name
String szAddress1, szAddress2, szAddress3		//  Company Address
String szAddress4, szAddress5, szAddress6		//  Destination Address
String szDest				                     //  To keep the destination code from parameter
String szNumberofLabels                      //  Number of Labels
String sz_name
String sz_id

st_generic_structure Stparm

Int 	l_i_no
INT	l_i_count

////////////////////////////////////////////////////////////////////
//		Initialization
//

szDest	= Message.StringParm
Stparm = Message.PowerObjectParm

	SELECT parameters.company_name, address_1, address_2, address_3
		INTO	:szCompany,
				:szAddress1,
				:szAddress2,
				:szAddress3
		FROM parameters ;

  SELECT destination.name,   
         destination.address_1,   
         destination.address_2,   
         destination.address_3  
    INTO :szDestination,   
         :szAddress4,   
         :szAddress5,   
         :szAddress6  
    FROM destination  
   WHERE destination.destination = :szDest   ;
	
//		SELECT order_header.dock_code
//		FROM order_header,shipper_detail, shipper
//		into :sz_orddock
//		where order_header.order_no = shipper_detail.order_no and
//				shipper_detail.shipper = shipper.id and
//If Stparm.value11 = "" Then
//	szNumberofLabels = "Q1"
//Else
//	szNumberofLabels = "Q" + Stparm.value11
//End If

cEsc = "~h1B"

////////////////////////////////////////////////////////////////////////////////
//	Main Routine
//

l_i_no = Integer ( em_1.text )

FOR l_i_count = 1 to l_i_no 
	
	ll_Label = PrintOpen ( )

	//	Start Printing
	PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

	//	Upper Box Data
	PrintSend ( ll_Label, cEsc + "V080" + cEsc + "H340" + cEsc + "M" + "FROM:" )
	PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H335" + cEsc + "$A,36,36,0" + cEsc + "$=" + szCompany )
	PrintSend ( ll_Label, cEsc + "V175" + cEsc + "H335" + cEsc + "$A,36,36,0" + cEsc + "$=" + szAddress1 )
	PrintSend ( ll_Label, cEsc + "V250" + cEsc + "H335" + cEsc + "$A,36,36,0" + cEsc + "$=" + szAddress2 )
	PrintSend ( ll_Label, cEsc + "V325" + cEsc + "H335" + cEsc + "$A,36,36,0" + cEsc + "$=" + szAddress3 )

	// print label count
	
	Printsend ( ll_Label, cEsc + "V080" + cEsc + "H1200" + cEsc + "s" + string ( l_i_count ) + " of " + string( l_i_no ) )

  //	Lower Box Data
  PrintSend ( ll_Label, cEsc + "V430" + cEsc + "H340" + cEsc + "M" + "TO:" )
  PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + szDestination )
  PrintSend ( ll_Label, cEsc + "V535" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress4 )
  PrintSend ( ll_Label, cEsc + "V610" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress5 )
  PrintSend ( ll_Label, cEsc + "V685" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress6 )


  //	Draw Lines
  PrintSend ( ll_Label, cEsc + "N" )

  //	Top Box
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H050" + cEsc + "FW06V1020" )		   //	Top Horz Line
  PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H050" + cEsc + "FW06H0336" )		// Left Vert Line
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H050" + cEsc + "FW06H0330" )		   //	Right Vert Line
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H380" + cEsc + "FW06V1020" )  		// Bottom Horz Line 

  //	Bottom Box
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H410" + cEsc + "FW06V1020" )		   //	Top Horz Line
  PrintSend ( ll_Label, cEsc + "V1100" + cEsc + "H410" + cEsc + "FW06H0356" )		//	Left Vert Line
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H410" + cEsc + "FW06H0350" )		   //	Right Vert Line
  PrintSend ( ll_Label, cEsc + "V80" + cEsc + "H760" + cEsc + "FW06V1020" )		   // Bottom Horz Line

	PrintSend ( ll_Label, cEsc + "Q1" )
	PrintSend ( ll_Label, cEsc + "Z" )
	PrintClose ( ll_Label )

NEXT

Close (parent)

end event

