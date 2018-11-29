$PBExportHeader$dwcompute.sru
forward
global type dwcompute from dwsyntax
end type
end forward

global type dwcompute from dwsyntax
end type

type variables

string Band="header"  //refactor
int Alignment=2 //refactor
string Expression=""
int Border=6 //refactor
long Color=33554432 //refactor
int X=9
int Y=8
int Height=56
int Width=311
string Format="[GENERAL]"
dwtexthtml DWTextHtml
string Name="compute_1"
int Visible=1
dwtextfont DWTextFont
dwtextbackground DWTextBackground

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"Compute(" + &
	Prefix + "Band=" + Band + SP + &
	Prefix + "Alignment=" + DQ(Alignment) + SP + &
	Prefix + "Expression=" + DQ(Expression) + SP + &
	Prefix + "Border=" + DQ(Border) + SP + &
	Prefix + "Color=" + DQ(Color) + SP + &
	Prefix + "X=" + DQ(X) + SP + &
	Prefix + "Y=" + DQ(Y) + SP + &
	Prefix + "Height=" + DQ(Height) + SP + &
	Prefix + "Width=" + DQ(Width) + SP + &
	Prefix + "Format=" + DQ(Format) + SP + &
	DWTextHtml.GetSyntax() + SP + &
	Prefix + "Name=" + Name + SP + &
	Prefix + "Visible=" + DQ(Visible) + SP + &
	DWTextFont.GetSyntax() + SP + &
	DWTextBackground.GetSyntax() + SP + &
	")"

end function

on dwcompute.create
call super::create
end on

on dwcompute.destroy
call super::destroy
end on

