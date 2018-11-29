$PBExportHeader$dwtable.sru
forward
global type dwtable from dwsyntax
end type
end forward

global type dwtable from dwsyntax
end type

type variables

dwtablecolumn DWTableColumns[]
dwretrieve DWRetrieve
dwprocedure DWProcedure
dwtableupdate DWTableUpdate
dwtablearguments DWTableArguments

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
string	ColumnSyntax = ""
int i
for	i = 1 to UpperBound(DWTableColumns)
	ColumnSyntax += DWTableColumns[i].GetSyntax() + CR
next

return &
	"table(" + &
	ColumnSyntax + &
	DWRetrieve.GetSyntax() + &
	DWProcedure.GetSyntax() + &
	DWTableUpdate.GetSyntax() + &
	DWTableArguments.GetSyntax() + &
	")"

end function

on dwtable.create
call super::create
end on

on dwtable.destroy
call super::destroy
end on

