$PBExportHeader$dwprintpaper.sru
forward
global type dwprintpaper from dwsyntax
end type
end forward

global type dwprintpaper from dwsyntax
string prefix="print.paper."
end type

type variables

int Source=0
int Size=0

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return Prefix + "source=" + S(Source) + SP + Prefix + "size=" + S(Size)

end function

on dwprintpaper.create
call super::create
end on

on dwprintpaper.destroy
call super::destroy
end on

