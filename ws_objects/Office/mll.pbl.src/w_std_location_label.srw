$PBExportHeader$w_std_location_label.srw
forward
global type w_std_location_label from Window
end type
type dwname from datawindow within w_std_location_label
end type
end forward

global type w_std_location_label from Window
int X=672
int Y=264
int Width=1582
int Height=988
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dwname dwname
end type
global w_std_location_label w_std_location_label

type variables
Long lSerial
end variables

event open;//
//  Standard Location Label
//  Chris Rogers
//  1/26/94
//


//
//  Declaration
//

//Int iLabel		  // 16-bit Open Handle
Long ll_Label		  // 32-bit Open Handle

String cEsc         // Escape Code
String szLoc        //  Location
String szName       //  Location Name
String s_NumberOfLabels

st_generic_structure Stparm

//
//  Initialization
//

//Stparm = Message.PowerObjectParm
cEsc = "~h1B"
//szLoc = dwName.GetItemString ( dwName.GetRow ( ), "code" )
szLoc = Message.StringParm
dwName.SetTransObject( SQLCA )
dwName.Retrieve( szLoc )
szLoc = dwName.GetItemString ( 1, "code" )
szName = dwName.GetItemString( 1, "name" )
//szLoc = Message.StringParm

//If Stparm.value11 = "" Then
//	s_NumberofLabels = "Q1"
//Else
//	s_NumberofLabels = "Q" + Stparm.value11
//End If

//
//  Main Routine
//

ll_Label = PrintOpen ( )

PrintSend ( ll_Label, cEsc + "A" + cEsc + "R" ) //  Start Printing
PrintSend ( ll_Label, cEsc + "AR" )

PrintSend ( ll_Label, cEsc + "V075" + cEsc + "H400" + cEsc + "M" + "LOCATION CODE:" )
PrintSend ( ll_Label, cEsc + "V100" + cEsc + "H400" )
PrintSend ( ll_Label, cEsc + "$A,200,200,0" + cEsc + "$=" + szLoc )
PrintSend ( ll_Label, cEsc + "V350" + cEsc + "H400" )
PrintSend ( ll_Label, cEsc + "B103200" + "*" + szLoc + "*" )
PrintSend ( ll_Label, cEsc + "V640" + cEsc + "H400" )
PrintSend ( ll_Label, cEsc + "$A,100,100,0" + cEsc + "$=" + szName )

PrintSend ( ll_Label, cEsc + "N" )
PrintSend ( ll_Label, cEsc + "V030" + cEsc + "H320" + cEsc + "FW03V1127" )
PrintSend ( ll_Label, cEsc + s_NumberOfLabels )
PrintSend ( ll_Label, cEsc + "Z" )
PrintClose ( ll_Label )

Close ( this )
end event

on w_std_location_label.create
this.dwname=create dwname
this.Control[]={this.dwname}
end on

on w_std_location_label.destroy
destroy(this.dwname)
end on

type dwname from datawindow within w_std_location_label
int X=101
int Y=244
int Width=1330
int Height=360
int TabOrder=10
string DataObject="dwname"
boolean LiveScroll=true
end type

