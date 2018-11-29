$PBExportHeader$n_fxds.sru
forward
global type n_fxds from n_ds
end type
end forward

global type n_fxds from n_ds
end type
global n_fxds n_fxds

type variables

//	Form or grid layout.
constant int FORMLAYOUT = 0
constant int GRIDLAYOUT = 1
int Layout = GRIDLAYOUT

//	Grid behavior.
boolean RowIndicator = false

//	Update behavior.
boolean AutoUpdate = false

//	FXDW datasource.
string TableAlias, TableName, ColumnGroupList

//	ToolTip handling:
public string PriorDWOName = "!"
u_tooltip ToolTip
int AnchorX, AnchorY

//	Generation version:
string VERSION = '2011.01.03.01'
string DBVersion
end variables

forward prototypes
public function integer generatedw (ref string dwname, ref integer gridwidth, boolean dropdown)
end prototypes

public function integer generatedw (ref string dwname, ref integer gridwidth, boolean dropdown);
//	Check for existing datawindow.
string dwEntry, dwSyntax, syntaxErr, filter

select
	convert(varchar, RowGUID)
,	DbVersion
into
	:dwEntry
,	:DbVersion
from
	FT.DWVersions
where
	TableAlias = :TableAlias
	and
		TableName = :TableName
	and
		GeneratorVersion = :VERSION
	and
		DbVersion = :DBVersion
	and
		GridWidth > 0  ;

if	dwEntry > "" then
	string entries
	entries = LibraryDirectory("fxdws.pbd", DirDatawindow!)
	n_ds libraryDirDS
	libraryDirDS = create n_ds
	libraryDirDS.DataObject = "d_librarydirectory"
	libraryDirDS.ImportString(entries)
	filter = "name = ~"d_" + lower(dwEntry) + "~"" // and comments = ~"" + 'V' + string(VERSION) + ',' + String(DbVersion) + "~""
	libraryDirDS.SetFilter(filter)
	libraryDirDS.Filter()
	if	libraryDirDS.RowCount() > 0 then
		destroy libraryDirDS
		this.DataObject =  "d_" + dwEntry
		dwName = "d_" + dwEntry
		
		select
			GridWidth
		into
			:gridWidth
		from
			FT.DWVersions
		where
			convert(varchar, RowGUID) = :dwEntry  ;

		return SUCCESS
	end if
	destroy libraryDirDS
	
	select
		DWSyntax
	,	GridWidth
	into
		:dwSyntax
	,	:gridWidth
	from
		FT.DWVersions
	where
		convert(varchar, RowGUID) = :dwEntry  ;
	
	LibraryImport ("fxdws.pbd", "d_" + dwEntry, ImportDataWindow!, dwSyntax, syntaxErr, 'V' + string(VERSION) + ',' + String(DbVersion))
	this.DataObject = "d_" + dwEntry
	dwName = "d_" + dwEntry
else
	
	//	Build datawindow syntax.

	if	Layout = GRIDLAYOUT then
		fxdw fxGridDW
		fxGridDW.RowIndicator = this.RowIndicator
		dwSyntax = fxGridDW.GetSyntax(TableAlias, TableName, ColumnGroupList, dropDown)
	else
		fxdw fxFormDW
		dwSyntax = fxFormDW.GetSyntax(TableAlias, TableName, ColumnGroupList, dropDown)
	end if
	
	gridWidth = fxGridDW.GridWidth
	
	insert
		FT.DWVersions
	(
		TableAlias
	,	TableName
	,	ColumnGroupList
	,	DBVersion
	,	GeneratorVersion
	,	dwSyntax
	,	GridWidth
	)
	select
		TableAlias = :TableAlias
	,	TableName = :TableName
	,	ColumnGroupList = :ColumnGroupList
	,	DBVersion = FT.fn_GetDictionaryVersion()
	,	GeneratorVersion = :VERSION
	,	dwSyntax = :dwSyntax
	,	GridWidth = :gridWidth  ;
	
	commit  ;
	
	return GenerateDW(dwName, gridWidth, dropDown)
end if

return SUCCESS

end function

on n_fxds.create
call super::create
end on

on n_fxds.destroy
call super::destroy
end on

