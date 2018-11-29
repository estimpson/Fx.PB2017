$PBExportHeader$dwprocedure.sru
forward
global type dwprocedure from dwsyntax
end type
end forward

global type dwprocedure from dwsyntax
end type

type variables

string ProcedureSyntax = ""

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
if	len(ProcedureSyntax) > 0 then
	return &
		"procedure=" + &
		DQ(ProcedureSyntax) + SP
else
	return ""
end if
end function

on dwprocedure.create
call super::create
end on

on dwprocedure.destroy
call super::destroy
end on

