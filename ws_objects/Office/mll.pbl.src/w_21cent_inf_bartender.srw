$PBExportHeader$w_21cent_inf_bartender.srw
forward
global type w_21cent_inf_bartender from window
end type
end forward

global type w_21cent_inf_bartender from window
integer x = 823
integer y = 360
integer width = 1989
integer height = 1184
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
end type
global w_21cent_inf_bartender w_21cent_inf_bartender

type variables
st_generic_structure stparm
end variables

event open;
// This label uses special yellow label stock, which only one printer on the floor is set up to use
n_cst_printer printer
f_setprinter(printer, true)
printer.of_StoreDefault ()
printer.of_SetPrinter ("SATO CL408e")

//  Initialization
st_generic_structure labelParm
long serial

labelParm = Message.PowerObjectParm
serial = Long(labelParm.Value1)
string labelFormat

//	Print using run wait
n_runandwait runandwait
string runwaitCommand
string runwaitArg

//	Figure out what btw file to print (using labelParm.value12)...
labelFormat = 'INFILTRATORBTW2'

string labelLocation
select 
	LabelPath        
into
	:labelLocation
from
	BartenderLabels
where
	LabelFormat = :labelFormat   ;

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

// A separate label is required, which prints on normal label stock, so return to the default printer
printer.of_RestoreDefault ()
f_setprinter(printer, false)

//	Figure out what btw file to print (using labelParm.value12)...
labelFormat = 'INFILTRATORBTW1'

select
	LabelPath        
into
	:labelLocation
from
	BartenderLabels
where
	LabelFormat = :labelFormat   ;

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

close ( this )
end event

on w_21cent_inf_bartender.create
end on

on w_21cent_inf_bartender.destroy
end on

