$PBExportHeader$u_netout_processed.sru
forward
global type u_netout_processed from nonvisualobject
end type
end forward

global type u_netout_processed from nonvisualobject
end type
global u_netout_processed u_netout_processed

type variables
STRING	part [ ]

LONG	rows, &
	origin [ ]

DOUBLE	quantity [ ]

DATETIME	due [ ]
end variables

on u_netout_processed.create
TriggerEvent( this, "constructor" )
end on

on u_netout_processed.destroy
TriggerEvent( this, "destructor" )
end on

