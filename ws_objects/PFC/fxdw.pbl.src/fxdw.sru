$PBExportHeader$fxdw.sru
forward
global type fxdw from dw
end type
end forward

global type fxdw from dw
end type

type variables

protected fxEDictionaryTableColumn EDictionaryTableColumns[]
protected int ColumnCount = 0
protected string DbVersion

boolean RowIndicator
int	GridWidth = 4
int NextTab = 1

end variables

forward prototypes
public function integer readcolumnvalues (string _tableschema, string _tablename, string _columnname)
private function integer buildtable (string tableschema, string tablename)
public function integer readcolumndefinition (string _tableschema, string _tablename, string _columngroupname)
public function string getformsyntax (string tableschema, string tablename, string columngroupname)
public function integer builddropdowndw (string parenttableschema, string parenttablename, string fxcolumntype, ref string dddwname, ref string displaycolumn, ref string datacolumn, ref integer dropdownwidth)
public function string getgridsyntax (string tableschema, string tablename, string columngroupname, boolean dropdown)
public function string getsyntax (string tableschema, string tablename, string columngroupname, boolean dropdown)
public function integer buildcolumns (string tableschema, string tablename, boolean dropdown)
end prototypes

public function integer readcolumnvalues (string _tableschema, string _tablename, string _columnname);
//	Assertion: ColumnID is consistant among EDictionary and is the indexor of runtime EDictionary.
declare EDictionaryColumnValuesCursor cursor for
select
	TableSchema
,	TableName
,	ColumnName
,	ColumnID
,	DataType
,	StringValue
,	StringDescription
from
	FT.EDictionaryTableColumnStringValues edtcsv
where
	TableSchema = :_tableSchema
	and
		TableName = :_tableName
	and
		ColumnName = :_columnName
order by
	TableSchema
,	TableName
,	ColumnID
,	StringValue  ;

open EDictionaryColumnValuesCursor  ;

int	Values = 0
fxEDictionaryColumnValue eDictionaryColumnValueBuffer

do while 1 = 1
	fetch
		EDictionaryColumnValuesCursor
	into
		:eDictionaryColumnValueBuffer.TableSchema
	,	:eDictionaryColumnValueBuffer.TableName
	,	:eDictionaryColumnValueBuffer.ColumnName
	,	:eDictionaryColumnValueBuffer.ColumnID
	,	:eDictionaryColumnValueBuffer.DataType
	,	:eDictionaryColumnValueBuffer.StringValue
	,	:eDictionaryColumnValueBuffer.StringDescription
	;
	
	if	SQLCA.SQLCode = 0 then
		Values++
		EDictionaryTableColumns[eDictionaryColumnValueBuffer.ColumnID].EDictionaryColumnValues[Values] = eDictionaryColumnValueBuffer
	else
		exit
	end if
loop

close EDictionaryColumnValuesCursor  ;

commit  ;

return SUCCESS

end function

