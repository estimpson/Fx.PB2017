$PBExportHeader$u_base_custom.sru
forward
global type u_base_custom from UserObject
end type
end forward

global type u_base_custom from UserObject
int Width=1998
int Height=1209
boolean Border=true
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
end type
global u_base_custom u_base_custom

type variables
Protected:
Window	i_w_parent, &
	i_w_mdi_frame

BOOLEAN	i_b_parent, &
		i_b_mdi_frame

GraphicObject	i_go_parent [ ]
end variables

on u_base_custom.create
end on

on u_base_custom.destroy
end on

event constructor;INTEGER	l_i_count = 1

i_go_parent [ l_i_count ] = GetParent ( )
Do While TypeOf ( i_go_parent [ l_i_count ] ) <> Window!
	l_i_count ++
	i_go_parent [ l_i_count ] = i_go_parent [ l_i_count - 1 ].GetParent ( )
Loop
i_w_parent = i_go_parent [ l_i_count ]
IF IsValid ( i_w_parent ) THEN
	i_b_parent = TRUE
	i_w_mdi_frame = i_w_parent.ParentWindow ( )
	IF IsValid ( i_w_mdi_frame ) THEN
		i_b_mdi_frame = TRUE
	END IF
END IF
end event

