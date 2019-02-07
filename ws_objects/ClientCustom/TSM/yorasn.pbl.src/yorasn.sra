$PBExportHeader$yorasn.sra
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type yorasn from application
 end type
global yorasn yorasn

on yorasn.create
appname = "yorasn"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on yorasn.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