private function integer buildtable (string tableschema, string tablename);
string	columnSelectList = ""
int i
for i = 1 to ColumnCount
	DWTable.DWTableColumns[i].Name = EDictionaryTableColumns[i].ColumnName
	DWTable.DWTableColumns[i].DBName = EDictionaryTableColumns[i].ColumnName
	DWTable.DWTableColumns[i].Updateable = (IsNull(EDictionaryTableColumns[i].NewRowEditable, 0) + IsNull(EDictionaryTableColumns[i].OldRowEditable, 0) > 0)
	DWTable.DWTableColumns[i].UpdateWhereClause = DWTable.DWTableColumns[i].Updateable
	DWTable.DWTableColumns[i].Key = (EDictionaryTableColumns[i].ColumnIsKey = 1)
	
	choose case EDictionaryTableColumns[i].ColumnType
		case 'varchar', 'char', 'nvarchar', 'nchar'
			if EDictionaryTableColumns[i].ColumnPrecision > 0 then
				DWTable.DWTableColumns[i].cType = "char(" + String(EDictionaryTableColumns[i].ColumnPrecision) + ")"
			else
				DWTable.DWTableColumns[i].cType = "char(32766)"
			end if
		case "uniqueidentifier"
			DWTable.DWTableColumns[i].cType = "char(39)"
		case 'float'
			DWTable.DWTableColumns[i].cType = "number"
			DWTable.DWTableColumns[i].Initial = "0"			
		case 'bigint'
			DWTable.DWTableColumns[i].cType = "decimal(0)"
			DWTable.DWTableColumns[i].Initial = "0"			
		case 'numeric', 'decimal'
			DWTable.DWTableColumns[i].cType = "decimal(" + String(EDictionaryTableColumns[i].ColumnScale) + ")"
			DWTable.DWTableColumns[i].Initial = "0"			
		case 'bit', 'int', 'smallint', 'tinyint'
			DWTable.DWTableColumns[i].cType = "long"
			DWTable.DWTableColumns[i].Initial = "0"			
		case 'datetime'
			DWTable.DWTableColumns[i].cType = "datetime"
			DWTable.DWTableColumns[i].Initial = "Today()"			
		case else
			DWTable.DWTableColumns[i].cType = EDictionaryTableColumns[i].ColumnType
	end choose
	
	//	Add values to lists.
	if	EDictionaryTableColumns[i].IsChild = 0 then
		choose case EDictionaryTableColumns[i].PrimativeType
			case 1.10
				//	Build value list
				readColumnValues(EDictionaryTableColumns[i].TableSchema, EDictionaryTableColumns[i].TableName, EDictionaryTableColumns[i].ColumnName)
				DWTable.DWTableColumns[i].Values = EDictionaryTableColumns[i].GetValues()
		end choose
	end if
	
	//	Build select statement.
	if	i = 1 then
		columnSelectList += TAB + EDictionaryTableColumns[i].ColumnName
	else
		columnSelectList += CR + "," + TAB + EDictionaryTableColumns[i].ColumnName
	end if
next
i = UpperBound(DWTable.DWTableColumns) + 1
DWTable.DWTableColumns[i].Name = "Change"
DWTable.DWTableColumns[i].DBName = "Change"
DWTable.DWTableColumns[i].Updateable = false
DWTable.DWTableColumns[i].UpdateWhereClause = DWTable.DWTableColumns[i].Updateable
DWTable.DWTableColumns[i].cType = "char(1000)"
i++
DWTable.DWTableColumns[i].Name = "IsSelected"
DWTable.DWTableColumns[i].DBName = "IsSelected"
DWTable.DWTableColumns[i].Updateable = false
DWTable.DWTableColumns[i].UpdateWhereClause = DWTable.DWTableColumns[i].Updateable
DWTable.DWTableColumns[i].cType = "long"

DWTable.DWRetrieve.RetrieveSyntax = "select" + CR + columnSelectList + CR + "," + TAB + "Change = convert(varchar(1000), '')" + CR + "," + TAB + "IsSelected = 0" + CR + "from" + CR + TAB + tableSchema + '.' + tableName
DWTable.DWTableUpdate.UpdateTable = tableSchema + '.' + tableName
return FAILURE

end function

public function integer readcolumndefinition (string _tableschema, string _tablename, string _columngroupname);
declare EDictionaryTableColumnsCursor cursor for
select
	edtc.TableColumn
,	edtc.TableSchema
,	edtc.TableName
,	edtc.ColumnName
,	edtc.ColumnID
,	IsKey = convert(int, case when dtuk.KeyColumnName = edtc.ColumnName then 1 else 0 end)
,	edtc.FXColumnType
,	edtc.IsChild
,	edtc.DataType
,	edtc.PrimativeType
,	edtc.GridHeaderText
,	edtc.FormHeaderText
,	edtc.ToolTipColumnText
,	edtc.ToolTipGridHeaderText
,	convert(int,
		case
			when ColumnGroupExists.GroupExists = 1 and dtcg.ColumnName = edtc.ColumnName and :_columnGroupName like 'DropDown%' then edtc.DisplayOnLookup
			when ColumnGroupExists.GroupExists = 1 and dtcg.ColumnName = edtc.ColumnName then edtc.Display
			when ColumnGroupExists.GroupExists = 1 then 0
			when :_columnGroupName like 'DropDown%' then edtc.DisplayOnLookup
			else edtc.Display
		end
	)
