$PBExportHeader$w_winwedge_link.srw
forward
global type w_winwedge_link from w_ddelink
end type
end forward

global type w_winwedge_link from w_ddelink
event ue_open ( )
end type
global w_winwedge_link w_winwedge_link

type variables
STRING			i_s_commport,&
			i_s_amount_field,&
			i_s_steady_field,&
			i_s_data,&
			i_s_data_field
INT			i_i_amount_field,&
			i_i_steady_field
end variables

forward prototypes
public function integer wf_start_ww (string a_s_machine)
end prototypes

public function integer wf_start_ww (string a_s_machine);//	Declare local variables
STRING						l_s_winwedge_loc,&
								l_s_winwedge_config
int							l_i_port,&
								l_i_return

// Get machine serial communications parameters
SELECT	serial_port, 
			winwedge_location, 
			wwconfig_location,
			amount_field,
			steady_field
INTO		:l_i_port, 
			:l_s_winwedge_loc,
			:l_s_winwedge_config,
			:i_i_amount_field,
			:i_i_steady_field
FROM		machine_serial_comm 
WHERE		machine = :a_s_machine ;


// If valid values, open WinWedge with config file and minimize
IF sqlca.sqlcode = 0 THEN
	i_s_commport = "COM" + String ( l_i_port )
	i_s_amount_field = "Field(" + String ( i_i_amount_field ) + ")"
	i_s_steady_field = "Field(" + String ( i_i_steady_field ) + ")"
//	Run ( l_s_winwedge_loc + " " + l_s_winwedge_config , Minimized! )
//	INT l_i_count
//	FOR l_i_count = 1 TO 15000
//	NEXT
//	l_i_return = wf_exec_command ( "{APPNORMAL}", "WinWedge", i_s_commport )
//	IF l_i_return < 0 THEN
//		MessageBox ( "Serial Interface", "The configuration settings for the serial interface are not set up correctly.  Please check settings and try again.", Information! )
//		Close ( This )
//		RETURN -1
//	END IF
//	l_i_return = wf_exec_command ( "{APPMINIMIZE}", "WinWedge", i_s_commport )
//	IF l_i_return < 0 THEN
//		MessageBox ( "Serial Interface", "The configuration settings for the serial interface are not set up correctly.  Please check settings and try again.", Information! )
//		Close ( This )
//		RETURN -1
//	END IF
//ELSE
//	MessageBox ( "Serial Interface", "The configuration settings for the serial interface are not set up correctly.  Please check settings and try again.", Information! )
//	Close ( This )
//	RETURN -1
END IF

// Start the hot link for amount and steady fields (1,2 respectively)
IF i_i_amount_field > 0 THEN
	wf_connect ( i_s_amount_field, "WinWedge", i_s_commport )
END IF

IF i_i_steady_field > 0 THEN
	wf_connect ( i_s_steady_field, "WinWedge", i_s_commport )
END IF

RETURN 1
end function

on w_winwedge_link.create
call w_ddelink::create
end on

on w_winwedge_link.destroy
call w_ddelink::destroy
end on

event close;call super::close;// Stop hot link for amount and steady fields
IF i_i_amount_field > 0 THEN
	wf_disconnect ( i_s_amount_field )
END IF

IF i_i_steady_field > 0 THEN
	wf_disconnect ( i_s_steady_field )
END IF

// Close WinWedge
//wf_exec_command ( "{APPEXIT}", "WinWedge", i_s_commport )
end event

event hotlinkalarm;call super::hotlinkalarm;// Declare local variables
STRING	l_s_dummy1,&
			l_s_dummy2
			
// Get the dde data being sent and it's origin (field)
GetDataDDE ( i_s_data )
GetDataDDEOrigin ( l_s_dummy1, l_s_dummy2, i_s_data_field )
end event

