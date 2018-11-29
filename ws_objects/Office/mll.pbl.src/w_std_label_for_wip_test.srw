$PBExportHeader$w_std_label_for_wip_test.srw
forward
global type w_std_label_for_wip_test from window
end type
end forward

global type w_std_label_for_wip_test from window
integer width = 2025
integer height = 1448
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
global w_std_label_for_wip_test w_std_label_for_wip_test

type prototypes
//FUNCTION long RunWait(string filename, string arguments) Library "RunWaitDotNet.dll"
end prototypes

type variables

end variables

event open;st_generic_structure stParm
stParm= Message.PowerObjectParm


///////////////////////////////
// Declaration
//

long serial
long labelQuantity
string labelLocation

serial = Long(stParm.Value1)
labelQuantity = Long(stParm.Value11)
labelLocation = "I:\Fx\Custom\Labels\BarTenderLabels\STD_WIP_TestDB.btw"

OLEObject obj
obj = CREATE OLEObject

int return_code
return_code = obj.ConnectToNewObject("RunWaitDotNet.RunWait")


if return_code <> 0 then
	destroy obj
	messagebox("Error", "Component Installation Error");
	return
else
	String runwaitCommand
	String runwaitArg
	
	runwaitCommand = "~"C:\Program Files (x86)\Seagull\BarTender Suite\bartend.exe~""
	runwaitArg =  "/F=" + labelLocation + " /?Serial=" + string(serial) +  " /C=" + string(labelQuantity) + " /P /X"
	 
	int variable
	variable = obj.Run(runwaitCommand, runwaitArg)
	if variable <> 0 then
		messagebox("Error", "Exception throw from .NET RunWait.Run()");
		//messagebox("Result", variable);
	end if
	destroy obj
end if


close (this)
end event

on w_std_label_for_wip_test.create
end on

on w_std_label_for_wip_test.destroy
end on

