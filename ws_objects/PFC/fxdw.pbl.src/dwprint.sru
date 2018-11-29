$PBExportHeader$dwprint.sru
forward
global type dwprint from dwsyntax
end type
end forward

global type dwprint from dwsyntax
string prefix = "print."
end type

type variables

string PrinterName=""
string DocumentName=""
int Orientation=0
dwprintmargin DWPrintMargin
dwprintpaper DWPrintPaper
boolean CanUseDefaultPrinter=true
boolean Prompt=false
boolean Buttons=false
dwprintpreview DWPrintPreview
boolean ClipText=false
boolean OverridePrintJob=false
boolean Collate=false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "PrinterName=" + DQ(PrinterName) + SP + &
	Prefix + "DocumentName=" + DQ(DocumentName) + SP + &
	Prefix + "Orientation=" + S(Orientation) + SP + &
	DWPrintMargin.GetSyntax() + SP + &
	DWPrintPaper.GetSyntax() + SP + &
	Prefix + "CanUseDefaultPrinter=" + YN(CanUseDefaultPrinter) + SP + &
	Prefix + "Prompt=" + YN(Prompt) + SP + &
	Prefix + "Buttons=" + YN(Buttons) + SP + &
	DWPrintPreview.GetSyntax() + SP + &
	Prefix + "ClipText=" + YN(ClipText) + SP + &
	Prefix + "OverridePrintJob=" + YN(OverridePrintJob) + SP + &
	Prefix + "Collate=" + YN(Collate) + SP + &
	""

end function

on dwprint.create
call super::create
end on

on dwprint.destroy
call super::destroy
end on

