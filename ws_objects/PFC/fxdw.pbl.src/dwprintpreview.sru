$PBExportHeader$dwprintpreview.sru
forward
global type dwprintpreview from dwsyntax
end type
end forward

global type dwprintpreview from dwsyntax
string prefix="print.preview."
end type

type variables

boolean buttons=false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return Prefix + "buttons=" + YN(buttons)


end function

on dwprintpreview.create
call super::create
end on

on dwprintpreview.destroy
call super::destroy
end on

