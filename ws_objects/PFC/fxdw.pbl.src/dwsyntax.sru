$PBExportHeader$dwsyntax.sru
forward
global type dwsyntax from n_base
end type
end forward

global type dwsyntax from n_base autoinstantiate
end type

type variables

string Prefix=""
constant string EmptyString=""
constant string SP=" "
constant string CR="~r~n"
constant string TAB="~t"

dwtextalignment dwTextAlignment
dwborder dwBorder

end variables

forward prototypes
public function string getsyntax ()
public function string YN (boolean value)
public function string dq (string value)
public function string sq (string value)
public function string s (any value)
public function string dq (integer value)
public function string dq (long value)
public function string dq (boolean value)
public function string sq (integer value)
public function string sq (long value)
public function string sq (boolean value)
end prototypes

public function string getsyntax ();
return ""

end function

public function string YN (boolean value);
if	IsNull (value) then
	return EmptyString
end if

if	value then
	return "yes"
else
	return "no"
end if

end function

public function string dq (string value);
if	IsNull(value) then
	return EmptyString
end if

return	"~"" + value + "~""

end function

public function string sq (string value);
if	IsNull(value) then
	return EmptyString
end if

return	"~'" + value + "~'"

end function

public function string s (any value);
if	IsNull(value) then
	return EmptyString
end if

return	String(value)

end function

public function string dq (integer value);
if	IsNull(value) then
	return EmptyString
end if

return	DQ(String(value))

end function

public function string dq (long value);
if	IsNull(value) then
	return EmptyString
end if

return	DQ(String(value))

end function

public function string dq (boolean value);
if	IsNull(value) then
	return EmptyString
end if

return	DQ(YN(value))

end function

public function string sq (integer value);
if	IsNull(value) then
	return EmptyString
end if

return	SQ(String(value))

end function

public function string sq (long value);
if	IsNull(value) then
	return EmptyString
end if

return	SQ(String(value))

end function

public function string sq (boolean value);
if	IsNull(value) then
	return EmptyString
end if

return	SQ(YN(value))

end function

on dwsyntax.create
call super::create
end on

on dwsyntax.destroy
call super::destroy
end on

