$PBExportHeader$dwdetail.sru
forward
global type dwdetail from dwsyntax
end type
end forward

global type dwdetail from dwsyntax
end type

type variables

int Height=92
string Color="536870912"

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"detail(" + &
	Prefix + "Height=" + S(Height) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	")"

end function

on dwdetail.create
call super::create
end on

on dwdetail.destroy
call super::destroy
end on

