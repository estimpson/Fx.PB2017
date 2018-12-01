$PBExportHeader$torcacustom.sra
$PBExportComments$Generated Application Object
forward
global type torcacustom from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type torcacustom from application
string appname = "torcacustom"
end type
global torcacustom torcacustom

on torcacustom.create
appname = "torcacustom"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on torcacustom.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

