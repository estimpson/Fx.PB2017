$PBExportHeader$fxedictionarycolumnvalue.sru
forward
global type fxedictionarycolumnvalue from n_base
end type
end forward

global type fxedictionarycolumnvalue from n_base autoinstantiate
end type

type variables

public:
string TableSchema
string TableName
string ColumnName
int ColumnID
string DataType
string StringValue
string StringDescription

end variables

on fxedictionarycolumnvalue.create
call super::create
end on

on fxedictionarycolumnvalue.destroy
call super::destroy
end on

