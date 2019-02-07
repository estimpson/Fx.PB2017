HA$PBExportHeader$n_partmaster_editpartcontroller.sru
forward
global type n_partmaster_editpartcontroller from n_cst_virtual_controller
end type
end forward

global type n_partmaster_editpartcontroller from n_cst_virtual_controller
end type
global n_partmaster_editpartcontroller n_partmaster_editpartcontroller

type variables

Private:
//	Browser controller.
//n_browser_controller _browserController

//	Model data:
string _partCode

boolean _isNewPart
string _newPartToken

//	View references
u_panel _primaryPartPanel
u_fxdw_partmaster_partedit _partMasterEditView
u_tabpg_partmaster_editattachments _partAttachmentsView
u_fxdw_partmaster_attachmentcategoryedit _attachmentCategoriesView
u_tabpg_partmaster_editcrossreferences _partCrossReferencesView
u_fxdw_partmaster_crossrefcategoryedit _crossReferenceCategoriesView
u_tabpg_partmaster_editcustomfields _customFieldsView
u_tabpg_partmaster_editcustomfieldmvalue _customFieldMultiValueView
u_tabpg_partmaster_editrelatedparts _relatedPartsView
u_fxdw_partmaster_newrelatedpartgroup _newRelatedPartGroupView
u_fxdw_partmaster_editrelatedpartgroup _editRelatedPartGroupView

end variables

forward prototypes
public function integer editattachments ()
public function integer changeattachmentproperty (long rowid, string categoryname, string filedescription)
public function integer copypart ()
public function integer deletepart ()
public function integer discardattachment (long rowid)
public function integer editattachmentcategory (string categoryname)
public function integer editcrossreferencecategory (string categoryname)
public function integer editcustomfieldmultivalue (string customfieldname)
public function integer editpartcustom ()
public function integer editrelatedpartgroupname (string groupguid)
public function integer editrelatedparts ()
public function integer endeditattachmentcategory (integer action, string categoryname)
public function integer restorepartmasteredit ()
public function integer refreshpartmasteredit ()
public function integer endeditattachments ()
public function integer endeditcrossreferencecategory (integer action, string categoryname, string categorydescription)
public function integer endeditcrossreferences ()
public function integer endeditcustomfieldmultivalue (integer action)
public function integer endeditcustomfields ()
public function integer endeditrelatedparts ()
public function integer endnewrelatedpartgroup (integer action)
public function integer newattachment (string filename, string filepath, string filedescription, string categoryname)
public function integer newpart ()
end prototypes

public function integer editattachments ();
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

if	not IsValid(_primaryPartPanel) or not IsValid(_partAttachmentsView) then
	return FAILURE
end if

//	Show edit attachments view.
_partAttachmentsView.SetPart(partCode)
return _primaryPartPanel.ShowControl(_partAttachmentsView)

end function

public function integer changeattachmentproperty (long rowid, string categoryname, string filedescription);
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

n_cst_partmastertrans_attachments partMasterTrans_Attachments
partMasterTrans_Attachments = create n_cst_partmastertrans_attachments

//	Change attachment category.
if	partMasterTrans_Attachments.ChangeAttachmentProperties(partCode, rowID, categoryName, fileDescription) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

partMasterTrans_Attachments.CommitTrans()
destroy partMasterTrans_Attachments
return SUCCESS

end function

public function integer copypart ();
return FAILURE

end function

public function integer deletepart ();
return FAILURE

end function

public function integer discardattachment (long rowid);
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

n_cst_partmastertrans_attachments partMasterTrans_Attachments
partMasterTrans_Attachments = create n_cst_partmastertrans_attachments

//	Discard attachment.
if	partMasterTrans_Attachments.DiscardAttachment(partCode, rowID) <> SUCCESS then
	destroy partMasterTrans_Attachments
	return FAILURE
end if

partMasterTrans_Attachments.CommitTrans()
destroy partMasterTrans_Attachments
return SUCCESS

end function

public function integer editattachmentcategory (string categoryname);
if	not IsValid(_primaryPartPanel) or not IsValid(_attachmentCategoriesView) then
	return FAILURE
end if

_attachmentCategoriesView.SetCategory(categoryName)
return _primaryPartPanel.ShowControl(_attachmentCategoriesView)

end function

public function integer editcrossreferencecategory (string categoryname);
if	not IsValid(_primaryPartPanel) or not IsValid(_crossReferenceCategoriesView) then
	return FAILURE
end if

