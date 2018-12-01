$PBExportHeader$azteccustom.sra
$PBExportComments$Generated Application Object
forward
global type azteccustom from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type azteccustom from application
string appname = "azteccustom"
end type
global azteccustom azteccustom

on azteccustom.create
appname = "azteccustom"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on azteccustom.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

