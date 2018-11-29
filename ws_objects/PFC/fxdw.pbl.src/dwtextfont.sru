$PBExportHeader$dwtextfont.sru
forward
global type dwtextfont from dwsyntax
end type
end forward

global type dwtextfont from dwsyntax
string prefix = "font."
end type

type variables

string Face="MS Sans Serif" //refactor
int Height=-8 //refactor
int Weight=400 //refactor
int Family=2 //refactor
int Pitch=2 //refactor
int CharSet=0 //refactor

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "Face=" + DQ(Face) + SP + &
	Prefix + "Height=" + DQ(Height) + SP + &
	Prefix + "Weight=" + DQ(Weight) + SP + &
	Prefix + "Family=" + DQ(Family) + SP + &
	Prefix + "Pitch=" + DQ(Pitch) + SP + &
	Prefix + "CharSet=" + DQ(CharSet) + SP + &
	""

end function

on dwtextfont.create
call super::create
end on

on dwtextfont.destroy
call super::destroy
end on