,	edtc.DisplayOnLookup
,	edtc.NewRowRequired
,	edtc.NewRowRequiredExpression
,	edtc.NewRowEditable
,	edtc.NewRowEditableExpression
,	edtc.OldRowRequired
,	edtc.OldRowRequiredExpression
,	edtc.OldRowEditable
,	edtc.OldRowEditableExpression
,	edtc.GridFormat
,	edtc.FormFormat
,	edtc.UserDefinedGridFormat
,	edtc.UserDefinedFormFormat
,	edtc.DefaultGridWidth
,	edtc.DefaultFormWidth
,	edtc.StringTypeEditStyle
,	edtc.ColumnAllowsNull
,	edtc.ColumnIsComputed
,	edtc.ColumnIsIdentity
,	edtc.ColumnIsIndexable
,	edtc.ColumnIsRowGuidCol
,	edtc.ColumnType
,	edtc.ColumnPrecision
,	edtc.ColumnScale
from
	FT.fn_EDictionaryTableColumns (:_tableSchema, :_tableName) edtc
	left join FT.DictionaryTableUpdateKey dtuk on
		dtuk.TableSchema = :_tableSchema
		and
			dtuk.TableName = :_tableName
		and
			dtuk.ColumnID = edtc.ColumnID
	left join FT.DictionaryTableColumnGroups dtcg on
		dtcg.TableSchema = :_tableSchema
		and
			dtcg.TableName = :_tableName
		and
			dtcg.ColumnGroupName = :_columnGroupName
		and
			dtcg.ColumnName = edtc.ColumnName
	left join
	(	select
			GroupExists = max(1)
		from
			FT.DictionaryTableColumnGroups dtcg
		where
			dtcg.TableSchema = :_tableSchema
			and
				dtcg.TableName = :_tableName
			and
				dtcg.ColumnGroupName = :_columnGroupName
	) ColumnGroupExists on 1 = 1
			
where
	edtc.TableSchema = :_tableSchema
	and
		edtc.TableName = :_tableName
	and
		not edtc.ColumnType in ('timestamp', 'binary')
order by
	edtc.TableSchema
,	edtc.TableName
,	edtc.ColumnID  ;

open EDictionaryTableColumnsCursor  ;

int	Columns = 0
fxEDictionaryTableColumn eDictionaryTableColumnsBuffer

do while 1 = 1
	fetch
		EDictionaryTableColumnsCursor
	into
		:eDictionaryTableColumnsBuffer.TableColumn
	,	:eDictionaryTableColumnsBuffer.TableSchema
	,	:eDictionaryTableColumnsBuffer.TableName
	,	:eDictionaryTableColumnsBuffer.ColumnName
	,	:eDictionaryTableColumnsBuffer.ColumnID
	,	:eDictionaryTableColumnsBuffer.ColumnIsKey
	,	:eDictionaryTableColumnsBuffer.FXColumnType
	,	:eDictionaryTableColumnsBuffer.IsChild
	,	:eDictionaryTableColumnsBuffer.DataType
	,	:eDictionaryTableColumnsBuffer.PrimativeType
	,	:eDictionaryTableColumnsBuffer.GridHeaderText
	,	:eDictionaryTableColumnsBuffer.FormHeaderText
	,	:eDictionaryTableColumnsBuffer.ToolTipColumnText
	,	:eDictionaryTableColumnsBuffer.ToolTipGridHeaderText
	,	:eDictionaryTableColumnsBuffer.Display
	,	:eDictionaryTableColumnsBuffer.DisplayOnLookup
	,	:eDictionaryTableColumnsBuffer.NewRowRequired
	,	:eDictionaryTableColumnsBuffer.NewRowRequiredExpression
	,	:eDictionaryTableColumnsBuffer.NewRowEditable
	,	:eDictionaryTableColumnsBuffer.NewRowEditableExpression
	,	:eDictionaryTableColumnsBuffer.OldRowRequired
	,	:eDictionaryTableColumnsBuffer.OldRowRequiredExpression
	,	:eDictionaryTableColumnsBuffer.OldRowEditable
	,	:eDictionaryTableColumnsBuffer.OldRowEditableExpression
	,	:eDictionaryTableColumnsBuffer.GridFormat
	,	:eDictionaryTableColumnsBuffer.FormFormat
	,	:eDictionaryTableColumnsBuffer.UserDefinedGridFormat
	,	:eDictionaryTableColumnsBuffer.UserDefinedFormFormat
	,	:eDictionaryTableColumnsBuffer.DefaultGridWidth
	,	:eDictionaryTableColumnsBuffer.DefaultFormWidth
	,	:eDictionaryTableColumnsBuffer.StringTypeEditStyle
	,	:eDictionaryTableColumnsBuffer.ColumnAllowsNull
	,	:eDictionaryTableColumnsBuffer.ColumnIsComputed
	,	:eDictionaryTableColumnsBuffer.ColumnIsIdentity
	,	:eDictionaryTableColumnsBuffer.ColumnIsIndexable
	,	:eDictionaryTableColumnsBuffer.ColumnIsRowGuidCol
	,	:eDictionaryTableColumnsBuffer.ColumnType
	,	:eDictionaryTableColumnsBuffer.ColumnPrecision
	,	:eDictionaryTableColumnsBuffer.ColumnScale
	;
	
	if	SQLCA.SQLCode = 0 then
		Columns++
		EDictionaryTableColumns[Columns] = eDictionaryTableColumnsBuffer
	else
		exit
	end if
