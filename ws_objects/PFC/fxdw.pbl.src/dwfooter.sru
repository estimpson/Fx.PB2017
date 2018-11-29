$PBExportHeader$dwfooter.sru
forward
global type dwfooter from dwsyntax
end type
end forward

global type dwfooter from dwsyntax
end type

type variables

int Height=0
long Color=536870912

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"footer(" + &
	Prefix + "Height=" + S(Height) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	")"

end function

on dwfooter.create
call super::create
end on

on dwfooter.destroy
call super::destroy
end on

