$PBExportHeader$fxtree.sru
forward
global type fxtree from n_base
end type
type fxtreestruct from structure within fxtree
end type
type fxnode from structure within fxtree
end type
end forward

type fxtreestruct from structure
	long		Node
	long		PNode
	long		Sequence
end type

type fxnode from structure
	string		Code
	string		DisplayString
end type

global type fxtree from n_base
end type
global fxtree fxtree

type variables

Private:
FXNode FXNodes[]
FXTreeStruct FXTreeStruct[]

end variables

forward prototypes
public function integer sourcenodes (ref powerobject source, string codefield, string displayfield)
end prototypes

public function integer sourcenodes (ref powerobject source, string codefield, string displayfield);
//	Read codes and display values.
string codes[]
string descriptions[]

//		Only datawindow types are valid sources.
choose case source.TypeOf()
	case datawindow!, datawindowchild!, datastore!
		int row, rows
		rows = source.dynamic rowcount()
		for	row = 1 to rows
			codes[row] = source.dynamic GetItemString(row, codeField)
			descriptions[row] = source.dynamic GetItemString(row, displayField)
		next
	case else
		return FAILURE
end choose

return SUCCESS

end function

on fxtree.create
call super::create
end on

on fxtree.destroy
call super::destroy
end on

