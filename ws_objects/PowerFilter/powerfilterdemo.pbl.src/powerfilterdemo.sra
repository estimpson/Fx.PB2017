$PBExportHeader$powerfilterdemo.sra
$PBExportComments$Generated SDI Application Object
forward
global type powerfilterdemo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
date	gd_build = Today()
time	gtm_build = Now()
ulong	gul_temp
string	gs_key = "HKEY_CURRENT_USER\Software\Sybase\PowerBuilder\powerfilter"
integer	gi_dummy1 = RegistryGet( gs_key, "Build", ReguLong!, gul_temp)
integer	gi_dummy2 = RegistrySet( gs_key, "Build", ReguLong!, gul_temp + 1)
ulong	gul_build = gul_temp
end variables

global type powerfilterdemo from application
string appname = "powerfilterdemo"
end type
global powerfilterdemo powerfilterdemo

type variables

end variables

on powerfilterdemo.create
appname="powerfilterdemo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on powerfilterdemo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//*-----------------------------------------------------------------*/
//*    open:  Application Open Script
//*           1) Opens Main window
//*-----------------------------------------------------------------*/
Open ( w_powerfilterdemo_main )
end event