loop

close EDictionaryTableColumnsCursor  ;

commit  ;

ColumnCount = UpperBound(EDictionaryTableColumns)
return SUCCESS

end function

public function string getformsyntax (string tableschema, string tablename, string columngroupname);
return ""

end function

public function integer builddropdowndw (string parenttableschema, string parenttablename, string fxcolumntype, ref string dddwname, ref string displaycolumn, ref string datacolumn, ref integer dropdownwidth);
fxcolumntypeparser fxColumnTypeParser
fxColumnTypeParser.ParseType(fxColumnType)

n_fxds	dropDownDW
dropDownDW = create n_fxds
dropDownDW.DbVersion = this.DbVersion
dropDownDW.TableAlias = fxColumnTypeParser.TableSchema
dropDownDW.TableName = fxColumnTypeParser.TableName
dropDownDW.ColumnGroupList = "DropDown" + "-" + parentTableSchema + "." + parentTableName
dropDownDW.GenerateDW(dddwName, dropDownWidth, true)
displayColumn = isnull(fxColumnTypeParser.DisplayColumn, fxColumnTypeParser.DataColumn)
dataColumn = fxColumnTypeParser.DataColumn
destroy dropDownDW
return SUCCESS

end function

public function string getgridsyntax (string tableschema, string tablename, string columngroupname, boolean dropdown);
//	Set the header and detail heights.
DWDetail.Height = 92
DWDetail.Color = "536870912~tif(isRowNew(),rgb(255,255,64),if(currentRow()=getRow(),rgb(128,128,255),if(IsSelected=1,rgb(192,192,255),536870912)))"
DWHeader.Height = 96

return GetSyntax(tableschema, tablename, columngroupname, dropdown)

end function

public function string getsyntax (string tableschema, string tablename, string columngroupname, boolean dropdown);
select
	FT.fn_GetDictionaryVersion()
into
	:DBVersion
from
	(	select
			Row = 1
	) Row ;

//	Set the header and detail heights.
DWDetail.Height = 92
DWDetail.Color = "536870912~tif(isRowNew(),rgb(255,255,64),if(currentRow()=getRow(),rgb(128,128,255),if(IsSelected=1,rgb(192,192,255),536870912)))"
DWHeader.Height = 96

readColumnDefinition(tableSchema, tableName, columnGroupName)
buildTable(tableSchema, tableName)
buildColumns(tableSchema, tableName, dropdown)

return super::GetSyntax()

end function

