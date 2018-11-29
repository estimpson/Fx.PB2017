$PBExportHeader$app_default.sra
forward
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global n_err error
global n_msg message
end forward

global variables
n_cst_appmanager	gnv_App
end variables

global type app_default from application
 end type
global app_default app_default

on app_default.create
appname = "app_default"
message = create n_msg
sqlca = create n_tr
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create n_err
end on

on app_default.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

