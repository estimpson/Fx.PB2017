$PBExportHeader$u_dw_compiled.sru
forward
global type u_dw_compiled from u_base_dw
end type
end forward

global type u_dw_compiled from u_base_dw
end type
global u_dw_compiled u_dw_compiled

type variables
Protected:
STRING	i_s_object_name, &
	i_s_library_name

st_generic_structure	i_st_parm
end variables

event constructor;call super::constructor;SetTransObject ( SQLCA )
end event

