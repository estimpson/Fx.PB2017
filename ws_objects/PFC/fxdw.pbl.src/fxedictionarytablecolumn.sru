$PBExportHeader$fxedictionarytablecolumn.sru
forward
global type fxedictionarytablecolumn from n_base
end type
end forward

global type fxedictionarytablecolumn from n_base autoinstantiate
end type

type variables

public:
string TableColumn
string TableSchema
string TableName
string ColumnName
int ColumnID
int ColumnIsKey
string FXColumnType
int IsChild
string DataType
decimal {2} PrimativeType
string GridHeaderText
string FormHeaderText
string ToolTipColumnText
string ToolTipGridHeaderText
int Display
int DisplayOnLookup
int NewRowRequired
string NewRowRequiredExpression
int NewRowEditable
string NewRowEditableExpression
int OldRowRequired
string OldRowRequiredExpression
int OldRowEditable
string OldRowEditableExpression
int GridFormat
int FormFormat
string UserDefinedGridFormat
string UserDefinedFormFormat
int DefaultGridWidth
int DefaultFormWidth
int StringTypeEditStyle
int ColumnAllowsNull
int ColumnIsComputed
int ColumnIsIdentity
int ColumnIsIndexable
int ColumnIsRowGuidCol
string ColumnType
int ColumnPrecision
int ColumnScale

fxEDictionaryColumnValue EDictionaryColumnValues[]

end variables

forward prototypes
public function string getvalues ()
end prototypes

public function string getvalues ();
string valueList = ""
int i, values
values = UpperBound(EDictionaryColumnValues)
for	i = 1 to values
	valueList += EDictionaryColumnValues[i].StringDescription + "~t" + EDictionaryColumnValues[i].StringValue + "/"
next

return valueList

end function

on fxedictionarytablecolumn.create
call super::create
end on

on fxedictionarytablecolumn.destroy
call super::destroy
end on

