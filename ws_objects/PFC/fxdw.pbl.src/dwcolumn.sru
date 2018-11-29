$PBExportHeader$dwcolumn.sru
forward
global type dwcolumn from dwsyntax
end type
end forward

global type dwcolumn from dwsyntax
end type

type variables

string Band="header"  //refactor
int ID = 1
int Alignment=2 //refactor
int TabSequence=32766
string Text=""
int Border=0 //refactor
long Color=33554432 //refactor
int X=9
int Y=8
int Height=56
int Width=311
string Format="[general]" 
dwtexthtml DWTextHtml
string ProtectExp=""
string Name=""
string Tag
int Visible=1
dwcolumnedit DWColumnEdit
dwtextfont DWTextFont
dwtextbackground DWTextBackground

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"column(" + &
	Prefix + "band=" + Band + SP + &
	Prefix + "id=" + S(ID) + SP + &
	Prefix + "alignment=" + DQ(Alignment) + SP + &
	Prefix + "tabsequence=" + S(TabSequence) + SP + &
	Prefix + "border=" + DQ(Border) + SP + &
	Prefix + "color=" + DQ(Color) + SP + &
	Prefix + "x=" + DQ(X) + SP + &
	Prefix + "y=" + DQ(Y) + SP + &
	Prefix + "height=" + DQ(Height) + SP + &
	Prefix + "width=" + DQ(Width) + SP + &
	Prefix + "format=" + DQ(Format) + SP + &
	DWTextHtml.GetSyntax() + SP + &
	Prefix + "protect=" + DQ(ProtectExp) + SP + &
	Prefix + "name=" + Name + SP + &
	Prefix + "tag=" + DQ(Tag) + SP + &
	Prefix + "visible=" + DQ(Visible) + SP + &
	DWColumnEdit.GetSyntax() + SP + &
	DWTextFont.GetSyntax() + SP + &
	DWTextBackground.GetSyntax() + SP + &
	")"

end function

on dwcolumn.create
call super::create
end on

on dwcolumn.destroy
call super::destroy
end on

