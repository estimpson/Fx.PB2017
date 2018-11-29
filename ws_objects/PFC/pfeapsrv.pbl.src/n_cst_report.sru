$PBExportHeader$n_cst_report.sru
forward
global type n_cst_report from n_cst_winsrv
end type
type st_reportproperties from structure within n_cst_report
end type
end forward

type st_reportproperties from structure
	string		reporttype
	string		object_name
	string		library_name
	string		preview
	string		print_setup
	string		printer
	real		copies
	string		xlabel_format
	string		datasource
	string		datasource_library_name
	string		datasource_dw_name
end type

global type n_cst_report from n_cst_winsrv
end type
global n_cst_report n_cst_report

type prototypes
FUNCTION long SWAPI_LP_Initialize ( long p_ParentWindow, ref string p_BaseDirectory, ref string p_ProductInfoFileName, ref string p_DriverDirectory, ref string p_LanguageDirectory, ref string p_MediaDirectory, ref string p_DriverInfFileName, ref string p_ConnectFileName, ref string p_HelpFileName, ref string p_PasswordFileName, ref string p_QueueFileName) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_Initialize;Ansi"
FUNCTION long SWAPI_LP_Terminate ( ) LIBRARY "SWLPRT32.DLL"
FUNCTION long SWAPI_LP_StartPrintJob ( ref string p_QdfName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_StartPrintJob;Ansi"
FUNCTION long SWAPI_LP_SetDupCount ( ulong p_DupCount) LIBRARY "SWLPRT32.DLL"
FUNCTION long SWAPI_LP_LoadLabelFile ( ref string p_LabelFileName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_LoadLabelFile;Ansi"
FUNCTION long SWAPI_LP_ChangeDbfFileName ( ref string p_DbfName, ref string p_NewDbfFileName ) LIBRARY "SWLPRT32.DLL" alias for "SWAPI_LP_ChangeDbfFileName;Ansi"
end prototypes

type variables
Public:

constant integer	PRINT = 1
constant integer	PRINTCANCEL = 0
constant integer	REPORTNOTFOUND = -1
constant integer	INVALIDXTRN = -2
constant integer	INVALIDDW = -3
constant integer	NODATA = -4
constant integer	INVALIDXTRNFUS = -5
constant integer	FUSIONNOINIT = -6
constant integer	FUSIONNODUP = -7
constant integer	FUSIONNOPRINT = -8
constant integer	FUSIONNOTRM = -9

Private:

constant integer	DATAWINDOWREPORT = 1
constant integer	COMPILEDDATAWINDOWREPORT = 2
constant integer	WINDOWREPORT = 3
constant integer	FUSIONREPORT = 4

string	OBJECTTYPE [ 4 ] = { "DATAWINDOW", "CONSTANTDATAWINDOW", "WINDOW", "FUSION" }

end variables

forward prototypes
private function integer of_getreportnames (string as_report, ref string as_name[])
private function integer of_getreportproperties (string as_name, string as_report, ref n_cst_associative_array ancst_reportproperties)
public subroutine of_retrievepreview (any aa_arg1, any aa_arg2)
protected function integer of_printwindow (string as_windowname, any aa_arg1, any aa_arg2, integer ai_copies, string as_reportname)
protected function integer of_printuncompileddw (string as_libraryname, string as_dwname, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname)
protected function integer of_printcompileddw (string as_dwname, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname)
protected function integer of_printdw (ref datastore ads_report, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname)
protected function integer of_printfusionlabel (string as_datasourcename, string as_datasourcelibraryname, string as_datasourcedwname, string as_labelformat, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview)
public function integer of_printrpt (ref n_cst_associative_array anv_printparameters)
public function integer of_print (ref n_cst_associative_array anv_printparm)
public function integer getreportdw (n_cst_associative_array reportparms, ref datawindow dwreport)
public function integer getreportds (n_cst_associative_array reportparms, ref datastore dsreport)
end prototypes

private function integer of_getreportnames (string as_report, ref string as_name[]);
//	Description:
//
//	Syntax:
//	of_GetReportNames ( report, * names [ ] )
//
//	Arguments:
//	report		The name of the report to get the names for.
//	names		A pointer to an array of names.
//
//	Return Value:
//	Integer.  Returns 1 if the function succeeds and -1 if an error occurs.

//	Declarations.
integer	li_ReturnValue = 0
integer	li_Retrieve

DataStore	lds_Names

//	Create datastore
lds_Names = create DataStore

//	Set DataObject for Names
lds_Names.DataObject = "d_report_names"

//	SetTransObject.
lds_Names.SetTransObject ( SQLCA )

//	Retrieve names.
li_Retrieve = lds_Names.Retrieve ( as_Report )

//	Set ReturnValue
choose case li_Retrieve
	case -1
		li_ReturnValue = -1
	case 0
		li_ReturnValue = 100
	case else
		li_ReturnValue = 0
		
		//	Assign Names.
		as_Name = lds_Names.object.name.Primary
end choose

//	Destroy datastore
destroy lds_Names

//	Return.
return li_ReturnValue
end function

private function integer of_getreportproperties (string as_name, string as_report, ref n_cst_associative_array ancst_reportproperties);
//	Description:
//
//	Syntax:
//	of_GetReportProperties ( name, report, reportproperties )
//
//	Arguments:
//	name				The name of the report to get the properties of.
//	report				The report type to get the properties of.
//	reportproperties	An array to hold property values.
//
//	Return Value:
//	Integer.  Returns 0 if the function succeeds, 100 if no report is found,
//	and -1 if an error occurs.

//	Declarations.
integer	li_ReturnValue = 0
integer	li_Retrieve

DataStore	lds_Properties

st_reportproperties	lst_Properties [ ]

//	Create datastore
lds_Properties = create DataStore

//	Set DataObject for Properties
lds_Properties.DataObject = "d_report_properties"

//	SetTransObject.
lds_Properties.SetTransObject ( SQLCA )

//	Retrieve Properties.
li_Retrieve = lds_Properties.Retrieve ( as_Name, as_Report )

//	Set ReturnValue
choose case li_Retrieve
	case -1
		li_ReturnValue = -1
	case 0
		li_ReturnValue = 100
	case else
		li_ReturnValue = 0
		
		//	Assign Properties.
		lst_Properties = lds_Properties.object.data.primary
		ancst_ReportProperties.of_SetItem ( "ObjectName", lst_Properties [ 1 ].object_name )
		ancst_ReportProperties.of_SetItem ( "LibraryName", lst_Properties [ 1 ].library_name )
		ancst_ReportProperties.of_SetItem ( "Preview", ( lst_Properties [ 1 ].preview <> 'N' ) )
		ancst_ReportProperties.of_SetItem ( "Setup", ( lst_Properties [ 1 ].print_setup <> 'N' ) )
		ancst_ReportProperties.of_SetItem ( "Printer", lst_Properties [ 1 ].printer )
		ancst_ReportProperties.of_SetItem ( "Copies", lst_Properties [ 1 ].copies )
		
		//	Assign type.
		choose case lst_Properties [ 1 ].reporttype
			case 'D'
				ancst_ReportProperties.of_SetItem ( "Type", DATAWINDOWREPORT )
			case 'C'
				ancst_ReportProperties.of_SetItem ( "Type", COMPILEDDATAWINDOWREPORT )
			case 'W'
				ancst_ReportProperties.of_SetItem ( "Type", WINDOWREPORT )
			case 'F'
				ancst_ReportProperties.of_SetItem ( "Type", FUSIONREPORT )
				
				//	Assign Fusion Properties.
				ancst_ReportProperties.of_SetItem ( "DataSource", lst_Properties [ 1 ].datasource )
				ancst_ReportProperties.of_SetItem ( "XLabelFormat", lst_Properties [ 1 ].xlabel_format )
				ancst_ReportProperties.of_SetItem ( "DataSourceLibraryName", lst_Properties [ 1 ].datasource_library_name )
				ancst_ReportProperties.of_SetItem ( "DataSourceDWName", lst_Properties [ 1 ].datasource_dw_name )
		end choose
end choose

//	Destroy datastore
destroy lds_Properties

//	Return.
return li_ReturnValue
end function

public subroutine of_retrievepreview (any aa_arg1, any aa_arg2);
//	Retrieve preview window's report.
//	Retrieve Report and check for success.
w_print_preview.dw_report.SetTransObject ( SQLCA )
w_print_preview.dw_report.Retrieve ( aa_Arg1, aa_Arg2 )

end subroutine

protected function integer of_printwindow (string as_windowname, any aa_arg1, any aa_arg2, integer ai_copies, string as_reportname);

//	Transform argument to generic structure for backward compatibility.
st_generic_structure	lst_Parm

lst_Parm.Value1 = String (aa_Arg1)
lst_Parm.Value2 = String (aa_Arg2)
lst_Parm.Value11 = String (ai_Copies)
lst_Parm.Value12 = as_ReportName

//	Print Report.
window	lw_Report
ClassDefinition lcd_Report
lcd_Report = FindClassDefinition(as_WindowName)
if IsValid (lcd_Report) then
	int returnValue
	returnValue = OpenWithParm (lw_Report, lst_Parm, as_WindowName)
	return SUCCESS
else
	return FAILURE
end if


end function

protected function integer of_printuncompileddw (string as_libraryname, string as_dwname, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname);
//	Create Report from syntax.
datastore lds_Report; lds_Report = create DataStore
string ls_Syntax; ls_Syntax = LibraryExport (as_LibraryName, as_DWName, ExportDataWindow!)
string ls_Error
lds_Report.Create (ls_Syntax, ls_Error)

//	Check creation success.
if ls_Error > "" then
	//	Error occurred, invalid external datawindow.
	return INVALIDXTRN
else
	lds_Report.SetTransObject (SQLCA)
end if

return of_PrintDW (lds_Report, aa_Arg1, aa_Arg2, ai_Copies, ab_PrintPreview, as_PrintJobName)

end function

protected function integer of_printcompileddw (string as_dwname, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname);
//	Create Report from syntax.
datastore lds_Report; lds_Report = create DataStore
lds_Report.DataObject = as_DWName
if lds_Report.SetTransObject (SQLCA) = -1 then
	//	Error occurred, invalid compiled datawindow.
	return INVALIDDW
end if

return of_PrintDW (lds_Report, aa_Arg1, aa_Arg2, ai_Copies, ab_PrintPreview, as_PrintJobName)

end function

protected function integer of_printdw (ref datastore ads_report, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview, string as_printjobname);
//	Retrieve Report and check for success.
if ads_Report.Retrieve (aa_Arg1, aa_Arg1) <= 0 then
	//	Attempt to retrieve with string data for backward compatability.
	aa_Arg1 = String (aa_Arg1)
	aa_Arg2 = String (aa_Arg2)
	
	if ads_Report.Retrieve (aa_Arg1, aa_Arg2) <= 0 then
		
		//	Error occurred, no data returned.
		destroy ads_Report
		return NODATA
	end if
end if

//	Check preview.
if ab_PrintPreview then
	
	//	Post preview retrieve.  The posted function executes after the
	//	open script of w_print_preview.
	post of_RetrievePreview (aa_Arg1, aa_Arg2)
	
	//	Open preview.
	OpenWithParm (w_print_preview, ads_Report)
	
	//	Check if print was cancelled.
	if Message.DoubleParm = PRINTCANCEL then
		destroy ads_Report
		return PRINTCANCEL
	end if
end if

//	Print Report.
long ll_PrintJob; ll_PrintJob = PrintOpen (as_PrintJobName)
integer li_PrintCopy
for li_PrintCopy = 1 to ai_Copies
	PrintDataWindow (ll_PrintJob, ads_Report)
next
PrintClose (ll_PrintJob)
destroy ads_Report
return SUCCESS

end function

protected function integer of_printfusionlabel (string as_datasourcename, string as_datasourcelibraryname, string as_datasourcedwname, string as_labelformat, any aa_arg1, any aa_arg2, integer ai_copies, boolean ab_printpreview);
//	Create Report from syntax
datastore lds_Report; lds_Report = create DataStore
string ls_Syntax; ls_Syntax = LibraryExport (as_DataSourceLibraryName, as_DataSourceDWName, ExportDataWindow!)
string ls_Error; lds_Report.Create (ls_Syntax, ls_Error)

//	Check creation success.
if ls_Error > "" then
	
	//	Error occurred, invalid external datawindow.
//	li_ReturnValue = INVALIDXTRNFUS
//	return li_ReturnValue
else
	lds_Report.SetTransObject (SQLCA)
end if

//	Retrieve Report and check for success.
if lds_Report.Retrieve (aa_Arg1, aa_Arg2) <= 0 then
	
	//	Attempt to retrieve with string data for backward compatability.
	if lds_Report.Retrieve (String (aa_Arg1), String (aa_Arg2)) <= 0 then
		
		//	Error occurred, no data returned.
		return NODATA
	end if
end if

//	Check preview.
if ab_PrintPreview then
	
	//	Open preview.
	OpenWithParm (w_print_preview, lds_Report)
	
	//	Check if print was cancelled.
	if Message.DoubleParm = PRINTCANCEL then
		return PRINTCANCEL
	end if
end if

//	Generate data.
lds_Report.SaveAs (monsys.root + "\" + as_DataSourceName + ".dbf", dbase3!, true)

//	Print Report using Label Matrix Fusion API calls.
long	ll_ReturnFusion
long	ll_Null; SetNull (ll_Null)
string	ls_Null; SetNull (ls_Null)
if SWAPI_LP_Initialize (ll_null, monsys.root, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null, ls_null) = 0 then
	if SWAPI_LP_SetDupCount (ai_Copies) = 0 then
		if SWAPI_LP_StartPrintJob (as_LabelFormat) = 0 then
			if SWAPI_LP_Terminate () <> 0 then
				//	Unable to terminate the print job.
				MessageBox (gnv_App.iapp_Object.DisplayName, "Unable to terminate the print job! ~r~nReason:" + String (ll_ReturnFusion))
				return FUSIONNOTRM
			end if
		else			
			//	Unable to start the print job.
			MessageBox (gnv_App.iapp_Object.DisplayName, "Unable to start the print job! ~r~nReason:" + String (ll_ReturnFusion))
			return FUSIONNOPRINT
		end if
	else
		
		//	Unable to set the number of duplicates.
		MessageBox (gnv_App.iapp_Object.DisplayName, "Unable to set the number of duplicates! ~r~nReason:" + String (ll_ReturnFusion))
		return FUSIONNODUP
	end if
else
	
	//	Unable to initiate the print job.
	MessageBox (gnv_App.iapp_Object.DisplayName, "Unable to initiate the print job! ~r~nReason:" + String (ll_ReturnFusion))
	return FUSIONNOINIT
end if

return SUCCESS
end function

public function integer of_printrpt (ref n_cst_associative_array anv_printparameters);
//	Description:
//	Print a Monitor Report 
//
//	Syntax:
//	Print (* MonitorReportParm)
//
//	Arguments:
//	MonitorReportParm	An associative array containing retrieval arguments and report and
//						report name.
//
//	Return Value:
//	Returns 1 if it succeeds, FAILURE if an error occurs.

//	Declarations.
integer	li_ReturnValue

//	Call print function for report.
li_ReturnValue = of_Print (anv_PrintParameters)

//	Display error code
choose case li_ReturnValue
	case PRINT
	case PRINTCANCEL
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Print cancelled.")
	case REPORTNOTFOUND
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Report not found.")
	case INVALIDXTRN
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Invalid external DataWindow or DataWindow not found.")
	case INVALIDDW
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Compiled DataWindow not found.")
	case NODATA
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "No data retrieved.  Check report.")
	case INVALIDXTRNFUS
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Invalid external DataWindow or DataWindow not found for fusion.")
	case FUSIONNOINIT
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Fusion error.")
	case FUSIONNODUP
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Fusion error.")
	case FUSIONNOPRINT
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Fusion error.")
	case FUSIONNOTRM
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Fusion error.")
	case else
		li_ReturnValue = FAILURE
		MessageBox (gnv_App.iapp_Object.DisplayName, "Unknown or unspecified error while printing.")
end choose

//	Return.
return li_ReturnValue

end function

public function integer of_print (ref n_cst_associative_array anv_printparm);
//	Description:
//	Print a Monitor Report 
//
//	Syntax:
//	Print (* MonitorReportParm)
//
//	Arguments:
//	MonitorReportParm	An associative array containing retrieval arguments and report and
//				report name.
//
//	Return Value:
//	returns 1 if it succeeds, 0 if print was cancelled, error code if an error occurs.
//
//	Error Codes:
//	-1	REPORTNOTFOUND	Report not found.
//	-2	INVALIDXTRN	Invalid external (uncompiled) datawindow.
//	-3	INVALIDDW	Invalid [compiled] datawindow.
//	-4	NODATA		No data returned.
//	-5	INVALIDXTRNFUS	Invalid external (uncompiled) datawindow for fusion printing.
//	-6	FUSIONNOINIT	Unable to initiate fusion print job.
//	-7	FUSIONNODUP	Unable to set the number of fusion duplicates.
//	-8	FUSIONNOPRINT	Unable to start fusion print job.
//	-9	FUSIONNOTRM	Unable to terminate fusion print job.

//	Declarations.
string	ls_AllNames []

n_cst_associative_array	lnv_ReportProperties

//	Get the report and report name.
string ls_Report; ls_Report = String (anv_PrintParm.of_GetItem ("Report"))
string ls_Name; ls_Name = IsNull (String (anv_PrintParm.of_GetItem ("Name")), "")
any la_Arg1; la_Arg1 = IsNull (anv_PrintParm.of_GetItem ("Arg1"), 0)
any la_Arg2; la_Arg2 = IsNull (anv_PrintParm.of_GetItem ("Arg2"), 0)
string	ls_PrintJobName; ls_PrintJobName = ls_Report + "\" + ls_Name + "\" + String (la_Arg1)

//	Look for printing redirect.
if IsValid (iw_requestor) then
	if IsValid (iw_requestor.inv_RemoteLabelLibrary) then
		la_Arg1 = IsNull (anv_PrintParm.of_GetItem ("Arg1"), 0)
		la_Arg2 = IsNull (anv_PrintParm.of_GetItem ("Arg2"), 0)
		return iw_requestor.inv_RemoteLabelLibrary.of_Print (ls_Report + "," + ls_Name + "," + string (la_Arg1) + "," + string (la_Arg2))
	end if
end if

//	Check if Name was specified.
if not (ls_Name > "") then
	
	//	Determine if list of names needs to be displayed.
	of_GetReportNames (ls_Report, ls_AllNames)
	
	choose case UpperBound (ls_AllNames)
		case 0
			//	Error occurred, no report of requested type.
			return REPORTNOTFOUND
		case 1
			//	Only one report of type, print it.
			ls_Name = ls_AllNames [1]
		case else
			//	Display list of reports for selection.
			ls_Name = ls_AllNames [1]
	end choose
end if

//	Get report properties.
if of_GetReportProperties (ls_Name, ls_Report, lnv_ReportProperties) <> 0 then
	
	//	Error occurred, no report of requested type.
	return REPORTNOTFOUND
end if

//	Read report properties.
integer	li_ReportType; li_ReportType = Integer (lnv_ReportProperties.of_GetItem ("Type"))
integer li_PrintCopies; li_PrintCopies = lnv_ReportProperties.of_GetItem ("Copies")
boolean lb_PrintPreview; lb_PrintPreview = IsNull (lnv_ReportProperties.of_GetItem ("Preview"), false)
boolean lb_PrintSetup; lb_PrintSetup = IsNull (lnv_ReportProperties.of_GetItem ("Setup"), false)
string	ls_ObjectName; ls_ObjectName = String (lnv_ReportProperties.of_GetItem ("ObjectName"))
string	ls_LibraryName; ls_LibraryName = String (lnv_ReportProperties.of_GetItem ("LibraryName"))

//	Check print setup.
if lb_PrintSetup then
	PrintSetup ()
end if

choose case li_ReportType
	case DATAWINDOWREPORT
		if of_PrintUncompiledDW (ls_LibraryName, ls_ObjectName, la_Arg1, la_Arg2, li_PrintCopies, lb_PrintPreview, ls_PrintJobName) <> SUCCESS then return FAILURE
	case COMPILEDDATAWINDOWREPORT
		if of_PrintCompiledDW (ls_ObjectName, la_Arg1, la_Arg2, li_PrintCopies, lb_PrintPreview, ls_PrintJobName) <> SUCCESS then return FAILURE
	case WINDOWREPORT
		if of_PrintWindow (ls_ObjectName, la_Arg1, la_Arg2, li_PrintCopies, ls_Name) <> SUCCESS then return FAILURE
	case FUSIONREPORT
		string ls_DataSourceLibraryName; ls_DataSourceLibraryName = String (lnv_ReportProperties.of_GetItem ("DataSourceLibraryName"))
		string ls_DataSourceDWName; ls_DataSourceDWName = String (lnv_ReportProperties.of_GetItem ("DataSourceDWName"))
		string ls_DataSourceName; ls_DataSourceName = lnv_ReportProperties.of_GetItem ("DataSource")
		string ls_XLabelFormat; ls_XLabelFormat = lnv_ReportProperties.of_GetItem ("XLabelFormat")

		if of_PrintFusionLabel (ls_LibraryName, ls_ObjectName, ls_DataSourceName, ls_XLabelFormat, la_Arg1, la_Arg2, li_PrintCopies, lb_PrintPreview) <> SUCCESS then return FAILURE
end choose

//	return.
return PRINT

end function

public function integer getreportdw (n_cst_associative_array reportparms, ref datawindow dwreport);
//	Get the report and report name.
string reportType; reportType = String (reportParms.of_GetItem ("Report"))
string reportName; reportName = IsNull (String (reportParms.of_GetItem ("Name")), "")
any reportArg1; reportArg1 = IsNull (reportParms.of_GetItem ("Arg1"), 0)
any reportArg2; reportArg2 = IsNull (reportParms.of_GetItem ("Arg2"), 0)

//	Check if Name was specified.
if	not (reportName > "") then
	
	//	Determine if list of names needs to be displayed.
	string allReportNames []
	of_GetReportNames (reportType, allReportNames)
	
	choose case UpperBound (allReportNames)
		case 0
			//	Error occurred, no report of requested type.
			return REPORTNOTFOUND
		case 1
			//	Only one report of type, print it.
			reportName = allReportNames [1]
		case else
			//	Display list of reports for selection.
			reportName = allReportNames [1]
	end choose
end if

//	Get report properties.
n_cst_associative_array	reportProperties
if	of_GetReportProperties (reportName, reportType, reportProperties) <> 0 then
	
	//	Error occurred, no report of requested type.
	return REPORTNOTFOUND
end if

//	Read report properties.
integer reportSourceType; reportSourceType = Integer (reportProperties.of_GetItem ("Type"))
integer printCopies; printCopies = reportProperties.of_GetItem ("Copies")
string	reportObjectName; reportObjectName = String (reportProperties.of_GetItem ("ObjectName"))
string	libraryName; libraryName = String (reportProperties.of_GetItem ("LibraryName"))

choose case reportSourceType
	case COMPILEDDATAWINDOWREPORT
		dwReport.dataobject = reportObjectName
	case DATAWINDOWREPORT
		//	Create Report from syntax.
		string dwSyntax; dwSyntax = LibraryExport (libraryName, reportObjectName, ExportDataWindow!)
		string createError
		dwReport.Create (dwSyntax, createError)
		
		//	Check creation success.
		if createError > "" then
			//	Error occurred, invalid external datawindow.
			return INVALIDXTRN
		end if
	case else
		return REPORTNOTFOUND
end choose

if	dwReport.SetTransObject (SQLCA) = -1 then
	//	Error occurred, invalid compiled datawindow.
	return INVALIDDW
end if

if	dwReport.Retrieve(reportArg1, reportArg2) <= 0 then
	dwReport.Retrieve(String(reportArg1), String(reportArg2))
end if

return SUCCESS

end function

public function integer getreportds (n_cst_associative_array reportparms, ref datastore dsreport);
//	Get the report and report name.
string reportType; reportType = String (reportParms.of_GetItem ("Report"))
string reportName; reportName = IsNull (String (reportParms.of_GetItem ("Name")), "")
any reportArg1; reportArg1 = IsNull (reportParms.of_GetItem ("Arg1"), 0)
any reportArg2; reportArg2 = IsNull (reportParms.of_GetItem ("Arg2"), 0)

//	Check if Name was specified.
if	not (reportName > "") then
	
	//	Determine if list of names needs to be displayed.
	string allReportNames []
	of_GetReportNames (reportType, allReportNames)
	
	choose case UpperBound (allReportNames)
		case 0
			//	Error occurred, no report of requested type.
			return REPORTNOTFOUND
		case 1
			//	Only one report of type, print it.
			reportName = allReportNames [1]
		case else
			//	Display list of reports for selection.
			reportName = allReportNames [1]
	end choose
end if

//	Get report properties.
n_cst_associative_array	reportProperties
if	of_GetReportProperties (reportName, reportType, reportProperties) <> 0 then
	
	//	Error occurred, no report of requested type.
	return REPORTNOTFOUND
end if

//	Read report properties.
integer reportSourceType; reportSourceType = Integer (reportProperties.of_GetItem ("Type"))
integer printCopies; printCopies = reportProperties.of_GetItem ("Copies")
string	reportObjectName; reportObjectName = String (reportProperties.of_GetItem ("ObjectName"))
string	libraryName; libraryName = String (reportProperties.of_GetItem ("LibraryName"))

choose case reportSourceType
	case COMPILEDDATAWINDOWREPORT
		dsReport.dataobject = reportObjectName
	case DATAWINDOWREPORT
		//	Create Report from syntax.
		string dwSyntax; dwSyntax = LibraryExport (libraryName, reportObjectName, ExportDataWindow!)
		string createError
		dsReport.Create (dwSyntax, createError)
		
		//	Check creation success.
		if createError > "" then
			//	Error occurred, invalid external datawindow.
			return INVALIDXTRN
		end if
	case else
		return REPORTNOTFOUND
end choose

if	dsReport.SetTransObject (SQLCA) = -1 then
	//	Error occurred, invalid compiled datawindow.
	return INVALIDDW
end if

if	dsReport.Retrieve(reportArg1, reportArg2) <= 0 then
	dsReport.Retrieve(String(reportArg1), String(reportArg2))
end if

return SUCCESS

end function

on n_cst_report.create
call super::create
end on

on n_cst_report.destroy
call super::destroy
end on

