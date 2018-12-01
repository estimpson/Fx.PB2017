$PBExportHeader$w_tsm_printlabel.srw
forward
global type w_tsm_printlabel from window
end type
end forward

global type w_tsm_printlabel from window
integer width = 4754
integer height = 1980
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
global w_tsm_printlabel w_tsm_printlabel

forward prototypes
public function integer getlabelcode (long boxserial, string labelname, string printertype, integer numberoflabels, ref string labelcode, ref long procresult)
end prototypes

public function integer getlabelcode (long boxserial, string labelname, string printertype, integer numberoflabels, ref string labelcode, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare	GetLabeCode procedure for FT.usp_GetLabelCode
	@Serial = :boxSerial
,	@LabelName = :labelName
,	@PrinterType = :printerType
,	@NumberOfLabels = :numberOfLabels
,	@LabelCode = :labelCode output
,	@Result =:procResult output using SQLCA  ;

execute GetLabeCode  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get label data:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return -1
end if

//	Get the order number created and/or the result of the stored procedure.
fetch
	GetLabeCode
into
	:labelCode
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get label data:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return -1
end if

//	Close procedure and commit.
close GetLabeCode  ;
SQLCA.of_Commit()

//	Return.
return 1

end function

event open;
st_generic_structure stParm
stParm = Message.PowerObjectParm

//datastore aaData
//aaData = create datastore
//aaData.dataObject = "d_getlabeldata"
//aaData.SetTransObject(SQLCA)
//
//long printHandle
//string labelData
//if	aaData.Retrieve(Long(stParm.Value1), stParm.Value12, "SATO", LONG(stParm.Value11)) = 1 then
//	labelData = aaData.object.labeldata[1]
//	
//	commit  ;
//	
//	printHandle = PrintOpen()
//	PrintSend (printHandle, labelData)
//	PrintClose (printHandle)
//end if

long printHandle, procResult
string labelData
if	GetLabelCode(Long(stParm.Value1), stParm.Value12, "SATO", LONG(stParm.Value11), labelData, procResult) = 1 then
	
	printHandle = PrintOpen()
	PrintSend (printHandle, labelData)
	PrintClose (printHandle)
end if

close(This)

end event

on w_tsm_printlabel.create
end on

on w_tsm_printlabel.destroy
end on

