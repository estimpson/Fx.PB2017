$PBExportHeader$dwdatawindow.sru
forward
global type dwdatawindow from dwsyntax
end type
end forward

global type dwdatawindow from dwsyntax
end type

type variables

int Units=0
int Timer_interval=0
long Color=1073741824
int Processing=1
boolean HTMLDW=false
boolean HideGrayLine=false

dwprint DWPrint

int GridLines=0

boolean SelectedMouse=false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	"datawindow(" + &
	Prefix + "Units=" + S(Units) + SP + &
	Prefix + "Timer_interval=" + S(Timer_interval) + SP + &
	Prefix + "Color=" + S(Color) + SP + &
	Prefix + "Processing=" + S(Processing) + SP + &
	Prefix + "HTMLDW=" + YN(HTMLDW) + SP + &
	Prefix + "HideGrayLine=" + YN(HideGrayLine) + SP + &
	DWPrint.GetSyntax() + SP + &
	Prefix + "Grid.Lines=" + S(Color) + SP + &
	Prefix + "Selected.Mouse=" + YN(SelectedMouse) + SP + &
	")"

end function

on dwdatawindow.create
call super::create
end on

on dwdatawindow.destroy
call super::destroy
end on

