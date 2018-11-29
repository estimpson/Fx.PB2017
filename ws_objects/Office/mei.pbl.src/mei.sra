$PBExportHeader$mei.sra
forward
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_cst_appmanager	gnv_App

String 			is_Company
String 			is_Serial
String 			is_OEMTitle
String 			szReturnedString
string 			gs_module[],&
			gs_buttontext[],&
			gs_menutext[],&
			gs_buttonpic[],&
			gs_microhelp[],&
			gs_menutype[],&
			gs_menucommand[],&
			g_s_platform,&
			szglobalarray[]
st_generic_structure	sttransparm
int			gi_menuarrayupper
boolean			bnocommit
window			wmainscreen
dec			dglobalnumber
end variables

global type mei from application
 end type
global mei mei

event open;LONG  	l_l_count
Window	lw_splash
string	ls_splash

// Instantiate Global NVO's

sysmetrics 	= CREATE sysmetrics
syscolor 	= CREATE syscolor
sysenviron 	= CREATE sysenviron
monsys 		= CREATE monsys
registry 	= CREATE registry
stdcolor 	= CREATE stdcolor
liblist		= CREATE liblist

monsys.title = "EXECUTIVE INFORMATION"
liblist.app	 = this

IF ( liblist.uf_initiate_list () = 0 ) THEN
	HALT CLOSE 
END IF

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
ELSE
	if monsys.dbplatform = "Mssql7" then
		ls_splash = "w_splash_sql7"
	else
		ls_splash = "w_title_popup"
	end if
	Open ( lw_splash, ls_splash )
END IF

// Establish Environment

// Connect to Primary Database
gnv_App = create n_cst_appmanager
SQLCA.ii_SQLConnector = 2
SQLCA.event pfc_connect("Monitor")
//IF NOT SQLCA.uf_connect ( ) = SQLCA.SUCCESS THEN
//	Close ( lw_splash )
//	HALT
//END IF

// populate the g_s_platform value
g_s_platform = sqlca.sqlreturndata

// Set Toolbar Names
toolbarframetitle = "EXECUTIVE INFORMATION"
toolbarsheettitle = "EXECUTIVE INFORMATION"

IF ISVALID ( lw_splash ) THEN
	if monsys.dbplatform = "Mssql7" then
		lw_splash.DYNAMIC wf_timer ( )
	else
		lw_splash.DYNAMIC wf_rotate ( )
	end if
	CLOSE ( lw_splash )
END IF

// set idle time to value stored in monitor.ini
Idle ( sqlca.of_getidlecommittime ( ) * 60 )

// Open MDI Frame
Open ( w_meiw30_main )



end event

event close;destroy sqlca
end event

on mei.create
appname = "mei"
message = create message
sqlca = create n_tr
end on

on mei.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event systemerror;OPEN ( w_error_watch_dog )
end event

event idle;commit;
end event

