$PBExportHeader$dwcolumneditcheckbox.sru
forward
global type dwcolumneditcheckbox from dwsyntax
end type
end forward

global type dwcolumneditcheckbox from dwsyntax
string prefix = "checkbox."
end type

type variables

//	Settings for checkbox style.
string Text = ""
string OnValue = ""
string OffValue = ""
string OtherValue = ""
boolean LeftText = false
boolean Scale = false
boolean ThreeD = false

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
return &
	Prefix + "text=" + DQ(Text) + SP + &
	Prefix + "on=" + DQ(OnValue)+ SP + &
	Prefix + "off=" + DQ(OffValue)+ SP + &
	IsNull(NullIf(Prefix + "other=" + DQ(OtherValue)+ SP, Prefix + "other=" + DQ("")+ SP), '') + &
	Prefix + "lefttext=" + YN(LeftText) + SP + &
	Prefix + "scale=" + YN(Scale) + SP + &
	Prefix + "threed=" + YN(ThreeD) + SP + &
	""

end function

on dwcolumneditcheckbox.create
call super::create
end on

on dwcolumneditcheckbox.destroy
call super::destroy
end on

