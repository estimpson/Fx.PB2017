$PBExportHeader$w_tsm_printlabel.srw
forward
global type w_tsm_printlabel from Window
end type
end forward

global type w_tsm_printlabel from Window
int X=1051
int Y=468
int Width=1861
int Height=1132
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_tsm_printlabel w_tsm_printlabel

event open;
st_generic_structure stParm
stParm = Message.PowerObjectParm

datastore aaData
aaData = create datastore
aaData.dataObject = "d_getlabeldata"
aaData.SetTransObject(SQLCA)

long printHandle
string labelData
if	aaData.Retrieve(Long(stParm.Value1), stParm.Value12, "SATO", LONG(stParm.Value11)) = 1 then
	labelData = aaData.object.labeldata[1]
	
	commit  ;
	
	printHandle = PrintOpen()
	PrintSend (printHandle, labelData)
	PrintClose (printHandle)
end if

destroy aaData
close(This)

end event

on w_tsm_printlabel.create
end on

on w_tsm_printlabel.destroy
end on

