$PBExportHeader$n_cst_dwsrv_xdef.sru
$PBExportComments$Extension DataWindow Search service
forward
global type n_cst_dwsrv_xdef from n_cst_dwsrv
end type
type os_columns from structure within n_cst_dwsrv_xdef
end type
end forward

type os_columns from structure
	string		s_columnname
	dwobject		dwo_source
	datawindow		dw_source
end type

global type n_cst_dwsrv_xdef from n_cst_dwsrv
event pfc_editchanged ( ref long al_row,  ref dwobject adwo_obj,  ref string as_data )
event pfc_itemfocuschanged ( long al_row,  ref dwobject adwo_object )
end type
global n_cst_dwsrv_xdef n_cst_dwsrv_xdef

type variables

constant int DATABASESTORAGEMODE = 1
//constant int LOCALFILESTORAGEMODE = 2
protectedwrite int Mode = DATABASESTORAGEMODE

protectedwrite string	eXternalDefitionName

end variables

forward prototypes
public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib)
public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib)
public function integer of_setrequestor (u_dw adw_requestor)
public function integer createdatabasestorage ()
public function integer setmode (integer _mode)
public function integer getdefaultexternaldefinitionname (ref string _name)
public function integer readdwdef ()
public function integer writedwdef ()
end prototypes

public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib);
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_infoattrib	(By reference) The Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Service Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Populate Information.
anv_infoattrib.is_name = 'eXternal Definition'
anv_infoattrib.is_description = &
	'Handles storing and retrieving datawindow definitions in local files and/or the database, allowing clients to have their own definitions.'
	
Return 1

end function

public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib);
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetPropertyInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_attrib	(By ref.) The Property Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Service Property Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_infoattrib lnv_infoattrib

// Get the first two attributes from the Main Information attributes.
of_GetInfo(lnv_infoattrib)
anv_attrib.is_name = lnv_infoattrib.is_name
anv_attrib.is_description = lnv_infoattrib.is_description

// Set the rest of the attributes.
anv_attrib.is_propertypage = {'u_tabpg_dwproperty_srvexternaldefinition'}
anv_attrib.ib_switchbuttons = True

Return 1
end function

public function integer of_setrequestor (u_dw adw_requestor);
if	super::of_SetRequestor(adw_requestor) <> SUCCESS then
	return FAILURE
end if

return GetDefaultExternalDefinitionName(eXternalDefitionName)

end function

public function integer createdatabasestorage ();
execute immediate "if object_id ('FXSYS.ExternalDWDefinition') is null create table FXSYS.ExternalDWDefinition (Name varchar(388), GroupName sysname null, UserName sysname null, DWDefinition nvarchar(max), RowID int identity primary key, unique (Name, GroupName, UserName))"  using SQLCA  ;

if	SQLCA.SQLCode = 0 then
	commit using SQLCA  ;
	return SUCCESS
else
	rollback using SQLCA  ;
	return FAILURE
end if

end function

public function integer setmode (integer _mode);
choose case _mode
	case DATABASESTORAGEMODE
		Mode = _mode
		CreateDatabaseStorage()
		return SUCCESS
//	case LOCALFILESTORAGEMODE    //Not implemented yet.
//		return SUCCESS
	case default
		return FAILURE
end choose

end function

public function integer getdefaultexternaldefinitionname (ref string _name);
if	not IsValid (idw_Requestor) then
	return FAILURE
end if

_name = idw_Requestor.ClassName()
powerobject	parentObject
parentObject = idw_Requestor.GetParent()
do while IsValid(parentObject)
	_name =parentObject.ClassName() + "/" + _name
	parentObject = parentObject.GetParent()
loop

return success

end function

public function integer readdwdef ();
string	dwSyntax, dwSyntaxError
choose case Mode
	case DATABASESTORAGEMODE
		select
			DWDefinition
		into
			:dwSyntax
		from
			FXSYS.ExternalDWDefinition edd
		where
			Name = :eXternalDefitionName
		using
			SQLCA  ;
		
		idw_Requestor.Create(dwSyntax, dwSyntaxError)
		
		if	dwSyntaxError > "" then
			msgbox(dwSyntaxError)
		end if
		
end choose

return FAILURE
end function

public function integer writedwdef ();
if	not IsValid(idw_Requestor) then
	return FAILURE
end if
if	not idw_Requestor.DataObject > "" then
	return failure
end if

string	dwSyntax
dwSyntax = idw_Requestor.object.datawindow.syntax
choose case Mode
	case DATABASESTORAGEMODE
		insert
			FXSYS.ExternalDWDefinition
		(
			Name
		,	DWDefinition
		)
		values
		(
			:eXternalDefitionName
		,	:dwSyntax
		)
		using
			SQLCA  ;
		
		if	SQLCA.SQLCode = 0 then
			commit using SQLCA  ;
		else
			rollback using SQLCA  ;
		end if
		
		return SUCCESS		
end choose

return FAILURE

end function

on n_cst_dwsrv_xdef.destroy
call super::destroy
end on

on n_cst_dwsrv_xdef.create
call super::create
end on

