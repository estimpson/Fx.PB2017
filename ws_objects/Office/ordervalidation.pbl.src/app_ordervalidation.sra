$PBExportHeader$app_ordervalidation.sra
forward
global u_tr_ordervalidation sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string		g_s_platform
end variables

global type app_ordervalidation from application
 end type
global app_ordervalidation app_ordervalidation

type variables

end variables

on app_ordervalidation.create
appname = "app_ordervalidation"
message = create message
sqlca = create u_tr_ordervalidation
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on app_ordervalidation.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event open;/*	Declarations	*/
LONG	ll_count
Window	lw_splash
string	ls_splash

// Instantiate Global NVO's
monsys = CREATE monsys
sysmetrics = CREATE sysmetrics
syscolor = CREATE syscolor
sysenviron = CREATE sysenviron
registry = CREATE registry
stdcolor = CREATE stdcolor
liblist		= CREATE liblist

monsys.title = "Monitor Order Validation"
monsys.of_getidinfo ( )
liblist.app	 = this

IF ( liblist.uf_initiate_list () = 0 ) THEN
	HALT CLOSE 
END IF

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
ELSE
	if monsys.dbplatform = "Mssql7" then
		ls_splash = "w_splash_sql7"
	else
		ls_splash = "w_title_popup"
	end if
	Open ( lw_splash, ls_splash )
END IF

// Connect to Primary Database
IF NOT SQLCA.uf_connect ( ) THEN
	Close ( lw_splash )
	Halt
END IF

// populate the g_s_platform value
g_s_platform = sqlca.platform

// Set Toolbar Names
toolbarframetitle = "Order Validation"
toolbarsheettitle = "None"

// Display the rotating logo then close
// To display the rotating logo 
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
Open ( w_mdi_frame_ordervalidation )
end event

event systemerror;Open ( w_error_watch_dog )
end event

event close;destroy sqlca
end event

event idle;commit;
end event

