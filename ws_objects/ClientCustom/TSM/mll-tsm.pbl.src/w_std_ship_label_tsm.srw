$PBExportHeader$w_std_ship_label_tsm.srw
forward
global type w_std_ship_label_tsm from Window
end type
end forward

global type w_std_ship_label_tsm from Window
int X=672
int Y=264
int Width=1582
int Height=992
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_std_ship_label_tsm w_std_ship_label_tsm

event open;//Script : open for w_std_ship_label

//
//	Standard Shipper Label
//	David Cervenan
//	6/14/95


///////////////////////////////////////////////////////////////
//	   Declaration
//

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle
Long ll_serial

String cEsc					                     //  Escape Code
String szCompany			                     //  Company Name
String szDestination		                     //  Destination Name
String szAddress1, szAddress2, szAddress3		//  Company Address
String szAddress4, szAddress5, szAddress6		//  Destination Address
String szDest				                     //  To keep the destination code from parameter
String szNumberofLabels                      //  Number of Labels
String s_temp
String s_temp1

st_generic_structure Stparm

////////////////////////////////////////////////////////////////////
//		Initialization
//

szDest	= Message.StringParm
Stparm = Message.PowerObjectParm
//szDest = String ( stparm.value1 )

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
   WHERE destination.destination = :szDest ;

If Stparm.value11 = "" Then
	szNumberofLabels = "Q1"
Else
	szNumberofLabels = "Q" + Stparm.value11
End If
//szNumberOfLabels = "Q1"

s_temp = MID ( szCompany, 1,12 )
s_temp1 = MID ( szCompany, 13,40 )
cEsc = "~h1B"

////////////////////////////////////////////////////////////////////////////////
//	Main Routine
//

ll_Label = PrintOpen ( )

//	Start Printing
PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" )

//	Upper Box Data
PrintSend ( ll_Label, cEsc + "V060" + cEsc + "H340" + cEsc + "M" + "FROM:" )
PrintSend ( ll_label, cEsc + "V080" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + szCompany )
PrintSend ( ll_Label, cEsc + "V155" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + szAddress1 )
PrintSend ( ll_Label, cEsc + "V230" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + szAddress2 )
PrintSend ( ll_Label, cEsc + "V305" + cEsc + "H335" + cEsc + "$A,72,72,0" + cEsc + "$=" + szAddress3 )

//	Lower Box Data
PrintSend ( ll_Label, cEsc + "V430" + cEsc + "H340" + cEsc + "M" + "TO:" )
PrintSend ( ll_Label, cEsc + "V460" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szDestination )
PrintSend ( ll_Label, cEsc + "V535" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress4 )
PrintSend ( ll_Label, cEsc + "V610" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress5 )
PrintSend ( ll_Label, cEsc + "V685" + cEsc + "H335" + cEsc + "$A,60,60,0" + cEsc + "$=" + szAddress6 )

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

PrintSend ( ll_Label, cEsc + szNumberofLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )
Close ( this )
end event

on w_std_ship_label_tsm.create
end on

on w_std_ship_label_tsm.destroy
end on

