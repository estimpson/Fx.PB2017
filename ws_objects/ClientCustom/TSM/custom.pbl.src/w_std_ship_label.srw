$PBExportHeader$w_std_ship_label.srw
forward
global type w_std_ship_label from window
end type
end forward

global type w_std_ship_label from window
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
global w_std_ship_label w_std_ship_label

type prototypes
FUNCTION long RunWait(string command, long winstate) LIBRARY "runwait.dll"

end prototypes

on w_std_ship_label.create
end on

on w_std_ship_label.destroy
end on

event open;
//	Print destination label.
if	not IsValid(w_shipping_dock) then
	MessageBox("Warning", "Shipping Dock not open")
	return -1
end if
Run ("c:\Fx\monprint\monprint.exe w_std_ship_label:" + String(w_shipping_dock.iShipper) +  ",1")

close (this)

end event

