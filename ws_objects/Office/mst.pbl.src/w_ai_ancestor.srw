$PBExportHeader$w_ai_ancestor.srw
forward
global type w_ai_ancestor from Window
end type
end forward

global type w_ai_ancestor from Window
int X=833
int Y=357
int Width=1994
int Height=1213
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_pipestart pbm_custom10
event ue_pipeend pbm_custom11
event ue_pipemeter pbm_custom12
end type
global w_ai_ancestor w_ai_ancestor

type variables
string		is_ai_type, &
		is_PipeName, &
		is_PipePBLName, &
		is_StoredProcName
STRING	is_AIDbProfile

uo_pipeline	ipl_PipeLine
end variables

on open;STRING	s_Pass, &
		s_ID, &
		s_Path

st_generic_structure	st_Parm

gitr_accounting_interface = CREATE transaction

  SELECT parameters.accounting_profile  
    INTO :is_AIDBProfile  
    FROM parameters  ;

IF FileExists ( 'c:\windows\monitor.ini' ) THEN
	s_Path = 'c:\windows\monitor.ini'
ELSE
	s_Path = 'MONITOR.ini'
END IF

gitr_accounting_interface.DBMS		= ProfileString ( s_Path, 'PROFILE ' + is_AIDbProfile, "DBMS", '' )
gitr_accounting_interface.Database	= ProfileString ( s_Path, 'PROFILE ' + is_AIDbProfile, "database", '' )
gitr_accounting_interface.ServerName	= ProfileString ( s_Path, 'PROFILE ' + is_AIDbProfile, "ServerName", '' )
gitr_accounting_interface.DbParm		= ProfileString ( s_Path, 'PROFILE ' + is_AIDbProfile, "DbParm", '' )

connect using gitr_accounting_interface ;

if gitr_accounting_interface.sqlcode <> 0 then
	Open ( w_login_accounting )
	IF IsValid ( Message.PowerObjectParm ) THEN
		st_Parm = Message.PowerObjectParm
		gitr_accounting_interface.UserId	= st_Parm.Value1
		gitr_accounting_interface.DBPass	= st_Parm.Value2
		gitr_accounting_interface.LogId	= st_Parm.Value1
		gitr_accounting_interface.LogPass	= st_Parm.Value2
	
		connect using gitr_accounting_interface  ;
	END IF

	IF gitr_accounting_interface.sqlcode <> 0 THEN
		MessageBox ( "Connect Error", "Unable to connect to accounting database!", StopSign! )
		Close ( This )
	END IF
end if

This.PostEvent ( "ue_open" )
end on

on close;disconnect using gitr_accounting_interface;
destroy gitr_accounting_interface;
end on

on w_ai_ancestor.create
end on

on w_ai_ancestor.destroy
end on