_crossReferenceCategoriesView.SetCategory(categoryName)
return _primaryPartPanel.ShowControl(_crossReferenceCategoriesView)

end function

public function integer editcustomfieldmultivalue (string customfieldname);
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

if	not IsValid(_primaryPartPanel) or not IsValid(_customFieldMultiValueView) then
	return FAILURE
end if

_customFieldMultiValueView.SetPartCustomFieldName(partCode, customFieldName)
return _primaryPartPanel.ShowControl(_customFieldMultiValueView)

end function

public function integer editpartcustom ();
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

if	not IsValid(_primaryPartPanel) or not IsValid(_customFieldsView) then
	return FAILURE
end if

_customFieldsView.SetPart(partCode)
return _primaryPartPanel.ShowControl(_customFieldsView)

end function

public function integer editrelatedpartgroupname (string groupguid);
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

if	not IsValid(_primaryPartPanel) or not IsValid(_editRelatedPartGroupView) then
	return FAILURE
end if

_editRelatedPartGroupView.SetPartGroupGUID(partCode, groupGUID)
return _primaryPartPanel.ShowControl(_editRelatedPartGroupView)

end function

public function integer editrelatedparts ();
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

if	not IsValid(_primaryPartPanel) or not IsValid(_relatedPartsView) then
	return FAILURE
end if

_relatedPartsView.SetPart(partCode)
return _primaryPartPanel.ShowControl(_relatedPartsView)

end function

public function integer endeditattachmentcategory (integer action, string categoryname);
if	not IsValid(_primaryPartPanel) or not IsValid(_partAttachmentsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	_partAttachmentsView.SetCategory(categoryName)
else
	_partAttachmentsView.RefocusCategory()
end if
return _primaryPartPanel.ShowControl(_partAttachmentsView)

end function

public function integer restorepartmasteredit ();
if	not IsValid(_primaryPartPanel) or not IsValid(_partMasterEditView) then
	return FAILURE
end if

_primaryPartPanel.ShowControl(_partMasterEditView)

return RefreshPartMasterEdit()

end function

public function integer refreshpartmasteredit ();
//	Show part edit.
return _partMasterEditView.Refresh()

end function

public function integer endeditattachments ();
return RestorePartMasterEdit()

end function

public function integer endeditcrossreferencecategory (integer action, string categoryname, string categorydescription);
if	not IsValid(_primaryPartPanel) or not IsValid(_partCrossReferencesView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	_partCrossReferencesView.SetCategory(categoryName, categoryDescription)
else
	_partCrossReferencesView.RefocusCategory()
end if
return _primaryPartPanel.ShowControl(_partCrossReferencesView)

end function

public function integer endeditcrossreferences ();
return RestorePartMasterEdit()

end function

public function integer endeditcustomfieldmultivalue (integer action);
if	not IsValid(_primaryPartPanel) or not IsValid(_customFieldsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	_customFieldsView.Refresh()
end if
return _primaryPartPanel.ShowControl(_customFieldsView)

end function

public function integer endeditcustomfields ();
return RestorePartMasterEdit()

end function

public function integer endeditrelatedparts ();
return RestorePartMasterEdit()

end function

public function integer endnewrelatedpartgroup (integer action);
if	not IsValid(_primaryPartPanel) or not IsValid(_relatedPartsView) then
	return FAILURE
end if

//	Tell the view to use new value or not.
if	action = SUCCESS then
	_relatedPartsView.Refresh()
end if
return _primaryPartPanel.ShowControl(_relatedPartsView)

end function

public function integer newattachment (string filename, string filepath, string filedescription, string categoryname);
string partCode
if	_isNewPart then partCode = _newPartToken else partCode = _partCode

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

partMasterTrans_Attachments.CommitTrans()
destroy partMasterTrans_Attachments

return SUCCESS

end function

public function integer newpart ();
if	not IsValid(_primaryPartPanel) or not IsValid(_partMasterEditView) then
	return FAILURE
end if

//	Restore the 
RestorePartMasterEdit()
_isNewPart = true
SetNull (_partCode)

_partMasterEditView.Reset()
_partMasterEditView.InsertRow(0)

n_partmaster_editparttrans partMasterTrans
partMasterTrans = create n_partmaster_editparttrans


partMasterTrans.CommitTrans()
destroy partMasterTrans
return SUCCESS

end function

on n_partmaster_editpartcontroller.create
call super::create
end on

on n_partmaster_editpartcontroller.destroy
call super::destroy
end on

