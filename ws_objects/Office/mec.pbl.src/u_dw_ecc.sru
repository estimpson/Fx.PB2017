$PBExportHeader$u_dw_ecc.sru
$PBExportComments$(New)~r~nDataWindow used for ECC data entry.
forward
global type u_dw_ecc from u_dw_sp_base
end type
end forward

global type u_dw_ecc from u_dw_sp_base
int Width=1947
int Height=1348
string DataObject="d_ecc_entry"
boolean VScrollBar=true
end type
global u_dw_ecc u_dw_ecc

type variables
LONG	i_l_modified_row

STRING	i_s_part
end variables

forward prototypes
public function integer update ()
public function long retrieve (string a_s_part)
public function integer deleterow (long a_l_row)
end prototypes

public function integer update ();CHAR	l_c_isrow

DATETIME l_dt_effective_date

INTEGER	l_i_rvalue

STRING	l_s_engineering_level, &
	l_s_notes, &
	ls_operator

IF i_l_modified_row > 0 THEN
	AcceptText ( )
	l_dt_effective_date = object.effective_date [ i_l_modified_row ]
	l_s_engineering_level = object.engineering_level [ i_l_modified_row ]
	l_s_notes = object.notes [ i_l_modified_row ]
	l_c_isrow =object.isrow [ i_l_modified_row ]
	i_l_modified_row = 0

	if isnull(szoperator,'') = '' then 
		select	min(operator_code)
		into	:ls_operator
		from	employee;
	else
		ls_operator = szoperator
	end if 
	
	if isnull(ls_operator,'')='' then ls_operator = 'Mon'
	
	IF l_c_isrow = '*' THEN
		//Modify old row
		l_i_rvalue = SQLCA.uf_modify_ecc ( i_s_part, l_dt_effective_date, ls_operator, l_s_notes, l_s_engineering_level )
	ELSE
		//Insert new row
		l_i_rvalue = SQLCA.uf_add_ecc ( i_s_part, l_dt_effective_date, ls_operator, l_s_notes, l_s_engineering_level )
	END IF
	
	IF l_i_rvalue = 0 THEN
		SQLCA.uf_commit ( )
		l_i_rvalue = 1
	END IF
	
	Retrieve ( i_s_part )
	
	Return l_i_rvalue
END IF
MessageBox ( "","" )
Return -1
end function

public function long retrieve (string a_s_part);i_s_part = a_s_part

Return SUPER::Retrieve ( i_s_part )
end function

public function integer deleterow (long a_l_row);CHAR		l_c_isrow

DATETIME	l_dt_effective_date

INTEGER	l_i_rvalue

STRING	l_s_engineering_level, &
			l_s_notes

IF a_l_row > 0 THEN
	l_dt_effective_date = object.effective_date [ a_l_row ]
	l_s_engineering_level = object.engineering_level [ a_l_row ]
	l_s_notes = object.notes [ a_l_row ]
	l_c_isrow =object.isrow [ a_l_row ]
	
	IF l_c_isrow = '*' THEN
		//Modify old row
		l_i_rvalue = SQLCA.uf_remove_ecc ( i_s_part, l_dt_effective_date, 'EES', l_s_notes, l_s_engineering_level )
	END IF
	
	IF l_i_rvalue = 0 THEN
		SQLCA.uf_commit ( )
		l_i_rvalue = 1
	END IF
	
	Retrieve ( i_s_part )
	
	Return l_i_rvalue
END IF
MessageBox ( "","" )
Return -1
end function

event retrieveend;call super::retrieveend;i_l_modified_row = 0
end event

event rowfocuschanged;IF currentrow > 0 THEN
	IF i_l_modified_row > 0 THEN
		IF ( MessageBox ( monsys.msg_title, "Save changes?", none!, YesNo! ) = 1 ) THEN
			Update ( )
		ELSE
			Retrieve ( i_s_part )
		END IF
	END IF
END IF
end event

event constructor;SetTransObject ( SQLCA )
end event

event editchanged;i_l_modified_row = row
end event

event clicked;SelectRow ( 0, FALSE )
IF IsValid ( dwo ) THEN
	IF Lower ( dwo.type ) = "column" THEN
		IF row > 0 AND dwo.ID = "1" THEN SelectRow ( row, TRUE )
	END IF
END IF
end event

