$PBExportHeader$dwprintmargin.sru
forward
global type dwprintmargin from dwsyntax
end type
end forward

global type dwprintmargin from dwsyntax
string prefix="print.margin."
end type

type variables

int Left=110
int Right=110
int Top=96
int Bottom=96

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return Prefix + "left=" + S(Left) + SP + Prefix + "right=" + S(Right) + SP + Prefix + "top=" + S(Top) + SP + Prefix + "bottom=" + S(Bottom)

end function

on dwprintmargin.create
call super::create
end on

on dwprintmargin.destroy
call super::destroy
end on

