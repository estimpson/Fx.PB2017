$PBExportHeader$scheduling.sra
$PBExportComments$Generated Application Object
forward
global type scheduling from application
end type
global n_tr_scheduling sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global n_err error
global n_msg message
end forward

global variables

n_cst_appmanager	gnv_App

end variables

global type scheduling from application
string appname = "scheduling"
string displayname = "FX COP"
end type
global scheduling scheduling

type variables

end variables

on scheduling.create
appname="scheduling"
message=create n_msg
sqlca=create n_tr_scheduling
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create n_err
end on

on scheduling.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
//	Setup db connection.
destroy SQLCA
SQLCA = create n_tr_scheduling

//	Create monsys.
monsys = create monsys
monsys.msg_Title = DisplayName

//	Create app manager and open.
message.inv_Parm.of_SetItem ("SQLCAConnect", "fxCOP")
gnv_App = create n_cst_appmanager_scheduling
gnv_App.event pfc_open (CommandLine)

end event

