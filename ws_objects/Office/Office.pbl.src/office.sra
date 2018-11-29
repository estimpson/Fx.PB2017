$PBExportHeader$office.sra
$PBExportComments$Generated Application Object
forward
global type office from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global n_err error
global n_msg message
end forward

global variables

n_cst_appmanager	gnv_App

//	Refactor out:
st_generic_structure 	stTransParm, stGlobalParm
datawindow dw1, dw2, dw3, dw4
window wChain, wTrans[5], wmainscreen
string szReturnedString, szReturnedPart, szOperator, szMachineParm, szInquiry, szReturnedUnit, is_Transaction
transaction gitr_accounting_interface
integer g_i_node_ptr, iLastTransInstance, iCurInst
string g_s_platform
boolean gb_bitmap
boolean bfinish, bSuccess, bNoCommit, bCancel, bChanged
dec dreturnedqty, dconvertedqty
m_main_menu	mMenu
DataWindowChild dwcUnits
RadioButton rb1

end variables

global type office from application
string appname = "office"
boolean toolbartext = true
string toolbarframetitle = "FT.Frame"
string toolbarsheettitle = "FT.Sheet"
string displayname = "factory eXplorer"
end type
global office office

type variables

end variables

on office.create
appname="office"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create n_err
end on

on office.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
//	Setup db connection.
destroy SQLCA
SQLCA = create n_tr_office

//	Create monsys.
monsys = create monsys
monsys.msg_Title = DisplayName

//	Read testing command line config.
string testingCommandLine
testingCommandLine = ProfileString("C:\Data\GIT2\PB10\SourceCode\Office\FxCommandLine.ini", "Default", "CommandLine", CommandLine)
if	testingCommandLine <> CommandLine and CommandLine = "" then
	CommandLine = testingCommandLine
end if

////	Read tracing flag.
//string traceFile
//traceFile = ProfileString("C:\Data\GIT2\PB10\SourceCode\Office\FxCommandLine.ini", "Default", "TraceFile", "")
//if	traceFile > "" then
//	any w, x, y, z
//	w = TraceOpen(TraceFile, Clock!)
//	x = TraceEnableActivity(ActRoutine!)
//	y = TraceBegin("Trace_block_1")
//	z = TraceUser(0, "office.open")
//end if

//	Create app manager and open.
message.inv_Parm.of_SetItem ("SQLCAConnect", "Office")
gnv_App = create n_cst_appmanager_office
gnv_App.event pfc_open (CommandLine)

end event

event close;//
//TraceUser(999, "office.close")
//TraceEnd()
//
end event

