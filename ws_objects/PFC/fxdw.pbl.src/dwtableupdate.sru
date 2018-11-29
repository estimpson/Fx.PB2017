$PBExportHeader$dwtableupdate.sru
forward
global type dwtableupdate from dwsyntax
end type
end forward

global type dwtableupdate from dwsyntax
end type

type variables

string UpdateTable=""
int UpdateWhere=0 //Refactor 0 Key only, 1 Key updateable,  2 Key modified
boolean UpdateKeyInPlace=false //Refactor true Use Delete/Insert, false Use Update

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
if	len(UpdateTable) > 0 then
	return  &
		"Update=" + DQ(UpdateTable) + SP +&
		"UpdateWhere=" + S(UpdateWhere) + SP +&
		"UpdateKeyInPlace=" + YN(UpdateKeyInPlace) + SP
else
	return ""
end if

end function

on dwtableupdate.create
call super::create
end on

on dwtableupdate.destroy
call super::destroy
end on

