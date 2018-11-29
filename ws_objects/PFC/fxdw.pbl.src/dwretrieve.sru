$PBExportHeader$dwretrieve.sru
forward
global type dwretrieve from dwsyntax
end type
end forward

global type dwretrieve from dwsyntax
end type

type variables

string RetrieveSyntax = ""

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
if	len(RetrieveSyntax) > 0 then
	return &
		"retrieve=" + &
		DQ(RetrieveSyntax) + SP
else
	return ""
end if
end function

on dwretrieve.create
call super::create
end on

on dwretrieve.destroy
call super::destroy
end on

