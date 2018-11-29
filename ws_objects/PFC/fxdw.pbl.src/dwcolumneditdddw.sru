$PBExportHeader$dwcolumneditdddw.sru
forward
global type dwcolumneditdddw from dwsyntax
end type
end forward

global type dwcolumneditdddw from dwsyntax
string prefix = "dddw."
end type

type variables

//	Settings for drop down list style.
string Name
string DisplayColumn
string DataColumn
int PercentWidth = 0
int Lines = 0
int Limit = 0
boolean AllowEdit = true
boolean UseAsBorder = false
string TextCase = "Any"
boolean NilIsNull = false
boolean Required = false
boolean AutoHScroll = true
boolean HScrollBar = true
boolean VScrollBar = true
boolean ShowList = false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "name=" + S(Name) + SP + &
	Prefix + "displaycolumn=" + S(DisplayColumn) + SP + &
	Prefix + "datacolumn=" + S(DataColumn) + SP + &
	Prefix + "percentwidth=" + S(PercentWidth) + SP + &
	Prefix + "lines=" + S(Lines) + SP + &
	Prefix + "limit=" + S(Limit) + SP + &
	Prefix + "allowedit=" + YN(AllowEdit) + SP + &
	Prefix + "useasborder=" + YN(UseAsBorder) + SP + &
	Prefix + "case=" + S(textCase) + SP + &
	Prefix + "nilisnull=" + YN(NilIsNull) + SP + &
	Prefix + "required=" + YN(Required) + SP + &
	Prefix + "autohscroll=" + YN(AutoHScroll) + SP + &
	Prefix + "hscrollbar=" + YN(HScrollBar) + SP + &
	Prefix + "vscrollbar=" + YN(VScrollBar) + SP + &
	Prefix + "showlist=" + YN(ShowList) + SP + &
	""

end function

on dwcolumneditdddw.create
call super::create
end on

on dwcolumneditdddw.destroy
call super::destroy
end on

