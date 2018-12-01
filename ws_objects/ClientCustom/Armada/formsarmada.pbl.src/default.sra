$PBExportHeader$default.sra
$PBExportComments$Generated Infomaker Application Object
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
/*  Infomaker Default Globals  */
string	exename
string	ininame
end variables

global type default from application
 end type
global default default

on default.create
appname = "default"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on default.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