public function integer buildcolumns (string tableschema, string tablename, boolean dropdown);
//	Add row indicator.
if	RowIndicator then
	dwcompute rowIndicatorCompute
	rowIndicatorCompute.band = "detail"
	rowIndicatorCompute.x = 9
	rowIndicatorCompute.width = 82
	rowIndicatorCompute.y = 12
	rowIndicatorCompute.height = 76
	rowIndicatorCompute.expression = "if ( getrow () = currentrow (), '>', '' )"
	rowIndicatorCompute.border = dwBorder.NONE
	DWComputeFields[1] = rowIndicatorCompute
	GridWidth = 91
end if

//	Build preliminary datawindow for finding columns.
string preliminarySyntax, createError
preliminarySyntax = super::GetSyntax()
datastore preliminaryDS
preliminaryDS = create datastore
if	preliminaryDS.Create(preliminarySyntax, createError) <> SUCCESS then
	clipboard(preliminarySyntax)
	return FAILURE
end if

string describeResult
int	i, columnNo = 0, textNo = 0

string columnSyntax = "", modifyResult
dwcolumn tableColumn
tableColumn.band = "detail"
tableColumn.y = 12
tableColumn.height = 76
tableColumn.border = dwBorder.NONE

dwcolumn tableColumnAsHeader
string columnID
tableColumnAsHeader.band = "header"
tableColumnAsHeader.y = 12
tableColumnAsHeader.height = 72
tableColumnAsHeader.border = dwBorder.RAISED

dwtext tableHeader
tableHeader.band="header"
tableHeader.y = 12
tableHeader.height = 72
tableHeader.border = dwBorder.RAISED
tableHeader.alignment =  tableHeader.dwTextAlignment.LEFTJUSTIFIED

