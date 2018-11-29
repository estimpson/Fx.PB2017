$PBExportHeader$dwtablecolumn.sru
forward
global type dwtablecolumn from dwsyntax
end type
end forward

global type dwtablecolumn from dwsyntax
end type

type variables

string cType="long"
boolean Updateable=false
boolean UpdateWhereClause=false
boolean Key=false
boolean Identity=false
string Name=""
string DBName=""
string Initial=""
string Validation=""
boolean CriteriaDialog=false
string Values=""

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"column=(" + &
	Prefix + "Type=" + cType + SP + &
	Prefix + "Update=" + YN(Updateable) + SP +&
	Prefix + "UpdateWhereClause=" + YN(UpdateWhereClause) + SP + &
	Prefix + "Key=" + YN(Key) + SP +&
	Prefix + "Identity=" + YN(Identity) + SP +&
	Prefix + "Name=" + Name + SP + &
	Prefix + "DBName=" + DQ(DBName) + SP + &
	Prefix + "Initial=" + DQ(Initial) + SP + &
	IsNull(NullIf(Prefix + "Validation=" + DQ(Validation) + SP, Prefix + "Validation=" + DQ("") + SP), "") +&
	Prefix + "Criteria.Dialog=" + YN(CriteriaDialog) + SP +&
	Prefix + "Values=" + DQ(Values) + SP +&
	")"

end function

on dwtablecolumn.create
call super::create
end on

on dwtablecolumn.destroy
call super::destroy
end on

