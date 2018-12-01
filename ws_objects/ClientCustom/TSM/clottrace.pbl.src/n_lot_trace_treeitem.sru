$PBExportHeader$n_lot_trace_treeitem.sru
forward
global type n_lot_trace_treeitem from n_base
end type
end forward

global type n_lot_trace_treeitem from n_base
end type
global n_lot_trace_treeitem n_lot_trace_treeitem

type variables

long Serial
decimal Quantity
datetime TranDT
string	TreeItemID, Part, LinkType, Chain
boolean HasChildren

n_lot_trace_treeitem _childtreeItems[]

end variables
forward prototypes
public function integer reset ()
end prototypes

public function integer reset ();
int i, count
count = UpperBound(_childtreeItems)
for	i = 1 to count
	_childTreeItems[i].Reset()
	destroy _childTreeItems[i]
next

return SUCCESS

end function

on n_lot_trace_treeitem.create
call super::create
end on

on n_lot_trace_treeitem.destroy
call super::destroy
end on

