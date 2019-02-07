HA$PBExportHeader$u_tabpg_partmaster_editattachments.sru
forward
global type u_tabpg_partmaster_editattachments from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_partmaster_editattachments
end type
type cb_close from commandbutton within u_tabpg_partmaster_editattachments
end type
end forward

global type u_tabpg_partmaster_editattachments from u_tabpg_dw
integer width = 2304
cb_save cb_save
cb_close cb_close
end type
global u_tabpg_partmaster_editattachments u_tabpg_partmaster_editattachments

type variables

private string _partCode
private long _categoryEditRow

end variables

forward prototypes
public function integer setpart (string partcode)
public function integer setcategory (string categoryname)
public function integer refocuscategory ()
public function integer copycategorydetails (long row, string categoryname)
public function integer save ()
public subroutine close ()
end prototypes

public function integer setpart (string partcode);
//	Set part and refresh.
_partCode = partCode
return Refresh()

end function

public function integer setcategory (string categoryname);
if	_categoryEditRow < 1 or _categoryEditRow > dw_1.RowCount() then
	MessageBox("FYI", "Error setting category after category edit.")
end if

//	Retrieve category list drop down.
datawindowchild dwc
long dwcRow
if	dw_1.GetChild("CategoryName", dwc) < 1 then
	MessageBox("fyi", "Unable to get CategoryName datawindowchild.")
	return FAILURE
end if
dwc.SetTransObject(SQLCA)
dwc.Retrieve()

//	Copy values for the category.
CopyCategoryDetails(_categoryEditRow, categoryName)

_categoryEditRow = -1

return SUCCESS

end function

public function integer refocuscategory ();
if	_categoryEditRow < 1 or _categoryEditRow > dw_1.RowCount() then
	MessageBox("FYI", "Error refocusing category after category edit.")
end if

dw_1.SetRow(_categoryEditRow)
dw_1.Object.CategoryName[_categoryEditRow] = ""
dw_1.SetColumn("CategoryName")
_categoryEditRow = -1

return SUCCESS

end function

public function integer copycategorydetails (long row, string categoryname);
//	Copy the category description and default extensions from the selected category.
datawindowchild dwc
long dwcRow
if	dw_1.GetChild("CategoryName", dwc) < 1 then
	MessageBox("fyi", "Unable to get CategoryName datawindowchild.")
	return FAILURE
end if

dwcRow = dwc.Find("CategoryName='" + categoryName + "'", 1, dwc.RowCount())
	
if	dwcRow < 1 then
	return NO_ACTION
end if

//	Perform copy.
dw_1.Object.CategoryDescription[row] = dw_1.Object.CategoryName.Object.CategoryDescription[dwcRow]
dw_1.Object.DefaultExtensions[row] = dw_1.Object.CategoryName.Object.DefaultExtensions[dwcRow]
return SUCCESS

end function

public function integer save ();
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

//	End edits.
dw_1.AcceptText()

//	Iterate rows.
int userResponse
long i

//	Definition properties.
string categoryName, originalFileName, originalFilePath, fileDescription
string originalCategoryName, originalOriginalFileName, originalFileDescription

//	Validate.
for	i = 1 to dw_1.RowCount()
	
	categoryName = dw_1.Object.CategoryName[i]
	originalFileName = dw_1.Object.OriginalFileName[i]
	originalFilePath = dw_1.Object.OriginalFilePath[i]
	fileDescription = dw_1.Object.FileDescription[i]
	originalCategoryName = dw_1.Object.CategoryName.Original[i]
	originalOriginalFileName = dw_1.Object.OriginalFileName.Original[i]
	
	//	Confirm file changes.
	if	originalFileName > "" and originalOriginalFileName > "" and originalOriginalFileName <> originalFileName and categoryName > "" then
		userResponse = MessageBox(gnv_App.iapp_Object.DisplayName, "The file " + originalOriginalFileName + " will be discarded and replaced by " + originalFileName + ".", Question!, OkCancel!, 2)
		if	userResponse = 2 then
			return NO_ACTION
		end if
	end if
	
	//	Confirm category changes.
	if	originalCategoryName > "" and originalCategoryName <> categoryName and originalFileName > "" then
		userResponse = MessageBox(gnv_App.iapp_Object.DisplayName, "The category for " + originalFileName + " will be changed from " + originalCategoryName + " to " + categoryName + ".", Question!, OkCancel!, 2)
		if	userResponse = 2 then
			return NO_ACTION
		end if
	end if
	
	//	Confirm missing category.
	if	originalFileName > "" and IsNull(categoryName, "") = "" then
		userResponse = MessageBox(gnv_App.iapp_Object.DisplayName, "No category was assigned for " + originalFileName + ".  This image will be discarded.", Question!, OkCancel!, 2)
		if	userResponse = 2 then
			return NO_ACTION
		end if
	end if
	
	//	Confirm discarded attachments.
	if	IsNull(originalFileName, "") = "" and originalOriginalFileName > "" then
		userResponse = MessageBox(gnv_App.iapp_Object.DisplayName, "The currently attached file " + originalOriginalFileName + "will be discarded.", Question!, OkCancel!, 2)
		if	userResponse = 2 then
			return NO_ACTION
		end if
	end if
