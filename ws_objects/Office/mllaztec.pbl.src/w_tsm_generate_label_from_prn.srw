$PBExportHeader$w_tsm_generate_label_from_prn.srw
forward
global type w_tsm_generate_label_from_prn from Window
end type
end forward

global type w_tsm_generate_label_from_prn from Window
int X=1051
int Y=468
int Width=2578
int Height=1536
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_tsm_generate_label_from_prn w_tsm_generate_label_from_prn

event open;
st_generic_structure stParm
stParm = Message.PowerObjectParm

datastore aaData
aaData = create datastore
aaData.dataObject = "d_americanaxledata"
aaData.SetTransObject(SQLCA)

long printHandle
string labelData
if	aaData.Retrieve(Long(stParm.Value1)) = 1 then
	labelData = aaData.object.labeldata[1]
	
	commit  ;
	
	printHandle = PrintOpen()
	PrintSend (printHandle, labelData)
	PrintClose (printHandle)
end if

destroy aaData
close(This)

end event

on w_tsm_generate_label_from_prn.create
end on

on w_tsm_generate_label_from_prn.destroy
end on

