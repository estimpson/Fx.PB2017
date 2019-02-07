$PBExportHeader$w_label_torca_tenneco_bt.srw
forward
global type w_label_torca_tenneco_bt from Window
end type
end forward

global type w_label_torca_tenneco_bt from Window
int X=1394
int Y=456
int Width=2062
int Height=1288
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_label_torca_tenneco_bt w_label_torca_tenneco_bt

type prototypes
FUNCTION long RunWait(string command, long winstate) LIBRARY "runwait.dll"
end prototypes

event open;st_generic_structure stParm
stParm= Message.PowerObjectParm


///////////////////////////////
// Declaration
//


long serial
long labelQuantity
string labelLocation = "K:\Label\Bartender\Tenneco_New.btw"


serial = Long(stParm.Value1)
labelQuantity = Long(stParm.Value11)


RUNWAIT ("C:\Program Files\Seagull\BarTender 7.00\Enterprise\bartend.exe /F=" + labelLocation + " /?Serial=" + string(serial) +  " /C=" + string(labelQuantity) + " /P /X", 1)


close (this)
end event
on w_label_torca_tenneco_bt.create
end on

on w_label_torca_tenneco_bt.destroy
end on

