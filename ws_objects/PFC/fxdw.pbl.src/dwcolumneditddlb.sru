$PBExportHeader$dwcolumneditddlb.sru
forward
global type dwcolumneditddlb from dwsyntax
end type
end forward

global type dwcolumneditddlb from dwsyntax
string prefix = "ddlb."
end type

type variables

//	Settings for drop down list style.
int Limit = 0
boolean Sorted = false
boolean AllowEdit = true
string TextCase = "Any"
boolean Required = false
boolean NilIsNull = true
boolean AutoHScroll = false
boolean VScrollBar = false
boolean ShowList = false
boolean UseAsBorder = false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "limit=" + S(Limit) + SP + &
	Prefix + "sorted=" + YN(Sorted) + SP + &
	Prefix + "allowedit=" + YN(AllowEdit) + SP + &
	Prefix + "case=" + S(textCase) + SP + &
	Prefix + "required=" + YN(Required) + SP + &
	Prefix + "nilisnull=" + YN(NilIsNull) + SP + &
	Prefix + "autohscroll=" + YN(AutoHScroll) + SP + &
	Prefix + "vscrollbar=" + YN(VScrollBar) + SP + &
	Prefix + "showlist=" + YN(ShowList) + SP + &
	Prefix + "useasborder=" + YN(UseAsBorder) + SP + &
	""

end function

on dwcolumneditddlb.create
call super::create
end on

on dwcolumneditddlb.destroy
call super::destroy
end on

