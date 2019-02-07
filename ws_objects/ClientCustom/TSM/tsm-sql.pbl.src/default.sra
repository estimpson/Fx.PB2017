﻿$PBExportHeader$default.sra
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string ExeName
string IniName
end variables

global type default from application
end type
global default default

on open;
window w_local
ToolBarText=True
ExeName="cs_inv.exe"
IniName="cs_inv.ini"
if not fileexists(IniName) then
    MessageBox("Initialization Error", "Application .ini file ~"" + IniName + "~" not found.")
    return
end if

sqlca.DBMS=ProfileString(IniName,"database","DBMS","")
sqlca.Database=ProfileString(IniName,"database","database","")
sqlca.UserId=ProfileString(IniName,"database","UserID","")
sqlca.DBPass=ProfileString(IniName,"database","DatabasePassWord","")
sqlca.LogID=ProfileString(IniName,"database","LogID","")
sqlca.LogPass=ProfileString(IniName,"database","LogPassWord","")
sqlca.ServerName=ProfileString(IniName,"database","ServerName","")
sqlca.Lock=ProfileString(IniName,"database","Lock","")
sqlca.AutoCommit=(ProfileInt(IniName,"database","AutoCommit",0)=1)
sqlca.DBParm=ProfileString(IniName,"database","DBParm","")
if Pos(Upper(sqlca.DBMS),"ODB") = 0 then Open(w_pbstyle_logon)
connect;
if sqlca.sqlcode = 0 then
OpenWithParm(w_local,ExeName,"w_pbstyle_frame")
else
MessageBox("Database Error","Database connect failed. Application cannot be run.")
end if
end on

on default.create
message = create message
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
sqlca = create transaction
end on

on default.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on
