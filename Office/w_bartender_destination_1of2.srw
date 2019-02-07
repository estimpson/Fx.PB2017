HA$PBExportHeader$w_bartender_destination_1of2.srw
forward
global type w_bartender_destination_1of2 from window
end type
end forward

global type w_bartender_destination_1of2 from window
integer width = 3378
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_bartender_destination_1of2 w_bartender_destination_1of2

event open;
//	Get number of labels from labelParm.
st_generic_structure labelParm

//  Initialization
labelParm = Message.PowerObjectParm
long shipper
shipper = long(labelParm.value1)

//	Figure out what btw file to print (using labelParm.value12)...
string labelLocation
select
	LabelPath
into
	:labelLocation
from
	BartenderLabels
where
	LabelFormat in ('DESTINATION', 'Destination Label')   ;

//	Print using run wait
n_runandwait runandwait
String runwaitCommand
String runwaitArg

if	FileExists("C:\Program Files (x86)\Seagull\BarTender Suite\bartend.exe") then
	runwaitCommand = "~"C:\Program Files (x86)\Seagull\BarTender Suite\bartend.exe~" "
elseif FileExists("C:\Program Files\Seagull\BarTender Suite\bartend.exe") then
	runwaitCommand = "~"C:\Program Files\Seagull\BarTender Suite\bartend.exe~" "
else
	MessageBox(gnv_App.iapp_Object.DisplayName, "Bartender not installed or not found.", StopSign!)
	close(this)
end if

runwaitArg =  "/F=" + labelLocation + " /?Shipper=" + string(shipper) +  " /?C=" + labelParm.value11 + " /P /X"
clipboard(runwaitCommand + runwaitArg)
runandwait.of_run(runwaitCommand + runwaitArg, Hide!)

//	Close
close (this)

end event

on w_bartender_destination_1of2.create
end on

on w_bartender_destination_1of2.destroy
end on

