$PBExportHeader$registry.sru
forward
global type registry from nonvisualobject
end type
end forward

global type registry from nonvisualobject
end type
global registry registry

type variables
constant string	MonitorRoot = "HKEY_LOCAL_MACHINE\Software\Monitor Software\TMFMS", &
	                MonitorMacro = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\MACRO", &
                                MonitorLiblist = "HKEY_LOCAL_MACHINE\Software\Monitor Software\TMFMS\Library List", &
		MonitorIncomingEDI = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\EDI\Incoming\File List", &
		MonitorEDIIncomingFileList = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\EDI\Incoming\File List", &
		MonitorEDIOutgoingFileList = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\EDI\Outgoing\File List", &
		MonitorEDIOutgoingDWList = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\EDI\Outgoing\DW List", &
		MonitorIncomingMapping = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\TMFMS\EDI\Incoming\Mapping", &
		MonitorCurrentUserQueue = "HKEY_CURRENT_USER\Software\Monitor Systems, Inc.\Job Queue", &
		MonitorLocalMachineQueue = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\Job Queue", &
		MonitorCurrentUserJob = "HKEY_CURRENT_USER\Software\Monitor Systems, Inc.\Job", &
		MonitorLocalMachineJob = "HKEY_LOCAL_MACHINE\Software\Monitor Systems, Inc.\Job", &
		ODBCProfile = "HKEY_CURRENT_USER\Software\ODBC\ODBC.INI", &
		MonitorProfile = "HKEY_CURRENT_USER\Software\Monitor Software\Profiles"
end variables

on registry.create
TriggerEvent( this, "constructor" )
end on

on registry.destroy
TriggerEvent( this, "destructor" )
end on

