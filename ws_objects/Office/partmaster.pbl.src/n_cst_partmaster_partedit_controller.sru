$PBExportHeader$n_cst_partmaster_partedit_controller.sru
forward
global type n_cst_partmaster_partedit_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_partmaster_partedit_controller from n_cst_virtual_controller
end type
global n_cst_partmaster_partedit_controller n_cst_partmaster_partedit_controller

type variables

Private:

//	State data:
boolean _isNewPart = false

//	Model data:
string _partCode

//	View references
u_panel_leftright LeftRightPanel
u_panel_headerdetail HeaderDetailPanel
u_tabpg_partmaster_partedit_parts PartsView
u_fxdw_partmaster_partedit PartMasterEditView
u_tabpg_browser BrowserView
u_tabpg_partmaster_editattachments PartAttachmentsView
u_fxdw_partmaster_attachmentcategoryedit AttachmentCategoriesView
u_tabpg_partmaster_editcrossreferences PartCrossReferencesView
u_fxdw_partmaster_crossrefcategoryedit CrossReferenceCategoriesView
u_tabpg_partmaster_editcustomfields CustomFieldsView
u_tabpg_partmaster_editcustomfieldmvalue CustomFieldMultiValueView
u_tabpg_partmaster_editrelatedparts RelatedPartsView
u_fxdw_partmaster_newrelatedpartgroup NewRelatedPartGroupView
u_fxdw_partmaster_editrelatedpartgroup EditRelatedPartGroupView

end variables

forward prototypes
public function integer createlayout ()
public function integer setpartcode (string partcode)
public function integer deletepart (string partcode)
public function integer renamepart (string partcode)
public function integer editrelatedparts (string partcode)
public function integer editpartcustom (string partcode)
public function integer copypart (string partcode)
public function integer newpart ()
public function integer browsernavigate (string url)
public function integer editattachments (string partcode)
public function integer endeditattachments ()
public function integer endeditattachmentcategory (integer action, string categoryname)
public function integer editattachmentcategory (string categoryname)
public function integer chooseattachment (string partcode, string categoryname, string searchpattern, ref string newfilepath, ref string newfilename)
public function integer newattachment (string partcode, string filename, string filepath, string filedescription, string categoryname)
public function integer discardattachment (string partcode, long rowid)
public function integer changeattachmentproperties (string partcode, long rowid, string categoryname, string filedescription)
public function integer restorepartmasteredit ()
public function integer refreshpartmasteredit ()
public function integer endeditcrossreferences ()
public function integer editcrossreferences (string partcode)
public function integer editcrossreferencecategory (string categoryname)
public function integer endeditcrossreferencecategory (integer action, string categoryname, string categorydescription)
public function integer endeditcustomfieldmultivalue (integer action)
public function integer endeditcustomfields ()
public function integer editcustomfieldmultivalue (string partcode, string customfieldname)
public function integer endeditrelatedparts ()
public function integer newrelatedpartgroup (string partcode)
public function integer endnewrelatedpartgroup (integer action, string groupname)
public function integer editrelatedpartgroupname (string partcode, string groupguid)
public function integer showcharacteristics ()
public function integer showflowrouter ()
public function integer shownotes ()
public function integer showpackaging ()
public function integer showpurchasing ()
public function integer showsales ()
public function integer showrelatedpartcontextmenu (string partcode)
public function integer printcomponentlabel (long rowid)
end prototypes

public function integer createlayout ();
//	Create the layout panels (example, override).
ParentSheet.OpenUserObject(LeftRightPanel, "u_panel_leftright")
ParentSheet.uo_1.AddPanelControl(LeftRightPanel)
ParentSheet.uo_1.ShowControl(LeftRightPanel)

ParentSheet.OpenUserObject(HeaderDetailPanel, "u_panel_headerdetail")
LeftRightPanel.uo_1.AddPanelControl(HeaderDetailPanel)
LeftRightPanel.uo_1.ShowControl(HeaderDetailPanel)

//	Create editable control(s) for each panel (example, override).
ParentSheet.OpenUserObject(PartsView, "u_tabpg_partmaster_partedit_parts")
PartsView.Controller = this
HeaderDetailPanel.uo_1.AddPanelControl(PartsView)
HeaderDetailPanel.uo_1.ShowControl(PartsView)
MasterListControl = PartsView

ParentSheet.OpenUserObject(PartMasterEditView, "u_fxdw_partmaster_partedit")
PartMasterEditView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(PartMasterEditView)
HeaderDetailPanel.uo_2.ShowControl(PartMasterEditView)

