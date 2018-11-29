$PBExportHeader$dwheader.sru
forward
global type dwheader from dwsyntax
end type
end forward

global type dwheader from dwsyntax
end type

type variables

int Height=72
long Color=536870912

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"header(" + &
	Prefix + "Height=" + S(Height) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	")"

end function

on dwheader.create
call super::create
end on

on dwheader.destroy
call super::destroy
end on

