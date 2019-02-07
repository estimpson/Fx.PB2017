$PBExportHeader$w_std_ship_label.srw
$PBExportComments$TEMPORARY FOR STAMPINGS, INC.
forward
global type w_std_ship_label from Window
end type
end forward

global type w_std_ship_label from Window
int X=672
int Y=264
int Width=1582
int Height=992
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_std_ship_label w_std_ship_label

event open;//Script : open for w_std_ship_label

//
//	Standard Shipper Label
//	David Cervenan
//	6/14/95


///////////////////////////////////////////////////////////////////
//	   Declaration
//

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle

String cEsc					                     //  Escape Code
String l_s_Company			                     //  Company Name
String l_s_Destination		                     //  Destination Name
String l_s_Address1, l_s_Address2, l_s_Address3		//  Company Address
String l_s_Address4, l_s_Address5, l_s_Address6		//  Destination Address
String l_s_Dest				                     //  To keep the destination code from parameter
String l_s_NumberofLabels                      //  Number of Labels

st_generic_structure Stparm

////////////////////////////////////////////////////////////////////
//		Initialization
//

l_s_Dest	= Message.StringParm
Stparm = Message.PowerObjectParm

//  Get the company information.
SELECT	company_name,
			address_1,
			address_2,
			address_3
  INTO	:l_s_company,
			:l_s_address1,
			:l_s_address2,
			:l_s_address3
  FROM	parameters  ;

SELECT destination.name,   
		 destination.address_1,   
		 destination.address_2,   
		 destination.address_3  
  INTO :l_s_Destination,   
		 :l_s_Address4,   
		 :l_s_Address5,   
		 :l_s_Address6  
  FROM destination  
 WHERE destination.destination = :l_s_Dest   ;

//If Stparm.value11 = "" Then
//	l_s_NumberofLabels = "Q1"
//Else
//	l_s_NumberofLabels = "Q" + Stparm.value11
//End If

cEsc = "~h1B"

////////////////////////////////////////////////////////////////////////////////
//	Main Routine
//

ll_Label = PrintOpen ( )

//	Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )
PrintSend ( ll_Label, cEsc + "AR" )

//	Upper Box Data
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H340" + cEsc + "M" + "FROM:" )
PrintSend ( ll_Label, cEsc + "V080" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + l_s_Company )
PrintSend ( ll_Label, cEsc + "V155" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + l_s_Address1 )
PrintSend ( ll_Label, cEsc + "V230" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + l_s_Address2 )
PrintSend ( ll_Label, cEsc + "V305" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + l_s_Address3 )

//	Lower Box Data
PrintSend ( ll_Label, cEsc + "V430" + cEsc + "H340" + cEsc + "M" + "TO:" )
PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + l_s_Destination )
PrintSend ( ll_Label, cEsc + "V535" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + l_s_Address4 )
PrintSend ( ll_Label, cEsc + "V610" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + l_s_Address5 )
PrintSend ( ll_Label, cEsc + "V685" + cEsc + "H335" + cEsc + "$A,75,75,0" + cEsc + "$=" + l_s_Address6 )

//	Bottom Of Label
//PrintSend ( ll_Label, cEsc + "V775" + cEsc + "H300" + cEsc + "M" + "COMMENTS:" )


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
//PrintSend ( ll_Label, cEsc + l_s_NumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_std_ship_label.create
end on

on w_std_ship_label.destroy
end on

