$PBExportHeader$sysenviron.sru
forward
global type sysenviron from nonvisualobject
end type
end forward

global type sysenviron from nonvisualobject
event ue_constructor ( )
end type
global sysenviron sysenviron

type variables
CPUTypes	CPUType
OSTypes		OSType
PBTypes		PBType

BOOLEAN	MachineCode, &
		Win16

INTEGER	OSFixesRevision, &
		OSMajorRevision, &
		OSMinorRevision, &
		PBFixesRevision, &
		PBMajorRevision, &
		PBMinorRevision

LONG		NumberOfColors, &
		ScreenHeight, &
		ScreenWidth
end variables

event ue_constructor;Environment	l_env_temp

GetEnvironment ( l_env_temp )

machinecode			= l_env_temp.machinecode
win16					= l_env_temp.win16
cputype				= l_env_temp.cputype
osfixesrevision	= l_env_temp.osfixesrevision
osmajorrevision	= l_env_temp.osmajorrevision
osminorrevision	= l_env_temp.osminorrevision
pbfixesrevision	= l_env_temp.pbfixesrevision
pbmajorrevision	= l_env_temp.pbmajorrevision
pbminorrevision	= l_env_temp.pbminorrevision
numberofcolors		= l_env_temp.numberofcolors
screenheight		= l_env_temp.screenheight
screenwidth			= l_env_temp.screenwidth
ostype				= l_env_temp.ostype
end event

event constructor;TRIGGER EVENT ue_constructor ( )
end event

on sysenviron.create
TriggerEvent( this, "constructor" )
end on

on sysenviron.destroy
TriggerEvent( this, "destructor" )
end on

