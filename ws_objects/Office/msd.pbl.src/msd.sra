$PBExportHeader$msd.sra
$PBExportComments$Shipping Dock
forward
global type msd from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global n_err error
global n_msg message
end forward

global variables
n_cst_appmanager	gnv_App

m_main_menu	mMenu
st_generic_structure 	stGlobalParm
st_generic_structure 	stTransParm
Int 			iCurInst, &
			iCurArray, &
			iCurArrayLimit, &
			iChoice, &
			iFlag, &
			gi_MenuArrayUpper, &
			il_PreviousRow,&
			iLastTransInstance
String 			szreturnedstring, &
			szInquiry, &
			szReturnedPart, &
			szReturnedUnit, &
			szGlobalArray[], &
			szCompanyName, &
			szLicenseName, &
			szLicenseCompany, &
			szLicenseNumber, &
			is_Serial, &
			is_Company, &
			is_OEMTitle, &
			gs_Module[], &
			gs_MenuText[], &
			gs_ButtonText[], &
			gs_ButtonPic[], &
			gs_MicroHelp[], &
			gs_MenuType[], &
			gs_MenuCommand[],&
			g_s_platform,&
			is_transaction,&
			szmachineparm,&
			szWorkOrder,&
			szOperator
Window 			wTitleScreen, &
			wMainScreen, &
			wChain, &
			wActiveSheet, &
			wChain1, &
			wCustomChain,&
			wTrans[5]
DataWindow 		dwName, &
			dw1, &
			dw2, &
			dw3, &
			dw4, &
			dw5, &
			dw6, &
			dw7, &
			dw8, &
			dw9, &
			dw10, &
			dwAux
DataWindowChild 		dwcUnits
RadioButton 		rb1
Long 			lStart, &
			g_i_Node_ptr,&
			i_i_Node_Ptr
Boolean 			bCancel, &
			bSearch, &
			bScreenOpen, &
			bCloseOnOpen, &
			bOpenEvent, &
			bChanged, &
			bBackToMain, &
			bFinish, &
			bNoCommit, &
			bSuccess, &
			bSelectVend, &
			gb_Bitmap,&
			bIC
Dec 			dNumberQue, &
			dReturnedQty, &
			dConvertedQty, &
			dReturnedFlag, &
			dGlobalNumber,&
			dGlobalDec,&
			szRemQty
PowerObject 		obCurrentObject
StaticText 		st1, &
			st2, &
			st3, &
			st4
Transaction		gitr_accounting_interface

end variables

global type msd from application
string appname = "msd"
string displayname = "Shipping"
end type
global msd msd

type prototypes

end prototypes

type variables

end variables

event open;LONG  l_l_count

// Instantiate Global NVO's
gnv_App = create n_cst_appmanager
gnv_App.of_Splash(1)

sysmetrics 	= CREATE sysmetrics
syscolor 	= CREATE syscolor
sysenviron 	= CREATE sysenviron
monsys 		= CREATE monsys
registry 	= CREATE registry
stdcolor 	= CREATE stdcolor
liblist		= CREATE liblist

monsys.title = "Shipping Dock"
monsys.of_getidinfo ( )
liblist.app	 = this

IF sysenviron.OSType = windowsnt! THEN
	monsys.msg_title = monsys.title + " for Windows NT"
ELSE
	monsys.msg_title = monsys.title + " for Windows 95"
END IF
	
IF Handle ( this ) = 0 THEN
	monsys.title += " -- Runtime"
ELSE
	monsys.title += " - " + monsys.company
END IF

IF Handle ( this, TRUE ) > 0 THEN
	MessageBox ( monsys.msg_title,  monsys.title + " is already running."  )
	HALT
END IF

// Establish Environment

// Connect to Primary Database
gnv_App = create n_cst_appmanager
SQLCA.ii_SQLConnector = 2
SQLCA.event pfc_connect("Office")
//IF NOT SQLCA.uf_connect ( ) = SQLCA.SUCCESS THEN
//	Close ( lw_splash )
//	HALT
//END IF

// populate the g_s_platform value
g_s_platform = sqlca.sqlreturndata

// Set Toolbar Names
toolbarframetitle = "SHIPPING DOCK"
toolbarsheettitle = "SHIPPING DOCK"
toolbartext			= TRUE

// set idle time to value stored in monitor.ini
Idle ( sqlca.of_getidlecommittime ( ) * 60 )

// Open MDI Frame
Open ( w_shipping_mdi_screen )




end event

event close;destroy sqlca
end event

on systemerror;Open(w_error_watch_dog)
end on

on msd.create
appname="msd"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create n_err
end on

on msd.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event idle;// commit in case user leaves connection open
commit;
end event

