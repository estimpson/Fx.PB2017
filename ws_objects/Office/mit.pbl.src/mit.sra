$PBExportHeader$mit.sra
forward
global type mit from application
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
String 			szInquiry, &
			szReturnedPart, &
			szReturnedUnit, &
                                                szReturnedString, &
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

global type mit from application
string appname = "mit"
string displayname = "Inventory"
end type
global mit mit

forward prototypes
public subroutine af_parse_command_line (string as_commandline)
end prototypes

public subroutine af_parse_command_line (string as_commandline);Long		l_SpacePos
String	s_Temp, &
			s_Left, &
			s_Right

IF as_CommandLine = '' THEN 
	is_Transaction = ''
	szMachineParm = ''
	Return
END IF

l_SpacePos = PosA ( as_CommandLine, ' ' )

IF l_SpacePos > 0 THEN
	s_Left 	= Upper ( LeftA ( as_CommandLine, l_SpacePos - 1 ) )
	s_Right	= Upper ( RightA ( as_CommandLine, LenA ( as_CommandLine ) - l_SpacePos ) )
	IF s_Left = "JOBCOMPLETE" OR &
		s_Left = "COMBOSCAN" OR &
		s_Left = "MATERIALISSUE" OR &
		s_Left = "TRANSFER" OR &
		s_Left = "COMBINE" OR &
		s_Left = "BREAKOUT" OR &
		s_Left = "QUALITYCONTROL" THEN

		is_Transaction = s_Left

		SELECT machine.machine_no  
		  INTO :s_Temp  
		  FROM machine  
		 WHERE machine.machine_no = :s_Right   ;

		IF SQLCA.SQLCode = 0 THEN
			szMachineParm = s_Temp
		ELSE
			szMachineParm = ''
		END IF

	ELSEIF s_Right	= "JOBCOMPLETE" OR &
		s_Right = "COMBOSCAN" OR &
		s_Right = "MATERIALISSUE" OR &
		s_Right = "TRANSFER" OR &
		s_Right = "COMBINE" OR &
		s_Right = "BREAKOUT" OR &
		s_Right = "QUALITYCONTROL" THEN

		is_Transaction = s_Right

		SELECT machine.machine_no  
		  INTO :s_Temp  
		  FROM machine  
		 WHERE machine.machine_no = :s_Left   ;

		IF SQLCA.SQLCode = 0 THEN
			szMachineParm = s_Temp
		ELSE
			szMachineParm = ''
		END IF

	ELSE

		is_Transaction = ''

		SELECT machine.machine_no  
		  INTO :s_Temp  
		  FROM machine  
		 WHERE machine.machine_no = :s_Left   ;

		IF SQLCA.SQLCode = 0 THEN
			szMachineParm = s_Temp
		ELSE
			szMachineParm = ''
		END IF

	END IF
ELSE

	as_CommandLine = Upper ( as_CommandLine )

	IF as_CommandLine	= "JOBCOMPLETE" OR &
		as_CommandLine = "COMBOSCAN" OR &
		as_CommandLine = "MATERIALISSUE" OR &
		as_CommandLine = "TRANSFER" OR &
		as_CommandLine = "COMBINE" OR &
		as_CommandLine = "BREAKOUT" OR &
		as_CommandLine = "QUALITYCONTROL" THEN

		is_Transaction = as_CommandLine
		szMachineParm = ''

	ELSE

		is_Transaction = ''

		SELECT machine.machine_no  
		  INTO :s_Temp  
		  FROM machine  
		 WHERE machine.machine_no = :as_CommandLine   ;

		IF SQLCA.SQLCode = 0 THEN
			szMachineParm = s_Temp
		ELSE
			szMachineParm = ''
		END IF

	END IF

END IF
end subroutine

on mit.create
appname="mit"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create n_err
end on

on mit.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;LONG  l_l_count, &
		l_l_temp, &
		l_l_inner

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

monsys.title = "Inventory Control"
monsys.of_getidinfo ( )
liblist.app	 = this

IF Handle ( this ) = 0 THEN
	monsys.title += "-- Runtime"
END IF

IF sysenviron.OSType = windowsnt! THEN
	monsys.msg_title = monsys.title + " for Windows NT"
ELSE
	monsys.msg_title = monsys.title + " for Windows 95"
END IF
	
IF Handle ( this, TRUE ) > 0 THEN
	MessageBox ( monsys.msg_title,  monsys.title + " is already running."  )
	HALT
END IF

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
Toolbarframetitle = "INVENTORY CONTROL"
Toolbartext			= TRUE

// Open MDI Frame
af_parse_command_line ( f_get_string_value ( CommandParm ( ) ) )

bIC = False

// set idle time to value stored in monitor.ini
Idle ( sqlca.of_getidlecommittime ( ) * 60 )

IF is_Transaction > '' THEN

	st_generic_structure stParm

	/*  Initialize Variables  */

	CHOOSE CASE is_Transaction
		CASE "JOBCOMPLETE"
			Open ( w_job_complete )
			Return
		CASE "MATERIALISSUE"
			stParm.Value1 = "Material Issue"
		CASE "COMBOSCAN"
			Open ( w_combo_scan )
			Return
		CASE "TRANSFER"
			stParm.Value1 = "Transfer"
		CASE "COMBINE"
			stParm.Value1 = "Combine"
		CASE "QUALITYCONTROL"
			stParm.Value1 = "Quality Control"
		CASE "BREAKOUT"
			stParm.Value1 = "BreakOut"
	END CHOOSE

	stParm.Value5 = szWorkOrder

	OpenWithParm ( w_touch_screen_generic_trans, stparm )

ELSE
	Open ( w_mitw30_main )
END IF



end event

event close;destroy sqlca
end event

event systemerror;OPEN ( w_error_watch_dog )
end event

event idle;// commit in case user leaves connection open
commit;
end event

