$PBExportHeader$dwtablearguments.sru
forward
global type dwtablearguments from dwsyntax
end type
type argument from structure within dwtablearguments
end type
end forward

type argument from structure
	string		name
	string		atype
end type

global type dwtablearguments from dwsyntax
end type

type variables

private argument Arguments[]

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
string	ArgumentSyntax = ""
int i
for	i = 1 to UpperBound(Arguments)
	ArgumentSyntax += "(" + DQ(Arguments[i].Name) + "," + Arguments[i].aType + ")" + ","
next

if	Len(ArgumentSyntax) > 0 then
	return &
		"arguments=(" + ArgumentSyntax + ")"
else
	return ""
end if

end function

on dwtablearguments.create
call super::create
end on

on dwtablearguments.destroy
call super::destroy
end on

