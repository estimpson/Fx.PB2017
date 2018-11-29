$PBExportHeader$w_fusion_label_print.srw
forward
global type w_fusion_label_print from Window
end type
end forward

global type w_fusion_label_print from Window
int X=1317
int Y=664
int Width=1650
int Height=1000
boolean Visible=false
boolean TitleBar=true
string Title="Label Print"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
end type
global w_fusion_label_print w_fusion_label_print

type prototypes
FUNCTION long SWAPI_LP_Initialize ( long p_ParentWindow, ref string p_BaseDirectory, ref string p_ProductInfoFileName, ref string p_DriverDirectory, ref string p_LanguageDirectory, ref string p_MediaDirectory, ref string p_DriverInfFileName, ref string p_ConnectFileName, ref string p_HelpFileName, ref string p_PasswordFileName, ref string p_QueueFileName) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_Initialize;Ansi"
FUNCTION long SWAPI_LP_Terminate ( ) LIBRARY "SWLPRT32.DLL"
FUNCTION long SWAPI_LP_StartPrintJob ( ref string p_QdfName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_StartPrintJob;Ansi"
FUNCTION long SWAPI_LP_SetDupCount ( ulong p_DupCount) LIBRARY "SWLPRT32.DLL"
FUNCTION long SWAPI_LP_LoadLabelFile ( ref string p_LabelFileName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_LoadLabelFile;Ansi"
FUNCTION long SWAPI_LP_ChangeDbfFileName ( ref string p_DbfName, ref string p_NewDbfFileName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_ChangeDbfFileName;Ansi"
end prototypes

on w_fusion_label_print.create
end on

on w_fusion_label_print.destroy
end on

event open;ulong		li_Dups

long		ll_null
long		ll_return

string	ls_null
string	ls_LabelFormat
string	ls_Datasource
string	ls_XLabelFormat
string	ls_Library
string	ls_DWName
string	ls_DWSyntax
string	ls_CurrentDirectory
string	ls_DBFFile
string	ls_FusionRoot
string	ls_OriginalDBF

//constant string	FusionRegKey = "HKEY_LOCAL_MACHINE\SOFTWARE\Monitor Systems, Inc.\TMFMS\Fusion"
//constant string	FusionRegValue = "FusionRoot"

DataStore	lds_LabelData

//ListBox	llb_Directory

//StaticText	lst_CurrentDirectory

st_generic_structure	lst_Parms

lst_Parms = Message.PowerObjectParm
lds_LabelData = create DataStore

//	Get current directory.
//OpenUserObject ( llb_Directory, "ListBox" )
//OpenUserObject ( lst_CurrentDirectory, "StaticText" )
//llb_Directory.DirList ( "", 0, lst_CurrentDirectory )
//CloseUserObject ( llb_Directory )
//CloseUserObject ( lst_CurrentDirectory )

//	Get Fusion directory.
//if RegistryGet ( FusionRegKey, FusionRegValue, RegString!, ls_FusionRoot ) = -1 then
//	MessageBox ( monsys.msg_title, "Invalid or no registry entry for external label print module.", StopSign! )
//	destroy lds_LabelData
//	Close ( This )
//	return
//end if	

//  Get number of dups
li_Dups = IsNull ( Integer ( lst_Parms.Value11 ), 0 )

//  Get format name
ls_LabelFormat = lst_Parms.Value12

//	Get datasource name and external label format name for label.
SELECT	'\' + datasource,
		xlabelformat,
		library_name,
		dw_name
  INTO	:ls_Datasource,
  		:ls_XLabelFormat,
		:ls_Library,
		:ls_DWName
  FROM	xreport_library
  		JOIN xreport_datasource ON datasource = datasource_name
 WHERE	name = :ls_LabelFormat  ;

choose case SQLCA.SQLCode
	case 100
		MessageBox ( monsys.msg_title, "External label format setups incomplete for format " + ls_LabelFormat + ".  Return to parameters to verify settings.", StopSign! )
		destroy lds_LabelData
		Close ( this )
		return
	case -1
		MessageBox ( monsys.msg_title, "Database changes for external label formats not installed.  Run database upgrade scripts.", StopSign! )
		destroy lds_LabelData
		Close ( this )
		return
end choose

//  Generate data
ls_DWSyntax = LibraryExport ( ls_Library, ls_DWName, ExportDataWindow! )
if lds_LabelData.Create ( ls_DWSyntax ) <> 1 then
	MessageBox ( monsys.msg_title, "External label format setups incomplete or incorrect for format " + ls_LabelFormat + ".  Return to parameters to verify settings.", StopSign! )
	destroy lds_LabelData
	Close ( this )
	return
end if
lds_LabelData.SetTransObject ( SQLCA )
if lds_LabelData.Retrieve ( lst_Parms.Value1 ) > 0 then
//	ls_DBFFile = ls_CurrentDirectory + ls_Datasource + ".dbf"
	ls_DBFFile = monsys.root + ls_Datasource + ".dbf"
	lds_LabelData.SaveAs ( ls_DBFFile, dBASE3!, true )
//	ls_DBFFile = ls_FusionRoot + ls_Datasource + ".dbf"
//	lds_LabelData.SaveAs ( ls_DBFFile, dBASE3!, true )
else
	MessageBox ( monsys.msg_title, "Data unavailable to print label for serial:  " + lst_Parms.Value1 + ".  Check the DataWindow retrieval.", StopSign! )
	destroy lds_LabelData
	Close ( This )
	return
end if

SetNull ( ll_null )
SetNull ( ls_null )

// print label using label matrix fusion api calls
ll_return = SWAPI_LP_Initialize ( ll_null, monsys.root, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null )
if ll_return = 0 then
	ll_return = SWAPI_LP_SetDupCount ( li_Dups )
	if ll_return = 0 then
//		ll_Return = SWAPI_LP_LoadLabelFile ( ls_XLabelFormat )
//		if ll_return = 0 then
//			ls_OriginalDBF = Upper ( Right ( ls_Datasource, Len ( ls_Datasource ) - 1 ) )
//			ls_DBFFile = monsys.root + ls_DBFFile + '~"' //Left ( ls_DBFFile, Len ( ls_DBFFile ) - 4 )
//			ll_return = SWAPI_LP_ChangeDbfFileName ( ls_OriginalDBF, ls_DBFFile )
//			if ll_return = 0 then
//			if SWAPI_LP_ChangeDbfFileName ( ls_Datasource, Left ( ls_DBFFile, Len ( ls_DBFFile ) - 4 ) ) = 0 then
				ll_return = SWAPI_LP_StartPrintJob ( ls_XLabelFormat )
				if ll_return = 0 then
					ll_return = SWAPI_LP_Terminate ( )
					if ll_return <> 0 then
						MessageBox ( monsys.msg_title, "Unable to terminate the print job! ~r~nReason:" + String ( ll_return ) )
					end if
				else
					MessageBox ( monsys.msg_title, "Unable to start the print job! ~r~nReason:" + String ( ll_return ) )
				end if
//			else
//				MessageBox ( monsys.msg_title, "Unable to set the dbf file name! ~r~nReason:" + String ( ll_return ) )
//			end if
//		else
//			MessageBox ( monsys.msg_title, "Unable to load the label format! ~r~nReason:" + String ( ll_return ) )
//		end if
	else
		MessageBox ( monsys.msg_title, "Unable to set the number of duplicates! ~r~nReason:" + String ( ll_return ) )
	end if
else
	MessageBox ( monsys.msg_title, "Unable to initiate the print job! ~r~nReason:" + String ( ll_return ) )
end if

destroy lds_LabelData

Close ( This )
end event

