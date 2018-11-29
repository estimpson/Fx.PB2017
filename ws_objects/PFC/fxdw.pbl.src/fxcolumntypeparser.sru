$PBExportHeader$fxcolumntypeparser.sru
forward
global type fxcolumntypeparser from n_base
end type
end forward

global type fxcolumntypeparser from n_base autoinstantiate
end type

type variables

string TableSchema, TableName, DataColumn, DisplayColumn
end variables

forward prototypes
public function integer parsetype (string fxcolumntype)
public function any split (string splitstring, string separatorstring)
end prototypes

public function integer parsetype (string fxcolumntype);
//	DROPDOWN_TABLE_EXPRESSION = ~{DROPDOWN_TABLE[~[FILTER_COLUMN_EXPRESSION1[...{&,|}FILTER_COLUMN_EXPRESSIONn]~]~}
//	DROPDOWN_TABLE = TABLE_SCHEMA.TABLE_NAME.DATA_COLUMN_NAME[,DISPLAY_COLUMN_NAME]

//	Validate the expression begins and ends in braces.
if	Left(fxColumnType, 1) <> '{' or Right(fxColumnType, 1) <> '}' then
	return FAILURE
end if

//	Get the dropdown table expression.
string dropDownTable
if	Pos(fxColumnType, "[", 1) > 1 then
	dropDownTable = Mid(fxColumnType, 2, Pos(fxColumnType, "[", 1) - 2)
else
	dropDownTable = Mid(fxColumnType, 2, Len(fxColumnType) - 2)
end if

//	Ensure that table expression contains the proper form (x.y.z[,m]).
if	not Match(dropDownTable, "^[A-Za-z][A-Za-z0-9_]*\.[A-Za-z][A-Za-z0-9_]*\.[A-Za-z][A-Za-z0-9_]") and &
	not Match(dropDownTable, "^[A-Za-z][A-Za-z0-9_]*\.[A-Za-z][A-Za-z0-9_]*\.[A-Za-z][A-Za-z0-9_],[A-Za-z][A-Za-z0-9_]") then
	return FAILURE
end if

//	Get the table schema, name, data column, and display column.
string dropDownTableParts[], lookupColumns[]
dropDownTableParts = split(dropDownTable, ".")
lookupColumns = split(dropDownTableParts[3], ",")
TableSchema = dropDownTableParts[1]
TableName = dropDownTableParts[2]
DataColumn = lookupColumns[1]
if	UpperBound(lookupColumns) > 1 then
	DisplayColumn = lookupColumns[2]
else
	SetNull(DisplayColumn)
end if

return SUCCESS

end function

public function any split (string splitstring, string separatorstring);
string parts[]
int partCount = 1

do while	Pos(splitString, separatorString) > 1
	parts[partCount] = Left(splitString, Pos(splitString, separatorString) - Len(separatorString))
	splitString = Mid(splitString, Pos(splitString, separatorString) + Len(separatorString), Len(splitString))
	partCount++
loop
parts[partCount] = splitString
return parts

end function

on fxcolumntypeparser.create
call super::create
end on

on fxcolumntypeparser.destroy
call super::destroy
end on

