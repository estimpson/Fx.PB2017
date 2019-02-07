$PBExportHeader$chrysler_asn.sra
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type chrysler_asn from application
 end type
global chrysler_asn chrysler_asn

on chrysler_asn.create
appname = "chrysler_asn"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on chrysler_asn.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

