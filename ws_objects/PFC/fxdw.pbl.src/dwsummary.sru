$PBExportHeader$dwsummary.sru
forward
global type dwsummary from dwsyntax
end type
end forward

global type dwsummary from dwsyntax
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
	"summary(" + &
	Prefix + "Height=" + S(Height) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	")"

end function

on dwsummary.create
call super::create
end on

on dwsummary.destroy
call super::destroy
end on

