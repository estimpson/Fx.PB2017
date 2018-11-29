$PBExportHeader$u_fxdw_partmaster_editrelatedpartgroup.sru
forward
global type u_fxdw_partmaster_editrelatedpartgroup from u_fxdw
end type
end forward

global type u_fxdw_partmaster_editrelatedpartgroup from u_fxdw
integer width = 1778
integer height = 488
string dataobject = "d_partmaster_relatedpartgroupedit"
boolean hscrollbar = true
end type
global u_fxdw_partmaster_editrelatedpartgroup u_fxdw_partmaster_editrelatedpartgroup

type variables

private string _partCode
private string _groupGUID
end variables

forward prototypes
public function integer setpartgroupguid (string partcode, string groupguid)
end prototypes

public function integer setpartgroupguid (string partcode, string groupguid);
_partCode = partCode
_groupGUID = groupGUID
return Refresh()

end function

on u_fxdw_partmaster_editrelatedpartgroup.create
call super::create
end on

on u_fxdw_partmaster_editrelatedpartgroup.destroy
call super::destroy
end on

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

string groupName
choose case dwo.Name
	case "p_ok"
		//	Save new group.
		AcceptText()
		groupName = Object.GroupName[1]
		
		n_cst_partmastertrans_relatedparts partMasterTrans_RelatedParts
		partMasterTrans_RelatedParts = create n_cst_partmastertrans_relatedparts
		if	partMasterTrans_RelatedParts.EditRelatedPartGroupName(_partCode, _groupGUID, groupName) <> SUCCESS then
			destroy partMasterTrans_RelatedParts
			return
		end if
		destroy partMasterTrans_RelatedParts
		commit using SQLCA  ;
		Reset()
		myController.EndNewRelatedPartGroup(SUCCESS, groupName)
	case "p_cancel"
		Reset()
		SetNull(groupName)
		myController.EndNewRelatedPartGroup(SUCCESS, groupName)
end choose

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode, _groupGUID)

end event

event updateend;call super::updateend;
commit using SQLCA ;

end event