ParentSheet.OpenUserObject(BrowserView, "u_tabpg_browser")
BrowserView.Controller = this
LeftRightPanel.uo_2.AddPanelControl(BrowserView)
LeftRightPanel.uo_2.ShowControl(BrowserView)

ParentSheet.OpenUserObject(PartAttachmentsView, "u_tabpg_partmaster_editattachments")
PartAttachmentsView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(PartAttachmentsView)

ParentSheet.OpenUserObject(AttachmentCategoriesView, "u_fxdw_partmaster_attachmentcategoryedit")
AttachmentCategoriesView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(AttachmentCategoriesView)

ParentSheet.OpenUserObject(PartCrossReferencesView, "u_tabpg_partmaster_editcrossreferences")
PartCrossReferencesView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(PartCrossReferencesView)

ParentSheet.OpenUserObject(CrossReferenceCategoriesView, "u_fxdw_partmaster_crossrefcategoryedit")
CrossReferenceCategoriesView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(CrossReferenceCategoriesView)

ParentSheet.OpenUserObject(CustomFieldsView, "u_tabpg_partmaster_editcustomfields")
CustomFieldsView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(CustomFieldsView)

ParentSheet.OpenUserObject(CustomFieldMultiValueView, "u_tabpg_partmaster_editcustomfieldmvalue")
CustomFieldMultiValueView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(CustomFieldMultiValueView)

ParentSheet.OpenUserObject(RelatedPartsView, "u_tabpg_partmaster_editrelatedparts")
RelatedPartsView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(RelatedPartsView)

ParentSheet.OpenUserObject(NewRelatedPartGroupView, "u_fxdw_partmaster_newrelatedpartgroup")
NewRelatedPartGroupView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(NewRelatedPartGroupView)

ParentSheet.OpenUserObject(EditRelatedPartGroupView, "u_fxdw_partmaster_editrelatedpartgroup")
EditRelatedPartGroupView.Controller = this
HeaderDetailPanel.uo_2.AddPanelControl(EditRelatedPartGroupView)

return SUCCESS

end function

public function integer setpartcode (string partcode);
if	not IsValid(PartAttachmentsView) then
	return FAILURE
end if

//	Set part on part master edit.
_partCode = partCode
PartMasterEditView.PartCode = _partCode
PartMasterEditView.Refresh()

//	Tell browser to show current part.
BrowserNavigate("file://fxsqlhn.local.volttech.us/FX/FxVoltTech/PartIntranet/" + _partCode + ".htm")

//	Done.
return SUCCESS

end function

public function integer deletepart (string partcode);
return FAILURE

end function

public function integer renamepart (string partcode);
return FAILURE

end function

public function integer editrelatedparts (string partcode);
if	not IsValid(HeaderDetailPanel) or not IsValid(RelatedPartsView) then
	return FAILURE
end if

//	Show edit attachments view.
RelatedPartsView.SetPart(PartCode)
HeaderDetailPanel.uo_2.ShowControl(RelatedPartsView)
return SUCCESS

end function

public function integer editpartcustom (string partcode);
if	not IsValid(HeaderDetailPanel) or not IsValid(CustomFieldsView) then
	return FAILURE
end if

//	Show edit attachments view.
CustomFieldsView.SetPart(PartCode)
HeaderDetailPanel.uo_2.ShowControl(CustomFieldsView)
return SUCCESS

end function

public function integer copypart (string partcode);
return FAILURE

end function

public function integer newpart ();
if	not IsValid(HeaderDetailPanel) or not IsValid(PartMasterEditView) then
	return FAILURE
end if

//	Restore the 
RestorePartMasterEdit()

PartMasterEditView.Reset()
PartMasterEditView.InsertRow(0)
_isNewPart = true
SetNull (_partCode)

return FAILURE

end function

public function integer browsernavigate (string url);
if	not IsValid(BrowserView) then
	return FAILURE
end if

//	Navigate the browser.
BrowserView.uo_browser.Navigate(URL)
return SUCCESS

end function

public function integer editattachments (string partcode);
if	not IsValid(HeaderDetailPanel) or not IsValid(PartAttachmentsView) then
	return FAILURE
end if

//	Show edit attachments view.
PartAttachmentsView.SetPart(PartCode)
HeaderDetailPanel.uo_2.ShowControl(PartAttachmentsView)
return SUCCESS

end function

public function integer endeditattachments ();
return RestorePartMasterEdit()

end function

