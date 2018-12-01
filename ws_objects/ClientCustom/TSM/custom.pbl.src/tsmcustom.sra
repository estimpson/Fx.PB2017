$PBExportHeader$tsmcustom.sra
$PBExportComments$Generated Application Object
forward
global type tsmcustom from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type tsmcustom from application
string appname = "tsmcustom"
end type
global tsmcustom tsmcustom

on tsmcustom.create
appname = "tsmcustom"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on tsmcustom.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

