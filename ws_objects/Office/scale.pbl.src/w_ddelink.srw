$PBExportHeader$w_ddelink.srw
forward
global type w_ddelink from Window
end type
end forward

global type w_ddelink from Window
int X=833
int Y=361
int Width=1998
int Height=1209
boolean TitleBar=true
string Title="DDE Link"
long BackColor=79741120
end type
global w_ddelink w_ddelink

type variables
STRING		i_s_appname,&
		i_s_topic
end variables

forward prototypes
public function integer wf_connect (string a_s_location, string a_s_appname, string a_s_topic)
public function integer wf_exec_command (string a_s_command, string a_s_appname, string a_s_topic)
public function integer wf_disconnect (string a_s_location)
end prototypes

public function integer wf_connect (string a_s_location, string a_s_appname, string a_s_topic);INT		l_i_return

l_i_return = StartHotLink ( a_s_location, a_s_appname, a_s_topic )

IF l_i_return = 1 THEN
	i_s_appname		= a_s_appname
	i_s_topic		= a_s_topic
END IF

return l_i_return

end function

public function integer wf_exec_command (string a_s_command, string a_s_appname, string a_s_topic);Return ExecRemote ( a_s_command, a_s_appname, a_s_topic )
end function

public function integer wf_disconnect (string a_s_location);return StopHotLink ( a_s_location, i_s_appname, i_s_topic )
end function

on w_ddelink.create
end on

on w_ddelink.destroy
end on