string	dddwName, displayColumn, dataColumn
for	i = 1 to ColumnCount
	if	IsNull(EDictionaryTableColumns[i].Display, 1) = 1 then
		tableColumn.name = lower(EDictionaryTableColumns[i].ColumnName)
		tableColumn.id = i
		tableColumn.x = GridWidth
		tableColumn.width =  IsNull(PixelsToUnits(EDictionaryTableColumns[i].DefaultGridWidth, XPixelsToUnits!), PixelsToUnits(100, XPixelsToUnits!))
		tableColumn.tag = IsNull(EDictionaryTableColumns[i].ToolTipColumnText, tableColumn.name)
		tableColumn.format = IsNull(EDictionaryTableColumns[i].UserDefinedGridFormat, "[general]")
		tableColumn.dwtextbackground.Mode="1~tif(mid(Change[0]," + string(i) + ",1)=~~~"1~~~",0,1)"
		tableColumn.dwtextbackground.color = "536870912~tif(mid(Change[0]," + string(i) + ",1)=~~~"1~~~",RGB(255,255,64),RGB(255,255,255))"
		
		//	Column protection.
		if	IsNull(EDictionaryTableColumns[i].NewRowEditable, 1) = 0 then
			EDictionaryTableColumns[i].NewRowEditableExpression = "1"
		elseif IsNull(EDictionaryTableColumns[i].NewRowEditable, 1) = 1 then
			EDictionaryTableColumns[i].NewRowEditableExpression = "0"
		end if
		if	IsNull(EDictionaryTableColumns[i].OldRowEditable, 1) = 0 then
			EDictionaryTableColumns[i].OldRowEditableExpression = "1"
		elseif IsNull(EDictionaryTableColumns[i].OldRowEditable, 1) = 1 then
			EDictionaryTableColumns[i].OldRowEditableExpression = "0"
		end if
		tableColumn.protectexp = "0~~tif(isRowNew()," + IsNull(EDictionaryTableColumns[i].NewRowEditableExpression, "0") + "," + IsNull(EDictionaryTableColumns[i].OldRowEditableExpression, "0") + ")"
		
		//	Set the tab order for this column.
		tableColumn.tabSequence = NextTab
		NextTab++
		
		//	Justify according to primative type.
		choose case EDictionaryTableColumns[i].PrimativeType
			case 1.00 to 1.99
				tableColumn.alignment = tableColumn.dwTextAlignment.LEFTJUSTIFIED
			case 2.00 to 4.99
				tableColumn.alignment = tableColumn.dwTextAlignment.RIGHTJUSTIFIED
			case else
				tableColumn.alignment = tableColumn.dwTextAlignment.CENTERJUSTIFIED
		end choose
		
		//	Setup edit style.
		if	EDictionaryTableColumns[i].IsChild = 0 then
			//	Not a child, edit style appropriate for primative type.
			choose case EDictionaryTableColumns[i].PrimativeType
				case 1.10
					tableColumn.alignment = tableColumn.dwTextAlignment.CENTERJUSTIFIED
					tableColumn.dwColumnEdit.EditStyle = tableColumn.dwColumnEdit.DROPDOWNLIST
					tableColumn.dwColumnEdit.EditDDLB.UseAsBorder=false
					tableColumn.format = "[general]"
				case else
					tableColumn.dwColumnEdit.EditStyle = tableColumn.dwColumnEdit.EDIT
					tableColumn.dwColumnEdit.NilIsNull = (EDictionaryTableColumns[i].ColumnAllowsNull = 1)
			end choose
		elseif not dropDown then
			//	Child, build drop down datawindow.
			int dropDownWidth
			BuildDropDownDW(tableSchema, tableName, EDictionaryTableColumns[i].FXColumnType, dddwName, displayColumn, dataColumn, dropDownWidth)
			tableColumn.dwColumnEdit.EditStyle = tableColumn.dwColumnEdit.DROPDOWNDW
			tableColumn.dwColumnEdit.EditDDDW.Name = dddwName
			tableColumn.dwColumnEdit.EditDDDW.DisplayColumn = displayColumn
			tableColumn.dwColumnEdit.EditDDDW.DataColumn = dataColumn
			tableColumn.dwColumnEdit.EditDDDW.NilIsNull = (EDictionaryTableColumns[i].ColumnAllowsNull = 1)
			tableColumn.dwColumnEdit.EditDDDW.AllowEdit = true
			tableColumn.dwColumnEdit.EditDDDW.AutoHScroll = true
			tableColumn.dwColumnEdit.EditDDDW.HScrollbar = true
			tableColumn.dwColumnEdit.EditDDDW.VScrollbar = true
			tableColumn.dwColumnEdit.EditDDDW.PercentWidth = round((dropDownWidth + 90) * 100 / tableColumn.Width, 0)
		else
			tableColumn.dwColumnEdit.EditStyle = tableColumn.dwColumnEdit.EDIT
			tableColumn.dwColumnEdit.NilIsNull = (EDictionaryTableColumns[i].ColumnAllowsNull = 1)			
		end if
		
		//	Add either a column as header or text header.
		if	match(EDictionaryTableColumns[i].GridHeaderText, "^{this\..*}$") then
			tableColumnAsHeader.name = Mid(EDictionaryTableColumns[i].GridHeaderText, 7, Len(EDictionaryTableColumns[i].GridHeaderText) - 7)
			columnID = preliminaryDS.Describe(tableColumnAsHeader.name + ".id")
			if	columnID <> "!" then
				columnNo++
				tableColumnAsHeader.name = tableColumn.name + "_t"
				tableColumnAsHeader.id = Integer(columnID)
				tableColumnAsHeader.x = GridWidth
				tableColumnAsHeader.width = tableColumn.width
				tableHeader.tag = IsNull(EDictionaryTableColumns[i].ToolTipGridHeaderText, tableHeader.text)
				DWColumnFields[columnNo] = tableColumnAsHeader
			end if
		else
			textNo++
			tableHeader.name = tableColumn.name + "_t"
			tableHeader.text = IsNull(EDictionaryTableColumns[i].GridHeaderText, tableColumn.name)
			tableHeader.x = GridWidth
			tableHeader.width = tableColumn.width
			tableHeader.tag = IsNull(EDictionaryTableColumns[i].ToolTipGridHeaderText, tableHeader.text)
			DWTextFields[textNo] = tableHeader
		end if
		
		columnNo++
		DWColumnFields[columnNo] = tableColumn
		GridWidth += tableColumn.width
	end if
next

destroy preliminaryDS

return SUCCESS

end function

on fxdw.create
call super::create
end on

on fxdw.destroy
call super::destroy
end on