public function integer endeditattachmentcategory (integer action, string categoryname);
if	not IsValid(HeaderDetailPanel) or not IsValid(PartAttachmentsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	PartAttachmentsView.SetCategory(categoryname)
else
	PartAttachmentsView.RefocusCategory()
end if
HeaderDetailPanel.uo_2.ShowControl(PartAttachmentsView)
return SUCCESS

end function

public function integer editattachmentcategory (string categoryname);
if	not IsValid(HeaderDetailPanel) or not IsValid(AttachmentCategoriesView) then
	return FAILURE
end if

AttachmentCategoriesView.SetCategory(categoryName)
HeaderDetailPanel.uo_2.ShowControl(AttachmentCategoriesView)

return NO_ACTION

end function

public function integer chooseattachment (string partcode, string categoryname, string searchpattern, ref string newfilepath, ref string newfilename);
string filePath, fileName
integer li_rtn

string	lastKnownPath = "C:\Users\estimpson.FORE-THOUGHT\Pictures\Fore-Thought"
if	GetFileOpenName("Select Part Image", filePath, fileName, "", searchPattern, lastKnownPath, 2^1 + 2^6 + 2^8 + 2^14) = 1 then
	//	Tell browser to the selected image.
	BrowserNavigate(filePath)
	
	//	Return the image url.
	newFilePath = filePath
	newFileName = fileName
	return SUCCESS
end if

return FAILURE

end function

public function integer newattachment (string partcode, string filename, string filepath, string filedescription, string categoryname);
n_cst_partmastertrans_attachments partMasterTrans_Attachments
partMasterTrans_Attachments = create n_cst_partmastertrans_attachments

//	Get the attachment upload path.
string uploadPath
if	partMasterTrans_Attachments.GetUploadPath(uploadPath) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

//	Copy file to upload path.
if	FileCopy(filePath, uploadPath + "\" + fileName) <> SUCCESS then
	MessageBox("fyi", "filecopyfailed")
	destroy partMasterTrans_Attachments
	return FAILURE
end if

//	Create attachment.
string attachmentName
if	partMasterTrans_Attachments.AttachDocument(partCode, fileName, filePath, fileDescription, categoryName, attachmentName) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

commit using SQLCA  ;
destroy partMasterTrans_Attachments
return SUCCESS

end function

public function integer discardattachment (string partcode, long rowid);
n_cst_partmastertrans_attachments partMasterTrans_Attachments
partMasterTrans_Attachments = create n_cst_partmastertrans_attachments

//	Discard attachment.
if	partMasterTrans_Attachments.DiscardAttachment(partCode, rowID) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

commit using SQLCA  ;
destroy partMasterTrans_Attachments
return SUCCESS

end function

public function integer changeattachmentproperties (string partcode, long rowid, string categoryname, string filedescription);
n_cst_partmastertrans_attachments partMasterTrans_Attachments
partMasterTrans_Attachments = create n_cst_partmastertrans_attachments

//	Change attachment category.
if	partMasterTrans_Attachments.ChangeAttachmentProperties(partCode, rowID, categoryName, fileDescription) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

commit using SQLCA  ;
destroy partMasterTrans_Attachments
return SUCCESS

end function

public function integer restorepartmasteredit ();
if	not IsValid(HeaderDetailPanel) or not IsValid(PartMasterEditView) then
	return FAILURE
end if

HeaderDetailPanel.uo_2.ShowControl(PartMasterEditView)

return RefreshPartMasterEdit()


end function

public function integer refreshpartmasteredit ();
//	Show part edit.
PartMasterEditView.Refresh()

//	Done.
return SUCCESS

end function

public function integer endeditcrossreferences ();
return RestorePartMasterEdit()

end function

public function integer editcrossreferences (string partcode);
if	not IsValid(HeaderDetailPanel) or not IsValid(PartCrossReferencesView) then
	return FAILURE
end if

//	Show edit attachments view.
PartCrossReferencesView.SetPart(PartCode)
HeaderDetailPanel.uo_2.ShowControl(PartCrossReferencesView)
return SUCCESS

end function

public function integer editcrossreferencecategory (string categoryname);
if	not IsValid(HeaderDetailPanel) or not IsValid(CrossReferenceCategoriesView) then
	return FAILURE
end if

CrossReferenceCategoriesView.SetCategory(categoryName)
HeaderDetailPanel.uo_2.ShowControl(CrossReferenceCategoriesView)

return NO_ACTION

end function

public function integer endeditcrossreferencecategory (integer action, string categoryname, string categorydescription);
if	not IsValid(HeaderDetailPanel) or not IsValid(PartCrossReferencesView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	PartCrossReferencesView.SetCategory(categoryName, categoryDescription)
else
	PartCrossReferencesView.RefocusCategory()
end if
HeaderDetailPanel.uo_2.ShowControl(PartCrossReferencesView)
return SUCCESS

end function

public function integer endeditcustomfieldmultivalue (integer action);
if	not IsValid(HeaderDetailPanel) or not IsValid(CustomFieldsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	CustomFieldsView.Refresh()
end if
HeaderDetailPanel.uo_2.ShowControl(CustomFieldsView)
return SUCCESS

end function

public function integer endeditcustomfields ();
return RestorePartMasterEdit()

end function

public function integer editcustomfieldmultivalue (string partcode, string customfieldname);
if	not IsValid(HeaderDetailPanel) or not IsValid(CustomFieldMultiValueView) then
	return FAILURE
end if

CustomFieldMultiValueView.SetPartCustomFieldName(partCode, customFieldName)
HeaderDetailPanel.uo_2.ShowControl(CustomFieldMultiValueView)

return NO_ACTION

end function

public function integer endeditrelatedparts ();
return RestorePartMasterEdit()

end function

public function integer newrelatedpartgroup (string partcode);
if	not IsValid(HeaderDetailPanel) or not IsValid(NewRelatedPartGroupView) then
	return FAILURE
end if

//	Show new related part group view.
NewRelatedPartGroupView.SetPart(PartCode)
HeaderDetailPanel.uo_2.ShowControl(NewRelatedPartGroupView)
return SUCCESS

end function

public function integer endnewrelatedpartgroup (integer action, string groupname);
if	not IsValid(HeaderDetailPanel) or not IsValid(RelatedPartsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	RelatedPartsView.Refresh()
end if
HeaderDetailPanel.uo_2.ShowControl(RelatedPartsView)
return SUCCESS

end function

public function integer editrelatedpartgroupname (string partcode, string groupguid);
if	not IsValid(HeaderDetailPanel) or not IsValid(EditRelatedPartGroupView) then
	return FAILURE
end if

//	Show edit related part group view.
EditRelatedPartGroupView.SetPartGroupGUID(partCode, groupGUID)
HeaderDetailPanel.uo_2.ShowControl(EditRelatedPartGroupView)
return SUCCESS

end function

public function integer showcharacteristics ();
OpenSheetWithParm(w_part_char, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer showflowrouter ();
OpenSheetWithParm(w_router_maintenance, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer shownotes ();
OpenSheetWithParm(w_notes, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer showpackaging ();
OpenSheetWithParm(w_part_package_materials, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer showpurchasing ();
OpenSheetWithParm(w_vendor_price_matrix, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer showsales ();
OpenSheetWithParm(w_customer_price_matrix, _partCode, gnv_App.of_GetFrame(), 3, Original!)
return SUCCESS

end function

public function integer showrelatedpartcontextmenu (string partcode);
m_context contextMenu, groupMenu, relatedPartMenu
contextMenu = create m_context
groupMenu = create m_context
relatedPartMenu = create m_context

n_partmaster_relatedpartitem relatedParts[]
n_cst_partmastertrans_relatedparts relatedPartsTrans
relatedPartsTrans = create n_cst_partmastertrans_relatedparts
relatedPartsTrans.GetRelatedParts(partCode, relatedParts)
int i, groupNo = 0, relatedPartNo = 0
for	i = 1 to UpperBound(relatedParts)
	if	relatedParts[i].IsGroup then
		groupMenu = create m_context
		groupMenu.Controller = this
		groupMenu.Text = relatedParts[i].GroupName
		contextMenu.Item[groupNo + 1] = groupMenu
		groupNo++
		relatedPartNo = 0
	else
		relatedPartMenu = create m_context
		relatedPartMenu.Controller = this
		relatedPartMenu.Text = relatedParts[i].RelatedPart
		relatedPartMenu.Tag = 'R' + relatedParts[i].RelatedPart
		contextMenu.Item[groupNo].Item[relatedPartNo + 1] = relatedPartMenu
		relatedPartNo++
	end if
next

contextMenu.PopMenu(gnv_App.of_GetFrame().PointerX(), gnv_App.of_GetFrame().PointerY())

return SUCCESS
end function

public function integer printcomponentlabel (long rowid);
string labelFormat = "Component Part"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", rowID)
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", labelFormat )
return Print(printerParm)

end function

on n_cst_partmaster_partedit_controller.create
call super::create
end on

on n_cst_partmaster_partedit_controller.destroy
call super::destroy
end on

event contextmenuclick;call super::contextmenuclick;
choose case left(menuTag, 1)
	case "R"
		if	PartsView.SetPart(menuText) <> SUCCESS then
			SetPartCode(menuText)
		end if
end choose

end event

