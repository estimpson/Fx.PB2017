HA$PBExportHeader$w_print_monlabel.srw
forward
global type w_print_monlabel from window
end type
end forward

global type w_print_monlabel from window
boolean visible = false
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Mon Label Printer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_print_monlabel w_print_monlabel

type prototypes
FUNCTION long RunWait(string command, long winstate) LIBRARY "runwait.dll"

end prototypes

on w_print_monlabel.create
end on

on w_print_monlabel.destroy
end on

event open;
st_generic_structure lstParm
lstParm = Message.PowerObjectParm

//	Find the monitor label format for this label.
string windowName
select
	WindowName
into
	:windowName
from
	dbo.MonitorLabels
where
	MonitorLabelName = :lstParm.value12  ;

Run ("c:\Fx\monprint\monprint.exe " + windowName + ":" + string(lstParm.value1) +  "," + lstParm.value11)

close (this)

end event

