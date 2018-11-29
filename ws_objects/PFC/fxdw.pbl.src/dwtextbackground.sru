$PBExportHeader$dwtextbackground.sru
forward
global type dwtextbackground from dwsyntax
end type
end forward

global type dwtextbackground from dwsyntax
string prefix = "background."
end type

type variables

string Mode="1" //refactor
string Color="536870912" //refactor

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "Mode=" + DQ(Mode) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	""

end function

on dwtextbackground.create
call super::create
end on

on dwtextbackground.destroy
call super::destroy
end on

