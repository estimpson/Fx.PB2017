$PBExportHeader$n_setup_defectcodes_controller.sru
forward
global type n_setup_defectcodes_controller from n_cst_virtual_controller
end type
end forward

global type n_setup_defectcodes_controller from n_cst_virtual_controller
end type
global n_setup_defectcodes_controller n_setup_defectcodes_controller

type variables

private:

//	Model data.

//	View references.
u_panel_leftright _listViewAndPropertiesSplitView
u_tabpg_setup_defectcodes _defectCodesListView
u_tabpg_browser _defectPropertiesView

w_setup_defectcodes _parentSheet

//	Data context.
n_setup_defectcodes_trans _setupDefectCodesTrans

end variables

forward prototypes
public function integer showcontrols ()
public function integer createlayout ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showimagefile (string imagefilename)
public function integer selectimagefile (string defectcode)
public function integer browsernavigate (string url)
public function integer printdefectlabel (long rowid)
end prototypes

public function integer showcontrols ();
_parentSheet.uo_1.ShowControl(_listViewAndPropertiesSplitView)
_listViewAndPropertiesSplitView.uo_1.ShowControl(_defectCodesListView)
_listViewAndPropertiesSplitView.uo_2.ShowControl(_defectPropertiesView)

return SUCCESS

end function

public function integer createlayout ();
//	Details / properties split view.
_parentSheet.OpenUserObject(_listViewAndPropertiesSplitView, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_listViewAndPropertiesSplitView)

//	Defect codes list view
_parentSheet.OpenUserObject(_defectCodesListView, "u_tabpg_setup_defectcodes")
_listViewAndPropertiesSplitView.uo_1.AddPanelControl(_defectCodesListView)
MasterListControl = _defectCodesListView

 //	Defect properties browser view
_parentSheet.OpenUserObject(_defectPropertiesView, "u_tabpg_browser")
_listViewAndPropertiesSplitView.uo_2.AddPanelControl(_defectPropertiesView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

//	Link up frame controller for control of scanning.
GetFrameController()

return SUCCESS

end function

public function integer showimagefile (string imagefilename);
return BrowserNavigate(imageFileName)

end function

public function integer selectimagefile (string defectcode);
string categoryName, categoryDescription, defaultExtensions, searchPattern, newDocumentPath, newDocumentName
categoryName = "Image"
_setupDefectCodesTrans.GetCatDetails_forDefectCodeAttachmentCat("Image", categoryDescription, defaultExtensions)
searchPattern = isnull("All " + CategoryName + "s (" + defaultExtensions + ")," + defaultExtensions + ",All Files (*.*),*.*", "All Files (*.*),*.*")

string filePath, fileName
integer li_rtn

string	lastKnownPath = "C:\Users\estimpson.FORE-THOUGHT\Pictures\Fore-Thought"
if	GetFileOpenName("Select Part Image", filePath, fileName, "", searchPattern, lastKnownPath, 2^1 + 2^6 + 2^8 + 2^14) = 1 then
	//	Tell browser to the selected image.
	BrowserNavigate(filePath)
	
	//	Get the attachment upload path.
	string uploadPath
	if	_setupDefectCodesTrans.GetUploadPath(uploadPath) <> SUCCESS then
		return FAILURE
	end if
	
	//	Copy file to upload path.
	if	FileCopy(filePath, uploadPath + "\" + fileName) <> SUCCESS then
		MsgBox("filecopyfailed")
		return FAILURE
	end if
	
	//	Create attachment.
	string attachmentName
	if	_setupDefectCodesTrans.AttachDocument(defectCode, fileName, filePath, "Defect Image", categoryName, attachmentName) <> SUCCESS then
		return FAILURE
	end if
	_setupDefectCodesTrans.CommitTrans()

	MsgBox("File " + fileName + " attached as " + categoryName + ".")
end if

return Refresh()

end function

public function integer browsernavigate (string url);
if	not IsValid(_defectPropertiesView) then
	return FAILURE
end if

//	Navigate the browser.
_defectPropertiesView.uo_browser.Navigate(URL)
return SUCCESS

end function

public function integer printdefectlabel (long rowid);
string labelFormat = "Defect Label"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", rowID)
printerParm.of_SetItem ( "Report", "Defect Label" )
printerParm.of_SetItem ( "Name", labelFormat )
return Print(printerParm)

end function

on n_setup_defectcodes_controller.create
call super::create
end on

on n_setup_defectcodes_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_setupDefectCodesTrans = create n_setup_defectcodes_trans

end event

event destructor;call super::destructor;
destroy _setupDefectCodesTrans

end event

