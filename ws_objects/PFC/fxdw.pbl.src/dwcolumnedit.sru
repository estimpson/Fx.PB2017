$PBExportHeader$dwcolumnedit.sru
forward
global type dwcolumnedit from dwsyntax
end type
end forward

global type dwcolumnedit from dwsyntax
string prefix = "edit."
end type

type variables

//	Settings for standard edit style.
constant int EDIT = 0
int Limit=100
string CCase="any"
boolean FocusRectangle=false
boolean AutoCelect=true
boolean AutoHScroll=true
boolean DisplayOnly=false
boolean NilIsNull=false

//	Settings for edit mask style.
constant int EDITMASK = 1

//	Settings for drop down datawindow style.
constant int DROPDOWNDW = 2
dwColumnEditDDDW EditDDDW

//	Settings for drop down list style.
constant int DROPDOWNLIST = 3
dwColumnEditDDLB EditDDLB

//	Settings for checkbox style.
constant int CHECKBOX = 4
dwColumnEditCheckBox EditCheckBox

//	Settings for radiobutton style.
constant int RADIOBUTTON = 5

int EditStyle = EDIT

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
choose case EditStyle
	case DROPDOWNLIST
		return EditDDLB.GetSyntax()
	case CHECKBOX
		return EditCheckBox.GetSyntax()
	case DROPDOWNDW
		return EditDDDW.GetSyntax()
	case else
		return &
			Prefix + "limit=" + S(Limit) + SP + &
			Prefix + "case=" + CCase + SP + &
			Prefix + "focusrectangle=" + YN(FocusRectangle) + SP + &
			Prefix + "autoselect=" + YN(AutoCelect) + SP + &
			Prefix + "nilisnull=" + YN(NilIsNull) + SP + &
			Prefix + "autohscroll=" + YN(AutoHScroll) + SP + &
			Prefix + "displayonly=" + YN(DisplayOnly) + SP + &
			""
end choose

end function

on dwcolumnedit.create
call super::create
end on

on dwcolumnedit.destroy
call super::destroy
end on

