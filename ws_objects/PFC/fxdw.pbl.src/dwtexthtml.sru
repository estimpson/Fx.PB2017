$PBExportHeader$dwtexthtml.sru
forward
global type dwtexthtml from dwsyntax
end type
end forward

global type dwtexthtml from dwsyntax
string prefix = "html."
end type

type variables

int ValueIsHtml=0

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return Prefix + "ValueIsHtml=" + DQ(ValueIsHtml)

end function

on dwtexthtml.create
call super::create
end on

on dwtexthtml.destroy
call super::destroy
end on