next

long	rowID
//	Validations completed.  Now save.
for	i = 1 to dw_1.RowCount()
	
	//	Save valid attachments definitions.
	categoryName = dw_1.Object.CategoryName[i]
	originalFileName = dw_1.Object.OriginalFileName[i]
	originalFilePath = dw_1.Object.OriginalFilePath[i]
	fileDescription = dw_1.Object.FileDescription[i]
	originalCategoryName = dw_1.Object.CategoryName.Original[i]
	originalOriginalFileName = dw_1.Object.OriginalFileName.Original[i]
	originalFileDescription = dw_1.Object.FileDescription.Original[i]
	rowID = dw_1.Object.RowID[i]
	
	//	Property change.
	if	((originalCategoryName > "" and originalCategoryName <> categoryName) or (fileDescription <> isnull(originalFileDescription, ""))) and originalFileName > "" then
		if	myController.ChangeAttachmentProperties(_partCode, rowID, categoryName, fileDescription) = SUCCESS then
			if	originalCategoryName > "" and originalCategoryName <> categoryName then
				MessageBox (gnv_App.iapp_Object.DisplayName, "Category changed for " + originalFileName + ".")
			end if
		end if
		continue
	end if
	
	//	New attachment.
	if	originalFileName > ""  and originalFileName <> isnull(originalOriginalFileName, "") and categoryName > "" then
		if	myController.NewAttachment(_partCode, originalFileName, originalFilePath, fileDescription, categoryName) = SUCCESS then
			MessageBox (gnv_App.iapp_Object.DisplayName, "File " + originalFileName + " attached as " + categoryName + ".")
		end if
		continue
	end if
	
	//	Discard attachment.
	if	IsNull(originalFileName, "") = "" and originalOriginalFileName > "" then
		if	myController.DiscardAttachment(_partCode, rowID) = SUCCESS then
			MessageBox (gnv_App.iapp_Object.DisplayName, "File " + originalFileName + " discarded.")
		end if
	end if
next

return SUCCESS

end function

public subroutine close ();
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

dw_1.Reset()
myController.EndEditAttachments()

end subroutine

on u_tabpg_partmaster_editattachments.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
end on

on u_tabpg_partmaster_editattachments.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_close, 100, 100, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_editattachments
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_editattachments
string dataobject = "d_partmaster_partattachmentlist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::itemchanged;call super::itemchanged;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case Upper(dwo.Name)
	case upper("CategoryName")
		if	IsNull(data, "") = "" then
			MessageBox(gnv_App.iapp_Object.DisplayName, "Enter a new category name.")
			return 2
		end if
		
		//	Copy the category description and default extensions from the selected category.
		if	CopyCategoryDetails(row, data) = NO_ACTION then
			if	MessageBox(gnv_App.iapp_Object.DisplayName, "Do you want to create a category named " + data + "?", Question!, YesNo!, 1) = 2 then
				return 2
			end if
			
			//	Display attachment category maintenance.
			_categoryEditRow = row
			myController.EditAttachmentCategory(data)
			return
		end if
end choose

end event

event dw_1::clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

SetRedraw(false)
choose case upper(dwo.Name)
	case Upper("c_newattachment")
		long newRow
		newRow = dw_1.InsertRow(0)
		dw_1.ScrollToRow(newRow)
		dw_1.SetRow(newRow)
		
	case Upper("c_deleteattachment")
		string originalFileName
		originalFileName = dw_1.Object.OriginalFileName[row]
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to remove the selected attachment?", Question!, YesNo!, 2) = 2 then
			SetRedraw(true)
			return
		end if
		dw_1.Object.OriginalFileName[row]= ""
		dw_1.Object.FileDescription[row] = ""
		
	case Upper("c_choosefile"), Upper("originalfilename")
		string categoryName, defaultExtensions, searchPattern, newDocumentPath, newDocumentName
		categoryName = dw_1.Object.CategoryName[row]
		defaultExtensions = dw_1.Object.DefaultExtensions[row]
		searchPattern = isnull("All " + CategoryName + "s (" + defaultExtensions + ")," + defaultExtensions + ",All Files (*.*),*.*", "All Files (*.*),*.*")
		if	myController.ChooseAttachment(_partCode, categoryName, searchPattern, newDocumentPath, newDocumentName) = SUCCESS then
			dw_1.Object.OriginalFilePath[row] = newDocumentPath
			dw_1.Object.OriginalFileName[row] = newDocumentName
			dw_1.Object.AttachmentPath[row] = newDocumentPath
		end if
		
end choose
SetRedraw(true)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow < 1 or activerow > RowCount() then return

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

//	Show the current attachment.
myController.BrowserNavigate(dw_1.Object.AttachmentPath[activerow])

end event

type cb_save from commandbutton within u_tabpg_partmaster_editattachments
integer x = 1806
integer y = 16
integer width = 443
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;
//	Save
if	Save() = SUCCESS then
	
	//	and New...
	Refresh()
end if

end event

type cb_close from commandbutton within u_tabpg_partmaster_editattachments
integer x = 1806
integer y = 972
integer width = 443
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;
//	Close
Close()

end event

