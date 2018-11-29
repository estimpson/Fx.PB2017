$PBExportHeader$w_bartender.srw
forward
global type w_bartender from window
end type
end forward

global type w_bartender from window
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
global w_bartender w_bartender

event open;st_generic_structure labelParm
long serial

//  Initialization
labelParm = Message.PowerObjectParm
serial = Long(labelParm.Value1)

//	Figure out what btw file to print (using labelParm.value12)...
string labelFormat
labelFormat = labelParm.value12

string labelLocation
SELECT 
	LabelPath        
INTO
	:labelLocation
FROM
	BartenderLabels
WHERE 
	LabelFormat = :labelFormat   ;


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

runwaitArg =  "/F=" + labelLocation + " /?Serial=" + string(serial) +  " /C=" + labelParm.value11 + " /P /RUN /X"
runandwait.of_run(runwaitCommand + runwaitArg, Hide!)

//	Close
close (this)

end event

on w_bartender.create
end on

on w_bartender.destroy
end on

