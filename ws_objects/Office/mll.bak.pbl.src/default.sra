$PBExportHeader$default.sra
forward
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type default from application
 end type
global default default

on default.create
appname = "default"
message = create message
sqlca = create n_tr
end on

on default.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

